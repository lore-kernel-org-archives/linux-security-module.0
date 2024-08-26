Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B1155C87;
	Mon, 26 Aug 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669414; cv=none; b=KaHQqIUxBkA+wSEtxnReVcH5pQgznxEaGFnVWBAWKGQvDO1HRuqlBxKzsRP3kdj48rMVOABgm6YoYmAF1bg1JO7dScDwI/OCcCM/VfrbSVDxg4CbBG9Jj8rac3nWJyNA5bdW0JQNiNN2BjF4XOUPw5sM+2qty5nJ6F+V2BqhMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669414; c=relaxed/simple;
	bh=g9whlb+2ufFaVEpQMZxnUUuaozKwg0yP2/yN1qqfTDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+CXPYJ5Xpk92P9xJb4YbjiwZCcRwP3r5nL4bUSt6qYDGDR5WH78iXEmDr7rgPf1mnKxOwgGeuji31j1LyxeIAYU8YenWwHTLaJ7Cvd7/KhHHRe321+rrApfLq38EQwc7Qj/8kUys3Na8xoozh6G19iw+RkmawuaN0UK7k5BZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbWqB003453;
	Mon, 26 Aug 2024 05:37:32 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbW2c003452;
	Mon, 26 Aug 2024 05:37:32 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 13/14] Implement infrastructure for loadable security models.
Date: Mon, 26 Aug 2024 05:37:27 -0500
Message-Id: <20240826103728.3378-14-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240826103728.3378-1-greg@enjellic.com>
References: <20240826103728.3378-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default deterministic security model can be replaced through
the use of models that are implemented with kernel loadable
modules.  Kernel loadable modules can be used to replace the
following components of the TSEM modeling infrastructure:

- event bypasses

- event initialization

- event mapping

An alternate security model is specified for a security modeling
namespace by using the following key/value pair as an argument to
the creation of the security modeling namespace:

model=MODEL_NAME

Where MODEL_NAME is the name of the model compiled into the
kernel loadable model that implements the model.

Befor any model can be used it must be registered through the
infrastructure supplied by this commit, namely the nsmgr.c file.

Addition or removal of modules can be locked, either through the
TSEM control plame or by the 'tsem_locked' kernel command-line
parameter.  Locking of the registation process is an irreversible
process, once locked the registration/removal process will be
locked until the system is rebooted.
---
 security/tsem/nsmgr.c | 255 ++++++++++++++++++++++++++++++++++++++++++
 security/tsem/nsmgr.h |  48 ++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 security/tsem/nsmgr.c
 create mode 100644 security/tsem/nsmgr.h

diff --git a/security/tsem/nsmgr.c b/security/tsem/nsmgr.c
new file mode 100644
index 000000000000..0b34c18feb01
--- /dev/null
+++ b/security/tsem/nsmgr.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file contains infrastructure for managing the security models
+ * for TSEM that are implemented by kernel loadable modules. Any model
+ * provided by a kernel loadable module must be registered before it
+ * can be specified for a security modeling namespace.
+ *
+ * The registration of additional models, or the removal of existing
+ * models, can be prevented by 'locking' the registration process.
+ * This locking can be implemented either through the TSEM control
+ * plane or by specifying the 'tsem_locked' kernel command-line
+ * parameter.
+ */
+
+#include "tsem.h"
+#include "nsmgr.h"
+
+static bool locked;
+static bool setup_locked __ro_after_init;
+
+struct model {
+	struct list_head list;
+	const struct tsem_context_ops *ops;
+	struct module *module;
+};
+
+DEFINE_MUTEX(model_list_mutex);
+LIST_HEAD(model_list);
+
+
+static struct model *find_model(const char *name)
+{
+	struct model *found = NULL, *entry = NULL;
+
+	list_for_each_entry(entry, &model_list, list) {
+		if (!strcmp(entry->ops->name, name)) {
+			found = entry;
+			break;
+		}
+	}
+	return found;
+}
+
+/**
+ * tsem_nsmgr_put() - Release a reference to a TSEM security model.
+ *
+ * @ops: A pointer to the tsem_context_ops structure that defines
+ *	 this model.
+ *
+ * This function is the counter part to tsem_nsmgr_get() function.
+ * A check is made to determine if a module is supplying this model and
+ * if so the reference that was taken to the module when the security
+ * namespace is created is released.
+ */
+void tsem_nsmgr_put(const struct tsem_context_ops *ops)
+{
+	struct model *model;
+
+	if (!strcmp(tsem_model0_ops.name, ops->name))
+		return;
+
+	mutex_lock(&model_list_mutex);
+	model = find_model(ops->name);
+	if (!model) {
+		pr_warn("tsem: Attempt to put an unknown model.\n");
+		goto done;
+	}
+	if (model->module)
+		module_put(model->module);
+
+ done:
+	mutex_unlock(&model_list_mutex);
+}
+
+/**
+ * tsem_nsmgr_get() - Obtain a reference to a TSEM security model.
+ *
+ * @name: A null terminated character buffer containing the name of
+ *	  the security model to obtain a reference for.
+ *
+ * This function is used to determine whether or not TSEM has access
+ * to a security model named by the called.  Upon success of locating
+ * the named security model a tsem_context_ops structure is returned
+ * that implements the model.  In addition a reference is taken to
+ * the module in order to prevent its release while a security modeling
+ * namespace is using the model.
+ *
+ * Return: If the named security model is not available a NULL pointer
+ *	   is returned.  If the model is available a pointer to the
+ *	   tsem_context_ops structure that implements the model is
+ *	   returned.
+ */
+const struct tsem_context_ops *tsem_nsmgr_get(const char *name)
+{
+	struct model *model;
+	const struct tsem_context_ops *retn = NULL;
+
+	mutex_lock(&model_list_mutex);
+	model = find_model(name);
+	mutex_unlock(&model_list_mutex);
+
+	if (!model) {
+		if (request_module("%s", name))
+			return NULL;
+
+		mutex_lock(&model_list_mutex);
+		model = find_model(name);
+		mutex_unlock(&model_list_mutex);
+		if (!model)
+			return NULL;
+	}
+
+	if (model && try_module_get(model->module))
+		retn = model->ops;
+	return retn;
+}
+
+/**
+ * tsem_nsmgr_lock() - Lock the TSEM loadable module infrastructure.
+ *
+ * @by_setup: This boolean value is used to signal that the request to
+ *	      lock the model state is being done by the system setup.
+ *
+ * This function disables the registration of additional loadable
+ * modules for model implementation.  It also raises the reference count
+ * for each modules that is loaded to prevent the current modules from
+ * being unloaded.
+ *
+ * Return: This function returns 0 if the modeling infrastructure was
+ *	   locked or a negative value if locking fails.
+ */
+int tsem_nsmgr_lock(const bool by_setup)
+{
+	struct model *entry = NULL;
+
+	if (by_setup) {
+		setup_locked = true;
+		return 0;
+	}
+
+	if (setup_locked)
+		return -EINVAL;
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+	if (tsem_context(current)->id)
+		return -EINVAL;
+	if (locked)
+		return -EINVAL;
+	locked = true;
+
+	mutex_lock(&model_list_mutex);
+	list_for_each_entry(entry, &model_list, list) {
+		__module_get(entry->module);
+	}
+	mutex_unlock(&model_list_mutex);
+
+	pr_info("tsem: Model state is now locked.\n");
+	return 0;
+}
+
+/**
+ * tsem_nsmgr_register() - Register a TSEM security namespace model.
+ * @ops:    A pointer to a tsem_context_ops structure that describes
+ *	    the model that will be implemented.
+ * @module: A pointer to the module implementing the security namespace
+ *	    model.
+ *
+ * This function is used by loadable modules to register a security
+ * model that is to be available for use by security modeling namespaces.
+ *
+ * Return: This function returns 0 if the model was successfully registered
+ *	   or a negative error value if registration failed.
+ */
+int tsem_nsmgr_register(const struct tsem_context_ops *ops,
+			struct module *module)
+{
+	int retn = 0;
+	struct model *model = NULL;
+
+	if (setup_locked || locked) {
+		pr_warn("tsem: Attempt to register model in locked state.\n");
+		return -EINVAL;
+	}
+	if (!capable(CAP_MAC_ADMIN))
+		return -EPERM;
+	if (!strcmp(tsem_model0_ops.name, ops->name))
+		return -EINVAL;
+
+	mutex_lock(&model_list_mutex);
+	if (find_model(ops->name)) {
+		pr_warn("tsem: Attempt to insert identical model: %s\n",
+			ops->name);
+		retn = -EEXIST;
+		goto done;
+	}
+
+	model = kzalloc(sizeof(*model), GFP_KERNEL);
+	if (!model) {
+		retn = -ENOMEM;
+		goto done;
+	}
+
+	model->ops = ops;
+	model->module = module;
+	list_add_tail(&model->list, &model_list);
+	pr_info("tsem: Registered model: '%s'\n", ops->name);
+
+ done:
+	mutex_unlock(&model_list_mutex);
+	return retn;
+}
+EXPORT_SYMBOL_GPL(tsem_nsmgr_register);
+
+/**
+ * tsem_nsmgr_release() - Release a TSEM security namespace model.
+ * @name:   A null terminated character buffer containing the name
+ *	    of the model being implemented.
+ *
+ * This function is used to release the use of security modeling
+ * namespace model.
+ *
+ * Return: This function returns 0 if the model was successfully released
+ *	   or a negative error value if release failed.
+ */
+int tsem_nsmgr_release(const struct tsem_context_ops *ops)
+{
+	int retn = 0;
+	struct model *model;
+
+	if (setup_locked || locked) {
+		pr_warn("tsem: Attempt to release model in locked state.\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&model_list_mutex);
+
+	model = find_model(ops->name);
+	if (!model) {
+		pr_warn("tsem: Model '%s' not found for release.\n",
+			ops->name);
+		retn = -EINVAL;
+		goto done;
+	}
+	list_del(&model->list);
+
+ done:
+	mutex_unlock(&model_list_mutex);
+	pr_info("tsem: Released model: '%s'\n", ops->name);
+	return retn;
+}
+EXPORT_SYMBOL_GPL(tsem_nsmgr_release);
diff --git a/security/tsem/nsmgr.h b/security/tsem/nsmgr.h
new file mode 100644
index 000000000000..cb4d30a4962d
--- /dev/null
+++ b/security/tsem/nsmgr.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This header file contains declarations for globally visible
+ * functionality surrounding the registration of security models
+ * provided in the form of loadable modules.
+ *
+ * This header file detects whether or not kernel modules are enabled
+ * and if not provides a stub function that causes an attempt to
+ * specify an alternate security model to fail.
+ */
+
+#ifdef CONFIG_MODULES
+extern void tsem_nsmgr_put(const struct tsem_context_ops *ops);
+extern const struct tsem_context_ops *tsem_nsmgr_get(const char *name);
+extern int tsem_nsmgr_lock(const bool);
+extern int tsem_nsmgr_register(const struct tsem_context_ops *ops,
+			       struct module *module);
+extern int tsem_nsmgr_release(const struct tsem_context_ops *ops);
+#else
+static inline void tsem_nsmgr_put(const struct tsem_context_ops *ops)
+{
+}
+
+static inline int tsem_nsmgr_lock(const bool by_setup)
+{
+	return EOPNOTSUPP;
+}
+
+static inline const struct tsem_context_ops *tsem_nsmgr_get(const char *name)
+{
+	return NULL;
+}
+
+static inline int tsem_nsmgr_register(const struct tsem_context_ops *ops,
+				      struct module *module)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int tsem_nsmgr_release(const struct tsem_context_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+#endif
-- 
2.39.1


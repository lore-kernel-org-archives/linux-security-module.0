Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B21F55E4
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341299; cv=none; b=cidDnxnDN7Fh/xTu2+PidgRf8nWWR/FZUf/sEhH83KXTBcNYCfO99iKR3mTYhfyDFQI/m6qZOynvhgmy72K2l7OGRIQGuC7nlNtn9qg9yV8HkS+O7WfqduaBT/XhdnNHYj2faOo7OP9HauelOxwsf82Ept7GWHbk48gfACKCeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341299; c=relaxed/simple;
	bh=armgMynyhbaJWif0AxnvKnIExXEE9FpW6K2Fc/eMi3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGC4B3ad37KNv33yQ+QyMRVvaEwYunZA3OC6UWiKlwXaZcWuoOCFFfc0np8o/Zb09KbghwvTbHxDBycqPNzx4zgMfmxRHbSTkNh/dX87xoFpD52PyTkh1zzy6X1BMs+TXDNnHIRAzIkufvbbI+JLvOjoWoYkTZjoGz9ho52L+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oAclw7bY; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oAclw7bY"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1hH0HG6zClW;
	Fri, 31 Jan 2025 17:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341294;
	bh=EoG7lKIcgzOE6DS13t1+RUuwwP5OY6Prk56tBe+01WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAclw7bYFiox7QNFFAULTE6AcnVHfMco7MCqaHPZ+Q+O+B9wGMovQ2WtGkpEQyBr2
	 v4k665iAENAk6n29ul5xAAR1ZQYjUye8/6Ji8Co7PDVbtZF6x/wvmwhBh4/phcOuNp
	 fnMxILrvM7v/N3GLw6lJ655imt4VhsgEct8BhgK0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1hG15xvzZcy;
	Fri, 31 Jan 2025 17:34:54 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Tyler Hicks <code@tyhicks.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 1/3] landlock: Add landlock_read_domain_id()
Date: Fri, 31 Jan 2025 17:34:45 +0100
Message-ID: <20250131163447.1140564-2-mic@digikod.net>
In-Reply-To: <20250131163447.1140564-1-mic@digikod.net>
References: <20250131163447.1140564-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This public landlock_read_domain_id() helper will be used in the next
commit by the PIDFD_GET_INFO IOCTL to read a task's domain ID.

A task is only allowed to get information about its nested domains.

Being able to read tasks' domain IDs is useful for telemetry, debugging,
and tests.  It enables users:
- to know if a task is well sandboxed;
- to know which tasks are part of the same sandbox;
- to map Landlock audit logs to running processes.

Future changes will leverage this feature to improve Landlock
observability.

Landlock domain IDs are now always generated at domain creation time.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Praveen K Paladugu <prapal@linux.microsoft.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163447.1140564-2-mic@digikod.net
---
 include/linux/landlock.h     | 26 +++++++++++++
 security/landlock/Makefile   | 12 ++++--
 security/landlock/domain.c   |  2 -
 security/landlock/domain.h   |  8 ++--
 security/landlock/ruleset.c  |  2 +
 security/landlock/syscalls.c | 75 ++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/landlock.h

diff --git a/include/linux/landlock.h b/include/linux/landlock.h
new file mode 100644
index 000000000000..a091deee9ad7
--- /dev/null
+++ b/include/linux/landlock.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock public helpers
+ *
+ * Copyright © 2025 Microsoft Corporation
+ */
+
+#include <linux/cred.h>
+#include <linux/sched.h>
+
+#ifdef CONFIG_SECURITY_LANDLOCK
+
+int landlock_read_domain_id(const struct cred *const cred,
+			    struct task_struct *const task, const bool last,
+			    u64 *const id);
+
+#else /* CONFIG_SECURITY_LANDLOCK */
+
+static inline int landlock_read_domain_id(const struct cred *const cred,
+					  struct task_struct *const task,
+					  const bool last, u64 *const id)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 3160c2bdac1d..5db653a1717e 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,11 +1,17 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := setup.o syscalls.o object.o ruleset.o \
-	cred.o task.o fs.o
+landlock-y := \
+	setup.o \
+	syscalls.o \
+	object.o \
+	ruleset.o \
+	cred.o \
+	task.o \
+	fs.o \
+	id.o
 
 landlock-$(CONFIG_INET) += net.o
 
 landlock-$(CONFIG_AUDIT) += \
-	id.o \
 	audit.o \
 	domain.o
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 49ccb0f72e53..782cc4ef73e0 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -21,7 +21,6 @@
 #include "common.h"
 #include "domain.h"
 #include "fs.h"
-#include "id.h"
 
 #ifdef CONFIG_AUDIT
 
@@ -125,7 +124,6 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 		return PTR_ERR(details);
 
 	hierarchy->details = details;
-	hierarchy->id = landlock_get_id_range(1);
 	hierarchy->log_status = LANDLOCK_LOG_PENDING;
 	hierarchy->quiet_subdomains = false;
 	hierarchy->log_cross_exec = false;
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 06b213aa7579..3f678caddaff 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -78,6 +78,10 @@ struct landlock_hierarchy {
 	 * Landlock domain.
 	 */
 	struct landlock_hierarchy *parent;
+	/**
+	 * @id: Landlock domain ID, sets once at domain creation time.
+	 */
+	u64 id;
 	/**
 	 * @usage: Number of potential children domains plus their parent
 	 * domain.
@@ -96,10 +100,6 @@ struct landlock_hierarchy {
 	 * Masked (i.e. never logged) denials are still counted.
 	 */
 	atomic64_t num_denials;
-	/**
-	 * @id: Landlock domain ID, sets once at domain creation time.
-	 */
-	u64 id;
 	/**
 	 * @details: Information about the related domain.
 	 */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index de41e8bde2e4..e42933361c32 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -25,6 +25,7 @@
 #include "access.h"
 #include "audit.h"
 #include "domain.h"
+#include "id.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
@@ -576,6 +577,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+	new_dom->hierarchy->id = landlock_get_id_range(1);
 	return no_free_ptr(new_dom);
 }
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 5709a53c4a09..060ac9d52527 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/landlock.h>
 #include <linux/limits.h>
 #include <linux/mount.h>
 #include <linux/path.h>
@@ -538,3 +539,77 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	return commit_creds(new_cred);
 }
+
+/**
+ * landlock_read_domain_id - Read the domain ID of a task
+ *
+ * @cred: The credential used to check permission.
+ * @task: Task to read the domain ID from.
+ * @last: Either get the ID of the last or the closest nested domain relative
+ *        to @cred.
+ * @id: Returned domain ID on success.
+ *
+ * @cred is only allowed to get information about its nested domains.
+ *
+ * Any error returned by this function just translates to non-information in a
+ * PIDFD_GET_INFO's PIDFD_INFO_LANDLOCK_LAST_DOMAIN or
+ * PIDFD_INFO_LANDLOCK_FIRST_DOMAIN request.
+ *
+ * Returns: 0 on success, or -errno on error.
+ */
+int landlock_read_domain_id(const struct cred *const cred,
+			    struct task_struct *const task, const bool last,
+			    u64 *const id)
+{
+	const struct landlock_ruleset *cred_dom, *task_dom;
+	const struct landlock_hierarchy *walker, *prev;
+	bool is_allowed;
+
+	if (!is_initialized())
+		return -EOPNOTSUPP;
+
+	cred_dom = landlock_cred(cred)->domain;
+
+	guard(rcu)();
+	task_dom = landlock_get_task_domain(task);
+
+	/*
+	 * Domain introspection is denied to not leak information about the
+	 * current restrictions.  However, a task can open a pidfd to itself,
+	 * sandbox itself, and then read its domain ID from the previously
+	 * opened pidfd.  This is OK because the task already knows its
+	 * sandbox, which might not be the case for its children.
+	 *
+	 * For consistency wrt sandboxed and non-sandboxed tasks, any task
+	 * should get the same result when directly reading its own domain.  A
+	 * non-sandboxed task requesting to read another non-sandboxed task
+	 * should then also be denied (i.e. cred_dom == task_dom == NULL).
+	 */
+	if (cred_dom == task_dom)
+		return -EPERM;
+
+	if (!task_dom)
+		return -EPERM;
+
+	/* Reading properties of @cred's nested domains is allowed. */
+	is_allowed = !cred_dom;
+	prev = task_dom->hierarchy;
+	for (walker = prev; walker; walker = walker->parent) {
+		if (cred_dom && walker == cred_dom->hierarchy) {
+			is_allowed = true;
+			break;
+		}
+
+		prev = walker;
+	}
+
+	if (!is_allowed)
+		return -EPERM;
+
+	if (last)
+		*id = task_dom->hierarchy->id;
+	else
+		*id = prev->id;
+
+	return 0;
+}
-- 
2.48.1


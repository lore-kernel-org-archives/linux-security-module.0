Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267B1F869E
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351047; cv=none; b=V842z0fkS9AcaN/41s0lGOyvR9r2wQrKhdbIVay2EnfJAizOjzn9249OwpPlI/mPjgvGMafAby+mU4U1DpXSGF+EJrL3l6zy6gdpLa4HhCNHjXKpk5r51vqvA1S+k1AQ+r/9amsZcXDgnkP9BRvYJGkO/xo1kgO+v1BDxVzwcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351047; c=relaxed/simple;
	bh=QJqwYq5frXoftVqz8LmANwAzt2hFiBJ6iJtSHT5ib30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E58zqy55UPbfOiEcLDvwS/oxXDZagh2aw/Y2MdvZn6Aw7bEbIPaCzVNbYKeS31N2xKqDnnBbMVBA+c+VHwrs2nnIfeoXnFIWsdCGxp3+YmdVzEYQhmPWI8hbwQY/U0c5vTLs9UETY16Yrvd8tcCRIODcZnmN/b1ANYI2OuPg8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uKn5Cyt1; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uKn5Cyt1"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsf46Mrxzt6D;
	Wed,  8 Jan 2025 16:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351036;
	bh=+oXeGTZhWH7zBrQn+Rqm0cL2tmgvGubeqz4bC82gHKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKn5Cyt1fy8HNn9dNzo94+saIuMbKk9tuT5fAbXUJKDyV5h0042Kkd0h+reDI/kU5
	 HRbm+GlmT0ZGqNTml3nG76EaK+VfZsWhf1kwxePlbq4eS+DD89TVgaMw3cVQVTe2Nh
	 YYYy9Vu8vQCXutfEqHClqV3l2i9jH1AO7/ThDHVA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsf362CyzHf5;
	Wed,  8 Jan 2025 16:43:55 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 07/30] landlock: Move domain hierarchy management and export helpers
Date: Wed,  8 Jan 2025 16:43:15 +0100
Message-ID: <20250108154338.1129069-8-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Create a new domain.h file containing the struct landlock_hierarchy
definition and helpers.  This type will grow with audit support.  This
also prepares for a new domain type.

Export landlock_get_hierarchy() and landlock_put_hierarchy() that will
be used by audit in a following commit.

Clean up Makefile entries.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-8-mic@digikod.net
---

Changes since v3:
- Export landlock_get_hierarchy() and landlock_put_hierarchy().
- Clean up Makefile entries.

Changes since v1:
- New patch.
---
 MAINTAINERS                 |  1 +
 include/linux/landlock.h    | 31 +++++++++++++++++++++++++++++++
 security/landlock/Makefile  | 11 +++++++++--
 security/landlock/domain.c  | 29 +++++++++++++++++++++++++++++
 security/landlock/domain.h  | 31 +++++++++++++++++++++++++++++++
 security/landlock/ruleset.c | 22 ++++------------------
 security/landlock/ruleset.h | 17 +----------------
 security/landlock/task.c    |  1 +
 8 files changed, 107 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/landlock.h
 create mode 100644 security/landlock/domain.c
 create mode 100644 security/landlock/domain.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 30cbc3d44cd5..425676b25a4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12961,6 +12961,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
 F:	fs/ioctl.c
+F:	include/linux/landlock.h
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
diff --git a/include/linux/landlock.h b/include/linux/landlock.h
new file mode 100644
index 000000000000..8491142658a1
--- /dev/null
+++ b/include/linux/landlock.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock - Kernel API
+ *
+ * Copyright © 2024-2025 Microsoft Corporation
+ */
+
+#ifndef _LINUX_LANDLOCK_H
+#define _LINUX_LANDLOCK_H
+
+struct landlock_hierarchy;
+
+#ifdef CONFIG_SECURITY_LANDLOCK
+
+void landlock_get_hierarchy(struct landlock_hierarchy *hierarchy);
+
+void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy);
+
+#else /* CONFIG_SECURITY_LANDLOCK */
+
+static inline void landlock_get_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+}
+
+static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK */
+
+#endif /* _LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index e1777abbc413..51815908a464 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,7 +1,14 @@
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
+	domain.o
 
 landlock-$(CONFIG_INET) += net.o
 
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
new file mode 100644
index 000000000000..df58638ffc50
--- /dev/null
+++ b/security/landlock/domain.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Domain management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ * Copyright © 2024-2025 Microsoft Corporation
+ */
+
+#include <linux/landlock.h>
+#include <linux/mm.h>
+
+#include "domain.h"
+
+void landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+	if (hierarchy)
+		refcount_inc(&hierarchy->usage);
+}
+
+void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
+		const struct landlock_hierarchy *const freeme = hierarchy;
+
+		hierarchy = hierarchy->parent;
+		kfree(freeme);
+	}
+}
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
new file mode 100644
index 000000000000..2e612ef754e3
--- /dev/null
+++ b/security/landlock/domain.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Domain management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_DOMAIN_H
+#define _SECURITY_LANDLOCK_DOMAIN_H
+
+#include <linux/landlock.h>
+#include <linux/refcount.h>
+
+/**
+ * struct landlock_hierarchy - Node in a domain hierarchy
+ */
+struct landlock_hierarchy {
+	/**
+	 * @parent: Pointer to the parent node, or NULL if it is a root
+	 * Landlock domain.
+	 */
+	struct landlock_hierarchy *parent;
+	/**
+	 * @usage: Number of potential children domains plus their parent
+	 * domain.
+	 */
+	refcount_t usage;
+};
+
+#endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index dbc528f5f3b7..8b47af69af3e 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/landlock.h>
 #include <linux/lockdep.h>
 #include <linux/overflow.h>
 #include <linux/rbtree.h>
@@ -21,6 +22,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
@@ -305,22 +307,6 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
 }
 
-static void get_hierarchy(struct landlock_hierarchy *const hierarchy)
-{
-	if (hierarchy)
-		refcount_inc(&hierarchy->usage);
-}
-
-static void put_hierarchy(struct landlock_hierarchy *hierarchy)
-{
-	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
-		const struct landlock_hierarchy *const freeme = hierarchy;
-
-		hierarchy = hierarchy->parent;
-		kfree(freeme);
-	}
-}
-
 static int merge_tree(struct landlock_ruleset *const dst,
 		      struct landlock_ruleset *const src,
 		      const enum landlock_key_type key_type)
@@ -475,7 +461,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	get_hierarchy(parent->hierarchy);
+	landlock_get_hierarchy(parent->hierarchy);
 	child->hierarchy->parent = parent->hierarchy;
 
 out_unlock:
@@ -499,7 +485,7 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 		free_rule(freeme, LANDLOCK_KEY_NET_PORT);
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-	put_hierarchy(ruleset->hierarchy);
+	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 2f29b9f40392..39169b6860e3 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "object.h"
 
@@ -106,22 +107,6 @@ struct landlock_rule {
 	struct landlock_layer layers[] __counted_by(num_layers);
 };
 
-/**
- * struct landlock_hierarchy - Node in a ruleset hierarchy
- */
-struct landlock_hierarchy {
-	/**
-	 * @parent: Pointer to the parent node, or NULL if it is a root
-	 * Landlock domain.
-	 */
-	struct landlock_hierarchy *parent;
-	/**
-	 * @usage: Number of potential children domains plus their parent
-	 * domain.
-	 */
-	refcount_t usage;
-};
-
 /**
  * struct landlock_ruleset - Landlock ruleset
  *
diff --git a/security/landlock/task.c b/security/landlock/task.c
index dc7dab78392e..98894ad1abc7 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -18,6 +18,7 @@
 
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "fs.h"
 #include "ruleset.h"
 #include "setup.h"
-- 
2.47.1


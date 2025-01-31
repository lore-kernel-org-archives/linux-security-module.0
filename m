Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A01F37A7
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341456; cv=none; b=uaenyPMUCYGRgYvj657+uIZXJoN+bIB1rrByxJTDb9XCTvhlttQjwuz0PRMiSLkoLtRpQwFKsbeewrDIT9cInl75wNp5UK6/xyDqFCcroaU512ogoJCWpOJsKPO+kERaltbAlp0hXC9Qapvq8tbjEr9SvbKaa2fOQ07Io3L99NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341456; c=relaxed/simple;
	bh=N8Om2n0KddmhOLHiv5L0C5QyD/YuD/cDRrTNRIclHOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTd9AOS32PuNCJ+NK7WbwCldLM/jX29p0w8gmeal1qpYZ5WW0PO+HApgGymePUFvGbRmjSDmShy9vMOKlDaQVD6sMnVAKC2BFGRPlfMMmzMrhs1/BaCD9sT7bozhCG4y0fI4yxTp0W4RWoBBkEtj+O83ZJ8JlEe09vj/v6MCJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DBQcl10f; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DBQcl10f"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1c44lVRzSw9;
	Fri, 31 Jan 2025 17:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341076;
	bh=aHQJl+dVGbOpW1bY4DGl2h1/OFoOfo4CmWzo2/nx1s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBQcl10f0f5D7/8u603fLWuzPyCxrKg6WKqyVNRjKJxqfKzXAcixwRxGpV/A72o8u
	 bCUKQfQRObjITh5I5s3KKhldntUgWoEZLvjCh8BFN7DNSHNZPgNmXLU/S3EhX5VvUZ
	 XfeTHZpWoZf2bIXFLpQA8Xs1SMCCJOjNFhR7pDpM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1c35h9szd0d;
	Fri, 31 Jan 2025 17:31:15 +0100 (CET)
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
Subject: [PATCH v5 03/24] landlock: Move domain hierarchy management
Date: Fri, 31 Jan 2025 17:30:38 +0100
Message-ID: <20250131163059.1139617-4-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
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

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-4-mic@digikod.net
---

Changes since v4:
- Revert v3 changes because of the new audit rule patch removal.

Changes since v3:
- Export landlock_get_hierarchy() and landlock_put_hierarchy().
- Clean up Makefile entries.

Changes since v1:
- New patch.
---
 security/landlock/domain.h  | 48 +++++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.c | 21 +++-------------
 security/landlock/ruleset.h | 17 +------------
 security/landlock/task.c    |  1 +
 4 files changed, 53 insertions(+), 34 deletions(-)
 create mode 100644 security/landlock/domain.h

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
new file mode 100644
index 000000000000..015d61fd81ec
--- /dev/null
+++ b/security/landlock/domain.h
@@ -0,0 +1,48 @@
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
+#include <linux/mm.h>
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
+static inline void
+landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+	if (hierarchy)
+		refcount_inc(&hierarchy->usage);
+}
+
+static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
+		const struct landlock_hierarchy *const freeme = hierarchy;
+
+		hierarchy = hierarchy->parent;
+		kfree(freeme);
+	}
+}
+
+#endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 241ce44375b6..fb955354912d 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
@@ -307,22 +308,6 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
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
@@ -477,7 +462,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	get_hierarchy(parent->hierarchy);
+	landlock_get_hierarchy(parent->hierarchy);
 	child->hierarchy->parent = parent->hierarchy;
 
 out_unlock:
@@ -501,7 +486,7 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 		free_rule(freeme, LANDLOCK_KEY_NET_PORT);
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-	put_hierarchy(ruleset->hierarchy);
+	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 52f4f0af6ab0..bbb5996545d2 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "object.h"
 
@@ -108,22 +109,6 @@ struct landlock_rule {
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
2.48.1


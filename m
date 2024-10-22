Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFA1B6555
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614016; cv=none; b=ZIWhKiGXmxVUqAcPYQQfDP/VR71bz2hqZgnrA6wXDLJyYJ/nkVZhVcIo2cBMAGaHzMQzNoku4WlGxz4xO2lRwh1r0Q2amMpBZdkeGSH5A8477iIvRlfq7qCRhRezukWKYSr4T8vdZGFDWW6D+TLZund+RQ4VErBKd2c4a3GNjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614016; c=relaxed/simple;
	bh=4GeYmW8FVXAUclTZ3wGNsCun2WpzvRZ0cA3FW8mmcv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmMF7ibRMhLeoorw9S4b2Q5N0Wl5RsofqX1qdMzSSyxMMaK2pN+p3EeqN8YC5RQi/AB0TrZEFAAOFb9ATdhJjRCmX5euAOY5JppENPRM0h0lPh+l0JM1KHeOn7OQ1PzOqVXyBuHcripnUaSRi+iTqGEwqTkfcKix8gfoszeOk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hqg/nHDt; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hqg/nHDt"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwg1mywz183d;
	Tue, 22 Oct 2024 18:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613427;
	bh=6kguhd2Vr+s/85Nr2Op6lj+yU1Ns4KOpTtVIwEiojB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqg/nHDtE3nSVjsQExu2OEaru4HgWI7eE5n/kPq9/gNUbIDkSz1H2vMDRy5HhGAwr
	 giUL3xeELgunfjKJCySCZx3vR/OPYoCLONd8OBrj0qYX4kIZT4er5d7NAj0DGNWODt
	 W2WVvHjB934JPNV6LkaDyjyghIX1XaYudUeZfuAg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwf3DYyzwwl;
	Tue, 22 Oct 2024 18:10:26 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 06/14] landlock: Move domain hierarchy management
Date: Tue, 22 Oct 2024 18:10:01 +0200
Message-ID: <20241022161009.982584-7-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241022161009.982584-7-mic@digikod.net
---

Changes since v1:
* New patch.
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
index a93bdbf52fff..57cb7dcd6333 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include "domain.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
@@ -304,22 +305,6 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
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
@@ -473,7 +458,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	get_hierarchy(parent->hierarchy);
+	landlock_get_hierarchy(parent->hierarchy);
 	child->hierarchy->parent = parent->hierarchy;
 
 out_unlock:
@@ -497,7 +482,7 @@ static void free_ruleset(struct landlock_ruleset *const ruleset)
 		free_rule(freeme, LANDLOCK_KEY_NET_PORT);
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-	put_hierarchy(ruleset->hierarchy);
+	landlock_put_hierarchy(ruleset->hierarchy);
 	kfree(ruleset);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 7921bbe01344..d0a60a5f7cd9 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -18,6 +18,7 @@
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
+#include "domain.h"
 #include "limits.h"
 #include "object.h"
 
@@ -119,22 +120,6 @@ struct landlock_rule {
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
index e7f45af87ff5..23b56b3772c6 100644
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
2.47.0


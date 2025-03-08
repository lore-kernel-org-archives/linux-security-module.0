Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6C1FC7D9
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459490; cv=none; b=kLZ8IVg/FOHsEpLcAAQ+r7/Na/bdTvjy6AA6+85OQSxl4rCe8NXIq9pl5tUXIrZp20gQrg2OQeYzTOCGs4snw0jZnI5aHYxDAwXFHa6X9jMu6bbhviuQtgpCxuBIEeMEEZTLeUTF3i8MHLX90B0R9vDjBWdsATx6gjo4pdxkqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459490; c=relaxed/simple;
	bh=/DIW+o9MtyBqi9NSDKP1dznkr/BGT7d3uJ58sf94IQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gF46IOpkjSBICJuLMvXS1RNTW24jOTQQX2AIqKTZzmZQXGH9cgQgskrPPn8kPvQ+Pk/05TWZZergZdeshAxL7fuSV38BXOZK6ZJzTM5S8cZWEcSNorT0/dPx4RThC0dxc69Us+4YuIMQ5VIjf8BxMUr+IVGaUPSxAd17cDdvTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PsGar88P; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PsGar88P"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsK5h1nzQ5y;
	Sat,  8 Mar 2025 19:44:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459477;
	bh=KEWxcLsnhjmJc3O6glXK+S8YI69l+/vlv/Gj9V16MQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsGar88PKisKUNdvF7leuI3ysvAVX3CKKesUBVxxuEscR6Mp5SEKTDs9muh6y7jp+
	 mJAMIC+VTM+mIOo8chP/ZRaVlfx/85SGrG/4hD5CI+B2P98oUtPqVfJOEUaRpQrkwJ
	 09CbHWna27RY1+QVEfgd49Jozk0DpFphfgIT49YU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsK0wJXzn94;
	Sat,  8 Mar 2025 19:44:37 +0100 (CET)
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 03/26] landlock: Move domain hierarchy management
Date: Sat,  8 Mar 2025 19:43:59 +0100
Message-ID: <20250308184422.2159360-4-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250308184422.2159360-4-mic@digikod.net
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
index bff4e40a3093..adb7f87828df 100644
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


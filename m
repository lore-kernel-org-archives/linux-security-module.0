Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA25C7082B
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286059; cv=none; b=c/laAcD+LY8Xb8Gy2iRtRv6wO3HRKqjBVUdHIIE4ZV6rE3y2uyWD4IbFjN7CuyPnVreQ4mHRxqWDeVg5RpsfRi4HaDSnnxSjHy7HmkjQdTqEcealFYLE/JqdmX4O1ZSAr04rltwx5LxAaaynQ/xS+1iA600GfIjwC5XDVi7V/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286059; c=relaxed/simple;
	bh=NuT0tcq/43zDLvDEY8JWunzl/WOg4jV/JJW5DYCdEdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2OMVFixHxI05N+Dek1QAKlVJdavd8+vJlllGYudb1zwk/n/aCLAR4MszRwjH4Gvn1NdCFWiPNHCEVbXcz9zl2A7V1r09Yne7IxV4CWcx6yHSLpQu+NsUwWNgGjJ7rHhvHBeZ39QPqgdxsWLnOcf+EZd8OU8BPg9fpy7p9ziFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YyjWljcv; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YyjWljcv"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKF5G5jzcBZ;
	Fri, 22 Nov 2024 15:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286049;
	bh=8Ei6RdWiyTIEr0sm3nOOSbLrW31UhPKYLCfZTJ/6SdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyjWljcvGeJieGlqZKPvWq1H43r2bNPIPvh5Z1hXmzTAeRzubP75L/J6jMCWoGF19
	 15BGkb/JRQxrEeXtxpEYZDgbG2QrmUZ3NZ2tj6vqu/vVdQHrCjQTgPDpzW2LGU087A
	 oeOhbGIl0AI1r5gLoZo1esDwOuhrtiHKB8WnANbU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKF09LzzlDf;
	Fri, 22 Nov 2024 15:34:09 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
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
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 05/23] landlock: Move access types
Date: Fri, 22 Nov 2024 15:33:35 +0100
Message-ID: <20241122143353.59367-6-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Move LANDLOCK_ACCESS_FS_INITIALLY_DENIED, access_mask_t, struct
access_mask, and struct access_masks_all to a dedicated access.h file.

Rename LANDLOCK_ACCESS_FS_INITIALLY_DENIED to
_LANDLOCK_ACCESS_FS_INITIALLY_DENIED to make it clear that it's not part
of UAPI.  Add some newlines when appropriate.

This file will be extended with following commits, and it will help to
avoid dependency loops.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-6-mic@digikod.net
---

Changes since v2:
- Rebased on the (now merged) masks improvement patches.
- Move ACCESS_FS_OPTIONAL to a following patch introducing deny_masks_t,
  spotted by Francis Laniel.
- Move and rename LANDLOCK_ACCESS_FS_INITIALLY_DENIED to
  _LANDLOCK_ACCESS_FS_INITIALLY_DENIED.

Changes since v1:
- New patch
---
 security/landlock/access.h  | 62 +++++++++++++++++++++++++++++++++++++
 security/landlock/fs.c      |  3 +-
 security/landlock/fs.h      |  1 +
 security/landlock/ruleset.c |  1 +
 security/landlock/ruleset.h | 47 ++--------------------------
 5 files changed, 68 insertions(+), 46 deletions(-)
 create mode 100644 security/landlock/access.h

diff --git a/security/landlock/access.h b/security/landlock/access.h
new file mode 100644
index 000000000000..a64694287d2c
--- /dev/null
+++ b/security/landlock/access.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Access types and helpers
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ * Copyright © 2024 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_ACCESS_H
+#define _SECURITY_LANDLOCK_ACCESS_H
+
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/kernel.h>
+#include <uapi/linux/landlock.h>
+
+#include "limits.h"
+
+/*
+ * All access rights that are denied by default whether they are handled or not
+ * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
+ * entries when we need to get the absolute handled access masks.
+ */
+/* clang-format off */
+#define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
+	LANDLOCK_ACCESS_FS_REFER)
+/* clang-format on */
+
+typedef u16 access_mask_t;
+
+/* Makes sure all filesystem access rights can be stored. */
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
+/* Makes sure all network access rights can be stored. */
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
+/* Makes sure all scoped rights can be stored. */
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
+/* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
+static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
+
+/* Ruleset access masks. */
+struct access_masks {
+	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
+	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
+	access_mask_t scope : LANDLOCK_NUM_SCOPE;
+};
+
+union access_masks_all {
+	struct access_masks masks;
+	u32 all;
+};
+
+/* Makes sure all fields are covered. */
+static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
+	      sizeof(typeof_member(union access_masks_all, all)));
+
+typedef u16 layer_mask_t;
+
+/* Makes sure all layers can be checked. */
+static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
+
+#endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d911c924843f..3da5f1945158 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -36,6 +36,7 @@
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
 
+#include "access.h"
 #include "common.h"
 #include "cred.h"
 #include "fs.h"
@@ -393,7 +394,7 @@ get_handled_fs_accesses(const struct landlock_ruleset *const domain)
 {
 	/* Handles all initially denied by default access rights. */
 	return landlock_union_access_masks(domain).fs |
-	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
 static const struct access_masks any_fs = {
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 1487e1f023a1..d445f411c26a 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 
+#include "access.h"
 #include "ruleset.h"
 #include "setup.h"
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a93bdbf52fff..cae69f2f01d9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include "access.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 631e24d4ffe9..2f29b9f40392 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -9,58 +9,15 @@
 #ifndef _SECURITY_LANDLOCK_RULESET_H
 #define _SECURITY_LANDLOCK_RULESET_H
 
-#include <linux/bitops.h>
-#include <linux/build_bug.h>
-#include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/workqueue.h>
-#include <uapi/linux/landlock.h>
 
+#include "access.h"
 #include "limits.h"
 #include "object.h"
 
-/*
- * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
- * entries when we need to get the absolute handled access masks.
- */
-/* clang-format off */
-#define LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
-	LANDLOCK_ACCESS_FS_REFER)
-/* clang-format on */
-
-typedef u16 access_mask_t;
-/* Makes sure all filesystem access rights can be stored. */
-static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
-/* Makes sure all network access rights can be stored. */
-static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
-/* Makes sure all scoped rights can be stored. */
-static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
-/* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
-static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
-
-/* Ruleset access masks. */
-struct access_masks {
-	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
-	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
-	access_mask_t scope : LANDLOCK_NUM_SCOPE;
-};
-
-union access_masks_all {
-	struct access_masks masks;
-	u32 all;
-};
-
-/* Makes sure all fields are covered. */
-static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
-	      sizeof(typeof_member(union access_masks_all, all)));
-
-typedef u16 layer_mask_t;
-/* Makes sure all layers can be checked. */
-static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
-
 /**
  * struct landlock_layer - Access rights for a given layer
  */
@@ -366,7 +323,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
 {
 	/* Handles all initially denied by default access rights. */
 	return ruleset->access_masks[layer_level].fs |
-	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
 static inline access_mask_t
-- 
2.47.0


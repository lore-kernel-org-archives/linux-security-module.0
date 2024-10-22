Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAC54FB5
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614615; cv=none; b=GvBcJ8Av7bxbdFpA/grcQwKd2bjMWWCIo1yyr2JeBsoZi7hNHwswE36kJiwPEXKYpepMlJVjr3faCyNlAY/3qwDHavfjWnDlXedk6Y+JT/im5Qnmj/WbQ50/7kQR0Zgb0mW0M2psbOHcdpjz14hMOz5S3mrA7jxBrF5pT0is9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614615; c=relaxed/simple;
	bh=ZcoF4avO5+1Nf7WyLQZutgIfdEZgUWOxw1VHiw9Jzk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnSfLRNUe7DgpAyDedypagiMmK+44irH+N8j1lLVQNeXjO5uS5n6gIlKODuT1zxHjt+m+yfZikU2Z7q1gvd87pX/XvkQQzsmE379qhuf29O55+C7MMgEPNF9tdBIcRRVLnNYa+Hxq5rK4Ma6RQ1o3LcNGj0MvLZeNMpYEEV/by0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ag4USti3; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ag4USti3"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwd56RlzLlZ;
	Tue, 22 Oct 2024 18:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613425;
	bh=w7OPDpT+/pVeC3pioaOdEpjy1MvoCvp/oh183aLvVSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ag4USti3JMXQSd0mjR8BCWDrRIEooE0rOUoqCW+oUU6eJ6QbAnSJLDAdpMZAMYujY
	 3ZWy0XDMB8bc6qgK0qQj0vk4bW0KE7NvLtNMsetqk7ceXcZWPq9SKU9S21ILAspYIT
	 59I48tjquk1nPl2Ab7sv1aSV+X483foQBibYWSNs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwc6xgpzrKf;
	Tue, 22 Oct 2024 18:10:24 +0200 (CEST)
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
Subject: [RFC PATCH v2 05/14] landlock: Move access types
Date: Tue, 22 Oct 2024 18:10:00 +0200
Message-ID: <20241022161009.982584-6-mic@digikod.net>
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

Move ACCESS_FS_OPTIONAL, access_mask_t, struct access_mask, and struct
access_masks_all to a dedicated access.h file.

This file will be extended with a following commit, and it will help to
avoid dependency loops.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-6-mic@digikod.net
---

Changes since v1:
* New patch
---
 security/landlock/access.h  | 53 +++++++++++++++++++++++++++++++++++++
 security/landlock/fs.c      |  1 +
 security/landlock/fs.h      |  1 +
 security/landlock/ruleset.h | 31 +---------------------
 4 files changed, 56 insertions(+), 30 deletions(-)
 create mode 100644 security/landlock/access.h

diff --git a/security/landlock/access.h b/security/landlock/access.h
new file mode 100644
index 000000000000..2659fd9b4aaf
--- /dev/null
+++ b/security/landlock/access.h
@@ -0,0 +1,53 @@
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
+#include <uapi/linux/landlock.h>
+
+#include "limits.h"
+
+/* clang-format off */
+#define ACCESS_FS_OPTIONAL ( \
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+/* clang-format on */
+
+typedef u16 access_mask_t;
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
+static_assert(sizeof(((union access_masks_all *)NULL)->masks) ==
+	      sizeof(((union access_masks_all *)NULL)->all));
+
+typedef u16 layer_mask_t;
+/* Makes sure all layers can be checked. */
+static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
+
+#endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 698a623a8184..e0e5775b75ae 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -36,6 +36,7 @@
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
 
+#include "access.h"
 #include "common.h"
 #include "cred.h"
 #include "fs.h"
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
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index e00edcb38c5b..7921bbe01344 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
 
+#include "access.h"
 #include "limits.h"
 #include "object.h"
 
@@ -30,36 +31,6 @@
 	LANDLOCK_ACCESS_FS_REFER)
 /* clang-format on */
 
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
-static_assert(sizeof(((union access_masks_all *)NULL)->masks) ==
-	      sizeof(((union access_masks_all *)NULL)->all));
-
-typedef u16 layer_mask_t;
-/* Makes sure all layers can be checked. */
-static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
-
 /**
  * struct landlock_layer - Access rights for a given layer
  */
-- 
2.47.0


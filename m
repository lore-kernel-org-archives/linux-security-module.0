Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8E1172A
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376420; cv=none; b=QJEaafCCNXRd08iSxKT7ntEJE9/L7yDrKMpThfl8SuPqHZXd2p6i+6FRwV/s8jNTmVgteJtPSAbXtS/IwglTXl2Z4uBXj2tLSLklVuzEN8QCUA96YTNLUw0bIRu+11avPZMAWENHaZn+r3YyhHw5BixU83cK52UCgRk8gZlxeVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376420; c=relaxed/simple;
	bh=WorUqO2lCJn7UEs4OhhQiaaGNgnvP+73Vse+/gFqQXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8xlg9tdoBUKQc4/jJPNKLRGiaZoKSvG7IaqeujUm/R5YN84ZSYYjiEitpRsHAssRlkxpRQoS9gEF2SF1PZZPiZkupeNX4RrLvNgcnsdXzyxHU03TicnyaSTBCZ88pVvadkLYkX9i428HowmL9mp45Mk2ggK4NOInaMb7nmoQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=hneHbzUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuraBqfB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="hneHbzUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuraBqfB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C01AA1D0018D;
	Mon,  8 Sep 2025 20:06:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Sep 2025 20:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757376417; x=
	1757462817; bh=zOg8fxeDMiUC7bcxHVMFlFlb7j9f6rW8/0Q3x6Z3qFI=; b=h
	neHbzUWtc5icQt3cGVfT+eJlhj7Ofc4EecekUYJMpO8QilWmfk2CbGGw3yDPYmyX
	P8DZNV2iEhgRN8uHeTJKsIZq9scKEuLe1YqF8RaxpmzQSYP7fTENiIeHcDzTplbP
	YZKt3PSWJCRW1uwh09uR1lJ+4S9Uhdi6vVUztMYEDOV3YljnEUVqJ4kVhOonVm/1
	SkcXYWAIRnq2dJAKciKFKku1CdsNBj0MgqAMO0y7M4gp1MpFFDF+DTLNgXsr6jq4
	DaP00Jfkyz8AAbGrrJJI44KJxXtMl3jdroWN54YvWDNpEiqhXKoOc21AIAmo98tl
	kj3h1wm/0x39ORI3nhHzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757376417; x=1757462817; bh=z
	Og8fxeDMiUC7bcxHVMFlFlb7j9f6rW8/0Q3x6Z3qFI=; b=JuraBqfBm2j7X31cT
	zl2cb5RiVHcm6FXDE9duiP7GhnwqX/Mlp4X/E3faHZfuGkY6W80qXYzaktTEIOsd
	Jn3ARvT2t4WMz30QLOh/f2c1+MhkBixyG1UbQvCnj95NS3e1GG0vV/mdZNCTwnr1
	oNDoCR+98RPBCXiCam90HEf/o3XBMnh7+wiMRhyZgonj/VT3Hh9AkB2CSHHYWa4U
	RMDNnOcyTEpkGoRNhjnCCBrtjULxx+oS2Xv5Ge0PiInCUAVkdQ+89xoD6X162fdp
	4O7miQCRDT6TW288MNnC3rYhLVxBHsmclHlVgXEDSewWpxIeFY2tGa3xo824eMe1
	RniBw==
X-ME-Sender: <xms:oW-_aFyKstgZU2Ftl9iBosX1e0PcKLMV_1SG6TvZHWYmi6AlPVgInA>
    <xme:oW-_aAwkNqT3ZkPZvJlnr1XJinUX39YjGbMbUW7IrIbgLX1C7cQoK75_vN9tha8XV
    qx7cS8bHJFpSJDfkxk>
X-ME-Received: <xmr:oW-_aFxLIbgX1tKT93gmXCH5w4PrKy6b80eQFlH4c-g2TpUvZ1SEo8xMiwOZKJQYgIAhyDhnjH8URofzaDM-kFujxlt4O7S30GpSa21bk76H0rQiJfyk4SRqyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oW-_aCZ7x8UK6T8hz5U-MdgdurvVhX0QIpDZwFNKllJp4KI1L4tw1A>
    <xmx:oW-_aOXsl-2HhsE0-K7Fh9lu41DLl-3Uai_k4yko-ZDeA3khuS-8OA>
    <xmx:oW-_aIjj2veUYTIqUsqygo_i8j2d-txSiUhqlIsjpl2JW0C-fkZj6g>
    <xmx:oW-_aEtScNkiHmZ3aXPjjBvBJa2sjyekDj_Ihfc64MxVQ5vFkrgxSg>
    <xmx:oW-_aLdsx7zDxpLT2_hF-qFMquDgbAQrCbExFFlXYbTKCN71VmmM6foA>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:06:56 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 2/6] landlock: Add API support for the quiet flag
Date: Tue,  9 Sep 2025 01:06:36 +0100
Message-ID: <e9462ee16376d706188d48d8f4b4fd50760432e5.1757376311.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757376311.git.m@maowtm.org>
References: <cover.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also added documentation.

As for kselftests, for now we just change add_rule_checks_ordering to use
a different invalid flag.  I will add tests for the quiet flag in a later
version.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 include/uapi/linux/landlock.h                | 25 +++++++++++++++++
 security/landlock/fs.c                       |  4 +--
 security/landlock/fs.h                       |  2 +-
 security/landlock/net.c                      |  5 ++--
 security/landlock/net.h                      |  3 ++-
 security/landlock/ruleset.c                  |  8 +++++-
 security/landlock/ruleset.h                  |  2 +-
 security/landlock/syscalls.c                 | 28 ++++++++++++--------
 tools/testing/selftests/landlock/base_test.c |  2 +-
 9 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..3e5b2ce0b18b 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -69,6 +69,31 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
+/**
+ * DOC: landlock_add_rule_flags
+ *
+ * **Flags**
+ *
+ * %LANDLOCK_ADD_RULE_QUIET
+ *     This flag controls whether Landlock will log audit messages when
+ *     access to the objects covered by this rule is denied by this layer.
+ *
+ *     When Landlock denies an access, if audit logging is enabled,
+ *     Landlock will check if the youngest layer that denied the access
+ *     has marked the object in question as "quiet".  If so, no audit log
+ *     will be generated.  Note that logging is only suppressed if the
+ *     layer that denied the access is this layer.  This means that a
+ *     sandboxed program cannot use this flag to "hide" access denials,
+ *     unless it denies itself the access.
+ *
+ *     When this flag is present, the caller is allowed to pass in a rule
+ *     with empty allowed_access.
+ */
+
+/* clang-format off */
+#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+/* clang-format on */
+
 /**
  * DOC: landlock_restrict_self_flags
  *
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e7eaf55093e9..b566ae498df5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -322,7 +322,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
  */
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
-			    access_mask_t access_rights)
+			    access_mask_t access_rights, const int flags)
 {
 	int err;
 	struct landlock_id id = {
@@ -343,7 +343,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index bf9948941f2f..cb7e654933ac 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -126,6 +126,6 @@ __init void landlock_add_fs_hooks(void);
 
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
-			    access_mask_t access_hierarchy);
+			    access_mask_t access_hierarchy, const int flags);
 
 #endif /* _SECURITY_LANDLOCK_FS_H */
diff --git a/security/landlock/net.c b/security/landlock/net.c
index fc6369dffa51..bddbe93d69fd 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -20,7 +20,8 @@
 #include "ruleset.h"
 
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
-			     const u16 port, access_mask_t access_rights)
+			     const u16 port, access_mask_t access_rights,
+			     const int flags)
 {
 	int err;
 	const struct landlock_id id = {
@@ -35,7 +36,7 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			 ~landlock_get_net_access_mask(ruleset, 0);
 
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 
 	return err;
diff --git a/security/landlock/net.h b/security/landlock/net.h
index 09960c237a13..799cedd5d0b7 100644
--- a/security/landlock/net.h
+++ b/security/landlock/net.h
@@ -16,7 +16,8 @@
 __init void landlock_add_net_hooks(void);
 
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
-			     const u16 port, access_mask_t access_rights);
+			     const u16 port, access_mask_t access_rights,
+			     const int flags);
 #else /* IS_ENABLED(CONFIG_INET) */
 static inline void landlock_add_net_hooks(void)
 {
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 3aa4e33ac95b..990aa1a2c120 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
 
 #include "access.h"
 #include "audit.h"
@@ -251,6 +252,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
 				return -EINVAL;
 			this->layers[0].access |= (*layers)[0].access;
+			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
 			return 0;
 		}
 
@@ -297,12 +299,15 @@ static void build_check_layer(void)
 /* @ruleset must be locked by the caller. */
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
-			 const access_mask_t access)
+			 const access_mask_t access, const int flags)
 {
 	struct landlock_layer layers[] = { {
 		.access = access,
 		/* When @level is zero, insert_rule() extends @ruleset. */
 		.level = 0,
+		.flags = {
+			.quiet = flags & LANDLOCK_ADD_RULE_QUIET ? 1 : 0,
+		}
 	} };
 
 	build_check_layer();
@@ -343,6 +348,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 			return -EINVAL;
 
 		layers[0].access = walker_rule->layers[0].access;
+		layers[0].flags = walker_rule->layers[0].flags;
 
 		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
 		if (err)
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index d4b70b6af137..4f184d2da382 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -224,7 +224,7 @@ DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
-			 const access_mask_t access);
+			 const access_mask_t access, const int flags);
 
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..e46164246fdb 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -312,7 +312,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 }
 
 static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
-				 const void __user *const rule_attr)
+				 const void __user *const rule_attr, int flags)
 {
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct path path;
@@ -328,8 +328,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.
+	 * (However, the rule is not useless if it is there to hold a quiet
+	 * flag)
 	 */
-	if (!path_beneath_attr.allowed_access)
+	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
@@ -344,13 +346,13 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
 	/* Imports the new rule. */
 	err = landlock_append_fs_rule(ruleset, &path,
-				      path_beneath_attr.allowed_access);
+				      path_beneath_attr.allowed_access, flags);
 	path_put(&path);
 	return err;
 }
 
 static int add_rule_net_port(struct landlock_ruleset *ruleset,
-			     const void __user *const rule_attr)
+			     const void __user *const rule_attr, int flags)
 {
 	struct landlock_net_port_attr net_port_attr;
 	int res;
@@ -364,8 +366,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored by network actions.
+	 * (However, the rule is not useless if it is there to hold a quiet
+	 * flag)
 	 */
-	if (!net_port_attr.allowed_access)
+	if (!flags && !net_port_attr.allowed_access)
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
@@ -379,7 +383,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 
 	/* Imports the new rule. */
 	return landlock_append_net_rule(ruleset, net_port_attr.port,
-					net_port_attr.allowed_access);
+					net_port_attr.allowed_access, flags);
 }
 
 /**
@@ -390,7 +394,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -414,6 +418,9 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  *   @rule_attr is not the expected file descriptor type;
  * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
  * - %EFAULT: @rule_attr was not a valid address.
+ *
+ * .. kernel-doc:: include/uapi/linux/landlock.h
+ *     :identifiers: landlock_add_rule_flags
  */
 SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
@@ -424,8 +431,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	/* No flag for now. */
-	if (flags)
+	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
@@ -435,9 +441,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	switch (rule_type) {
 	case LANDLOCK_RULE_PATH_BENEATH:
-		return add_rule_path_beneath(ruleset, rule_attr);
+		return add_rule_path_beneath(ruleset, rule_attr, flags);
 	case LANDLOCK_RULE_NET_PORT:
-		return add_rule_net_port(ruleset, rule_attr);
+		return add_rule_net_port(ruleset, rule_attr, flags);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 7b69002239d7..d07a0bf6927c 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -201,7 +201,7 @@ TEST(add_rule_checks_ordering)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks invalid flags. */
-	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
+	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
-- 
2.51.0


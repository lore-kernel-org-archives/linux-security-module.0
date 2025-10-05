Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301B1534EC
	for <linux-security-module@vger.kernel.org>; Sun,  5 Oct 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686996; cv=none; b=VY2it8OoNqy1/RND8lyMeUNQP/0HsW36BaPpbqDooaCPphO+0mOHzlaOisYjnSnef/PCAVqGjUzNhxAo0f5Z819ZX+rNu92uKvPVLgvP/e7Scm6NndFgIcrq4ac10OeD+Qs7j0K/2K49NTQ1vo0Hys+99uWtjIcUDc/O/JdBflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686996; c=relaxed/simple;
	bh=lLpJeZ1ziGNRnT04ptqowLYvXHMW/kJCehs2aeEQZ+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ2ZLY77JjwIPsSLJG4ZxgmTs04mDQqlIQtG7hleLHB0JcjI1Z3jQO7L85wU/IstHxYJGtdQ61a+AsVAxPsWgGq4uRwqqMNHpfYN9LOUqjyQ6GMed6MFSRI8jORUSGzzvF1IamfzKkRMMzpvD0O3fC1Tqu/TU5BM16AdWdG/QcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=U090sRKx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTyMrR5C; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="U090sRKx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTyMrR5C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DDCC1D00075;
	Sun,  5 Oct 2025 13:56:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Oct 2025 13:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1759686992; x=
	1759773392; bh=Ri3sZ9Qu38tna+JtdtsvUN46anDpCQJXCOOG8tTtOjU=; b=U
	090sRKxkVoNISWMOrcU6oixg8HIi68D73zrIpYLoXdVBcngC4lzYZlFUtSwozGAL
	01nEWAB6wJpd31M84HUTAj0GCMcUs2CxL+/HhBlzKA8I1gu9Lp7vGqWZ+j0EakDF
	4NLpMxU3DhAumfaSrFzDeJCQcS0C+r033qpOkyEGZXW03Bn0R4aySQr3L595U4HL
	/iF3a6x8l39IbmCbaER2XTG5uB3YJq5sd4Ds1U/++wSF2wU0Q+nolyaMgvvewsOD
	jIoLpK/NpgvEKzryNkHJ1TpF4ET0/DAG/ZVechmX7WDsvwH5T1ROHdjFMBKALfCU
	pNGsM55IkAE7PPH/ToGHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759686992; x=1759773392; bh=R
	i3sZ9Qu38tna+JtdtsvUN46anDpCQJXCOOG8tTtOjU=; b=VTyMrR5CMV2ZRHU+Z
	0rQ+uUxFtWSN+p0wna4LDcolfApnyhoxOF/byYQ98YfLNqnLpM6ZKqN0spXoaltr
	/3Efx4jEyl69L8cftT7wgMYGKZRm88H68357HE1CRHYHBzo4C/tFprbGiuWyPF18
	DFBbsCF1hRIjYCynRMDFHgM0C6Bh8WqQ76C6lrLFOIRudcs/Z2Jchsug04yXlXfw
	x7jRWDxOqy0fasXDfHe64a5Q4HSnSjisSqpG1StllSulDS6bJwtJ/HRoapXLeOfA
	TL97Vqggb5vMdO+CgvqjbxkP31zSDXFEe5vhP6t4LzMvbwaLMyCLpGm4CdcwQgxT
	ccAMg==
X-ME-Sender: <xms:ULHiaLGFoXyhw47W8nuUQsyuApGofUo7Au8DRkMCKBOQZ8ruIQooiw>
    <xme:ULHiaPPYOwf2uN38MSKSF15lWt8EqBE9QDq9mBTNkz0iSGB4B6OSrSJbKIb7w5fCq
    as1zzyPoy5tn520asWWyAYhVses25m9uzCzfhD-WYGENz1qgj-R6KM>
X-ME-Received: <xmr:ULHiaFdEfDbV7EGFl9CG4S45NcuMbnkruX0fFdqS3lqg56OT6_b8IlBBEx6cTLU0aJ7FFFKstPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepledufe
    ehffelffeikeekffeihefhgeehveegfeefvdettefhtdffhedtkeeiheffnecuffhomhgr
    ihhnpehquhhivghtpghmrghskhhsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkoh
    gurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhn
    ohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtii
    dprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ULHiaEttJNBRXQrOqW79PF8yG7xwAfetqKVrK8a6AYSogI0G1YkrPA>
    <xmx:ULHiaOmn7VlEVAnUCm7ny1T3bNQcj4xq5d7XgSbsgwJmlR0ZijvxgQ>
    <xmx:ULHiaOwt1KukPMOrdvrTmHtzLJyN3cgzElJ6RbTO6-QvEuXTU-rgrA>
    <xmx:ULHiaIPdYh4T1qQqgmUBrt6lcKKrZ5VYw855JY9KxVOGdVT0hm0Wnw>
    <xmx:ULHiaK0AXryGOPqzeJzWtZ6z4wJZKImo4b_oLJigm1gipIUYiNHJqfhN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 13:56:31 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/6] landlock: Add API support and docs for the quiet flags
Date: Sun,  5 Oct 2025 18:55:25 +0100
Message-ID: <e32cef442528bd99e3348e3149cec71b9e399e8c.1759686613.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759686613.git.m@maowtm.org>
References: <cover.1759686613.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As for kselftests, for now we just change add_rule_checks_ordering to use
a different invalid flag.  I will add tests for the quiet flag in a later
version.

According to pahole, even after adding the struct access_masks quiet_masks
in struct landlock_hierarchy, the u32 log_* bitfield still only has a size
of 2 bytes, so there's minimal wasted space.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes since v1:
- Per suggestion, added support for quieting only certain access bits,
  controlled by extra quiet_access_* fields in the ruleset_attr.
- Added docs for the extra fields and made updates to doc changes in v1.
  In particular, call out that the effect of LANDLOCK_ADD_RULE_QUIET is
  independent from the access bits passed in rule_attr
- landlock_add_rule will return -EINVAL when LANDLOCK_ADD_RULE_QUIET is
  used but the ruleset does not have any quiet access bits set for the
  given rule type.
- ABI version bump to v8
- Syntactic and comment changes per suggestion.

 include/uapi/linux/landlock.h                | 64 +++++++++++++++++
 security/landlock/domain.h                   |  5 ++
 security/landlock/fs.c                       |  4 +-
 security/landlock/fs.h                       |  2 +-
 security/landlock/net.c                      |  5 +-
 security/landlock/net.h                      |  3 +-
 security/landlock/ruleset.c                  | 10 ++-
 security/landlock/ruleset.h                  |  8 ++-
 security/landlock/syscalls.c                 | 72 +++++++++++++++-----
 tools/testing/selftests/landlock/base_test.c |  4 +-
 10 files changed, 150 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..0e8555c1f0d3 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -32,6 +32,19 @@
  * *handle* a wide range or all access rights that they know about at build time
  * (and that they have tested with a kernel that supported them all).
  *
+ * quiet_access_fs and quiet_access_net are bitmasks of actions for which
+ * a denial by this layer will not trigger an audit log if the
+ * corresponding object (or its children, for filesystem rules) is marked
+ * with the "quiet" bit via LANDLOCK_ADD_RULE_QUIET, even if audit logging
+ * would normally take place per landlock_restrict_self() flags.
+ * quiet_scoped is similar, except that it does not require marking any
+ * objects as quiet - if the ruleset is created with any bits set in
+ * quiet_scoped, then denial of such scoped resources will not trigger any
+ * audit log.  These 3 fields are available since Landlock ABI version 8.
+ *
+ * quiet_access_fs, quiet_access_net and quiet_scoped must be a subset of
+ * handled_access_fs, handled_access_net and scoped respectively.
+ *
  * This structure can grow in future Landlock versions.
  */
 struct landlock_ruleset_attr {
@@ -51,6 +64,24 @@ struct landlock_ruleset_attr {
 	 * resources (e.g. IPCs).
 	 */
 	__u64 scoped;
+
+	/* Since ABI 8: */
+
+	/**
+	 * @quiet_access_fs: Bitmask of filesystem actions which should not be
+	 * audit logged if per-object quiet flag is set.
+	 */
+	__u64 quiet_access_fs;
+	/**
+	 * @quiet_access_net: Bitmask of network actions which should not be
+	 * audit logged if per-object quiet flag is set.
+	 */
+	__u64 quiet_access_net;
+	/**
+	 * @quiet_scoped: Bitmask of scoped actions which should not be audit
+	 * logged.
+	 */
+	__u64 quiet_scoped;
 };
 
 /**
@@ -69,6 +100,39 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
+/**
+ * DOC: landlock_add_rule_flags
+ *
+ * **Flags**
+ *
+ * %LANDLOCK_ADD_RULE_QUIET
+ *     Together with the quiet_* fields in struct landlock_ruleset_attr,
+ *     this flag controls whether Landlock will log audit messages when
+ *     access to the objects covered by this rule is denied by this layer.
+ *
+ *     If audit logging is enabled, when Landlock denies an access, it will
+ *     suppress the audit log if all of the following are true:
+ *
+ *     - This layer is the innermost layer that denied the access;
+ *     - The access is part of the quiet_* fields in the initial
+ *       landlock_ruleset_attr;
+ *     - The object (or one of its parents, for filesystem rules) is
+ *       marked as "quiet" via LANDLOCK_ADD_RULE_QUIET.
+ *
+ *     Because logging is only suppressed by a layer if the layer denies
+ *     access, a sandboxed program cannot use this flag to "hide" access
+ *     denials, without denying itself the access in the first place.
+ *
+ *     The effect of this flag does not depend on the value of
+ *     allowed_access in the passed in rule_attr.  When this flag is
+ *     present, the caller is also allowed to pass in an empty
+ *     allowed_access.
+ */
+
+/* clang-format off */
+#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+/* clang-format on */
+
 /**
  * DOC: landlock_restrict_self_flags
  *
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7fb70b25f85a..aadbf53505c0 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -114,6 +114,11 @@ struct landlock_hierarchy {
 		 * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.  Set to false by default.
 		 */
 		log_new_exec : 1;
+	/**
+	 * @quiet_masks: Bitmasks of access that should be quieted (i.e. not
+	 * logged) if the related object is marked as quiet.
+	 */
+	struct access_masks quiet_masks;
 #endif /* CONFIG_AUDIT */
 };
 
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
index 3aa4e33ac95b..5f551a7a7485 100644
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
+			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
+		}
 	} };
 
 	build_check_layer();
@@ -343,6 +348,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 			return -EINVAL;
 
 		layers[0].access = walker_rule->layers[0].access;
+		layers[0].flags = walker_rule->layers[0].flags;
 
 		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
 		if (err)
@@ -573,6 +579,8 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+
 	return no_free_ptr(new_dom);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index eeee287a9508..43d59c7116e5 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -193,6 +193,12 @@ struct landlock_ruleset {
 			 * non-merged ruleset (i.e. not a domain).
 			 */
 			u32 num_layers;
+			/**
+			 * @quiet_masks: Stores the quiet flags for an unmerged
+			 * ruleset.  For a merged domain, this is stored in each
+			 * layer's struct landlock_hierarchy instead.
+			 */
+			struct access_masks quiet_masks;
 			/**
 			 * @access_masks: Contains the subset of filesystem and
 			 * network actions that are restricted by a ruleset.
@@ -223,7 +229,7 @@ DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
-			 const access_mask_t access);
+			 const access_mask_t access, const int flags);
 
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..8288bf914c8b 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -102,8 +102,11 @@ static void build_check_abi(void)
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
 	ruleset_size += sizeof(ruleset_attr.handled_access_net);
 	ruleset_size += sizeof(ruleset_attr.scoped);
+	ruleset_size += sizeof(ruleset_attr.quiet_access_fs);
+	ruleset_size += sizeof(ruleset_attr.quiet_access_net);
+	ruleset_size += sizeof(ruleset_attr.quiet_scoped);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 48);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -161,7 +164,7 @@ static const struct file_operations ruleset_fops = {
  * Documentation/userspace-api/landlock.rst should be updated to reflect the
  * UAPI change.
  */
-const int landlock_abi_version = 7;
+const int landlock_abi_version = 8;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -185,6 +188,8 @@ const int landlock_abi_version = 7;
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
+ * - %EINVAL: quiet_access_fs or quiet_fs_net is not a subset of the
+ *   corresponding handled_access_fs or handled_access_net;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
@@ -241,6 +246,21 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
 		return -EINVAL;
 
+	/*
+	 * Check that quiet masks are subsets of the respective handled masks.
+	 * Because of the checks above this is sufficient to also ensure that
+	 * the quiet masks are valid access masks.
+	 */
+	if ((ruleset_attr.quiet_access_fs | ruleset_attr.handled_access_fs) !=
+	    ruleset_attr.handled_access_fs)
+		return -EINVAL;
+	if ((ruleset_attr.quiet_access_net | ruleset_attr.handled_access_net) !=
+	    ruleset_attr.handled_access_net)
+		return -EINVAL;
+	if ((ruleset_attr.quiet_scoped | ruleset_attr.scoped) !=
+	    ruleset_attr.scoped)
+		return -EINVAL;
+
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
 					  ruleset_attr.handled_access_net,
@@ -248,6 +268,10 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
+	ruleset->quiet_masks.fs = ruleset_attr.quiet_access_fs;
+	ruleset->quiet_masks.net = ruleset_attr.quiet_access_net;
+	ruleset->quiet_masks.scope = ruleset_attr.quiet_scoped;
+
 	/* Creates anonymous FD referring to the ruleset. */
 	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 				      ruleset, O_RDWR | O_CLOEXEC);
@@ -312,7 +336,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 }
 
 static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
-				 const void __user *const rule_attr)
+				 const void __user *const rule_attr, int flags)
 {
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct path path;
@@ -327,9 +351,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
-	 * are ignored in path walks.
+	 * are ignored in path walks.  However, the rule is not useless if it
+	 * is there to hold a quiet flag
 	 */
-	if (!path_beneath_attr.allowed_access)
+	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
@@ -337,6 +362,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
+	/* Check for useless quiet flag */
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.fs)
+		return -EINVAL;
+
 	/* Gets and checks the new rule. */
 	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
 	if (err)
@@ -344,13 +373,13 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
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
@@ -363,9 +392,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
-	 * are ignored by network actions.
+	 * are ignored by network actions.  However, the rule is not useless
+	 * if it is there to hold a quiet flag
 	 */
-	if (!net_port_attr.allowed_access)
+	if (!flags && !net_port_attr.allowed_access)
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
@@ -373,13 +403,17 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	if ((net_port_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
+	/* Check for useless quiet flag */
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
+		return -EINVAL;
+
 	/* Denies inserting a rule with port greater than 65535. */
 	if (net_port_attr.port > U16_MAX)
 		return -EINVAL;
 
 	/* Imports the new rule. */
 	return landlock_append_net_rule(ruleset, net_port_attr.port,
-					net_port_attr.allowed_access);
+					net_port_attr.allowed_access, flags);
 }
 
 /**
@@ -390,7 +424,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -400,20 +434,25 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
  *   supported by the running kernel;
- * - %EINVAL: @flags is not 0;
+ * - %EINVAL: @flags is not valid;
  * - %EINVAL: The rule accesses are inconsistent (i.e.
  *   &landlock_path_beneath_attr.allowed_access or
  *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
  *   handled accesses)
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
+ * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
+ *   quiet access bits set for the corresponding rule type.
  * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
- *   0);
+ *   0) and no flags;
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
  *   @rule_attr is not the expected file descriptor type;
  * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
  * - %EFAULT: @rule_attr was not a valid address.
+ *
+ * .. kernel-doc:: include/uapi/linux/landlock.h
+ *     :identifiers: landlock_add_rule_flags
  */
 SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
@@ -424,8 +463,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	/* No flag for now. */
-	if (flags)
+	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
@@ -435,9 +473,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
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
index 7b69002239d7..b34b340c52a5 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
@@ -201,7 +201,7 @@ TEST(add_rule_checks_ordering)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks invalid flags. */
-	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
+	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
-- 
2.51.0

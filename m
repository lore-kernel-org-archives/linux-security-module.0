Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238D149C6F
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511536; cv=none; b=raaK/jf9mjrzFf6QsnFiLDKcwMq4tT+qedX6yMoa+y6XyvE4rLD+BA3lGJI2UZ3Ke/Ftm5bYaxkrmElbknRAyTShJGwDtFb1nJwb7S+jxzsjA5Zo2ALqrEtmVAvO9mbefsKuIikZuraV14sko1EA/SY4Ca0tCLhr0UcOc+B7w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511536; c=relaxed/simple;
	bh=h78mR4jnJyM6xKkgaeUAR7fNRGHdGxcnQcn18M0ABnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7wzX1qn5eFkDGUNRvVHXdFMhlr3pkUwmeOdaquCMuhN9ABl2B7yPSS3c3dgx5iKZJb9RZoEhTkgLnObyQvIEa1ac7BsPjKFdF4kN7gRhmM11dB3MwEV21SaCKJ9D3Gp1YlV+LkICw7P0m8Hs3/jGUoB3rMJ/taModTT3WPum6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Kr4UYa/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNR+u4nR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Kr4UYa/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNR+u4nR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 51DBBEC027F;
	Sun, 26 Oct 2025 16:45:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 26 Oct 2025 16:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761511533;
	 x=1761597933; bh=Y87gjDxOdU6a18w5vpwdyPPVzxI+bZY9rfaauJLCZkI=; b=
	Kr4UYa/cEQL7zX4VSYq7k0TxY+2ih1NWJI5gZH3fNy+D5Jg4+A6j3PTjlaeWFKQ7
	WX3aIXPyrSWCHVuyJUWsrAvVNywqeqVs9IKsDhJavN3IoNJIZjkgDnd9c41bZxyC
	BusXGgR7ygz08xoEH30iq7WNekdLYwSIhARQKlmAfrxwmZN7jh4Qi2nCJJPAnK/z
	cGY0QnbdVn//k5GRK6fd86vzuvA9lYQHXUYgSB6Dc/lhLTnIXmS/ubBgC6P9YJJ6
	cBF/JBkDVPPa/0thUVVZ1IiY5GSgVnwwrWSiKeoacXlbJOLKuqToSkNyuPTOYdjg
	oNc4Myn8wQrt4U25Cd9liQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761511533; x=
	1761597933; bh=Y87gjDxOdU6a18w5vpwdyPPVzxI+bZY9rfaauJLCZkI=; b=M
	NR+u4nR1vN9NfxVYzdMu1NRq+2s6UQmVq3GOP2mYVyjxjFSHasS0yL9sW5TSNiQJ
	dgef0LDcI+RH+Kzs+IvpsigNfhLsZUl3YF6ASFwO197D6jG1M0X/wvLWx/MCS4cx
	TuNnHoCuaAyrpSerluRKTGxACGGykK1p6U4hU8yb5b36Ibe6tUhimqAnNl+pylEx
	sxyk3r/SKfnwIFGiOtG0EAvOgtz4S0+iG+TxQmFK5KOSi/rNHD6JGGXuwd3Cwlhd
	ayJmwFPJ/e5IfDatwSOm45BSIJb8R8P4NkP8GJcWzewuk+bvm/bJ1BeM2UBg/GgF
	k1HPm5CT2WIgiheAidZNA==
X-ME-Sender: <xms:bIj-aOGZ-90te00IvCLt2CrvahchcyWr5ag02pmjvJ0UyzP9LhKljg>
    <xme:bIj-aDDsPYG6rbvsptqikQimOwlTjrQRFBwFb48kar1Ke4QkEp_nOP10EcrTEgU2M
    m0biC5NTfD9cYXUSGjnYOi8ZbGxFx1sdovjTkhv0VgvmcN4PZLt2OV_>
X-ME-Received: <xmr:bIj-aB8LlE4ws0iGO008-2CwmSi5HJaIef9wMAkTnXt6QGbWl8i1Usstrh3_r6mDc_Scf6SfJ_jkWq-lRnydLl-Ncmx4namaZjdGwUgFRmRlJokWeXQ4DKgpBK46pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ehveeitddvkedtgffhhfeugfdufeeigeekfeelleetfeffudduuddttefgtdeinecuffho
    mhgrihhnpehquhhivghtpghmrghskhhsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgih
    hkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohep
    ghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:bIj-aPAFiH2k1S9ju1b0Z6JeCDI176h6820_Q0C18CfUKC6vyXfGpA>
    <xmx:bIj-aGT29aegzys0DFvSO7n7FDHlLjBoyvm5A6kV0OQQrWYfJmNBcA>
    <xmx:bIj-aGvfd-pk6rRHT5NR6cW3N6SwN0Vfh_4ZMb5hqZenaQ1TxppWEA>
    <xmx:bIj-aC25cFYDIfRkkojoKELGYxbEiyX7v3TnjLkBrobq-IZH40adfQ>
    <xmx:bYj-aBOTWI_Bc_9bkjzlaWdVzez6RY0NFWoYNxycqRJy5omqbj2O8y_g>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:31 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 2/8] landlock: Add API support and docs for the quiet flags
Date: Sun, 26 Oct 2025 20:44:17 +0000
Message-ID: <2794ddec86d8f24bdfe8a4b3adae18a5f0c41494.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As for kselftests, for now we just change add_rule_checks_ordering to use
a different invalid flag.  I will add tests for the quiet flag in a later
version.

According to pahole, even after adding the struct access_masks quiet_masks
in struct landlock_hierarchy, the u32 log_* bitfield still only has a size
of 2 bytes, so there's minimal wasted space.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes since v2:
- Updated docs from Mickaël's suggestions.

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
index f030adc462ee..50f0806b7e33 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -32,6 +32,19 @@
  * *handle* a wide range or all access rights that they know about at build time
  * (and that they have tested with a kernel that supported them all).
  *
+ * @quiet_access_fs and @quiet_access_net are bitmasks of actions for
+ * which a denial by this layer will not trigger an audit log if the
+ * corresponding object (or its children, for filesystem rules) is marked
+ * with the "quiet" bit via %LANDLOCK_ADD_RULE_QUIET, even if logging
+ * would normally take place per landlock_restrict_self() flags.
+ * quiet_scoped is similar, except that it does not require marking any
+ * objects as quiet - if the ruleset is created with any bits set in
+ * quiet_scoped, then denial of such scoped resources will not trigger any
+ * log.  These 3 fields are available since Landlock ABI version 8.
+ *
+ * @quiet_access_fs, @quiet_access_net and @quiet_scoped must be a subset
+ * of @handled_access_fs, @handled_access_net and @scoped respectively.
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
+ *     - All requested accesses are part of the quiet_* fields in the
+ *       related struct landlock_ruleset_attr;
+ *     - The object (or one of its parents, for filesystem rules) is
+ *       marked as "quiet" via %LANDLOCK_ADD_RULE_QUIET.
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
index 721cd63a4de8..13195b6ffed7 100644
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
index 81cdf87d1c79..e0bb7e795574 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
 
 #include "access.h"
 #include "audit.h"
@@ -255,6 +256,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
 				return -EINVAL;
 			this->layers[0].access |= (*layers)[0].access;
+			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
 			return 0;
 		}
 
@@ -305,12 +307,15 @@ static void build_check_layer(void)
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
@@ -351,6 +356,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 			return -EINVAL;
 
 		layers[0].access = walker_rule->layers[0].access;
+		layers[0].flags = walker_rule->layers[0].flags;
 
 		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
 		if (err)
@@ -581,6 +587,8 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+
 	return no_free_ptr(new_dom);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 9790c60c0c00..57fa2e18a483 100644
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
index 0116e9f93ffe..93396bfc1500 100644
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
 
+	/* Check for useless quiet flag. */
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
 
+	/* Check for useless quiet flag. */
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
2.51.1

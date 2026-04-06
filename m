Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134B2D47E9
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490814; cv=none; b=dOH/s3fCpLHjzj252PIs7PQM1Ev7Ppd61YFycrvrmdmuOWKQGB1uOTkF2gYRkfG6f3WFOm2foy26tsDnirvGnfjBMgcXOl3SMcU7pG+URNHuygixeDHQJKKJL0aQvQP3POoOIvxqWTJ2mRMz9DTM4IGfUrytDvDBzscxVs6FMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490814; c=relaxed/simple;
	bh=dw+9WhvxLgbnRlCAUfsSPxf2rXBl7tSNRzHyhoHAHhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLMReVJiwcKFFvXFhEjP4r6kapndAavNL2SapeI7lVDsBtzI13hvLrbJoXPMQppyPANAl4fcxHyD+FHoOW0DfOzujtmVoP3vY0nOpu8FjdVJqiqU4eCEY9paFP6LgRoT5nzePOdTmiTTL8SoiCxoxPhhd6g17ZPwIKcTgz5whgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Yr0b/fko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p70J474S; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Yr0b/fko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p70J474S"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A18651D0002E;
	Mon,  6 Apr 2026 11:53:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 11:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775490811;
	 x=1775577211; bh=Lp+Sdn013kfxEh/2YHaOxw2aV+dSFl7cQRQKtM49Dvs=; b=
	Yr0b/fko99JokamguNFHPNx1uKPP6TK2KHKT1Vs+lBnAjEDRFVPq7XiXD2/Oupam
	3mFnCG6hXmCtRCkcrvunqSVqG2TXhltPkWwtBVPLLsOdWeeUWvIRg3tpggLpRb2E
	brpBiN7Z7NXRjQJWKbQNbazee8dnr1LY52hKhPpEl3PNaQYU4sFUDzlCCgqUFwnQ
	3ivWPa79VaJopH8uV/pXH97McTWMgxOd8Mgh8mlgxe0fitKTCAyixPRl/C8LFVeo
	90QPU//Fj60yeWwEhTf7pkiQFnkzSYyQimsKKzoLOSVM4NaSUwmERttMrl3perj2
	PPcX96WD9RLzxZLKh6YYtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775490811; x=
	1775577211; bh=Lp+Sdn013kfxEh/2YHaOxw2aV+dSFl7cQRQKtM49Dvs=; b=p
	70J474SUb0XWK7P/GghN0GWr9AYhc0JgW+47uQpxZ+J+n5OGrZ2Enum0oivR2Nip
	35+LNX2H8iJru1ZF21aeUjogiKBq7Vkw/qp1sShTnsPCAiizrSodqSh3cGtpF+sE
	pkP9WP602IBSNlLUWFMbEoRDMjqQ6ycQuLA4Hs255EC6icA9h/6o9EnTYsLSoV6E
	EiFQZcvOu3tBgOc4oPFskX7w6eMT0y08usZBT0cXiwp+YdWsiDEKp+uyC61fd31M
	Q73j1lFtSi9VQUcKK7qVsuNtOPBSEu632otEXUe2eV1cNVC2ycJlgkFqsC4SM9mU
	kXUEdOALZLYmvDx1S22WA==
X-ME-Sender: <xms:-9bTac5xkzemzU-OCdlkr7KGjs3QqVMDqjeuPEGsWJTsWAxAX1ZA1Q>
    <xme:-9bTaQKNvK5NpJfysCn44n5vCZdCI8ppses-BvnERAyU2dtoder53q9D6-BJe79Xw
    CFTGLs2RegA4cFJhkPpTCfxobaqL07gE3p7_7BD6Avfpf-PUvtsiyg>
X-ME-Received: <xmr:-9bTaduxE3IxsOE0JYsycMycYdT2zqgR13Tpaxy1l5jVeh5qarNputDhn_F29Sd9P3BLDbF1xdeO8KD2sHn7Zgmm0S5KqAKTPy8UpYiF1mtRJQwYnTzNuJlzDhJVPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpefhhe
    eviedtvdektdfghffhuefgudefieegkeefleelteefffduuddutdetgfdtieenucffohhm
    rghinhepqhhuihgvthgpmhgrshhkshdrnhgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhopehuthhilhhithihvg
    hmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgii
    pdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:-9bTaXLqwLId7Mit_-qWxcwUQ4ZOm019D5Vw7gEBHPufdVE_LwHMwg>
    <xmx:-9bTae8Sk7MHmmSeo2CYuVIihvkmCjS_MsLaeNUBu_b5ZXiS4P1J8Q>
    <xmx:-9bTaYwpQ6Esmg_x4DNJlC7b3k1CzIonQ1hflHE_-H9h4FXEVlmW0Q>
    <xmx:-9bTaT7U1imt8CMwf0Sq4KaXoNJiOsxXlwdn-AWZWmjLcbho9m2U0w>
    <xmx:-9bTaZ2xmFhhGkQlRELwC7piH9821u-Fr-5y74duB_4LUuYh3qsx3xQo>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:53:30 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 2/9] landlock: Add API support and docs for the quiet flags
Date: Mon,  6 Apr 2026 16:52:15 +0100
Message-ID: <b4d25793959493f0a8ef66f03feedac1a15e7595.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775490344.git.m@maowtm.org>
References: <cover.1775490344.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds the UAPI for the quiet flags feature (but not the implementation
yet).

According to pahole, even after adding the struct access_masks quiet_masks
in struct landlock_hierarchy, the u32 log_* bitfield still only has a size
of 2 bytes, so there's minimal wasted space.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v8:
- The new Landlock ABI version is now v10 as a result of rebase.
- Allocate a rule_flags in hook_unix_find() and pass to
  is_access_to_paths_allowed().

Changes in v6:
- Fix typo in doc

Changes in v5:
- Doc fixes.
- Fix build failure without CONFIG_AUDIT / CONFIG_INET (reported by Justin
  Suess)

Changes in v4:
- Minor update to this commit message.
- Fix minor formatting

Changes in v3:
- Updated docs from Mickaël's suggestions.

Changes in v2:
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
 security/landlock/fs.c                       | 11 +--
 security/landlock/fs.h                       |  2 +-
 security/landlock/net.c                      |  5 +-
 security/landlock/net.h                      |  5 +-
 security/landlock/ruleset.c                  | 12 +++-
 security/landlock/ruleset.h                  | 12 +++-
 security/landlock/syscalls.c                 | 72 +++++++++++++++-----
 tools/testing/selftests/landlock/base_test.c |  6 +-
 10 files changed, 160 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 10a346e55e95..9a41c65623a1 100644
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
+ * log.  These 3 fields are available since Landlock ABI version 10.
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
+	/* Since ABI 10: */
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
+ *     - this layer is the innermost layer that denied the access;
+ *     - all accesses denied by this layer are part of the quiet_* fields
+ *       in the related struct landlock_ruleset_attr;
+ *     - the object (or one of its parents, for filesystem rules) is
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
index a9d57db0120d..9b8aeac8ebd2 100644
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
index 6f63e0182ef0..06a8d2258558 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -325,7 +325,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
  */
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
-			    access_mask_t access_rights)
+			    access_mask_t access_rights, const int flags)
 {
 	int err;
 	struct landlock_id id = {
@@ -346,7 +346,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
@@ -1662,6 +1662,7 @@ static int hook_unix_find(const struct path *const path, struct sock *other,
 	static const struct access_masks fs_resolve_unix = {
 		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
 	};
+	struct collected_rule_flags rule_flags = {};
 
 	/* Lookup for the purpose of saving coredumps is OK. */
 	if (unlikely(flags & SOCK_COREDUMP))
@@ -1700,9 +1701,9 @@ static int hook_unix_find(const struct path *const path, struct sock *other,
 	unix_state_unlock(other);
 
 	/* Checks the connections to allow-listed paths. */
-	if (is_access_to_paths_allowed(subject->domain, path,
-				       fs_resolve_unix.fs, &layer_masks,
-				       &request, NULL, 0, NULL, NULL, NULL))
+	if (is_access_to_paths_allowed(
+		    subject->domain, path, fs_resolve_unix.fs, &layer_masks,
+		    &rule_flags, &request, NULL, 0, NULL, NULL, NULL, NULL))
 		return 0;
 
 	landlock_log_denial(subject, &request);
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
index dc82ce4a2bd4..ade2b1750042 100644
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
index 09960c237a13..72c47f4d6803 100644
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
@@ -24,7 +25,7 @@ static inline void landlock_add_net_hooks(void)
 
 static inline int
 landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
-			 access_mask_t access_rights)
+			 access_mask_t access_rights, const int flags)
 {
 	return -EAFNOSUPPORT;
 }
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e4e6b730b581..d2d1e3fb6cf2 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
 
 #include "access.h"
 #include "domain.h"
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
+		},
 	} };
 
 	build_check_layer();
@@ -351,6 +356,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 			return -EINVAL;
 
 		layers[0].access = walker_rule->layers[0].access;
+		layers[0].flags = walker_rule->layers[0].flags;
 
 		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
 		if (err)
@@ -581,6 +587,10 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+#ifdef CONFIG_AUDIT
+	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+#endif /* CONFIG_AUDIT */
+
 	return no_free_ptr(new_dom);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 3b31552f0c95..e369f15ae885 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -172,8 +172,8 @@ struct landlock_ruleset {
 		 * @work_free: Enables to free a ruleset within a lockless
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
-		 * The fields @lock, @usage, @num_rules, @num_layers and
-		 * @access_masks are then unused.
+		 * The fields @lock, @usage, @num_rules, @num_layers, @quiet_masks
+		 * and @access_masks are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -199,6 +199,12 @@ struct landlock_ruleset {
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
@@ -229,7 +235,7 @@ DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
-			 const access_mask_t access);
+			 const access_mask_t access, const int flags);
 
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index accfd2e5a0cd..a71068c41f76 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -105,8 +105,11 @@ static void build_check_abi(void)
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
@@ -166,7 +169,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 9;
+const int landlock_abi_version = 10;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -193,6 +196,8 @@ const int landlock_abi_version = 9;
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small
  *   @size;
+ * - %EINVAL: quiet_access_fs or quiet_access_net is not a subset of the
+ *   corresponding handled_access_fs or handled_access_net;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
@@ -249,6 +254,21 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
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
@@ -256,6 +276,10 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
+	ruleset->quiet_masks.fs = ruleset_attr.quiet_access_fs;
+	ruleset->quiet_masks.net = ruleset_attr.quiet_access_net;
+	ruleset->quiet_masks.scope = ruleset_attr.quiet_scoped;
+
 	/* Creates anonymous FD referring to the ruleset. */
 	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 				      ruleset, O_RDWR | O_CLOEXEC);
@@ -320,7 +344,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 }
 
 static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
-				 const void __user *const rule_attr)
+				 const void __user *const rule_attr, int flags)
 {
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct path path;
@@ -335,9 +359,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
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
@@ -345,6 +370,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
+	/* Check for useless quiet flag. */
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.fs)
+		return -EINVAL;
+
 	/* Gets and checks the new rule. */
 	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
 	if (err)
@@ -352,13 +381,13 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
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
@@ -371,9 +400,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 
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
@@ -381,13 +411,17 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
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
@@ -398,7 +432,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -408,20 +442,25 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
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
@@ -432,8 +471,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	/* No flag for now. */
-	if (flags)
+	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
@@ -443,9 +481,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
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
index 30d37234086c..84e91fcaa1b2 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,8 +76,8 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
-					     LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
@@ -201,7 +201,7 @@ TEST(add_rule_checks_ordering)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks invalid flags. */
-	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
+	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
-- 
2.53.0

Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047873CAA52
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082475; cv=none; b=o4RefeIlJUz8YAflYCtfclMoV0Cv48QeBIEclUUnvW2jKrIjfri8f/LGgrXpK8WYrjHtijBaH3f+Bb6WksjC/XyX74LVJQ/CzvLle1rfvceIk1gM4DIrjq/14gvJrMLV1JMMQ61rfQP7chsGGwuVWWWlxof9DJuvO8D2OJyCyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082475; c=relaxed/simple;
	bh=/fG2yc2KSQgpDOA1APuADRQtCm266Fqg1b7RhGq4xys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7BJfazzi0jSWvZod9d/ze88pAolfHCzAKjxD9O5C86EnC71+hRy+9sOgYJxCfVQ+V6QB940qpdRil0qQ83J5L7l4KDsD0T1FG5GYPiCAXJuMx6swR7Y1p2yMzdeJ69EwW1BU3CCgYH6jbc6ZNqds0e1cbo33h3yPtzxlbFyywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NwsCMTOS; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NwsCMTOS"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rcr1F3dzf35;
	Sun, 26 Jul 2026 18:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082459;
	bh=RSMKogOTy87m1Iz1Xox2IubVelwEMc4C4YPwdcd2428=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwsCMTOSzYW6Cksxi+QkaZiOO4o9RuXy4kFSl5xKDUWr7u1MrdahRSS9OGU9TV94S
	 HOeV1fKm6dibh8atVqQ4mrlb10KZ4IawdXKh5vfkxuLm+R7OvjlWpwLLEZ2ClRade9
	 ZOOwLop4p1xDKZQsTKS4i4+2UXi2Zr2CyQjSQ3Zo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rcq1BNfzRdC;
	Sun, 26 Jul 2026 18:14:19 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 05/12] landlock: Wrap per-layer access masks in struct layer_config
Date: Sun, 26 Jul 2026 18:13:50 +0200
Message-ID: <20260726161400.3010511-6-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The per-layer FAM in struct landlock_ruleset currently stores struct
access_masks directly, but upcoming permission features (capability and
namespace restrictions) need additional per-layer data beyond the
handled-access bitfields.

Introduce struct layer_config as a wrapper around struct access_masks
and rename the FAM from access_masks[] to layers[].  This makes room for
future per-layer fields (e.g. allowed bitmasks) without modifying struct
access_masks itself, which is also used as a lightweight parameter type
for functions that only need the handled-access bitfields.

No functional change.

Cc: Günther Noack <gnoack@google.com>
Reviewed-by: Günther Noack <gnoack@google.com>
Reviewed-by: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260527181127.879771-4-mic@digikod.net
- The rebase required adopting the released check-time struct
  layer_masks and the new per-ruleset quiet_access (added by the base's
  merged quiet feature) and updating the struct landlock_ruleset @layers
  kdoc; struct layer_config already existed in v2.

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-5-mic@digikod.net
- Add Reviewed-by: Tingmao Wang.
- Address Günther Noack's review nits:
  - Clarify that _LANDLOCK_ACCESS_FS_INITIALLY_DENIED is ORed with
    the .handled field of all ruleset->layers[] entries (not the
    entries themselves).
  - Rename landlock_upgrade_handled_access_masks() to
    landlock_upgrade_handled_layer_config() to match the parameter
    type.
  - Rewrap the @layers kdoc in struct landlock_ruleset.
- Rename struct layer_rights to struct layer_config: "config" is
  the more general term for per-layer state.
- Add Reviewed-by: Günther Noack.
---
 security/landlock/access.h   | 32 ++++++++++++++++++++---------
 security/landlock/cred.h     |  2 +-
 security/landlock/ruleset.c  | 16 +++++++--------
 security/landlock/ruleset.h  | 39 ++++++++++++++++++------------------
 security/landlock/syscalls.c |  2 +-
 5 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index d926078bf0a5..b4f79508729e 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -19,9 +19,9 @@
 
 /*
  * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
- * entries when we need to get the absolute handled access masks, see
- * landlock_upgrade_handled_access_masks().
+ * by a ruleset/layer.  This must be ORed with the .handled field of all
+ * ruleset->layers[] entries when we need to get the absolute handled access
+ * masks, see landlock_upgrade_handled_layer_config().
  */
 /* clang-format off */
 #define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
@@ -45,7 +45,7 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
-/* Ruleset access masks. */
+/* Handled access masks (bitfields only). */
 struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
@@ -61,6 +61,20 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+/**
+ * struct layer_config - Per-layer access configuration
+ *
+ * Wraps the per-layer handled-access bitfields.  This is the element type of
+ * the &struct landlock_ruleset.layers FAM.
+ */
+struct layer_config {
+	/**
+	 * @handled: Bitmask of access rights handled (i.e. restricted) by this
+	 * layer.
+	 */
+	struct access_masks handled;
+};
+
 /**
  * struct layer_mask - The access rights and rule flags for a layer.
  *
@@ -123,17 +137,17 @@ static_assert(BITS_PER_TYPE(deny_masks_t) >=
 static_assert(HWEIGHT(LANDLOCK_MAX_NUM_LAYERS) == 1);
 
 /* Upgrades with all initially denied by default access rights. */
-static inline struct access_masks
-landlock_upgrade_handled_access_masks(struct access_masks access_masks)
+static inline struct layer_config
+landlock_upgrade_handled_layer_config(struct layer_config layer_config)
 {
 	/*
 	 * All access rights that are denied by default whether they are
 	 * explicitly handled or not.
 	 */
-	if (access_masks.fs)
-		access_masks.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	if (layer_config.handled.fs)
+		layer_config.handled.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 
-	return access_masks;
+	return layer_config;
 }
 
 /* Checks the subset relation between access masks. */
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index f287c56b5fd4..3e2a7e88710e 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -139,7 +139,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	for (layer_level = domain->num_layers - 1; layer_level >= 0;
 	     layer_level--) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->layers[layer_level].handled,
 		};
 
 		if (layer.all & masks_all.all) {
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 6bccba2ec1ac..af08a8cc705c 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -33,7 +33,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
+	new_ruleset = kzalloc_flex(*new_ruleset, layers, num_layers,
 				   GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
@@ -47,9 +47,9 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 
 	new_ruleset->num_layers = num_layers;
 	/*
-	 * hierarchy = NULL
-	 * num_rules = 0
-	 * access_masks[] = 0
+	 * - hierarchy = NULL
+	 * - num_rules = 0
+	 * - layers[] = 0
 	 */
 	return new_ruleset;
 }
@@ -387,8 +387,8 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	dst->access_masks[dst->num_layers - 1] =
-		landlock_upgrade_handled_access_masks(src->access_masks[0]);
+	dst->layers[dst->num_layers - 1] =
+		landlock_upgrade_handled_layer_config(src->layers[0]);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
@@ -470,8 +470,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		goto out_unlock;
 	}
 	/* Copies the parent layer stack and leaves a space for the new layer. */
-	memcpy(child->access_masks, parent->access_masks,
-	       flex_array_size(parent, access_masks, parent->num_layers));
+	memcpy(child->layers, parent->layers,
+	       flex_array_size(parent, layers, parent->num_layers));
 
 	if (WARN_ON_ONCE(!parent->hierarchy)) {
 		err = -EINVAL;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index f1fdad1d528e..2a825b1f08b9 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -157,7 +157,7 @@ struct landlock_ruleset {
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
 		 * The fields @lock, @usage, @num_rules, @num_layers,
-		 * @quiet_access and @access_masks are then unused.
+		 * @quiet_access and @layers are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -190,18 +190,16 @@ struct landlock_ruleset {
 			 */
 			struct access_masks quiet_access;
 			/**
-			 * @access_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a ruleset.
-			 * A domain saves all layers of merged rulesets in a
-			 * stack (FAM), starting from the first layer to the
-			 * last one.  These layers are used when merging
-			 * rulesets, for user space backward compatibility
-			 * (i.e. future-proof), and to properly handle merged
-			 * rulesets without overlapping access rights.  These
-			 * layers are set once and never changed for the
-			 * lifetime of the ruleset.
+			 * @layers: Per-layer access configuration.  A domain
+			 * saves all layers of merged rulesets in a stack (FAM),
+			 * starting from the first layer to the last one.  These
+			 * layers are used when merging rulesets, for user space
+			 * backward compatibility (i.e. future-proof), and to
+			 * properly handle merged rulesets without overlapping
+			 * access rights.  These layers are set once and never
+			 * changed for the lifetime of the ruleset.
 			 */
-			struct access_masks access_masks[];
+			struct layer_config layers[] __counted_by(num_layers);
 		};
 	};
 };
@@ -241,7 +239,8 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
  *
  * @domain: Landlock ruleset (used as a domain)
  *
- * Return: An access_masks result of the OR of all the domain's access masks.
+ * Return: An access_masks result of the OR of all the domain's handled access
+ * masks.
  */
 static inline struct access_masks
 landlock_union_access_masks(const struct landlock_ruleset *const domain)
@@ -251,7 +250,7 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
 
 	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->layers[layer_level].handled,
 		};
 
 		matches.all |= layer.all;
@@ -269,7 +268,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(fs_access_mask != fs_mask);
-	ruleset->access_masks[layer_level].fs |= fs_mask;
+	ruleset->layers[layer_level].handled.fs |= fs_mask;
 }
 
 static inline void
@@ -281,7 +280,7 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(net_access_mask != net_mask);
-	ruleset->access_masks[layer_level].net |= net_mask;
+	ruleset->layers[layer_level].handled.net |= net_mask;
 }
 
 static inline void
@@ -292,7 +291,7 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(scope_mask != mask);
-	ruleset->access_masks[layer_level].scope |= mask;
+	ruleset->layers[layer_level].handled.scope |= mask;
 }
 
 static inline access_mask_t
@@ -300,7 +299,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
 			    const u16 layer_level)
 {
 	/* Handles all initially denied by default access rights. */
-	return ruleset->access_masks[layer_level].fs |
+	return ruleset->layers[layer_level].handled.fs |
 	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
@@ -308,14 +307,14 @@ static inline access_mask_t
 landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
 			     const u16 layer_level)
 {
-	return ruleset->access_masks[layer_level].net;
+	return ruleset->layers[layer_level].handled.net;
 }
 
 static inline access_mask_t
 landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 			const u16 layer_level)
 {
-	return ruleset->access_masks[layer_level].scope;
+	return ruleset->layers[layer_level].handled.scope;
 }
 
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 66a852e5aaf0..1924c703c280 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -367,7 +367,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->access_masks[0].fs;
+	mask = ruleset->layers[0].handled.fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
-- 
2.54.0


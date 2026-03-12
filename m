Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705F3B5302
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310445; cv=none; b=SIEoFurewQ+oItMk2tmWszTvYNLgij3siiDYCsoq+mT90WTLZveSVu4iEDfG+hZFA47QB4Qkr7+IpnG/c7fUG0F87r6C+MIB9n2ydjs1QjcFyJBYl4Jr1Zr2cTDZn+gzqZfRPG0Tta5RvYWwanl2p9TYznRapJctSTY0l/ddOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310445; c=relaxed/simple;
	bh=WSGfULoaaoh9SZWdXCHWXj3qpO9/VQrgb53l57qTdDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LL+hwyzoL375RgOxYLOaEdZnLWD+jSY91cPT2K0dn8XMM1dYxR9MQudz1VkwldbPinXhmCZ227Fekl3Nti0w/3Y94eH3gZDrHjfwxdtSwc6oZ20HgchXyIdeJZHwHxbVxotu8OGVjalcZVzgxW0gFJfMG5XkOr9r09Pe8WM+rtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fJlIkmir; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fJlIkmir"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsj5pJ7z197m;
	Thu, 12 Mar 2026 11:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309913;
	bh=MgD9cfGoZ73o8ZH114oUHG3bIOLlZf431npXrrlq/MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJlIkmirbI4pSu1aHf1X7zpIeN5ohdOHZ8C1Z79bBgqoBPhUT2eF7YqyqcRZg0o1f
	 /gWeXtV3DsqI0thrq6IWcM1uOiudprIOAUuizN5aAsHiukklokPd98MhUo9lv5HHFs
	 HVpxr418GVCgUxoI4bd5Ohx325oxGIYsOECEvDGw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjsj15Grz8Qc;
	Thu, 12 Mar 2026 11:05:13 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
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
Subject: [RFC PATCH v1 04/11] landlock: Wrap per-layer access masks in struct layer_rights
Date: Thu, 12 Mar 2026 11:04:37 +0100
Message-ID: <20260312100444.2609563-5-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
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
access_masks directly, but upcoming permission features (capability
and namespace restrictions) need additional per-layer data beyond the
handled-access bitfields.

Introduce struct layer_rights as a wrapper around struct access_masks
and rename the FAM from access_masks[] to layers[].  This makes room
for future per-layer fields (e.g. allowed bitmasks) without modifying
struct access_masks itself, which is also used as a lightweight
parameter type for functions that only need the handled-access
bitfields.

No functional change.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/access.h   | 29 ++++++++++++++++++++++-------
 security/landlock/cred.h     |  2 +-
 security/landlock/ruleset.c  | 12 ++++++------
 security/landlock/ruleset.h  | 28 +++++++++++++++-------------
 security/landlock/syscalls.c |  2 +-
 5 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 42c95747d7bd..b3e147771a0e 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -19,7 +19,7 @@
 
 /*
  * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
+ * by a ruleset/layer.  This must be ORed with all ruleset->layers[]
  * entries when we need to get the absolute handled access masks, see
  * landlock_upgrade_handled_access_masks().
  */
@@ -45,7 +45,7 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
-/* Ruleset access masks. */
+/* Handled access masks (bitfields only). */
 struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
@@ -61,6 +61,21 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+/**
+ * struct layer_rights - Per-layer access configuration
+ *
+ * Wraps the handled-access bitfields together with any additional per-layer
+ * data (e.g. allowed bitmasks added by future patches).  This is the element
+ * type of the &struct landlock_ruleset.layers FAM.
+ */
+struct layer_rights {
+	/**
+	 * @handled: Bitmask of access rights handled (i.e. restricted) by
+	 * this layer.
+	 */
+	struct access_masks handled;
+};
+
 /**
  * struct layer_access_masks - A boolean matrix of layers and access rights
  *
@@ -100,17 +115,17 @@ static_assert(BITS_PER_TYPE(deny_masks_t) >=
 static_assert(HWEIGHT(LANDLOCK_MAX_NUM_LAYERS) == 1);
 
 /* Upgrades with all initially denied by default access rights. */
-static inline struct access_masks
-landlock_upgrade_handled_access_masks(struct access_masks access_masks)
+static inline struct layer_rights
+landlock_upgrade_handled_access_masks(struct layer_rights layer_rights)
 {
 	/*
 	 * All access rights that are denied by default whether they are
 	 * explicitly handled or not.
 	 */
-	if (access_masks.fs)
-		access_masks.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	if (layer_rights.handled.fs)
+		layer_rights.handled.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 
-	return access_masks;
+	return layer_rights;
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
index 181df7736bb9..a7f8be37ec31 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -32,7 +32,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
 	struct landlock_ruleset *new_ruleset;
 
-	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
+	new_ruleset = kzalloc_flex(*new_ruleset, layers, num_layers,
 				   GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
@@ -48,7 +48,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 	/*
 	 * hierarchy = NULL
 	 * num_rules = 0
-	 * access_masks[] = 0
+	 * layers[] = 0
 	 */
 	return new_ruleset;
 }
@@ -381,8 +381,8 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	dst->access_masks[dst->num_layers - 1] =
-		landlock_upgrade_handled_access_masks(src->access_masks[0]);
+	dst->layers[dst->num_layers - 1] =
+		landlock_upgrade_handled_access_masks(src->layers[0]);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
@@ -464,8 +464,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
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
index 889f4b30301a..900c47eb0216 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -146,7 +146,7 @@ struct landlock_ruleset {
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
 		 * The fields @lock, @usage, @num_rules, @num_layers and
-		 * @access_masks are then unused.
+		 * @layers are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -173,9 +173,10 @@ struct landlock_ruleset {
 			 */
 			u32 num_layers;
 			/**
-			 * @access_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a ruleset.
-			 * A domain saves all layers of merged rulesets in a
+			 * @layers: Per-layer access configuration, including
+			 * handled access masks and allowed permission
+			 * bitmasks.  A domain saves all layers of merged
+			 * rulesets in a
 			 * stack (FAM), starting from the first layer to the
 			 * last one.  These layers are used when merging
 			 * rulesets, for user space backward compatibility
@@ -184,7 +185,7 @@ struct landlock_ruleset {
 			 * layers are set once and never changed for the
 			 * lifetime of the ruleset.
 			 */
-			struct access_masks access_masks[];
+			struct layer_rights layers[] __counted_by(num_layers);
 		};
 	};
 };
@@ -224,7 +225,8 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
  *
  * @domain: Landlock ruleset (used as a domain)
  *
- * Return: An access_masks result of the OR of all the domain's access masks.
+ * Return: An access_masks result of the OR of all the domain's handled access
+ * masks.
  */
 static inline struct access_masks
 landlock_union_access_masks(const struct landlock_ruleset *const domain)
@@ -234,7 +236,7 @@ landlock_union_access_masks(const struct landlock_ruleset *const domain)
 
 	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
 		union access_masks_all layer = {
-			.masks = domain->access_masks[layer_level],
+			.masks = domain->layers[layer_level].handled,
 		};
 
 		matches.all |= layer.all;
@@ -252,7 +254,7 @@ landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(fs_access_mask != fs_mask);
-	ruleset->access_masks[layer_level].fs |= fs_mask;
+	ruleset->layers[layer_level].handled.fs |= fs_mask;
 }
 
 static inline void
@@ -264,7 +266,7 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(net_access_mask != net_mask);
-	ruleset->access_masks[layer_level].net |= net_mask;
+	ruleset->layers[layer_level].handled.net |= net_mask;
 }
 
 static inline void
@@ -275,7 +277,7 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
 
 	/* Should already be checked in sys_landlock_create_ruleset(). */
 	WARN_ON_ONCE(scope_mask != mask);
-	ruleset->access_masks[layer_level].scope |= mask;
+	ruleset->layers[layer_level].handled.scope |= mask;
 }
 
 static inline access_mask_t
@@ -283,7 +285,7 @@ landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
 			    const u16 layer_level)
 {
 	/* Handles all initially denied by default access rights. */
-	return ruleset->access_masks[layer_level].fs |
+	return ruleset->layers[layer_level].handled.fs |
 	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
@@ -291,14 +293,14 @@ static inline access_mask_t
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
index 3b33839b80c7..2aa7b50d875f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -341,7 +341,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->access_masks[0].fs;
+	mask = ruleset->layers[0].handled.fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
-- 
2.53.0


Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70287376A01
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367407; cv=none; b=J/FkbWZ4gBwBwAdYCFIf5XnifP/NPQb/0xnppLk9MI6sSMtj8xdNLRngGWUqJYWz1vJ2cnh9ZmdwdpEzfBQkSXBUw/yO+iF5j0i7e9WJKo1ue0gNEuvPJDbcjqfL0JWPRjagSXHBMC/bSOi3j9IAv+rq27mUwHvyQzHGeyqtKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367407; c=relaxed/simple;
	bh=zCjB6i4qzcZ+hkV1T7x4qvN37ipXvLga/yEEzhmGylc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBIxT5OGmi4auQwR1hq9q4+RXHI6P+2YnHABtQZL8x+FtQQFsCLlo6zS2aNlZxl8tQZIugxXztmJ1S3e5sdbomm1DcuCehqemDfwwfxmW2x/W1OdcSh/wM1EVrGj1DvOLiyw6ZJ/cMjN1vKpxoP/T+86T5MZmv8/nQVAP3GU2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oxXzlVYU; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oxXzlVYU"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j07wn0sJvzbSY;
	Wed,  7 Oct 2026 12:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791367384;
	bh=K3LBFVDiwrqweSoL3BT7bDuegaFZzJdPyE+R1Vju3+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxXzlVYUvX9P6ggd4HTJpUEIol+mtkYnsqJcZ/73nRvlXKVcSApnZmHlQkKGkomys
	 jqMFk3Q0q/Aci+3Olghe8kAFU58odUwUvBsLcjldcFBABgXeFdIOOtX+0b0PTBAegl
	 MVMJHn1kKADhuoeYDjO9ZGyjSPSBXhJCYXj8QcJo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j07wl4xMXzglV;
	Wed,  7 Oct 2026 12:03:03 +0200 (CEST)
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
Subject: [PATCH v5 2/8] landlock: Wrap per-layer access masks in struct layer_config
Date: Wed,  7 Oct 2026 12:02:45 +0200
Message-ID: <20261007100255.1333386-3-mic@digikod.net>
In-Reply-To: <20261007100255.1333386-1-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The domain layer FAM stores struct access_masks values directly, while a
ruleset stores the equivalent single mutable value.  Per-category
permissions need additional per-layer data beyond the handled-access
bitfields.

Introduce struct layer_config as the common value type.  Keeping the
handled bitfields in its .handled member leaves struct access_masks as a
lightweight parameter type for functions that only need those bitfields,
while the complete layer can be snapshotted with one assignment.

At this point struct layer_config only wraps the four-byte access_masks,
so it does not grow the per-domain allocation: the maximum 16-entry FAM
remains 64 bytes.

No functional change.

Cc: Günther Noack <gnoack@google.com>
Reviewed-by: Günther Noack <gnoack@google.com>
Reviewed-by: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-6-mic@digikod.net
- Adapt the wrapper to the ruleset/domain split by using one
  layer_config value for the ruleset singleton and the domain FAM.
- Generalize the struct access_masks comment because the type also
  represents quiet and request masks.

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
 include/trace/events/landlock.h |  6 +++---
 security/landlock/access.h      | 32 +++++++++++++++++++++++---------
 security/landlock/cred.h        |  2 +-
 security/landlock/domain.c      | 10 +++++-----
 security/landlock/domain.h      | 30 ++++++++++++++----------------
 security/landlock/fs.c          |  2 +-
 security/landlock/net.c         |  2 +-
 security/landlock/ruleset.c     |  6 +++---
 security/landlock/ruleset.h     |  5 ++---
 security/landlock/syscalls.c    |  4 ++--
 10 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 3a43638c9bc2..215d08c1e03d 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -353,9 +353,9 @@ TRACE_EVENT(landlock_create_ruleset,
 	TP_fast_assign(
 		__entry->ruleset_id	= ruleset->id;
 		__entry->ruleset_version = ruleset->version;
-		__entry->handled_fs	= ruleset->handled_masks.fs;
-		__entry->handled_net	= ruleset->handled_masks.net;
-		__entry->scoped		= ruleset->handled_masks.scope;
+		__entry->handled_fs	= ruleset->layer.handled.fs;
+		__entry->handled_net	= ruleset->layer.handled.net;
+		__entry->scoped		= ruleset->layer.handled.scope;
 	),
 
 	TP_printk("ruleset=%llx.%llu handled_fs=%s handled_net=%s scoped=%s",
diff --git a/security/landlock/access.h b/security/landlock/access.h
index f843835851d0..1b1dede27925 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -19,9 +19,9 @@
 
 /*
  * All access rights that are denied by default whether they are handled or not
- * by a ruleset/layer.  This must be ORed with all domain->handled_masks[]
- * entries when we need to get the absolute handled access masks, see
- * landlock_upgrade_handled_access_masks().
+ * by a ruleset/layer.  This must be ORed with the .handled field of all
+ * domain->layers[] entries when we need to get the absolute handled access
+ * masks, see landlock_upgrade_handled_layer_config().
  */
 /* clang-format off */
 #define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
@@ -45,7 +45,7 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
-/* Ruleset access masks. */
+/* Access masks (bitfields only). */
 struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
@@ -61,6 +61,20 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+/**
+ * struct layer_config - Per-layer access configuration
+ *
+ * A ruleset stores one mutable layer and a domain stores a flexible array of
+ * immutable layers.
+ */
+struct layer_config {
+	/**
+	 * @handled: Bitmask of access rights handled (i.e. restricted) by this
+	 * layer.
+	 */
+	struct access_masks handled;
+};
+
 #define _LANDLOCK_LAYER_MASK_PADDING                              \
 	(BITS_PER_TYPE(access_mask_t) - LANDLOCK_NUM_ACCESS_MAX - \
 	 IS_ENABLED(CONFIG_SECURITY_LANDLOCK_LOG))
@@ -131,17 +145,17 @@ static_assert(BITS_PER_TYPE(deny_masks_t) >=
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
index a5ff9957949a..1c6a4838f38b 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -138,7 +138,7 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	for (layer_level = domain->num_layers - 1; layer_level >= 0;
 	     layer_level--) {
 		union access_masks_all layer = {
-			.masks = domain->handled_masks[layer_level],
+			.masks = domain->layers[layer_level].handled,
 		};
 
 		if (layer.all & masks_all.all) {
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index c66663f8cd8b..636abcd75aff 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -50,7 +50,7 @@ static struct landlock_domain *create_domain(const u32 num_layers)
 	struct landlock_domain *new_domain;
 
 	build_check_domain();
-	new_domain = kzalloc_flex(*new_domain, handled_masks, num_layers,
+	new_domain = kzalloc_flex(*new_domain, layers, num_layers,
 				  GFP_KERNEL_ACCOUNT);
 	if (!new_domain)
 		return ERR_PTR(-ENOMEM);
@@ -328,8 +328,8 @@ static int merge_ruleset(struct landlock_domain *const dst,
 	if (WARN_ON_ONCE(dst->num_layers < 1))
 		return -EINVAL;
 
-	dst->handled_masks[dst->num_layers - 1] =
-		landlock_upgrade_handled_access_masks(src->handled_masks);
+	dst->layers[dst->num_layers - 1] =
+		landlock_upgrade_handled_layer_config(src->layer);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
@@ -404,8 +404,8 @@ static int inherit_ruleset(struct landlock_domain *const parent,
 	/*
 	 * Copies the parent layer stack and leaves a space for the new layer.
 	 */
-	memcpy(child->handled_masks, parent->handled_masks,
-	       flex_array_size(parent, handled_masks, parent->num_layers));
+	memcpy(child->layers, parent->layers,
+	       flex_array_size(parent, layers, parent->num_layers));
 
 	if (WARN_ON_ONCE(!parent->hierarchy))
 		return -EINVAL;
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 03f24382537c..bdec27c3bc7f 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -217,7 +217,7 @@ struct landlock_domain {
 		 * @work_free: Enables to free a domain within a lockless
 		 * section.  This is only used by landlock_put_domain_deferred()
 		 * when @usage reaches zero.  The fields @usage, @num_layers and
-		 * @handled_masks are then unused.
+		 * @layers are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -233,18 +233,16 @@ struct landlock_domain {
 			 */
 			u32 num_layers;
 			/**
-			 * @handled_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a domain.  A
-			 * domain saves all layers of merged rulesets in a stack
-			 * (FAM), starting from the first layer to the last one.
-			 * These layers are used when merging rulesets, for user
-			 * space backward compatibility (i.e. future-proof), and
-			 * to properly handle merged rulesets without
-			 * overlapping access rights.  These layers are set once
-			 * and never changed for the lifetime of the domain.
+			 * @layers: Per-layer access configuration.  A domain
+			 * saves all layers of merged rulesets in a stack (FAM),
+			 * starting from the first layer to the last one.  These
+			 * layers are used when merging rulesets, for user space
+			 * backward compatibility (i.e. future-proof), and to
+			 * properly handle merged rulesets without overlapping
+			 * access rights.  These layers are set once and never
+			 * changed for the lifetime of the domain.
 			 */
-			struct access_masks
-				handled_masks[] __counted_by(num_layers);
+			struct layer_config layers[] __counted_by(num_layers);
 		};
 	};
 };
@@ -254,7 +252,7 @@ landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
 	/* Handles all initially denied by default access rights. */
-	return domain->handled_masks[layer_level].fs |
+	return domain->layers[layer_level].handled.fs |
 	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
@@ -262,14 +260,14 @@ static inline access_mask_t
 landlock_get_net_access_mask(const struct landlock_domain *const domain,
 			     const u16 layer_level)
 {
-	return domain->handled_masks[layer_level].net;
+	return domain->layers[layer_level].handled.net;
 }
 
 static inline access_mask_t
 landlock_get_scope_mask(const struct landlock_domain *const domain,
 			const u16 layer_level)
 {
-	return domain->handled_masks[layer_level].scope;
+	return domain->layers[layer_level].handled.scope;
 }
 
 /**
@@ -288,7 +286,7 @@ landlock_union_access_masks(const struct landlock_domain *const domain)
 
 	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
 		union access_masks_all layer = {
-			.masks = domain->handled_masks[layer_level],
+			.masks = domain->layers[layer_level].handled,
 		};
 
 		matches.all |= layer.all;
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index cab43892ec2f..a8fa8f77e775 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -342,7 +342,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 	/* Transforms relative access rights to absolute ones. */
 	access_rights |= LANDLOCK_MASK_ACCESS_FS &
-			 ~(ruleset->handled_masks.fs |
+			 ~(ruleset->layer.handled.fs |
 			   _LANDLOCK_ACCESS_FS_INITIALLY_DENIED);
 	id.key.object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 6fe0dbde3b78..8fd73cf4bd15 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -35,7 +35,7 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
 	/* Transforms relative access rights to absolute ones. */
-	access_rights |= LANDLOCK_MASK_ACCESS_NET & ~ruleset->handled_masks.net;
+	access_rights |= LANDLOCK_MASK_ACCESS_NET & ~ruleset->layer.handled.net;
 
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a5d135d085cb..edf9396deac6 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -64,20 +64,20 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 					   LANDLOCK_MASK_ACCESS_FS;
 
 		WARN_ON_ONCE(fs_access_mask != mask);
-		new_ruleset->handled_masks.fs |= mask;
+		new_ruleset->layer.handled.fs |= mask;
 	}
 	if (net_access_mask) {
 		const access_mask_t mask = net_access_mask &
 					   LANDLOCK_MASK_ACCESS_NET;
 
 		WARN_ON_ONCE(net_access_mask != mask);
-		new_ruleset->handled_masks.net |= mask;
+		new_ruleset->layer.handled.net |= mask;
 	}
 	if (scope_mask) {
 		const access_mask_t mask = scope_mask & LANDLOCK_MASK_SCOPE;
 
 		WARN_ON_ONCE(scope_mask != mask);
-		new_ruleset->handled_masks.scope |= mask;
+		new_ruleset->layer.handled.scope |= mask;
 	}
 	return new_ruleset;
 }
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 8ebdd4fa098f..424055a7af86 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -188,10 +188,9 @@ struct landlock_ruleset {
 	 */
 	struct access_masks quiet_access;
 	/**
-	 * @handled_masks: Contains the subset of filesystem and network actions
-	 * that are handled by this ruleset.
+	 * @layer: Access configuration for this ruleset's single mutable layer.
 	 */
-	struct access_masks handled_masks;
+	struct layer_config layer;
 };
 
 struct landlock_ruleset *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 17d8e9b7b0c6..ec616d198184 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -377,7 +377,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->handled_masks.fs;
+	mask = ruleset->layer.handled.fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
@@ -418,7 +418,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = ruleset->handled_masks.net;
+	mask = ruleset->layer.handled.net;
 	if ((net_port_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
-- 
2.55.0


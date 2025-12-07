Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60461FE451
	for <linux-security-module@vger.kernel.org>; Sun,  7 Dec 2025 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765072321; cv=none; b=JsQordh1wWZ4B//qvUNJBJWYvNrHUmNAh7yCkTimZOcJtExPt9FY1OeOQ5Tbk7MHCpCJYTLgufhVVpSDC5i10in7hQGZdyvh5xfRx8PAAwP82E8CTDapNuvUE7Sa28CRxniPYDA7c8hVpAywnz43m8RP2Hh/tMuvnind7KdmsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765072321; c=relaxed/simple;
	bh=sd9wFI0y0PUG7enXjpzN/NRouZ+Xcp5yzmDQDdToTVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjcA0LKyZDVMHB7PSOIsQIMrRjZnA4bZmgX4LYuniMZ/ZN2GW2orKO9Tdl2iq0eSLkcd0yV5fa3+u1+mZGxBL53hYld35VCGoujagAkjKdlsEExYJneHAAfr0Hjawa7fe/jxD5cMVSAVdYCH9j5HPnE4VjeHwjQE+sfayCN1p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaH/Z6XU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaH/Z6XU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7815092cd0bso28819037b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 17:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765072318; x=1765677118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx9Hcv1zGeaDTK1SN1vUpL695a0AdFpsQRJeh9pwiwE=;
        b=FaH/Z6XURSjBjfDfz3bgz34fjdLpNfYGHAaBmDamA4RSpYPfv3l0Td/0Up3iXHvkoY
         Q3bfmGfMNit8NkqaedL+SiGKCCuedYmo/HJXCDzBP8D4BNC83UYtPyLAfrPTZN+UBDSz
         PXWMJUR9nZsir9xtEaXPvgMVq+y0HzIK0XrStITs1zp0+paKXgcJDkiNEfl0MN7i8/we
         QRFlVo8TWls5tSYqDddcyBI+G0ACwXg0eMq+IbmpnbAQk5k5u5CFX8WRNF6SlaGtz/pK
         Ku8tHx1Zknya+kcQmhul5nLeuiehUt9B7Dt0IeD7P9uexFkoEPXwEJkEDUTgWoyEhPOr
         +DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765072318; x=1765677118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bx9Hcv1zGeaDTK1SN1vUpL695a0AdFpsQRJeh9pwiwE=;
        b=Ix0GtKWprKkJvSQZMRYlBA6aPDXKu1qh3JzrIKTvcWO2NVSy0I318TxXSu4ju/wBx9
         t3AUfjHhYa48c7xQkQ7lO75iVM4M3qRsCfpDctAAICkUGtb2utS2FQcaoRuyFNC8GhiW
         JNCYS6HqKVf6a2x4l25qlK82kCwOctW7kfe+wo8A2gQ1ZuXfNCW87f0vbKAf3AadHNkH
         OKJlvBZ7PeSqZL6pISr6XW64QTubaIFWoCMThdvb/IvoylhjKZrkB0305kjRUwbqmPAq
         Qenp8IZX4wxf01YfNpDRbwZXcT8WwRMR89V7ty/VVNLY/JgG2nDqAMvKUM8z9wpAleMB
         Omag==
X-Forwarded-Encrypted: i=1; AJvYcCXQf+GbjEIdFtchKzNOerlUy0ACwXjtkQ0c8L9PoaIePWoOPrGqygjeZrW87ysH6Yls/hxF/NYUXByrsgpzDhwaKyWNcDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/NwdL2ALZs0U7Zt3iL4ZaszaTurJalu+60+F3yZVZ6G+V/Jo
	npvvAU6CNxQxtigaWEaUp+Efh0kfHQjRFRg0W+Pzixf22n6urwjHrm7Q
X-Gm-Gg: ASbGncv/mHB3G/OOXpZweNIRz/+2jUNGpasfgVT0R5lkVYs1wj62aAKy1JNVsMWXaxv
	UPdJmk8+nRLMvMArSDUSag2U/7+GUGm72Ak9K/gRHurHZeCeVIC5hSkm1vL3rdFJ4NgUX+o7GV6
	XafwL1Qr4WIZyL1cCF06s2l5K9M5FWn9J2Oc4PRwb0aX6unojmZwEVXmglLymAKFfzXBVA3kQV1
	pF+Am7t40N/TroA6Jwh9Qj/45PwaKf6RX8w7FPmo+PCRIFKmKw1bFoPJS9tqSEi+XyNmJ/groWK
	nwmV7x7QWoviP+ANFVEyqVKKfrhUAK58uufKkLRKHpZVE0uk3I+PNTpUbGHAnG7aBCYKGcyIaL/
	LYyAFDk3Rs6lqcgZeZEOr03O5gNtkEmvQV+TfYUSsD4RUFTXoF4+d55Sv1mph2ygbvIfSmxpE66
	dtjtvZh/IPys+YA59cCiaPiqdE/aCREnMis0xowpcBCvT6KAgzXB7p8Cb4raIv
X-Google-Smtp-Source: AGHT+IFIbPuUFDSVgy74EJ9EmMoHFrgKB7LkDmeJx9siH5fIdtc1MzVqFwOP1sTBNZovYj3cTFR5VQ==
X-Received: by 2002:a05:690c:6d01:b0:786:9322:e3fa with SMTP id 00721157ae682-78c33cbc494mr67316717b3.68.1765072317583;
        Sat, 06 Dec 2025 17:51:57 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm33158417b3.3.2025.12.06.17.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 17:51:56 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 1/5] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat,  6 Dec 2025 20:51:27 -0500
Message-ID: <20251207015132.800576-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207015132.800576-1-utilityemal77@gmail.com>
References: <20251207015132.800576-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements a flag to prevent access grant inheritance within the filesystem
hierarchy for landlock rules.

If a landlock rule on an inode has this flag, any access grants on parent
inodes will be ignored. Moreover, operations that involve altering the
ancestors of the subject with LANDLOCK_ADD_RULE_NO_INHERIT will be
denied up to the VFS root (new in v4).

For example, if /a/b/c/ = read only + LANDLOCK_ADD_RULE_NO_INHERIT and
/ = read write, writes to files in /a/b/c will be denied. Moreover,
moving /a to /bad, removing /a/b/c, or creating links to /a will be
prohibited.

Parent flag inheritance is automatically suppressed by the permission
harvesting logic, which will finish processing early if all relevant
layers are tagged with NO_INHERIT.

And if / has LANDLOCK_ADD_RULE_QUIET, /a/b/c will still audit (handled)
accesses. This is because LANDLOCK_ADD_RULE_NO_INHERIT also
suppresses flag inheritance from parent objects.

The parent directory restrictions mitigate sandbox-restart attacks. For
example, if a sandboxed program is able to move a
LANDLOCK_ADD_RULE_NO_INHERIT restricted directory, upon sandbox restart,
the policy applied naively on the same filenames would be invalid.
Preventing these operations mitigates these attacks.

v3..v4 changes:

  * Rebased on v6 of Tingmao Wang's "quiet flag" series.
  * Removed unnecessary mask_no_inherit_descendant_layers and related
    code at Tingmao Wang's suggestion, simplifying patch.
  * Updated to use new disconnected directory handling.
  * Improved WARN_ON_ONCE usage. (Thanks Tingmao Wang!)
  * Removed redundant loop for single-layer rulesets (again thanks Tingmao
    Wang!)
  * Protections now apply up to the VFS root, not just the mountpoint.
  * Indentation fixes.
  * Removed redundant flag marker blocked_flag_masks.

v2..v3 changes:

  * Parent directory topology protections now work by lazily
    inserting blank rules on parent inodes if they do not
    exist. This replaces the previous xarray implementation
    with simplified logic.
  * Added an optimization to skip further processing if all layers
    collected have no inherit.
  * Added support to block flag inheritance.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c      | 389 +++++++++++++++++++++++++++++++++++-
 security/landlock/ruleset.c |  19 +-
 security/landlock/ruleset.h |  29 ++-
 3 files changed, 433 insertions(+), 4 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0b589263ea42..7b0b77859778 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -317,6 +317,207 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
+static const struct landlock_rule *find_rule(const struct landlock_ruleset *const domain,
+					     const struct dentry *const dentry);
+
+/**
+ * landlock_domain_layers_mask - Build a mask covering all layers of a domain
+ * @domain: The ruleset (domain) to inspect.
+ *
+ * Return a layer mask with a 1 bit for each existing layer of @domain.
+ * If @domain has no layers 0 is returned.  If the number of layers is
+ * greater than or equal to the number of bits in layer_mask_t, all bits
+ * are set.
+ */
+static layer_mask_t landlock_domain_layers_mask(const struct landlock_ruleset
+						*const domain)
+{
+	if (!domain || !domain->num_layers)
+		return 0;
+
+	if (domain->num_layers >= sizeof(layer_mask_t) * BITS_PER_BYTE)
+		return (layer_mask_t)~0ULL;
+
+	return GENMASK_ULL(domain->num_layers - 1, 0);
+}
+
+/**
+ * rule_blocks_all_layers_no_inherit - check whether a rule disables inheritance
+ * @domain_layers_mask: Mask describing the domain's active layers.
+ * @rule: Rule to inspect.
+ *
+ * Return true if every layer present in @rule has its no_inherit flag set
+ * and the set of layers covered by the rule equals @domain_layers_mask.
+ * This indicates that the rule prevents inheritance on all layers of the
+ * domain and thus further walking for inheritance checks can stop.
+ */
+static bool rule_blocks_all_layers_no_inherit(const layer_mask_t domain_layers_mask,
+					      const struct landlock_rule *const rule)
+{
+	layer_mask_t rule_layers = 0;
+	u32 layer_index;
+
+	if (!domain_layers_mask || !rule)
+		return false;
+
+	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
+		const struct landlock_layer *const layer =
+			&rule->layers[layer_index];
+		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
+
+		if (!layer->flags.no_inherit)
+			return false;
+
+		rule_layers |= layer_bit;
+	}
+
+	return rule_layers && rule_layers == domain_layers_mask;
+}
+
+/**
+ * ensure_rule_for_dentry - ensure a ruleset contains a rule entry for dentry,
+ * inserting a blank rule if needed.
+ * @ruleset: Ruleset to modify/inspect.  Caller must hold @ruleset->lock.
+ * @dentry: Dentry to ensure a rule exists for.
+ *
+ * If no rule is currently associated with @dentry, insert an empty rule
+ * (with zero access) tied to the backing inode.  Returns a pointer to the
+ * rule associated with @dentry on success, NULL when @dentry is negative, or
+ * an ERR_PTR()-encoded error if the rule cannot be created.
+ *
+ * This is useful for LANDLOCK_ADD_RULE_NO_INHERIT processing, where a rule
+ * may need to be created for an ancestor dentry that does not yet have one
+ * to properly track no_inherit flags.
+ *
+ * The flags are set to zero if a rule is newly created, and the caller
+ * is responsible for setting them appropriately.
+ *
+ * The returned rule pointer's lifetime is tied to @ruleset.
+ */
+static const struct landlock_rule *
+ensure_rule_for_dentry(struct landlock_ruleset *const ruleset,
+		       struct dentry *const dentry)
+{
+	struct landlock_id id = {
+		.type = LANDLOCK_KEY_INODE,
+	};
+	const struct landlock_rule *rule;
+	int err;
+
+	if (WARN_ON_ONCE(!ruleset || !dentry || d_is_negative(dentry)))
+		return NULL;
+
+	lockdep_assert_held(&ruleset->lock);
+
+	rule = find_rule(ruleset, dentry);
+	if (rule)
+		return rule;
+
+	id.key.object = get_inode_object(d_backing_inode(dentry));
+	if (IS_ERR(id.key.object))
+		return ERR_CAST(id.key.object);
+
+	err = landlock_insert_rule(ruleset, id, 0, 0);
+	landlock_put_object(id.key.object);
+	if (err)
+		return ERR_PTR(err);
+
+	rule = find_rule(ruleset, dentry);
+	if (WARN_ON_ONCE(!rule))
+		return ERR_PTR(-ENOENT);
+	return rule;
+}
+
+/**
+ * mark_no_inherit_ancestors - mark ancestors as having no_inherit descendants
+ * @ruleset: Ruleset to modify.  Caller must hold @ruleset->lock.
+ * @path: Path representing the descendant that carries no_inherit bits.
+ * @descendant_layers: Mask of layers from the descendant that should be
+ *                     advertised to ancestors via has_no_inherit_descendant.
+ *
+ * Walks upward from @dentry and ensures that any ancestor rule contains the
+ * has_no_inherit_descendant marker for the specified @descendant_layers so
+ * parent lookups can quickly detect descendant no_inherit influence.
+ *
+ * Returns 0 on success or a negative errno if ancestor bookkeeping fails.
+ */
+static int mark_no_inherit_ancestors(struct landlock_ruleset *ruleset,
+				     const struct path *const path,
+				     layer_mask_t descendant_layers)
+{
+	struct dentry *cursor;
+	struct path walk_path;
+	int err = 0;
+
+	if (WARN_ON_ONCE(!ruleset || !path || !path->dentry || !path->mnt ||
+			 !descendant_layers))
+		return -EINVAL;
+
+	lockdep_assert_held(&ruleset->lock);
+
+	walk_path.mnt = path->mnt;
+	walk_path.dentry = path->dentry;
+	path_get(&walk_path);
+
+	cursor = dget(walk_path.dentry);
+	while (cursor) {
+		struct dentry *parent;
+		const struct landlock_rule *rule;
+
+		/* Follow mounts all the way up to the root. */
+		if (IS_ROOT(cursor)) {
+			dput(cursor);
+			if (!follow_up(&walk_path)) {
+				cursor = NULL;
+				continue;
+			}
+			cursor = dget(walk_path.dentry);
+		}
+
+		parent = dget_parent(cursor);
+		dput(cursor);
+		if (!parent)
+			break;
+
+		if (WARN_ON_ONCE(d_is_negative(parent))) {
+			dput(parent);
+			break;
+		}
+		/*
+		 * Ensures a rule exists for the parent dentry,
+		 * inserting a blank one if needed.
+		 */
+		rule = ensure_rule_for_dentry(ruleset, parent);
+		if (IS_ERR(rule)) {
+			err = PTR_ERR(rule);
+			dput(parent);
+			cursor = NULL;
+			break;
+		}
+		if (rule) {
+			struct landlock_rule *mutable_rule =
+				(struct landlock_rule *)rule;
+			/*
+			 * Unmerged rulesets should only have one layer.
+			 */
+			if (WARN_ON_ONCE(mutable_rule->num_layers != 1)) {
+				dput(parent);
+				err = -EINVAL;
+				cursor = NULL;
+				break;
+			}
+
+			if (descendant_layers & BIT_ULL(0))
+				mutable_rule->layers[0]
+					.flags.has_no_inherit_descendant = true;
+		}
+
+		cursor = parent;
+	}
+	path_put(&walk_path);
+	return err;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -344,13 +545,40 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	if (!err && (flags & LANDLOCK_ADD_RULE_NO_INHERIT)) {
+		const struct landlock_rule *rule;
+		layer_mask_t descendant_layers = 0;
+
+		rule = find_rule(ruleset, path->dentry);
+		/*
+		 * This was already checked at function entry.
+		 */
+		if (WARN_ON_ONCE(!rule || rule->num_layers != 1))
+			goto out_unlock;
+
+		if (rule->layers[0].flags.no_inherit ||
+		    rule->layers[0].flags.has_no_inherit_descendant)
+			descendant_layers = BIT_ULL(0);
+
+		if (descendant_layers) {
+			err = mark_no_inherit_ancestors(ruleset, path,
+							descendant_layers);
+			if (err)
+				goto out_unlock;
+		}
+	}
 	mutex_unlock(&ruleset->lock);
+out:
 	/*
 	 * No need to check for an error because landlock_insert_rule()
 	 * increments the refcount for the new object if needed.
 	 */
 	landlock_put_object(id.key.object);
 	return err;
+
+out_unlock:
+	mutex_unlock(&ruleset->lock);
+	goto out;
 }
 
 /* Access-control management */
@@ -764,6 +992,8 @@ static bool is_access_to_paths_allowed(
 	struct landlock_request *const log_request_parent2,
 	struct dentry *const dentry_child2)
 {
+	const layer_mask_t domain_layers_mask =
+		landlock_domain_layers_mask(domain);
 	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
 	     child1_is_directory = true, child2_is_directory = true;
 	struct path walker_path;
@@ -906,6 +1136,10 @@ static bool is_access_to_paths_allowed(
 					       ARRAY_SIZE(*layer_masks_parent2),
 					       rule_flags_parent2);
 
+		if (rule &&
+		    rule_blocks_all_layers_no_inherit(domain_layers_mask, rule))
+			break;
+
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
@@ -1064,7 +1298,9 @@ static bool collect_domain_accesses(
 	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
 	struct collected_rule_flags *const rule_flags)
 {
-	unsigned long access_dom;
+	access_mask_t access_dom;
+	const layer_mask_t domain_layers_mask =
+		landlock_domain_layers_mask(domain);
 	bool ret = false;
 
 	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
@@ -1080,9 +1316,11 @@ static bool collect_domain_accesses(
 	while (true) {
 		struct dentry *parent_dentry;
 
+		const struct landlock_rule *rule = find_rule(domain, dir);
+
 		/* Gets all layers allowing all domain accesses. */
 		if (landlock_unmask_layers(
-			    find_rule(domain, dir), access_dom, layer_masks_dom,
+			    rule, access_dom, layer_masks_dom,
 			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
@@ -1092,6 +1330,10 @@ static bool collect_domain_accesses(
 			break;
 		}
 
+		if (rule &&
+		    rule_blocks_all_layers_no_inherit(domain_layers_mask, rule))
+			break;
+
 		/*
 		 * Stops at the mount point or the filesystem root for a disconnected
 		 * directory.
@@ -1107,6 +1349,120 @@ static bool collect_domain_accesses(
 	return ret;
 }
 
+/**
+ * collect_topology_sealed_layers - collect layers sealed against topology changes
+ * @domain: Ruleset to consult.
+ * @dentry: Starting dentry for the upward walk.
+ * @override_layers: Optional out parameter filled with layers that are
+ *                   present on ancestors but considered overrides (not
+ *                   sealing the topology for descendants).
+ *
+ * Walk upwards from @dentry and return a mask of layers where either the
+ * visited dentry contains a no_inherit rule or ancestors were previously
+ * marked as having a descendant with no_inherit.  @override_layers, if not
+ * NULL, is filled with layers that would normally be overridden by more
+ * specific descendant rules.
+ *
+ * Returns a layer mask where set bits indicate layers that are "sealed"
+ * (topology changes like rename/rmdir are denied) for the subtree rooted at
+ * @dentry.
+ *
+ * Useful for LANDLOCK_ADD_RULE_NO_INHERIT parent directory enforcement to ensure
+ * that topology changes do not violate the no_inherit constraints.
+ */
+static layer_mask_t
+collect_topology_sealed_layers(const struct landlock_ruleset *const domain,
+			       struct dentry *dentry,
+			       layer_mask_t *const override_layers)
+{
+	struct dentry *cursor, *parent;
+	bool include_descendants = true;
+	layer_mask_t sealed_layers = 0;
+
+	if (override_layers)
+		*override_layers = 0;
+
+	if (WARN_ON_ONCE(!domain || !dentry || d_is_negative(dentry)))
+		return 0;
+
+	cursor = dget(dentry);
+	while (cursor) {
+		const struct landlock_rule *rule;
+		u32 layer_index;
+
+		rule = find_rule(domain, cursor);
+		if (rule) {
+			for (layer_index = 0; layer_index < rule->num_layers;
+			     layer_index++) {
+				const struct landlock_layer *layer =
+					&rule->layers[layer_index];
+				layer_mask_t layer_bit =
+					BIT_ULL(layer->level - 1);
+
+				if (include_descendants &&
+				    (layer->flags.no_inherit ||
+				     layer->flags.has_no_inherit_descendant)) {
+					sealed_layers |= layer_bit;
+				} else if (override_layers) {
+					*override_layers |= layer_bit;
+				}
+			}
+		}
+
+		if (sealed_layers || IS_ROOT(cursor))
+			break;
+
+		parent = dget_parent(cursor);
+		dput(cursor);
+		if (!parent)
+			return sealed_layers;
+
+		cursor = parent;
+		include_descendants = false;
+	}
+	dput(cursor);
+	return sealed_layers;
+}
+
+/**
+ * deny_no_inherit_topology_change - deny topology changes on sealed layers
+ * @subject: Subject performing the operation (contains the domain).
+ * @dentry: Dentry that is the target of the topology modification.
+ *
+ * Checks whether any domain layers are sealed against topology changes at
+ * @dentry (via collect_topology_sealed_layers).  If so, emit an audit record
+ * and return -EACCES.  Otherwise return 0.
+ */
+static int deny_no_inherit_topology_change(const struct landlock_cred_security
+					   *subject,
+					   struct dentry *dentry)
+{
+	layer_mask_t sealed_layers;
+	layer_mask_t override_layers;
+	unsigned long layer_index;
+
+	if (WARN_ON_ONCE(!subject || !dentry || d_is_negative(dentry)))
+		return 0;
+	sealed_layers = collect_topology_sealed_layers(subject->domain,
+						       dentry, &override_layers);
+	sealed_layers &= ~override_layers;
+
+	if (!sealed_layers)
+		return 0;
+
+	layer_index = __ffs((unsigned long)sealed_layers);
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dentry,
+		},
+		.layer_plus_one = layer_index + 1,
+	});
+
+	return -EACCES;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1191,6 +1547,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
+		int err;
+
+		err = deny_no_inherit_topology_change(subject, old_dentry);
+		if (err)
+			return err;
+		if (exchange) {
+			err = deny_no_inherit_topology_change(subject, new_dentry);
+			if (err)
+				return err;
+		}
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
 	}
@@ -1583,12 +1949,31 @@ static int hook_path_symlink(const struct path *const dir,
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+	int err;
+
+	if (subject) {
+		err = deny_no_inherit_topology_change(subject, dentry);
+		if (err)
+			return err;
+	}
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
 }
 
 static int hook_path_rmdir(const struct path *const dir,
 			   struct dentry *const dentry)
 {
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+	int err;
+
+	if (subject) {
+		err = deny_no_inherit_topology_change(subject, dentry);
+		if (err)
+			return err;
+	}
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 750a444e1983..9152a939d79a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -255,8 +255,13 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 				return -EINVAL;
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
 				return -EINVAL;
+			/* Merge the flags into the rules */
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
+			this->layers[0].flags.no_inherit |=
+				(*layers)[0].flags.no_inherit;
+			this->layers[0].flags.has_no_inherit_descendant |=
+				(*layers)[0].flags.has_no_inherit_descendant;
 			return 0;
 		}
 
@@ -315,7 +320,10 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
-		},
+			.no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+			.has_no_inherit_descendant =
+				!!(flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+		}
 	} };
 
 	build_check_layer();
@@ -662,9 +670,18 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		unsigned long access_bit;
 		bool is_empty;
 
+		/* Skip layers that already have no inherit flags. */
+		if (rule_flags &&
+		    (rule_flags->no_inherit_masks & layer_bit))
+			continue;
+
 		/* Collect rule flags for each layer. */
 		if (rule_flags && layer->flags.quiet)
 			rule_flags->quiet_masks |= layer_bit;
+		if (rule_flags && layer->flags.no_inherit)
+			rule_flags->no_inherit_masks |= layer_bit;
+		if (rule_flags && layer->flags.has_no_inherit_descendant)
+			rule_flags->no_inherit_desc_masks |= layer_bit;
 
 		/*
 		 * Records in @layer_masks which layer grants access to each requested
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index eb60db646422..81df6c56a152 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -40,6 +40,21 @@ struct landlock_layer {
 		 * down the file hierarchy.
 		 */
 		bool quiet:1;
+		/**
+		 * @no_inherit: Prevents this rule from being inherited by
+		 * descendant directories in the filesystem layer.  Only used
+		 * for filesystem rules.
+		 */
+		bool no_inherit:1;
+		/**
+		 * @has_no_inherit_descendant: Marker to indicate that this layer
+		 * has at least one descendant directory with a rule having the
+		 * no_inherit flag.  Only used for filesystem rules.
+		 * This "flag" is not set by the user, but by Landlock on
+		 * parent directories of rules when the child rule has
+		 * a rule with the no_inherit flag.
+		 */
+		bool has_no_inherit_descendant:1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
@@ -49,13 +64,25 @@ struct landlock_layer {
 };
 
 /**
- * struct collected_rule_flags - Hold accumulated flags for each layer.
+ * struct collected_rule_flags - Hold accumulated flags and their markers for each layer.
  */
 struct collected_rule_flags {
 	/**
 	 * @quiet_masks: Layers for which the quiet flag is effective.
 	 */
 	layer_mask_t quiet_masks;
+	/**
+	 * @no_inherit_masks: Layers for which the no_inherit flag is effective.
+	 */
+	layer_mask_t no_inherit_masks;
+	/**
+	 * @no_inherit_desc_masks: Layers for which the
+	 * has_no_inherit_descendant tag is effective.
+	 * This is not a flag itself, but a marker set on ancestors
+	 * of rules with the no_inherit flag to deny topology changes
+	 * in the direct parent path.
+	 */
+	layer_mask_t no_inherit_desc_masks;
 };
 
 /**
-- 
2.51.0


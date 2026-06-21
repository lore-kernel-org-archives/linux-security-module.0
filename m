Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0341D88D7
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013960; cv=none; b=Klf9SSov7bZfAXhVkuivIjmy0tMYKqVQv7BU61ZjDD9tMsPkatDakFyFo6AEH9Sr9yRYiSGmkc08o8NZMrqc1W6gmAFlUs43yCUCSkKAXZVN2NkNhUe+BNuSd7Na4IZb61HlG6UB9DagdIUTtMbL/pyKfXSZUliKuEgY8IKq/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013960; c=relaxed/simple;
	bh=QZPWHzEhfRcEh1PUtM2AXeDypn9TOiaJOQEk/A5i2TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6pDWZsFS4rlWV1gz/EXhBVCtTKrJEIPTneygLXVjNPnG7CtV3HdD7eERm8cgczekQzGSJ7+5pvh/4+e7KJxLb602GpSTV58A4gxEcDSIzJCtnMlB4QvbeOuMPOeDtmGA8DQ9kw24HeearJIqIqMkINm1aEJcjXj9hMWws6t6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUQFZQ6j; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUQFZQ6j"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7ea6923cc94so33196267b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013957; x=1782618757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGDcPhWuhy7A1S9F3/7IFlP6YtcfrsSlQQiPDSdTb7E=;
        b=UUQFZQ6jLb8wEeZgRAVtiGRMmSF5aNHGh2zK2xp+kzzxB/WQp1vaQp9EhcSsp933ef
         Ey9cqlA/QZ24pzJu7D6dceDLiUNzvinEgb5DxrDF91vIesVLX7Bv6gpSw29H8EmxxgGY
         er93lf+bsm4BQeCmbuZsAp1LYfH+dkgZPlvb1ok9REA8RxlSj4k2Azn0SYREqLQ2dfLQ
         m4ISxXsvSrzvFgVFmcmNpWn1krGaJ3zlUQRsKbAy/IA92o/KgJ3LEz3ZR4X8MLJXUF+c
         iprQkN7tr7bC26PBqbBygRMunV18YGQVh/t9GhkAiuBrCgU7mCHAFJGEm4UEEpyscuW1
         vg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013957; x=1782618757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGDcPhWuhy7A1S9F3/7IFlP6YtcfrsSlQQiPDSdTb7E=;
        b=ZVNePJxlBfmpbTlXiFjnk1C/Mn2UdSaIZLDUsAZFMv6LZTE0VmX1gCPuW8ddCna4Og
         TiB4rjxsIbBLeMxD1tIgWqaKmPlhGKEbyRBRtXelHHlHT+Iixx1kM5FZqlUs/SBX2H71
         b3xdzTMFrgab60baliSrXKzoqZoxtsrmZRZChnT4wGzq+b6/n/xY8a9p2D+KT1KexlTN
         aTWh8QwWcygkiAJKd4pV3Sly7vMwJ5FfFXDk6SaAm0V5gmE91U5o8kALO2FvH6vAhBDs
         XKtxdjOYE73jXqKjyRTB5du1g5skIsU8IUKiFa3uxsyoA5JWTTMXOojpiWILlKJOVuyb
         IaAA==
X-Gm-Message-State: AOJu0Yz/dBRhA32vDNWdIl/9iauthUWXl6rKQhp3S20B/UcWt8pmvYdS
	wGaAdRcwOQ2jYYg8T34XdeBm4VUj+7FaMEnTAddTL7G0Fuz4SEjX0g/SYe6efA==
X-Gm-Gg: AfdE7clA6aDK6O18fBMKpky2FOFilJNkMEjn+VjpfvrJuvgt1IVafBtVhdX06HyS8DJ
	ifi06W70iN+DPE/f+Edcp17PBssQ9r1mR1LX1ReEQG8hsKUkGgpDsCLAbCiTwy62seFxcVLYeM+
	q1nyAkTVMCrcZAqQURPoqJSmgYAyJxuL6CYe/Mq2QV00IXp/QYPDXORET31WkDCGStLwSiz4QD6
	RgB8/fDI7rKjfFOsuK41Rzk+qsuAomf1/D72ipr+6+tehEn0Zn2mXTSlJwa7+aU/63MxvjSiJAx
	QVY2iK4Lw8rV0wgoA+xbbMkW5ZeGxRkh9Zfs1wJMqrNJrTQWPPHgprYmuLNbEWkZBTnyfIAZ+uW
	gr4IW/SioRU5d2GtJ0pI8lg1+aT8C2YQOgHABj9JsEznl+BLl4L69OZCM6OYXzqP5JTK6BvtJ9M
	RTXtIHk1+aJN6OzfEZZ+gkzCCSJsU4hMPG22HfZMVQQ/DNPhS0NdgMB8xR
X-Received: by 2002:a05:690c:6c86:b0:7be:fedd:726b with SMTP id 00721157ae682-801342ab5d2mr88013867b3.42.1782013957332;
        Sat, 20 Jun 2026 20:52:37 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:36 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 5/9] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat, 20 Jun 2026 23:52:18 -0400
Message-ID: <20260621035223.2651547-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make %LANDLOCK_ADD_RULE_NO_INHERIT actually enforce its semantics:

- Tag the new rule's layer with @no_inherit and
  @has_no_inherit_descendant so landlock_unmask_layers() stops walking
  up the hierarchy once it has been seen, and so the rule's own object
  is sealed against topology changes.
- Walk from the rule's path up to the VFS root in
  landlock_append_fs_rule(), inserting a zero-access rule on each
  ancestor with @has_no_inherit_descendant set, so topology changes
  (rename, rmdir, link, ...) on any ancestor are denied too.
- Add deny_no_inherit_topology_change(), called from
  current_check_refer_path(), hook_path_unlink() and hook_path_rmdir()
  to enforce the seal at the LSM hook layer.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Extracted the ancestor-sealing walk out of landlock_append_fs_rule()
      into a new seal_ancestors() helper, removing the out_unlock goto.
    - The seal loop now handles LANDLOCK_WALK_INTERNAL explicitly (skips
      disconnected internal-mount roots and keeps walking), matching the
      updated landlock_walk_path_up() behavior.
    - Broadened current_check_refer_path() enforcement:
      deny_no_inherit_topology_change() is now applied to old_dentry and
      (when present) new_dentry unconditionally, covering hard links (link)
      in addition to rename/exchange.
    - Factored the unlink/rmdir hooks into a new current_check_remove()
      helper instead of duplicating the subject lookup and deny call.
    - Simplified deny_no_inherit_topology_change() to short-circuit and log
      on the first sealed layer, dropping the sealed_layers accumulator and
      the redundant no_inherit test.
    - Bumped the Landlock ABI to version 11 and updated the base_test
      abi_version expectation.
    - Rebased onto mic/next.

 security/landlock/access.h                   |   6 +
 security/landlock/fs.c                       | 156 ++++++++++++++++++-
 security/landlock/ruleset.c                  |  30 +++-
 security/landlock/ruleset.h                  |  13 ++
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 6 files changed, 202 insertions(+), 7 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index d926078bf0a5..9df6c6de71e2 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -81,6 +81,12 @@ struct layer_mask {
 	 */
 	access_mask_t quiet : 1;
 #endif /* CONFIG_AUDIT */
+	/**
+	 * @no_inherit: Whether we have encountered a rule with the no-inherit
+	 * flag for this layer, so that ancestor rules do not grant additional
+	 * access rights.
+	 */
+	access_mask_t no_inherit : 1;
 } __packed __aligned(sizeof(access_mask_t));
 
 /*
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 34d1c245af92..44ccf6cede85 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -362,6 +362,70 @@ static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
 	return LANDLOCK_WALK_CONTINUE;
 }
 
+/**
+ * seal_ancestors - Seal every ancestor of @walker up to the VFS root
+ *
+ * @ruleset: Ruleset (must be locked by the caller) to insert the seal rules
+ *           into.
+ * @walker: Path to the inode whose ancestors must be sealed.  It is walked up
+ *          to the real VFS root and is modified during the walk.
+ *
+ * Inserts a no-access rule tagged @has_no_inherit_descendant for each ancestor
+ * so that topology-changing operations (rename, rmdir, link, ...) on them are
+ * denied.
+ *
+ * On failure the walk stops early, so the ruleset may be left with the leaf
+ * rule and only some of its ancestors sealed.  The caller must therefore
+ * discard the ruleset on error rather than enforce it, since an enforced but
+ * partially sealed ruleset would provide a weaker guarantee than intended.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+static int seal_ancestors(struct landlock_ruleset *const ruleset,
+			  struct path *const walker)
+{
+	int err = 0;
+
+	path_get(walker);
+	for (;;) {
+		struct landlock_rule *ancestor_rule;
+		struct landlock_id ancestor_id = {
+			.type = LANDLOCK_KEY_INODE,
+		};
+		const enum landlock_walk_result res =
+			landlock_walk_path_up(walker);
+
+		/* Done once the real VFS root has been reached. */
+		if (res == LANDLOCK_WALK_STOP_REAL_ROOT)
+			break;
+		/*
+		 * @walker advanced past the disconnected root of an internal
+		 * mount, which does not name a sealable ancestor; keep walking
+		 * up so that every ancestor up to the real root is still
+		 * sealed.
+		 */
+		if (res == LANDLOCK_WALK_INTERNAL)
+			continue;
+
+		/* LANDLOCK_WALK_CONTINUE: seal this ancestor. */
+		ancestor_id.key.object =
+			get_inode_object(d_backing_inode(walker->dentry));
+		if (IS_ERR(ancestor_id.key.object)) {
+			err = PTR_ERR(ancestor_id.key.object);
+			break;
+		}
+		ancestor_rule = landlock_insert_rule(ruleset, ancestor_id, 0, 0);
+		landlock_put_object(ancestor_id.key.object);
+		if (IS_ERR(ancestor_rule)) {
+			err = PTR_ERR(ancestor_rule);
+			break;
+		}
+		ancestor_rule->layers[0].flags.has_no_inherit_descendant = true;
+	}
+	path_put(walker);
+	return err;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -391,6 +455,20 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	mutex_lock(&ruleset->lock);
 	rule = landlock_insert_rule(ruleset, id, access_rights, flags);
 	err = PTR_ERR_OR_ZERO(rule);
+	/*
+	 * Sealing an inode also seals all of its ancestors against topology
+	 * changes, so walk the path up to the VFS root and seal each ancestor
+	 * too.  This is best effort: a concurrent rename during the walk may
+	 * leave the seal incomplete.  Such changes to the hierarchy between
+	 * ruleset construction and enforcement are outside of Landlock's
+	 * threat model.  See the "Filesystem inheritance suppression" section
+	 * in Documentation/userspace-api/landlock.rst for the limitations.
+	 */
+	if (!err && (flags & LANDLOCK_ADD_RULE_NO_INHERIT)) {
+		struct path walker = *path;
+
+		err = seal_ancestors(ruleset, &walker);
+	}
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
@@ -1129,6 +1207,47 @@ log_fs_change_topology_dentry(const struct landlock_cred_security *const subject
 	});
 }
 
+/**
+ * deny_no_inherit_topology_change - Deny topology changes on sealed paths
+ * @subject: Subject performing the operation.
+ * @dentry: Target of the topology modification.
+ *
+ * Return: -EACCES (and emits an audit record) if any of the subject's
+ * domain layers seal @dentry against topology changes: either @dentry
+ * itself has a %LANDLOCK_ADD_RULE_NO_INHERIT rule, or one of its
+ * descendants does (recorded via @has_no_inherit_descendant on the
+ * dentry's rule). Returns 0 otherwise.
+ */
+static int
+deny_no_inherit_topology_change(const struct landlock_cred_security *subject,
+				struct dentry *const dentry)
+{
+	const struct landlock_rule *rule;
+
+	if (WARN_ON_ONCE(!subject || !dentry || d_is_negative(dentry)))
+		return 0;
+
+	rule = find_rule(subject->domain, dentry);
+	if (!rule)
+		return 0;
+
+	for (size_t i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+
+		/*
+		 * @has_no_inherit_descendant is a superset of @no_inherit: it is
+		 * set on the rule's own object when the no-inherit rule is
+		 * created, and on every ancestor.  Testing it alone seals both.
+		 */
+		if (layer->flags.has_no_inherit_descendant) {
+			log_fs_change_topology_dentry(subject, layer->level - 1,
+						      dentry);
+			return -EACCES;
+		}
+	}
+	return 0;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1194,6 +1313,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	struct path old_parent_path;
 	struct layer_masks layer_masks_parent1 = {}, layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
+	int err;
 
 	if (!subject)
 		return 0;
@@ -1210,6 +1330,22 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	}
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+	/*
+	 * A no-inherit seal forbids any topology change of the sealed inode or
+	 * its ancestors.  Deny renaming or linking the source out of its
+	 * hierarchy, as well as removing, overwriting or exchanging a sealed
+	 * destination.  This applies to both rename (@removable) and link
+	 * (!@removable) operations, so it is checked unconditionally.
+	 */
+	err = deny_no_inherit_topology_change(subject, old_dentry);
+	if (err)
+		return err;
+	if (!d_is_negative(new_dentry)) {
+		err = deny_no_inherit_topology_change(subject, new_dentry);
+		if (err)
+			return err;
+	}
+
 	if (removable) {
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
@@ -1586,16 +1722,32 @@ static int hook_path_symlink(const struct path *const dir,
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM);
 }
 
+static int current_check_remove(const struct path *const dir,
+				struct dentry *const dentry,
+				const access_mask_t access_request)
+{
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+
+	if (subject) {
+		int err = deny_no_inherit_topology_change(subject, dentry);
+
+		if (err)
+			return err;
+	}
+	return current_check_access_path(dir, access_request);
+}
+
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
+	return current_check_remove(dir, dentry, LANDLOCK_ACCESS_FS_REMOVE_FILE);
 }
 
 static int hook_path_rmdir(const struct path *const dir,
 			   struct dentry *const dentry)
 {
-	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
+	return current_check_remove(dir, dentry, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
 static int hook_path_truncate(const struct path *const path)
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index b8a35675bcbf..ca7cfa45c90a 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -258,6 +258,10 @@ insert_rule(struct landlock_ruleset *const ruleset,
 				return ERR_PTR(-EINVAL);
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
+			this->layers[0].flags.no_inherit |=
+				(*layers)[0].flags.no_inherit;
+			this->layers[0].flags.has_no_inherit_descendant |=
+				(*layers)[0].flags.has_no_inherit_descendant;
 			return this;
 		}
 
@@ -311,12 +315,20 @@ landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		     const struct landlock_id id,
 		     const access_mask_t access, const u32 flags)
 {
+	const bool no_inherit = !!(flags & LANDLOCK_ADD_RULE_NO_INHERIT);
 	struct landlock_layer layers[] = { {
 		.access = access,
 		/* When @level is zero, insert_rule() extends @ruleset. */
 		.level = 0,
 		.flags = {
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
+			.no_inherit = no_inherit,
+			/*
+			 * The rule's own object is also sealed against
+			 * topology changes, so mark it as if it had a
+			 * no-inherit descendant.
+			 */
+			.has_no_inherit_descendant = no_inherit,
 		},
 	} };
 
@@ -657,15 +669,25 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 	 */
 	for (size_t i = 0; i < rule->num_layers; i++) {
 		const struct landlock_layer *const layer = &rule->layers[i];
+		struct layer_mask *const layer_mask =
+			&masks->layers[layer->level - 1];
+
+		/*
+		 * Skip layers that already have no_inherit set: these layers
+		 * should not inherit access rights from ancestor directories.
+		 */
+		if (layer_mask->no_inherit)
+			continue;
 
 		/* Clear the bits where the layer in the rule grants access. */
-		masks->layers[layer->level - 1].access &= ~layer->access;
+		layer_mask->access &= ~layer->access;
 
 #ifdef CONFIG_AUDIT
-		/* Collect rule flags for each layer. */
 		if (layer->flags.quiet)
-			masks->layers[layer->level - 1].quiet = true;
+			layer_mask->quiet = true;
 #endif /* CONFIG_AUDIT */
+		if (layer->flags.no_inherit)
+			layer_mask->no_inherit = true;
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
@@ -731,6 +753,7 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 #ifdef CONFIG_AUDIT
 		masks->layers[i].quiet = false;
 #endif /* CONFIG_AUDIT */
+		masks->layers[i].no_inherit = false;
 	}
 	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
 	     i++) {
@@ -738,6 +761,7 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 #ifdef CONFIG_AUDIT
 		masks->layers[i].quiet = false;
 #endif /* CONFIG_AUDIT */
+		masks->layers[i].no_inherit = false;
 	}
 
 	return handled_accesses;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c927bcb82fa3..8d3dd551bf77 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -40,6 +40,19 @@ struct landlock_layer {
 		 * down the file hierarchy.
 		 */
 		u8 quiet : 1;
+		/**
+		 * @no_inherit: Prevents this rule from inheriting access rights
+		 * from ancestor inodes.  Only used for filesystem rules; set
+		 * via %LANDLOCK_ADD_RULE_NO_INHERIT.
+		 */
+		u8 no_inherit : 1;
+		/**
+		 * @has_no_inherit_descendant: Marker used to deny topology
+		 * changes on the rule's object: either the object itself has
+		 * a no-inherit rule, or a descendant does.  Only used for
+		 * filesystem rules; set by Landlock, never by user space.
+		 */
+		u8 has_no_inherit_descendant : 1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index b847b0be1cf7..3fea5492df0d 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 10;
+const int landlock_abi_version = 11;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..b8b5fa1042ba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.54.0


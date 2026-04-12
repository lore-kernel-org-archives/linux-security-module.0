Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5830ACEE
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022358; cv=none; b=Tf4+LdxVsKahKf6kZSHLWwXr+4pPG9cXHLYUJJJJxsPsm/9tY4gD8ihTUvKD/W3T9wjRZvf1SmqID6gjvj2CpyGx0ZmzBigZI23zQtCrqa65wp6TRbRuVOPDh2JTOFtgLVGNe0ysOFfqKnFRKdVNhdBurKXmkNXHRFVozz0OhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022358; c=relaxed/simple;
	bh=tCsGOv1KFUHLmeJ6Q7+A/rD4ZDIsCFDK5XRKxGLz3UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l19BAPQsavlnuLBUZisg6v20woSCNuRCo7rZPYopOzMGxOQrWd355LGDs5Bw2V8PjeOIZanri/LsLnnE/VIi+DqFWYQ8HxhTobQMwijJo3To5u9j2G6Ilc5s1xwlcCN1OVSRBnN0/NGt6YTeSJjPyZYxdJQhFG2Q+vPoD1JfPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LibSEfF/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LibSEfF/"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7a43424f861so29766977b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022356; x=1776627156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAS+VtMsYigVj7cnKBiBGnkjliP9bVlt7ozAKvXDZY0=;
        b=LibSEfF/jiZxhL9KGLYgfPUF+sH/6wmqezi60y9ZXwTkAEiYwSfDYrSePNGvIaUbnL
         AqNccby8vHXMCvaw7FXIgW7s0Ik5R6TaF0jdWVjH1CCYkJ9G3MhppcayXPhYTQc3Vq/b
         qk8hygr2x1u+vP+Lxf6sy3bsnzk1254mB7bSp+Mzla3PXU+rV8FFOxKqKzLLiL+epSpb
         ACsy6wm/c4cTz4nCA0nuVUqnu4BbvVfy5v4DFFYul0Jwh+fst9pPWuxb7O8XGeFFxq2o
         IyBHJillF79k8+cYJeoz3BhKrYxLvGUtenuP7dqY2JAphYV9Y6ksVXaxhVHJ7rMQGIwn
         PcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022356; x=1776627156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAS+VtMsYigVj7cnKBiBGnkjliP9bVlt7ozAKvXDZY0=;
        b=eVjyG5ka50RmRxJrVT5Hr3CQvQUuQv9seDLQyFl/P6jh/2uK0F16vG/iLhoYLY3uun
         cETC3C+58v8HheGESvU2DKGqHe2RpGDINQOmMBYqNlouoTbK0zfwg3e2fe7TZQM/YmJU
         KZ+3oLnVPJKrnlXie4+ZWHdeNsGzJPw/gvG5sI81X9jmyyajFW3YuBV0M9VhVdS2UYc2
         4b/jgLfg4+QgollEgqsEN/L9TPSFjIQ/IFrOEBa5JkYalieAjkJpO6oi3fKuWj0PidQj
         H/O8EMnOGcGJIF8Im0Th4yl9WrrxuZKrRwAy4HTS0JL7dg23g55heJtIPzQZQfGH6Ol3
         RvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm1VZmborU1WhqzlZLEZccQChFr1A7uGcnawne0e182Q2mW2hnElJFdWPP3Ku3SW4S5/UpqEKJLWpMaZsEnGNwZtZMZEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gI11Dw/re2fhOVpMqHqAwpUnXQa1XV7vA7G1ndsN8iCmdl1O
	5/gIl3JDdZ92zoBvXCgyueUX3buxF6hkg1u3LeFaOADM+5WrBRC9onJi
X-Gm-Gg: AeBDievxwh+CIVnKH9T19nWcY63P3vE9YTqlYWauH1yBb4jZZGxIifY55ctaQNAsUmg
	u/KSzLT5DRdAfegKJnN2XOwrB7Zuf7PrzFVR+T6sIQwithXxsdCizmEyYVbPPA2xkt80IrCBs87
	eWzsDWIw7svBzr3WLDCz5rIsOYmozxdAUnJXDzBWQRpCvTS8HhJLblhv72h7PAj5qkyQaKd7G0u
	06HTZOQOGtAbVXYIRmpBQy5uFq/H8V+ChvrkKpUbwrkUaMScW1u0RMHdSMhLtaA5MzcKgA4Awob
	oI5wTS5SuIzmU147tXhB9r8V6ZHqS5BLmYdyiMCm2ngxAT5F3x2smJs36+Qdyhlh1HGg5dc1jNC
	lZyaPOwhVJT8wx94BKxlTiUup1WDuMWex2F5r0OfuAiQhxcTpaQMoeU95/HNL1HAATIA+ANyi0L
	zmLMerJ3WTFlVkxIRcZqlD+m9Rwhxh4CUyu20UjHrYmDCceUA6LhP5Y1onfk++LBZu/VWM9Vzy
X-Received: by 2002:a05:690c:e3c3:b0:79a:5fb9:62ad with SMTP id 00721157ae682-7af71f460fcmr121035957b3.43.1776022356236;
        Sun, 12 Apr 2026 12:32:36 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:35 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 06/10] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 12 Apr 2026 15:31:57 -0400
Message-ID: <20260412193214.87072-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
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
denied up to the VFS root.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * Split landlock_walk_path_up, the is_access_to_paths_allowed conversion,
        the collect_domain_accesses conversion, and the find_rule move into
        separate preparatory patches.
      * Fixed disconnected-directory handling in landlock_append_fs_rule() when
        marking NO_INHERIT ancestors.
    
    v5..v6 changes:
    
      * Retain existing documentation for path traversal in
        is_access_to_paths_allowed.
      * Change conditional for path walk in is_access_to_paths_allowed
        removing possibility of infinite loop and renamed constant.
      * Remove (now) redundant mnt_root parameter from
        collect_domain_accesses.
      * Change path parameter to a dentry for
        deny_no_inherit_topology_change because only the dentry was needed.
      * Minor documentation fixes.
    
    v4..v5 changes:
    
      * Centralized path walking logic with landlock_walk_path_up.
      * Removed redundant functions in fs.c, and streamlined core
        logic, removing ~120 lines of code.
      * Removed mark_no_inherit_ancestors, replacing with direct flag
        setting in append_fs_rule.
      * Removed micro-optimization of skipping ancestor processing
        when all layers have no_inherit, as it complicated the code
        significantly for little gain.
    
    v3..v4 changes:
    
      * Rebased on v6 of Tingmao Wang's quiet flag series.
      * Removed unnecessary mask_no_inherit_descendant_layers and related
        code at Tingmao Wang's suggestion, simplifying patch.
      * Updated to use new disconnected directory handling.
      * Improved WARN_ON_ONCE usage.
      * Removed redundant loop for single-layer rulesets.
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

 security/landlock/fs.c      | 117 ++++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.c |  40 +++++++++---
 security/landlock/ruleset.h |  26 ++++++++
 3 files changed, 173 insertions(+), 10 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 86a3435ebbba..6af1043a941f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -392,6 +392,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_INODE,
 	};
+	struct path walker = *path;
 
 	/* Files only get access rights that make sense. */
 	if (!d_is_dir(path->dentry) &&
@@ -406,8 +407,44 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	id.key.object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
+
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	if (err || !(flags & LANDLOCK_ADD_RULE_NO_INHERIT))
+		goto out_unlock;
+
+	path_get(&walker);
+	while (landlock_walk_path_up(&walker) != LANDLOCK_WALK_STOP_REAL_ROOT) {
+		struct landlock_rule *ancestor_rule;
+
+		ancestor_rule = (struct landlock_rule *)find_rule(
+			ruleset, walker.dentry);
+		if (!ancestor_rule) {
+			struct landlock_id ancestor_id = {
+				.type = LANDLOCK_KEY_INODE,
+				.key.object = get_inode_object(
+					d_backing_inode(walker.dentry)),
+			};
+
+			if (IS_ERR(ancestor_id.key.object)) {
+				err = PTR_ERR(ancestor_id.key.object);
+				break;
+			}
+			/* Insert a "blank" rule for the ancestor. */
+			err = landlock_insert_rule(ruleset, ancestor_id, 0, 0);
+			landlock_put_object(ancestor_id.key.object);
+			if (err)
+				break;
+
+			ancestor_rule = (struct landlock_rule *)find_rule(
+				ruleset, walker.dentry);
+		}
+		/* Marks the ancestor rule, whether we inserted it or found it. */
+		ancestor_rule->layers[0].flags.has_no_inherit_descendant = true;
+	}
+	path_put(&walker);
+
+out_unlock:
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
@@ -1108,6 +1145,57 @@ collect_domain_accesses(const struct landlock_ruleset *const domain,
 	return ret;
 }
 
+/**
+ * deny_no_inherit_topology_change - deny topology changes on sealed paths
+ * @subject: Subject performing the operation (contains the domain).
+ * @path: Path whose dentry is the target of the topology modification.
+ *
+ * Checks whether any domain layers are sealed against topology changes at
+ * @path.  If so, emit an audit record and return -EACCES.  Otherwise return 0.
+ */
+static int
+deny_no_inherit_topology_change(const struct landlock_cred_security *subject,
+				struct dentry *const dcache_entry)
+{
+	layer_mask_t sealed_layers = 0;
+	layer_mask_t override_layers = 0;
+	const struct landlock_rule *rule;
+	size_t layer_index;
+
+	if (WARN_ON_ONCE(!subject || !dcache_entry ||
+			 d_is_negative(dcache_entry)))
+		return 0;
+
+	rule = find_rule(subject->domain, dcache_entry);
+	if (!rule)
+		return 0;
+
+	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
+		const struct landlock_layer *layer = &rule->layers[layer_index];
+		layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
+
+		if (layer->flags.no_inherit ||
+		    layer->flags.has_no_inherit_descendant)
+			sealed_layers |= layer_bit;
+		else
+			override_layers |= layer_bit;
+	}
+
+	sealed_layers &= ~override_layers;
+	if (!sealed_layers)
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dcache_entry,
+		},
+		.layer_plus_one = __ffs((unsigned long)sealed_layers) + 1,
+	});
+	return -EACCES;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1193,6 +1281,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
+		int err = deny_no_inherit_topology_change(subject, old_dentry);
+
+		if (err)
+			return err;
+		if (exchange) {
+			err = deny_no_inherit_topology_change(subject,
+							      new_dentry);
+			if (err)
+				return err;
+		}
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
 	}
@@ -1589,12 +1687,31 @@ static int hook_path_symlink(const struct path *const dir,
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
index d2d1e3fb6cf2..8fdba3a7f983 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -257,6 +257,10 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 				return -EINVAL;
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
+			this->layers[0].flags.no_inherit |=
+				(*layers)[0].flags.no_inherit;
+			this->layers[0].flags.has_no_inherit_descendant |=
+				(*layers)[0].flags.has_no_inherit_descendant;
 			return 0;
 		}
 
@@ -309,14 +313,17 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
 			 const access_mask_t access, const int flags)
 {
-	struct landlock_layer layers[] = { {
-		.access = access,
-		/* When @level is zero, insert_rule() extends @ruleset. */
-		.level = 0,
-		.flags = {
-			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
-		},
-	} };
+	struct landlock_layer layers
+		[] = { { .access = access,
+			 /* When @level is zero, insert_rule() extends @ruleset. */
+			 .level = 0,
+			 .flags = {
+				 .quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
+				 .no_inherit = !!(flags &
+						  LANDLOCK_ADD_RULE_NO_INHERIT),
+				 .has_no_inherit_descendant = !!(
+					 flags & LANDLOCK_ADD_RULE_NO_INHERIT),
+			 } } };
 
 	build_check_layer();
 	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
@@ -660,12 +667,25 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		const struct landlock_layer *const layer = &rule->layers[i];
 		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
 
+		/*
+		 * Skip layers that already have no_inherit set - these layers
+		 * should not inherit access rights from ancestor directories.
+		 */
+		if (rule_flags && (rule_flags->no_inherit_masks & layer_bit))
+			continue;
+
 		/* Clear the bits where the layer in the rule grants access. */
 		masks->access[layer->level - 1] &= ~layer->access;
 
 		/* Collect rule flags for each layer. */
-		if (rule_flags && layer->flags.quiet)
-			rule_flags->quiet_masks |= layer_bit;
+		if (rule_flags) {
+			if (layer->flags.quiet)
+				rule_flags->quiet_masks |= layer_bit;
+			if (layer->flags.no_inherit)
+				rule_flags->no_inherit_masks |= layer_bit;
+			if (layer->flags.has_no_inherit_descendant)
+				rule_flags->no_inherit_desc_masks |= layer_bit;
+		}
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index e369f15ae885..34b70da8bd50 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -40,6 +40,20 @@ struct landlock_layer {
 		 * down the file hierarchy.
 		 */
 		bool quiet:1;
+		/**
+		 * @no_inherit: Prevents this rule from inheriting access rights
+		 * from ancestor inodes. Only used for filesystem rules.
+		 */
+		bool no_inherit : 1;
+		/**
+		 * @has_no_inherit_descendant: Marker to indicate that this layer
+		 * has at least one descendant directory with a rule having the
+		 * no_inherit flag.  Only used for filesystem rules.
+		 * This "flag" is not set by the user, but by Landlock on
+		 * parent directories of rules when the child rule has
+		 * a rule with the no_inherit flag to deny topology changes.
+		 */
+		bool has_no_inherit_descendant : 1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
@@ -62,6 +76,18 @@ struct collected_rule_flags {
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
2.53.0


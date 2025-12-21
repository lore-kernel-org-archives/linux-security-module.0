Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39722459D1
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346194; cv=none; b=BgnUJo3jyZSgN5wAEOJ7QjLLXOGOGBc6uQTpQ5/QXlkILMiyrnOZsMuvNirP+EMP93w36Jn/405xyoRdbosks6ZwG2nM0aMbCvSOzHcHLQOgMGsnBtWZHSA7Vr54TCQoz8+fzFwuS6TG7Rwf6p3yVLd+rFCpngMBkVK4QK37MRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346194; c=relaxed/simple;
	bh=SbfQZr46jq8Kr3PCVsg/2YIpx9aUuG3e+eTgofZIk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJuV3Vg4WfW6WG9RQqLnDUYj091OJUPxxBv6oNnSY80IhB12GAE6uwIuCE9u6VrGVo5xg/JDycfFV1NfRMMqJJB3RAzqSJbu/dR+NKdB9cUrotqglDWWlv4yk6aD51mZSHhrEavwQRQB889C0wBzfQBzya25Q7R7DYpPN/25OMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdX2fmJn; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdX2fmJn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6467b7c3853so694434d50.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346189; x=1766950989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWlRkHQgxJAXM71k5BdHxSbEzU3bx8EaZO7h+BCGmWg=;
        b=PdX2fmJnjmDyo8pokp/OeMFCjasyV7s8yAl0yrsJPIsPs6jB/ue/Oj45fkLlG59f2f
         y7VC7hQsmCY4GSnKh4GiB52EAyfvxVu2TSCjBEwUsuOnvTMmN6rqujJAttWimsfxDTA4
         +PB0R290aGfJJlWkc5e/Li2gDQgCqUV+WhKimIPplTsM6BWRBVe/yjhs5cRPRndzk4W4
         DH3DVo0NVsFZU0hZXc3whvdx8m4Ydnqby6HVcZyLdkX68aY038n7ErxXTfe8npBksRQm
         MqXeTFd6JnQTyQyyFo16RaVof2ar9lDvH35VUQTT+V8Ub1Z8IChDHWSdU8Jp75WolHNT
         7SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346189; x=1766950989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWlRkHQgxJAXM71k5BdHxSbEzU3bx8EaZO7h+BCGmWg=;
        b=i55h9o8h87Q1yqgJ/nrIk0uLV6vS6vbgRtk5SrWOiaaEbhXsBYOhuozJ9t9AbclIe1
         aywXbbe6gwzuiiixiHJ57hdq/Q+h9liiJcf8goOz5kyJ1a62NB5URhtTI4Yb8mDVDF9z
         4DflQXKHnvhkuoBKQ7KMtfWqSzDATZW2Y8XfTDN9TaU+/xSSfZ6hWe5Ao8GfIYe/NLhj
         lvU8vSlbgrjMS0ww3AbsxbraV2jEQ8EaotdMbhDQlG/9UEuURjnDxVngbe+VDtTmk9/E
         O/dYcU37IybZFQwoAaL38UxXcCbo/hlE3OxgkUkmG97R3K/7e482pwuYcSO6iGt778UI
         acOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUER9gBIP+gms0j+KVbyVY1PmXFKSy9ODEt7aU4QmdbBGxC8YtiN84vYycuOSiqU8LeLjlskURTsbtzQAGvZUCfJsrvr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lTQv5SSc4noF1MBhGftYpvYrs8ROmDwUeSFnuGlzDvrqN3ve
	lhOlDADdnmJDWDFXv0GRa+U/MfqvtMDDFcN+AX613u0fpJBjoPKOJYhh
X-Gm-Gg: AY/fxX5z6JSwyzPTCtToDADNItdRLLboyvngURXX3WZCuxrqbW3SlYJEnKChMvWQ55b
	Tz3YqFr6Zui6JMP+MI3GUx9+txI22w51bjigpBal6ow5JnpGUF+AWuz0IWrPBkm/bHEyDVGxqmk
	/nyTs3SBp4rpFKJ2HT2uQL8nAltuhcC+Byair6+OZWRCRHFPEi2EVA2rmHWGBUUCfmxX+GRE0en
	dFtTekDqUgKeRfaNCodnbgM0qym9QQ5xwNd1AA9XoQcE6sevyujoTwLh9Zpw7Q7Maj71ZXyRgtk
	r3GlsT1o9NUt9smMqGEGr9O60aproB8Xif178+fdKIZGz4gWmeb/PWpB33peAS56ChNA9XIg/YQ
	ccXCJEIaPHMOn0fiMq1VZH/K1ZNWX2i4A00w9IxmephR3nv4TITtMKHbYkOdUUhNLE83r+1Q+pN
	AKpRX7cFXVfS+MMfvStpGW3cY0wazfj7RkM5nw2gu7lT9x9Otn0dDi0BTUlmDb
X-Google-Smtp-Source: AGHT+IFwh+oJ1I6uFSpdVruqrEWjG86mLJY50bqS2+wFLWqGNmCmXYx5bMigO8UwX89n3OYydvRDEg==
X-Received: by 2002:a53:cecc:0:b0:63c:f5a6:f30f with SMTP id 956f58d0204a3-6466a900e50mr5533083d50.57.1766346189356;
        Sun, 21 Dec 2025 11:43:09 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43701c7sm35628707b3.8.2025.12.21.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:43:09 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 1/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 21 Dec 2025 14:42:56 -0500
Message-ID: <20251221194301.247484-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221194301.247484-1-utilityemal77@gmail.com>
References: <20251221194301.247484-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implements a flag to prevent access grant inheritance within the filesystem
hierarchy for landlock rules.

If a landlock rule on an inode has this flag, any access grants on parent
inodes will be ignored. Moreover, operations that involve altering the
ancestors of the subject with LANDLOCK_ADD_RULE_NO_INHERIT will be
denied up to the VFS root.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: Mickaël Salaün <mic@digikod.net>
---

Notes:
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

 include/uapi/linux/landlock.h |  29 ++++
 security/landlock/fs.c        | 250 ++++++++++++++++++++++++++--------
 security/landlock/ruleset.h   |  28 +++-
 3 files changed, 250 insertions(+), 57 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index d4f47d20361a..239cdab66f14 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -127,10 +127,39 @@ struct landlock_ruleset_attr {
  *     allowed_access in the passed in rule_attr.  When this flag is
  *     present, the caller is also allowed to pass in an empty
  *     allowed_access.
+ * %LANDLOCK_ADD_RULE_NO_INHERIT
+ *     When set on a rule being added to a ruleset, this flag disables the
+ *     inheritance of access rights and flags from parent objects.
+ *
+ *     This flag currently applies only to filesystem rules.  Adding it to
+ *     non-filesystem rules will return -EINVAL, unless future extensions
+ *     of Landlock define other hierarchical object types.
+ *
+ *     By default, Landlock filesystem rules inherit allowed accesses from
+ *     ancestor directories: if a parent directory grants certain rights,
+ *     those rights also apply to its children.  A rule marked with
+ *     LANDLOCK_ADD_RULE_NO_INHERIT stops this propagation at the directory
+ *     covered by the rule.  Descendants of that directory continue to inherit
+ *     normally unless they also have rules using this flag.
+ *
+ *     If a regular file is marked with this flag, it will not inherit any
+ *     access rights from its parent directories; only the accesses explicitly
+ *     allowed by the rule will apply to that file.
+ *
+ *     This flag also enforces parent-directory restrictions: rename, rmdir,
+ *     link, and other operations that would change the directory's immediate
+ *     parent subtree are denied up to the VFS root.  This prevents
+ *     sandboxed processes from manipulating the filesystem hierarchy to evade
+ *     restrictions (e.g., via sandbox-restart attacks).
+ *
+ *     In addition, this flag blocks the inheritance of rule flags
+ *     (such as the quiet flag) from parent directories to the object covered
+ *     by this rule.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3320d88d8c36..fd0efd1adb8d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -317,6 +317,43 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
+/**
+ * enum landlock_walk_result - Result codes for landlock_walk_path_up()
+ * @LANDLOCK_WALK_CONTINUE: Path is now neither the real root nor an internal mount point.
+ * @LANDLOCK_WALK_STOP_REAL_ROOT: Path has reached the real VFS root.
+ * @LANDLOCK_WALK_INTERNAL: Path has reached an internal mount point.
+ */
+enum landlock_walk_result {
+	LANDLOCK_WALK_CONTINUE,
+	LANDLOCK_WALK_STOP_REAL_ROOT,
+	LANDLOCK_WALK_INTERNAL,
+};
+
+static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
+{
+	while (path->dentry == path->mnt->mnt_root) {
+		if (!follow_up(path))
+			return LANDLOCK_WALK_STOP_REAL_ROOT;
+	}
+
+	if (unlikely(IS_ROOT(path->dentry))) {
+		if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
+			return LANDLOCK_WALK_INTERNAL;
+		dput(path->dentry);
+		path->dentry = dget(path->mnt->mnt_root);
+		return LANDLOCK_WALK_CONTINUE;
+	}
+
+	struct dentry *const parent = dget_parent(path->dentry);
+
+	dput(path->dentry);
+	path->dentry = parent;
+	return LANDLOCK_WALK_CONTINUE;
+}
+
+static const struct landlock_rule *find_rule(const struct landlock_ruleset *const domain,
+					     const struct dentry *const dentry);
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -344,6 +381,48 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	if (err || !(flags & LANDLOCK_ADD_RULE_NO_INHERIT))
+		goto out_unlock;
+
+	/* Create ancestor rules and set has_no_inherit_descendant flags */
+	struct path walker = *path;
+
+	path_get(&walker);
+	while (landlock_walk_path_up(&walker) == LANDLOCK_WALK_CONTINUE) {
+		struct landlock_rule *ancestor_rule;
+
+		if (WARN_ON_ONCE(!walker.dentry || d_is_negative(walker.dentry))) {
+			err = -EIO;
+			break;
+		}
+
+		ancestor_rule = (struct landlock_rule *)find_rule(ruleset, walker.dentry);
+		if (!ancestor_rule) {
+			struct landlock_id ancestor_id = {
+				.type = LANDLOCK_KEY_INODE,
+				.key.object = get_inode_object(d_backing_inode(walker.dentry)),
+			};
+
+			if (IS_ERR(ancestor_id.key.object)) {
+				err = PTR_ERR(ancestor_id.key.object);
+				break;
+			}
+			err = landlock_insert_rule(ruleset, ancestor_id, 0, 0);
+			landlock_put_object(ancestor_id.key.object);
+			if (err)
+				break;
+
+			ancestor_rule = (struct landlock_rule *)
+				find_rule(ruleset, walker.dentry);
+		}
+		if (WARN_ON_ONCE(!ancestor_rule || ancestor_rule->num_layers != 1)) {
+			err = -EIO;
+			break;
+		}
+		ancestor_rule->layers[0].flags.has_no_inherit_descendant = true;
+	}
+	path_put(&walker);
+out_unlock:
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
@@ -855,6 +934,7 @@ static bool is_access_to_paths_allowed(
 	 */
 	while (true) {
 		const struct landlock_rule *rule;
+		enum landlock_walk_result walk_res;
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -913,47 +993,25 @@ static bool is_access_to_paths_allowed(
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
+		/* Otherwise, keep walking up to the root. */
+		walk_res = landlock_walk_path_up(&walker_path);
 
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
-
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
-				/*
-				 * Stops and allows access when reaching disconnected root
-				 * directories that are part of internal filesystems (e.g. nsfs,
-				 * which is reachable through /proc/<pid>/ns/<namespace>).
-				 */
-				allowed_parent1 = true;
-				allowed_parent2 = true;
-				break;
-			}
-
+		if (walk_res == LANDLOCK_WALK_INTERNAL) {
 			/*
-			 * We reached a disconnected root directory from a bind mount.
-			 * Let's continue the walk with the mount point we missed.
+			 * Stops and allows access when reaching disconnected root
+			 * directories that are part of internal filesystems (e.g. nsfs,
+			 * which is reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			dput(walker_path.dentry);
-			walker_path.dentry = walker_path.mnt->mnt_root;
-			dget(walker_path.dentry);
-		} else {
-			struct dentry *const parent_dentry =
-				dget_parent(walker_path.dentry);
-
-			dput(walker_path.dentry);
-			walker_path.dentry = parent_dentry;
+			allowed_parent1 = true;
+			allowed_parent2 = true;
+			break;
 		}
+		/*
+		 * Stops at the real root.  Denies access
+		 * because not all layers have granted access
+		 */
+		else if (walk_res == LANDLOCK_WALK_STOP_REAL_ROOT)
+			break;
 	}
 	path_put(&walker_path);
 
@@ -1050,8 +1108,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * collect_domain_accesses - Walk through a file path and collect accesses
  *
  * @domain: Domain to check against.
- * @mnt_root: Last directory to check.
- * @dir: Directory to start the walk from.
+ * @mnt_root: Last path element to check.
+ * @dir: Directory path to start the walk from.
  * @layer_masks_dom: Where to store the collected accesses.
  *
  * This helper is useful to begin a path walk from the @dir directory to a
@@ -1073,29 +1131,31 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  */
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
-	const struct dentry *const mnt_root, struct dentry *dir,
+	const struct path *const dir,
 	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
 	struct collected_rule_flags *const rule_flags)
 {
 	unsigned long access_dom;
 	bool ret = false;
+	struct path walker;
 
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
+	if (WARN_ON_ONCE(!domain || !dir || !layer_masks_dom))
 		return true;
-	if (is_nouser_or_private(dir))
+	if (is_nouser_or_private(dir->dentry))
 		return true;
 
 	access_dom = landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 					       layer_masks_dom,
 					       LANDLOCK_KEY_INODE);
 
-	dget(dir);
+	walker = *dir;
+	path_get(&walker);
 	while (true) {
-		struct dentry *parent_dentry;
+		enum landlock_walk_result walk_res;
 
 		/* Gets all layers allowing all domain accesses. */
 		if (landlock_unmask_layers(
-			    find_rule(domain, dir), access_dom, layer_masks_dom,
+			    find_rule(domain, walker.dentry), access_dom, layer_masks_dom,
 			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
@@ -1104,22 +1164,71 @@ static bool collect_domain_accesses(
 			ret = true;
 			break;
 		}
-
 		/*
 		 * Stops at the mount point or the filesystem root for a disconnected
 		 * directory.
 		 */
-		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
+		if (walker.dentry == dir->mnt->mnt_root && walker.mnt == dir->mnt)
+			break;
+		walk_res = landlock_walk_path_up(&walker);
+		if (walk_res != LANDLOCK_WALK_CONTINUE)
 			break;
-
-		parent_dentry = dget_parent(dir);
-		dput(dir);
-		dir = parent_dentry;
 	}
-	dput(dir);
+	path_put(&walker);
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
+static int deny_no_inherit_topology_change(const struct landlock_cred_security *subject,
+					   struct dentry *const dcache_entry)
+{
+	layer_mask_t sealed_layers = 0;
+	layer_mask_t override_layers = 0;
+	const struct landlock_rule *rule;
+	u32 layer_index;
+	unsigned long audit_layer_index;
+
+	if (WARN_ON_ONCE(!subject || !dcache_entry || d_is_negative(dcache_entry)))
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
+	audit_layer_index = __ffs((unsigned long)sealed_layers);
+	landlock_log_denial(subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+		.audit = {
+			.type = LSM_AUDIT_DATA_DENTRY,
+			.u.dentry = dcache_entry,
+		},
+		.layer_plus_one = audit_layer_index + 1,
+	});
+	return -EACCES;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1206,6 +1315,15 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
+		int err = deny_no_inherit_topology_change(subject, old_dentry);
+
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
@@ -1248,12 +1366,13 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
+	allow_parent1 = collect_domain_accesses(subject->domain,
+						&(struct path){ .mnt = new_dir->mnt,
+						.dentry = old_parent },
 						&layer_masks_parent1,
 						&rule_flags_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
+	allow_parent2 = collect_domain_accesses(subject->domain,
+						new_dir,
 						&layer_masks_parent2,
 						&rule_flags_parent2);
 	if (allow_parent1 && allow_parent2)
@@ -1602,12 +1721,31 @@ static int hook_path_symlink(const struct path *const dir,
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
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index eb60db646422..c0a9b33e68b2 100644
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
+		bool no_inherit:1;
+		/**
+		 * @has_no_inherit_descendant: Marker to indicate that this layer
+		 * has at least one descendant directory with a rule having the
+		 * no_inherit flag.  Only used for filesystem rules.
+		 * This "flag" is not set by the user, but by Landlock on
+		 * parent directories of rules when the child rule has
+		 * a rule with the no_inherit flag to deny topology changes.
+		 */
+		bool has_no_inherit_descendant:1;
 	} flags;
 	/**
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
@@ -49,13 +63,25 @@ struct landlock_layer {
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


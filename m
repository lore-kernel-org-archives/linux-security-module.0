Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0F221FCF
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731956; cv=none; b=Bh75tHncXCzITd3nIcuw8PR2wHxw4cyp6wka3kyPjb4yFSCkG+oub9wCEIWFcV5iY1UVkNZbJ1eDOV6jLmocAcVo1Mu4neno11+F2/fKrZXfMnB2u+hMZQEdWayfI4ABzGMVqDwDovVjYuDugV8HNT1kMfsw5N0V9KvXGpDUqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731956; c=relaxed/simple;
	bh=6JKmILeS923cLz660Ddhp9+tm1NzKr72JkvO422z65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beWmgSeT2LIIBzp4LytgdFiuhpFS1mnV9CjTxReoIEYuM0nrBGjyvLe8drWyG6qqyVGu6RLPeES0cxggVVYcMxV7vaImqVcd/nEZ+76c3uqN9HR0u8kklxT3SHHAIqNMCAfNwFqbBHd1MI/YadlaCS9dzyOaaOIfaX/3cmHN8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/d0gDmB; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/d0gDmB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64471fcdef0so1849771d50.1
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731953; x=1766336753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2vJ1HOBNs8UzoO3Ll3Uv8AhoYKXTFMFCSXN6U+MUHc=;
        b=Z/d0gDmB+AAQGJyiVToxw8v0CqtDHt2Hd7+3ICZ4Wbk00gk5/klpus+CHFVTFPqsgJ
         ikpV5aIAMhjJBSdW8R8HwBB9muC9o69DNvrfmskDnaj/WgLNXZuGdsbFfls8E0vNVaSZ
         mMz05Ro7WEyYPA2YccwojVSyPUP6epyKTF0rgKJu4wo+whcPhi/aSRKw23YYIk8Td4PP
         9DZaOvzacVmJc57wUZvgG2A9t+t/L27rEY6lpi++mTSCU5zzrVu/J0Iofe/BZ7PvD3Ww
         l8ssw3nA+SsGXXUbbeQLNQHl5JQm0mP7D9IDS7iPZwLFscXJigU6IdJ9PfCt9AuEOQIB
         vYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731953; x=1766336753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2vJ1HOBNs8UzoO3Ll3Uv8AhoYKXTFMFCSXN6U+MUHc=;
        b=YYo1StWY7wVfo/qhOG9SdCZqe3JxJGqiXPX00vSlEX+F10XYNtNw5GnKJyN9krTUmP
         LIDOprPN9CYcx9r5w8YowO8AnNzPF6XjXIq1OBk1HN8E3Ydrm3qYfapbn1GIX9aEjloO
         9EX8f98W82trYoSAqG3v0P6k05Ih+rSEY6TyGcKbMWGUX2kozTAzfM9SJV3sXdcBlTy7
         v2vkuh8buwH/O3yLh44NojGoVKL5o7/g3qoGabfsJ8jTM+FqpMCfM+rsFZoHKBF9llwk
         qariIwAly6B/OUXfDEapx2Z0OPn4FZs9ilmJebY6wMFHkEyhOVrXufB+S4ijHRIw+mgY
         0lTw==
X-Forwarded-Encrypted: i=1; AJvYcCV6udKkYygFunHM4yWlGB5xYz2ILsSkYsUZMkKKrfiyHgTw3K3DhS/GZjffJ5Vr8k0a+kdISE/vQCbCtAYbpPgBnBKvQnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06U2tMHOZGQCtt+pEJzzunkwklDkEfRYhRBVuCg6R0dyXMBhf
	aNKF69g+KHSwdB+nAMthXSHwaAbKiqnx5cB+6fnEXk8T7P0z4PMNz9/L
X-Gm-Gg: AY/fxX7CMP0ef0luzEfWps8L6c9QRAsva4Jyk48rM2yqaGnX+QXu/hJ1jzgm+sLRjZx
	h3sQvndrkEq4LPvPB5FS+9JHrKZ9hz53NTtkk0VSBeqLHbZzMSCMlQcgVJts9M6mUr0e6FDiTi8
	0vJM//tTdaWCTJ+x6Chc8tfKzu3q6HqHQnZOFfEMGYozQ+HPB876BcM+2CZINM96waJnZzIChg6
	lyYO1NCU0wooI5PzR9dT0qUSRCflHSDFMhsWSSrD9xlPITvHyBhTEW1CnZqNXOeK58ZYHYdP3ZV
	KKHbty12a/9CiRpxyz5MRvFTNUGPSnY5Hg58g5Aha2g9a7QuxmN85oy6RQ1FbBh0Ze8nMbKBBK4
	BJtc0D8ck9+KPsiSr59X8zA33vQ7W+f0ZyTtHK4f2Ofwxydm4AydrYyMru5+u1JjWHgMtQP44wz
	+7/sJv15dzFHDMedjh6T/93riVJ1WwjLZeifU+9VlnpHi+XUlvUefgzxi7soAk
X-Google-Smtp-Source: AGHT+IG3oaYuiqZCcWfuHjE21fgKtoO9KaHwIt5dTfIcs6alQLBx4/Sap68zD/asZH/vWMzFemZkLg==
X-Received: by 2002:a05:690c:7489:b0:786:7a54:4624 with SMTP id 00721157ae682-78e66ca5ea5mr146619727b3.7.1765731953314;
        Sun, 14 Dec 2025 09:05:53 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e7683sm19401117b3.32.2025.12.14.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 09:05:52 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 1/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 14 Dec 2025 12:05:41 -0500
Message-ID: <20251214170548.408142-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214170548.408142-1-utilityemal77@gmail.com>
References: <20251214170548.408142-1-utilityemal77@gmail.com>
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

For example, if /a/b/c/ = read only + LANDLOCK_ADD_RULE_NO_INHERIT and
/ = read write, writes to files in /a/b/c will be denied. Moreover,
moving /a to /bad, removing /a/b/c, or creating links to /a will be
prohibited.

Parent flag inheritance is automatically suppressed by the permission
harvesting logic, which will finish processing early if all relevant
layers are tagged with NO_INHERIT.

The parent directory restrictions mitigate sandbox-restart attacks. For
example, if a sandboxed program is able to move a
LANDLOCK_ADD_RULE_NO_INHERIT restricted directory, upon sandbox restart,
the policy applied naively on the same filenames would be invalid.
Preventing these operations mitigates these attacks.

Because this requires path walking, to centralize the logic in a
single location, the path walking logic is moved into a helper function
landlock_walk_path_up, which takes a path as a parameter, and returns
an enum corresponding to whether the path is a mount root, real root,
or other.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: Mickaël Salaün <mic@digikod.net>
---

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
 security/landlock/fs.c        | 266 +++++++++++++++++++++++++---------
 security/landlock/ruleset.h   |  29 +++-
 3 files changed, 258 insertions(+), 66 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index d4f47d20361a..6ab3e7bd1c81 100644
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
+ *     In addition, this flag blocks the inheritance of rule-layer flags
+ *     (such as the quiet flag) from parent directories to the object covered
+ *     by this rule.
  */
 
 /* clang-format off */
 #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0b589263ea42..8d8623ea857f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -317,6 +317,37 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
+enum landlock_walk_result {
+	LANDLOCK_WALK_CONTINUE,
+	LANDLOCK_WALK_STOP_REAL_ROOT,
+	LANDLOCK_WALK_MOUNT_ROOT,
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
+			return LANDLOCK_WALK_MOUNT_ROOT;
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
@@ -344,6 +375,48 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
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
+	while (landlock_walk_path_up(&walker) != LANDLOCK_WALK_STOP_REAL_ROOT) {
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
@@ -772,8 +845,10 @@ static bool is_access_to_paths_allowed(
 		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
 	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
-	struct collected_rule_flags *rule_flags_parent1 = &log_request_parent1->rule_flags;
-	struct collected_rule_flags *rule_flags_parent2 = &log_request_parent2->rule_flags;
+	struct collected_rule_flags *rule_flags_parent1 =
+		&log_request_parent1->rule_flags;
+	struct collected_rule_flags *rule_flags_parent2 =
+		log_request_parent2 ? &log_request_parent2->rule_flags : NULL;
 
 	if (!access_request_parent1 && !access_request_parent2)
 		return true;
@@ -784,7 +859,7 @@ static bool is_access_to_paths_allowed(
 	if (is_nouser_or_private(path->dentry))
 		return true;
 
-	if (WARN_ON_ONCE(!layer_masks_parent1))
+	if (WARN_ON_ONCE(!layer_masks_parent1 || !log_request_parent1))
 		return false;
 
 	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
@@ -851,6 +926,7 @@ static bool is_access_to_paths_allowed(
 	 */
 	while (true) {
 		const struct landlock_rule *rule;
+		enum landlock_walk_result walk_res;
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -910,46 +986,14 @@ static bool is_access_to_paths_allowed(
 		if (allowed_parent1 && allowed_parent2)
 			break;
 
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
-			/*
-			 * We reached a disconnected root directory from a bind mount.
-			 * Let's continue the walk with the mount point we missed.
-			 */
-			dput(walker_path.dentry);
-			walker_path.dentry = walker_path.mnt->mnt_root;
-			dget(walker_path.dentry);
-		} else {
-			struct dentry *const parent_dentry =
-				dget_parent(walker_path.dentry);
-
-			dput(walker_path.dentry);
-			walker_path.dentry = parent_dentry;
+		walk_res = landlock_walk_path_up(&walker_path);
+		if (walk_res == LANDLOCK_WALK_MOUNT_ROOT) {
+			allowed_parent1 = true;
+			allowed_parent2 = true;
+			break;
 		}
+		if (walk_res != LANDLOCK_WALK_CONTINUE)
+			break;
 	}
 	path_put(&walker_path);
 
@@ -963,7 +1007,7 @@ static bool is_access_to_paths_allowed(
 			ARRAY_SIZE(*layer_masks_parent1);
 	}
 
-	if (!allowed_parent2) {
+	if (!allowed_parent2 && log_request_parent2) {
 		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
 		log_request_parent2->audit.u.path = *path;
@@ -1037,8 +1081,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
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
@@ -1060,29 +1104,31 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  */
 static bool collect_domain_accesses(
 	const struct landlock_ruleset *const domain,
-	const struct dentry *const mnt_root, struct dentry *dir,
+	const struct path *const mnt_root, const struct path *const dir,
 	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
 	struct collected_rule_flags *const rule_flags)
 {
 	unsigned long access_dom;
 	bool ret = false;
+	struct path walker;
 
 	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
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
@@ -1091,22 +1137,69 @@ static bool collect_domain_accesses(
 			ret = true;
 			break;
 		}
-
-		/*
-		 * Stops at the mount point or the filesystem root for a disconnected
-		 * directory.
-		 */
-		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
+		if (walker.dentry == mnt_root->dentry && walker.mnt == mnt_root->mnt)
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
+static int deny_no_inherit_topology_change(const struct landlock_cred_security
+					   *subject,
+					   const struct path *const path)
+{
+	layer_mask_t sealed_layers = 0;
+	layer_mask_t override_layers = 0;
+	const struct landlock_rule *rule;
+	u32 layer_index;
+	unsigned long audit_layer_index;
+
+	if (WARN_ON_ONCE(!subject || !path || !path->dentry || !path->mnt ||
+			 d_is_negative(path->dentry)))
+		return 0;
+
+	rule = find_rule(subject->domain, path->dentry);
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
+			.u.dentry = path->dentry,
+		},
+		.layer_plus_one = audit_layer_index + 1,
+	});
+	return -EACCES;
+}
+
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1191,6 +1284,21 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	access_request_parent2 =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
+		int err = deny_no_inherit_topology_change(subject,
+							  &(struct path)
+							  { .mnt = new_dir->mnt,
+							  .dentry = old_dentry });
+
+		if (err)
+			return err;
+		if (exchange) {
+			err = deny_no_inherit_topology_change(subject,
+							      &(struct path)
+							      { .mnt = new_dir->mnt,
+							      .dentry = new_dentry });
+			if (err)
+				return err;
+		}
 		access_request_parent1 |= maybe_remove(old_dentry);
 		access_request_parent2 |= maybe_remove(new_dentry);
 	}
@@ -1232,12 +1340,15 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 						      old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
+	allow_parent1 = collect_domain_accesses(subject->domain,
+						&mnt_dir,
+						&(struct path){ .mnt = new_dir->mnt,
+						.dentry = old_parent },
 						&layer_masks_parent1,
 						&request1.rule_flags);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
+	allow_parent2 = collect_domain_accesses(subject->domain, &mnt_dir,
+						&(struct path){ .mnt = new_dir->mnt,
+						.dentry = new_dir->dentry },
 						&layer_masks_parent2,
 						&request2.rule_flags);
 
@@ -1583,12 +1694,37 @@ static int hook_path_symlink(const struct path *const dir,
 static int hook_path_unlink(const struct path *const dir,
 			    struct dentry *const dentry)
 {
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
+	int err;
+
+	if (subject) {
+		err = deny_no_inherit_topology_change(subject,
+						      &(struct path)
+						      { .mnt = dir->mnt,
+						      .dentry = dentry });
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
+		err = deny_no_inherit_topology_change(subject,
+						      &(struct path)
+						      { .mnt = dir->mnt,
+						      .dentry = dentry });
+		if (err)
+			return err;
+	}
+
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
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


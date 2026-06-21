Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729E306776
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013951; cv=none; b=bvk2osN+FmN0GF8gYBEfMeoBYfEOAQpGI19XKK7Grp4lhA/sQCxD2qiVrcWhMCQPhNRpQYWgaFIHkQR8r7B9h43LibWl7Vtibkgo0GgIeDZOqpLZSGINgcrq1IGUj89GbCUADqTkcgexwQaZ8cKac/qSsqYcd9JD76TKW7ejyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013951; c=relaxed/simple;
	bh=rDGsCbs/KG/cPyJdMQCdjLz9mcy20G/E2pQI4i1uDSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij5/T2pqVQKH/yJE24Low9cFKpHoJf+C01vaGni/s+YhsMPi96aSeX6r6OCHIi80f61UZR1PpiS3VEzxeYr0QpFFFwS9LWgBpjHmEA5eFxlEamU8puGIPIcW8vS3Kb0RT277jKOiZM+JRmVLbWeyOyAIDga4n8VdWNetZtvqXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye7sSZzt; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye7sSZzt"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ff05e5d009so32349167b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013949; x=1782618749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQcFxepiO6pFBaqPLbqJDmB8+FYlddB4aPf/lTcVJu8=;
        b=Ye7sSZztgP1B2cnDajQQT+qdPWBAs1ECsK+JRAmYeJwub/lXf0acoqDgEaKE6vd1V4
         MjkEeeRf/eldVoA00tQkfHGqvO82Oi9BzFxTbrb8tcrCdpMpqQXycRfGZkdyAmczXAYK
         oKIVFXi3RrjTZCtPvvLo+sdwqxwBSybUH+wB1JaY8m+MzU2jRrOnGUEqQ3sADc8sjkL6
         M9Qe1itZAfnVP0Ar61FBNk9wkWGKw1he+XtDpOi124ZlxqXlSOVkXMW/SLL6R/9yK6gb
         IsCt7/C5+WnyrTYdMlvH/OCMEiNsTzpwB8v2yWdMLwq5pvhstrKHO/gzuOw9MJ1uTdvb
         jicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013949; x=1782618749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQcFxepiO6pFBaqPLbqJDmB8+FYlddB4aPf/lTcVJu8=;
        b=oYG+IXGNeMhCeLAUngCWnyJrUHxtXs/Di5vqZoACSuwJXabuee0WaOgidilGhHqIlG
         55qMYiBwjpQIQvvl3t84L5QVARRaDAErRKHavbr5xbgZzakMlKvOgQo63H25MJOINwDR
         CSFCw1pZ8XfOiuaHMJQjb6BhvjVUWCb+U5Og8UHUF8YEN5ROU73gpMIrRyAQHQVIjVi4
         Y8brc3tPIyHhl8bP4vioMaK9Pl1hFQmoUluoZ9EPyerjrWbA/KVI1+N0Z1WM3L0Y38Fn
         6rz525iqr6sdwVMtf0uMhNhKrS2KOCrvwBCHu8uT9YnDN2NsP2rhQKx3byzuo9LLwWoo
         v9WQ==
X-Gm-Message-State: AOJu0YxNAqur0AeypmKUA8MSloK86i7YthP7LrhV9sF77DoJZUHYpANv
	5PSV/qjnhBq0SbiI1NbrL3xHGhnajtRn+vgisrnv6UFZ10zhs/QDZThefeEbPw==
X-Gm-Gg: AfdE7cmn9eK+1ZbZxOjRNgPY3iV6zAmKZ7N7qKIn0eC+pXzztF7dyrGID3iyMtHqziB
	5vb5HFeF8Mek3OBMCt9AuBSBnRGA0PxRqV/IPokpYRU8GhoLEX2LZ81ooGuruBIyDSryGlRu8ll
	/raYQVnQqqxdx1Si81+x/UKnjSmIDZLUNRHE5X4xJpQ2ZZ/gnwb7O3m3HoBU+V8UFojtT4lEh0/
	EKGvtSHpkIxoQg8Zn4T5y/BDTiaPolrL+axGAuz9nYiMO3nTVWoeJBycQ8Ai5JISRApxbKYFmoQ
	0qmqRf9tlQwN3DYmx85djSEaOSkwi1jflTwyuFtcTsx5C8jyZRNi6pgskzP97EA03lWY1mR3FHb
	VCKdZKCjHrrhj2aaWpuu6RsavtT4EGdKTYFPBg141v8CW5/Fe4j/vagnlSCfFEKhoa3Btgm21Ev
	azF6CZ88eJkqOWmj0IKBP0pS1Hy+87Yd8YsWxzmGMoVdwDcQ==
X-Received: by 2002:a05:690c:67c6:b0:7bd:6a98:58d7 with SMTP id 00721157ae682-8017817bb88mr86016647b3.38.1782013948525;
        Sat, 20 Jun 2026 20:52:28 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:28 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 1/9] landlock: Add and use landlock_walk_path_up() helper
Date: Sat, 20 Jun 2026 23:52:14 -0400
Message-ID: <20260621035223.2651547-2-utilityemal77@gmail.com>
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

Centralize the open-coded path-walk logic in fs.c by adding
landlock_walk_path_up(), which moves @path one step toward the VFS
root.  Its return value indicates whether the new position is an
internal mount point, the real root, or neither (i.e. the caller
should continue walking).

Convert the two open-coded walks to the helper:

- is_access_to_paths_allowed() loses its backward goto.
- collect_domain_accesses() additionally changes its signature from
  (mnt_root, dir) to a single struct path, so the caller's mount point
  and starting dentry are both carried in @path, keeping the traversal
  logic consistent between the two callers.

No functional change intended.

Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Squashed the three v8 patches ("Add landlock_walk_path_up() helper",
      "Use ... in is_access_to_paths_allowed()", and "Use ... in
      collect_domain_accesses()") into this single patch.
    - landlock_walk_path_up() now advances @path to the mount root before
      returning LANDLOCK_WALK_INTERNAL, instead of leaving it on the
      disconnected root, so callers can follow_up() into the parent mount.
      Updated the enum landlock_walk_result kerneldoc to match.
    - Reworded the current_check_refer_path() comment to explain that
      i_rwsem is held and collect_domain_accesses() takes its own reference.
    - Rebased onto mic/next.

 security/landlock/fs.c | 176 ++++++++++++++++++++++++-----------------
 1 file changed, 103 insertions(+), 73 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6292887e6cef..5b9cc450d614 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -320,6 +320,48 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 /* clang-format on */
 
+/**
+ * enum landlock_walk_result - Result codes for landlock_walk_path_up()
+ * @LANDLOCK_WALK_CONTINUE: Path advanced one step and is now neither the real
+ *	root nor the root of an internal mount point.
+ * @LANDLOCK_WALK_STOP_REAL_ROOT: Path has reached the real VFS root.
+ * @LANDLOCK_WALK_INTERNAL: Path advanced past the disconnected root of an
+ *	internal mount point (e.g. nsfs) and now sits at that mount's root.
+ */
+enum landlock_walk_result {
+	LANDLOCK_WALK_CONTINUE,
+	LANDLOCK_WALK_STOP_REAL_ROOT,
+	LANDLOCK_WALK_INTERNAL,
+};
+
+static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
+{
+	struct dentry *old;
+
+	while (path->dentry == path->mnt->mnt_root) {
+		if (!follow_up(path))
+			return LANDLOCK_WALK_STOP_REAL_ROOT;
+	}
+	old = path->dentry;
+	if (unlikely(IS_ROOT(old))) {
+		/*
+		 * Reached a disconnected root: advance to the mount root so
+		 * that the next call can follow_up() to the parent mount.
+		 * Internal mounts (e.g. nsfs, reachable through
+		 * /proc/<pid>/ns/<namespace>) are reported so that callers can
+		 * stop the walk there.
+		 */
+		path->dentry = dget(path->mnt->mnt_root);
+		dput(old);
+		if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
+			return LANDLOCK_WALK_INTERNAL;
+		return LANDLOCK_WALK_CONTINUE;
+	}
+	path->dentry = dget_parent(old);
+	dput(old);
+	return LANDLOCK_WALK_CONTINUE;
+}
+
 /*
  * @path: Should have been checked by get_path_from_fd().
  */
@@ -889,46 +931,27 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
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
+		switch (landlock_walk_path_up(&walker_path)) {
+		case LANDLOCK_WALK_CONTINUE:
+			continue;
+		case LANDLOCK_WALK_INTERNAL:
 			/*
-			 * We reached a disconnected root directory from a bind mount.
-			 * Let's continue the walk with the mount point we missed.
+			 * Stops and allows access when reaching disconnected
+			 * root directories that are part of internal
+			 * filesystems (e.g. nsfs, which is reachable through
+			 * /proc/<pid>/ns/<namespace>).
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
+		case LANDLOCK_WALK_STOP_REAL_ROOT:
+			/*
+			 * Stops at the real root.  Denies access because not
+			 * all layers have granted access.
+			 */
+			break;
 		}
+		break;
 	}
 	path_put(&walker_path);
 
@@ -1019,48 +1042,51 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * collect_domain_accesses - Walk through a file path and collect accesses
  *
  * @domain: Domain to check against.
- * @mnt_root: Last directory to check.
- * @dir: Directory to start the walk from.
+ * @path: Path to start the walk from and whose mount root is the last
+ *     directory to check.
  * @layer_masks_dom: Where to store the collected accesses.
  *
- * This helper is useful to begin a path walk from the @dir directory to a
- * @mnt_root directory used as a mount point.  This mount point is the common
- * ancestor between the source and the destination of a renamed and linked
- * file.  While walking from @dir to @mnt_root, we record all the domain's
- * allowed accesses in @layer_masks_dom.
+ * This helper is useful to begin a path walk from @path to the mount root
+ * directory used as a mount point.  This mount point is the common ancestor
+ * between the source and the destination of a renamed and linked file.  While
+ * walking from @path to that mount root, we record all the domain's allowed
+ * accesses in @layer_masks_dom.
  *
- * Because of disconnected directories, this walk may not reach @mnt_dir.  In
- * this case, the walk will continue to @mnt_dir after this call.
+ * Because of disconnected directories, this walk may not reach that mount
+ * root.  In this case, the walk will continue to the mount root after this
+ * call.
  *
  * This is similar to is_access_to_paths_allowed() but much simpler because it
  * only handles walking on the same mount point and only checks one set of
  * accesses.
  *
- * Return: True if all the domain access rights are allowed for @dir, false if
- * the walk reached @mnt_root.
+ * Return: True if all the domain access rights are allowed for @path, false if
+ * the walk reached the mount root.
  */
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
-				    const struct dentry *const mnt_root,
-				    struct dentry *dir,
-				    struct layer_masks *layer_masks_dom)
+static bool
+collect_domain_accesses(const struct landlock_ruleset *const domain,
+			const struct path *const path,
+			struct layer_masks *layer_masks_dom)
 {
 	bool ret = false;
+	struct path walker_path;
 
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
+	if (WARN_ON_ONCE(!domain || !path || !path->dentry || !path->mnt ||
+			 !layer_masks_dom))
 		return true;
-	if (is_nouser_or_private(dir))
+	if (is_nouser_or_private(path->dentry))
 		return true;
 
 	if (!landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
 				       layer_masks_dom, LANDLOCK_KEY_INODE))
 		return true;
 
-	dget(dir);
+	walker_path = *path;
+	path_get(&walker_path);
 	while (true) {
-		struct dentry *parent_dentry;
-
 		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir),
+		if (landlock_unmask_layers(find_rule(domain,
+						     walker_path.dentry),
 					   layer_masks_dom)) {
 			/*
 			 * Stops when all handled accesses are allowed by at
@@ -1074,14 +1100,16 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
 		 * Stops at the mount point or the filesystem root for a disconnected
 		 * directory.
 		 */
-		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
+		if ((walker_path.dentry == path->mnt->mnt_root &&
+		     walker_path.mnt == path->mnt) ||
+		    unlikely(IS_ROOT(walker_path.dentry)))
 			break;
 
-		parent_dentry = dget_parent(dir);
-		dput(dir);
-		dir = parent_dentry;
+		if (WARN_ON_ONCE(landlock_walk_path_up(&walker_path) !=
+				 LANDLOCK_WALK_CONTINUE))
+			break;
 	}
-	dput(dir);
+	path_put(&walker_path);
 	return ret;
 }
 
@@ -1147,7 +1175,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	bool allow_parent1, allow_parent2;
 	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	struct dentry *old_parent;
+	struct path old_parent_path;
 	struct layer_masks layer_masks_parent1 = {}, layer_masks_parent2 = {};
 	struct landlock_request request1 = {}, request2 = {};
 
@@ -1201,18 +1229,20 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/*
 	 * old_dentry may be the root of the common mount point and
 	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
-	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
-	 * we keep a reference to old_dentry.
+	 * OPEN_TREE_CLONE).  Reading old_dentry->d_parent without a reference is
+	 * safe because the directories' i_rwsem are held across the hook;
+	 * collect_domain_accesses() takes its own reference before walking.
 	 */
-	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
-						      old_dentry->d_parent;
+	old_parent_path.mnt = mnt_dir.mnt;
+	old_parent_path.dentry = (old_dentry == mnt_dir.dentry) ?
+					 old_dentry :
+					 old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
+	allow_parent1 = collect_domain_accesses(subject->domain,
+						&old_parent_path,
 						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
+	allow_parent2 = collect_domain_accesses(subject->domain, new_dir,
 						&layer_masks_parent2);
 	if (allow_parent1 && allow_parent2)
 		return 0;
@@ -1231,7 +1261,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		return 0;
 
 	if (request1.access) {
-		request1.audit.u.path.dentry = old_parent;
+		request1.audit.u.path.dentry = old_parent_path.dentry;
 		landlock_log_denial(subject, &request1);
 	}
 	if (request2.access) {
-- 
2.54.0


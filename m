Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2861E25F4
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475032; cv=none; b=BQiyoKv4Yfa7GNODeNsxMpUBJQfaqvQ5JQXgO/Iw2P4Iapr0mmOurhO2dFhi6/dM7teSLeuNcarml/KKfcKo6n+dhw4MA9y8S1X4HQoS7Ul8X5L8g9aroNEf5FQ4ll5qRF51D+dx8b55GgePH+ZZYH1D2QWVRgJH1HShQG89FLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475032; c=relaxed/simple;
	bh=PfYxg4mZJv6YqheA/gYG6o/BGUYb3G599Fw74I7OTW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzp93m+aLQeFME8X2Kt9rRrMiria1kT0ljkw1cueuMlrMok3J93iHJJHunm2+57xuVCgezKO1Ph1rdLGLL9mvMyOF4bW12QHaGjTBtHywisbG+vpvkg1MSWWz1DoCb9ayzcSzNuSp1vb1T2+YnKFFRaCWOYLIqHL7YVoRavWtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OOAWONrX; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OOAWONrX"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2164b1f05caso26445955ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 18:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736475028; x=1737079828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3YgARbk8bwWmg3ZP2FifjyABqR7kc6RTmRRVGa2mL8=;
        b=OOAWONrXidMs11RaoB60DFQy9G7iJxScb7ZY+TAEvMuEFHSM7wKcfdhETtiDQwFj98
         4JVO1sqjcdUdN5oXs5A6LwUf7NT4iSCccw8QKoJoli+mi58LVsfdm45Ht8gW58VoYeB5
         ZwapkA918HbnOg1a33oZuOwWmU6id77mTnNJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736475028; x=1737079828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3YgARbk8bwWmg3ZP2FifjyABqR7kc6RTmRRVGa2mL8=;
        b=sjOLSZCDxL0ELeuMDj2lPFTvezEn4RRJkoer2xzO4eqzPqI1MGMKrjlJwrzs4dsO5/
         IYiH7bI1/GvYrm7SaS9z1sxuyuo4Q6GoCqKOipu7GpCjfU4DVAEvn9EsVrAgVloIwXcR
         fP1WBInJrkawO5vzfTl4ttQgdg1l3+/eMXy7v9vdRo8hwm+5pezc8BLmWiG5vo4kAXko
         S3rd4lSyQSPpkSOZKGX/6X5/Km2NrGVXKgeWUWoVdXp0z/1B7yQFdCTlRtr3SD0sUyQ8
         VkZP8/nwkR4idQxv5VVfqMlBpPNCG7uQqoHDz4pyosF7YKPgLtIQ8EaWGWGFv7DZM1Q5
         Zv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjfGcXYoCykCi6KJjktSQgpZ4LBm5YMD27Lt9Ep4di3OLfR/3XklFE3h0u2XaIZq8dO+aJEdYpe1NkH2mRjNvXO2k/MQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEpoCYvC8jrAW3KDRdH1jNK5Y4QpeDBWwAqmT/5pmeP5qgrfL
	9wN+g3cgVJ4YXdHmkeaZa/5wCLBi7AhBYK9OerarnsGakg9sbburQbrQPlC6OA==
X-Gm-Gg: ASbGncunIQqmj5uRUGVzKbBaVVglze0pH7CpTk+aa46YsTn86t8RNWGzjblHGVhwroE
	b/hOdUXjhjvLsB20nOHqo+JdOC7ZlqwbUmwX0KTEkZG02T6rMq8Kq3zegEW76o51iPIc1DP8SOI
	FGk6PvT2yJQnt4q8gXbEC5gVwKJ0zRieCh12ASRZdoiw/K5knwUHh7ydy6ADie+MrEtuH+cI0T1
	eraybda7LMyyRYNSiEiKbw8l6q0pHTx+6nJkQOTJ+MzBtbzOpv4u6T+4dPBa1rNZ6j7CzCMkUa1
	WJqmjt3D4g==
X-Google-Smtp-Source: AGHT+IFuSSTuIw+SztGN5/SZAEfu9ZIa5Cbb/LtcIazkeOx3OvE2HzbvmGV0WXyRIkR85Q2gMR1vMg==
X-Received: by 2002:a05:6a00:948a:b0:725:f1b1:cbc5 with SMTP id d2e1a72fcca58-72d21f7e7c3mr12446698b3a.3.1736475028454;
        Thu, 09 Jan 2025 18:10:28 -0800 (PST)
Received: from enlightened2.mtv.corp.google.com ([2620:15c:9d:4:17ed:36c7:e5c0:d447])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e056063sm1671649a12.31.2025.01.09.18.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 18:10:28 -0800 (PST)
From: Shervin Oloumi <enlightened@chromium.org>
To: mic@digikod.net,
	viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gnoack@google.com,
	shuah@kernel.org,
	jorgelo@chromium.org,
	allenwebb@chromium.org,
	Shervin Oloumi <enlightened@chromium.org>
Subject: [PATCH v3 2/2] landlock: add support for private bind mount
Date: Thu,  9 Jan 2025 18:10:08 -0800
Message-ID: <20250110021008.2704246-2-enlightened@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250110021008.2704246-1-enlightened@chromium.org>
References: <20250110021008.2704246-1-enlightened@chromium.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new LandLock rule, LANDLOCK_ACCESS_FS_MOUNT for
controlling bind mount operations. While this patch mostly focuses on
bind mounts, the long-term goal is to utilize this rule for controlling
regular device mounts as well. To perform a successful bind mount, both
the source parent and the destination need to have the REFER rule and
the destination needs to carry the MOUNT rule. Note that this does imply
that the MOUNT rule needs to also exist in the source hierarchy, to
avoid rejection due to privilege escalation. The same path access logic
as REFER (used for rename/move and link) is used to check for any
possible privilege escalations before allowing the bind mount.

Additionally, only private bind mounts are allowed. This is to avoid
filesystem hierarchy changes that happen through mount propagation
between peer mount groups. For instance, bind mounting a directory in a
shared mount namespace, can result in hierarchy changes propagating
across the peer groups in that namespace. Such changes cannot be checked
for privilege escalation as the REFER check only covers the source and
the destination surfaced in the bind mount hook function. We do allow
recursive bind mounts. This is safe because, if a bind mount already
exists in some location, it must have passed the REFER check, so if its
parent passes the REFER check with respect to a new mount point, by
definition the child bind mount also passes the REFER check with respect
to that new mount point, and so it can be safely cloned to the new
location along with its predecessor bind mount.

If a bind mount request carries a --make-shared flag, or any flag other
than --make-private, the bind mount succeeds while the subsequent
propagation type change attempt fails. This is because, the kernel calls
the mount hook twice, first with the MS_BIND flag, and then with the
flag for the propagation type change. If the bind mount request carries
the --make-private flag, both the mount operation and the subsequent
propagation type change succeed. Any mount request with --make-private
or --make-rprivate flags are also allowed. Such requests operate on
existing mount points, changing the propagation type to private. In this
case any previously propagated mounts would continue to exist, but
additional bind mounts under the newly privatized mount point, would not
propagate anymore.

Finally, any existing mounts or bind mounts before the process enters a
LandLock domain remain as they are. Such mounts can be of the shared
propagation type, and they would continue to share updates with the rest
of their peer group. While this is an existing behavior, after this
patch such mounts can also be remounted as private, or be unmounted
after the process enters the sandbox. Existing mounts are outside the
scope of LandLock and should be considered before entering the sandbox.

Tests: Regular mount is rejected. Bind mount is rejected if either the
source parent or the mount point do not have the REFER rule, or if the
destination does not have the MOUNT rule. Bind mount is allowed only if
the REFER check passes, i.e.: no restrictions are dropped. Recursive
bind mounts are allowed, as long as they abide by the same rules. Bind
mounting a directory onto itself is always allowed. Mount calls with the
flags --make-private or --make-rprivate are always allowed. Unmounting
is always allowed. Link and rename functionality is unaffected. All
LandLock filesystem tests pass.

Link: https://github.com/landlock-lsm/linux/issues/14
Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
---

Changes since v2:
- Change the flag check conditions in the main mount hook function to
  allow any type of request carrying MS_BIND or MS_PRIVATE, as opposed
  to requests carrying only those flags, effectively allowing MS_REC
- Update the LandLock filesystem self tests to reflect the condition
  change that results in MS_PRIVATE | MS_REC succeeding
- Update the bind mount tests for readability
- Update the commit message to reflect the above updates

Changes since v1:
- Update the failing static assert in ruleset.h
- Update the bind mount hook function to include the newly added
  argument, recurse
---
 include/uapi/linux/landlock.h              |   1 +
 security/landlock/fs.c                     | 104 ++++++++++++-------
 security/landlock/limits.h                 |   2 +-
 security/landlock/ruleset.h                |   6 +-
 tools/testing/selftests/landlock/fs_test.c | 114 +++++++++++++++++++--
 5 files changed, 175 insertions(+), 52 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f787..10541a001f2f 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -259,6 +259,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_MOUNT			(1ULL << 16)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e31b97a9f175..df0a3094d90b 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
+#include <uapi/linux/mount.h>
 
 #include "common.h"
 #include "cred.h"
@@ -1033,34 +1034,36 @@ static bool collect_domain_accesses(
 }
 
 /**
- * current_check_refer_path - Check if a rename or link action is allowed
+ * current_check_reparent_path - Check if a reparent action is allowed
  *
- * @old_dentry: File or directory requested to be moved or linked.
- * @new_dir: Destination parent directory.
+ * @old_dentry: Source file or directory for move, link or bind mount.
+ * @new_dir: Destination parent directory for move and link, or destination
+ *     directory itself for bind mount (mount point).
  * @new_dentry: Destination file or directory.
  * @removable: Sets to true if it is a rename operation.
  * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
+ * @bind_mount: Sets to true if it is a bind mount operation.
  *
  * Because of its unprivileged constraints, Landlock relies on file hierarchies
- * (and not only inodes) to tie access rights to files.  Being able to link or
- * rename a file hierarchy brings some challenges.  Indeed, moving or linking a
- * file (i.e. creating a new reference to an inode) can have an impact on the
- * actions allowed for a set of files if it would change its parent directory
- * (i.e. reparenting).
+ * (and not only inodes) to tie access rights to files.  Being able to link,
+ * rename or bind mount a file hierarchy brings some challenges.  Indeed, these
+ * operations create a new reference to an inode, which can have an impact on
+ * the actions allowed for a set of files if it would change its parent
+ * directory (i.e. reparenting).
  *
  * To avoid trivial access right bypasses, Landlock first checks if the file or
  * directory requested to be moved would gain new access rights inherited from
  * its new hierarchy.  Before returning any error, Landlock then checks that
  * the parent source hierarchy and the destination hierarchy would allow the
- * link or rename action.  If it is not the case, an error with EACCES is
- * returned to inform user space that there is no way to remove or create the
- * requested source file type.  If it should be allowed but the new inherited
- * access rights would be greater than the source access rights, then the
- * kernel returns an error with EXDEV.  Prioritizing EACCES over EXDEV enables
+ * link, rename or bind mount action.  If it is not the case, an error with
+ * EACCES is returned to inform user space that there is no way to remove or
+ * create the requested source file type.  If it should be allowed but the new
+ * inherited access rights would be greater than the source access rights, then
+ * the kernel returns an error with EXDEV or EPERM.  Prioritizing EACCES enables
  * user space to abort the whole operation if there is no way to do it, or to
  * manually copy the source to the destination if this remains allowed, e.g.
  * because file creation is allowed on the destination directory but not direct
- * linking.
+ * linking, or bind mounting.
  *
  * To achieve this goal, the kernel needs to compare two file hierarchies: the
  * one identifying the source file or directory (including itself), and the
@@ -1082,13 +1085,18 @@ static bool collect_domain_accesses(
  *
  * Returns:
  * - 0 if access is allowed;
- * - -EXDEV if @old_dentry would inherit new access rights from @new_dir;
+ * - -EXDEV if @old_dentry would inherit new access rights from @new_dir through
+ *       link or rename.
+ * - -EPERM if @old_dentry would inherit new access rights from @new_dir through
+ *       bind mount.
  * - -EACCES if file removal or creation is denied.
  */
-static int current_check_refer_path(struct dentry *const old_dentry,
-				    const struct path *const new_dir,
-				    struct dentry *const new_dentry,
-				    const bool removable, const bool exchange)
+static int current_check_reparent_path(struct dentry *const old_dentry,
+				       const struct path *const new_dir,
+				       struct dentry *const new_dentry,
+				       const bool removable,
+				       const bool exchange,
+				       const bool bind_mount)
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
 	bool allow_parent1, allow_parent2;
@@ -1120,7 +1128,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	}
 
 	/* The mount points are the same for old and new paths, cf. EXDEV. */
-	if (old_dentry->d_parent == new_dir->dentry) {
+	if ((bind_mount && old_dentry == new_dentry) ||
+	    (!bind_mount && old_dentry->d_parent == new_dentry->d_parent)) {
 		/*
 		 * The LANDLOCK_ACCESS_FS_REFER access right is not required
 		 * for same-directory referer (i.e. no reparenting).
@@ -1160,6 +1169,14 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	if (allow_parent1 && allow_parent2)
 		return 0;
 
+	if (bind_mount) {
+		if (!is_access_to_paths_allowed(
+			    dom, new_dir, LANDLOCK_ACCESS_FS_MOUNT,
+			    &layer_masks_parent2, NULL, 0, NULL, NULL)) {
+			return -EPERM;
+		}
+	}
+
 	/*
 	 * To be able to compare source and destination domain access rights,
 	 * take into account the @old_dentry access rights aggregated with its
@@ -1173,7 +1190,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		return 0;
 
 	/*
-	 * This prioritizes EACCES over EXDEV for all actions, including
+	 * This prioritizes EACCES over EXDEV/EPERM for all actions, including
 	 * renames with RENAME_EXCHANGE.
 	 */
 	if (likely(is_eacces(&layer_masks_parent1, access_request_parent1) ||
@@ -1186,6 +1203,8 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
 	 * source or the destination.
 	 */
+	if (bind_mount)
+		return -EPERM;
 	return -EXDEV;
 }
 
@@ -1319,9 +1338,11 @@ static void hook_sb_delete(struct super_block *const sb)
  * topology (i.e. the mount namespace), changing it may grant access to files
  * not previously allowed.
  *
- * To make it simple, deny any filesystem topology modification by landlocked
- * processes.  Non-landlocked processes may still change the namespace of a
- * landlocked process, but this kind of threat must be handled by a system-wide
+ * Currently, we can safely handle private bind mounts, as the source and
+ * destination restrictions can be compared, however all other types of mount
+ * system calls are blocked, including shared bind mounts and device mounts.
+ * Non-landlocked processes may still change the namespace of a landlocked
+ * process, but this kind of threat must be handled by a system-wide
  * access-control security policy.
  *
  * This could be lifted in the future if Landlock can safely handle mount
@@ -1338,22 +1359,26 @@ static int hook_sb_mount(const char *const dev_name,
 {
 	if (!get_current_fs_domain())
 		return 0;
+
+	/*
+	 * Allow bind mount and make-private requests to proceed, including requests
+	 * with the MS_REC flag.  For bind mount requests, further security checks
+	 * are performed in the bind mount specific hook.
+	 */
+	if (flags && ((MS_BIND | MS_PRIVATE) & flags))
+		return 0;
 	return -EPERM;
 }
 
-static int hook_move_mount(const struct path *const from_path,
-			   const struct path *const to_path)
+static int hook_sb_bindmount(const struct path *const old_path,
+			     const struct path *const path, bool recurse)
 {
-	if (!get_current_fs_domain())
-		return 0;
-	return -EPERM;
+	return current_check_reparent_path(old_path->dentry, path, path->dentry,
+					   false, false, true);
 }
 
-/*
- * Removing a mount point may reveal a previously hidden file hierarchy, which
- * may then grant access to files, which may have previously been forbidden.
- */
-static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
+static int hook_move_mount(const struct path *const from_path,
+			   const struct path *const to_path)
 {
 	if (!get_current_fs_domain())
 		return 0;
@@ -1389,8 +1414,8 @@ static int hook_path_link(struct dentry *const old_dentry,
 			  const struct path *const new_dir,
 			  struct dentry *const new_dentry)
 {
-	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+	return current_check_reparent_path(old_dentry, new_dir, new_dentry,
+					   false, false, false);
 }
 
 static int hook_path_rename(const struct path *const old_dir,
@@ -1400,8 +1425,9 @@ static int hook_path_rename(const struct path *const old_dir,
 			    const unsigned int flags)
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
-	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE));
+	return current_check_reparent_path(old_dentry, new_dir, new_dentry,
+					   true, !!(flags & RENAME_EXCHANGE),
+					   false);
 }
 
 static int hook_path_mkdir(const struct path *const dir,
@@ -1652,8 +1678,8 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
+	LSM_HOOK_INIT(sb_bindmount, hook_sb_bindmount),
 	LSM_HOOK_INIT(move_mount, hook_move_mount),
-	LSM_HOOK_INIT(sb_umount, hook_sb_umount),
 	LSM_HOOK_INIT(sb_remount, hook_sb_remount),
 	LSM_HOOK_INIT(sb_pivotroot, hook_sb_pivotroot),
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 15f7606066c8..b495b15df25d 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MOUNT
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 631e24d4ffe9..62e1db3dd95a 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -31,7 +31,7 @@
 	LANDLOCK_ACCESS_FS_REFER)
 /* clang-format on */
 
-typedef u16 access_mask_t;
+typedef u32 access_mask_t;
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 /* Makes sure all network access rights can be stored. */
@@ -50,11 +50,11 @@ struct access_masks {
 
 union access_masks_all {
 	struct access_masks masks;
-	u32 all;
+	u64 all;
 };
 
 /* Makes sure all fields are covered. */
-static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
+static_assert(sizeof(typeof_member(union access_masks_all, masks)) <=
 	      sizeof(typeof_member(union access_masks_all, all)));
 
 typedef u16 layer_mask_t;
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6788762188fe..ab59bea0125b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -274,6 +274,11 @@ static int mount_opt(const struct mnt_opt *const mnt, const char *const target)
 		     mnt->data);
 }
 
+static int bindmount(const char *const source, const char *const target)
+{
+	return mount(source, target, NULL, MS_BIND, NULL);
+}
+
 static void prepare_layout_opt(struct __test_metadata *const _metadata,
 			       const struct mnt_opt *const mnt)
 {
@@ -558,7 +563,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_MOUNT
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
@@ -572,7 +577,8 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	LANDLOCK_ACCESS_FS_REFER)
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_MOUNT)
 
 /* clang-format on */
 
@@ -1735,14 +1741,14 @@ TEST_F_FORK(layout1, topology_changes_with_net_only)
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
-	/* Mount, remount, move_mount, umount, and pivot_root checks. */
+	/* Mount, remount, move_mount, pivot_root and umount checks. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s1d2));
 	ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC, NULL));
 	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
 			     dir_s2d2, 0));
-	ASSERT_EQ(0, umount(dir_s2d2));
 	ASSERT_EQ(0, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(0, umount(dir_s2d2));
 	ASSERT_EQ(0, chdir("/"));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -1763,19 +1769,17 @@ TEST_F_FORK(layout1, topology_changes_with_net_and_fs)
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
-	/* Mount, remount, move_mount, umount, and pivot_root checks. */
+	/* Mount, remount, move_mount, pivot_root and umount checks. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount_opt(&mnt_tmp, dir_s1d2));
 	ASSERT_EQ(EPERM, errno);
-	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC, NULL));
-	ASSERT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			      dir_s2d2, 0));
 	ASSERT_EQ(EPERM, errno);
-	ASSERT_EQ(-1, umount(dir_s3d2));
-	ASSERT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
 	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(0, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(0, umount(dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -3029,6 +3033,98 @@ TEST_F_FORK(layout1, reparent_remove)
 	ASSERT_EQ(EACCES, errno);
 }
 
+TEST_F_FORK(layout1, reparent_bindmount_deny)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MOUNT |
+				  LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MOUNT |
+				  LANDLOCK_ACCESS_FS_READ_DIR |
+				  LANDLOCK_ACCESS_FS_MAKE_DIR,
+		},
+		{
+			.path = dir_s3d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_READ_DIR |
+				  LANDLOCK_ACCESS_FS_MAKE_DIR,
+		},
+		{},
+	};
+	const int ruleset_fd =
+		create_ruleset(_metadata, layer1[1].access, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* Privilege escalation (FS_MAKE_DIR). */
+	ASSERT_EQ(-1, bindmount(dir_s1d2, dir_s2d2));
+	ASSERT_EQ(EPERM, errno);
+
+	/* Mount point missing FS_MOUNT. */
+	ASSERT_EQ(-1, bindmount(dir_s2d2, dir_s3d2));
+	ASSERT_EQ(EPERM, errno);
+
+	/* Mount point missing permissions other than FS_MOUNT. */
+	ASSERT_EQ(-1, bindmount(dir_s2d2, dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Missing permissions other than FS_MOUNT, for a self bind mount. */
+	ASSERT_EQ(-1, bindmount(dir_s1d2, dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+TEST_F_FORK(layout1, reparent_bindmount_allow)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MOUNT,
+		},
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MOUNT |
+				  LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{
+			.path = dir_s3d1,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{},
+	};
+	const int ruleset_fd =
+		create_ruleset(_metadata, layer1[1].access, layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* Mount point has more restrictions than the source. */
+	ASSERT_EQ(0, bindmount(dir_s2d2, dir_s1d2));
+	ASSERT_EQ(0, umount(dir_s1d2));
+
+	/* Bind mounting a directory on itself with no FS_MOUNT. */
+	ASSERT_EQ(0, bindmount(dir_s3d2, dir_s3d2));
+	ASSERT_EQ(0, umount(dir_s3d2));
+
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
 TEST_F_FORK(layout1, reparent_dom_superset)
 {
 	const struct rule layer1[] = {
-- 
2.47.1.613.gc27f4b7a9f-goog


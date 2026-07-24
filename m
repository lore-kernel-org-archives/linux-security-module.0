Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3973B4EBD
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909425; cv=none; b=C+IAgxIfoplBlE2mWDgth6JsG8htyfFWaY+AxZLGc/juBz0ndOAfnJP8Y+1Cv1qRw0IuoafzkA8zTRZMG4TXcoeyoOcfgNqIs6lB1By2me+HEpJ3A04PIv3GlWzFaWka7mmfQQ0zRLjFNhI0hi6O2XqcbnQf2HSZWXDOP7kicmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909425; c=relaxed/simple;
	bh=4eG8PmtsvHxThrCkPC4um78sn9mPoy8mRr2ZZu2d2oU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLnWPwbJwiQURMZm66qw10jOIbU43aNs4GX3tDK9jZuHQn/BqfKMBqoXqZjVrTOL7gGe5SXNXvQoRMuOvH9s32jiv/i2QaLHdaVpImNAxcNOXX9SG0KfnsO44nZE4o+00bHM5BKJdxeCaulB5ml1TSzD1qYLkwRTOC0ckAuvX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngRPX2TY; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngRPX2TY"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c232fa136so90825266b.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784909422; x=1785514222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wEYnayFwedtiX0CKFBB1fX9jrAB3fZaGlpkWRix27Q0=;
        b=ngRPX2TY9GR70IcWRsVh94QPCv6wW+9IGLY7SXiG7izCM8bgBtgf96Vuw82fefok04
         zzBHJnvjdsYXQWq4L+1TDJYXs6kH69sUTOd+nVsqPP1CSHz4uSpELsf/KnVVAZWYS91P
         OF1six8B8onS9ByZ3LbJNzTk76dSLi6jnd+JgHROPNXF1WHWY7wbHay+AA5V3ciDObBk
         zflv85IMdzP4FHNhP4S5MElEeEK4VHmzf/C72DsAsqDu9H5ip6sgPr0hr0R2NfwpFVg8
         o9OUhuYwG5AvhFFstT5+hqbYzucWIv8wlrQJ96R3sodYhDVV6/KUiJJCMo8Dgjn5XAFb
         BCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909422; x=1785514222;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEYnayFwedtiX0CKFBB1fX9jrAB3fZaGlpkWRix27Q0=;
        b=XqKqa0uPc9TDefnzKHCW4Nt0/URk94hjE/sKnXZ+cYFzfCuGso/eYFnVi7GJ3H5SRU
         zmaU/akzZIEiP7vz1kPWFWnmhaMgM7x6OQ0yIU2c6Y2G9yzpIHF6D1oZrokWlETLVydx
         S45YxkQ4QAFLwonSI4uoGmjP3V2epKIuL6XqHQGzLwFbNg+NTFd8zTcfNtiiL4mTFPwB
         6xujnys3qEGLwJHn6kbk+hlG2+qfY0RKcLTYE6iHfWM1Eq+dxX8lahTw4LvmXIUtF+/4
         KYnAjUg4k3uQylCdGUYCWybSYNL0lViFxUxNmf5S/AVqTBGAbQjBz0dl/6EpODmx18VH
         Sryw==
X-Gm-Message-State: AOJu0YzGNx7GJ4hJRQJlZTOGxoYlgd/8Ujp/s4+4RG/6hEgAel/YOw+r
	jPzjFws8UfDG7l4BRAF5AxPGGIENZi7GUAJZXRr7jpihdRWLSy0gSkDq3sFkggRujqdP2ah8aUH
	qnyeV2Q==
X-Received: from edvh8.prod.google.com ([2002:aa7:de08:0:b0:69f:5c5e:5030])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:794c:b0:c15:ee17:47a
 with SMTP id a640c23a62f3a-c1f13552533mr63378566b.15.1784909421382; Fri, 24
 Jul 2026 09:10:21 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:10:01 +0200
In-Reply-To: <20260724161004.2360749-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724161004.2360749-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724161004.2360749-3-gnoack@google.com>
Subject: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Whiteout files are used in the upper layer of an Overlayfs to indicate
that the file with this name does not exist in the unified view, even
if it is present in one of the lower layer file systems.

For userspace implementations of Overlay file systems (fuse-overlayfs),
whiteout files can be created from userspace as well:

* mknod(2) with S_IFCHR and makedev(0, 0)
* renameat2(2) with RENAME_WHITEOUT,
  creating the whiteout in the old place of the moved file.

This commit guards whiteout creation in both of these cases with
LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout files are *not* considered
character devices and are not bound to a driver.

Before this commit, renameat2(2) with RENAME_WHITEOUT would create a
directory entry even when all LANDLOCK_ACCESS_FS_MAKE_* rights are
denied.

This does not affect normal renames within layered OverlayFS mounts:
When doing a regular rename() on a mounted fuse-overlayfs, it is the
fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITEOUT,
and only the Landlock domain of that daemon is checked there.

This also adds a Landlock erratum for that case.

Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h    |  1 +
 security/landlock/errata/abi-1.h | 26 ++++++++++++++++++++++++++
 security/landlock/fs.c           | 31 ++++++++++++++++++++++++-------
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 7ffe2ef127ee..9c1102ebf06e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -351,6 +351,7 @@ struct landlock_net_port_attr {
  *   device.
  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular fi=
le.
+ *   This also guards the creation of whiteout objects as used in OverlayF=
S.
  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX doma=
in
  *   socket.
  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pip=
e.
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/ab=
i-1.h
index 3f099555f059..ee43bf53f6e2 100644
--- a/security/landlock/errata/abi-1.h
+++ b/security/landlock/errata/abi-1.h
@@ -22,3 +22,29 @@
  * from their original mount points.
  */
 LANDLOCK_ERRATUM(3)
+
+/**
+ * DOC: erratum_4
+ *
+ * Erratum 4: Creation of whiteout objects
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue through which it was possible to create whi=
teout
+ * objects, even when all file creation is restricted using Landlock.
+ *
+ * With this fix, the creation of whiteout objects is now guarded using
+ * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
+ * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is done thr=
ough
+ * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which previ=
ously
+ * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
+ *
+ * Whiteout objects are special file types used in OverlayFS to mark the a=
bsence
+ * of a file in an upper file system, even when the lower (often read-only=
) file
+ * system does have a file with the same name.
+ *
+ * Impact:
+ *
+ * Without this fix, it was possible to create whiteout files from userspa=
ce
+ * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.
+ */
+LANDLOCK_ERRATUM(4)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f7e5e4ef9eac..570f9ff21344 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -983,7 +983,8 @@ static int current_check_access_path(const struct path =
*const path,
 	return -EACCES;
 }
=20
-static __attribute_const__ access_mask_t get_mode_access(const umode_t mod=
e)
+static __attribute_const__ access_mask_t get_mode_access(const umode_t mod=
e,
+							 const unsigned int dev)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -991,6 +992,9 @@ static __attribute_const__ access_mask_t get_mode_acces=
s(const umode_t mode)
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
+		/* Whiteout objects are guarded with MAKE_REG. */
+		if (dev =3D=3D WHITEOUT_DEV)
+			return LANDLOCK_ACCESS_FS_MAKE_REG;
 		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
 	case S_IFBLK:
 		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
@@ -1093,6 +1097,7 @@ static bool collect_domain_accesses(const struct land=
lock_ruleset *const domain,
  * @new_dentry: Destination file or directory.
  * @removable: Sets to true if it is a rename operation.
  * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANG=
E.
+ * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOU=
T.
  *
  * Because of its unprivileged constraints, Landlock relies on file hierar=
chies
  * (and not only inodes) to tie access rights to files.  Being able to lin=
k or
@@ -1140,7 +1145,8 @@ static bool collect_domain_accesses(const struct land=
lock_ruleset *const domain,
 static int current_check_refer_path(struct dentry *const old_dentry,
 				    const struct path *const new_dir,
 				    struct dentry *const new_dentry,
-				    const bool removable, const bool exchange)
+				    const bool removable, const bool exchange,
+				    const bool whiteout)
 {
 	const struct landlock_cred_security *const subject =3D
 		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
@@ -1160,17 +1166,27 @@ static int current_check_refer_path(struct dentry *=
const old_dentry,
 		if (unlikely(d_is_negative(new_dentry)))
 			return -ENOENT;
 		access_request_parent1 =3D
-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
+			get_mode_access(d_backing_inode(new_dentry)->i_mode,
+					d_backing_inode(new_dentry)->i_rdev);
 	} else {
 		access_request_parent1 =3D 0;
 	}
 	access_request_parent2 =3D
-		get_mode_access(d_backing_inode(old_dentry)->i_mode);
+		get_mode_access(d_backing_inode(old_dentry)->i_mode,
+				d_backing_inode(old_dentry)->i_rdev);
 	if (removable) {
 		access_request_parent1 |=3D maybe_remove(old_dentry);
 		access_request_parent2 |=3D maybe_remove(new_dentry);
 	}
=20
+	/*
+	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
+	 * created in the source location, so we require an additional access
+	 * right there.
+	 */
+	if (whiteout)
+		access_request_parent1 |=3D LANDLOCK_ACCESS_FS_MAKE_REG;
+
 	/* The mount points are the same for old and new paths, cf. EXDEV. */
 	if (old_dentry->d_parent =3D=3D new_dir->dentry) {
 		/*
@@ -1520,7 +1536,7 @@ static int hook_path_link(struct dentry *const old_de=
ntry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+					false, false);
 }
=20
 static int hook_path_rename(const struct path *const old_dir,
@@ -1531,7 +1547,8 @@ static int hook_path_rename(const struct path *const =
old_dir,
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
-					!!(flags & RENAME_EXCHANGE));
+					!!(flags & RENAME_EXCHANGE),
+					!!(flags & RENAME_WHITEOUT));
 }
=20
 static int hook_path_mkdir(const struct path *const dir,
@@ -1544,7 +1561,7 @@ static int hook_path_mknod(const struct path *const d=
ir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	return current_check_access_path(dir, get_mode_access(mode));
+	return current_check_access_path(dir, get_mode_access(mode, dev));
 }
=20
 static int hook_path_symlink(const struct path *const dir,
--=20
2.55.0.229.g6434b31f56-goog


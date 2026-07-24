Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1026327C09
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909420; cv=none; b=aSiO/A88DXKFI1IKwePrpf+UNtjPkSCdelgy5Jt+XW0z+SbZhp7rYxl0VfS9n7LqSCgsEmee1FFYUXm1ROQ3k20bmvWRg75b2snF3ZetoK+4ABZ1ChGHDAijMH3I651Neund+rch/rmyIeYcQcl5C7b2Kc7f4vZW4nUVOUha5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909420; c=relaxed/simple;
	bh=luFk64E+CvdprncYBRbxSNElHAw1ltRmmGmlkxAlFK0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JfKu4RywBHdcdZUuAgRGoSnqK5UgPhgX1gDk2WLee8qdHYPXyxdo27IIjLN1i0oCp3POvibr8Lilv2sDxE19xzzPapb21VMdUucUTyfZHhH6LJu7sRk2sJqPW3ikJ0AFIaNRBE6uYM66N3Z9z+4bi92wJCO5biVIIUjIr6FNT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGvAHpJM; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGvAHpJM"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495569acf8dso4453695e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784909416; x=1785514216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I6dj0vOfZuCUfOeS7lVdNepot6xMYRuL1EGf1Hggoj0=;
        b=QGvAHpJMUJqdwutG9d1Q8KPOj/1A5u/N1dag+KswMWLFxEfB1s0/cnN1jXo5sr1ZBm
         NSD22RCbSTHHofmhyRlVePPQtlqs/Ne2U7iXsGwRbCRXWreQ9zOjFfvF2dzBZ9+y+JMc
         VTFlIdOsIUaQGK5WIyDU3xfqlPS2LAZn6HI/JPPsFPWeDdmt6pqEfIS98g9lWhywJwp9
         puw6XvCXxrrLA9K5K4uV0LIuJ3gea1WbhXtr4tvV3QK74/HjHReFCQCM53huCF1nNl4M
         Kdu4cy4apBabdc6C0rnEj80FtHIUf7ZAuCOzRxcALoFyqsA1UB8wrTU/Kjcno4IJ/q0X
         5ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909416; x=1785514216;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I6dj0vOfZuCUfOeS7lVdNepot6xMYRuL1EGf1Hggoj0=;
        b=QfgL+fAlV+VgvKL1RujUh5oGHJld76MmVUE8xA3gmeTuDFWcXBhNd31EXYUab37t1R
         JVT8enSkVbsQCixbQhYow5kSWmdPstzwJ2bz9wzkeu5SKT5WxQtKql9yrXMZuvt8dqqR
         0HMRpPc01G2vqHHPHuS53+1gvkbA7Tvzjjyn9P7ZRnoQZs5LUVaHcyqQjpT7Rgn4Sgku
         ImaQyGmm9j2FEwIOcn+niZgXKYKKw5tMT/U/GpH0NjdctUgSQHiRaJBhyR0WdujJvoqW
         xrVC7lH/El2koWF7Q4hyFUvmkIG/Kn7D0f8l6gu4opJgJj7TF7ZSUvqSgJ4/dG5vRsbf
         MQpw==
X-Gm-Message-State: AOJu0Yz0M8yB0rya86dKjh19kU/yo41177qRbluEjaYcnEqNeum3UBLW
	um99Psdnhcwnsr23PT8wRxOA5Rg4r/NiCdmYSeVGhNWgohMatEiQMmHvv4W5EZKFlNWcUfSOPHE
	l3UKQVw==
X-Received: from wmdd24.prod.google.com ([2002:a05:600c:a218:b0:495:46dc:fbb2])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6cf:b0:495:4d00:2fda
 with SMTP id 5b1f17b1804b1-49573cb9654mr56560815e9.2.1784909415869; Fri, 24
 Jul 2026 09:10:15 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724161004.2360749-1-gnoack@google.com>
Subject: [PATCH v4 0/5] landlock: Restrict whiteout object creation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

As discussed in [1], the renameat2() syscall's RENAME_WHITEOUT flag allows
the creation of chardev directory entries with major=3Dminor=3D0 as "whiteo=
ut
objects" in the location of the rename source file [2].

This functionality is available even without having any OverlayFS mounted
and can be invoked with the regular renameat2(2) syscall [3].

In V1 [5], it was discussed that whiteout objects are not the same as chara=
cter
devices, and should therefore be treated differently.  After considering a =
new
access right in V2 and V3, we eventually settled on guarding it with the
existing LANDLOCK_ACCESS_FS_MAKE_REG access right and introducing a new err=
atum
[6].

Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The RENAME_WHITEOUT flag side-steps all of the existing Landlock access
rights, which are designed to restrict the creation of directory entries.
It is desirable to restrict that.

This patch set fixes that by adding a check in Landlock's path_rename and
path_mknod hooks.


[1] https://lore.kernel.org/all/adUBCQXrt7kmgqJT@google.com/
[2] https://docs.kernel.org/filesystems/overlayfs.html#whiteouts-and-opaque=
-directories
[3] https://man7.org/linux/man-pages/man2/renameat2.2.html#DESCRIPTION
[4] https://codesearch.debian.net/search?q=3Drename.*RENAME_WHITEOUT&litera=
l=3D0
[5] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/
[6] https://lore.kernel.org/all/20260720.chow9ohYie5b@digikod.net/

Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D

v4:
 - Guard it with LANDLOCK_ACCESS_FS_MAKE_REG as discussed.
 - Selftests and documentation.

v3:
 - Do LANDLOCK_ACCESS_FS_MAKE_WHITEOUT check as part of
   current_check_refer_path().
 - https://lore.kernel.org/all/20260610092318.3868884-1-gnoack@google.com/

v2:
 - Introduce LANDLOCK_ACCESS_FS_MAKE_WHITEOUT access right
   and guard it with that.
 - Bump ABI version
 - https://lore.kernel.org/all/20260513160552.4022649-1-gnoack@google.com/

v1:
 - initial version
   https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/


G=C3=BCnther Noack (5):
  selftests/landlock: Use an actual chardev for MAKE_CHAR audit test
  landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
  selftests/landlock: Add tests for whiteout object creation
  selftests/landlock: Test whiteout object behaviour in OverlayFS
    renames
  landlock: Link the erratum documentation for whiteout objects

 Documentation/userspace-api/landlock.rst   |  3 ++
 include/uapi/linux/landlock.h              |  1 +
 security/landlock/errata/abi-1.h           | 26 +++++++++
 security/landlock/fs.c                     | 31 ++++++++---
 tools/testing/selftests/landlock/fs_test.c | 63 +++++++++++++++++++++-
 5 files changed, 116 insertions(+), 8 deletions(-)

Range-diff against v3:
-:  ------------ > 1:  119b5b4b2fb6 selftests/landlock: Use an actual chard=
ev for MAKE_CHAR audit test
1:  4a8c3fb9e707 ! 2:  3203d5da06e3 landlock: Require LANDLOCK_ACCESS_FS_MA=
KE_WHITEOUT for RENAME_WHITEOUT
    @@ Metadata
     Author: G=C3=BCnther Noack <gnoack@google.com>
    =20
      ## Commit message ##
    -    landlock: Require LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHIT=
EOUT
    +    landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creatio=
n
    =20
    -    renameat2(2) with the RENAME_WHITEOUT flag places a whiteout chara=
cter
    -    device file in the source file location in place of the moved file=
.
    -    This creates a directory entry even in cases where all
    -    LANDLOCK_ACCESS_FS_MAKE_* rights are denied.
    +    Whiteout files are used in the upper layer of an Overlayfs to indi=
cate
    +    that the file with this name does not exist in the unified view, e=
ven
    +    if it is present in one of the lower layer file systems.
    =20
    -    Introduce the LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right, which is che=
cked
    -    for the origin directory if RENAME_WHITEOUT is passed.
    +    For userspace implementations of Overlay file systems (fuse-overla=
yfs),
    +    whiteout files can be created from userspace as well:
    +
    +    * mknod(2) with S_IFCHR and makedev(0, 0)
    +    * renameat2(2) with RENAME_WHITEOUT,
    +      creating the whiteout in the old place of the moved file.
    +
    +    This commit guards whiteout creation in both of these cases with
    +    LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout files are *not* considered
    +    character devices and are not bound to a driver.
    +
    +    Before this commit, renameat2(2) with RENAME_WHITEOUT would create=
 a
    +    directory entry even when all LANDLOCK_ACCESS_FS_MAKE_* rights are
    +    denied.
    =20
         This does not affect normal renames within layered OverlayFS mount=
s:
    -    When OverlayFS invokes rename with RENAME_WHITEOUT as part of a
    -    "normal" rename operation, it does so in ovl_rename() using the
    -    credentials that were set at the time of mounting the OverlayFS.
    +    When doing a regular rename() on a mounted fuse-overlayfs, it is t=
he
    +    fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITE=
OUT,
    +    and only the Landlock domain of that daemon is checked there.
    =20
    -    Bump the Landlock ABI version to 10.
    +    This also adds a Landlock erratum for that case.
    =20
         Suggested-by: Christian Brauner <brauner@kernel.org>
         Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
    +    Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control"=
)
         Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
    =20
      ## include/uapi/linux/landlock.h ##
     @@ include/uapi/linux/landlock.h: struct landlock_net_port_attr {
    -  *
    -  *   If multiple requirements are not met, the ``EACCES`` error code =
takes
    -  *   precedence over ``EXDEV``.
    -+ * - %LANDLOCK_ACCESS_FS_MAKE_WHITEOUT: Create a whiteout object thro=
ugh
    -+ *   :manpage:`rename(2)` with ``RENAME_WHITEOUT``.
    -  *
    -  * .. warning::
    -  *
    -@@ include/uapi/linux/landlock.h: struct landlock_net_port_attr {
    - #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
    - #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
    - #define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
    -+#define LANDLOCK_ACCESS_FS_MAKE_WHITEOUT		(1ULL << 17)
    - /* clang-format on */
    -=20
    - /**
    +  *   device.
    +  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
    +  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regul=
ar file.
    ++ *   This also guards the creation of whiteout objects as used in Ove=
rlayFS.
    +  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX=
 domain
    +  *   socket.
    +  * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a name=
d pipe.
    =20
    - ## security/landlock/audit.c ##
    -@@ security/landlock/audit.c: static const char *const fs_access_strin=
gs[] =3D {
    - 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] =3D "fs.truncate",
    - 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] =3D "fs.ioctl_dev",
    - 	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] =3D "fs.resolve_unix",
    -+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_WHITEOUT)] =3D "fs.make_whiteout"=
,
    - };
    -=20
    - static_assert(ARRAY_SIZE(fs_access_strings) =3D=3D LANDLOCK_NUM_ACCES=
S_FS);
    + ## security/landlock/errata/abi-1.h ##
    +@@
    +  * from their original mount points.
    +  */
    + LANDLOCK_ERRATUM(3)
    ++
    ++/**
    ++ * DOC: erratum_4
    ++ *
    ++ * Erratum 4: Creation of whiteout objects
    ++ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ++ *
    ++ * This fix addresses an issue through which it was possible to creat=
e whiteout
    ++ * objects, even when all file creation is restricted using Landlock.
    ++ *
    ++ * With this fix, the creation of whiteout objects is now guarded usi=
ng
    ++ * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
    ++ * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is don=
e through
    ++ * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which =
previously
    ++ * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
    ++ *
    ++ * Whiteout objects are special file types used in OverlayFS to mark =
the absence
    ++ * of a file in an upper file system, even when the lower (often read=
-only) file
    ++ * system does have a file with the same name.
    ++ *
    ++ * Impact:
    ++ *
    ++ * Without this fix, it was possible to create whiteout files from us=
erspace
    ++ * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.
    ++ */
    ++LANDLOCK_ERRATUM(4)
    =20
      ## security/landlock/fs.c ##
    +@@ security/landlock/fs.c: static int current_check_access_path(const =
struct path *const path,
    + 	return -EACCES;
    + }
    +=20
    +-static __attribute_const__ access_mask_t get_mode_access(const umode_=
t mode)
    ++static __attribute_const__ access_mask_t get_mode_access(const umode_=
t mode,
    ++							 const unsigned int dev)
    + {
    + 	switch (mode & S_IFMT) {
    + 	case S_IFLNK:
    +@@ security/landlock/fs.c: static __attribute_const__ access_mask_t ge=
t_mode_access(const umode_t mode)
    + 	case S_IFDIR:
    + 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
    + 	case S_IFCHR:
    ++		/* Whiteout objects are guarded with MAKE_REG. */
    ++		if (dev =3D=3D WHITEOUT_DEV)
    ++			return LANDLOCK_ACCESS_FS_MAKE_REG;
    + 		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
    + 	case S_IFBLK:
    + 		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
     @@ security/landlock/fs.c: static bool collect_domain_accesses(const s=
truct landlock_ruleset *const domain,
       * @new_dentry: Destination file or directory.
       * @removable: Sets to true if it is a rename operation.
    @@ security/landlock/fs.c: static bool collect_domain_accesses(const st=
ruct landloc
      	const struct landlock_cred_security *const subject =3D
      		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
     @@ security/landlock/fs.c: static int current_check_refer_path(struct =
dentry *const old_dentry,
    + 		if (unlikely(d_is_negative(new_dentry)))
    + 			return -ENOENT;
    + 		access_request_parent1 =3D
    +-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
    ++			get_mode_access(d_backing_inode(new_dentry)->i_mode,
    ++					d_backing_inode(new_dentry)->i_rdev);
    + 	} else {
    + 		access_request_parent1 =3D 0;
    + 	}
    + 	access_request_parent2 =3D
    +-		get_mode_access(d_backing_inode(old_dentry)->i_mode);
    ++		get_mode_access(d_backing_inode(old_dentry)->i_mode,
    ++				d_backing_inode(old_dentry)->i_rdev);
    + 	if (removable) {
    + 		access_request_parent1 |=3D maybe_remove(old_dentry);
      		access_request_parent2 |=3D maybe_remove(new_dentry);
      	}
     =20
    @@ security/landlock/fs.c: static int current_check_refer_path(struct d=
entry *const
     +	 * right there.
     +	 */
     +	if (whiteout)
    -+		access_request_parent1 |=3D LANDLOCK_ACCESS_FS_MAKE_WHITEOUT;
    ++		access_request_parent1 |=3D LANDLOCK_ACCESS_FS_MAKE_REG;
     +
      	/* The mount points are the same for old and new paths, cf. EXDEV. *=
/
      	if (old_dentry->d_parent =3D=3D new_dir->dentry) {
    @@ security/landlock/fs.c: static int hook_path_rename(const struct pat=
h *const old
      }
     =20
      static int hook_path_mkdir(const struct path *const dir,
    -
    - ## security/landlock/limits.h ##
    -@@
    - #define LANDLOCK_MAX_NUM_LAYERS		16
    - #define LANDLOCK_MAX_NUM_RULES		U32_MAX
    -=20
    --#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    -+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
    - #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
    - #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCES=
S_FS)
    -=20
    -
    - ## security/landlock/syscalls.c ##
    -@@ security/landlock/syscalls.c: static const struct file_operations r=
uleset_fops =3D {
    -  * If the change involves a fix that requires userspace awareness, al=
so update
    -  * the errata documentation in Documentation/userspace-api/landlock.r=
st .
    -  */
    --const int landlock_abi_version =3D 9;
    -+const int landlock_abi_version =3D 10;
    -=20
    - /**
    -  * sys_landlock_create_ruleset - Create a new ruleset
    -
    - ## tools/testing/selftests/landlock/base_test.c ##
    -@@ tools/testing/selftests/landlock/base_test.c: TEST(abi_version)
    - 	const struct landlock_ruleset_attr ruleset_attr =3D {
    - 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
    - 	};
    --	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
    --					     LANDLOCK_CREATE_RULESET_VERSION));
    -+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
    -+					      LANDLOCK_CREATE_RULESET_VERSION));
    -=20
    - 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
    - 					      LANDLOCK_CREATE_RULESET_VERSION));
    -
    - ## tools/testing/selftests/landlock/fs_test.c ##
    -@@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, in=
val)
    - 	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
    - 	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
    -=20
    --#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    -+#define ACCESS_LAST LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
    -=20
    - #define ACCESS_ALL ( \
    - 	ACCESS_FILE | \
    -@@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, in=
val)
    - 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
    - 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
    - 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
    --	LANDLOCK_ACCESS_FS_REFER)
    -+	LANDLOCK_ACCESS_FS_REFER | \
    -+	LANDLOCK_ACCESS_FS_MAKE_WHITEOUT)
    -=20
    - /* clang-format on */
    +@@ security/landlock/fs.c: static int hook_path_mknod(const struct pat=
h *const dir,
    + 			   struct dentry *const dentry, const umode_t mode,
    + 			   const unsigned int dev)
    + {
    +-	return current_check_access_path(dir, get_mode_access(mode));
    ++	return current_check_access_path(dir, get_mode_access(mode, dev));
    + }
     =20
    + static int hook_path_symlink(const struct path *const dir,
2:  063646822083 ! 3:  98f783636d6b selftests/landlock: Add test for RENAME=
_WHITEOUT denial
    @@ Metadata
     Author: G=C3=BCnther Noack <gnoack@google.com>
    =20
      ## Commit message ##
    -    selftests/landlock: Add test for RENAME_WHITEOUT denial
    +    selftests/landlock: Add tests for whiteout object creation
    =20
    -    Add a test to check that renames with RENAME_WHITEOUT are guarded =
by
    -    LANDLOCK_ACCESS_FS_MAKE_WHITEOUT.
    +    Add a test to check that whiteout object creation is guarded by
    +    LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created =
from
    +    userspace:
    +
    +    * Conventional creation with mknod()
    +    * Linking or renaming an existing whiteout object
    +    * renameat2() with RENAME_WHITEOUT,
    +      which creates a new whiteout object in the source location
    =20
         Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
    =20
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, ren=
ame_file)
     =20
     +TEST_F_FORK(layout1, rename_whiteout_denied)
     +{
    -+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, NULL);
    ++	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
     +
     +	/*
     +	 * Try to rename a file with RENAME_WHITEOUT.
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, ren=
ame_file)
      TEST_F_FORK(layout1, rename_dir)
      {
      	const struct rule rules[] =3D {
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, ma=
ke_char)
    + 		       makedev(1, 3));
    + }
    +=20
    ++TEST_F_FORK(layout1, make_whiteout)
    ++{
    ++	/* Creates a whiteout object (creation guarded by MAKE_REG). */
    ++	set_cap(_metadata, CAP_MKNOD);
    ++	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
    ++		       makedev(0, 0));
    ++}
    ++
    + TEST_F_FORK(layout1, make_block)
    + {
    + 	/* Creates a /dev/loop0 device. */
     @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout2_ove=
rlay, same_content_different_file)
      	}
      }
3:  5d4606bc1e84 ! 4:  98aab13d9f3f selftests/landlock: Test OverlayFS rena=
mes w/o LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
    @@ Metadata
     Author: G=C3=BCnther Noack <gnoack@google.com>
    =20
      ## Commit message ##
    -    selftests/landlock: Test OverlayFS renames w/o LANDLOCK_ACCESS_FS_=
MAKE_WHITEOUT
    +    selftests/landlock: Test whiteout object behaviour in OverlayFS re=
names
    =20
         Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and =
even
    -    though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, =
a process
    -    that renames files in an OverlayFS can do so without having the
    -    LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right in that location.
    +    though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a pro=
cess that
    +    renames non-regular files in an OverlayFS can do so without having=
 the
    +    LANDLOCK_ACCESS_FS_MAKE_REG right in that location.
    =20
         This works, and is supposed to work, because OverlayFS uses the cr=
edentials
         determined at mount time for the internal vfs_rename() operation. =
-- The
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout2_over=
lay, same_co
      	}
      }
     =20
    -+TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_whiteout)
    ++TEST_F_FORK(layout2_overlay, rename_in_overlay_without_make_reg)
     +{
     +	struct stat st;
     +	const char *merge_fl1_renamed =3D MERGE_DATA "/fl1_renamed";
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout2_over=
lay, same_co
     +	if (self->skip_test)
     +		SKIP(return, "overlayfs is not supported (test)");
     +
    -+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, NULL);
    ++	/*
    ++	 * In this test, merge_fl1 is a FIFO file.  MAKE_REG is restricted, =
but
    ++	 * MAKE_FIFO is allowed.  Despite MAKE_REG being restricted, the ren=
ame
    ++	 * on the OverlayFS works and creates a whiteout file in the underly=
ing
    ++	 * upper file system.
    ++	 */
    ++	ASSERT_EQ(0, unlink(merge_fl1));
    ++	ASSERT_EQ(0, mknod(merge_fl1, S_IFIFO, 0));
    ++	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
     +
     +	/*
     +	 * Execute a regular file rename within OverlayFS.
-:  ------------ > 5:  d79f3daff3ed landlock: Link the erratum documentatio=
n for whiteout objects
--=20
2.55.0.229.g6434b31f56-goog


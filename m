Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E642E8EA
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512643; cv=none; b=nPg9G4WALeE6rQci5tDabbH6sArYQnCrscLzU2CoOYJfzc5NI+rQglds+RUdAqxtChaO6Icuwawp31ancci+LqMZVO/WjKdvlbRRt7xy4uGvr1Em4PTE9KkwMmvlx61jv6UdEDc2Xf3cWur4USK758KTzDDJ5Jnti2WF9eKBxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512643; c=relaxed/simple;
	bh=cohHuKTQQwM1yXN7G8OUTUV63w7JFn55cVVp67T+iEU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=flyCKz4fxmZRbhvCdrgnMxOUvwYTjHaNxv2sQ+YHN9OX4opyxVRnQ2yclXQgUiio6YrxbHB75XupNNU0pC43ap+jmE6eJjpJTQyGdflRZGRsAPUq/ciYe2000ck4htUJ4NVC+jXkDpavpVmU74K9RfYyKAMAb3EKTbQo5lPZEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B745D0L3; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B745D0L3"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f726186c4so918398f8f.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785512639; x=1786117439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o3q1Vt4WNE3C2quRFaCqLZVHO8QmBC+VeuJSd8R+xiw=;
        b=B745D0L3yZmW6pFlACUdUezI0xwJHjtjN/OLJt2H8CEyyFDpMKp36Kvbn/E2nE6I9g
         ri/wcWfz5XwveliTJanf6muevX2gkiuz5kcrax3LVty2AXzeo1VkLJ+cBaYWZyuBBceV
         osBMgfq8AeGqG2qgV0BjISOybrgklrkJz8aaAuEBp1IYRT2T7Kx50TGL2+uJznKEbKEJ
         D4uVE3lO408nIvlAibHVnK2APNPZ3BNbaJVT46yrhyKicpILLZVamLKc+NPjR7g/aisG
         P+/ilbL/3SL2j9Q8Kd2ofcATSXz59DcJ07qqE9q5fOa41FyaA7aiiMAwNibbZ/BpvtEL
         p7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512639; x=1786117439;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o3q1Vt4WNE3C2quRFaCqLZVHO8QmBC+VeuJSd8R+xiw=;
        b=BruTaqKqn2CpIPiWI9H236NiE8WJk6uZAHhxzYO2o8jdpoS0sey1Aco3lLVi0f+WIW
         +nHaX2abGTdbQ5GnjTV+3UJZgowgxpisluiWmAeqgffWaIiB7v3fMh1x5vbCxfxL0pJi
         1omOSbBk8trPJUlLEr4liyA4IU4zdLnhq0L7Cz+rN9QH3Fiyr52L1YXpKw5jDpbdaRfU
         /5grBi9bACFmjaUWVtmT1jTMWF+W1fer9ONxFUR20f6veAac1NamisyVpTOFHdRsmyWa
         ulVxRchBT9kvijwDZl7LU7H//KFqHnUDv4Cbi+PW3yJgd5QWRK4E/Q0YojB5PM4h6vJR
         zIuw==
X-Gm-Message-State: AOJu0Yzs+np7VuOw6jdy9S7BSVdzcQvUFLrlLtMEJM/Nxmr9aV11MEUU
	SIcG1FoRz/ijVWtzkB3xl3goNWj8y1lfdrtEQfdoJLwYN+eBANi74ZVZoDjgWCX9pdUl01dtYre
	cDpch5g==
X-Received: from wrwl2.prod.google.com ([2002:a5d:6742:0:b0:460:2d58:857f])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2dca:b0:47f:9752:3277
 with SMTP id ffacd0b85a97d-47fd72a5be6mr309660f8f.2.1785512638184; Fri, 31
 Jul 2026 08:43:58 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:43:48 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731154353.1790268-1-gnoack@google.com>
Subject: [PATCH v5 0/5] landlock: Restrict whiteout object creation
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

V5 of this patch set is an intermediary version so that we can pipeline the
review and implementation, as discussed with Micka=C3=ABl offline; some V4 =
feedback
on patch 3/5 and the feedback on 4/5 are not addressed yet.

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

v5:
 - Erratum: Clarify that this is about mknod(2) only
 - Add Cc stable@vger.kernel.org and Depends-on lines
 - Smaller code changes
   - Use dev_t where appropriate
   - Introduce get_dentry_access() helper
   - Use get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV)
     to calculate the required access right for the created whiteout object
 - Tests:
   - rename_whiteout_denied: move a FIFO
     - otherwise, the test succeeded without the change
   - make_whiteout: drop set_cap(CAP_MKNOD) (not needed)
 - This is an intermediary state: It incorporates feedback to 2/5 and some =
3/5
   feedback from v4, but not the 4/5 feedback yet.

v4:
 - Guard it with LANDLOCK_ACCESS_FS_MAKE_REG as discussed.
 - Selftests and documentation.
 - https://lore.kernel.org/all/20260724161004.2360749-1-gnoack@google.com/

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

 Documentation/userspace-api/landlock.rst   |  3 +
 include/uapi/linux/landlock.h              |  1 +
 security/landlock/errata/abi-1.h           | 23 ++++++++
 security/landlock/fs.c                     | 41 ++++++++++---
 tools/testing/selftests/landlock/fs_test.c | 68 +++++++++++++++++++++-
 5 files changed, 126 insertions(+), 10 deletions(-)

Range-diff against v4:
1:  119b5b4b2fb6 =3D 1:  d1a8a84d92e0 selftests/landlock: Use an actual cha=
rdev for MAKE_CHAR audit test
2:  3203d5da06e3 ! 2:  9fe2edf17413 landlock: Require LANDLOCK_ACCESS_FS_MA=
KE_REG for whiteout creation
    @@ Metadata
      ## Commit message ##
         landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creatio=
n
    =20
    -    Whiteout files are used in the upper layer of an Overlayfs to indi=
cate
    -    that the file with this name does not exist in the unified view, e=
ven
    -    if it is present in one of the lower layer file systems.
    +    Whiteout objects are used in the upper layer of an OverlayFS to
    +    indicate that the file with this name does not exist in the unifie=
d
    +    view, even if it is present in one of the lower layer file systems=
.
    =20
    -    For userspace implementations of Overlay file systems (fuse-overla=
yfs),
    -    whiteout files can be created from userspace as well:
    +    For the userspace implementations of OverlayFS (fuse-overlayfs),
    +    whiteout objects can be created from userspace as well:
    =20
         * mknod(2) with S_IFCHR and makedev(0, 0)
         * renameat2(2) with RENAME_WHITEOUT,
           creating the whiteout in the old place of the moved file.
    =20
         This commit guards whiteout creation in both of these cases with
    -    LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout files are *not* considered
    +    LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout objects are *not* considere=
d
         character devices and are not bound to a driver.
    =20
    -    Before this commit, renameat2(2) with RENAME_WHITEOUT would create=
 a
    -    directory entry even when all LANDLOCK_ACCESS_FS_MAKE_* rights are
    -    denied.
    +    For the mknod(2) case, introduce a Landlock erratum.  The creation=
 of
    +    whiteout objects through mknod(2) was previously guarded using
    +    LANDLOCK_ACCESS_FS_MAKE_CHAR, and it is now guarded using
    +    LANDLOCK_ACCESS_MAKE_REG.
    +
    +    For the renameat2(2) case, fix a bug: Before this commit, renameat=
2(2)
    +    with RENAME_WHITEOUT would create a directory entry even when all
    +    LANDLOCK_ACCESS_FS_MAKE_* rights were denied.
    =20
         This does not affect normal renames within layered OverlayFS mount=
s:
         When doing a regular rename() on a mounted fuse-overlayfs, it is t=
he
         fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITE=
OUT,
         and only the Landlock domain of that daemon is checked there.
    =20
    -    This also adds a Landlock erratum for that case.
    -
         Suggested-by: Christian Brauner <brauner@kernel.org>
         Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
    +    Cc: stable@vger.kernel.org
         Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control"=
)
    +    Depends-on: 49c9e09d9610 ("landlock: Fix handling of disconnected =
directories")
    +    Depends-on: fe72ce6710cb ("landlock: Add errata documentation sect=
ion")
         Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
    =20
      ## include/uapi/linux/landlock.h ##
    @@ security/landlock/errata/abi-1.h
     + * Erratum 4: Creation of whiteout objects
     + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     + *
    -+ * This fix addresses an issue through which it was possible to creat=
e whiteout
    -+ * objects, even when all file creation is restricted using Landlock.
    ++ * This fix changes the access rights required for the creation of wh=
iteout
    ++ * objects through :manpage:`mknod(2)` or :manpage:`renameat2(2)`.  C=
reating
    ++ * whiteout objects is now guarded by ``LANDLOCK_ACCESS_FS_MAKE_REG``=
 instead of
    ++ * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
     + *
    -+ * With this fix, the creation of whiteout objects is now guarded usi=
ng
    -+ * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
    -+ * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is don=
e through
    -+ * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which =
previously
    -+ * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
    -+ *
    -+ * Whiteout objects are special file types used in OverlayFS to mark =
the absence
    -+ * of a file in an upper file system, even when the lower (often read=
-only) file
    -+ * system does have a file with the same name.
    ++ * Whiteout objects are used in OverlayFS to mark the absence of a fi=
le in an
    ++ * upper file system.  Despite being created with ``S_IFCHR``, whiteo=
ut objects
    ++ * do not count as character devices.
     + *
     + * Impact:
     + *
    -+ * Without this fix, it was possible to create whiteout files from us=
erspace
    -+ * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.
    ++ * Sandboxed programs that create OverlayFS whiteouts (such as fuse-o=
verlayfs)
    ++ * now require ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of
    ++ * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
     + */
     +LANDLOCK_ERRATUM(4)
    =20
      ## security/landlock/fs.c ##
    +@@
    + #include <linux/falloc.h>
    + #include <linux/fs.h>
    + #include <linux/init.h>
    ++#include <linux/kdev_t.h>
    + #include <linux/kernel.h>
    + #include <linux/limits.h>
    + #include <linux/list.h>
     @@ security/landlock/fs.c: static int current_check_access_path(const =
struct path *const path,
      	return -EACCES;
      }
     =20
     -static __attribute_const__ access_mask_t get_mode_access(const umode_=
t mode)
     +static __attribute_const__ access_mask_t get_mode_access(const umode_=
t mode,
    -+							 const unsigned int dev)
    ++							 const dev_t dev)
      {
      	switch (mode & S_IFMT) {
      	case S_IFLNK:
    @@ security/landlock/fs.c: static __attribute_const__ access_mask_t get=
_mode_access
      		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
      	case S_IFBLK:
      		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
    +@@ security/landlock/fs.c: static __attribute_const__ access_mask_t ge=
t_mode_access(const umode_t mode)
    + 	}
    + }
    +=20
    ++static __attribute_const__ access_mask_t
    ++get_dentry_access(const struct dentry *const dentry)
    ++{
    ++	return get_mode_access(d_backing_inode(dentry)->i_mode,
    ++			       d_backing_inode(dentry)->i_rdev);
    ++}
    ++
    + static access_mask_t maybe_remove(const struct dentry *const dentry)
    + {
    + 	if (d_is_negative(dentry))
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
    + 	if (exchange) {
      		if (unlikely(d_is_negative(new_dentry)))
      			return -ENOENT;
    - 		access_request_parent1 =3D
    +-		access_request_parent1 =3D
     -			get_mode_access(d_backing_inode(new_dentry)->i_mode);
    -+			get_mode_access(d_backing_inode(new_dentry)->i_mode,
    -+					d_backing_inode(new_dentry)->i_rdev);
    ++		access_request_parent1 =3D get_dentry_access(new_dentry);
      	} else {
      		access_request_parent1 =3D 0;
      	}
    - 	access_request_parent2 =3D
    +-	access_request_parent2 =3D
     -		get_mode_access(d_backing_inode(old_dentry)->i_mode);
    -+		get_mode_access(d_backing_inode(old_dentry)->i_mode,
    -+				d_backing_inode(old_dentry)->i_rdev);
    ++	access_request_parent2 =3D get_dentry_access(old_dentry);
      	if (removable) {
      		access_request_parent1 |=3D maybe_remove(old_dentry);
      		access_request_parent2 |=3D maybe_remove(new_dentry);
    @@ security/landlock/fs.c: static int current_check_refer_path(struct d=
entry *const
     +	 * right there.
     +	 */
     +	if (whiteout)
    -+		access_request_parent1 |=3D LANDLOCK_ACCESS_FS_MAKE_REG;
    ++		access_request_parent1 |=3D
    ++			get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
     +
      	/* The mount points are the same for old and new paths, cf. EXDEV. *=
/
      	if (old_dentry->d_parent =3D=3D new_dir->dentry) {
    @@ security/landlock/fs.c: static int hook_path_mknod(const struct path=
 *const dir,
      			   const unsigned int dev)
      {
     -	return current_check_access_path(dir, get_mode_access(mode));
    -+	return current_check_access_path(dir, get_mode_access(mode, dev));
    ++	return current_check_access_path(
    ++		dir, get_mode_access(mode, new_decode_dev(dev)));
      }
     =20
      static int hook_path_symlink(const struct path *const dir,
3:  98f783636d6b ! 3:  d23ea62b3325 selftests/landlock: Add tests for white=
out object creation
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, ren=
ame_file)
     =20
     +TEST_F_FORK(layout1, rename_whiteout_denied)
     +{
    ++	/* The affected file is a FIFO. */
    ++	ASSERT_EQ(0, unlink(file1_s3d3));
    ++	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
    ++
    ++	/* Deny MAKE_REG, but allow MAKE_FIFO. */
     +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
     +
     +	/*
     +	 * Try to rename a file with RENAME_WHITEOUT.
     +	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT=
.
    ++	 * Denied, because whiteout creation is guarded with MAKE_REG.
     +	 */
     +	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
     +				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, mak=
e_char)
     +TEST_F_FORK(layout1, make_whiteout)
     +{
     +	/* Creates a whiteout object (creation guarded by MAKE_REG). */
    -+	set_cap(_metadata, CAP_MKNOD);
     +	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
     +		       makedev(0, 0));
     +}
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout1, mak=
e_char)
      TEST_F_FORK(layout1, make_block)
      {
      	/* Creates a /dev/loop0 device. */
    -@@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout2_ove=
rlay, same_content_different_file)
    - 	}
    - }
    -=20
    -+
    - FIXTURE(layout3_fs)
    - {
    - 	bool has_created_dir;
4:  98aab13d9f3f ! 4:  10ed1d74636d selftests/landlock: Test whiteout objec=
t behaviour in OverlayFS renames
    @@ Commit message
         selftests/landlock: Test whiteout object behaviour in OverlayFS re=
names
    =20
         Even though OverlayFS uses vfs_rename() with RENAME_WHITEOUT, and =
even
    -    though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a pro=
cess that
    -    renames non-regular files in an OverlayFS can do so without having=
 the
    -    LANDLOCK_ACCESS_FS_MAKE_REG right in that location.
    +    though RENAME_WHITEOUT requires LANDLOCK_ACCESS_FS_MAKE_REG, a pro=
cess
    +    that renames non-regular files in an OverlayFS can do so without
    +    having the LANDLOCK_ACCESS_FS_MAKE_REG right in that location.
    =20
    -    This works, and is supposed to work, because OverlayFS uses the cr=
edentials
    -    determined at mount time for the internal vfs_rename() operation. =
-- The
    -    rename happens with the credentials of the user who mounted the Ov=
erlayFS.
    +    This works, and is supposed to work, because OverlayFS uses the
    +    credentials determined at mount time for the internal vfs_rename()
    +    operation.  The rename happens with the credentials of the user wh=
o
    +    mounted the OverlayFS.
    =20
         Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
    =20
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(layout2_over=
lay, same_co
     +	EXPECT_TRUE(S_ISCHR(st.st_mode));
     +	EXPECT_EQ(0, st.st_rdev);
     +}
    -=20
    ++
      FIXTURE(layout3_fs)
      {
    + 	bool has_created_dir;
5:  d79f3daff3ed =3D 5:  35651219395c landlock: Link the erratum documentat=
ion for whiteout objects
--=20
2.55.0.508.g3f0d502094-goog


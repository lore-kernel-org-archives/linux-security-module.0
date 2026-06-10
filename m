Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15D392824
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083405; cv=none; b=f99EHqHr9fz8JNF0mgJBioilpLSSlZX7kivRoFU4wKXa0FT3Qm/SpPEOFPwEAAQrdq2ytKNnmAwqxOZxR1heoe13K3ght48xEk7UGixM3dDo0UXyAvMob5TY1f2kecVqfLPgyez+BZQzk6CacM2+iByx4On1wQezFHUO1/Q0mpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083405; c=relaxed/simple;
	bh=8kgqkRnWWqHRYLgbEXMz8rqt8rlSz+SfKMAFgKQmOgQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XrZUpsDsPsEzPOVrZTl+lDotg9G0UA/PlFNRYJ+agSFdKlPFZnfaogHkSaLIr+H3Z5DtM5AAI5eCzLVehj/Rd0//Ob08iv4gG0UJGsppKi4mw+qjKxkKQkX6yVloXZPjAHAm0COJrv38d3t3fdMUwSZUws8vy44vZuNOg+/Xu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuEzBNc/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuEzBNc/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b37e1ebfso31886895e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781083402; x=1781688202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aynqyRXjXcE4oQyslFjuLKecz4QRybe3bRsF1VeBj4E=;
        b=uuEzBNc/JExp+NXCgzUskVPkOaqOUiL9cdK62fxeJW7xPlc7Ldwm/Y/gAOMhVElbXn
         VIg60nzZgs8s0uur98CAamtBlDl1Yzkzpnawot3tc+LHEFfDMVhiZwaoSLFcEiQZRokN
         OKhCwA6+cjsNPoVUlkTopPNbny/p2Zff6+XXg3n1X+X/s2hdPYHidcoxGFFeR8+khb93
         GmoaLAjtC1xmGctgbZyRzJyiko8E3+obNHCv2Rd/aPjihlVzLDv+EnmCuYlVGyM8j/Xo
         pg7LWGYe7iRC/43ZDfnfmzQ0iAs5ZwafaKBDlwkH6GD4ZiqvKHnUnT9IKLneBkGb1pxn
         aGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083402; x=1781688202;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aynqyRXjXcE4oQyslFjuLKecz4QRybe3bRsF1VeBj4E=;
        b=PNcQEI2qiM7Ft+vgjE31jvvZjm8Y9l1kSH4T1EvIEbSnUSvcs5OREg4U2QMdk22JEq
         zDrE+mg2qpxTv71dpSdRC4JgwMYh584yCBpxvtx2w0ZVxOSMStnK4+fIYP1q43/RIvGU
         JxqhG1QGEr7YNDVv7Eoz/I+CtBmdZ5ncJ5Nx2p06OO9XhJbyfeJJq1QIdsVqXlW8RShP
         SLQO5vta6wBi3iR2zhTpjXFQWsreC0+XO4A5gk6L03pCevx2fHr3rukX3yum+rs/3PuZ
         7dxJxGwYn80mZpc0M6eXBmxa9mENdhjp+cencZxpwHDG6ce3KWetLVjN4pn6b6f8Ir73
         iLUQ==
X-Gm-Message-State: AOJu0Yx1Np5eLP6tiPNBnTw7UY14BQ2q9/JCMBMmqz+4C664Tu0BZwKs
	HvMBnlW+8Vh/XyLsGobvm8nhvdZmFcM+d4XEmE0HgMPXYMAF0t35aYTsATiu/FYwjzR14qBZ4bz
	6n/bQkA==
X-Received: from wmxa5-n2.prod.google.com ([2002:a05:600d:6445:20b0:490:c053:6ea7])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e0a:b0:490:45bb:8dd9
 with SMTP id 5b1f17b1804b1-490c259a33emr364196935e9.8.1781083402105; Wed, 10
 Jun 2026 02:23:22 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:23:15 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610092318.3868884-1-gnoack@google.com>
Subject: [PATCH v3 0/3] landlock: Restrict renameat2 with RENAME_WHITEOUT
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

In V1 [5], it was discussed that whiteout objects are not the same as
character devices, and should therefore be guarded with a separate access
right.  We are therefore guarding the operation with the new access right
LANDLOCK_ACCESS_FS_MAKE_WHITEOUT now.

By introducing a new access right, that change is also exposed by
incrementing the ABI level and does not require a Landlock erratum.

Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The RENAME_WHITEOUT flag side-steps all of the existing Landlock access
rights, which are designed to restrict the creation of directory entries.
It is desirable to restrict that.

This patch set fixes that by adding a check in Landlock's path_rename hook.


[1] https://lore.kernel.org/all/adUBCQXrt7kmgqJT@google.com/
[2] https://docs.kernel.org/filesystems/overlayfs.html#whiteouts-and-opaque=
-directories
[3] https://man7.org/linux/man-pages/man2/renameat2.2.html#DESCRIPTION
[4] https://codesearch.debian.net/search?q=3Drename.*RENAME_WHITEOUT&litera=
l=3D0
[5] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/


Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D

v3:
 - Do LANDLOCK_ACCESS_FS_MAKE_WHITEOUT check as part of
   current_check_refer_path().

v2:
 - Introduce LANDLOCK_ACCESS_FS_MAKE_WHITEOUT access right
   and guard it with that.
 - Bump ABI version
 - https://lore.kernel.org/all/20260513160552.4022649-1-gnoack@google.com/

v1:
 - initial version
   https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/


G=C3=BCnther Noack (3):
  landlock: Require LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
  selftests/landlock: Add test for RENAME_WHITEOUT denial
  selftests/landlock: Test OverlayFS renames w/o
    LANDLOCK_ACCESS_FS_MAKE_WHITEOUT

 include/uapi/linux/landlock.h                |  3 ++
 security/landlock/audit.c                    |  1 +
 security/landlock/fs.c                       | 17 +++++--
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  4 +-
 tools/testing/selftests/landlock/fs_test.c   | 50 +++++++++++++++++++-
 7 files changed, 70 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  1f2b7f49b927 ! 1:  4a8c3fb9e707 landlock: Require LANDLOCK_ACCESS_FS_MA=
KE_WHITEOUT for RENAME_WHITEOUT
    @@ security/landlock/audit.c: static const char *const fs_access_string=
s[] =3D {
      static_assert(ARRAY_SIZE(fs_access_strings) =3D=3D LANDLOCK_NUM_ACCES=
S_FS);
    =20
      ## security/landlock/fs.c ##
    +@@ security/landlock/fs.c: static bool collect_domain_accesses(const s=
truct landlock_ruleset *const domain,
    +  * @new_dentry: Destination file or directory.
    +  * @removable: Sets to true if it is a rename operation.
    +  * @exchange: Sets to true if it is a rename operation with RENAME_EX=
CHANGE.
    ++ * @whiteout: Sets to true if it is a rename operation with RENAME_WH=
ITEOUT.
    +  *
    +  * Because of its unprivileged constraints, Landlock relies on file h=
ierarchies
    +  * (and not only inodes) to tie access rights to files.  Being able t=
o link or
    +@@ security/landlock/fs.c: static bool collect_domain_accesses(const s=
truct landlock_ruleset *const domain,
    + static int current_check_refer_path(struct dentry *const old_dentry,
    + 				    const struct path *const new_dir,
    + 				    struct dentry *const new_dentry,
    +-				    const bool removable, const bool exchange)
    ++				    const bool removable, const bool exchange,
    ++				    const bool whiteout)
    + {
    + 	const struct landlock_cred_security *const subject =3D
    + 		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
    +@@ security/landlock/fs.c: static int current_check_refer_path(struct =
dentry *const old_dentry,
    + 		access_request_parent2 |=3D maybe_remove(new_dentry);
    + 	}
    +=20
    ++	/*
    ++	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object i=
s
    ++	 * created in the source location, so we require an additional acces=
s
    ++	 * right there.
    ++	 */
    ++	if (whiteout)
    ++		access_request_parent1 |=3D LANDLOCK_ACCESS_FS_MAKE_WHITEOUT;
    ++
    + 	/* The mount points are the same for old and new paths, cf. EXDEV. *=
/
    + 	if (old_dentry->d_parent =3D=3D new_dir->dentry) {
    + 		/*
    +@@ security/landlock/fs.c: static int hook_path_link(struct dentry *co=
nst old_dentry,
    + 			  struct dentry *const new_dentry)
    + {
    + 	return current_check_refer_path(old_dentry, new_dir, new_dentry, fal=
se,
    +-					false);
    ++					false, false);
    + }
    +=20
    + static int hook_path_rename(const struct path *const old_dir,
     @@ security/landlock/fs.c: static int hook_path_rename(const struct pa=
th *const old_dir,
    - 			    const unsigned int flags)
      {
      	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
    -+	if (flags & RENAME_WHITEOUT) {
    -+		int err;
    -+
    -+		/*
    -+		 * Rename with RENAME_WHITEOUT creates a whiteout object in the
    -+		 * old location, so we check the access right for creating that.
    -+		 *
    -+		 * See Documentation/filesystems/overlayfs.rst and renameat2(2).
    -+		 */
    -+		err =3D current_check_access_path(
    -+			old_dir, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT);
    -+		if (err)
    -+			return err;
    -+	}
    -+
      	return current_check_refer_path(old_dentry, new_dir, new_dentry, tru=
e,
    - 					!!(flags & RENAME_EXCHANGE));
    +-					!!(flags & RENAME_EXCHANGE));
    ++					!!(flags & RENAME_EXCHANGE),
    ++					!!(flags & RENAME_WHITEOUT));
      }
    +=20
    + static int hook_path_mkdir(const struct path *const dir,
    =20
      ## security/landlock/limits.h ##
     @@
2:  aa4e4aeb5884 =3D 2:  063646822083 selftests/landlock: Add test for RENA=
ME_WHITEOUT denial
3:  6660d70a1eda =3D 3:  5d4606bc1e84 selftests/landlock: Test OverlayFS re=
names w/o LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
--=20
2.54.0.1099.g489fc7bff1-goog


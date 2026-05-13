Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF9386C3E
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688365; cv=none; b=dgw1TeRSp4G/c4EEduPoa5Xpj8hqe422YgQfhlWIazRI0HGBQzSWHIe6YHMxRVfBKKwntiquRs5fT3alNRoc82a3vbe9pAI6pR/VHn+i2QtK0dw+QIQszZeslKC4YKcrRMXMurCQdPP3+axIVCxdExsxUpBe7BOTD3iGZUKfTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688365; c=relaxed/simple;
	bh=JAwX3AkvZkfbKbJuGfYQKegG4J7hYKkEoeJo8zYNXSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liSO/Uye+zlKUbDeTlaJDuaq7ojaDswnBX9CNoxgyweibw4RL0x7yUhlJ/OIEOtrTz+7NMaqeVb3IMApvfjqSwnmzCNUngqVYxDYElbsB7wo228zBiGEDasB4+1z0+60evalBfHrDt8lDSfm6FfMWoGwyBLQPNkqnVgSb8T89F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YURroP7S; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YURroP7S"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso4640089f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688360; x=1779293160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVDXO5pYVsq4eoZ/zimi9NTOwyUpdlLrzvrvR+5Dm08=;
        b=YURroP7SBAOat1fEVqm+ywZYpHbZPaSfgH0iTil4iGuYGuxBmqqaCFEYZstumcReUR
         wCJU+TDBn+dbPcyMs9p/a7D3ibob0HatXOhhh6sBM0LXMQCs3ZNv0TAxdlcyax1kj0iA
         HNMxK774EKA3jnXT3a3g+i14SPqvuUDKfadqjFAIflDIrURdU2v4reJ7pjkVZvbmmReX
         uW4H/XCUlvvgHvFe09O6u++twketl1ngdrRVERjrbQ83/p3AC+bNS5jvdK8ucJW59UaF
         Hv4q000VDc03tDu0qocOKM369gT7Xv9zUnRhfSrtZWYNtrVKrHqk57wLiVT2BqYqslF9
         oNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688360; x=1779293160;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DVDXO5pYVsq4eoZ/zimi9NTOwyUpdlLrzvrvR+5Dm08=;
        b=q+VsQa/nMohCUmQZMvzJSkkyE/W0Il902lrWVvdqDDQtFo0inDCNG0s/yJ8Dde6sa7
         XTXey2XnoPRoq0J/OAHlcWUwia96yVcpcylNJ+SiM8djZ7k7eE+9aAnr+aZoOFON70ZJ
         j0IA07YR2jXHwM4Zc1q3jC6NEgjBwBOgdf38ekDRLY/YnJ2H3wIGYqyX4Q9Fs93gqCMN
         FSHpj0D7Dbph1/8okgaT6Mn5ZlAsImf12Vpboi+cvaOcmRRTiT+9WrRp0z7zuPDOhflN
         nq3t/dh8caz+svTT03aibEcx7fJuG9FZcO+KrJAQTQcHu0VgfVYnZhnQG5iKkuIEtn7l
         avGw==
X-Gm-Message-State: AOJu0YxJepojVJtUb/P1V/P/49jXFHz8QNxIIlhCewZ4vhJwfq7Uuthu
	EYYaCRbiBynRiuOl9lf7Jeu2mDwOx10yHcN6h9LZHuEnyDHxfAax6Clje33E9/ss+63h/y5NfUe
	seJId8Q==
X-Received: from wrvc16.prod.google.com ([2002:a5d:5290:0:b0:439:b9ad:6599])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:24c6:b0:45c:154d:6387
 with SMTP id ffacd0b85a97d-45c7a7dc6a2mr6051437f8f.37.1778688359013; Wed, 13
 May 2026 09:05:59 -0700 (PDT)
Date: Wed, 13 May 2026 18:05:50 +0200
In-Reply-To: <20260513160552.4022649-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513160552.4022649-1-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513160552.4022649-2-gnoack@google.com>
Subject: [PATCH v2 1/3] landlock: Require LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

renameat2(2) with the RENAME_WHITEOUT flag places a whiteout character
device file in the source file location in place of the moved file.
This creates a directory entry even in cases where all
LANDLOCK_ACCESS_FS_MAKE_* rights are denied.

Introduce the LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right, which is checked
for the origin directory if RENAME_WHITEOUT is passed.

This does not affect normal renames within layered OverlayFS mounts:
When OverlayFS invokes rename with RENAME_WHITEOUT as part of a
"normal" rename operation, it does so in ovl_rename() using the
credentials that were set at the time of mounting the OverlayFS.

Bump the Landlock ABI version to 10.

Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h                |  3 +++
 security/landlock/audit.c                    |  1 +
 security/landlock/fs.c                       | 15 +++++++++++++++
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  4 ++--
 tools/testing/selftests/landlock/fs_test.c   |  5 +++--
 7 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 10a346e55e95..1f8a1d6d25f1 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -328,6 +328,8 @@ struct landlock_net_port_attr {
  *
  *   If multiple requirements are not met, the ``EACCES`` error code takes
  *   precedence over ``EXDEV``.
+ * - %LANDLOCK_ACCESS_FS_MAKE_WHITEOUT: Create a whiteout object through
+ *   :manpage:`rename(2)` with ``RENAME_WHITEOUT``.
  *
  * .. warning::
  *
@@ -356,6 +358,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
 #define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
+#define LANDLOCK_ACCESS_FS_MAKE_WHITEOUT		(1ULL << 17)
 /* clang-format on */
=20
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 8d0edf94037d..09c97083f599 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -38,6 +38,7 @@ static const char *const fs_access_strings[] =3D {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] =3D "fs.truncate",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] =3D "fs.ioctl_dev",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] =3D "fs.resolve_unix",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_WHITEOUT)] =3D "fs.make_whiteout",
 };
=20
 static_assert(ARRAY_SIZE(fs_access_strings) =3D=3D LANDLOCK_NUM_ACCESS_FS)=
;
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c1ecfe239032..09de6ba5c3a3 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1519,6 +1519,21 @@ static int hook_path_rename(const struct path *const=
 old_dir,
 			    const unsigned int flags)
 {
 	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
+	if (flags & RENAME_WHITEOUT) {
+		int err;
+
+		/*
+		 * Rename with RENAME_WHITEOUT creates a whiteout object in the
+		 * old location, so we check the access right for creating that.
+		 *
+		 * See Documentation/filesystems/overlayfs.rst and renameat2(2).
+		 */
+		err =3D current_check_access_path(
+			old_dir, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT);
+		if (err)
+			return err;
+	}
+
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
 					!!(flags & RENAME_EXCHANGE));
 }
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index b454ad73b15e..e59378e8e897 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -19,7 +19,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
=20
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index accfd2e5a0cd..d45469d5d464 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops =3D {
  * If the change involves a fix that requires userspace awareness, also up=
date
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version =3D 9;
+const int landlock_abi_version =3D 10;
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 30d37234086c..6c8113c2ded1 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,8 +76,8 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
-					     LANDLOCK_CREATE_RULESET_VERSION));
+	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+					      LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index cdb47fc1fc0a..53d1b659849f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -579,7 +579,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
 	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
@@ -593,7 +593,8 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	LANDLOCK_ACCESS_FS_REFER)
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_MAKE_WHITEOUT)
=20
 /* clang-format on */
=20
--=20
2.54.0.563.g4f69b47b94-goog


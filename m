Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBE392824
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083408; cv=none; b=aqwGJc4M9vCRbc6eqty8O9OfbSujMahvnL+miArAHHur7aklmc05A9++q6Y+3QZJ0qYAFrKlTgmJrD/jb179BJ6uM3LnCI51UdLdaggIi0RA1DcIItZOERDIakLtmPEloEVwuTtCOTi2XuYIKHpB9GMW5vdnYRq6WXS+vVXmqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083408; c=relaxed/simple;
	bh=Y3z6UYAsAZkiz2oLadIpW6vDoiF70bMA16W5zyM1hSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TuTj81qSrm+NYCjg0wVRrQsY073vmHj6ZppWc6LV783qxMhjuL1zxk4c4zjPjFL7ovhy+BcKljK5uoaiAu6DQhYBi9YJDD78Mv4uAKV9bDh5aHnTMxR6+c/28DcDlixMpGtl0xlc87/3QQ55VaxH854/JjQkQZTXAKfuwx3fiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3PdnB9m; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3PdnB9m"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45efa12a788so4492847f8f.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781083405; x=1781688205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/G++3vR3Sm0gSldZG9s59J919nabzwGS/4shg/BIS4o=;
        b=r3PdnB9mGwgVxfQFJwUw/ib4CxfxA/6/96223szot7VOLuTlj1kslv67btMCjCY28T
         XAgjDMHmP1RLDLNdOmzYIEio33n0BJJTHhkOM6FAwftMIcfqqP8rcL3gb+22s6e8exzz
         dw549UpfYOaZMcbVnG3ytosVv2jj6bjHO6W3gwC5v16aqm/Wmid3OLmi2YOFJPit93EI
         iDnqI06kAzIDwkFLabJM/IBTMFXmY0AmxX5kCylLQgin/PNHziutKFdOLDFgvRVIwzAk
         I4tcGnXSxSMNy1wlW1AOi1pgEotbHrZ9KvodmBLWv/1Uolmim1hJAmlDxX8sAZ0Ji8AE
         R9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083405; x=1781688205;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/G++3vR3Sm0gSldZG9s59J919nabzwGS/4shg/BIS4o=;
        b=cmYuCoQR6lbfTGw0MFB9WVyLP1ASjSA4upKWlYS0X50tzghbd4+ADlzau/PZj29wem
         s2lwqq9S7AQhy8afQuneLTfkxgS1ls67ycLUJ2Qx9Pd519K2vQNcYzD/uPzwkcXmc2bd
         iPO6F85E5DX+iOHAGbCqNeS2GgQexu2ptNw97CN0064BmyHwfCvo2RJgQU4EBFlseJo/
         Q/tZ4yVeMCxWaRLtSPr54QySalhU4Rrf+WM1GGBovQJs6n9gDw3t7gykntI2TCIJCB7h
         qeuL8YaZftDVo+9k+oo/51JWf3tG70sQpNbmdTl0Kch7qy/HHtW6+TQOMZqAjpgJuf99
         oGYA==
X-Gm-Message-State: AOJu0YwzSSxjzWjHioKz+OBIdi21OczLL5dm9eazyj+fTNDs2pi/dbBt
	PV1nXFrPyaQ1FQED2gA0cVwNi6f2VVGi3TflQnmE0LuUWRuedgF19KPtPhVx45CzfAojLJUCZbx
	/Blp7eA==
X-Received: from wmxb4-n2.prod.google.com ([2002:a05:600d:8444:20b0:490:bad8:32ba])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34cb:b0:490:4b89:5361
 with SMTP id 5b1f17b1804b1-490c25afa03mr383227725e9.7.1781083404762; Wed, 10
 Jun 2026 02:23:24 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:23:16 +0200
In-Reply-To: <20260610092318.3868884-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610092318.3868884-1-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610092318.3868884-2-gnoack@google.com>
Subject: [PATCH v3 1/3] landlock: Require LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
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
 security/landlock/fs.c                       | 17 ++++++++++++++---
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  4 ++--
 tools/testing/selftests/landlock/fs_test.c   |  5 +++--
 7 files changed, 25 insertions(+), 9 deletions(-)

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
index c1ecfe239032..67810d5242b2 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1080,6 +1080,7 @@ static bool collect_domain_accesses(const struct land=
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
@@ -1127,7 +1128,8 @@ static bool collect_domain_accesses(const struct land=
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
@@ -1159,6 +1161,14 @@ static int current_check_refer_path(struct dentry *c=
onst old_dentry,
 		access_request_parent2 |=3D maybe_remove(new_dentry);
 	}
=20
+	/*
+	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
+	 * created in the source location, so we require an additional access
+	 * right there.
+	 */
+	if (whiteout)
+		access_request_parent1 |=3D LANDLOCK_ACCESS_FS_MAKE_WHITEOUT;
+
 	/* The mount points are the same for old and new paths, cf. EXDEV. */
 	if (old_dentry->d_parent =3D=3D new_dir->dentry) {
 		/*
@@ -1509,7 +1519,7 @@ static int hook_path_link(struct dentry *const old_de=
ntry,
 			  struct dentry *const new_dentry)
 {
 	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
-					false);
+					false, false);
 }
=20
 static int hook_path_rename(const struct path *const old_dir,
@@ -1520,7 +1530,8 @@ static int hook_path_rename(const struct path *const =
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
2.54.0.1099.g489fc7bff1-goog


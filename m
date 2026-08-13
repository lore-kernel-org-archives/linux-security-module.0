Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DB30F924
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613542; cv=none; b=jiCO3Mi0qMa1sXJwGT4F2xplaN7qp1OixHdM9Z+oJtKmzU0NXgw3chOVeekLganTupv/EnE3440H9yEJn/PTdUoEU7NjtywFe0qkiibCiLCRFBGrt5zlWdb4Ds2tYRWnPKjJlVho0Mt95s0lMvYO+3kQXuVCx0uhwog5agv9WWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613542; c=relaxed/simple;
	bh=6Fe115/E8LmA3L4DNptgcBYXSgvPwv+wAjcr1kGZScc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CwmD1eHtj/88lvJ0sM7yhWwzrJPZqCVkfogVugDVZ65zFBwmD0cKOA5NW+Q9tseV/MvjiWoPGXJN341npppQn8YJsBW/AHFdY+Yf0vPKMlKg4myB4JN0ScHQyU+jgRxsMkkvExQSa2OjBVQ5iJMWjCf5bcuirDcUvHvs7MAomgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYRpGT6I; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYRpGT6I"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c167e032f03so41667766b.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786613539; x=1787218339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PGQ0sjjU/ewZQgqV841U3UcbLXMXvr0K5Bswu4dRh6E=;
        b=TYRpGT6InwJNyqvq87m+nlpUzYdQdcLpYNPz1dBoHikQlBn3g1WNagm7sGCToQh7zQ
         Hb5wTBhWMvnouAuZjW9WhnAK9riCY/XWFwTOJ5hi13A9QZp0kS0dUMVOfwqaYDnmCBrI
         atcdDbK90Z7gfXOdQ7OrG8TyWrHBb1uOkpIdCyw/5M4eJr5KfYAA1gONwNgZwHbor9zw
         EaP3mf3NsT4y0/IH2rRZ5LAygVWP7wbFixshXmtUUWXRPGWk+sh70pjXMQynRSU+SHTQ
         eZv9PhlqtYibKFZqW2/BthKdJyz26IDx87IzsBm4cYDZ9RfR10kY0AaPUFDGxECWcFrT
         HWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613539; x=1787218339;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGQ0sjjU/ewZQgqV841U3UcbLXMXvr0K5Bswu4dRh6E=;
        b=Xl4ZhPhEvuVFSTzYEW1zyemqY2gUip7Kc0ntDIs+iqIcnRfdwbygtDhUIbC7NVYO4h
         1sWBv4g5ktY7hbW4ytZZNzWKDbj1NW3xvKGP5cIgTemWW8oZbGqw/3JkHHdb1xnOxJAe
         W/o6u9NFsCl5OW2uczkWOy5zkgtHQs1a31VhL+mvS0YQn2qOFkRKdV15tEJ+UD4nA1hU
         Gq34jHQerZXRwkosaZZe7f2FLF1Hub0UyVWkczwXCfFjgcXpATbv2+GASFU6qj1DAwQg
         ngv0+gQOXKUtMU4CStc8qN3EfGa7SNJZX+i0lNUbLRk8IA6T61+JA3n7y8wTC1/jJ/gZ
         lXAw==
X-Gm-Message-State: AOJu0Ywto/g//0hvEAP4+u6C56dxhiFhmBHqX2ETyKzRE97GMbnJUKzd
	DV32WutZfdpfiorJDdzHCrFheWvn9Ezdc/7EEMjLVpE+Ruk2mT2NftCwSjl3qlP7XZgVLDs+hq3
	udE+0bg==
X-Received: from edcpv21.prod.google.com ([2002:a05:6402:c295:b0:69f:5133:7186])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e0d:b0:c20:56a9:af3d
 with SMTP id a640c23a62f3a-c21090df101mr196547966b.32.1786613538342; Thu, 13
 Aug 2026 02:32:18 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:31:54 +0200
In-Reply-To: <20260813093157.1436894-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813093157.1436894-1-gnoack@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260813093157.1436894-4-gnoack@google.com>
Subject: [PATCH v6 3/6] selftests/landlock: Add tests for whiteout object creation
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a test to check that whiteout object creation is guarded by
LANDLOCK_ACCESS_FS_MAKE_REG, in the cases where these are created from
userspace:

* Conventional creation with mknod()
* Linking or renaming an existing whiteout object
* renameat2() with RENAME_WHITEOUT,
  which creates a new whiteout object in the source location

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 176 +++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index e82b56a74c5f..871a5b819b98 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2247,6 +2247,170 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
=20
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	/* The affected file is a FIFO. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+
+	/* Deny MAKE_REG, but allow MAKE_FIFO. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, NULL);
+
+	/*
+	 * Try to rename a file with RENAME_WHITEOUT.
+	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
+	 * Denied, because whiteout creation is guarded with MAKE_REG.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+}
+
+static bool is_whiteout(const char *const path)
+{
+	struct stat st;
+
+	if (stat(path, &st) =3D=3D -1)
+		return false;
+
+	return S_ISCHR(st.st_mode) && st.st_rdev =3D=3D makedev(0, 0);
+}
+
+static bool is_fifo(const char *const path)
+{
+	struct stat st;
+
+	return stat(path, &st) =3D=3D 0 && S_ISFIFO(st.st_mode);
+}
+
+TEST_F_FORK(layout1, rename_whiteout_allowed)
+{
+	const struct rule rules[] =3D {
+		{
+			.path =3D dir_s3d3,
+			.access =3D LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The affected file is a FIFO. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+
+	/* Allow MAKE_REG below dir_s3d3. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, rules);
+
+	/*
+	 * Rename a file with RENAME_WHITEOUT within the same directory.
+	 * Allowed, because MAKE_REG is granted for the whiteout object which
+	 * gets created in the source location.
+	 */
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+			       TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+
+	/* A whiteout object took the place of the moved FIFO. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(TMP_DIR "/s3d1/s3d2/s3d3/f2"));
+}
+
+TEST_F_FORK(layout1, rename_whiteout_reparenting)
+{
+	const struct rule rules[] =3D {
+		{
+			.path =3D dir_s3d2,
+			.access =3D LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path =3D dir_s3d3,
+			.access =3D LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The moved files are FIFOs. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+	ASSERT_EQ(0, unlink(file1_s3d4));
+	ASSERT_EQ(0, mknod(file1_s3d4, S_IFIFO | 0600, 0));
+
+	/* Allow REFER below dir_s3d2, but MAKE_REG only below dir_s3d3. */
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   rules);
+
+	/*
+	 * The whiteout object is created in the source directory: Moving the
+	 * FIFO out of dir_s3d4 is denied because MAKE_REG is not granted
+	 * there, even though it is granted in the destination directory
+	 * dir_s3d3.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+
+	/*
+	 * Moving the FIFO out of dir_s3d3 is allowed, because MAKE_REG is
+	 * granted there for the created whiteout object.
+	 */
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+			       TMP_DIR "/s3d1/s3d2/s3d4/f2", RENAME_WHITEOUT));
+
+	/* A whiteout object took the place of the moved FIFO. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(TMP_DIR "/s3d1/s3d2/s3d4/f2"));
+}
+
+TEST_F_FORK(layout1, rename_whiteout_exchange)
+{
+	const char *const whiteout_s3d3 =3D TMP_DIR "/s3d1/s3d2/s3d3/f2";
+	const struct rule rules[] =3D {
+		{
+			.path =3D dir_s3d2,
+			.access =3D LANDLOCK_ACCESS_FS_REFER,
+		},
+		{
+			.path =3D dir_s3d3,
+			.access =3D LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+
+	/* The exchanged files are FIFOs and an existing whiteout object. */
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ASSERT_EQ(0, mknod(file1_s3d3, S_IFIFO | 0600, 0));
+	ASSERT_EQ(0, mknod(whiteout_s3d3, S_IFCHR | 0600, makedev(0, 0)));
+	ASSERT_EQ(0, unlink(file1_s3d4));
+	ASSERT_EQ(0, mknod(file1_s3d4, S_IFIFO | 0600, 0));
+
+	/* Allow REFER below dir_s3d2, but MAKE_REG only below dir_s3d3. */
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   rules);
+
+	/*
+	 * With RENAME_EXCHANGE, the whiteout object moves into the source
+	 * directory of the rename: Exchanging the FIFO in dir_s3d4 with the
+	 * whiteout object is denied because MAKE_REG is not granted in
+	 * dir_s3d4, even though it is granted in the whiteout object's own
+	 * directory dir_s3d3.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
+				RENAME_EXCHANGE));
+	EXPECT_EQ(EACCES, errno);
+
+	/*
+	 * Exchanging the FIFO in dir_s3d3 with the whiteout object is
+	 * allowed, because MAKE_REG is granted in the directory into which
+	 * the whiteout object moves.
+	 */
+	EXPECT_EQ(0, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD, whiteout_s3d3,
+			       RENAME_EXCHANGE));
+
+	/* The FIFO and the whiteout object swapped places. */
+	EXPECT_TRUE(is_whiteout(file1_s3d3));
+	EXPECT_TRUE(is_fifo(whiteout_s3d3));
+}
+
 TEST_F_FORK(layout1, rename_dir)
 {
 	const struct rule rules[] =3D {
@@ -3270,6 +3434,18 @@ TEST_F_FORK(layout1, make_char)
 		       makedev(1, 3));
 }
=20
+TEST_F_FORK(layout1, make_whiteout)
+{
+	/*
+	 * Creates a whiteout object (creation guarded by MAKE_REG).
+	 *
+	 * Contrary to the other character devices, this does not require
+	 * CAP_MKNOD, cf. vfs_mknod().
+	 */
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFCHR,
+		       makedev(0, 0));
+}
+
 TEST_F_FORK(layout1, make_block)
 {
 	/* Creates a /dev/loop0 device. */
--=20
2.55.0.699.gb54405d56f-goog


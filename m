Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9004745ED
	for <linux-security-module@vger.kernel.org>; Fri,  9 Feb 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498386; cv=none; b=F8rEVueYnEykF1hNXygG3zYmp2/dkPXXlh80jaF2ex5rZRERIh4TAjDrgWeQHsHjAx2NQ2gUeAwdMuvkLTH0j72bGFzcTeXP9o/ZDm/wBfxPEJRex1EZ1n2VGaWU6TfHQO+GDdO9A9QdoaKfpGksGw83ukZ04LzQWW4XXYBq/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498386; c=relaxed/simple;
	bh=pgXtTW831ZCa5Q1K21oQWfrSPXWxTFd8H3OjAYMuwjA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=NqiDZcrVvyo8ma3q4y6tv/fTzXcOtXSpiJCt4RrViEcmPsnMb2z4fBj3/MP9GmlGgjs3NBu4I09cVJveSz8qpSKtswx6n3TzU8DK3HkVursBO0iITGNcnx0Ti/8TYzCHTaBbdDfV+I9wf1Y8Oc3IqFTkaamI98dfldzlQFUEIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZE2xuwn; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZE2xuwn"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5589ce327e2so1005628a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 09 Feb 2024 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498383; x=1708103183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWceuWdFUB2p61QT2dRG6Wq/C3P9HIbEdoSnPoZ0Bb0=;
        b=TZE2xuwnzo9qNAEYQYr72tHeuDACPJcN0NwdSTPUJ0l1XGQfSYQ0Q1NJnlxc0XqU36
         wKl6JrT/sAGypjuKBLbIn0EDBv7mAle2yb3G7mlq7swxSgVzhYyPDjk+98sj8p21zA5Q
         Ek+6Ze4KAWaONyXN0zajI2XGKpHtnAlU1td2R/bYEB2O8sp0LfZAh6jGsaByWYR1ho75
         qLp/XUcsGlUEi0koJY8R2n/NukM2g9zfXrBtquTN1Lv+uU+Y5X2GV7s3Gm15Mu3hg2PK
         JrkUBQr8izdx3fwSqMdAcDKdwyS0Uf1qsxZPNY36J+bLwD11HcRAuDFzws2E+2CgACiB
         U0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498383; x=1708103183;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWceuWdFUB2p61QT2dRG6Wq/C3P9HIbEdoSnPoZ0Bb0=;
        b=erQssnEycshBEkn40MtOh5se2sbJWJRndNOnY0irQPdC55ytcsO1kb9t5IsKNz2usd
         jo1W/AGYxie6UdSNPy6fuWqXYSI0vKLoMVLWclpwGrhuULY18NhGGS+c2wvK+4yM0vkb
         G3UvYaAqveUOihXutUQV7//TE+71zLOCUmhIqt3toDP8zva8l1i24hMg/vWNkEVlWmkJ
         pwmi+WODeB4qNCfM8CTFja0zZ2dx2shHoqi9g6Ckwds8FXz67xSbH07z7DGaCEVJ39P1
         kixJfyExbPxUt+jbTlwRjmB3cfT5SYI8j+doaUXPLDha2wkOdFGa+pww9zX0tlsfHizK
         hV1A==
X-Gm-Message-State: AOJu0Yy9sTYwRmvNMqcj9YxFAWJ5hdoOUGv0QWv4KCgnVjlTVmA50AFP
	0IgXEQNk/q1PJvfWG3ETMa5d46t+deMv70sBTrWEsSiUkFopPqaHlZYLdOrmCuJjE2b00PcarlR
	kIR/U4eTv/ZtCLr0VU6oYj4+1TA7TIAoGeM3mY/5qc8UvulETiTJg5cOQXLxgtekCBvoYrJQ50N
	xbzArMHTvHZztArEFUbPbzvBYdRry6IOi+eYZmCnpTfwUKwavSk0ab
X-Google-Smtp-Source: AGHT+IHaiaOhKUPbOA5Nox92k2d5qWgKBE3k8Rcqe2AhHnovtDLCmsYap3nsfmDwEeQjLTkpM2cdXGh3sWs=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4496:b0:560:9958:1010 with SMTP id
 er22-20020a056402449600b0056099581010mr7567edb.7.1707498382970; Fri, 09 Feb
 2024 09:06:22 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:06 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 2/8] selftests/landlock: Test IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Exercises Landlock's IOCTL feature in different combinations of
handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 379 ++++++++++++++++++++-
 1 file changed, 376 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 3203f4a5bc85..6ff1026c26c2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -23,6 +23,12 @@
 #include <sys/vfs.h>
 #include <unistd.h>
=20
+/*
+ * Intentionally included last to work around header conflict.
+ * See https://sourceware.org/glibc/wiki/Synchronizing_Headers.
+ */
+#include <linux/fs.h>
+
 #include "common.h"
=20
 #ifndef renameat2
@@ -735,6 +741,9 @@ static int create_ruleset(struct __test_metadata *const=
 _metadata,
 	}
=20
 	for (i =3D 0; rules[i].path; i++) {
+		if (!rules[i].access)
+			continue;
+
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
 				 rules[i].path);
 	}
@@ -3443,7 +3452,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3526,7 +3535,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3752,7 +3761,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3829,6 +3838,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
+/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
+static int test_fs_ioc_getflags_ioctl(int fd)
+{
+	uint32_t flags;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
+		return errno;
+	return 0;
+}
+
 TEST(memfd_ftruncate)
 {
 	int fd;
@@ -3845,6 +3864,360 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/* clang-format off */
+FIXTURE(ioctl) {};
+/* clang-format on */
+
+FIXTURE_SETUP(ioctl)
+{
+	prepare_layout(_metadata);
+	create_file(_metadata, file1_s1d1);
+}
+
+FIXTURE_TEARDOWN(ioctl)
+{
+	EXPECT_EQ(0, remove_path(file1_s1d1));
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(ioctl)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const mode_t open_mode;
+	/*
+	 * These are the expected IOCTL results for a representative IOCTL from
+	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
+	 * results here, and treat other errors as 0.
+	 */
+	const int expected_fioqsize_result; /* RW */
+	const int expected_fibmap_result; /* RW_FILE */
+	const int expected_fionread_result; /* special */
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D 0,
+	.open_mode =3D O_RDWR,
+	/*
+	 * If LANDLOCK_ACCESS_FS_IOCTL is handled, but nothing else is
+	 * explicitly handled, almost all IOCTL commands will be governed by the
+	 * LANDLOCK_ACCESS_FS_IOCTL right.  Files can be opened, but IOCTLs are
+	 * disallowed.
+	 */
+	.expected_fioqsize_result =3D EACCES,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwd_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwd_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_ri_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_wi_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_di_allowed_d) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_DIR,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_rw) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE=
,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_ri) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_wi) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+static int test_fioqsize_ioctl(int fd)
+{
+	size_t sz;
+
+	if (ioctl(fd, FIOQSIZE, &sz) < 0)
+		return errno;
+	return 0;
+}
+
+static int test_fibmap_ioctl(int fd)
+{
+	int blk =3D 0;
+
+	/*
+	 * We only want to distinguish here whether Landlock already caught it,
+	 * so we treat anything but EACCESS as success.  (It commonly returns
+	 * EPERM when missing CAP_SYS_RAWIO.)
+	 */
+	if (ioctl(fd, FIBMAP, &blk) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D dir_s1d1,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open(file1_s1d1, variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const char *const path =3D dir_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int dir_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Ignore variant->open_mode for this test, as we intend to open a
+	 * directory.  If the directory can not be opened, the variant is
+	 * infeasible to test with an opened directory.
+	 */
+	dir_fd =3D open(path, O_RDONLY);
+	if (dir_fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(dir_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(dir_fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const char *const path =3D file1_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
+		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
+			     "can not be granted on files");
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open(path, variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.43.0.687.g38aa6559b0-goog


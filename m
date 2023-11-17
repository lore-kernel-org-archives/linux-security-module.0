Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B745C072A2
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Nov 2023 15:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjKQPts (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjKQPtn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 10:49:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466F11D
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b59662ff67so25707507b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236179; x=1700840979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB1G0pSFnh90AFDrFXqyA+gNp0ElXy6xfe2eRyBIU6Q=;
        b=LV/1TgCaf93stg3blgNUkXoTL1M3FswVcsI/snM8ILdKWG8HYcsyx9vYqgVmdfAd5Z
         MIIIPW2vHhsFlMbvJWmp7tI78q0sHjDql92pJduLUih9ZT77JT4vw8cA0MXKGUJTkVEL
         LAqwHz8QoJTBbUnlwExfgGfDyn38oIb/a1UMl6P5wcgB9naqlFswpGg0Ew6v/TN/I7pR
         h4oCc+7G2xmhMzb0oPSGLgtTVonsi+lMZveSjV3vqVmN8fGG40gGGrqlsb/e+ntuP+ub
         8cSiclLdZdqPXx5Pf7AYOahwN5235Z/4PitHjGdba8bWcCQOwEPaJau22dfZXT9mXw6i
         2XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236179; x=1700840979;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CB1G0pSFnh90AFDrFXqyA+gNp0ElXy6xfe2eRyBIU6Q=;
        b=vZAEAeN0n3vS8Em7jfaVzzy3mqfqSSchXpR2AqYifKy4ZZU6+U5tySDsV8ik4daXZZ
         JYgoQb55hdmz9dEI3S9q78bf6ExT47kYncG6RDRYBs8H1q4B1B5yM3WjCGCoHIMoeZGa
         scx+sInrb5ji6Is/bWcGeC2U9fSIznX56QHqD9U6SvH74k63eIltCo5wrjCM4jteRolh
         0RDDcgNxscsfdhnt9mtWMKbimXofaE3AZI3eZNvCKZ13aY2D0Bpsf1a5tAd/4xWV5LT4
         67fhJUEwfoQcusWoZoSjTlLCLln7AEh6mnKVCWvJvSiaFEAzUt5QgU95p74AF5B7hRRp
         C7KA==
X-Gm-Message-State: AOJu0Yxd7l9J66l3pRC2kmdkrp8FkbCcqNB52ov43t/HJB/9x8psVzV4
        wMk7q/hAnB0rWIDO2Z/s1aRxlkmyNhhifHEREQV+ypcgf8NEcn5pZ2UvswkhLSNHetB34douSrK
        EgE8TemmU6vMMaulOSOFpg/kU7ID67728XgWVcgh/s8ZjU6a/QOVjcOG5C/d9v/YLws+fjEUMeP
        6Yx2ZjDQ==
X-Google-Smtp-Source: AGHT+IERYqT4X4e5oow9/OBDpktHd2R9R6ftPIKLPVry5XbGP9gHx4xIarnXl0L53dR4h77CPNAdy0Jp38I=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6902:571:b0:d9c:a723:5c3c with SMTP id
 a17-20020a056902057100b00d9ca7235c3cmr157438ybt.1.1700236178618; Fri, 17 Nov
 2023 07:49:38 -0800 (PST)
Date:   Fri, 17 Nov 2023 16:49:16 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-4-gnoack@google.com>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 3/7] selftests/landlock: Test IOCTL support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Exercises Landlock's IOCTL feature in different combinations of
handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 423 ++++++++++++++++++++-
 1 file changed, 420 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 256cd9a96eb7..564e73087e08 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -9,6 +9,7 @@
=20
 #define _GNU_SOURCE
 #include <fcntl.h>
+#include <linux/fs.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
 #include <sched.h>
@@ -3380,7 +3381,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3463,7 +3464,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3690,7 +3691,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3767,6 +3768,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
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
@@ -3783,6 +3794,412 @@ TEST(memfd_ftruncate)
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
+	const __u64 permitted;
+	const mode_t open_mode;
+	/*
+	 * These are the expected IOCTL results for a representative IOCTL from
+	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
+	 * results here, and treat other errors as 0.
+	 */
+	const int expected_fioqsize_result; /* G1 */
+	const int expected_fibmap_result; /* G2 */
+	const int expected_fionread_result; /* G3 */
+	const int expected_fs_ioc_zero_range_result; /* G4 */
+	const int expected_fs_ioc_getflags_result; /* other */
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D EACCES,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.permitted =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwd_permitted_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwd_permitted_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_ri_permitted_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_wi_permitted_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_di_permitted_d) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_DIR,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_rw) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		     LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_ri) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_wi) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
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
+#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
+
+static int test_fs_ioc_zero_range_ioctl(int fd)
+{
+	struct space_resv {
+		__s16 l_type;
+		__s16 l_whence;
+		__s64 l_start;
+		__s64 l_len; /* len =3D=3D 0 means until end of file */
+		__s32 l_sysid;
+		__u32 l_pid;
+		__s32 l_pad[4]; /* reserved area */
+	} reservation =3D {};
+	/*
+	 * This can fail for various reasons, but we only want to distinguish
+	 * here whether Landlock already caught it, so we treat anything but
+	 * EACCES as success.
+	 */
+	if (ioctl(fd, FS_IOC_ZERO_RANGE, &reservation) < 0 && errno =3D=3D EACCES=
)
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
+			.access =3D variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open(file1_s1d1, variant->open_mode);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const char *const path =3D dir_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
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
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const char *const path =3D file1_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
+
+	if (variant->permitted & LANDLOCK_ACCESS_FS_READ_DIR) {
+		/* This access right can not be granted on files. */
+		return;
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open(path, variant->open_mode);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.43.0.rc1.413.gea7ed67945-goog


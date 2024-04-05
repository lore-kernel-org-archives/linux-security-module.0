Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624ED17555A
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353278; cv=none; b=pq7WleB3F7pJr2NkMFdZ5vV+XTBn8dG2WFmS1BedVFQipc8kjW+nerNhp3jksZmJP/shwgsEp5i0pEvDO9vftQcgfFyZdxcYHA7kOr7os22FPrrS6VzNBAwdhJ6KHQk4Fa/ZG/aRlQlvyMq6DSdJmsV1F4PcvjqKPIP4805MW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353278; c=relaxed/simple;
	bh=Sum4EMToXj/OKtXUcDUkLaOTfYyFqAnqoxL7KhbOZtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sA/6ULyqyHHzCpG85RTNKubjxzTO5sLz6V3g1KBQ2pTRArdZKtbIaCYGCRvO1DaVf23OS7UKEPyIukElFKkM++KRLybYrt2XKSlG8PHLfDRj9RSTKIFog1l4rdSdLCbSD0rqI35S5lDRWn9qQ6c9hzBDufOIO2Yd7OjkgYbckbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=le0P1/59; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="le0P1/59"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so2091217a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353275; x=1712958075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aofx+t608hkJDSbgJreaC1UFvhMHU/jfKZpHBV0ifF8=;
        b=le0P1/59pzyNC//ihogwu8nSuYd/OTVtYjRD1DZFyuqyC+GqTJg05kd1vNbOqRfYhp
         t1E5FJfjJvKF9N2EpNq+vv9YRCwnYzrkNMfgUgboPwESBjGZrURdJqsmDQxWdMt6DSRC
         u5SY+EaL85G80WLxf8d0/bGx0jLC4qCuGqZkHOhM0iRrupE5e/404IdloiakyiTwGTBq
         DyjamtlsAobG5La6seS8eifJCAwbu502SKBVwSH3kgXNfOGKhKYJ2P0Wlb6XVNqEwDRX
         r3uN9Om3BxOUceDSLmG45A6Xvtc+9ixettn7nfsPxc/Lu/Ziew0iHrz+FfthdkNjnkZ+
         XoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353275; x=1712958075;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aofx+t608hkJDSbgJreaC1UFvhMHU/jfKZpHBV0ifF8=;
        b=kmWLe8MYON6O7nTA4h22s4II6tNc7dsMdybHggfTtLgQzu62bX4Rbs7IH1URMj4SFB
         paJP6/jLfwW7QCIvAsjveP0ig1vO3t7GrbV8pW1BE9J95/Kkw8EnB60xlnCdCiJhO6h/
         XnnqHaDUB2va8gB2nfY6pzLU+wubVmlGBMlPfnjAVJCa9SRycTiS2srN+ENnDx+2BYBO
         gKA3nsOIqhaiy1iB2xaqcf8e/Z/d9h0Ht6vq35PGnhtVamuoMyAe1gJAlagp6+u2NbzA
         viOelfQReHm5DkATDTVeGpdztYv375dQ8E6A7PuQDqoRwWT7WWpCEDGHWsYPQqRFdwO5
         Ss7Q==
X-Gm-Message-State: AOJu0YzGXQCplGRJWTU8IUc6rPPz9qbunwdz+gyISkk1OijYpA2IVdPe
	cvKrJJIrw5kzZrp1Gzm61vh8nNHs7yHF7DrqXfoGD1lpH+yRjpj6jmb/y49WN3qrk+3ewp3VvhF
	A/glL44TEZs2aXGEw5AS+Yq2RsuWaflq4frAUPqWRIAH1ygGZbSu+zvQ5N++FKUhSVl+gxWiWKB
	JlaB6Io36hbZl3gBCUKQald7ybhFyY1W9K5FcBMld3YFu4c2b3HA3n
X-Google-Smtp-Source: AGHT+IGxjy6XrGMyavG+XiOc2sbD3JYzVW80Y9PbADM1gGdwDlRngpPHRsrHLQ8vV5V0dy+NKImSpzD8YV0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5296:b0:56e:c25:6cb2 with SMTP id
 en22-20020a056402529600b0056e0c256cb2mr4132edb.4.1712353274740; Fri, 05 Apr
 2024 14:41:14 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:31 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-4-gnoack@google.com>
Subject: [PATCH v14 03/12] selftests/landlock: Test IOCTL support
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
handling and permitting the LANDLOCK_ACCESS_FS_IOCTL_DEV right, and in
different combinations of using files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 227 ++++++++++++++++++++-
 1 file changed, 224 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 418ad745a5dd..8a72e26d4977 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -8,6 +8,7 @@
  */
=20
 #define _GNU_SOURCE
+#include <asm/termbits.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
@@ -15,6 +16,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/capability.h>
+#include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/sendfile.h>
@@ -23,6 +25,12 @@
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
@@ -737,6 +745,9 @@ static int create_ruleset(struct __test_metadata *const=
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
@@ -3445,7 +3456,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3528,7 +3539,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3754,7 +3765,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3831,6 +3842,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
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
@@ -3847,6 +3868,206 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+/* clang-format off */
+FIXTURE(ioctl) {};
+
+FIXTURE_SETUP(ioctl) {};
+
+FIXTURE_TEARDOWN(ioctl) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(ioctl)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const mode_t open_mode;
+	/*
+	 * TCGETS is used as a characteristic device-specific IOCTL command.
+	 * The logic is the same for other IOCTL commands as well.
+	 */
+	const int expected_tcgets_result; /* terminal device IOCTL */
+	/*
+	 * FIONREAD is implemented in fs/ioctl.c for regular files,
+	 * but we do not blanket-permit it for devices.
+	 */
+	const int expected_fionread_result;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D 0,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+static int test_tcgets_ioctl(int fd)
+{
+	struct termios info;
+
+	if (ioctl(fd, TCGETS, &info) < 0)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev",
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
+	file_fd =3D open("/dev/tty", variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/* Checks that IOCTL commands return the expected errors. */
+	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev",
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
+	dir_fd =3D open("/dev", O_RDONLY);
+	if (dir_fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands return the expected errors.
+	 * We do not use the expected values from the fixture here.
+	 *
+	 * When using IOCTL on a directory, no Landlock restrictions apply.
+	 * TCGETS will fail anyway because it is not invoked on a TTY device.
+	 */
+	EXPECT_EQ(ENOTTY, test_tcgets_ioctl(dir_fd));
+	EXPECT_EQ(0, test_fionread_ioctl(dir_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIGETBSZ, &flag));
+
+	ASSERT_EQ(0, close(dir_fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev/tty0",
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
+	file_fd =3D open("/dev/tty0", variant->open_mode);
+	ASSERT_LE(0, file_fd)
+	{
+		TH_LOG("Failed to open /dev/tty0: %s", strerror(errno));
+	}
+
+	/* Checks that IOCTL commands return the expected errors. */
+	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.44.0.478.gd926399ef9-goog


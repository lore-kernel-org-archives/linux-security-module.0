Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB9130E3F
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543098; cv=none; b=RmSFsTAxlqr5KkBsSMIUhvJkUpTcX8qyMTJdVKYaOVxG/TDtQIYrFRZW873Yf9f4yYuHYFDYioacWdufmXMTiGAHPj9cEit4A2EPn4ujozWWER/6bu2bTJyfiob1/1e68cB8QjfU/AUCfc8OPLhQk7QVgMw4JEnagYbg+atvlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543098; c=relaxed/simple;
	bh=89WV0CMvwXh9yq7ka8y1xe6QHE0cARt1R2UcEVb6Bts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YVxxx0E5QJRJ6PglN4ZkB7QGsydUwTVjK/i8ZZQXn0HDNTd2dm8p0UJCKq/agvhuGIllckfrs5s96JctTcFIH9N3l9GCEcUTbnjXfer96+wt9CKSD7fpKHau3sFpG9q8QRYvniUIPyEbftTrC5hqYpyWIRk0CU6AFb21omCmT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZS+IJy9d; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZS+IJy9d"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56e34264982so652124a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543095; x=1714147895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHBJvnMnNJzJ8vAgi2MyZlVxWJr4muBmk+RXJTR3a8k=;
        b=ZS+IJy9dsPLUIP1btRMCU7QyFotp5C5yRgZGU+slH8tYBkbiYYV3QSYY8wl+3B2RTF
         cEFGlsfdK3B3pmWCmYob4JejPdbjl1KzRuGehRvm8KRrpXJ5LmtbR0eohWnWO3WpGQCh
         ECWFkRivBcpIRQ2pZ+DK5AviGzD9IOrmq+4lTM2MRScdZF2Waw9cVwAI3yTu4teU2CDd
         /AmhrDWCk3TIzCdcHBIN885rO3ymu/u5g+nm7lxnrbZdHtg4ZfyHPvu5IkjwX985m8Sd
         begqC8345sGL2tTEGOQB8hlsJNvYNjN6CeNrOntH32qBj0qnpVeWvoTlOqNyTaQkSwUD
         JYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543095; x=1714147895;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OHBJvnMnNJzJ8vAgi2MyZlVxWJr4muBmk+RXJTR3a8k=;
        b=t9dujx3O4d8gHiQHlZPWxKI2iw7YmkBX39fTOAm8JAN492CYdjSsEHiBK1kQWyJSZl
         id1mciIwGU6L4PrJpKQFQ0GHCAJkYBT0HOP39DBgXnawlTk5H8Ivm1MfWkcTwsRUHfRI
         tXgqYHEaui+WbHKn4hQKz83MELvSUujQVENY4d94Am8/H3a3nv1hQdOtzzq760KvCLmp
         V1Ct8NdmJwmV6g6w14tSVRjxOvbSp+PzGosBcskVRaXZooS/APxtD8gM2gBcb7Pj4w8g
         /Zytvnt/+YAehwNXE+jvUh64MoYpuuLrRnD+5sOc+O8BCt+Fg90KoedtmnNHEm1dE3Mz
         PvJA==
X-Gm-Message-State: AOJu0YyRjTQLp5dEAsj+Vx5TDL8cgz1uVliD4sXBRXJyXizDs+rL0F6V
	R6JpM5rlijN3TPESGBH92I7rUUMzCcW2BSYjNQ63I6aVffpYgZC+jWtsugNgRpY7Tn4gnD5wwn7
	HdPoBbsjefFtWTUbKB/5IfMUAdurMN710FDd7aqBYdsBdRBGuXe7ZcZqz/tlhQyT9+ffwBKMDpM
	ZdhEDPIYGmH+s7PbHB4iDuaf0i8BANcaSeoBNyMJNF1OHWYJwnw4KP
X-Google-Smtp-Source: AGHT+IHiDl8X7wS/Sbq5JyAvUWf/jlE2GQl6pxK2E96e9OZ0VmTpcBzsa/EbwXKplSwO9RggliX+U2rPO3Q=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:3785:b0:56e:6989:39d6 with SMTP id
 et5-20020a056402378500b0056e698939d6mr3182edb.3.1713543094582; Fri, 19 Apr
 2024 09:11:34 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:13 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-3-gnoack@google.com>
Subject: [PATCH v15 02/11] selftests/landlock: Test IOCTL support
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
 tools/testing/selftests/landlock/fs_test.c | 192 ++++++++++++++++++++-
 1 file changed, 189 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 418ad745a5dd..cb1382a887c9 100644
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
@@ -3847,6 +3858,181 @@ TEST(memfd_ftruncate)
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
+	 * FIONREAD is used as a characteristic device-specific IOCTL command.
+	 * It is implemented in fs/ioctl.c for regular files,
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
+	.expected_fionread_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.open_mode =3D O_RDWR,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fionread_result =3D 0,
+};
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
+	file_fd =3D open("/dev/zero", variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/* Checks that IOCTL commands return the expected errors. */
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
+	 */
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
+			.path =3D "/dev/zero",
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
+	file_fd =3D open("/dev/zero", variant->open_mode);
+	ASSERT_LE(0, file_fd)
+	{
+		TH_LOG("Failed to open /dev/zero: %s", strerror(errno));
+	}
+
+	/* Checks that IOCTL commands return the expected errors. */
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
2.44.0.769.g3c40516874-goog


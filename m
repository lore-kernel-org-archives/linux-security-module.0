Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3AC19F21
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiHDTiI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiHDTiG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 15:38:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EE6E2D5
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 12:38:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e13so880997edj.12
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3j1qLeekZcD1KvZE0aOzlzwKDFcypE2FPEHeWsDtdjY=;
        b=RxECg/x6VpxJatl0LTZrJTahrO3yCfu+keuEjDJcFxpDqGqmUn/+QcVSf6wh2ufsoL
         lCRRZiH84oc93jt23ip2WK2nQbuxQ9vnFn4/uQLDCqgwwDarY9PXpw/7cfBl28oD45vp
         aJBuzE2R/L1pJqCOIruJUhcWydn3mEo9w/3wvrD3iEdeB4VvZj6qD49aM8dzCK0tSJw/
         4PRJavNavml7fPwbQdgivt/qKH0rI/eJx2rcZfU4GXRHLMaTgY5R2B3hiQz0rskBQyK9
         XOHa2rgdfVtvM6xr3b7yrPyzMhLvlk/vfG50ZFEsHyq0ooMzXVEWiqDmBJOr+UBcMphe
         rjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3j1qLeekZcD1KvZE0aOzlzwKDFcypE2FPEHeWsDtdjY=;
        b=FHuMCVqYSlSOLAkjTe/wHORoYcCBcUL4jArPS7WoWHcQKU/YlcIxvimXzYehnvvMC/
         U+LPpZrHHmk7AAM6VkMJbUUeRX6EpIx4Y0O9J1LLq5zCxGgMVBoYAydqxeKFyqRQnP1Y
         kcaIk7gip06foHYzMaSjNPWnEWmnFkY7HgERw88mJ+E0iMNJB0yf9sUFzZjPA5wLheXI
         l2SZbUnOLtsTmxqS2zgEAOirB1edKUm0He4zH8pApzwznOStN8yljNR4Y6HD8oLYqcR5
         GTU1WoiHu6FOgQyd2sy1pTBYgDCJw/TVDQyOIojt1TrpaX4rhgXcsiXMdvke4kgE0nmn
         iUzQ==
X-Gm-Message-State: ACgBeo2IXFUdJ/TWhyhTDAsNRJPg1XEXiAOVVrKJKMzs1dXp6//v/1u3
        UIGC1WIQiiKmeaOSyLqNsiKNp7KwbYk=
X-Google-Smtp-Source: AA6agR5A13SqeDcK7LL4CIjcbr8vV48RMlmqZKsoOjBSl7FpL/wG1sr/DvUU9R8iWzvrgX+JF6iWUA==
X-Received: by 2002:a05:6402:450d:b0:43b:d99:6d4f with SMTP id ez13-20020a056402450d00b0043b0d996d4fmr3542649edb.39.1659641883400;
        Thu, 04 Aug 2022 12:38:03 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072abb95c9f4sm631851ejh.193.2022.08.04.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:38:02 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3 2/4] selftests/landlock: Selftests for file truncation support
Date:   Thu,  4 Aug 2022 21:37:44 +0200
Message-Id: <20220804193746.9161-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804193746.9161-1-gnoack3000@gmail.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These tests exercise the following truncation operations:

* truncate() (truncate by path)
* ftruncate() (truncate by file descriptor)
* open with the O_TRUNC flag
* special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.

in the following scenarios:

* Files with read, write and truncate rights.
* Files with read and truncate rights.
* Files with the truncate right.
* Files without the truncate right.

In particular, the following scenarios are enforced with the test:

* The truncate right is required to use ftruncate,
  even when the thread already has the right to write to the file.
* open() with O_TRUNC requires the truncate right, if it truncates a file.
  open() already checks security_path_truncate() in this case,
  and it required no additional check in the Landlock LSM's file_open hook.
* creat() requires the truncate right
  when called with an existing filename.
* creat() does *not* require the truncate right
  when it's creating a new file.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 204 +++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cb77eaa01c91..3e84bae7e83a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
 static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
 
 static const char dir_s3d1[] = TMP_DIR "/s3d1";
+static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
 /* dir_s3d2 is a mount point. */
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
@@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
  * │           ├── f1
  * │           └── f2
  * └── s3d1
+ *     ├── f1
  *     └── s3d2
  *         └── s3d3
  */
@@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	create_file(_metadata, file1_s2d3);
 	create_file(_metadata, file2_s2d3);
 
+	create_file(_metadata, file1_s3d1);
 	create_directory(_metadata, dir_s3d2);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
@@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(file1_s2d2));
 	EXPECT_EQ(0, remove_path(file1_s2d1));
 
+	EXPECT_EQ(0, remove_path(file1_s3d1));
 	EXPECT_EQ(0, remove_path(dir_s3d3));
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	umount(dir_s3d2);
@@ -3023,6 +3027,206 @@ TEST_F_FORK(layout1, proc_pipe)
 	ASSERT_EQ(0, close(pipe_fds[1]));
 }
 
+/* Opens the file, invokes ftruncate(2) and returns the errno or 0. */
+static int test_ftruncate(struct __test_metadata *const _metadata,
+			  const char *const path, int flags)
+{
+	int res, err, fd;
+
+	fd = open(path, flags | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	res = ftruncate(fd, 10);
+	err = errno;
+	ASSERT_EQ(0, close(fd));
+
+	if (res < 0)
+		return err;
+	return 0;
+}
+
+/* Invokes truncate(2) and returns the errno or 0. */
+static int test_truncate(const char *const path)
+{
+	if (truncate(path, 10) < 0)
+		return errno;
+	return 0;
+}
+
+/* Invokes creat(2) and returns the errno or 0. */
+static int test_creat(struct __test_metadata *const _metadata,
+		      const char *const path, mode_t mode)
+{
+	int fd = creat(path, mode);
+
+	if (fd < 0)
+		return errno;
+	ASSERT_EQ(0, close(fd));
+	return 0;
+}
+
+TEST_F_FORK(layout1, truncate)
+{
+	const char *const file_rwt = file1_s1d1;
+	const char *const file_rw = file2_s1d1;
+	const char *const file_rt = file1_s1d2;
+	const char *const file_t = file2_s1d2;
+	const char *const file_none = file1_s1d3;
+	const char *const dir_t = dir_s2d1;
+	const char *const file_in_dir_t = file1_s2d1;
+	const char *const dir_w = dir_s3d1;
+	const char *const file_in_dir_w = file1_s3d1;
+	const struct rule rules[] = {
+		{
+			.path = file_rwt,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = file_rw,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file_rt,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = file_t,
+			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		// Implicitly: No access rights for file_none.
+		{
+			.path = dir_t,
+			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = dir_w,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{},
+	};
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE |
+			      LANDLOCK_ACCESS_FS_TRUNCATE;
+	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks read, write and truncate rights: truncation works.
+	 *
+	 * Note: Independent of Landlock, ftruncate(2) on read-only
+	 * file descriptors never works.
+	 */
+	EXPECT_EQ(0, test_ftruncate(_metadata, file_rwt, O_WRONLY));
+	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rwt, O_RDONLY));
+	EXPECT_EQ(0, test_truncate(file_rwt));
+	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
+
+	/* Checks read and write rights: no truncate variant works. */
+	EXPECT_EQ(EACCES, test_ftruncate(_metadata, file_rw, O_WRONLY));
+	EXPECT_EQ(EINVAL, test_ftruncate(_metadata, file_rw, O_RDONLY));
+	EXPECT_EQ(EACCES, test_truncate(file_rw));
+	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
+
+	/*
+	 * Checks read and truncate rights: truncation works.
+	 *
+	 * Note: Files opened in O_RDONLY can get truncated as part of
+	 * the same operation.
+	 */
+	EXPECT_EQ(0, test_open(file_rt, O_RDONLY));
+	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY));
+	EXPECT_EQ(0, test_truncate(file_rt));
+
+	/* Checks truncate right: truncate works, but can't open file. */
+	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(0, test_truncate(file_t));
+
+	/* Checks "no rights" case: No form of truncation works. */
+	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_truncate(file_none));
+
+	/* Checks truncate right on directory: truncate works on contained files */
+	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(0, test_truncate(file_in_dir_t));
+
+	/*
+	 * Checks creat in dir_w: This requires the truncate right
+	 * when overwriting an existing file, but does not require it
+	 * when the file is new.
+	 */
+	EXPECT_EQ(EACCES, test_creat(_metadata, file_in_dir_w, 0600));
+
+	ASSERT_EQ(0, unlink(file_in_dir_w));
+	EXPECT_EQ(0, test_creat(_metadata, file_in_dir_w, 0600));
+}
+
+/*
+ * Exercises file truncation when it's not restricted,
+ * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
+ */
+TEST_F_FORK(layout1, truncate_unhandled)
+{
+	const char *const file_r = file1_s1d1;
+	const char *const file_w = file2_s1d1;
+	const char *const file_none = file1_s1d2;
+	const struct rule rules[] = {
+		{
+			.path = file_r,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = file_w,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		// Implicitly: No rights for file_none.
+		{},
+	};
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE;
+	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks read right: truncation should work through truncate and open. */
+	EXPECT_EQ(0, test_truncate(file_r));
+	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
+
+	/* Checks write right: truncation should work through truncate, ftruncate and open. */
+	EXPECT_EQ(0, test_truncate(file_w));
+	EXPECT_EQ(0, test_ftruncate(_metadata, file_w, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
+
+	/* Checks "no rights" case: truncate works but all open attempts fail. */
+	EXPECT_EQ(0, test_truncate(file_none));
+	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.37.1


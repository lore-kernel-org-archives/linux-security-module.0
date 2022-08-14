Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC3C25B06
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Aug 2022 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiHNT0r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHNT0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 15:26:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343915A27
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy5so10394491ejc.3
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6Q2TegWMUY5/S4yJdcvMTnAZgZ5cdtyHsjKA6Bz26CU=;
        b=PJ8e3OooWYW6RyZs1SXc1zg4x8Cof8/G86MFPF2q3kZNpVw2RyFPez+qE/J6cS3nNb
         mNXQkXNqaN7LqEgLig0Y0fiYYW2KovGi12kQp6rOrhA6azVj21PiHQp3I8BWVxCTxPdR
         KY5/QHofKm2s8U++qXZpNfS3KbqFmTYtv/UlOQX5ArKAS/Bbdz6ZKWVE1bhjIyIOOgpc
         0rcyV+sgJM5m7X91yW4pQNnnfWw17mzdaxHnK5E1w8EigRGgHvpstmN8e/HscEfxed3b
         L/VThGpOTPHCCP1ZXqnbH7s8DcrjTM6C9jcd3l6Fs7Ua+vKrKId2yGOw+vrd2lOKFlqB
         r9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6Q2TegWMUY5/S4yJdcvMTnAZgZ5cdtyHsjKA6Bz26CU=;
        b=zJ3k0w73padvtDzHOVa+BMpDaDHSmOmL7SccEaFT12P2J2utrtfA2MT4E5pKWZGVtA
         eDDn/vpfnud3W7Hi0IkMbcXaBndLPrZAmQYSmgkiW1/MjpvRXA+KddXEw02ZQRPxFaqU
         I0vul+BAUzkRlbcQldlDqPQuDm5H2eTgQILBuRek506YyUOSIejAxHKlWCkrkS7RqfsC
         ieC8LRdrobj54ZxKNKtFSVziWQpr4xddSk3lTNXR4+FHQxARfy3ag7qokgkFTIRJh5ZO
         ElK8EPjyrRD54wMpxhS2SMvngsiigLttbnR9/aBSajbCKmFQOWx2d31IhbEFqfsoAwwQ
         +9lg==
X-Gm-Message-State: ACgBeo2yzF15szzvwjPE+fkUCKs3Uyx3qWrGaRxIPZRvafXo/CYzPYFm
        TdDv84OWxICbeEBkqDwR9JaQsKFhIpg=
X-Google-Smtp-Source: AA6agR5lfiblGneLAYP4ZGTeOLoAjesiYGQrGDzktTJluXxB67oPqOBz7xWfpZvoX9QkEZ2gDvDDKw==
X-Received: by 2002:a17:907:929:b0:731:3bb6:d454 with SMTP id au9-20020a170907092900b007313bb6d454mr8305807ejc.96.1660505199876;
        Sun, 14 Aug 2022 12:26:39 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id bq24-20020a170906d0d800b0072b2ef2757csm3209066ejb.180.2022.08.14.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 12:26:39 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v4 2/4] selftests/landlock: Selftests for file truncation support
Date:   Sun, 14 Aug 2022 21:26:01 +0200
Message-Id: <20220814192603.7387-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220814192603.7387-1-gnoack3000@gmail.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
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
 tools/testing/selftests/landlock/fs_test.c | 219 +++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cb77eaa01c91..7a2ce6cd1a5a 100644
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
@@ -3023,6 +3027,221 @@ TEST_F_FORK(layout1, proc_pipe)
 	ASSERT_EQ(0, close(pipe_fds[1]));
 }
 
+/*
+ * Opens the file and invokes ftruncate(2).
+ *
+ * Returns the errno of ftruncate if ftruncate() fails.
+ * Returns EBADFD if open() or close() fail (should not happen).
+ * Returns 0 if ftruncate(), open() and close() were successful.
+ */
+static int test_ftruncate(struct __test_metadata *const _metadata,
+			  const char *const path, int flags)
+{
+	int res, err, fd;
+
+	fd = open(path, flags | O_CLOEXEC);
+	if (fd < 0)
+		return EBADFD;
+
+	res = ftruncate(fd, 10);
+	err = errno;
+
+	if (close(fd) != 0)
+		return EBADFD;
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
+/*
+ * Invokes creat(2) and returns its errno or 0.
+ * Closes the opened file descriptor on success.
+ * Returns EBADFD if close() returns an error (should not happen).
+ */
+static int test_creat(struct __test_metadata *const _metadata,
+		      const char *const path, mode_t mode)
+{
+	int fd = creat(path, mode);
+
+	if (fd < 0)
+		return errno;
+
+	if (close(fd) < 0)
+		return EBADFD;
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
2.37.2


Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAB4C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jul 2022 21:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiGLVOe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiGLVOd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jul 2022 17:14:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15580AF760
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k30so11712377edk.8
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGiu9/7PzN2hwy6DS8nG5hWSQ1nIvFkuZpax1qKhZrE=;
        b=WneeTtB1GnEoo7tJld6bb4QocxKniUMPOOVY+w1UtDhDNhlKTPIazbk3IDP6G+dPE7
         pd8Bo6tJSGHG5sjHltSa96ql4/7XIcSJQIJ7L0yppdnVLs2Mj3AfOBnyjzlbqJWuqLPa
         p62F2vLQLxwY5l7nc/u+s6JSUwJZmx7p7UXn6UFMJ4I22lJMG+vuByAOBaMx6F+hASNm
         SOC8kgdRjmndSG/NTX0gSaWyMAQDG8ZMdB6MnfFF14ngccNG8UqNMYffOecvHDEf2BBq
         7w20yVHdp31PA5EygLkPRWeHPzplzzwCk0sAQ5C+1j4R7ercPLBEcG5GfB0jWKkujsuf
         uoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGiu9/7PzN2hwy6DS8nG5hWSQ1nIvFkuZpax1qKhZrE=;
        b=tHhfTWiAQzbUBMlG1z3AcuGxlHbLS1qE/si3y8ooxGPLO/X0zXs0wpkDQH7rBCl+Yx
         qR4FFRAqjV8rtOwHb+TUGug899TdFCq7kWrdtBuGo2XYGogv28hwbT9Bzh+00R1cBlNG
         SenOPbnfInKTDdCVcPboTBHLelg7yo33OD4k4jjbalu7kdCPtrMUweeJyE9Ql62qZu9I
         r35xKJ6mqMsqll/WxLuWRflANzoWCOOhS4TIiJXhbi7Ev3Sjz3YX6K49C2tT0xJTV/M2
         yqPQkCsYctLDbieIzf333pY8oHOrkwP01VUH746SKP8s8noHkzNM48Tv2fom9EEnl3wD
         OQpg==
X-Gm-Message-State: AJIora+R5Fgr8mjS5LUgpCAQePHaOjk1GVIs+HUgZBcQYc0CtsRCBVTM
        kUlLmgCTfHGNOP+W2CVlcL6wRu3CNaw=
X-Google-Smtp-Source: AGRyM1t8NFYu9y2RB3JMHb4SdOyLnXe68X2ZQtg0QWiDTIcjj2JL8obQM76CjuabENKToUzau4sMJg==
X-Received: by 2002:a05:6402:c44:b0:431:52cc:f933 with SMTP id cs4-20020a0564020c4400b0043152ccf933mr87742edb.41.1657660470582;
        Tue, 12 Jul 2022 14:14:30 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e41-20020a056402332900b0042de3d661d2sm6679296eda.1.2022.07.12.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:14:30 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 2/4] selftests/landlock: Selftests for file truncation support
Date:   Tue, 12 Jul 2022 23:14:03 +0200
Message-Id: <20220712211405.14705-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712211405.14705-1-gnoack3000@gmail.com>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These tests exercise the following truncation operations:

* truncate() and trunate64() (truncate by path)
* ftruncate() and ftruncate64() (truncate by file descriptor)
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
Link: https://lore.kernel.org/all/20220707200612.132705-3-gnoack3000@gmail.com/
---
 tools/testing/selftests/landlock/fs_test.c | 238 +++++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cb77eaa01c91..1e5660118bce 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3023,6 +3023,244 @@ TEST_F_FORK(layout1, proc_pipe)
 	ASSERT_EQ(0, close(pipe_fds[1]));
 }
 
+TEST_F_FORK(layout1, truncate)
+{
+	const char *file_rwt = file1_s1d1;
+	const char *file_rw = file2_s1d1;
+	const char *file_rt = file1_s1d2;
+	const char *file_t = file2_s1d2;
+	const char *file_none = file1_s1d3;
+	const char *dir_t = dir_s2d1;
+	const char *file_in_dir_t = file1_s2d1;
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
+		{},
+	};
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE |
+			      LANDLOCK_ACCESS_FS_TRUNCATE;
+	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
+	struct stat statbuf;
+	int reg_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks read, write and truncate rights: truncate and ftruncate work. */
+	reg_fd = open(file_rwt, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	EXPECT_EQ(0, ftruncate(reg_fd, 10));
+	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
+	ASSERT_EQ(0, close(reg_fd));
+
+	EXPECT_EQ(0, truncate(file_rwt, 10));
+	EXPECT_EQ(0, truncate64(file_rwt, 20));
+
+	reg_fd = open(file_rwt, O_WRONLY | O_TRUNC | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, close(reg_fd));
+
+	reg_fd = open(file_rwt, O_RDONLY | O_TRUNC | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, close(reg_fd));
+
+	/* Checks read and write rights: no truncate variant works. */
+	reg_fd = open(file_rw, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	EXPECT_EQ(-1, ftruncate(reg_fd, 10));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, ftruncate64(reg_fd, 20));
+	EXPECT_EQ(EACCES, errno);
+	ASSERT_EQ(0, close(reg_fd));
+
+	EXPECT_EQ(-1, truncate(file_rw, 10));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, truncate64(file_rw, 20));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, open(file_rw, O_WRONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, open(file_rw, O_RDONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Checks read and truncate right: truncate works, also with open(2). */
+	EXPECT_EQ(-1, open(file_rt, O_WRONLY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, truncate(file_rt, 10));
+	EXPECT_EQ(0, truncate64(file_rt, 20));
+
+	reg_fd = open(file_rt, O_RDONLY | O_TRUNC | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, fstat(reg_fd, &statbuf));
+	EXPECT_EQ(0, statbuf.st_size);
+	ASSERT_EQ(0, close(reg_fd));
+
+	/* Checks truncate right: truncate works, but can't open file. */
+	EXPECT_EQ(-1, open(file_t, O_WRONLY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, truncate(file_t, 10));
+	EXPECT_EQ(0, truncate64(file_t, 20));
+
+	EXPECT_EQ(-1, open(file_t, O_RDONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Checks "no rights" case: No form of truncation works. */
+	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, truncate(file_none, 10));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, truncate64(file_none, 20));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, open(file_none, O_RDONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Checks truncate right on directory:  */
+	EXPECT_EQ(-1, open(file_in_dir_t, O_WRONLY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, truncate(file_in_dir_t, 10));
+	EXPECT_EQ(0, truncate64(file_in_dir_t, 20));
+
+	EXPECT_EQ(-1, open(file_in_dir_t, O_RDONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+}
+
+/*
+ * Exercises file truncation when it's not restricted,
+ * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
+ */
+TEST_F_FORK(layout1, truncate_unhandled)
+{
+	const char *file_r = file1_s1d1;
+	const char *file_w = file2_s1d1;
+	const char *file_none = file1_s1d2;
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
+	int reg_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks read right: truncation should work through truncate and open. */
+	EXPECT_EQ(0, truncate(file_r, 10));
+	EXPECT_EQ(0, truncate64(file_r, 20));
+
+	reg_fd = open(file_r, O_RDONLY | O_TRUNC | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, close(reg_fd));
+
+	EXPECT_EQ(-1, open(file_r, O_WRONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Checks write right: truncation should work through truncate, ftruncate and open. */
+	EXPECT_EQ(0, truncate(file_w, 10));
+	EXPECT_EQ(0, truncate64(file_w, 20));
+
+	EXPECT_EQ(-1, open(file_w, O_RDONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	reg_fd = open(file_w, O_WRONLY | O_TRUNC | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, close(reg_fd));
+
+	reg_fd = open(file_w, O_WRONLY);
+	ASSERT_LE(0, reg_fd);
+	EXPECT_EQ(0, ftruncate(reg_fd, 10));
+	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
+	ASSERT_EQ(0, close(reg_fd));
+
+	/* Checks "no rights" case: truncate works but all open attempts fail. */
+	EXPECT_EQ(0, truncate(file_none, 10));
+	EXPECT_EQ(0, truncate64(file_none, 20));
+
+	EXPECT_EQ(-1, open(file_none, O_RDONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_TRUNC | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, open(file_none, O_WRONLY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+}
+
+/* Exercises creat(), which is equivalent to an open with O_CREAT|O_WRONLY|O_TRUNC. */
+TEST_F_FORK(layout1, truncate_creat)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	const __u64 handled = LANDLOCK_ACCESS_FS_WRITE_FILE |
+			      LANDLOCK_ACCESS_FS_TRUNCATE;
+	const int ruleset_fd = create_ruleset(_metadata, handled, rules);
+	int reg_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks creating a new file: This should work even without the truncate right. */
+	ASSERT_EQ(0, unlink(file1_s1d1));
+
+	reg_fd = creat(file1_s1d1, 0600);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, close(reg_fd));
+
+	/*
+	 * Checks creating a file over an existing one:
+	 * This should fail. It would truncate the file, and we don't have that right.
+	 */
+	EXPECT_EQ(-1, creat(file2_s1d1, 0600));
+	EXPECT_EQ(EACCES, errno);
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.37.0


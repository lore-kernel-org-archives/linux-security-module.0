Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE0C433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 20:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiGGUHW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiGGUHS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434E5C97A
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 13:07:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so24483785edb.9
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFEiXmlmmakvJoKKqKPuYTzu0f95IywK8wLMlckOUZ0=;
        b=gqUYmvaJrb4vM6sk+/P3kr0D3bZfrLZoU3z0g+Io7zpSPnIv5qdpF4lp8hjTkuEdaH
         p6EnJZ4dDi2IHwjpsysXdJGVTGfqWnBj5jwWbGCl/PE6m5K/r+C09cNUMyctVBULAgFx
         YImop4s1yMJ2tBXJelsZQ/v0h2YeUxkYqt9NDSunb6zFCesA3snU+yMXHA/ewp7RN1HK
         NVPpinsZ3QO8jW5DfdLHMtYyXdBWk1elcOx+jFsjHSCmcS1NB+J0x1JlaRkKb35WP3xX
         HzO3Igh7lgmVxzoDkeK2kJx+Y1DcZoW4fWd8ZO/VHctEOI79NJBlgCFp3wFJfnWOIpD+
         BTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFEiXmlmmakvJoKKqKPuYTzu0f95IywK8wLMlckOUZ0=;
        b=UF4xnm2p/fBow2F4fqqky8saba8SMYg9rDb7S1118phdukK1t6iyHEAbI/tQz1thJl
         nRlQ8lmCLJIkz5iKEn0NSTU6597Keiu+7pG857q4L/ufbURdcRES2BePfalYrisXnrtj
         rA8wPP9Fa85PpPYYEIEYAuMcSIZzndxeZ3fsnDlvSdOM8x7pEvlEWTJVkrijZ52xol4C
         zBo07R3ZNlN/T8hh9t8m9oRawciPAuoRzbgmFeyU04lbHYHBYoPbaIzNltb0stRbb0+F
         +iv55kxuqh7w3aklmjwK/zTtsP0vkKHpU8WEOxL17UJuhj0KOroyxK2Cq9Ym7w78Wshl
         9Iaw==
X-Gm-Message-State: AJIora9cxJHITJ6tU+brhc1zUypY7B5izcofFZ9hPBLd+htlycOBUyaX
        Q7RDWDUpAj5BH+YGrwSM81Q942WEY2U=
X-Google-Smtp-Source: AGRyM1vHo/pm/dw2+qo1nwbQO0dka70NODfZG9j3iExRAwLn4Zd68k5QDF6FE+Lo2Rl0ByWhDFyDyw==
X-Received: by 2002:a05:6402:150d:b0:43a:2cac:ca24 with SMTP id f13-20020a056402150d00b0043a2cacca24mr34759177edw.110.1657224436068;
        Thu, 07 Jul 2022 13:07:16 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402020d00b0043a71775903sm8397959edv.39.2022.07.07.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:15 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 2/2] landlock: Selftests for truncate(2) support.
Date:   Thu,  7 Jul 2022 22:06:13 +0200
Message-Id: <20220707200612.132705-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220707200612.132705-1-gnoack3000@gmail.com>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These tests exercise the following scenarios:

* File with Read, Write, Truncate rights.
* File with Read, Write rights.
* File with Truncate rights.
* File with no rights.
* Directory with Truncate rights.

For each of the scenarios, both truncate() and the open() +
ftruncate() syscalls get exercised and their results checked.

In particular, the test demonstrates that opening a file for writing
is not enough to call truncate().

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cb77eaa01c91..c3e48fd12b2b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2237,6 +2237,86 @@ TEST_F_FORK(layout1, reparent_rename)
 	ASSERT_EQ(EXDEV, errno);
 }
 
+TEST_F_FORK(layout1, truncate)
+{
+	const struct rule rules[] = {
+		{
+			.path = file1_s1d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = file2_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file1_s1d2,
+			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = dir_s2d3,
+			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		// Implicitly: No access rights for file2_s1d1.
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, rules);
+	int reg_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Read, write and truncate permissions => truncate and ftruncate work. */
+	reg_fd = open(file1_s1d1, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	EXPECT_EQ(0, ftruncate(reg_fd, 10));
+	EXPECT_EQ(0, ftruncate64(reg_fd, 20));
+	ASSERT_EQ(0, close(reg_fd));
+
+	EXPECT_EQ(0, truncate(file1_s1d1, 10));
+	EXPECT_EQ(0, truncate64(file1_s1d1, 20));
+
+	/* Just read and write permissions => no truncate variant works. */
+	reg_fd = open(file2_s1d2, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	EXPECT_EQ(-1, ftruncate(reg_fd, 10));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, ftruncate64(reg_fd, 20));
+	EXPECT_EQ(EACCES, errno);
+	ASSERT_EQ(0, close(reg_fd));
+
+	EXPECT_EQ(-1, truncate(file2_s1d2, 10));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, truncate64(file2_s1d2, 20));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Just truncate permissions => truncate(64) works, but can't open file. */
+	ASSERT_EQ(-1, open(file1_s1d2, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, truncate(file1_s1d2, 10));
+	EXPECT_EQ(0, truncate64(file1_s1d2, 20));
+
+	/* Just truncate permission on directory => truncate(64) works, but can't open file. */
+	ASSERT_EQ(-1, open(file1_s2d3, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, truncate(file1_s2d3, 10));
+	EXPECT_EQ(0, truncate64(file1_s2d3, 20));
+
+	/* No permissions => Neither truncate nor ftruncate work. */
+	ASSERT_EQ(-1, open(file2_s1d1, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(-1, truncate(file2_s1d1, 10));
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(-1, truncate64(file2_s1d1, 20));
+	EXPECT_EQ(EACCES, errno);
+}
+
 static void
 reparent_exdev_layers_enforce1(struct __test_metadata *const _metadata)
 {
-- 
2.37.0


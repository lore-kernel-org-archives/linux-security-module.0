Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E918C67871
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Jan 2023 05:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAMFdn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 00:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjAMFcs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 00:32:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04BE6130D
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:32:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z4-20020a17090a170400b00226d331390cso23326610pjd.5
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 21:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DqhRtyB6skGEU45HUUKK5pgAZIImcgb5A+bxcz2gbg=;
        b=OmvxjXZ2MEBdoDpJ1qRvgXp0B0Ybu4CbqM4YPpMQeORhHi2ruDUFDw81KYM1l/AtIm
         b25uTAATlybaRj7H9+gSzy6guUEJ0XKrYCgR2gOVS75ht8ccNv2Fn/tNl93W3lPJGbP5
         qV32Pj3cLJoP2k6eGgA8nvigTGDW+o2DgJ4Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DqhRtyB6skGEU45HUUKK5pgAZIImcgb5A+bxcz2gbg=;
        b=SY+b4KIhOkW52AiwnsETUlgTSihCe3Kr9uKLFE7tFTWyPPg3SWOxq3z9rihrdov1i7
         hkEvz/bo6R2nsoV5uJFvw4ZvcM8qzKF3Z1KP0pnZZqkxZMM2OdbEw5x1pJsyOOl2OO7N
         kfssPfQR/Pib26pTwyrGAx7K54WZp8Gm2JOZ122CgSWZVlG9c9TZYtAEdl8tGTs1JeEh
         V/JHsJG3bnPtJdeEoLIacjKjPwAMQMxmQJ5kMLz75IgVFuToaMjyvIoONJtjDc9UXr8j
         JUAE44Se/ShuZNHZ3ijYktgkfvGF4XoIT35c+DFxcgW1jgvoq+pN3ycpEDw+Oh8y6di8
         veWg==
X-Gm-Message-State: AFqh2koyyKPVJeaMpTcZApyQGNTrhxOBOK2GvwWyb253lAw3JlxCMr1y
        ZzyHo+ma/HHq2a9Mj/hFdf83SQ==
X-Google-Smtp-Source: AMrXdXsMgbHo1FKyuoFcVkL6wZHMdcoEJVglsU+sbzrhPg99oWEpOI/3ZgfcAw4s39pvikkxvi8Pqw==
X-Received: by 2002:a17:903:555:b0:194:6110:9fe1 with SMTP id jo21-20020a170903055500b0019461109fe1mr3988432plb.4.1673587957528;
        Thu, 12 Jan 2023 21:32:37 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001945339354asm3450097plf.197.2023.01.12.21.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 21:32:36 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v8 1/1] selftests/landlock: skip overlayfs test when not support
Date:   Fri, 13 Jan 2023 05:32:29 +0000
Message-Id: <20230113053229.1281774-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230113053229.1281774-1-jeffxu@google.com>
References: <20230113053229.1281774-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Overlayfs can be disabled in kernel config, causing related tests to
fail. Add check for overlayfs’s supportability at runtime,
so we can call SKIP() when needed.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
 tools/testing/selftests/landlock/fs_test.c | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..b5bd5134c486 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <sched.h>
+#include <stdio.h>
 #include <string.h>
 #include <sys/capability.h>
 #include <sys/mount.h>
@@ -87,6 +88,41 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
  *         └── s3d3
  */
 
+static bool fgrep(FILE *inf, const char *str)
+{
+	char line[32];
+	int slen = strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, sizeof(line), inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool supports_overlayfs(void)
+{
+	bool res;
+	FILE *inf = fopen("/proc/filesystems", "r");
+
+	/*
+	 * If fopen failed, return supported.
+	 * This help detect missing file (shall not happen).
+	 */
+	if (!inf)
+		return true;
+
+	res = fgrep(inf, "nodev\toverlay\n");
+	fclose(inf);
+
+	return res;
+}
+
 static void mkdir_parents(struct __test_metadata *const _metadata,
 			  const char *const path)
 {
@@ -3404,6 +3440,9 @@ FIXTURE(layout2_overlay) {};
 
 FIXTURE_SETUP(layout2_overlay)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	prepare_layout(_metadata);
 
 	create_directory(_metadata, LOWER_BASE);
@@ -3440,6 +3479,9 @@ FIXTURE_SETUP(layout2_overlay)
 
 FIXTURE_TEARDOWN(layout2_overlay)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	EXPECT_EQ(0, remove_path(lower_do1_fl3));
 	EXPECT_EQ(0, remove_path(lower_dl1_fl2));
 	EXPECT_EQ(0, remove_path(lower_fl1));
@@ -3471,6 +3513,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
 
 TEST_F_FORK(layout2_overlay, no_restriction)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
@@ -3634,6 +3679,9 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	size_t i;
 	const char *path_entry;
 
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	/* Sets rules on base directories (i.e. outside overlay scope). */
 	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
 	ASSERT_LE(0, ruleset_fd);
-- 
2.39.0.314.g84b9a713c41-goog


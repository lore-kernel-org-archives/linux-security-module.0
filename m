Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39725C3DA79
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiL2UM1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiL2UM0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 15:12:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796E13D74
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:12:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so19909567pls.6
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9A7qKrqyBCgMr+32OKT2K30EofYl9j1pUVOj7Tz6xY=;
        b=UjlILiNlGYoASQMYKXDslSOxSItdnHODo7VenaEmcJ2shVzT2qHpVcvgZn9CGWID8S
         Ux8psKu3THtEY1GRIarONxzdo7cj3/E5mmPjx+hrdEpxyQTO5iq150VcSGj1V6b306+W
         CPRdXz5LGEuG9skRyJxV2+RTlB3NZ8tLyL1OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9A7qKrqyBCgMr+32OKT2K30EofYl9j1pUVOj7Tz6xY=;
        b=wxuHEqsNNxIc6zinFnbm8q6Z2sKnqTt89XSXDdaDiwXv0VdCSiPY2uH1p+gpv9PhfA
         GQ2NNEecqll1UbGGUp1QPpA88xxS6GoMGyoqB37z5Qnwc9M7Rnd7POOvpPt4bXp2aH3e
         h9JahCopD4kr77n5jXNn9dqBwHqW6moop7CZU1ednSzLnCEoGzskKtvq0oSdsFk5OnxT
         ySnn0v7f4ZyA3q2cqpTefDkZOMg6C1UK9t/pGnOHorNAKwiu6EzmkXxbPQGKDUQtiYag
         +kHu1eSlfgAWDMKDM8Xlo+AC2Tesu2zGelq+dEkezQTIIZvosd5xZyFNlfC4DKv/lZr6
         6Blg==
X-Gm-Message-State: AFqh2koss8ba8F+Ywe2VicQxgjITxrb3HpRhpwW5/vN+Qd/EHJf+1xLX
        yUI1RCR2eXY38gp0EH6I3tqsVA==
X-Google-Smtp-Source: AMrXdXv3yv8uukYk4ftWSDKGYo/UpTJuo+2Go7ExjLcmvchlcjIPKaUEptF2+ajFTDGK2N+5wKo+DQ==
X-Received: by 2002:a17:902:db05:b0:192:7c38:4842 with SMTP id m5-20020a170902db0500b001927c384842mr22966361plx.53.1672344745010;
        Thu, 29 Dec 2022 12:12:25 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b00177fb862a87sm13395570plb.20.2022.12.29.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:12:24 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v6 1/1] selftests/landlock: skip overlayfs test when kernel not support it
Date:   Thu, 29 Dec 2022 20:12:15 +0000
Message-Id: <20221229201215.3006512-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229201215.3006512-1-jeffxu@google.com>
References: <20221229201215.3006512-1-jeffxu@google.com>
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
---
 tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..2d84c055f86f 100644
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
@@ -62,6 +63,7 @@ static const char dir_s3d1[] = TMP_DIR "/s3d1";
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
 
+static const char proc_filesystems[] = "/proc/filesystems";
 /*
  * layout1 hierarchy:
  *
@@ -169,6 +171,48 @@ static int remove_path(const char *const path)
 	return err;
 }
 
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
+	char *res;
+	bool ret = false;
+	FILE *inf = fopen(proc_filesystems, "r");
+
+	/*
+	 * If fopen failed, return supported.
+	 * This help detect missing file (shall not
+	 * happen).
+	 */
+	if (!inf)
+		return true;
+
+	ret = fgrep(inf, "nodev\toverlay\n");
+
+	if (res)
+		free(res);
+
+	fclose(inf);
+
+	return ret;
+}
+
+
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
 	disable_caps(_metadata);
@@ -3404,6 +3448,9 @@ FIXTURE(layout2_overlay) {};
 
 FIXTURE_SETUP(layout2_overlay)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	prepare_layout(_metadata);
 
 	create_directory(_metadata, LOWER_BASE);
@@ -3440,6 +3487,9 @@ FIXTURE_SETUP(layout2_overlay)
 
 FIXTURE_TEARDOWN(layout2_overlay)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	EXPECT_EQ(0, remove_path(lower_do1_fl3));
 	EXPECT_EQ(0, remove_path(lower_dl1_fl2));
 	EXPECT_EQ(0, remove_path(lower_fl1));
@@ -3471,6 +3521,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
 
 TEST_F_FORK(layout2_overlay, no_restriction)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
@@ -3634,6 +3687,9 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
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


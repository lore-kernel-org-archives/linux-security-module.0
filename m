Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D02C3DA79
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 21:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiL2VCp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiL2VCm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 16:02:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256413F9B
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:02:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g16so10357840plq.12
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/mrA+bFtWISIHBTiBPuE0q3jGPPB4VhPCJ/npAZN0Q=;
        b=Thc4D3r8quhZ610ItEcsbUvC9xRl66Z8vSH2G0yYEtsBBA724cCtPgWYGUWDNm2PTT
         xYZaDjAwdBhD7RTh2gwZaSL2FmTujiblt2RLM6v9hrVmKBg6Tg/lYAVSOQge7oJ6Xnm1
         FTaVUhmBsnfgz2nK/wdws0Nto6ekkVtHd5mto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/mrA+bFtWISIHBTiBPuE0q3jGPPB4VhPCJ/npAZN0Q=;
        b=I+KRiZot3c0Aka80rwQn+xdar9rmsVy2MhjH6LPSgz1dePImGwv2JY7EN32STU38sZ
         kJvaPqDGjFhQkgY7jZh2y99bibcgPXdurUpwJYd3XAe4RxAMc/NIOdZPvPObM35BW9E2
         VzNUOMHmF2+dkbz+Jt8EQYgw2dxOKvwiFxU5JLEKwdVGOd2MRcpzVB5glpeoAEcDIJ3B
         OxUGGAbH6Kxu7euQcdwRuLEGei2fJIhbvv8T+TFDgnL0uswMzH0Rhilf8I9HL3+7k10D
         F3bvp0Y+D7wwrr7BwOEcFTyxGaZ9gDMAIua9yiRJGEtBs3pCvaVhLa2m1OMnciyQEeqj
         nO/Q==
X-Gm-Message-State: AFqh2kr/x3Z2rCR2ftIQWSEprKbdFfBMefb7rivxHA2DDgnx3ETGdv+9
        aW0iJO02zJHcA6tiI6Xd9nuacA==
X-Google-Smtp-Source: AMrXdXtEGn/SdiGUX1OcZdIpCuIgxGKi7CxevAx4JUrfXs8dQpzu8NPQ5uW4Nl7UOaGe9IhVypk0pw==
X-Received: by 2002:a17:902:e84d:b0:192:8824:e516 with SMTP id t13-20020a170902e84d00b001928824e516mr15896501plg.51.1672347761519;
        Thu, 29 Dec 2022 13:02:41 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001897de9bae3sm13458444plk.204.2022.12.29.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 13:02:40 -0800 (PST)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Subject: [PATCH v7 1/1] selftests/landlock: skip overlayfs test when kernel not support it
Date:   Thu, 29 Dec 2022 21:02:36 +0000
Message-Id: <20221229210236.3151723-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229210236.3151723-1-jeffxu@google.com>
References: <20221229210236.3151723-1-jeffxu@google.com>
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
 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..34095fe2419b 100644
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
@@ -169,6 +171,43 @@ static int remove_path(const char *const path)
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
+	bool res;
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
+	res = fgrep(inf, "nodev\toverlay\n");
+	fclose(inf);
+
+	return res;
+}
+
+
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
 	disable_caps(_metadata);
@@ -3404,6 +3443,9 @@ FIXTURE(layout2_overlay) {};
 
 FIXTURE_SETUP(layout2_overlay)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	prepare_layout(_metadata);
 
 	create_directory(_metadata, LOWER_BASE);
@@ -3440,6 +3482,9 @@ FIXTURE_SETUP(layout2_overlay)
 
 FIXTURE_TEARDOWN(layout2_overlay)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	EXPECT_EQ(0, remove_path(lower_do1_fl3));
 	EXPECT_EQ(0, remove_path(lower_dl1_fl2));
 	EXPECT_EQ(0, remove_path(lower_fl1));
@@ -3471,6 +3516,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
 
 TEST_F_FORK(layout2_overlay, no_restriction)
 {
+	if (!supports_overlayfs())
+		SKIP(return, "overlayfs is not supported");
+
 	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
@@ -3634,6 +3682,9 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
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


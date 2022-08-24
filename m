Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E89C32793
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Aug 2022 01:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiHXB7A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Aug 2022 21:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHXB67 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Aug 2022 21:58:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6381A86B40
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 18:58:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m2so14420416pls.4
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 18:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QQNt55krGUA5QP3qnO/4grWvtJbQigUAqQaAdXTVcc4=;
        b=LFEr3MbDMkRu9q32X6KnvGbP2rWOD8ryK4tk6iu3ozg9rx41U+sERyv9R8RUTHljQn
         ds+AaG+pHLu+F92NfafU5VZNVM4sSOmw4KG4mIKNHQ47VsIhap4afuxJp3zNITx6xBhu
         3Q6+pkoYmGErM6Lb2zTsX6JH+zmMgDlM0DQec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QQNt55krGUA5QP3qnO/4grWvtJbQigUAqQaAdXTVcc4=;
        b=aNagMJIoHhUpJEm6l0fS/AfdbzzdTiaQ2wioWblWF7mA+D37KBzg+XzofPDqlywhEV
         xqiN+5t99g9BIOsCGVpcErjYCfxoLXm1BMCPTdkJOdJtSKxoYYGEQcKkZImuu4vEdXhQ
         OYIDArZlvQaeP2SV7mht2Jf7ucx37P1xSkNJi7TqNgnZb9dnPKiFNf0+GoL6QwuYFGkK
         cwWaBdTCU6FtIEoXy+u85G4/kRTEkFuoe5R0Z/8owu7y47Ofsroq1MHx+XNuzLr7LKoZ
         KQoNLueFkOwOpkTg6aaMmedG1lHVlk6LTP4/jm4ypLgs3rZoxVnsGDy/b953SHT5tCGW
         oJIg==
X-Gm-Message-State: ACgBeo3sj90LwdTiOLDlruxqzTbgYxfENWXJCFUKHcPAQgXqUoOuAduv
        Chl+Ek/qztLvf0JotwwfLNVnlA==
X-Google-Smtp-Source: AA6agR5ng8c+dCuM1mpmESxtCR2ZhFJeiFXlQYQv3164PQNJiiSaiJZ0vV4kNdNOsr1VbNWLLZ2/Qw==
X-Received: by 2002:a17:90a:3c89:b0:1fa:acc2:bafe with SMTP id g9-20020a17090a3c8900b001faacc2bafemr5988345pjc.84.1661306336934;
        Tue, 23 Aug 2022 18:58:56 -0700 (PDT)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id g2-20020a632002000000b0042988a04bfdsm9932564pgg.9.2022.08.23.18.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:58:56 -0700 (PDT)
From:   jeffxu@chromium.org
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v5] selftests/landlock: Skip overlayfs tests not supported
Date:   Wed, 24 Aug 2022 01:58:52 +0000
Message-Id: <20220824015852.32257-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@chromium.org>

overlayfs can be disabled in the kernel configuration (which is the case
for chromeOS), causing related tests to fail.  Skip such tests when an
overlayfs mount operation failed because the running kernel doesn't
support this file system.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
 tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..645304d9fe98 100644
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
@@ -169,6 +170,42 @@ static int remove_path(const char *const path)
 	return err;
 }
 
+static bool fgrep(FILE *file, const char *str)
+{
+	char line[32];
+	int str_len = strlen(str);
+
+	while (!feof(file)) {
+		if (!fgets(line, sizeof(line), file))
+			break;
+		if (strncmp(line, str, str_len))
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
+	bool ret;
+	FILE *file = fopen("/proc/filesystems", "r");
+
+	/*
+	 * A failed attempt to open /proc/filesystems
+	 * implies that the file system is supported (default
+	 * behavior). This can help detect such unattended issue
+	 * (which should not happen)."
+	 */
+	if (!file)
+		return true;
+
+	ret = fgrep(file, "nodev\toverlay\n");
+	fclose(file);
+	return ret;
+}
+
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
 	disable_caps(_metadata);
@@ -3404,6 +3441,8 @@ FIXTURE(layout2_overlay) {};
 
 FIXTURE_SETUP(layout2_overlay)
 {
+	int ret, err;
+
 	prepare_layout(_metadata);
 
 	create_directory(_metadata, LOWER_BASE);
@@ -3431,11 +3470,20 @@ FIXTURE_SETUP(layout2_overlay)
 	create_directory(_metadata, MERGE_DATA);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_cap(_metadata, CAP_DAC_OVERRIDE);
-	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
-			   "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
-			   ",workdir=" UPPER_WORK));
+
+	ret = mount("overlay", MERGE_DATA, "overlay", 0,
+		   "lowerdir=" LOWER_DATA ",upperdir=" UPPER_DATA
+		   ",workdir=" UPPER_WORK);
+	err = errno;
 	clear_cap(_metadata, CAP_DAC_OVERRIDE);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	if (ret == -1) {
+		ASSERT_EQ(ENODEV, err);
+		ASSERT_FALSE(supports_overlayfs());
+		SKIP(return, "overlayfs is not supported");
+	}
+	ASSERT_EQ(0, ret);
 }
 
 FIXTURE_TEARDOWN(layout2_overlay)

base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
-- 
2.37.1.595.g718a3a8f04-goog


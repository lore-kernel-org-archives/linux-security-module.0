Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F535C28D13
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Aug 2022 01:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbiHWBCj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiHWBCg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 21:02:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585D57279
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 18:02:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-333f0d49585so212233947b3.9
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=Xs3bXQtTz2trm4xZb9ByuU+B5DQkHrgL3veNrfpYcZk=;
        b=cxtc6jJIQe9E2+goyy6zwKPZ7IkjjS2YW+zzVbJT5MS0LKeuHrQCCEjcsGVgj+E9Wy
         IcgmSiXaFvZlTIouoBM9LlMLdgugQmLanYlXv+ZjalIjNFRFZtbEeJgsm82z8SRFr1ky
         7/uE181Xaj+he+BzwqOOHmUpP4yMWy7oUBEZvSjvilobOlYxNjoAlJrPyhaM/wpQznWf
         p7kzoCxneIXDJLVfF4gs3GFt2+2OonCmwSuJRnodpr5K4UFNJIXrk28BI4DOogEjS2wt
         pTUzaH7/EvVYg9gGcCipWOAZpWfq5WZuJods3oAqHSOxwAtapWJJKwC24JFs1ErDUumw
         RrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=Xs3bXQtTz2trm4xZb9ByuU+B5DQkHrgL3veNrfpYcZk=;
        b=MorF0hWoOYmm6EhFE/e3FQKQCZAtv4QOonDk560XWhsgJfuEmE+LV0ZSX/AKQOuc0H
         8iDf9M8KJTSl7DoHr/P41T+JP4LZyrABWfJtjgTt5l32gb1oKX72EPnHQT6YdjpDWw8U
         dB0b/IR9ZDflz3UnU04tvRX1UCRP+oVqkWh5g81nozJGVd2vryxOe1gEBE6wfEOZ43kv
         qy1PRcHp2gOAPc/qoPrEoys4j7jkDmTP26nrdv7iEq7JM2ECBQpQYzhkCPlg2pFYRKE1
         pUuGuct7zJ4FYjtoG8/98uPM5reXtEiEEUNVXLQf3X3bp5cvQUUn5TJR+q8Yv7/r7xFk
         yjrg==
X-Gm-Message-State: ACgBeo0WSvMDg3NTxKkQymRrtMuHWk2zz0Heq8TPmCVKQrHB/MYZyM7M
        uV29wD4bWe9tGRStj3nhnBIT+yHL2/Q=
X-Google-Smtp-Source: AA6agR6e1molUtWxGuWskN0i70qVdzX/utzVP0TToUfcGXNUz+xubn5nB87XEd4PuE5gedO6bMkZ50bDseA=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a25:450:0:b0:695:8b65:ccd8 with SMTP id
 77-20020a250450000000b006958b65ccd8mr10815919ybe.67.1661216553615; Mon, 22
 Aug 2022 18:02:33 -0700 (PDT)
Date:   Tue, 23 Aug 2022 01:02:16 +0000
Message-Id: <20220823010216.2653012-1-jeffxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v4] selftests/landlock: skip overlayfs test when kernel not
 support it
From:   <jeffxu@google.com>
To:     mic@digikod.net
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        Jeff Xu <jeffxu@google.com>, Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jeff Xu <jeffxu@google.com>

Overlayfs can be disabled in kernel config, causing related tests to fail.
Add check for overlayfs=E2=80=99s supportability at runtime, so we can call=
 SKIP()
when needed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
 tools/testing/selftests/landlock/fs_test.c | 53 ++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 21a2ce8fa739..aaece185579d 100644
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
@@ -62,6 +63,7 @@ static const char dir_s3d1[] =3D TMP_DIR "/s3d1";
 static const char dir_s3d2[] =3D TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] =3D TMP_DIR "/s3d1/s3d2/s3d3";
=20
+static const char proc_filesystems[] =3D "/proc/filesystems";
 /*
  * layout1 hierarchy:
  *
@@ -169,6 +171,42 @@ static int remove_path(const char *const path)
 	return err;
 }
=20
+static bool fgrep(FILE *inf, const char *str)
+{
+	char line[32];
+	int slen =3D strlen(str);
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
+	bool ret =3D false;
+	FILE *inf =3D fopen(proc_filesystems, "r");
+
+	/*
+	 * If fopen fails, return supported.
+	 * This helps to detect missing file (shall not
+	 * happen).
+	 */
+	if (!inf)
+		return true;
+
+	ret =3D fgrep(inf, "nodev\toverlay\n");
+	fclose(inf);
+
+	return ret;
+}
+
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
 	disable_caps(_metadata);
@@ -3404,6 +3442,8 @@ FIXTURE(layout2_overlay) {};
=20
 FIXTURE_SETUP(layout2_overlay)
 {
+	int rc;
+
 	prepare_layout(_metadata);
=20
 	create_directory(_metadata, LOWER_BASE);
@@ -3431,11 +3471,18 @@ FIXTURE_SETUP(layout2_overlay)
 	create_directory(_metadata, MERGE_DATA);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_cap(_metadata, CAP_DAC_OVERRIDE);
-	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
-			   "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
-			   ",workdir=3D" UPPER_WORK));
+
+	rc =3D mount("overlay", MERGE_DATA, "overlay", 0,
+		   "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
+		   ",workdir=3D" UPPER_WORK);
 	clear_cap(_metadata, CAP_DAC_OVERRIDE);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	if (rc < 0) {
+		ASSERT_EQ(ENODEV, errno);
+		ASSERT_FALSE(supports_overlayfs());
+		SKIP(return, "overlayfs is not supported");
+	}
 }
=20
 FIXTURE_TEARDOWN(layout2_overlay)

base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
--=20
2.37.1.595.g718a3a8f04-goog


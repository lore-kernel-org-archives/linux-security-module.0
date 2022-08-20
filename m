Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C561C28D13
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Aug 2022 00:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiHTAp6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiHTApy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Aug 2022 20:45:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E84114188
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 17:45:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33352499223so101227857b3.8
        for <linux-security-module@vger.kernel.org>; Fri, 19 Aug 2022 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=2mkhwDsl7lmPqeHX3h+lzdJ6/MawdoOxYa2Tj7jdEDE=;
        b=jFBbnCEC8r/fPpRyPsIRTgz4o+HMKXtdx4gHU6fpyae4Am7WrrdYcwBpi9odfkN7pe
         dHxZxKEthaTTWT9rC4XUcv5hDDLWc48oueP2rY48OiUS+FceJHOY8puUoZVxu8vsIxPx
         4isfiTNxuIiHABgXX70cdScWN4GTqDV8fEoY9IgmFWGxZLR3DboEq1yQcVYb1cKa3Gpz
         gH3v3jb6NaYc5zdh19Lv261rzOHF/WrDBLVhNIVbfPFiToJB38dt6xDkW1L386JZ5Cxz
         S3ec9Gab/IduTaS346p0aWPc61Io6SPylS5Ozk159fpcAJ74Ashc+NmcLfHg2uYAAIdg
         2TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=2mkhwDsl7lmPqeHX3h+lzdJ6/MawdoOxYa2Tj7jdEDE=;
        b=SygxHUhe6ruPme705XlNVTZIXI1U5FuGuQHvwP/yunVpFLRsSAWjP99/eLjRvLO2a0
         8TCCpqUZo7wkmd61Btemt4DkgswykHybs+5sa+HsJMKCn+GvYQ3h3ayP9X9qnMFn5a8c
         In1UOKKFw95rfa0KXRWEyCwsdtX5PScXWTzGfA8XmY+51zjKT1B+ZwfUCAYkMQhZrgve
         QJ5hETKQnq6jQ63snEktwyWOeE7zglzE9pPmhGtYrmfqAuuQl+B+yUKCkK/7lqKJTIa2
         3iCmOtfd9s1g4zV16X1MwwGc8220gjEDhgXuJwmRUbWQHp6I3pZ3aM8eij43dKHXqnvc
         07LA==
X-Gm-Message-State: ACgBeo2DWqtP+P23n1Zq1uP2m9oCQPQlfAjin2HtZ/we2HY9l1IIIe4A
        Ikck7KKzS/JapUFrozGUO0ETQcej7/A=
X-Google-Smtp-Source: AA6agR6zCQYqji6MRgJvGrM6XjKpIQ8IGSSx97aAVhqSXUvdcGHpv9mcJ5H0DCG+dpzMtsnnnfS5NxxrlTM=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a25:ca83:0:b0:68f:ae73:4bb9 with SMTP id
 a125-20020a25ca83000000b0068fae734bb9mr10520039ybg.650.1660956353258; Fri, 19
 Aug 2022 17:45:53 -0700 (PDT)
Date:   Sat, 20 Aug 2022 00:45:47 +0000
Message-Id: <20220820004547.2135627-1-jeffxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] selftests/landlock: skip overlayfs test when kernel not
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
---
 tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 21a2ce8fa739..f604165dbd21 100644
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
@@ -3398,12 +3399,53 @@ static const char (*merge_sub_files[])[] =3D {
  *         =E2=94=94=E2=94=80=E2=94=80 work
  */
=20
+static char *fgrep(FILE *inf, const char *str)
+{
+	char line[256];
+	int slen =3D strlen(str);
+
+	while (!feof(inf)) {
+		if (!fgets(line, 256, inf))
+			break;
+		if (strncmp(line, str, slen))
+			continue;
+
+		return strdup(line);
+	}
+
+	return NULL;
+}
+
+static bool check_overlayfs_support(void)
+{
+	FILE *inf =3D fopen("/proc/filesystems", "r");
+	char *res;
+	bool ret =3D false;
+
+	if (!inf)
+		return false;
+
+	res =3D fgrep(inf, "nodev\toverlay\n");
+
+	if (res) {
+		ret =3D true;
+		free(res);
+	}
+
+	fclose(inf);
+
+	return ret;
+}
+
 /* clang-format off */
 FIXTURE(layout2_overlay) {};
 /* clang-format on */
=20
 FIXTURE_SETUP(layout2_overlay)
 {
+	int rc;
+	bool support;
+
 	prepare_layout(_metadata);
=20
 	create_directory(_metadata, LOWER_BASE);
@@ -3431,9 +3473,17 @@ FIXTURE_SETUP(layout2_overlay)
 	create_directory(_metadata, MERGE_DATA);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	set_cap(_metadata, CAP_DAC_OVERRIDE);
-	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
-			   "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
-			   ",workdir=3D" UPPER_WORK));
+
+	rc =3D mount("overlay", MERGE_DATA, "overlay", 0,
+			"lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
+			",workdir=3D" UPPER_WORK);
+	if (rc < 0) {
+		TH_LOG("mount overlay failed: errorno=3D%s", strerror(errno));
+		support =3D check_overlayfs_support();
+		ASSERT_FALSE(support);
+		SKIP(return, "overlayfs is not supported");
+	}
+
 	clear_cap(_metadata, CAP_DAC_OVERRIDE);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
--=20
2.37.1.595.g718a3a8f04-goog


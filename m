Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DFDC32772
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 16:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiHVQZm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiHVQZl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 12:25:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9D40569
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 09:25:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3360c0f0583so194986147b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=R7FOzb9HSCwvIBjVe06qBjW7lIdiLMhhjR4f0/SQR8s=;
        b=L0sy3iBmK/gxhLLhcMmF/atAEauOezlrC9Gmwxqnyyj17m36baneJ4+mymr+dN4Aw0
         eDCjVq6nzdOIdE3jrKf2sixxn63TDtNUlLR+1pGVdtM4tF9UC/Ma8n/SrbJ0/0EuYsUR
         WmxjeT5tKCB6RUDMGdnToAS8N68BbvzNumFpAxnsTpd2DuSaBTHG6Lty+IxUVTVHSLC6
         k1ZrHB8AGE76/ppgvUU2WRWHUTSucwUoBQb8vMR9lTbcJpuIR3LKMwkSpTOZ3nN2FDPR
         fUqhb505nCyPpHyE+ZAdZpip7ObcfxbhB8m/JZ+Cd+vUYyC9st+62ifEg8defZNQTWKm
         3x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=R7FOzb9HSCwvIBjVe06qBjW7lIdiLMhhjR4f0/SQR8s=;
        b=rHrXbQA1jySNdM1zg1rV75M+34rW2QQV1DJVa8tvAovg+V1z4xZeP1SeIpGwPBX4JC
         s+8dlXSLP00n9j6IzkjLX7nPgsVjYBYLjYQNEwXZ95Wm09S9RPB4xX0KtatRz9W2rasD
         sCE2Ncolg5y/cY29WP/ZWiCbKcsaEcOlMLG0PNMEUaOzwVUIf0vVDxykpHFJycpe0qAz
         qr7zy7phnTyHyEQKtqP8uy2xygUrmUB6NunTOcHQBVat2HZx3CuY2wHOB4c/Z4c8keWL
         ++/fGEmahgTCjcycd3ye9juFkt8fcNAgbv3ja/9WFfYGt6MYQZYnSYb/owynd82A3dDt
         ISQA==
X-Gm-Message-State: ACgBeo2My9BbUhyBW0Tptcne5BtzFK4cKtqHgJVhCOwaW+upbpIuej/0
        nJkpSzyyjZbRns9i51tGEdk3fzww+Fw=
X-Google-Smtp-Source: AA6agR66/JnF2co3gW7iwuZJ8rxY8EJ3fpYQ6OX/RSzbhkB9KimYVFHQxrb7IPYiMHOQRI+tydw0yjbEm/g=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a25:4645:0:b0:695:b0c8:2817 with SMTP id
 t66-20020a254645000000b00695b0c82817mr5765669yba.211.1661185539544; Mon, 22
 Aug 2022 09:25:39 -0700 (PDT)
Date:   Mon, 22 Aug 2022 16:25:33 +0000
Message-Id: <20220822162533.2594963-1-jeffxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] selftests/landlock: skip overlayfs test when kernel not
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
Change-Id: Ica94d677d6c11e8f2460e07d1b432be077946324
---
 tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++--
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 21a2ce8fa739..3a4c52619b46 100644
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
@@ -169,6 +171,49 @@ static int remove_path(const char *const path)
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
+	char *res;
+	bool ret =3D false;
+	FILE *inf =3D fopen(proc_filesystems, "r");
+
+	/*
+	 * If fopen failed, return supported.
+	 * This help detect missing file (shall not
+	 * happen).
+	 */
+	if (!inf)
+		return true;
+
+	ret =3D fgrep(inf, "nodev\toverlay\n");
+
+	if (res) {
+		free(res);
+	}
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
@@ -3397,13 +3442,14 @@ static const char (*merge_sub_files[])[] =3D {
  *     =E2=94=94=E2=94=80=E2=94=80 work
  *         =E2=94=94=E2=94=80=E2=94=80 work
  */
-
 /* clang-format off */
 FIXTURE(layout2_overlay) {};
 /* clang-format on */
=20
 FIXTURE_SETUP(layout2_overlay)
 {
+	int rc;
+
 	prepare_layout(_metadata);
=20
 	create_directory(_metadata, LOWER_BASE);
@@ -3431,11 +3477,19 @@ FIXTURE_SETUP(layout2_overlay)
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
+
 }
=20
 FIXTURE_TEARDOWN(layout2_overlay)

base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
--=20
2.37.1.595.g718a3a8f04-goog


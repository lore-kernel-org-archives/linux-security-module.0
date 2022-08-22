Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2299C3F6B0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiHVQxk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiHVQxj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 12:53:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131DE15828
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 09:53:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3360c0f0583so196077457b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc;
        bh=EsXvEEtmBGvWUVVMk/XzFeuStKlZLtGzI+X7ZhlrXt0=;
        b=nclkVuJ+Exh3Ht9g4TPajwFTkPLpIX+r464fK3wCu2MfanF90SE5k9eEMCDhiJWvk3
         QE3QD2MojJTBfiKxoFilRHWOYV/wD4hrxzQ9UhX0pVzAhqyZkKVpIL19X3GiXWdhewRB
         yW1nx9gL+3KB1xNAqPOzl784vdfOZWzHsY3EwG8ZOCP3qLAguwKbYSKX6Uq0kw1y6D8S
         7pVpfpZqp6Zpmqbq0c2kRapdd0KqrEI5xGNEeOVURH0xZA7TjDb8KwLlHEjV80V129FJ
         ZdXWJvD4O/exgRN6g2VuSonjLX8Q4RIqLpE9HDFmctqzsHZFkTGXi4kttx5zbEHEz+Ej
         k/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc;
        bh=EsXvEEtmBGvWUVVMk/XzFeuStKlZLtGzI+X7ZhlrXt0=;
        b=dJnUQMUbf3if8RVBWRDjRmFBK7WG9TawhHsu1QKZkK4RF2Bkg14yi/+f8/AQApIiuL
         trD2+jYTguR/Mt7YA5yUsBHdugaLiqWNa/6qNoNbaX7GJF4X8dwOaIV3SUQupbfHANoQ
         kZSBBvv84uUKovunuCnSX0Mz+GSQKP6crDAHswmMWj5BTkUoFLpIhBKCkzzbHfMuo4fW
         RPYeWATkND7Ss07Vmme4/vjmp8HDcpyvGtjS1c1fcibtsxUvrduEZfFyhQHYtTK8aRTY
         /O5wopljs+IriKP6SycaUYdFVhfjkw2I9DQgTKAjxOx4M/4DUMwo+yZEcCsP2u+yBOHa
         AHag==
X-Gm-Message-State: ACgBeo03bZUAbaXedkOQZPxrhecKLMh+QP4vP5aBRsZ3EFbS+6G3hOug
        HJXwGFj9Ln8pf9WI+FQkp1/7YiuJPl0=
X-Google-Smtp-Source: AA6agR6BevBdA6KkyTmNF5T5mLY1+kK3JZlondFv/LjMANEDLe++G5Ied2nc/bTtHXlgdtgiARkSmyR6QaI=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a05:6902:386:b0:693:e529:c93a with SMTP id
 f6-20020a056902038600b00693e529c93amr19392069ybs.328.1661187217374; Mon, 22
 Aug 2022 09:53:37 -0700 (PDT)
Date:   Mon, 22 Aug 2022 16:53:33 +0000
Message-Id: <20220822165333.2600411-1-jeffxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v3] selftests/landlock: skip overlayfs test when kernel not
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
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 21a2ce8fa739..0c283d50f222 100644
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
@@ -169,6 +171,43 @@ static int remove_path(const char *const path)
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
+
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
 	disable_caps(_metadata);
@@ -3397,13 +3436,14 @@ static const char (*merge_sub_files[])[] =3D {
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
@@ -3431,11 +3471,19 @@ FIXTURE_SETUP(layout2_overlay)
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


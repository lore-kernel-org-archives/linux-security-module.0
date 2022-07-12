Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A5C43334
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jul 2022 21:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiGLVOn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiGLVOm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Jul 2022 17:14:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E88B7D6A
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bp15so6279480ejb.6
        for <linux-security-module@vger.kernel.org>; Tue, 12 Jul 2022 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhEPy/JEKSWa2dBteD25VO5DzVw3Wexe65XRAgAl3Tc=;
        b=YgGOsbw63rLoYcz57bYJOtKTDIwJW8Vrzf5gSVcQ/RJJaxi02JfujqAUpEdPz0p/xq
         RNWuaw6mxwx/eYxnLIvbGV9ZYcCeeFeIFo16Y1OegB8QadxmyWLopR54/TCFW8ANxQiQ
         VMFdDHgf5udd7+cTvUy1VGf5v5O3AqOFRQUv2yULBFZ54wkI9r93cZ594a1rYgeXAfuI
         MsEDbo3Ooe6uh1R55NBQuLCxiZcT5void3UFkiO1kNEMHGPAWdJFDEjpTjZhZjlgzm/h
         G204KJk79OHg3XQJpbLXNr3GRHxbVTkvGzfqHFxAnBwNpHj29zst7tR/7NUaWHQnkyZT
         0Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhEPy/JEKSWa2dBteD25VO5DzVw3Wexe65XRAgAl3Tc=;
        b=ACRE62jugZxItM4OJPRq1UxHZuymHTjXstRgzLRXFUidBMSfPWM2N7MKtWaRVvA6Dl
         U5Fppc4RxVjMVsfPbsxi+sFae7vrhEvhrZ08lZMwKsaCa/xBRRx2CIA0mZ3xcq4Tol0s
         q5MbesNqwwTaaspUXmNH5FNsK866CEYWUdcACN2uZMW0giHr5KhYdVbIsCb4P/LwN10r
         9NKU2crilc558Eb2A7gNLx6o/mcfXz9g6erefLN4PvngrjCCjwjJ+J5gyi1ZAC9gYqzw
         BiEDhlD1QGKNjFxupyJ6rDsRDLvnURUGHk/yL202kX8Aq9bUoykLMhqUqj4IqAq0mKfp
         e3PQ==
X-Gm-Message-State: AJIora8ZrEwfgfdMlLiE2+87RukV2iV0papFPfzFCzpJkorAMONILp86
        syOeVOp9n5DgpE6Nn1gfm69QruscTWg=
X-Google-Smtp-Source: AGRyM1tETnj2kCvnwxchpz+vHLYHux3ygC7nlNjEO2w+DJEFa63MdtPURU/l8k0loNvzw7ytqv8XGQ==
X-Received: by 2002:a17:906:d54f:b0:726:2c7c:c0f9 with SMTP id cr15-20020a170906d54f00b007262c7cc0f9mr45525ejc.441.1657660479395;
        Tue, 12 Jul 2022 14:14:39 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e41-20020a056402332900b0042de3d661d2sm6679296eda.1.2022.07.12.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:14:39 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 3/4] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Tue, 12 Jul 2022 23:14:04 +0200
Message-Id: <20220712211405.14705-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712211405.14705-1-gnoack3000@gmail.com>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The sample tool will restrict the truncate operation if possible with
the current kernel.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
---
 samples/landlock/sandboxer.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 3e404e51ec64..4c3ed0097ffd 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -76,7 +76,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_READ_FILE)
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
 /* clang-format on */
 
@@ -160,11 +161,15 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	LANDLOCK_ACCESS_FS_REFER)
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
 #define ACCESS_ABI_2 ( \
 	LANDLOCK_ACCESS_FS_REFER)
 
+#define ACCESS_ABI_3 ( \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
+
 /* clang-format on */
 
 int main(const int argc, char *const argv[], char *const *const envp)
@@ -226,6 +231,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 	/* Best-effort security. */
+	if (abi < 3) {
+		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_3;
+		access_fs_ro &= ~ACCESS_ABI_3;
+		access_fs_rw &= ~ACCESS_ABI_3;
+	}
+
 	if (abi < 2) {
 		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
 		access_fs_ro &= ~ACCESS_ABI_2;
-- 
2.37.0


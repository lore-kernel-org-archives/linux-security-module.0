Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E2BC19F2A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 19:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiHDTiJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiHDTiG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 15:38:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6496E2D6
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 12:38:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w19so1103429ejc.7
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=liWS+mbzdn/5uZ7TQqXTdXkRPTN/UcHsj0kI7okFJ90=;
        b=L5eTUTFMVy0xWYcAyjoiWAKqzsEWhViL+wVK2I1fv6ilJYeu+0KrOotwTRkvFQ7zJd
         CSQWl3JUTYauGV3y3SJNhTft2Ggvp04dSazXGNW79dgbdrR5CXnuPYf+5tYrWFhsi/9i
         HBa8DIlNGLQZ3IXJA3lTY8RhuLwewHqqQAhmDFsTUpuOutY2XvwofIM3pdY4buI8iyzi
         L8VNiGKyPjrCTyrpRaZmFmHR5mPrfDCJEvYpLk+kmE60dWeliM02MLWr9vlHGC137vwe
         bGmX6zSUXuiPG/fIfG/sU3D6z137lVh0vHLuVmJ5pr4Bkeujt6cBfbvZdKXUmdwOGOXc
         tZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=liWS+mbzdn/5uZ7TQqXTdXkRPTN/UcHsj0kI7okFJ90=;
        b=1Cbo8J/Xt/Gt5/KMd+Th1IaoB2Q16k5W9VmpiZu2CpONDsude6elIlLquIwhkmExlg
         CjYGCxxBwLvf7kb5Zsfrzkm1iU+P+0YhM/2KEKqzQVhaAJhpZXfp/nx/mm2LMKpIHIMK
         VMhLR5rZOl61zWio5FqAhLKr61p6B2Vjbapmnx7s8at8fn1X0G85XVW24/V4vMq1AMcP
         lNfBuxoS0OPMwX9fz/+5lUQ2jQ6dDyo0mC++16/vRGEtyyHpnyRXKbtuXsq5BiEsE8pR
         C3uiUI4VGhp/TLfwkLXLIIRaemaorP+VzfcBAES7q00uJIiaw+MvOv9KV1ODYnOAU+dI
         uwJg==
X-Gm-Message-State: ACgBeo2AeNy46VH0fcVWA7rLk9isCwx/Duwgi4GQdx8Pp8NN94/vxXWb
        LgFjko8NTQdVnyYsOHa4LAVCkxbxhvo=
X-Google-Smtp-Source: AA6agR5hk5JE/qSJpc37HWoGGIm+mZ3Xdw/deieeql79yKwR3BECFzR7bSRKiUGE1zD6K5LzK4s5uA==
X-Received: by 2002:a17:906:847a:b0:730:9a59:3958 with SMTP id hx26-20020a170906847a00b007309a593958mr2505893ejc.62.1659641885072;
        Thu, 04 Aug 2022 12:38:05 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072abb95c9f4sm631851ejh.193.2022.08.04.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:38:04 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3 3/4] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Thu,  4 Aug 2022 21:37:45 +0200
Message-Id: <20220804193746.9161-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804193746.9161-1-gnoack3000@gmail.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Update the sandboxer sample to restrict truncate actions. This is
automatically enabled by default if the running kernel supports
LANDLOCK_ACCESS_FS_TRUNCATE, expect for the paths listed in the
LL_FS_RW environment variable.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 3e404e51ec64..d266f3abbf63 100644
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
 
@@ -160,10 +161,8 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	LANDLOCK_ACCESS_FS_REFER)
-
-#define ACCESS_ABI_2 ( \
-	LANDLOCK_ACCESS_FS_REFER)
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
 /* clang-format on */
 
@@ -226,11 +225,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 	/* Best-effort security. */
-	if (abi < 2) {
-		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
-		access_fs_ro &= ~ACCESS_ABI_2;
-		access_fs_rw &= ~ACCESS_ABI_2;
+	switch (abi) {
+	case 1:
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+		__attribute__((fallthrough));
+	case 2:
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
 	}
+	access_fs_ro &= ruleset_attr.handled_access_fs;
+	access_fs_rw &= ruleset_attr.handled_access_fs;
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-- 
2.37.1


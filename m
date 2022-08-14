Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B9C25B0E
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Aug 2022 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiHNT0s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Aug 2022 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiHNT0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Aug 2022 15:26:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644B15A38
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so10353701ejc.10
        for <linux-security-module@vger.kernel.org>; Sun, 14 Aug 2022 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Rlx98mKeZrGekLkjWi04LgDVSnb7ZLX9tMW7Nnpkucs=;
        b=X/VzpjqASFz1N1CFokqYG4INEMrzvo9358oElTAIs8y87rOC14e+E6rvGlfGetIY1c
         KbLslExYHSGaaWZoJCfF7xJwdnAkdP5cd3Is1NB9P4VpaqrBvCTtSeOgBdbJ29y+ANSv
         lgWEnufyGNuXtT5DXxEULX/BwPNm7B8u4YHULlKlvN4SRTi7PvU0tpno5LG8HomyB2q7
         99yUBBHTSeZt2PMEAoR9pp6YI6AvOcVXLkgKcaNMomJNIuC2ZpVVkQ9hc1PDcEZ8kEXO
         /Yu6zKJd9zFlGdiIt+NDlE2kSdTP7hht/1QibF1ytmQFibObHFl/xgGNr9ZAY6842RWk
         YXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Rlx98mKeZrGekLkjWi04LgDVSnb7ZLX9tMW7Nnpkucs=;
        b=v6LGsDr2r/77zNhNv+GeL579gG4lyU/zPbf03Kznd173AlF6ZD7/U2CN5OFChLEeMD
         dESKOcJW6ovzKiqjMhuNH3BRFl63TlY/Tk14c9m2a+BgYzGoB3U+pa76M/irIhE/9ONI
         o3sboTH+3AZi65qVoQUgGrET+cresDizwJaXA9I2dkbsEDIQ1JTo3o23xhoqOLJTw1Jx
         fSf4fVDmT9yWglUAhq+H/RMTTKk/OvpbQF7pBNMaVc0umG2XnWUigkn3YzRS4g0lX9Ll
         AouWa3UqWqPaVdjEb7m2OMKmrm2oNKHz9qIWYesnpDOkEFv2BmxCPfSD+3PGEEEDji2F
         yJqg==
X-Gm-Message-State: ACgBeo3nfpMqSM+v6zmtMa5BTAhrdvA43S5KlC1NVhVDL86qSc6hVdK1
        P2D5AqxrlW+5W1qTaSzGCcxYjcYBRDE=
X-Google-Smtp-Source: AA6agR5zrCd0L7GIU/wbuEf5DXoVDQ5bSjuVjpHuqKTfAdUFGzxWCouM5SVrMUvFzGtCZ88rkQiO/w==
X-Received: by 2002:a17:907:8a04:b0:730:baa1:ac82 with SMTP id sc4-20020a1709078a0400b00730baa1ac82mr8286671ejc.737.1660505201252;
        Sun, 14 Aug 2022 12:26:41 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id bq24-20020a170906d0d800b0072b2ef2757csm3209066ejb.180.2022.08.14.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 12:26:40 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v4 3/4] samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
Date:   Sun, 14 Aug 2022 21:26:02 +0200
Message-Id: <20220814192603.7387-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220814192603.7387-1-gnoack3000@gmail.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
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
 samples/landlock/sandboxer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 3e404e51ec64..771b6b10d519 100644
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
 
@@ -226,11 +225,17 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 	/* Best-effort security. */
-	if (abi < 2) {
-		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
-		access_fs_ro &= ~ACCESS_ABI_2;
-		access_fs_rw &= ~ACCESS_ABI_2;
+	switch (abi) {
+	case 1:
+		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+		__attribute__((fallthrough));
+	case 2:
+		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
 	}
+	access_fs_ro &= ruleset_attr.handled_access_fs;
+	access_fs_rw &= ruleset_attr.handled_access_fs;
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-- 
2.37.2


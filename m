Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD7C77B73
	for <linux-security-module@archiver.kernel.org>; Tue,  2 May 2023 17:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjEBRS0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 May 2023 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjEBRSP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 May 2023 13:18:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F91724
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 10:18:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so39749975e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 02 May 2023 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683047886; x=1685639886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMuWJnZxC5vpZzYAd2BIYmuop+36mC3iEn3DltRGUwQ=;
        b=SRSA8DKP71LUZKlLhSMcF/ScMdLhiQi5F0ej/pFb5ZkRntHRN29MTRQT6mI7vdFw8r
         YRfLErhr7wXe4S1fObS4ZShuk2KSzfkWTSOK1jOtstNVNgqSUUFFK9DdTww7fpWcYZXN
         ArkV9Xa3kf1hL057PNdsyB+Bwq6DupSv7B1Uwkl8KutzKbfN27gnQsVRNeJw57MrrEfx
         BhTrr/ZZMVUbTd59qF2ZKX6Amfq8rUVB8KQSo2AyFNttOH3w6YiXbotmBltmeZmKDV8M
         8uVRqYTgW386HcEolmI3oMnird/c+oMmPsCGR0W7Hwillh8Ma+4UuqT9v6LclFJxHhWX
         2DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047886; x=1685639886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMuWJnZxC5vpZzYAd2BIYmuop+36mC3iEn3DltRGUwQ=;
        b=DdDGtgS+9m3ZMDvxjDGYSLIJthOAngQGSoGoCdEe0jNMsnZikf9wulkKSC2kul+eHi
         eF+r7z293n2yrXYags8r8f9pk28BdqhqCzrsG6/nAMcEOkU0xQ7hdT3b/3jT4WJBClZl
         TDrpXoGs/Stq9Z46ZNBycPw65oZ5g6klKNj/6tpOCPgG6f14Km6H0wzSGZ0qgg+LhNzY
         SZzGHpM0PKfWBegCnLA9ulloGB6yGUh53hLoQOxTDPC/ROBl3wDxG8jGKomWW4M6ATJt
         AWJHnywo5LpPlc6A7snYqaHw8+ZZl8q/BbHp+FZYnKa0WDtbKQHQxIGrOycZnaA6crD5
         kOkQ==
X-Gm-Message-State: AC+VfDwMZPDOH7v5DNHI3vVOPZ8uvA55rtAGYi17SNPZKgYn5tQCGZYA
        Mda9LlyFiGBGQKQT7I44lYINUi9HWyM=
X-Google-Smtp-Source: ACHHUZ45V4aMKUZOMnAPcebnNo+YtDQXuLL52VN3Fr+xha20BzMNSpBLKt6kDwXOIEuLVrrV80NJ4A==
X-Received: by 2002:a5d:44c8:0:b0:306:2fec:107e with SMTP id z8-20020a5d44c8000000b003062fec107emr3903435wrr.34.1683047886074;
        Tue, 02 May 2023 10:18:06 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d684a000000b003063176ef0dsm4483607wrw.97.2023.05.02.10.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:18:05 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [RFC 4/4] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
Date:   Tue,  2 May 2023 19:17:55 +0200
Message-Id: <20230502171755.9788-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171755.9788-1-gnoack3000@gmail.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e2056c8b902..c70d96d15c7 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -77,7 +77,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 
 /* clang-format on */
 
@@ -162,11 +163,12 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 3
+#define LANDLOCK_ABI_LAST 4
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -255,6 +257,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	case 2:
 		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
+		__attribute__((fallthrough));
+	case 3:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 4 */
+		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL;
 
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
-- 
2.40.1


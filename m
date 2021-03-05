Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD338C433DB
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 03:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9502464FEE
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 03:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCEDZL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 22:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEDZL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 22:25:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B6C061574;
        Thu,  4 Mar 2021 19:25:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id i14so1001450pjz.4;
        Thu, 04 Mar 2021 19:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsELJRNcDtTSsFfuFxiHJtBmBmVHnlXcRIQtbNC8CRQ=;
        b=hJwZBIae6zSKiD4JIIPtqSsaJlPghNkWhA5y+CW5kSbYN7SGoot49nQU45ZyssgybJ
         5k+eNYIfwTAP+icU6rj3t9XCs+kRv1EUHf/SVS4uxQ+jFwqT+aqCBiO5aJM0eu9+yUBN
         i1YM+UYl2PnfJrlIstL+coReHiSyny6zVlR4On8Mg0/X6SJGakTUClkt3MTne3rnzeJy
         BMIvAPpvTTVAxkiE+pC0uCtk8MDpYYuAntq7zqcuv8Hb4bVWEOqd93v+W/FngZ/e0cf0
         6gWv9XZ5KsNtlzjfcOvbpFbwLJkykdbQF8Ci4Lc3owIp7zzPPSQGmg+ybUfyc/H/mOr0
         y3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JsELJRNcDtTSsFfuFxiHJtBmBmVHnlXcRIQtbNC8CRQ=;
        b=eX+EpkqIIcD0AOeTipF9H7l971uyDru1e8YaiEk6O3wCFsX0q677YeF7XQGel2k9BB
         7vqHFHG90yToJ9gbREDI9qE5fWUovn9Hw7uYDMWdJJLt/GuSFDmjLw4q8iQkufyv7xcF
         VmKam+QIOb+TofqikeuEePD7FNvJGLpyxPQ5cJHlQU4voYBagsGXyrq7pnXoupvFW2ym
         oorcdP9R7T4FyLIFOKNRThJTcwePn37/aVcmcqzrAax9vTyJx7IJkRmw235MCDxNQXlg
         BlNKDpE+PUGDY6lVoSGri5XezJ6w/qL54Ff5OuTaHK9aUNGCfQm+UJCTPIO8T9VjuUw3
         OPNQ==
X-Gm-Message-State: AOAM533/iH7oGUspx2Vqz0I9bWfGBGZY6cmoY4oGprI1zpPPrGAtHavT
        XXqcLveOrpl/BWv6ulXgjn8=
X-Google-Smtp-Source: ABdhPJxub6tDTbIx20kB9vYGjQjZsDcc/y6IwqkpiKR3ai0zt205Rmwf8QAYoX8kVJQM5LtkN0ecvw==
X-Received: by 2002:a17:90b:798:: with SMTP id l24mr7625513pjz.63.1614914710762;
        Thu, 04 Mar 2021 19:25:10 -0800 (PST)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id w1sm670629pgs.15.2021.03.04.19.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 19:25:10 -0800 (PST)
From:   Jiele zhao <unclexiaole@gmail.com>
To:     keescook@chromium.org
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiele zhao <unclexiaole@gmail.com>
Subject: [PATCH v3] security/loadpin: Replace "kernel_read_file_str[j]" with function "kernel_read_file_id_str(j)".
Date:   Fri,  5 Mar 2021 03:21:10 +0000
Message-Id: <20210305032110.215024-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Actually Linux kernel already provide function "kernel_read_file_id_str()"
for secure access in "kernel_read_file.h".
And, in "parse_exclude()" function, it's better to use

	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) - 1 !=
		ARRAY_SIZE(ignore_read_file_id));

to make sure the arrays stay within expected sizes.

By the way, sorry for that mistake PATCH v2 file, I sent wrong path... ...

Signed-off-by: Jiele zhao <unclexiaole@gmail.com>
---
 security/loadpin/loadpin.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..1c35164673b4 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -210,9 +210,10 @@ static void __init parse_exclude(void)
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
 		     ARRAY_SIZE(ignore_read_file_id));
-	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
+	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) - 1 !=
 		     ARRAY_SIZE(ignore_read_file_id));
 
+
 	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
 		cur = exclude_read_files[i];
 		if (!cur)
@@ -221,9 +222,9 @@ static void __init parse_exclude(void)
 			continue;
 
 		for (j = 0; j < ARRAY_SIZE(ignore_read_file_id); j++) {
-			if (strcmp(cur, kernel_read_file_str[j]) == 0) {
+			if (strcmp(cur, kernel_read_file_id_str(j)) == 0) {
 				pr_info("excluding: %s\n",
-					kernel_read_file_str[j]);
+					kernel_read_file_id_str(j));
 				ignore_read_file_id[j] = 1;
 				/*
 				 * Can not break, because one read_file_str
-- 
2.25.1


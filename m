Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB953C433E9
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC6F64F0A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 08:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhCDIhR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbhCDIhI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 03:37:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B97C061574;
        Thu,  4 Mar 2021 00:36:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o38so18431245pgm.9;
        Thu, 04 Mar 2021 00:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wN0+yJpnJV0AHl9c2ZtqFOBkFWkFdSUFj1zpgPWViM0=;
        b=lOKRaFHSR1P8N8RKuxk7jWyJbP2uBPysGRaMX1NnlBLE2Liiwojhj2GEHmpJos3QyZ
         kD8KeKXmz1vosiOswOJOmbJZQ4EseiVAmqLq01AEMU1e1hJpAGxs5WMO8LBR/jDybmFL
         de40yfJaMb632r7UFvOpZv/XJ3raT4p8+BoprAp8TzmYPwK6ssWQsOhZe94QqGKL7NGh
         /WPsC1nAUZPNfW/9iz7VOuZyYFyY2F/hKJznQ0qAfx5nmmF4pieZ1H3KMWnVl5JTKJpr
         xIgBXDDnNRu4dpby9+1fLzeSGez2MfvEn3cXY8Kk7tW/4ObNUDfmhLH4XlOM+5DXCkKm
         oaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wN0+yJpnJV0AHl9c2ZtqFOBkFWkFdSUFj1zpgPWViM0=;
        b=M6Qrj97mt3ONVX8R6pBu+ReO/s+e3SncaqY1hIdZRJnS0AqYpwnbMsP1uOyx0v8MU9
         djcct9JbuZTQC2AX0rLmN03vlBhx1+ciHwpjHJ9WAdu/EJP2yIK4jvRXEEeh9qeD/CwP
         Vaaxm+OfY7vdfkGnjPi4hU0CLVtVKzqhQkoVWeFrPJgg46CV8XHC27oBZMS/sw2zZ6AX
         Uj+i4KLpqwzWGqnIuaa8beFIa5Rqx57XZvVm52xJRJdplwxzxo5EPdxbi+KOo5NhuKxP
         l3kN8yAFv2iSYZ/w5XvAiQqkpSdUqZD0GP8D01NPkAnyMsFhos8oLZFL7VZWjWUPxJRA
         KO9A==
X-Gm-Message-State: AOAM533EWYEoYxohpShw8ihTEWioWOo/x5D/bY7TkJOpX+u5IYUaSvtI
        3nVIA+fU57JNV3bO+khzef2KGDWOYLnrsz1u
X-Google-Smtp-Source: ABdhPJy7XBa22ZhDakgenv4u4Th2RP1XVocpdj6b4KaUhdEoe4Ya6AvjhGgpnTcvZZ5HFmXVjutAXg==
X-Received: by 2002:a62:cd:0:b029:1ef:55e:e374 with SMTP id 196-20020a6200cd0000b02901ef055ee374mr2985590pfa.31.1614847013185;
        Thu, 04 Mar 2021 00:36:53 -0800 (PST)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id q2sm26283458pfu.215.2021.03.04.00.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 00:36:52 -0800 (PST)
From:   zhaojiele <unclexiaole@gmail.com>
To:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaojiele <unclexiaole@gmail.com>
Subject: [PATCH] security/loadpin: Replace "kernel_read_file_str[j]" with function                   "kernel_read_file_id_str(j)".
Date:   Thu,  4 Mar 2021 08:36:38 +0000
Message-Id: <20210304083638.174767-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Actually Linux kernel already provide function "kernel_read_file_id_str()"
for secure access in "kernel_read_file.h".And, in "parse_exclude()"
function, there is no need for
"BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
ARRAY_SIZE(ignore_read_file_id))"
when access array by functon "kernel_read_file_id_str(j)".

Signed-off-by: zhaojiele <unclexiaole@gmail.com>
---
 security/loadpin/loadpin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..3e8bdcd06600 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -210,8 +210,6 @@ static void __init parse_exclude(void)
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
 		     ARRAY_SIZE(ignore_read_file_id));
-	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
-		     ARRAY_SIZE(ignore_read_file_id));
 
 	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
 		cur = exclude_read_files[i];
@@ -221,9 +219,9 @@ static void __init parse_exclude(void)
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


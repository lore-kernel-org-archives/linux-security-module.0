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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2AEC433DB
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 02:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A3064F21
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 02:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCECqq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECqq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 21:46:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A44C061574;
        Thu,  4 Mar 2021 18:46:45 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a24so605301plm.11;
        Thu, 04 Mar 2021 18:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yi3Usua41Hw4yIcJJb3KqUmU1Jph84h4mxzyZkzJeCo=;
        b=WygvtXqRxh06GZcIZ6cm/nZmLthTdfrg1fwqfQN+iyao52zxf+H8OEtEhvvzGzsit3
         AgHg9JnPzzUSi+5i3yOlhj1VmbeQ3US7lxyDFxxp/vSvcFtBDCysCNfdbk407DK7uDgS
         vdE2qjn+AQr+zn6Pf6F7S6x6QC/a54Cpaqpibd6meM+fYzdTxnVE+kw0IHYbWeQup9j5
         ev2PPA023ik/o0smRqejzuGuQicNX8KqV3ZOMNTMfGfJ259dbgwAs81UrvSQpuBVT5QN
         /qBWkabd+zwaVm93GbWAk5n2PAGBBwv5vxgWE8gW0TdLcP8FlfYVAHsDLA9TDbMqOeaw
         LJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yi3Usua41Hw4yIcJJb3KqUmU1Jph84h4mxzyZkzJeCo=;
        b=VifQ9aNXNjL9qfMApLUvSkoNyPAg1CpLrfS+CWn7s/4zV7LH2K3KZGiiPgQnsUXfSl
         guVF1XooquKo7e+tfH33CE7EFnE4BIwGs2bUNK7D011L8eHnh+DHdi5+gbGwbDpMkWRr
         F10AM3CEZaZNcIiUyQdNU0IhHIaZcpVIu7Zk1LT0swVH8WjvHKEdPRQQU8dww0bOXWUS
         ljCGxL6C+fSY9DEFEvLzLYG0EpB+17LCVSuGD1doLvSKmYEn75lRS98dWf0znnQ8gtuR
         3KiQH2+eA8TtOSfRR/U4fDPfxIF3SLgUCRjElrBuGybUh69QB1UM510Jw5ZahYO5U1K+
         jO3w==
X-Gm-Message-State: AOAM533EM0F3yguPIBVKizFuTjFF1suehKBne+XLJRqom1NEaWL48LN+
        1sI91tczBZ+55D1nuxwh+7g=
X-Google-Smtp-Source: ABdhPJw5hQakG0c/tHHQVSk+pol5yxTBtmdO5v4UMAS0hQ4wGZIa6/RTpBuxrJZ9LDjFjAJLO8tkng==
X-Received: by 2002:a17:90a:c20a:: with SMTP id e10mr7450856pjt.221.1614912404714;
        Thu, 04 Mar 2021 18:46:44 -0800 (PST)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id 197sm254861pfc.1.2021.03.04.18.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 18:46:44 -0800 (PST)
From:   Jiele zhao <unclexiaole@gmail.com>
To:     keescook@chromium.org
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiele zhao <unclexiaole@gmail.com>
Subject: [PATCH v2] security/loadpin: Replace "kernel_read_file_str[j]" with function "kernel_read_file_id_str(j)".
Date:   Fri,  5 Mar 2021 02:46:02 +0000
Message-Id: <20210305024602.203217-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Actually Linux kernel already provide function "kernel_read_file_id_str()"
for secure access in "kernel_read_file.h".
And, in "parse_exclude()" function, it's better to use

	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) - 1 ==
		ARRAY_SIZE(ignore_read_file_id));

to make sure the arrays stay within expected sizes.

Signed-off-by: Jiele zhao <unclexiaole@gmail.com>
---
 security/loadpin/loadpin.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..3d59ff363087 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -210,9 +210,10 @@ static void __init parse_exclude(void)
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(exclude_read_files) !=
 		     ARRAY_SIZE(ignore_read_file_id));
-	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) <
+	BUILD_BUG_ON(ARRAY_SIZE(kernel_read_file_str) - 1 ==
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


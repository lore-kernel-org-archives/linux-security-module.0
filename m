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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F46C433E6
	for <linux-security-module@archiver.kernel.org>; Sun, 24 Jan 2021 14:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C922DBF
	for <linux-security-module@archiver.kernel.org>; Sun, 24 Jan 2021 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbhAXOhP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Jan 2021 09:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAXOhM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Jan 2021 09:37:12 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83FC061573;
        Sun, 24 Jan 2021 06:36:31 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id p13so12140101ljg.2;
        Sun, 24 Jan 2021 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QodqNORzQEI0jZ3UgHKwlmsPP97FPNXiQY+I3Yhqyzc=;
        b=cr1C87z+wHnirM5Hf+2ePCj88USmE/RbjorXTfK0nVriB7GF9cbjnmuOcS737pAFHj
         ISYbaZGQsFchiAjS6vJjgXUKrWl6KZmYvFWmaZZeVAFwNzsmDOfxW8tsj5xSk0DSuu4q
         JlP8y+e6DyaPzCnfumo33j1TrGddibYXDDipIQy3vR074rY2NfAiEaSXBawc27TWDoA/
         Rfw3/XyzNqhpuDkwmGEbLyfKyE5zdIXHj8Sxl0XYgsP0YYx2NXq5R4XOeME/0Crg2rQi
         +akuE75Dv2J+2XcEemV+2DTGMCHgywIAKfoWlPHnOsXmkd6gBfldc5GmPuU0BrrCjPvA
         hNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QodqNORzQEI0jZ3UgHKwlmsPP97FPNXiQY+I3Yhqyzc=;
        b=lqD43ccQNAJI1/UR0CrM7SJvBHC34ThQhOWNU7d8HF2oP5S3QrP2+GB3h1BsepFPnr
         YB9e/KcpsyjNJEnFt2BXyXH6zRbjAmzf9gAmUi+p8qyi+EmWu7wmMLbK1Og1kXxmSQgW
         /pV3Bl7KQXKTHKcaVpYkSiQ7IoTuUT24dVpNBYmfcfz895OToM5mHNLwQpg8FI1rl1RM
         ESyVG3YHXqBbYZmgFt3P4/Y9IS9QHfTECQRi9AZfh5H2Bj5+G34j1tmb1Zg1A3p8JJf7
         gnPlaXlSLmAA+TOgHfC58zh8/tn503b820K2TTAk/cqvxxGrJxEgHSXc5u9W5duBictY
         ZX/A==
X-Gm-Message-State: AOAM5314CTc4Bwhn3z+3XqeoSFe3PJn1ar0G+QH4L0RRiBNb8fV8VYuJ
        hTOAN1o61NBBoEQcAgZjGEb/ZFTrrTH0sEwY
X-Google-Smtp-Source: ABdhPJxN17o2BHCp3cSgIPJMZPvckAl06RS5IVaXwqac7KRhgkS07PnxxvchDs7IAB/lG/rfdvjCHw==
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr428444ljo.401.1611498990449;
        Sun, 24 Jan 2021 06:36:30 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.238])
        by smtp.googlemail.com with ESMTPSA id u11sm43899ljj.45.2021.01.24.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 06:36:29 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     casey@schaufler-ca.com
Cc:     jmorris@namei.org, serge@hallyn.com, andreyknvl@google.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
Subject: [PATCH] smackfs: restrict bytes count in smackfs write functions
Date:   Sun, 24 Jan 2021 20:36:27 +0600
Message-Id: <20210124143627.582115-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot found WARNINGs in several smackfs write operations where
bytes count is passed to memdup_user_nul which exceeds
GFP MAX_ORDER. Check count size if bigger SMK_LONGLABEL,
for smk_write_syslog if bigger than PAGE_SIZE - 1.

Reported-by: syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 security/smack/smackfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5d44b7d258ef..88678c6f1b8c 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1167,7 +1167,7 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 		return -EPERM;
 	if (*ppos != 0)
 		return -EINVAL;
-	if (count < SMK_NETLBLADDRMIN)
+	if (count < SMK_NETLBLADDRMIN || count > SMK_LONGLABEL)
 		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
@@ -1427,7 +1427,7 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 		return -EPERM;
 	if (*ppos != 0)
 		return -EINVAL;
-	if (count < SMK_NETLBLADDRMIN)
+	if (count < SMK_NETLBLADDRMIN || count > SMK_LONGLABEL)
 		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
@@ -2647,6 +2647,8 @@ static ssize_t smk_write_syslog(struct file *file, const char __user *buf,
 
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
+	if (count > PAGE_SIZE - 1)
+		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
@@ -2744,6 +2746,8 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 	 */
 	if (*ppos != 0)
 		return -EINVAL;
+	if (count > SMK_LONGLABEL)
+		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
-- 
2.25.1


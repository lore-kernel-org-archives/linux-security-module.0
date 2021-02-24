Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA2CC433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Feb 2021 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C8764F07
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Feb 2021 13:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhBXNGl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Feb 2021 08:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234355AbhBXNBW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Feb 2021 08:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A90A64F3B;
        Wed, 24 Feb 2021 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614171184;
        bh=Cu4vqRUuzEIKRbA2z3V5UmP2g5YzATlkbEOiyofToOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huREABuS0TjO/hDbEohzLNiLUPXPoOUEEfMXQK/rnWTr1V7rBUE9ZUM9qwqTkUwCT
         lX3x5kfxSexniDfOK659e5RPP3HIBILYty8Wgc6ZOA8e9S8bYek1b0gMriNENF/lCI
         IDV9uz7otFwX31vqpzV3y021mJQkDjo8tTu3wZO5VOs/RisiLBxHLqsO8dauP70CQW
         lllZC1x4sdrHOqR8xhEztbhCSvnLGUnFo3cgz2SUVowHs5YL5PLSxN+53eQAiystod
         MVcGnJqr6FAJvNS+NO8f0DPYTnzfpRRX7Uyz7IyAj1zZggmzURIOsRLN8NbrXtNMXs
         +C4o7+Nn3cTQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 39/56] smackfs: restrict bytes count in smackfs write functions
Date:   Wed, 24 Feb 2021 07:51:55 -0500
Message-Id: <20210224125212.482485-39-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125212.482485-1-sashal@kernel.org>
References: <20210224125212.482485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

[ Upstream commit 7ef4c19d245f3dc233fd4be5acea436edd1d83d8 ]

syzbot found WARNINGs in several smackfs write operations where
bytes count is passed to memdup_user_nul which exceeds
GFP MAX_ORDER. Check count size if bigger than PAGE_SIZE.

Per smackfs doc, smk_write_net4addr accepts any label or -CIPSO,
smk_write_net6addr accepts any label or -DELETE. I couldn't find
any general rule for other label lengths except SMK_LABELLEN,
SMK_LONGLABEL, SMK_CIPSOMAX which are documented.

Let's constrain, in general, smackfs label lengths for PAGE_SIZE.
Although fuzzer crashes write to smackfs/netlabel on 0x400000 length.

Here is a quick way to reproduce the WARNING:
python -c "print('A' * 0x400000)" > /sys/fs/smackfs/netlabel

Reported-by: syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e567b4baf3a08..334299357e715 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1167,7 +1167,7 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 		return -EPERM;
 	if (*ppos != 0)
 		return -EINVAL;
-	if (count < SMK_NETLBLADDRMIN)
+	if (count < SMK_NETLBLADDRMIN || count > PAGE_SIZE - 1)
 		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
@@ -1427,7 +1427,7 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 		return -EPERM;
 	if (*ppos != 0)
 		return -EINVAL;
-	if (count < SMK_NETLBLADDRMIN)
+	if (count < SMK_NETLBLADDRMIN || count > PAGE_SIZE - 1)
 		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
@@ -1834,6 +1834,10 @@ static ssize_t smk_write_ambient(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	/* Enough data must be present */
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -2005,6 +2009,9 @@ static ssize_t smk_write_onlycap(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	if (count > PAGE_SIZE)
+		return -EINVAL;
+
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -2092,6 +2099,9 @@ static ssize_t smk_write_unconfined(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	if (count > PAGE_SIZE)
+		return -EINVAL;
+
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -2647,6 +2657,10 @@ static ssize_t smk_write_syslog(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	/* Enough data must be present */
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -2739,10 +2753,13 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 		return -EPERM;
 
 	/*
+	 * No partial write.
 	 * Enough data must be present.
 	 */
 	if (*ppos != 0)
 		return -EINVAL;
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
-- 
2.27.0


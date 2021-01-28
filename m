Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58057C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035B664DD8
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 11:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhA1L6w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhA1L6r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 06:58:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC21C061756;
        Thu, 28 Jan 2021 03:58:06 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h7so7222699lfc.6;
        Thu, 28 Jan 2021 03:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRtf0QmcidBZ2Eqy3uoPpzsmJyl+wCM0aMIKjggK7A8=;
        b=WLuGkfbk251OeDawLSI1Kz9L02B4yMXYZ52Jdve6ERDDKJbfUvoON5f7nddP9+meXs
         kSVZS3saeGGSLq+tLObzYEU9L0tAw6pHWMq2IJNCrNh/tvrbmqrzBU8c+LAAFeMd1P3j
         Co4u2DtM9ZOJ+k0D4N2zZwtv1wvJKYxvqrkMNHnWJiqOvjwDPxEP3vNMFMCEiaPw5jjw
         lf6u2dS20UtTpWDg8RuuNDOTGYJ4Jv9XWpMiv9CbNvAgyZT4aZuw6vU/p5gSOLhrZvde
         nE7N4H21JmChe24t9A7UAKNsdvoz6VxjJsMoZFu0/up7Lbwz4hPUTeCYGJPfOwN3rX1q
         Lbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRtf0QmcidBZ2Eqy3uoPpzsmJyl+wCM0aMIKjggK7A8=;
        b=cPC9pHF++p7+NM2GZOizJ7sZQQaeVknpRS13fjgt2U/0b67XbiwL2QrT1XJEi0K6yN
         Q4H0II+2QuoDjw7m6lXdqRAzlM2WD9e+FOGi+ztYkRxFlLZCeO4i7b9olIfRpTIBaNys
         ej7QEvqn0qoNKdi2hDA+5XLsQJ5rQ2C/Z6sC6dVlpoblZpSnT5PuM9WzF0VRbu0rxkfa
         SIjNlVcmWZvRt6PDw6O210IdwYStCTOl86mi3H+8uNENnuYE/2+f3764Hck8esbzDfxR
         H1gSinB6zuxb3o/Y2cQTPULsceZ77uJbwa2qhjqC0/oSPn5tvMOYJlsLtqJymBkFi2nb
         rIhg==
X-Gm-Message-State: AOAM532TsiAOcUZiOpZlBaxUTc8GKFF62QYloM2RU/vbbrXa/dAq7VBv
        bmsLYuUCw7P4M+wmXN/Sl5c=
X-Google-Smtp-Source: ABdhPJyA7LZmHW8TeIRomANLiH/WRxpbRzXeQqac0q4FvxGRQO4VIke+5eW5o2gx53UHVtqQi3mrQQ==
X-Received: by 2002:a19:3f94:: with SMTP id m142mr7512904lfa.196.1611835085330;
        Thu, 28 Jan 2021 03:58:05 -0800 (PST)
Received: from localhost.localdomain ([5.76.199.233])
        by smtp.googlemail.com with ESMTPSA id h5sm1943447ljj.136.2021.01.28.03.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:58:04 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     andreyknvl@google.com, casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        serge@hallyn.com, snovitoll@gmail.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
Subject: [PATCH v2] smackfs: restrict bytes count in smackfs write functions
Date:   Thu, 28 Jan 2021 17:58:01 +0600
Message-Id: <20210128115801.1096425-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3c35f7cc-1c8d-2fa0-6bc9-bde4e96017ce@i-love.sakura.ne.jp>
References: <3c35f7cc-1c8d-2fa0-6bc9-bde4e96017ce@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

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
---
 security/smack/smackfs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5d44b7d258ef..22ded2c26089 100644
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
@@ -2648,6 +2658,10 @@ static ssize_t smk_write_syslog(struct file *file, const char __user *buf,
 	if (!smack_privileged(CAP_MAC_ADMIN))
 		return -EPERM;
 
+	/* Enough data must be present */
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -2740,10 +2754,13 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
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
2.25.1


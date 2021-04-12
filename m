Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F54CC433ED
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Apr 2021 13:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5186128C
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Apr 2021 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhDLN3G (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:29:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49404 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbhDLN3G (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Apr 2021 09:29:06 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13CDSMkM016243;
        Mon, 12 Apr 2021 22:28:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Mon, 12 Apr 2021 22:28:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13CDSKDH016227
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Apr 2021 22:28:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] WARNING in smk_set_cipso (2)
To:     casey@schaufler-ca.com
References: <000000000000d06f2605bfc110e4@google.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        syzbot <syzbot+77c53db50c9fff774e8e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d1d73239-c549-c6c0-5b24-5d701b69e3f1@i-love.sakura.ne.jp>
Date:   Mon, 12 Apr 2021 22:28:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000d06f2605bfc110e4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit 7ef4c19d245f3dc2 ("smackfs: restrict bytes count in smackfs write
functions") missed that count > SMK_CIPSOMAX check applies to only
format == SMK_FIXED24_FMT case.

Reported-by: syzbot <syzbot+77c53db50c9fff774e8e@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/smack/smackfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 22ded2c26089..1ad7d0d1ea62 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -855,6 +855,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	if (format == SMK_FIXED24_FMT &&
 	    (count < SMK_CIPSOMIN || count > SMK_CIPSOMAX))
 		return -EINVAL;
+	if (count > PAGE_SIZE)
+		return -EINVAL;
 
 	data = memdup_user_nul(buf, count);
 	if (IS_ERR(data))
-- 
2.18.4


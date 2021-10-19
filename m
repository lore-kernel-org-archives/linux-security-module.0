Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B41C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Oct 2021 11:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D6160FED
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Oct 2021 11:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhJSL5Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:57:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61909 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhJSL5P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Oct 2021 07:57:15 -0400
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19JBsaJi020082;
        Tue, 19 Oct 2021 20:54:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 19 Oct 2021 20:54:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19JBsTIx020048
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Oct 2021 20:54:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] smackfs: use __GFP_NOFAIL for smk_cipso_doi()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     syzbot <syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com>,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
References: <000000000000db448f05a212beea@google.com>
 <a293a766-4329-f6de-c8a9-1a5051217c45@I-love.SAKURA.ne.jp>
Message-ID: <96c25c43-a419-bc5e-839a-7ff484b1c22a@i-love.sakura.ne.jp>
Date:   Tue, 19 Oct 2021 20:54:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a293a766-4329-f6de-c8a9-1a5051217c45@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot is reporting kernel panic at smk_cipso_doi() due to memory
allocation fault injection [1]. The reason for need to use panic() was
not explained. But since no fix was proposed for 18 months, for now
let's use __GFP_NOFAIL for utilizing syzbot resource on other bugs.

Link: https://syzkaller.appspot.com/bug?extid=89731ccb6fec15ce1c22 [1]
Reported-by: syzbot <syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/smack/smackfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 83b90442f963..3e6a198dd3dd 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -693,9 +693,7 @@ static void smk_cipso_doi(void)
 		printk(KERN_WARNING "%s:%d remove rc = %d\n",
 		       __func__, __LINE__, rc);
 
-	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL);
-	if (doip == NULL)
-		panic("smack:  Failed to initialize cipso DOI.\n");
+	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
 	doip->map.std = NULL;
 	doip->doi = smk_cipso_doi_value;
 	doip->type = CIPSO_V4_MAP_PASS;
-- 
2.18.4



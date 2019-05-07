Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E04DC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689CF205ED
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 11:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfEGLep (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 07:34:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64858 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGLep (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 07:34:45 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x47BYZ08097551;
        Tue, 7 May 2019 20:34:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Tue, 07 May 2019 20:34:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x47BYUSn097387
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 May 2019 20:34:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] tomoyo: Don't emit WARNING: string while fuzzing testing.
Date:   Tue,  7 May 2019 20:34:22 +0900
Message-Id: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
testing.") enabled the learning mode, and syzbot started crashing by
encountering this warning message. Disable this warning if built for
fuzzing testing; otherwise syzbot can't start fuzzing testing.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 security/tomoyo/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 0517cbd..52752e1 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1076,8 +1076,10 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
 		/* r->granted = false; */
 		tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
+#ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
 		pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
 			domain->domainname->name);
+#endif
 	}
 	return false;
 }
-- 
1.8.3.1


Return-Path: <SRS0=ioQF=P5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD7BC282DC
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E277820823
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfAUH0X (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:26:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:11675 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfAUH0X (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Jan 2019 02:26:23 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0L1PAdK046364
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jan 2019 10:25:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 21 Jan 2019 10:25:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0L1PAjP046353
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jan 2019 10:25:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x0L1PAwO046352;
        Mon, 21 Jan 2019 10:25:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201901210125.x0L1PAwO046352@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: [PATCH] apparmor: Adjust offset when accessing task blob.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     linux-security-module@vger.kernel.org
MIME-Version: 1.0
Date:   Mon, 21 Jan 2019 10:25:10 +0900
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

AppArmor will no longer be the only user of task blob
after TOMOYO started using task blob.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/apparmor/include/task.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 039c1e6..311e652 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -16,7 +16,7 @@
 
 static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
 {
-	return task->security;
+	return task->security + apparmor_blob_sizes.lbs_task;
 }
 
 /*
-- 
1.8.3.1

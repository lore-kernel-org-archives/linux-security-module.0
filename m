Return-Path: <SRS0=qkJb=5O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F81C43331
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 15:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CF1206F6
	for <linux-security-module@archiver.kernel.org>; Sun, 29 Mar 2020 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgC2PFY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:05:24 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:50186 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbgC2PFY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 29 Mar 2020 11:05:24 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 11:05:23 EDT
Received: from localhost.localdomain (unknown [120.229.255.87])
        by app2 (Coremail) with SMTP id XQUFCgBXXUWxt4BeeJuFAA--.1822S3;
        Sun, 29 Mar 2020 22:59:00 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xiyuyang19@fudan.edu.cn, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] apparmor: fix potential label refcnt leak in aa_change_profile
Date:   Sun, 29 Mar 2020 22:57:41 +0800
Message-Id: <1585493861-9867-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgBXXUWxt4BeeJuFAA--.1822S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfGF47WF4fCr45WrW5trb_yoW8GrWDpF
        47KF1UGFs5tFy2kF4Dta13urWak397Xr1Yva9xu3yUZrW5JayDXw1a9r17WryrurykAwsx
        tFWayF9Y9w1UC3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
        UUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

aa_change_profile() invokes aa_get_current_label(), which returns
a reference of the current task's label.

According to the comment of aa_get_current_label(), the returned
reference must be put with aa_put_label().
However, when the original object pointed by "label" becomes
unreachable because aa_change_profile() returns or a new object
is assigned to "label", reference count increased by
aa_get_current_label() is not decreased, causing a refcnt leak.

Fix this by calling aa_put_label() before the original object pointed
by "label" becomes unreachable.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 security/apparmor/domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6ceb74e0f789..b99145ae34c0 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1328,6 +1328,7 @@ int aa_change_profile(const char *fqname, int flags)
 		ctx->nnp = aa_get_label(label);
 
 	if (!fqname || !*fqname) {
+		aa_put_label(label);
 		AA_DEBUG("no profile name");
 		return -EINVAL;
 	}
@@ -1346,6 +1347,7 @@ int aa_change_profile(const char *fqname, int flags)
 			op = OP_CHANGE_PROFILE;
 	}
 
+	aa_put_label(label);
 	label = aa_get_current_label();
 
 	if (*fqname == '&') {
-- 
2.7.4


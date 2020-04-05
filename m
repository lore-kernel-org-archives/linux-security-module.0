Return-Path: <SRS0=1b+D=5V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C91C2D0E8
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Apr 2020 05:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FDD2072F
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Apr 2020 05:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgDEFNA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Apr 2020 01:13:00 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:60366 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbgDEFNA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Apr 2020 01:13:00 -0400
Received: from localhost.localdomain (unknown [120.229.255.226])
        by app1 (Coremail) with SMTP id XAUFCgA3XDjGaIlemdXLAA--.46630S3;
        Sun, 05 Apr 2020 13:12:41 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xiyuyang19@fudan.edu.cn, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v2] apparmor: fix potential label refcnt leak in aa_change_profile
Date:   Sun,  5 Apr 2020 13:11:55 +0800
Message-Id: <1586063515-15682-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgA3XDjGaIlemdXLAA--.46630S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfGF47WF4fCr45WrW5trb_yoW8Xw13pF
        47KF1UJa1DtFy7Ka1Dta15urWak3yxJr1Yvasxu3y5Zrs8JrWUXw17ur1Uur1rZrykArsF
        qa43tFsYvw1UCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
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

Fix this by calling aa_put_label() before aa_change_profile() return
and dropping unnecessary aa_get_current_label().

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
Changes in v2:
- Remove unnecessary aa_get_current_label() because it gets called
  earlier in the fn
---
 security/apparmor/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 6ceb74e0f789..a84ef030fbd7 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1328,6 +1328,7 @@ int aa_change_profile(const char *fqname, int flags)
 		ctx->nnp = aa_get_label(label);
 
 	if (!fqname || !*fqname) {
+		aa_put_label(label);
 		AA_DEBUG("no profile name");
 		return -EINVAL;
 	}
@@ -1346,8 +1347,6 @@ int aa_change_profile(const char *fqname, int flags)
 			op = OP_CHANGE_PROFILE;
 	}
 
-	label = aa_get_current_label();
-
 	if (*fqname == '&') {
 		stack = true;
 		/* don't have label_parse() do stacking */
-- 
2.7.4


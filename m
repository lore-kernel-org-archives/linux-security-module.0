Return-Path: <SRS0=H0OP=EO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA3C388F9
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 06:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17107217A0
	for <linux-security-module@archiver.kernel.org>; Sun,  8 Nov 2020 06:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgKHGps (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 8 Nov 2020 01:45:48 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40176 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgKHGps (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 8 Nov 2020 01:45:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UEZh2Lm_1604817943;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEZh2Lm_1604817943)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 14:45:44 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/smack: remove unused varible 'rc'
Date:   Sun,  8 Nov 2020 14:45:42 +0800
Message-Id: <1604817942-3755-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This varible isn't used and can be removed to avoid a gcc warning:
security/smack/smack_lsm.c:3873:6: warning: variable ‘rc’ set but not
used [-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Casey Schaufler <casey@schaufler-ca.com> 
Cc: James Morris <jmorris@namei.org> 
Cc: "Serge E. Hallyn" <serge@hallyn.com> 
Cc: linux-security-module@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 security/smack/smack_lsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5c90b9fa4d40..9994fcfafd70 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3870,7 +3870,6 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
 	struct netlbl_lsm_secattr secattr;
 	struct socket_smack *ssp = NULL;
 	struct smack_known *skp = NULL;
-	int rc;
 
 	netlbl_secattr_init(&secattr);
 
@@ -3880,7 +3879,7 @@ static struct smack_known *smack_from_netlbl(struct sock *sk, u16 family,
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
 		if (secattr.flags & NETLBL_SECATTR_CACHEABLE)
-			rc = netlbl_cache_add(skb, family, &skp->smk_netlabel);
+			netlbl_cache_add(skb, family, &skp->smk_netlabel);
 	}
 
 	netlbl_secattr_destroy(&secattr);
-- 
1.8.3.1


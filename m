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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9908C433B4
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Apr 2021 02:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8289C61002
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Apr 2021 02:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhDSC5V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 18 Apr 2021 22:57:21 -0400
Received: from m12-13.163.com ([220.181.12.13]:49891 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhDSC5U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 18 Apr 2021 22:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xomqc
        17oMU0luFxHQJ3xPnmAHn+4J6Ud91RfUSOUquk=; b=YdK9JpfH+G8VlOYibGHNH
        t5wHGCf1o9wAW7SMBp35Ywz/7zqH9xYmgmrJj2ra2NVA9jcGhSqABfmF6Bp4nciS
        zKPcKVigwZXB26vpHdPOZK7PAkMnbuHD0q6iaeKHroXmA4eNyscscLT8bY7acsWp
        VUWsKM/94GOvyZq7bz1oEM=
Received: from localhost.localdomain (unknown [183.46.37.234])
        by smtp9 (Coremail) with SMTP id DcCowAAnBI0j8XxgNHNwGg--.497S2;
        Mon, 19 Apr 2021 10:55:32 +0800 (CST)
From:   =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongjun Tan <tanzhongjun@yulong.com>
Subject: [PATCH v3] lsm:fix a missing-check bug in smack_sb_eat_lsm_opts()
Date:   Mon, 19 Apr 2021 10:55:17 +0800
Message-Id: <20210419025517.551-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnBI0j8XxgNHNwGg--.497S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4xGF1fCrWUKw4rtF43Jrb_yoWkGFc_G3
        4xA3WrXrW5C398C3yxZF4kAr40kw18Xr15WFn3tFy5AryYqw48W3Z8Xr93AF45ZF9rGas7
        CasxGryrAwnIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnq-e7UUUUU==
X-Originating-IP: [183.46.37.234]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/1tbiKAV5xl7WFHk3ZQAAsl
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Zhongjun Tan <tanzhongjun@yulong.com>

In smack_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul().
It returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
should be freed when error.

Signed-off-by: Zhongjun Tan <tanzhongjun@yulong.com>
---
changes in v1:
update the commit information. 
changes in v2:
fix brace error
changes in v3:
As viro said, just four codes and no other changes are needed.

security/smack/smack_lsm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 223a6da..020929f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -710,7 +710,10 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 		token = match_opt_prefix(from, len, &arg);
 		if (token != Opt_error) {
 			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
-			rc = smack_add_opt(token, arg, mnt_opts);
+			if (arg)
+				rc = smack_add_opt(token, arg, mnt_opts);
+			else
+				rc = -ENOMEM;
 			if (unlikely(rc)) {
 				kfree(arg);
 				if (*mnt_opts)
-- 
1.9.1



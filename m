Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDEEC433ED
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076C5610E6
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 09:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242274AbhDPJyV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:54:21 -0400
Received: from m12-16.163.com ([220.181.12.16]:45333 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242273AbhDPJyV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 05:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rfaZi
        75ykphmZytDo8j3USUV+G9FAfZwR9DbVC9yRWs=; b=kSXeBUI1sRoSQ7QJHc0/p
        h3ja45WotuY0RGleR+hU80oet1Oj6PUvcdzmyQHKT9rv56hmSpBANF1O/ntFeB/S
        fnFVeKpsCdwV2P9HSlwx4ybSWx3P7dq3jM/KW/VwI2I3iaS6rCkkul1aWlai0QOu
        8v7wZi6UkTItHdBHK/cBZg=
Received: from localhost.localdomain (unknown [183.46.98.96])
        by smtp12 (Coremail) with SMTP id EMCowAAnLRmLXnlgwwaZlw--.14718S2;
        Fri, 16 Apr 2021 17:53:17 +0800 (CST)
From:   =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongjun Tan <tanzhongjun@yulong.com>
Subject: [PATCH] lsm:fix a missing-check bug in smack_sb_eat_lsm_opts()
Date:   Fri, 16 Apr 2021 17:53:03 +0800
Message-Id: <20210416095303.530-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAnLRmLXnlgwwaZlw--.14718S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48Gw1DZFW8Kr1UAr4DCFg_yoW8Wr4rpr
        sakFnxGr9YqFs2qa93GF1vqF4rGa1kKryUWrZF9w13X3W5X34kKFWqqFy3tF1xGFW8tr4a
        9rs0vr4UWF1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvFAJUUUUU=
X-Originating-IP: [183.46.98.96]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBXhN2xlaD6oBAYwABsg
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Zhongjun Tan <tanzhongjun@yulong.com>

In smack_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul().
It returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
should be freed when error.

Signed-off-by: Zhongjun Tan <tanzhongjun@yulong.com>
---
 security/smack/smack_lsm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 223a6da..0d5439f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -696,10 +696,11 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
 	char *from = options, *to = options;
 	bool first = true;
+	int rc;
 
 	while (1) {
 		char *next = strchr(from, ',');
-		int token, len, rc;
+		int token, len;
 		char *arg = NULL;
 
 		if (next)
@@ -710,13 +711,14 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 		token = match_opt_prefix(from, len, &arg);
 		if (token != Opt_error) {
 			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
+			if (!arg) {
+				rc = -ENOMEM;
+				goto free_mnt_opts;
 			rc = smack_add_opt(token, arg, mnt_opts);
+			}
 			if (unlikely(rc)) {
 				kfree(arg);
-				if (*mnt_opts)
-					smack_free_mnt_opts(*mnt_opts);
-				*mnt_opts = NULL;
-				return rc;
+				goto free_mnt_opts;
 			}
 		} else {
 			if (!first) {	// copy with preceding comma
@@ -734,6 +736,13 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	}
 	*to = '\0';
 	return 0;
+
+free_mnt_opts:
+	if (*mnt_opts) {
+		smack_free_mnt_opts(*mnt_opts);
+		*mnt_opts = NULL;
+	}
+	return rc;
 }
 
 /**
-- 
1.9.1



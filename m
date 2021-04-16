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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07192C433ED
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA2361107
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Apr 2021 10:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhDPKNO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:13:14 -0400
Received: from m12-14.163.com ([220.181.12.14]:57070 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239216AbhDPKNN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Apr 2021 06:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DBxpB
        nFi6nwZpjt7AR3toFc2XaJmljNpCiXZBY+5bG0=; b=mMWVVG6STYatFqvjcdvPM
        NMD/z2k8MHlMoPtAMBIxuNGfh8gyR6LACkDrxFZcHlGKcYNhgdspCe1IAVeVVPLL
        d5BbsOq0NIVV0GnB3vYwWjC/ZwdthxGNAN2Rbql0/JuN8yZoY+1DHLUBV86Pj1if
        /HBOYNbprjtdyfilSMUyq4=
Received: from localhost.localdomain (unknown [183.46.98.96])
        by smtp10 (Coremail) with SMTP id DsCowADnkjAGY3lgfNzBDg--.11814S2;
        Fri, 16 Apr 2021 18:12:24 +0800 (CST)
From:   =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongjun Tan <tanzhongjun@yulong.com>
Subject: [PATCH v2] lsm:fix a missing-check bug in smack_sb_eat_lsm_opts()
Date:   Fri, 16 Apr 2021 18:12:10 +0800
Message-Id: <20210416101210.1175-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADnkjAGY3lgfNzBDg--.11814S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1DKF1xGry3tF47Xr4UCFg_yoW8Wrykpr
        sakFnxGrnYqFs2qa93WF1vqF4rGa1kKr1UWrZF9w13J3WYq34kKrWqqFy3tF1xGFWrtr4a
        9rs0vr45WF1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jPKsbUUUUU=
X-Originating-IP: [183.46.98.96]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBXgh2xlaD6oCNkAAAsE
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Zhongjun Tan <tanzhongjun@yulong.com>

In smack_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul().
It returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
should be freed when error.

Signed-off-by: Zhongjun Tan <tanzhongjun@yulong.com>
---
v2:fix brace error 

 security/smack/smack_lsm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 223a6da..1e4c66f 100644
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
+			}
 			rc = smack_add_opt(token, arg, mnt_opts);
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


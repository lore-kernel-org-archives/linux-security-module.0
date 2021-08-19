Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2700C4320A
	for <linux-security-module@archiver.kernel.org>; Thu, 19 Aug 2021 10:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B86860BD3
	for <linux-security-module@archiver.kernel.org>; Thu, 19 Aug 2021 10:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhHSKVo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKVn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Aug 2021 06:21:43 -0400
X-Greylist: delayed 254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Aug 2021 03:21:07 PDT
Received: from ha0.nfschina.com (unknown [IPv6:2400:dd01:100f:2:d63d:7eff:fe08:eb3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7380DC061756;
        Thu, 19 Aug 2021 03:21:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha0.nfschina.com (Postfix) with ESMTP id 93EACAE0D6B;
        Thu, 19 Aug 2021 18:17:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha0.nfschina.com ([127.0.0.1])
        by localhost (ha0.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vEz3jAI6unxM; Thu, 19 Aug 2021 18:16:53 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha0.nfschina.com (Postfix) with ESMTPA id 9B21AAE0DCB;
        Thu, 19 Aug 2021 18:16:52 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong <liqiong@nfschina.com>
Subject: [PATCH] ima: fix infinite loop within "ima_match_policy" function.
Date:   Thu, 19 Aug 2021 18:15:29 +0800
Message-Id: <20210819101529.28001-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When "ima_match_policy" is looping while "ima_update_policy" changs
the variable "ima_rules", then "ima_match_policy" may can't exit loop,
and kernel keeps printf "rcu_sched detected stall on CPU ...".

It occurs at boot phase, systemd-services are being checked within
"ima_match_policy,at the same time, the variable "ima_rules"
is changed by a service.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 security/integrity/ima/ima_policy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index fd5d46e511f1..7e71e643457c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -217,6 +217,7 @@ static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
 static struct list_head *ima_rules = &ima_default_rules;
+static DECLARE_RWSEM(ima_rules_sem);
 
 static int ima_policy __initdata;
 
@@ -666,6 +667,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 	if (template_desc && !*template_desc)
 		*template_desc = ima_template_desc_current();
 
+	down_read(&ima_rules_sem);
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, ima_rules, list) {
 
@@ -702,6 +704,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 			break;
 	}
 	rcu_read_unlock();
+	up_read(&ima_rules_sem);
 
 	return action;
 }
@@ -919,7 +922,9 @@ void ima_update_policy(void)
 
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
+		down_write(&ima_rules_sem);
 		ima_rules = policy;
+		up_write(&ima_rules_sem);
 
 		/*
 		 * IMA architecture specific policy rules are specified
-- 
2.11.0


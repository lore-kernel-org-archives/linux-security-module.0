Return-Path: <SRS0=Scbz=WO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94190C41514
	for <linux-security-module@archiver.kernel.org>; Sun, 18 Aug 2019 23:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6917421882
	for <linux-security-module@archiver.kernel.org>; Sun, 18 Aug 2019 23:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRX6c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 18 Aug 2019 19:58:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHRX6c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 18 Aug 2019 19:58:32 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 413A2EC57B49FFB82AA9;
        Mon, 19 Aug 2019 00:58:31 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.36) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 19 Aug 2019 00:58:22 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@huawei.com>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [WIP][RFC][PATCH 1/3] security: introduce call_int_hook_and() macro
Date:   Mon, 19 Aug 2019 01:57:43 +0200
Message-ID: <20190818235745.1417-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818235745.1417-1-roberto.sassu@huawei.com>
References: <20190818235745.1417-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The LSM hooks audit_rule_known() and audit_rule_match() define 1 as
result for successful operation. However, the security_ functions use
call_int_hook() which stops iterating over LSMs if the result is not
zero.

Introduce call_int_hook_and(), so that the final result returned by the
security_ functions is 1 if all LSMs return 1.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index cbee0b7915d5..ff1736ee3410 100644
--- a/security/security.c
+++ b/security/security.c
@@ -634,6 +634,20 @@ static void __init lsm_early_task(struct task_struct *task)
 	RC;							\
 })
 
+#define call_int_hook_and(FUNC, IRC, ...) ({			\
+	int RC = IRC;						\
+	do {							\
+		struct security_hook_list *P;			\
+								\
+		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (!RC)				\
+				break;				\
+		}						\
+	} while (0);						\
+	RC;							\
+})
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -2339,7 +2353,7 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return call_int_hook(audit_rule_known, 0, krule);
+	return call_int_hook_and(audit_rule_known, 0, krule);
 }
 
 void security_audit_rule_free(void *lsmrule)
@@ -2349,7 +2363,8 @@ void security_audit_rule_free(void *lsmrule)
 
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	return call_int_hook_and(audit_rule_match, 0, secid, field, op,
+				 lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.17.1


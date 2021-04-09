Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E03C433B4
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC8961182
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 11:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhDILpK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:45:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2823 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhDILpJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Apr 2021 07:45:09 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGwzW2VhVz67w98;
        Fri,  9 Apr 2021 19:35:19 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 13:44:55 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 5/7] ima: Introduce appraise_exec_immutable policy
Date:   Fri, 9 Apr 2021 13:43:11 +0200
Message-ID: <20210409114313.4073-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409114313.4073-1-roberto.sassu@huawei.com>
References: <20210409114313.4073-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch modifies the existing "appraise_exec_tcb" policy, by adding the
appraise_type=meta_immutable requirement for executed files. This policy
can be selected by specifying
ima_policy="appraise_exec_tcb|appraise_exec_immutable" in the kernel
command line.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 security/integrity/ima/ima_policy.c             | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 93c5f78905e2..265f7657f59d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1780,6 +1780,10 @@
 			appraised (with imasig requirement) instead of files
 			owned by root.
 
+			The "appraise_exec_immutable" policy requires immutable
+			metadata for executed files, if the "appraise_exec_tcb"
+			policy is selected.
+
 			The "appraise_tmpfs" policy excludes the dont_appraise
 			rule for the tmpfs and ramfs filesystems for the
 			"appraise_tcb" and "appraise_exec_tcb" policies.
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a45e494e06e8..6249817ebd04 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -243,6 +243,7 @@ __setup("ima_tcb", default_measure_policy_setup);
 static unsigned int ima_measure_skip_flags __initdata;
 static unsigned int ima_appraise_skip_flags __initdata;
 static bool ima_use_appraise_tcb __initdata;
+static bool ima_use_appraise_exec_immutable __initdata;
 static bool ima_use_secure_boot __initdata;
 static bool ima_use_critical_data __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
@@ -267,7 +268,9 @@ static int __init policy_setup(char *str)
 		else if (strcmp(p, "appraise_exec_tcb") == 0) {
 			ima_use_appraise_tcb = true;
 			ima_appraise_skip_flags |= IMA_SKIP_OPEN;
-		} else if (strcmp(p, "secure_boot") == 0)
+		} else if (strcmp(p, "appraise_exec_immutable") == 0)
+			ima_use_appraise_exec_immutable = true;
+		else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = true;
 		else if (strcmp(p, "critical_data") == 0)
 			ima_use_critical_data = true;
@@ -913,6 +916,9 @@ void __init ima_init_policy(void)
 				  IMA_DEFAULT_POLICY, 0);
 	}
 
+	if (ima_use_appraise_exec_immutable)
+		appraise_exec_rules[0].flags |= IMA_META_IMMUTABLE_REQUIRED;
+
 	if (ima_use_critical_data)
 		add_rules(critical_data_rules,
 			  ARRAY_SIZE(critical_data_rules),
-- 
2.26.2


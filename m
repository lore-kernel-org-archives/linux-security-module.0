Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D91C54FD0
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4072073E
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 16:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgCYQQr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:16:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbgCYQQr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 12:16:47 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3D4F71E70E9E7CC96987;
        Wed, 25 Mar 2020 16:16:46 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 16:16:35 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.struczynski@huawei.com>,
        <silviu.vlasceanu@huawei.com>
Subject: [PATCH 4/5] ima: Remove redundant policy rule set in add_rules()
Date:   Wed, 25 Mar 2020 17:14:54 +0100
Message-ID: <20200325161455.7610-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325161116.7082-1-roberto.sassu@huawei.com>
References: <20200325161116.7082-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Function ima_appraise_flag() returns the flag to be set in
temp_ima_appraise depending on the hook identifier passed as an argument.
It is not necessary to set the flag again for the POLICY_CHECK hook.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima_policy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c334e0dc6083..ea9b991f0232 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -643,11 +643,8 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 
 			list_add_tail(&entry->list, &ima_policy_rules);
 		}
-		if (entries[i].action == APPRAISE) {
+		if (entries[i].action == APPRAISE)
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-			if (entries[i].func == POLICY_CHECK)
-				temp_ima_appraise |= IMA_APPRAISE_POLICY;
-		}
 	}
 }
 
-- 
2.17.1


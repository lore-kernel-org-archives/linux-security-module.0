Return-Path: <SRS0=9aR4=3Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68904C33CA1
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Feb 2020 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92D21741
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Feb 2020 10:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEKfP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:35:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbgBEKfP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Feb 2020 05:35:15 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4D8FBB6410E05FE3D3EE;
        Wed,  5 Feb 2020 10:35:14 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 5 Feb 2020 10:35:07 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 3/8] ima: Evaluate error in init_ima()
Date:   Wed, 5 Feb 2020 11:33:12 +0100
Message-ID: <20200205103317.29356-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205103317.29356-1-roberto.sassu@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Evaluate error in init_ima() before register_blocking_lsm_notifier() and
return if not zero.

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..a16c148ed90d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -738,6 +738,9 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
+	if (error)
+		return error;
+
 	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
-- 
2.17.1


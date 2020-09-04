Return-Path: <SRS0=mt4R=CN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4744C43461
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Sep 2020 09:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A3A20770
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Sep 2020 09:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgIDJ1k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:27:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729835AbgIDJ1W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Sep 2020 05:27:22 -0400
Received: from lhreml742-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 47177DE6EC3476AF8C45;
        Fri,  4 Sep 2020 10:27:21 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml742-chm.china.huawei.com (10.201.108.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 10:27:21 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 11:27:20 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 02/12] ima: Remove semicolon at the end of ima_get_binary_runtime_size()
Date:   Fri, 4 Sep 2020 11:23:29 +0200
Message-ID: <20200904092339.19598-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20200904092339.19598-1-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch removes the unnecessary semicolon at the end of
ima_get_binary_runtime_size().

Cc: stable@vger.kernel.org
Fixes: d158847ae89a2 ("ima: maintain memory size needed for serializing the measurement list")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index fb4ec270f620..c096ef8945c7 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -133,7 +133,7 @@ unsigned long ima_get_binary_runtime_size(void)
 		return ULONG_MAX;
 	else
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
-};
+}
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
-- 
2.27.GIT


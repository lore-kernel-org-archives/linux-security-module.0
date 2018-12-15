Return-Path: <SRS0=zJ1g=OY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1BC43387
	for <linux-security-module@archiver.kernel.org>; Sat, 15 Dec 2018 09:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D672084D
	for <linux-security-module@archiver.kernel.org>; Sat, 15 Dec 2018 09:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeLOJqW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:46:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbeLOJqW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 15 Dec 2018 04:46:22 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 13A3E2FD7F1AD;
        Sat, 15 Dec 2018 17:46:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 17:46:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] evm: CHECK-remove set but not used variable 'xattr'
Date:   Sat, 15 Dec 2018 09:53:56 +0000
Message-ID: <1544867636-59276-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes gcc '-Wunused-but-set-variable' warning:

security/integrity/evm/evm_main.c: In function 'init_evm':
security/integrity/evm/evm_main.c:566:21: warning:
 variable 'xattr' set but not used [-Wunused-but-set-variable]

It never used since commit 21af76631476 ("EVM: turn evm_config_xattrnames
into a list")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/integrity/evm/evm_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 5ecaa3d..b6d9f14 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -563,7 +563,6 @@ static int __init init_evm(void)
 {
 	int error;
 	struct list_head *pos, *q;
-	struct xattr_list *xattr;
 
 	evm_init_config();
 
@@ -580,11 +579,8 @@ static int __init init_evm(void)
 error:
 	if (error != 0) {
 		if (!list_empty(&evm_config_xattrnames)) {
-			list_for_each_safe(pos, q, &evm_config_xattrnames) {
-				xattr = list_entry(pos, struct xattr_list,
-						   list);
+			list_for_each_safe(pos, q, &evm_config_xattrnames)
 				list_del(pos);
-			}
 		}
 	}




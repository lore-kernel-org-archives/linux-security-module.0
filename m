Return-Path: <SRS0=SHQt=5T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B911C2BA15
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Apr 2020 06:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD3A20787
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Apr 2020 06:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgDCGXq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:23:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729423AbgDCGXq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Apr 2020 02:23:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B132E64C2FAE4706A02E;
        Fri,  3 Apr 2020 14:23:28 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 14:23:22 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ima: make ima_mok_init() static
Date:   Fri, 3 Apr 2020 14:21:58 +0800
Message-ID: <20200403062158.1827-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix the following sparse warning:

security/integrity/ima/ima_mok.c:24:12: warning: symbol 'ima_mok_init'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 security/integrity/ima/ima_mok.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 36cadadbfba4..a93a2ca257d9 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -21,7 +21,7 @@ struct key *ima_blacklist_keyring;
 /*
  * Allocate the IMA blacklist keyring
  */
-__init int ima_mok_init(void)
+static __init int ima_mok_init(void)
 {
 	struct key_restriction *restriction;
 
-- 
2.17.2


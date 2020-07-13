Return-Path: <SRS0=XQ6M=AY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2605C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jul 2020 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EBD20738
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jul 2020 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgGMOQN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:16:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729823AbgGMOQN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jul 2020 10:16:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C748F25F2900C3B7BF4E;
        Mon, 13 Jul 2020 22:16:07 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Jul 2020 22:16:01 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] IMA: Make ima_mok_init() static
Date:   Mon, 13 Jul 2020 22:26:05 +0800
Message-ID: <20200713142605.50373-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The sparse tool complains as follows:

security/integrity/ima/ima_mok.c:24:12: warning:
 symbol 'ima_mok_init' was not declared. Should it be static?

ima_mok_init() is not used outside of ima_mok.c, so marks
it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
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
 


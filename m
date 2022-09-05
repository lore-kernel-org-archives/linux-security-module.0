Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE7AC6FA89
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Sep 2022 07:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiIEH6t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Sep 2022 03:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiIEH6m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Sep 2022 03:58:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D946DAC;
        Mon,  5 Sep 2022 00:58:40 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MLglx09Fbz1P6gb;
        Mon,  5 Sep 2022 15:54:52 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 15:58:38 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/4] ima: Use DECLARE_FLEX_ARRAY() helper in ima_modsig
Date:   Mon, 5 Sep 2022 15:58:34 +0800
Message-ID: <20220905075837.1083216-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905075837.1083216-1-cuigaosheng1@huawei.com>
References: <20220905075837.1083216-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members instead. So, replace zero-length array
declaration with the new DECLARE_FLEX_ARRAY() helper macro in struct
modsig.

This helper allows for a flexible-array member in a union.

Link: KSPP#21
Link: KSPP#193
Link: KSPP#197
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/ima/ima_modsig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index fb25723c65bc..d132383dbb64 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -29,7 +29,7 @@ struct modsig {
 	 * storing the signature.
 	 */
 	int raw_pkcs7_len;
-	u8 raw_pkcs7[];
+	DECLARE_FLEX_ARRAY(u8, raw_pkcs7);
 };
 
 /*
-- 
2.25.1


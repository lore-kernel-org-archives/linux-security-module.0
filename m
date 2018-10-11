Return-Path: <SRS0=pW3O=MX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2890FC46463
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 06:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12FE2085B
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Oct 2018 06:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12FE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJKOVc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:21:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13617 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbeJKOVc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Oct 2018 10:21:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 05A9FBE25D747;
        Thu, 11 Oct 2018 14:55:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 14:55:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] KEYS: trusted: remove set but not used variable ''
Date:   Thu, 11 Oct 2018 07:06:39 +0000
Message-ID: <1539241599-140866-1-git-send-email-yuehaibing@huawei.com>
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

security/keys/trusted.c: In function 'tpm_unseal':
security/keys/trusted.c:592:11: warning:
 variable 'keyhndl' set but not used [-Wunused-but-set-variable]
  uint32_t keyhndl;

It never used since introduction in 
commit d00a1c72f7f4 ("keys: add new trusted key-type")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/keys/trusted.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ff67893..169df79 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -589,7 +589,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	uint32_t authhandle2 = 0;
 	unsigned char cont = 0;
 	uint32_t ordinal;
-	uint32_t keyhndl;
 	int ret;
 
 	/* sessions for unsealing key and data */
@@ -605,7 +604,6 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
-	keyhndl = htonl(SRKHANDLE);
 	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);


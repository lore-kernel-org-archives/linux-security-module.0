Return-Path: <SRS0=BnuI=3Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50570C2D0DB
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320EC214D8
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jan 2020 17:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0RGP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:06:15 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2301 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgA0RGP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 12:06:15 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B982F9C7A7F77069A018;
        Mon, 27 Jan 2020 17:06:13 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:06:03 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to HASH_ALGO__LAST
Date:   Mon, 27 Jan 2020 18:04:36 +0100
Message-ID: <20200127170443.21538-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127170443.21538-1-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

chip->allocated_banks contains the list of TPM algorithm IDs of allocated
PCR banks. It also contains the corresponding ID of the crypto subsystem,
so that users of the TPM driver can calculate a digest for a PCR extend
operation.

However, if there is no mapping between TPM algorithm ID and crypto ID, the
crypto_id field in chip->allocated_banks remains set to zero (the array is
allocated and initialized with kcalloc() in tpm2_get_pcr_allocation()).
Zero should not be used as value for unknown mappings, as it is a valid
crypto ID (HASH_ALGO_MD4).

This patch initializes crypto_id to HASH_ALGO__LAST.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm2-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13696deceae8..760329598b99 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -525,6 +525,8 @@ static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
 		return 0;
 	}
 
+	bank->crypto_id = HASH_ALGO__LAST;
+
 	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
 }
 
-- 
2.17.1


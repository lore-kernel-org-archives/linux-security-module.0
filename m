Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466AEC433E4
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244BB206DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594223073;
	bh=ma9ZvKZoF5WtM7bB9wnNI5b3TrDkNcZs7yoCrAsR6v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kMQDm5cZDUx4YGCQDO9/vrytZbdmGeuam7Wv675KKiEanf4uLBjgpeUyPUYGzvcpA
	 OiSmawbKpc5OM1dWn3oJnxNBZ4ddtS8MbK57wjwueqB/Bywk3C03GZRUnottatzXzi
	 yYZb5YBI7qHPVq8p+JV/AP8bVTMQpNQyGzPJyg0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgGHPoc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbgGHPlW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF03207C4;
        Wed,  8 Jul 2020 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222881;
        bh=ma9ZvKZoF5WtM7bB9wnNI5b3TrDkNcZs7yoCrAsR6v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lc7kTyVUhaabkaPq0cp3rdRFkukxeEiq5qTfWRlwgPg2v7XZeltCtzNA94MgIpjjj
         0tVX2x6tj14cO4chyViHQkWT1ZgIlnOE5dEnH3ICeLwy65SZoBT7EwEhN7siK2PsXd
         aYZy5LnT3KyhdjmQ7rOyMBGiShdWTli0gqdoPSRo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Drocco <maurizio.drocco@ibm.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 03/30] ima: extend boot_aggregate with kernel measurements
Date:   Wed,  8 Jul 2020 11:40:49 -0400
Message-Id: <20200708154116.3199728-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154116.3199728-1-sashal@kernel.org>
References: <20200708154116.3199728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Maurizio Drocco <maurizio.drocco@ibm.com>

[ Upstream commit 20c59ce010f84300f6c655d32db2610d3433f85c ]

Registers 8-9 are used to store measurements of the kernel and its
command line (e.g., grub2 bootloader with tpm module enabled). IMA
should include them in the boot aggregate. Registers 8-9 should be
only included in non-SHA1 digests to avoid ambiguity.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
Tested-by: Bruno Meneguele <bmeneg@redhat.com>  (TPM 1.2, TPM 2.0)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 495e28bd488e6..844a55225ede0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -30,7 +30,7 @@
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
-enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
+enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index fb27174806ba4..e0738d1d143d7 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -682,13 +682,26 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 	if (rc != 0)
 		return rc;
 
-	/* cumulative sha1 over tpm registers 0-7 */
+	/* cumulative digest over TPM registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
 		rc = crypto_shash_update(shash, d.digest,
 					 crypto_shash_digestsize(tfm));
 	}
+	/*
+	 * Extend cumulative digest over TPM registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation. Registers 8-9 are only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (alg_id != TPM_ALG_SHA1) {
+		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+			ima_pcrread(i, &d);
+			rc = crypto_shash_update(shash, d.digest,
+						crypto_shash_digestsize(tfm));
+		}
+	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
 	return rc;
-- 
2.25.1


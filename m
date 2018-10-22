Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F8ECDE43
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4044A2083C
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MfgBB49v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4044A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJVPzU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:55:20 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49652 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbeJVPzU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 11:55:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5C9DA8EE0FC;
        Mon, 22 Oct 2018 00:37:59 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P-8npeWKPZWo; Mon, 22 Oct 2018 00:37:59 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B32768EE02B;
        Mon, 22 Oct 2018 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540193879;
        bh=uixT70AYpUKFVZtbVrW8Jp5Bhw+31o3X62lFXZHTEWM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MfgBB49vO2JF4qV+aNJRjK+J0yCZfbJSRQFqKqihv2VFtkfB8o1eae05uHi3HgqVe
         I1jnkwgil75qkkxVgS6AuvuIXH1BGXuPhHvy6xSDMeOP+Zaw0rkI+38xkzyrzlvhmL
         f/pYSMELK2i3PcgNyqeDGKPssHfUoUTXtQmwvHYU=
Message-ID: <1540193875.3202.12.camel@HansenPartnership.com>
Subject: [PATCH v4 4/7] tpm2: add session encryption protection to
 tpm2_get_random()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 08:37:55 +0100
In-Reply-To: <1540193596.3202.7.camel@HansenPartnership.com>
References: <1540193596.3202.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If some entity is snooping the TPM bus, they can see the random
numbers we're extracting from the TPM and do prediction attacks
against their consumers.  Foil this attack by using response
encryption to prevent the attacker from seeing the random sequence.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: add error handling to sessions and redo to be outside loop
---
 drivers/char/tpm/tpm2-cmd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 332b34b347f1..22f1c7bee173 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -266,7 +266,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	return rc;
 }
 
-
 struct tpm2_get_random_out {
 	__be16 size;
 	u8 buffer[TPM_MAX_RNG_DATA];
@@ -293,21 +292,32 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	int total = 0;
 	int retries = 5;
 	u8 *dest_ptr = dest;
+	struct tpm2_auth *auth;
 
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm2_start_auth_session(chip, &auth);
 	if (err)
 		return err;
 
+	err = tpm_buf_init(&buf, 0, 0);
+	if (err) {
+		tpm2_end_auth_session(auth);
+		return err;
+	}
+
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT
+					    | TPM2_SA_CONTINUE_SESSION,
+					    NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
-		err = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
-				       offsetof(struct tpm2_get_random_out,
-						buffer),
+		tpm_buf_fill_hmac_session(&buf, auth);
+		err = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data,
+				       PAGE_SIZE, TPM_HEADER_SIZE + 2,
 				       0, "attempting get random");
+		err = tpm_buf_check_hmac_response(&buf, auth, err);
 		if (err)
 			goto out;
 
@@ -327,6 +337,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	tpm_buf_destroy(&buf);
+	tpm2_end_auth_session(auth);
+
 	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
-- 
2.16.4


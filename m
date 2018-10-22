Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A35ECDE43
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1960120779
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 07:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jim/irJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1960120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJVP4G (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:56:06 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49674 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727638AbeJVP4F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 11:56:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E36078EE0FC;
        Mon, 22 Oct 2018 00:38:44 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GSKk2UYd-sE2; Mon, 22 Oct 2018 00:38:44 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 30BF38EE02B;
        Mon, 22 Oct 2018 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540193924;
        bh=J1VvdFIUMuHdOSYL9ku2HolnIldDscnVSitYJIYDsZg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jim/irJT99m2BofXjOsyLvyUvx1orBkN83biWhmRBXl4CHdrBC8ZAaJ0gzt7b9D6e
         +K2vWdPJCiNRlSBP5xdM5+3xcIfyZLo/JgsZePIlgV0f+d6wA07kIMsm+liy0A8V7T
         U3odZLPGRk2BRIqRlp58KaW8X8pmOZ4hzr45OkcY=
Message-ID: <1540193921.3202.13.camel@HansenPartnership.com>
Subject: [PATCH v4 5/7] trusted keys: Add session encryption protection to
 the seal/unseal path
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 08:38:41 +0100
In-Reply-To: <1540193596.3202.7.camel@HansenPartnership.com>
References: <1540193596.3202.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If some entity is snooping the TPM bus, the can see the data going in
to be sealed and the data coming out as it is unsealed.  Add parameter
and response encryption to these cases to ensure that no secrets are
leaked even if the bus is snooped.

As part of doing this conversion it was discovered that policy
sessions can't work with HMAC protected authority because of missing
pieces (the tpm Nonce).  I've added code to work the same way as
before, which will result in potential authority exposure (while still
adding security for the command and the returned blob), and a fixme to
redo the API to get rid of this security hole.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 155 ++++++++++++++++++++++++++++----------------
 1 file changed, 98 insertions(+), 57 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 22f1c7bee173..a8655cd535d1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -425,7 +425,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 {
 	unsigned int blob_len;
 	struct tpm_buf buf;
+	struct tpm_buf t2b;
 	u32 hash;
+	struct tpm2_auth *auth;
 	int i;
 	int rc;
 
@@ -439,45 +441,56 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
+
+	rc = tpm_buf_init_2b(&t2b);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
 
+	tpm_buf_append_name(&buf, auth, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_DECRYPT,
+				    options->keyauth, TPM_DIGEST_SIZE);
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+	tpm_buf_append_u16(&t2b, TPM_DIGEST_SIZE);
+	tpm_buf_append(&t2b, options->blobauth, TPM_DIGEST_SIZE);
+	tpm_buf_append_u16(&t2b, payload->key_len + 1);
+	tpm_buf_append(&t2b, payload->key, payload->key_len);
+	tpm_buf_append_u8(&t2b, payload->migratable);
 
-	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
-	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
-	tpm_buf_append_u16(&buf, payload->key_len + 1);
-	tpm_buf_append(&buf, payload->key, payload->key_len);
-	tpm_buf_append_u8(&buf, payload->migratable);
+	tpm_buf_append_2b(&buf, &t2b);
 
 	/* public */
-	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM2_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&buf, hash);
+	tpm_buf_append_u16(&t2b, TPM2_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&t2b, hash);
 
 	/* policy */
 	if (options->policydigest_len) {
-		tpm_buf_append_u32(&buf, 0);
-		tpm_buf_append_u16(&buf, options->policydigest_len);
-		tpm_buf_append(&buf, options->policydigest,
+		tpm_buf_append_u32(&t2b, 0);
+		tpm_buf_append_u16(&t2b, options->policydigest_len);
+		tpm_buf_append(&t2b, options->policydigest,
 			       options->policydigest_len);
 	} else {
-		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
-		tpm_buf_append_u16(&buf, 0);
+		tpm_buf_append_u32(&t2b, TPM2_OA_USER_WITH_AUTH);
+		tpm_buf_append_u16(&t2b, 0);
 	}
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM2_ALG_NULL);
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(&t2b, TPM2_ALG_NULL);
+	/* unique (zero) */
+	tpm_buf_append_u16(&t2b, 0);
+
+	tpm_buf_append_2b(&buf, &t2b);
 
 	/* outside info */
 	tpm_buf_append_u16(&buf, 0);
@@ -490,8 +503,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 4, 0,
-			      "sealing data");
+	tpm_buf_fill_hmac_session(&buf, auth);
+
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data,
+			      PAGE_SIZE, 4, 0, "sealing data");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (rc)
 		goto out;
 
@@ -509,6 +525,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	payload->blob_len = blob_len;
 
 out:
+	tpm_buf_destroy(&t2b);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0) {
@@ -528,7 +545,6 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
  * @payload: the key data in clear and encrypted form
  * @options: authentication values and other options
  * @blob_handle: returned blob handle
- * @flags: tpm transmit flags
  *
  * Return: 0 on success.
  *        -E2BIG on wrong payload size.
@@ -538,9 +554,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_payload *payload,
 			 struct trusted_key_options *options,
-			 u32 *blob_handle, unsigned int flags)
+			 u32 *blob_handle)
 {
 	struct tpm_buf buf;
+	struct tpm2_auth *auth;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
@@ -555,17 +572,18 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
 
+	tpm_buf_append_name(&buf, auth, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, 0, options->keyauth, TPM_DIGEST_SIZE);
 	tpm_buf_append(&buf, payload->blob, blob_len);
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
@@ -573,8 +591,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 4, flags,
-			      "loading blob");
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      4, 0, "loading blob");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -595,7 +615,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
  * @payload: the key data in clear and encrypted form
  * @options: authentication values and other options
  * @blob_handle: blob handle
- * @flags: tpm_transmit_cmd flags
  *
  * Return: 0 on success
  *         -EPERM on tpm error status
@@ -604,28 +623,54 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u32 blob_handle, unsigned int flags)
+			   u32 blob_handle)
 {
 	struct tpm_buf buf;
+	struct tpm2_auth *auth;
 	u16 data_len;
 	u8 *data;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, blob_handle);
-	tpm2_buf_append_auth(&buf,
-			     options->policyhandle ?
-			     options->policyhandle : TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     TPM2_SA_CONTINUE_SESSION,
-			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
-
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 6, flags,
-			      "unsealing");
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
+
+	tpm_buf_append_name(&buf, auth, blob_handle, NULL);
+
+	if (!options->policyhandle) {
+		tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT,
+					    options->blobauth, TPM_DIGEST_SIZE);
+	} else {
+		/*
+		 * FIXME: the policy can't be used for HMAC protection
+		 * of the authorization because it must be generated
+		 * with the initial nonces which isn't passed in, so
+		 * append a second encryption session to at least HMAC
+		 * protect the command and encrypt the sealed blob on
+		 * return so the only thing the attacker can get is
+		 * the password.
+		 *
+		 * We also consume the policy session otherwise it
+		 * would be absorbed into the kernel space.
+		 */
+		tpm2_buf_append_auth(&buf, options->policyhandle,
+				     NULL /* nonce */, 0, 0,
+				     options->blobauth /* hmac */,
+				     TPM_DIGEST_SIZE);
+		tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT,
+					    NULL, 0);
+	}
+
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      6, 0, "unsealing");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (rc > 0)
 		rc = -EPERM;
 
@@ -669,17 +714,13 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	u32 blob_handle;
 	int rc;
 
-	mutex_lock(&chip->tpm_mutex);
-	rc = tpm2_load_cmd(chip, payload, options, &blob_handle,
-			   TPM_TRANSMIT_UNLOCKED);
+	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
 	if (rc)
 		goto out;
 
-	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle,
-			     TPM_TRANSMIT_UNLOCKED);
-	tpm2_flush_context_cmd(chip, blob_handle, TPM_TRANSMIT_UNLOCKED);
+	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
+	tpm2_flush_context_cmd(chip, blob_handle, 0);
 out:
-	mutex_unlock(&chip->tpm_mutex);
 	return rc;
 }
 
-- 
2.16.4


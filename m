From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 10 Mar 2018 14:19:20 -0800
Subject: [PATCH v3 5/6] trusted keys: Add session encryption protection to
	the seal/unseal path
In-Reply-To: <1520720026.4495.11.camel@HansenPartnership.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
Message-ID: <1520720360.4495.18.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

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
 drivers/char/tpm/tpm2-cmd.c | 156 ++++++++++++++++++++++++++++----------------
 1 file changed, 98 insertions(+), 58 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 47395c455ae1..8b164b7347de 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -463,8 +463,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_options *options)
 {
 	unsigned int blob_len;
-	struct tpm_buf buf;
+	struct tpm_buf buf, t2b;
 	u32 hash, rlength;
+	struct tpm2_auth *auth;
 	int i;
 	int rc;
 
@@ -478,45 +479,56 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
 
+	rc = tpm_buf_init_2b(&t2b);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
+
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
@@ -529,8 +541,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
 
@@ -549,6 +564,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	payload->blob_len = blob_len;
 
 out:
+	tpm_buf_destroy(&t2b);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0) {
@@ -568,7 +584,6 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
  * @payload: the key data in clear and encrypted form
  * @options: authentication values and other options
  * @blob_handle: returned blob handle
- * @flags: tpm transmit flags
  *
  * Return: 0 on success.
  *        -E2BIG on wrong payload size.
@@ -578,9 +593,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -595,17 +611,18 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
@@ -613,8 +630,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
@@ -635,7 +654,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
  * @payload: the key data in clear and encrypted form
  * @options: authentication values and other options
  * @blob_handle: blob handle
- * @flags: tpm_transmit_cmd flags
  *
  * Return: 0 on success
  *         -EPERM on tpm error status
@@ -644,29 +662,55 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
 	u32 rlength;
 
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
 
@@ -712,17 +756,13 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
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
2.12.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

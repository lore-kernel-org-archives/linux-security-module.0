From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 07 Mar 2018 15:32:18 -0800
Subject: [RFC v2 3/5] tpm2: add hmac checks to tpm2_pcr_extend()
In-Reply-To: <1520465374.4894.12.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
Message-ID: <1520465538.4894.15.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We use tpm2_pcr_extend() in trusted keys to extend a PCR to prevent a
key from being re-loaded until the next reboot.  To use this
functionality securely, that extend must be protected by a session
hmac.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 2042d4008b9c..a56cdd5d55ff 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -247,13 +247,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 	return rc;
 }
 
-struct tpm2_null_auth_area {
-	__be32  handle;
-	__be16  nonce_size;
-	u8  attributes;
-	__be16  auth_size;
-} __packed;
-
 /**
  * tpm2_pcr_extend() - extend a PCR value
  *
@@ -268,7 +261,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 		    struct tpm2_digest *digests)
 {
 	struct tpm_buf buf;
-	struct tpm2_null_auth_area auth_area;
+	struct tpm2_auth *auth;
 	int rc;
 	int i;
 	int j;
@@ -276,20 +269,17 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	if (count > ARRAY_SIZE(chip->active_banks))
 		return -EINVAL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
+	if (rc)
+		return rc;
 
-	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
-	auth_area.nonce_size = 0;
-	auth_area.attributes = 0;
-	auth_area.auth_size = 0;
+	tpm_buf_append_name(&buf, auth, pcr_idx, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, 0, NULL, 0);
 
-	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
-	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
-		       sizeof(auth_area));
 	tpm_buf_append_u32(&buf, count);
 
 	for (i = 0; i < count; i++) {
@@ -302,9 +292,10 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 			       hash_digest_size[tpm2_hash_map[j].crypto_id]);
 		}
 	}
-
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
-			      "attempting extend a PCR value");
+	tpm_buf_fill_hmac_session(&buf, auth);
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      0, 0, "attempting extend a PCR value");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 
 	tpm_buf_destroy(&buf);
 
-- 
2.12.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

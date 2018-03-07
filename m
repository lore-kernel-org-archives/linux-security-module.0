From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 07 Mar 2018 15:33:06 -0800
Subject: [RFC v2 4/5] tpm2: add session encryption protection to
	tpm2_get_random()
In-Reply-To: <1520465374.4894.12.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
Message-ID: <1520465586.4894.16.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If some entity is snooping the TPM bus, they can see the random
numbers we're extracting from the TPM and do prediction attacks
against their consumers.  Foil this attack by using response
encryption to prevent the attacker from seeing the random sequence.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 76 +++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a56cdd5d55ff..ad2a7e72bacf 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -38,10 +38,6 @@ struct tpm2_get_tpm_pt_out {
 	__be32	value;
 } __packed;
 
-struct tpm2_get_random_in {
-	__be16	size;
-} __packed;
-
 struct tpm2_get_random_out {
 	__be16	size;
 	u8	buffer[TPM_MAX_RNG_DATA];
@@ -51,8 +47,6 @@ union tpm2_cmd_params {
 	struct	tpm2_startup_in		startup_in;
 	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
 	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
-	struct	tpm2_get_random_in	getrandom_in;
-	struct	tpm2_get_random_out	getrandom_out;
 };
 
 struct tpm2_cmd {
@@ -302,17 +296,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	return rc;
 }
 
-
-#define TPM2_GETRANDOM_IN_SIZE \
-	(sizeof(struct tpm_input_header) + \
-	 sizeof(struct tpm2_get_random_in))
-
-static const struct tpm_input_header tpm2_getrandom_header = {
-	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
-	.length = cpu_to_be32(TPM2_GETRANDOM_IN_SIZE),
-	.ordinal = cpu_to_be32(TPM2_CC_GET_RANDOM)
-};
-
 /**
  * tpm2_get_random() - get random bytes from the TPM RNG
  *
@@ -325,42 +308,53 @@ static const struct tpm_input_header tpm2_getrandom_header = {
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
-	struct tpm2_cmd cmd;
-	u32 recd, rlength;
+	u32 recd;
 	u32 num_bytes;
 	int err;
 	int total = 0;
 	int retries = 5;
 	u8 *dest = out;
+	struct tpm_buf buf;
+	struct tpm2_get_random_out *rout;
+	struct tpm2_auth *auth;
 
-	num_bytes = min_t(u32, max, sizeof(cmd.params.getrandom_out.buffer));
+	num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA);
 
-	if (!out || !num_bytes ||
-	    max > sizeof(cmd.params.getrandom_out.buffer))
+	if (!out || !num_bytes
+	    || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
 	do {
-		cmd.header.in = tpm2_getrandom_header;
-		cmd.params.getrandom_in.size = cpu_to_be16(num_bytes);
-
-		err = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd),
-				       offsetof(struct tpm2_get_random_out,
-						buffer),
-				       0, "attempting get random");
+		err = tpm2_start_auth_session(chip, &auth);
 		if (err)
 			break;
-
-		recd = min_t(u32, be16_to_cpu(cmd.params.getrandom_out.size),
-			     num_bytes);
-		rlength = be32_to_cpu(cmd.header.out.length);
-		if (rlength < offsetof(struct tpm2_get_random_out, buffer) +
-			      recd)
-			return -EFAULT;
-		memcpy(dest, cmd.params.getrandom_out.buffer, recd);
-
-		dest += recd;
-		total += recd;
-		num_bytes -= recd;
+		tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT,
+					    NULL, 0);
+		tpm_buf_append_u16(&buf, num_bytes);
+		tpm_buf_fill_hmac_session(&buf, auth);
+		err = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data,
+				       PAGE_SIZE, TPM_HEADER_SIZE + 2,
+				       0, "attempting get random");
+		err = tpm_buf_check_hmac_response(&buf, auth, err);
+		if (!err) {
+			rout = (struct tpm2_get_random_out *)&buf.data[TPM_HEADER_SIZE + 4];
+			recd = be16_to_cpu(rout->size);
+			recd = min_t(u32, recd, num_bytes);
+			if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4
+			    + 2 + recd) {
+				total = -EFAULT;
+			} else {
+				memcpy(dest, rout->buffer, recd);
+
+				dest += recd;
+				total += recd;
+				num_bytes -= recd;
+			}
+		}
+		tpm_buf_destroy(&buf);
+		if (err || total < 0)
+			break;
 	} while (retries-- && total < max);
 
 	return total ? total : -EIO;
-- 
2.12.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

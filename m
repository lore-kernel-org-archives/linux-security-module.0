From: tomas.winkler@intel.com (Tomas Winkler)
Date: Sat, 10 Mar 2018 10:24:23 +0200
Subject: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
In-Reply-To: <20180310082428.31519-1-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
Message-ID: <20180310082428.31519-4-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Factor out get random implementation from tpm-interface.c
into tpm1_get_random function in tpm1-cmd.c.
No functional changes.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 56 ++++------------------------------------
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm1-cmd.c      | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 6b70cefed505..59ca2e30b4d2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -707,14 +707,6 @@ int tpm_pm_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
-#define TPM_ORD_GET_RANDOM 70
-#define TPM_GETRANDOM_RESULT_SIZE	18
-static const struct tpm_input_header tpm_getrandom_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(14),
-	.ordinal = cpu_to_be32(TPM_ORD_GET_RANDOM)
-};
-
 /**
  * tpm_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
@@ -725,57 +717,19 @@ static const struct tpm_input_header tpm_getrandom_header = {
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
-	struct tpm_cmd_t tpm_cmd;
-	u32 recd, num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA), rlength;
-	int err, total = 0, retries = 5;
-	u8 *dest = out;
-
-	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
-		return -EINVAL;
+	int err;
 
 	chip = tpm_chip_find_get(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		err = tpm2_get_random(chip, out, max);
-		tpm_put_ops(chip);
-		return err;
-	}
-
-	do {
-		tpm_cmd.header.in = tpm_getrandom_header;
-		tpm_cmd.params.getrandom_in.num_bytes = cpu_to_be32(num_bytes);
-
-		err = tpm_transmit_cmd(chip, NULL, &tpm_cmd,
-				       TPM_GETRANDOM_RESULT_SIZE + num_bytes,
-				       offsetof(struct tpm_getrandom_out,
-						rng_data),
-				       0, "attempting get random");
-		if (err)
-			break;
-
-		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
-		if (recd > num_bytes) {
-			total = -EFAULT;
-			break;
-		}
-
-		rlength = be32_to_cpu(tpm_cmd.header.out.length);
-		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
-			      recd) {
-			total = -EFAULT;
-			break;
-		}
-		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
-
-		dest += recd;
-		total += recd;
-		num_bytes -= recd;
-	} while (retries-- && total < max);
+	else
+		err = tpm1_get_random(chip, out, max);
 
 	tpm_put_ops(chip);
-	return total ? total : -EIO;
+	return err;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1a8ef4d3cb1c..b5fe0269a833 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -537,6 +537,8 @@ int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 		    const char *log_msg);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
+int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
+
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 903352542192..5b310cf26a56 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -472,3 +472,57 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
+
+#define TPM_ORD_GET_RANDOM 70
+#define TPM_GETRANDOM_RESULT_SIZE	18
+static const struct tpm_input_header tpm_getrandom_header = {
+	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
+	.length = cpu_to_be32(14),
+	.ordinal = cpu_to_be32(TPM_ORD_GET_RANDOM)
+};
+
+int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+{
+	struct tpm_cmd_t tpm_cmd;
+	u32 recd;
+	u32 num_bytes = min_t(u32, max, TPM_MAX_RNG_DATA);
+	u32 rlength;
+	int err, total = 0, retries = 5;
+	u8 *dest = out;
+
+	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
+		return -EINVAL;
+
+	do {
+		tpm_cmd.header.in = tpm_getrandom_header;
+		tpm_cmd.params.getrandom_in.num_bytes = cpu_to_be32(num_bytes);
+
+		err = tpm_transmit_cmd(chip, NULL, &tpm_cmd,
+				       TPM_GETRANDOM_RESULT_SIZE + num_bytes,
+				       offsetof(struct tpm_getrandom_out,
+						rng_data),
+				       0, "attempting get random");
+		if (err)
+			break;
+
+		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		if (recd > num_bytes) {
+			total = -EFAULT;
+			break;
+		}
+
+		rlength = be32_to_cpu(tpm_cmd.header.out.length);
+		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
+			      recd) {
+			total = -EFAULT;
+			break;
+		}
+		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data, recd);
+
+		dest += recd;
+		total += recd;
+		num_bytes -= recd;
+	} while (retries-- && total < max);
+
+	return total ? total : -EIO;
+}
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

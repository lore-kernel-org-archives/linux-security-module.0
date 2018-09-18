From: tomas.winkler@intel.com (Tomas Winkler)
Date: Tue, 18 Sep 2018 12:34:57 +0300
Subject: [PATCH v3 18/20] tpm: use u32 instead of int for pcr index
In-Reply-To: <20180918093459.19165-1-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
Message-ID: <20180918093459.19165-19-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

TPM pcr indices cannot be negative, also the tpm
commands accept u32 number as a pcr index.

1. Adjust the API to use u32 instead of int in all pcr related
functions.
2. Rename tpm1_pcr_read_dev to tpm1_pcr_read() to match
the counterpart tpm2_pcr_read()
3. Remove redundant constants in tpm1_pcr_extend() function.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: new in the series
 drivers/char/tpm/tpm-interface.c    |  4 ++--
 drivers/char/tpm/tpm-sysfs.c        |  4 ++--
 drivers/char/tpm/tpm.h              | 10 +++++-----
 drivers/char/tpm/tpm1-cmd.c         | 14 ++++++--------
 drivers/char/tpm/tpm2-cmd.c         |  6 +++---
 include/linux/tpm.h                 |  2 +-
 security/integrity/ima/ima_crypto.c |  5 +++--
 7 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e3206874be22..0eea784e1ae4 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -444,7 +444,7 @@ EXPORT_SYMBOL_GPL(tpm_is_tpm2);
  *
  * Return: same as with tpm_transmit_cmd()
  */
-int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	int rc;
 
@@ -455,7 +455,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_pcr_read(chip, pcr_idx, res_buf);
 	else
-		rc = tpm1_pcr_read_dev(chip, pcr_idx, res_buf);
+		rc = tpm1_pcr_read(chip, pcr_idx, res_buf);
 
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 861acafd8f29..b88e08ec2c59 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -102,7 +102,7 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 	cap_t cap;
 	u8 digest[TPM_DIGEST_SIZE];
 	ssize_t rc;
-	int i, j, num_pcrs;
+	u32 i, j, num_pcrs;
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 
@@ -114,7 +114,7 @@ static ssize_t pcrs_show(struct device *dev, struct device_attribute *attr,
 
 	num_pcrs = be32_to_cpu(cap.num_pcrs);
 	for (i = 0; i < num_pcrs; i++) {
-		rc = tpm1_pcr_read_dev(chip, i, digest);
+		rc = tpm1_pcr_read(chip, i, digest);
 		if (rc)
 			break;
 		str += sprintf(str, "PCR-%02d: ", i);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index d0402aa122ec..dbbfb7118c31 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -518,14 +518,14 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 int tpm_get_timeouts(struct tpm_chip *);
 int tpm_auto_startup(struct tpm_chip *chip);
 
-int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
+int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr);
 int tpm1_do_selftest(struct tpm_chip *chip);
 int tpm1_auto_startup(struct tpm_chip *chip);
 int tpm1_get_timeouts(struct tpm_chip *chip);
 unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
-int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg);
-int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
+int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
@@ -567,8 +567,8 @@ static inline u32 tpm2_rc_value(u32 rc)
 }
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
-int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index e81641f9d0e3..777b1158e1b5 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -449,9 +449,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 }
 
 #define TPM_ORD_PCR_EXTEND 20
-#define EXTEND_PCR_RESULT_SIZE 34
-#define EXTEND_PCR_RESULT_BODY_SIZE 20
-int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
+int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
 	struct tpm_buf buf;
@@ -464,8 +462,8 @@ int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 	tpm_buf_append_u32(&buf, pcr_idx);
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
-			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
+	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
+			      TPM_DIGEST_SIZE, 0, log_msg);
 
 	tpm_buf_destroy(&buf);
 	return rc;
@@ -575,7 +573,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 }
 
 #define TPM_ORD_PCRREAD 21
-int tpm1_pcr_read_dev(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	struct tpm_buf buf;
 	int rc;
@@ -663,7 +661,7 @@ int tpm1_do_selftest(struct tpm_chip *chip)
 
 	do {
 		/* Attempt to read a PCR value */
-		rc = tpm1_pcr_read_dev(chip, 0, dummy);
+		rc = tpm1_pcr_read(chip, 0, dummy);
 
 		/* Some buggy TPMs will not respond to tpm_tis_ready() for
 		 * around 300ms while the self test is ongoing, keep trying
@@ -732,7 +730,7 @@ static const struct tpm_input_header savestate_header = {
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
  */
-int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
+int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
 	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
 	struct tpm_cmd_t cmd;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index b0b714309440..c2f297140dc7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -128,7 +128,7 @@ struct tpm2_pcr_read_out {
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
+int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	int rc;
 	struct tpm_buf buf;
@@ -178,7 +178,7 @@ struct tpm2_null_auth_area {
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-static int __tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
+static int __tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, u32 count,
 			     struct tpm2_digest *digests)
 {
 	struct tpm_buf buf;
@@ -225,7 +225,7 @@ static int __tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	return rc;
 }
 
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
+int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
 {
 	int rc;
 	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..44c13cdf720a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -53,7 +53,7 @@ struct tpm_class_ops {
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
-extern int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
+int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 extern int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7e7e7e7c250a..959d9edc113a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -629,7 +629,7 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 	return calc_buffer_shash(buf, len, hash);
 }
 
-static void __init ima_pcrread(int idx, u8 *pcr)
+static void __init ima_pcrread(u32 idx, u8 *pcr)
 {
 	if (!ima_tpm_chip)
 		return;
@@ -645,7 +645,8 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 					      struct crypto_shash *tfm)
 {
 	u8 pcr_i[TPM_DIGEST_SIZE];
-	int rc, i;
+	int rc;
+	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
 
 	shash->tfm = tfm;
-- 
2.14.4

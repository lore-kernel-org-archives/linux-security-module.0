From: tomas.winkler@intel.com (Tomas Winkler)
Date: Fri, 21 Sep 2018 16:58:11 +0300
Subject: [PATCH v4 12/21] tpm: move pcr extend code to tpm2-cmd.c
In-Reply-To: <20180921135820.20549-1-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
Message-ID: <20180921135820.20549-13-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
by tpm-interface.c. It wraps the original open code
implementation. The original original tpm2_pcr_extend() function
is renamed to __tpm2_pcr_extend() and made static, it is called
only from new tpm2_pcr_extend().

Fix warnings in __tpm2_pcr_extend()
tpm2-cmd.c:251:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
tpm2-cmd.c:252:17: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V3: Fix the commit message.
V4: 1. Fix the kdoc.
    2. Fix the commit message.
    3. Fix compilation warnings.

 drivers/char/tpm/tpm-interface.c | 24 +++++----------------
 drivers/char/tpm/tpm.h           |  3 +--
 drivers/char/tpm/tpm2-cmd.c      | 46 ++++++++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 686b5316dad5..d18d9103a867 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -491,31 +491,17 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
-	u32 count = 0;
-	int i;
 
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		memset(digest_list, 0, sizeof(digest_list));
-
-		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
-			digest_list[i].alg_id = chip->active_banks[i];
-			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
-			count++;
-		}
-
-		rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
-		tpm_put_ops(chip);
-		return rc;
-	}
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		rc = tpm2_pcr_extend(chip, pcr_idx, hash);
+	else
+		rc = tpm1_pcr_extend(chip, pcr_idx, hash,
+				     "attempting extend a PCR value");
 
-	rc = tpm1_pcr_extend(chip, pcr_idx, hash,
-			     "attempting extend a PCR value");
 	tpm_put_ops(chip);
 	return rc;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index fa88102a0cab..f0963a0a8acd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -592,8 +592,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 
 int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 8da5a16e7c8c..728fa08c5531 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -211,23 +211,22 @@ struct tpm2_null_auth_area {
 } __packed;
 
 /**
- * tpm2_pcr_extend() - extend a PCR value
+ * __tpm2_pcr_extend() - extend a PCR value
  *
- * @chip:	TPM chip to use.
- * @pcr_idx:	index of the PCR.
- * @count:	number of digests passed.
- * @digests:	list of pcr banks and corresponding digest values to extend.
+ * @chip:       TPM chip to use.
+ * @pcr_idx:    index of the PCR.
+ * @count:      number of digests passed.
+ * @digests:    list of pcr banks and corresponding digest values to extend.
  *
  * Return: Same as with tpm_transmit_cmd.
  */
-int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+static int __tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
+			     struct tpm2_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
+	u32 i, j;
 	int rc;
-	int i;
-	int j;
 
 	if (count > ARRAY_SIZE(chip->active_banks))
 		return -EINVAL;
@@ -267,6 +266,35 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
 	return rc;
 }
 
+/**
+ * tpm2_pcr_extend() - extend a PCR value
+ *
+ * @chip:       TPM chip to use.
+ * @pcr_idx:    index of the PCR to extend.
+ * @hash:       the hash of a measurement.
+ *
+ * Return: Same as with tpm_transmit_cmd.
+ */
+int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
+{
+	int rc;
+	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
+	u32 count = 0;
+	unsigned int i;
+
+	memset(digest_list, 0, sizeof(digest_list));
+	for (i = 0; i < ARRAY_SIZE(chip->active_banks); i++) {
+		if (chip->active_banks[i] == TPM2_ALG_ERROR)
+			break;
+		digest_list[i].alg_id = chip->active_banks[i];
+		memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
+		count++;
+	}
+
+	rc = __tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
+	return rc;
+}
+
 
 struct tpm2_get_random_out {
 	__be16 size;
-- 
2.14.4

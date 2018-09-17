From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Mon, 17 Sep 2018 11:38:18 +0200
Subject: [PATCH v2,
	RESEND 1/3] tpm: rename and export tpm2_digest and tpm2_algorithms
In-Reply-To: <20180917093820.20500-1-roberto.sassu@huawei.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
Message-ID: <20180917093820.20500-2-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rename tpm2_* to tpm_* and move the definitions to include/linux/tpm.h so
that these can be used by other kernel subsystems (e.g. IMA).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm-interface.c |  4 ++--
 drivers/char/tpm/tpm.h           | 13 +------------
 drivers/char/tpm/tpm2-cmd.c      | 20 ++++++++++----------
 include/linux/tpm.h              | 18 ++++++++++++++++++
 include/linux/tpm_eventlog.h     |  9 ++-------
 5 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1a803b0cf980..645c9aa7677a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1039,7 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 {
 	int rc;
-	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
+	struct tpm_digest digest_list[ARRAY_SIZE(chip->active_banks)];
 	u32 count = 0;
 	int i;
 
@@ -1051,7 +1051,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 		memset(digest_list, 0, sizeof(digest_list));
 
 		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
+			    chip->active_banks[i] != TPM_ALG_ERROR; i++) {
 			digest_list[i].alg_id = chip->active_banks[i];
 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
 			count++;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f3501d05264f..b928ba44d864 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -122,17 +122,6 @@ enum tpm2_return_codes {
 	TPM2_RC_RETRY		= 0x0922,
 };
 
-enum tpm2_algorithms {
-	TPM2_ALG_ERROR		= 0x0000,
-	TPM2_ALG_SHA1		= 0x0004,
-	TPM2_ALG_KEYEDHASH	= 0x0008,
-	TPM2_ALG_SHA256		= 0x000B,
-	TPM2_ALG_SHA384		= 0x000C,
-	TPM2_ALG_SHA512		= 0x000D,
-	TPM2_ALG_NULL		= 0x0010,
-	TPM2_ALG_SM3_256	= 0x0012,
-};
-
 enum tpm2_command_codes {
 	TPM2_CC_FIRST		= 0x011F,
 	TPM2_CC_CREATE_PRIMARY  = 0x0131,
@@ -577,7 +566,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 
 int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests);
+		    struct tpm_digest *digests);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
 			    unsigned int flags);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c31b490bd41d..2d7397b8a0d1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -33,11 +33,11 @@ struct tpm2_hash {
 };
 
 static struct tpm2_hash tpm2_hash_map[] = {
-	{HASH_ALGO_SHA1, TPM2_ALG_SHA1},
-	{HASH_ALGO_SHA256, TPM2_ALG_SHA256},
-	{HASH_ALGO_SHA384, TPM2_ALG_SHA384},
-	{HASH_ALGO_SHA512, TPM2_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM2_ALG_SM3_256},
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
 /*
@@ -200,7 +200,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
 	tpm_buf_append_u32(&buf, 1);
-	tpm_buf_append_u16(&buf, TPM2_ALG_SHA1);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA1);
 	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
 	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
@@ -234,7 +234,7 @@ struct tpm2_null_auth_area {
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
-		    struct tpm2_digest *digests)
+		    struct tpm_digest *digests)
 {
 	struct tpm_buf buf;
 	struct tpm2_null_auth_area auth_area;
@@ -457,7 +457,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	/* public */
 	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM2_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
 	tpm_buf_append_u16(&buf, hash);
 
 	/* policy */
@@ -472,7 +472,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	}
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM2_ALG_NULL);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
 	tpm_buf_append_u16(&buf, 0);
 
 	/* outside info */
@@ -909,7 +909,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
 out:
 	if (i < ARRAY_SIZE(chip->active_banks))
-		chip->active_banks[i] = TPM2_ALG_ERROR;
+		chip->active_banks[i] = TPM_ALG_ERROR;
 
 	tpm_buf_destroy(&buf);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..71d7bbf5f690 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,12 +22,30 @@
 #ifndef __LINUX_TPM_H__
 #define __LINUX_TPM_H__
 
+#include <crypto/hash_info.h>
+
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+};
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[SHA512_DIGEST_SIZE];
+} __packed;
+
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 20d9da77fc11..1481186749f0 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,7 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <crypto/hash_info.h>
+#include <linux/tpm.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
@@ -108,16 +108,11 @@ struct tcg_event_field {
 	u8 event[0];
 } __packed;
 
-struct tpm2_digest {
-	u16 alg_id;
-	u8 digest[SHA512_DIGEST_SIZE];
-} __packed;
-
 struct tcg_pcr_event2 {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
+	struct tpm_digest digests[TPM2_ACTIVE_PCR_BANKS];
 	struct tcg_event_field event;
 } __packed;
 
-- 
2.14.1

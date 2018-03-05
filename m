From: tomas.winkler@intel.com (Tomas Winkler)
Date: Mon,  5 Mar 2018 22:20:17 +0200
Subject: [PATCH 6/6] tpm: tpm-interface: drop unused tpm_input_header headers.
In-Reply-To: <20180305202017.24008-1-tomas.winkler@intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
Message-ID: <20180305202017.24008-7-tomas.winkler@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

PRC extend and get capability were reimplemented using
tpm_buf_ interface and the dangling tpm_input_headers can be dropped.
together with now unused constants.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7f6968b750c8..ebf52b48d727 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -355,16 +355,7 @@ int tpm_startup(struct tpm_chip *chip)
 }
 
 #define TPM_DIGEST_SIZE 20
-#define TPM_RET_CODE_IDX 6
-#define TPM_INTERNAL_RESULT_SIZE 200
 #define TPM_ORD_GET_CAP 101
-#define TPM_ORD_GET_RANDOM 70
-
-static const struct tpm_input_header tpm_getcap_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(22),
-	.ordinal = cpu_to_be32(TPM_ORD_GET_CAP)
-};
 
 ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		   const char *desc, size_t min_cap_length)
@@ -517,12 +508,6 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
 #define TPM_ORD_PCR_EXTEND 20
 #define EXTEND_PCR_RESULT_SIZE 34
 #define EXTEND_PCR_RESULT_BODY_SIZE 20
-static const struct tpm_input_header pcrextend_header = {
-	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
-	.length = cpu_to_be32(34),
-	.ordinal = cpu_to_be32(TPM_ORD_PCR_EXTEND)
-};
-
 static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
 			   char *log_msg)
 {
@@ -782,6 +767,7 @@ int tpm_pm_resume(struct device *dev)
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
 #define TPM_GETRANDOM_RESULT_SIZE	18
+#define TPM_ORD_GET_RANDOM 70
 static const struct tpm_input_header tpm_getrandom_header = {
 	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
 	.length = cpu_to_be32(14),
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

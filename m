From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Mon,  2 Jul 2018 11:24:49 -0400
Subject: [PATCH] ima: Use tpm_default_chip() and call TPM functions with a
	tpm_chip
Message-ID: <20180702152449.3219288-1-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rather than accessing the TPM functions by passing a NULL pointer for
the tpm_chip, which causes a lookup for a suitable chip every time, get a
hold of a tpm_chip and access the TPM functions using it. Also get rid of
the ima_used_chip variable and use the new ima_tpm_chip variable instead
for determining whether to call TPM functions.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c |  4 ++--
 security/integrity/ima/ima_init.c   | 16 +++++-----------
 security/integrity/ima/ima_queue.c  |  4 ++--
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..2ab1affffa36 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,9 +53,9 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 extern int ima_policy_flag;
 
 /* set during initialization */
-extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
+extern struct tpm_chip *ima_tpm_chip;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4e085a17124f..7e7e7e7c250a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -631,10 +631,10 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		return;
 
-	if (tpm_pcr_read(NULL, idx, pcr) != 0)
+	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..faac9ecaa0ae 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -26,7 +26,7 @@
 
 /* name for boot aggregate entry */
 static const char *boot_aggregate_name = "boot_aggregate";
-int ima_used_chip;
+struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -64,7 +64,7 @@ static int __init ima_add_boot_aggregate(void)
 	iint->ima_hash->algo = HASH_ALGO_SHA1;
 	iint->ima_hash->length = SHA1_DIGEST_SIZE;
 
-	if (ima_used_chip) {
+	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
@@ -106,17 +106,11 @@ void __init ima_load_x509(void)
 
 int __init ima_init(void)
 {
-	u8 pcr_i[TPM_DIGEST_SIZE];
 	int rc;
 
-	ima_used_chip = 0;
-	rc = tpm_pcr_read(NULL, 0, pcr_i);
-	if (rc == 0)
-		ima_used_chip = 1;
-
-	if (!ima_used_chip)
-		pr_info("No TPM chip found, activating TPM-bypass! (rc=%d)\n",
-			rc);
+	ima_tpm_chip = tpm_default_chip();
+	if (!ima_tpm_chip)
+		pr_info("No TPM chip found, activating TPM-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 418f35e38015..b186819bd5aa 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -142,10 +142,10 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
 
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		return result;
 
-	result = tpm_pcr_extend(NULL, pcr, hash);
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	return result;
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

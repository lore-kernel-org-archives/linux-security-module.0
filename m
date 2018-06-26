From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 26 Jun 2018 07:06:18 -0400
Subject: [PATCH v5 4/5] ima: Use tpm_default_chip() and call TPM functions
	with a tpm_chip
In-Reply-To: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
Message-ID: <20180626110619.2362791-5-stefanb@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rather than accessing the TPM functions by passing a NULL pointer for
the tpm_chip, which causes a lookup for a suitable chip every time, get a
hold of a tpm_chip and access the TPM functions using it.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c |  2 +-
 security/integrity/ima/ima_init.c   | 11 ++++-------
 security/integrity/ima/ima_queue.c  |  2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..35409461a3f2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -56,6 +56,7 @@ extern int ima_policy_flag;
 extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
+extern struct tpm_chip *ima_tpm_chip;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4e085a17124f..88082f35adb2 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -634,7 +634,7 @@ static void __init ima_pcrread(int idx, u8 *pcr)
 	if (!ima_used_chip)
 		return;
 
-	if (tpm_pcr_read(NULL, idx, pcr) != 0)
+	if (tpm_pcr_read(ima_tpm_chip, idx, pcr) != 0)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..1437ed3dbccc 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -27,6 +27,7 @@
 /* name for boot aggregate entry */
 static const char *boot_aggregate_name = "boot_aggregate";
 int ima_used_chip;
+struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -106,17 +107,13 @@ void __init ima_load_x509(void)
 
 int __init ima_init(void)
 {
-	u8 pcr_i[TPM_DIGEST_SIZE];
 	int rc;
 
-	ima_used_chip = 0;
-	rc = tpm_pcr_read(NULL, 0, pcr_i);
-	if (rc == 0)
-		ima_used_chip = 1;
+	ima_tpm_chip = tpm_default_chip();
 
+	ima_used_chip = ima_tpm_chip != NULL;
 	if (!ima_used_chip)
-		pr_info("No TPM chip found, activating TPM-bypass! (rc=%d)\n",
-			rc);
+		pr_info("No TPM chip found, activating TPM-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 418f35e38015..c6303fa19a49 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -145,7 +145,7 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 	if (!ima_used_chip)
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
More majordomo info at  http://vger.kernel.org/majordomo-info.html

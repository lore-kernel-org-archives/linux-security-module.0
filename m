Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB374E01FB;
	Wed, 30 Sep 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775873; cv=none; b=hcfkgfo+owZyEpycCehko0GhOaYRLRFmwHq1UxXIsN6R6zkL9DJLsoOJBgBI/Cuj5J7N7tnOFFqB6VK7LO0nGcZ66RTppgKpC9dWCwnOVM00ElhfC8452CrA4fjWx5aecaEA/mC+qQgva0RXWPzbxdIOg247o/wFJzKeKUprygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775873; c=relaxed/simple;
	bh=1TTNZBJOff+DQBq3pC1zbUDkT6WNaIHIEzHwkkzglHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlLp6eSkDrhfNbplETt4kiql+bFgUDACTlbOM22vBb+08iAXt9OgiaN7ZUn3awAmjsOP9jNbUy7oOFQE190BbGDQl7rXVBtpehHpFnmrObL6xU5Aag7Je1Pj87yKuvOy4tt6sbLd+tqP76iDJ9XEJPIS1xGDEdrYLLM33hNWks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tTB/GwOV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tTB/GwOV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 384F91596;
	Wed, 30 Sep 2026 06:44:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 995B33F86F;
	Wed, 30 Sep 2026 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790775864; bh=1TTNZBJOff+DQBq3pC1zbUDkT6WNaIHIEzHwkkzglHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tTB/GwOV1XyzfKlaRktYe421gIr7Cv2ujlMKh/Xcrni5rsJFcloZsl4vS4sOQuXs9
	 IQtXNBoMmWYE2xy3vCh1ofEMBc7MqmJq7u71q5YcIvjrEREj64B0YnkpuVYiFD8nv8
	 SppOoyKC9AqL5sCnfGrw3L+QPfcuA/SUYhTXmuLU=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 30 Sep 2026 14:44:00 +0100
Subject: [PATCH RFC 2/3] security: IMA: introduce ima_mr structure
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ima_tgx_integration_v2-v1-2-722c35370548@arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
In-Reply-To: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
To: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org
Cc: Dan Williams <djbw@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27263; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=1TTNZBJOff+DQBq3pC1zbUDkT6WNaIHIEzHwkkzglHU=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqvRIuzx+InW+p6TuxKW4IpfT+v1VyoXER+LNqD
 jt3daQZYKiJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCar0SLgAKCRBt1cPRWsUx
 M64iC/4saoATgghO55RE4YG6gYFZfJLUA+GGYJ9D9xv87WnzUgW1vNovfuaSiJgUJ1OIKjV2MLU
 0wRoGKSdQN/28SJ0QMWiEuQ8gLDab3F54QbQgOvbVoFPARU26tigRs/DOhX58BbIH/hbmzrx+Z7
 qupvg8JQiEu2xrnjL3G7+0mBimrIYI783TmtUPsqyKDxJiMKfLr3g04EpArtzFq4jDk34Vnj8ai
 aFf+bvSpu2ubqB6HeF9fCMt4dnbNJ9bdg6LWQCcINJ6QA2YqucWNZ6ZS38OT9twdZ7JX8Ga5zwv
 CHoGXVGbEGMd1M8JyX5gWyD9xYGeJloGXo/sIwEWnh1pLD9i8++4x563VERaxSZx2CatLxX+Sot
 OLhTcUzFMThwWmHrmM/5ALDRY8hAzr+vZ4BLNzrP3o0Jj3ksdYioEOYdLAdLE0vLsm9O2Y56B8+
 graeGQPjYq3C19H/clCmt/Fhdd2FnD4WWwrZSNGP7aV+f36Ry4rAgr6qAM5Mn+tE/tlic=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

This is preparatory patch to integrate tsm measurement registers with IMA.

To integrate tsm measurement registers, introcude ima_mr structure
which abstract measurements register and ima_mr_operation structure
which defines below operations to communicate with them:

  - mr_init(): find and initialise to communicate measurement registers
  - mr_get_bank_info: get information of bank of measurement registers.
  - mr_calc_boot_aggregate: generate boot aggregate hash with
                            measurement registers.
  - mr_extend: extend measurement registers.

Also, this patch adds ima_mr using TPM device using PCR as
measurement registers.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 security/integrity/ima/Makefile           |   2 +-
 security/integrity/ima/ima.h              |   7 +-
 security/integrity/ima/ima_api.c          |   4 +-
 security/integrity/ima/ima_crypto.c       | 137 +++++++++-----------------
 security/integrity/ima/ima_fs.c           |  16 ++-
 security/integrity/ima/ima_init.c         |   7 +-
 security/integrity/ima/ima_mr.c           |  47 +++++++++
 security/integrity/ima/ima_mr.h           |  75 +++++++++++++++
 security/integrity/ima/ima_mr_tpm.c       | 155 ++++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c        |  39 ++++----
 security/integrity/ima/ima_template.c     |   4 +-
 security/integrity/ima/ima_template_lib.c |   2 +-
 12 files changed, 365 insertions(+), 130 deletions(-)

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b376d38b4ee6..f2c46b405a00 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,7 +7,7 @@
 obj-$(CONFIG_IMA) += ima.o ima_iint.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_mr.o ima_mr_tpm.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 10214f73ca1e..5e43d3140357 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -22,11 +22,11 @@
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
 
+#include "ima_mr.h"
 #include "../integrity.h"
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
-enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 /*
  * BINARY: current binary measurements list
@@ -50,8 +50,6 @@ enum binary_lists {
 #define IMA_TEMPLATE_IMA_NAME "ima"
 #define IMA_TEMPLATE_IMA_FMT "d|n"
 
-#define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
-
 /* current content of the policy */
 extern int ima_policy_flag;
 
@@ -75,7 +73,6 @@ extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 
 extern int ima_appraise;
-extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
 extern const char boot_aggregate_late_name[];
 
@@ -118,7 +115,7 @@ struct ima_template_desc {
 
 struct ima_template_entry {
 	int pcr;
-	struct tpm_digest *digests;
+	mr_digest_t *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
 	struct ima_field_data template_data[];	/* template related data */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 122d127e108d..8a7194a26b81 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -40,7 +40,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_desc *desc)
 {
 	struct ima_template_desc *template_desc;
-	struct tpm_digest *digests;
+	mr_digest_t *digests;
 	int i, result = 0;
 
 	if (desc)
@@ -54,7 +54,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 		return -ENOMEM;
 
 	digests = kzalloc_objs(*digests,
-			       NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+			       NR_BANKS(ima_mr) + ima_extra_slots,
 			       GFP_NOFS);
 	if (!digests) {
 		kfree(*entry);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 0d72b48249ee..efa27ce5f128 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -58,7 +58,7 @@ static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 	if (algo == ima_hash_algo)
 		return tfm;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++)
+	for (i = 0; i < NR_BANKS(ima_mr) + ima_extra_slots; i++)
 		if (ima_algo_array[i].tfm && ima_algo_array[i].algo == algo)
 			return ima_algo_array[i].tfm;
 
@@ -77,6 +77,7 @@ int __init ima_init_crypto(void)
 	enum hash_algo algo;
 	long rc;
 	int i;
+	mr_bank_info_t bank_info;
 
 	rc = ima_init_ima_crypto();
 	if (rc)
@@ -85,8 +86,12 @@ int __init ima_init_crypto(void)
 	ima_sha1_idx = -1;
 	ima_hash_algo_idx = -1;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
-		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+	for (i = 0; i < NR_BANKS(ima_mr); i++) {
+		rc = ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
+		if (rc)
+			return rc;
+
+		algo = bank_info.crypto_id;
 		if (algo == HASH_ALGO_SHA1)
 			ima_sha1_idx = i;
 
@@ -95,24 +100,28 @@ int __init ima_init_crypto(void)
 	}
 
 	if (ima_sha1_idx < 0) {
-		ima_sha1_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+		ima_sha1_idx = NR_BANKS(ima_mr) + ima_extra_slots++;
 		if (ima_hash_algo == HASH_ALGO_SHA1)
 			ima_hash_algo_idx = ima_sha1_idx;
 	}
 
 	if (ima_hash_algo_idx < 0)
-		ima_hash_algo_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+		ima_hash_algo_idx = NR_BANKS(ima_mr) + ima_extra_slots++;
 
 	ima_algo_array = kzalloc_objs(*ima_algo_array,
-				      NR_BANKS(ima_tpm_chip) + ima_extra_slots);
+				      NR_BANKS(ima_mr) + ima_extra_slots);
 	if (!ima_algo_array) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
-		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
-		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
+	for (i = 0; i < NR_BANKS(ima_mr); i++) {
+		rc = ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
+		if (rc)
+			return rc;
+
+		algo = bank_info.crypto_id;
+		digest_size = bank_info.digest_size;
 		ima_algo_array[i].algo = algo;
 		ima_algo_array[i].digest_size = digest_size;
 
@@ -137,7 +146,7 @@ int __init ima_init_crypto(void)
 		}
 	}
 
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip)) {
+	if (ima_sha1_idx >= NR_BANKS(ima_mr)) {
 		if (ima_hash_algo == HASH_ALGO_SHA1) {
 			ima_algo_array[ima_sha1_idx].tfm = ima_shash_tfm;
 		} else {
@@ -153,7 +162,7 @@ int __init ima_init_crypto(void)
 		ima_algo_array[ima_sha1_idx].digest_size = SHA1_DIGEST_SIZE;
 	}
 
-	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
+	if (ima_hash_algo_idx >= NR_BANKS(ima_mr) &&
 	    ima_hash_algo_idx != ima_sha1_idx) {
 		digest_size = hash_digest_size[ima_hash_algo];
 		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
@@ -163,7 +172,7 @@ int __init ima_init_crypto(void)
 
 	return 0;
 out_array:
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+	for (i = 0; i < NR_BANKS(ima_mr) + ima_extra_slots; i++) {
 		if (!ima_algo_array[i].tfm ||
 		    ima_algo_array[i].tfm == ima_shash_tfm)
 			continue;
@@ -183,7 +192,7 @@ static void ima_free_tfm(struct crypto_shash *tfm)
 	if (tfm == ima_shash_tfm)
 		return;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++)
+	for (i = 0; i < NR_BANKS(ima_mr) + ima_extra_slots; i++)
 		if (ima_algo_array[i].tfm == tfm)
 			return;
 
@@ -335,7 +344,7 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry)
 {
-	u16 alg_id;
+	mr_bank_info_t bank_info;
 	int rc, i;
 
 	rc = ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
@@ -344,13 +353,16 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 
 	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+	for (i = 0; i < NR_BANKS(ima_mr) + ima_extra_slots; i++) {
 		if (i == ima_sha1_idx)
 			continue;
 
-		if (i < NR_BANKS(ima_tpm_chip)) {
-			alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
-			entry->digests[i].alg_id = alg_id;
+		if (i < NR_BANKS(ima_mr)) {
+			rc = ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
+			if (rc)
+				return rc;
+
+			entry->digests[i].alg_id = bank_info.alg_id;
 		}
 
 		/* for unmapped TPM algorithms digest is still a padded SHA1 */
@@ -414,87 +426,26 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 	return rc;
 }
 
-static void ima_pcrread(u32 idx, struct tpm_digest *d)
-{
-	if (!ima_tpm_chip)
-		return;
-
-	if (tpm_pcr_read(ima_tpm_chip, idx, d) != 0)
-		pr_err("Error Communicating to TPM chip\n");
-}
-
-/*
- * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
- * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but with
- * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
- * allowing firmware to configure and enable different banks.
- *
- * Knowing which TPM bank is read to calculate the boot_aggregate digest
- * needs to be conveyed to a verifier.  For this reason, use the same
- * hash algorithm for reading the TPM PCRs as for calculating the boot
- * aggregate digest as stored in the measurement list.
- */
-static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
-				       struct crypto_shash *tfm)
-{
-	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} };
-	int rc;
-	u32 i;
-	SHASH_DESC_ON_STACK(shash, tfm);
-
-	shash->tfm = tfm;
-
-	pr_devel("calculating the boot-aggregate based on TPM bank: %04x\n",
-		 d.alg_id);
-
-	rc = crypto_shash_init(shash);
-	if (rc != 0)
-		return rc;
-
-	/* cumulative digest over TPM registers 0-7 */
-	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
-		ima_pcrread(i, &d);
-		/* now accumulate with current aggregate */
-		rc = crypto_shash_update(shash, d.digest,
-					 crypto_shash_digestsize(tfm));
-		if (rc != 0)
-			return rc;
-	}
-	/*
-	 * Extend cumulative digest over TPM registers 8-9, which contain
-	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
-	 * in a typical PCR allocation. Registers 8-9 are only included in
-	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
-	 */
-	if (alg_id != TPM_ALG_SHA1) {
-		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
-			ima_pcrread(i, &d);
-			rc = crypto_shash_update(shash, d.digest,
-						crypto_shash_digestsize(tfm));
-		}
-	}
-	if (!rc)
-		rc = crypto_shash_final(shash, digest);
-	return rc;
-}
-
 int ima_calc_boot_aggregate(struct ima_digest_data *hash)
 {
 	struct crypto_shash *tfm;
-	u16 crypto_id, alg_id;
+	mr_bank_info_t bank_info;
 	int rc, i, bank_idx = -1;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
-		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
-		if (crypto_id == hash->algo) {
+	for (i = 0; i < NR_BANKS(ima_mr); i++) {
+		rc = ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
+		if (rc)
+			return rc;
+
+		if (bank_info.crypto_id == hash->algo) {
 			bank_idx = i;
 			break;
 		}
 
-		if (crypto_id == HASH_ALGO_SHA256)
+		if (bank_info.crypto_id == HASH_ALGO_SHA256)
 			bank_idx = i;
 
-		if (bank_idx == -1 && crypto_id == HASH_ALGO_SHA1)
+		if (bank_idx == -1 && bank_info.crypto_id == HASH_ALGO_SHA1)
 			bank_idx = i;
 	}
 
@@ -503,15 +454,19 @@ int ima_calc_boot_aggregate(struct ima_digest_data *hash)
 		return 0;
 	}
 
-	hash->algo = ima_tpm_chip->allocated_banks[bank_idx].crypto_id;
+	rc = ima_mr->ops->mr_get_bank_info(ima_mr, bank_idx, &bank_info);
+	if (rc)
+		return rc;
+
+	hash->algo = bank_info.crypto_id;
 
 	tfm = ima_alloc_tfm(hash->algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
 	hash->length = crypto_shash_digestsize(tfm);
-	alg_id = ima_tpm_chip->allocated_banks[bank_idx].alg_id;
-	rc = ima_calc_boot_aggregate_tfm(hash->digest, alg_id, tfm);
+	rc = ima_mr->ops->mr_calc_boot_aggregate(ima_mr, bank_idx,
+						  hash->digest, tfm);
 
 	ima_free_tfm(tfm);
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2a0bca554316..cfe1d5227e54 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -635,7 +635,9 @@ static int __init create_securityfs_measurement_lists(bool staging)
 	const struct file_operations *binary_ops = &ima_measurements_ops;
 	umode_t permissions = (S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP);
 	const char *file_suffix = "";
-	int count = NR_BANKS(ima_tpm_chip);
+	int count = NR_BANKS(ima_mr);
+	int rc;
+	mr_bank_info_t bank_info;
 
 	if (staging) {
 		ascii_ops = &ima_ascii_measurements_staged_ops;
@@ -643,7 +645,7 @@ static int __init create_securityfs_measurement_lists(bool staging)
 		file_suffix = "_staged";
 	}
 
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
+	if (ima_sha1_idx >= NR_BANKS(ima_mr))
 		count++;
 
 	for (int i = 0; i < count; i++) {
@@ -651,10 +653,16 @@ static int __init create_securityfs_measurement_lists(bool staging)
 		char file_name[NAME_MAX + 1];
 		struct dentry *dentry;
 
+		if (algo == HASH_ALGO__LAST) {
+			rc = ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
+			if (rc)
+				return rc;
+		}
+
 		if (algo == HASH_ALGO__LAST)
 			snprintf(file_name, sizeof(file_name),
 				 "ascii_runtime_measurements_tpm_alg_%x%s",
-				 ima_tpm_chip->allocated_banks[i].alg_id,
+				 bank_info.alg_id,
 				 file_suffix);
 		else
 			snprintf(file_name, sizeof(file_name),
@@ -669,7 +677,7 @@ static int __init create_securityfs_measurement_lists(bool staging)
 		if (algo == HASH_ALGO__LAST)
 			snprintf(file_name, sizeof(file_name),
 				 "binary_runtime_measurements_tpm_alg_%x%s",
-				 ima_tpm_chip->allocated_banks[i].alg_id,
+				 bank_info.alg_id,
 				 file_suffix);
 		else
 			snprintf(file_name, sizeof(file_name),
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index d53f4d89a53e..a1290e891fa4 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,7 +23,6 @@
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
 const char boot_aggregate_late_name[] = "boot_aggregate_late";
-struct tpm_chip *ima_tpm_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -78,7 +77,7 @@ static int __init ima_add_boot_aggregate(void)
 	 * Ultimately select SHA1 also for TPM 2.0 if the SHA256 PCR bank
 	 * is not found.
 	 */
-	if (ima_tpm_chip) {
+	if (ima_mr) {
 		result = ima_calc_boot_aggregate(hash_hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
@@ -126,9 +125,7 @@ int __init ima_init(void)
 {
 	int rc;
 
-	ima_tpm_chip = tpm_default_chip();
-	if (!ima_tpm_chip)
-		pr_info("No TPM chip found, activating TPM-bypass!\n");
+	ima_init_mr();
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_mr.c b/security/integrity/ima/ima_mr.c
new file mode 100644
index 000000000000..fe58eb968954
--- /dev/null
+++ b/security/integrity/ima/ima_mr.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Arm Ltd
+ *
+ * Author:
+ * Yeoreum Yun <yeoreum.yun@arm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "ima.h"
+
+struct ima_mr *ima_mr;
+
+static struct ima_mr_operations *ima_mr_ops[] = {
+	&ima_mr_tpm_operations,
+};
+
+void __init ima_init_mr(void)
+{
+	int rc, i;
+
+	ima_mr = kmalloc_obj(*ima_mr);
+	if (!ima_mr) {
+		pr_info("Out of memory creating MR, activating MR-bypass!\n");
+		return;
+	}
+
+	rc = -ENODEV;
+	for (i = 0; i < ARRAY_SIZE(ima_mr_ops); i++) {
+		if (!ima_mr_ops[i]->supported)
+			continue;
+
+		rc = ima_mr_ops[i]->mr_init(ima_mr);
+		if (!rc) {
+			pr_info("MR device found: %s\n", ima_mr_ops[i]->name);
+			break;
+		}
+	}
+
+	if (rc) {
+		pr_info("No MR device found, activating MR-bypass!\n");
+		kfree(ima_mr);
+		ima_mr = NULL;
+	}
+}
diff --git a/security/integrity/ima/ima_mr.h b/security/integrity/ima/ima_mr.h
new file mode 100644
index 000000000000..23b85522da34
--- /dev/null
+++ b/security/integrity/ima/ima_mr.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Arm Ltd
+ *
+ * Author:
+ * Yeoreum Yun <yeoreum.yun@arm.com>
+ */
+
+#ifndef __LINUX_IMA_MR_H
+#define __LINUX_IMA_MR_H
+
+#include <linux/types.h>
+#include <linux/crypto.h>
+#include <linux/hash.h>
+#include <linux/tpm.h>
+
+#define NR_BANKS(mr) ((mr != NULL) ? mr->nr_banks : 0)
+
+typedef struct tpm_bank_info mr_bank_info_t;
+typedef struct tpm_digest    mr_digest_t;
+
+enum tpm_pcrs {
+	TPM_PCR0 = 0,
+	TPM_PCR1 = 1,
+	TPM_PCR2 = 2,
+	TPM_PCR7 = 7,
+	TPM_PCR8 = 8,
+	TPM_PCR10 = 10,
+	TPM_PCR16 = 16,
+};
+
+struct ima_mr_operations;
+
+struct ima_mr {
+	int nr_banks;
+	struct ima_mr_operations *ops;
+	void *data;
+};
+
+struct ima_mr_operations {
+	const char *name;
+	bool supported;
+	int (*mr_init)(struct ima_mr *mr);
+	int (*mr_get_bank_info)(struct ima_mr *mr, int bank,
+				mr_bank_info_t *info);
+	int (*mr_calc_boot_aggregate)(struct ima_mr *mr, int bank,
+				      char *digest, struct crypto_shash *tfm);
+	int (*mr_extend)(struct ima_mr *mr, u32 pcr_idx,
+			 mr_digest_t *digests);
+};
+
+extern struct ima_mr *ima_mr;
+extern struct ima_mr_operations ima_mr_tpm_operations;
+
+void __init ima_init_mr(void);
+
+static __always_inline u16 hash_to_alg(u16 hash_id)
+{
+	switch (hash_id) {
+	case HASH_ALGO_SHA1:
+		return TPM_ALG_SHA1;
+	case HASH_ALGO_SHA256:
+		return TPM_ALG_SHA256;
+	case HASH_ALGO_SHA384:
+		return TPM_ALG_SHA384;
+	case HASH_ALGO_SHA512:
+		return TPM_ALG_SHA512;
+	case HASH_ALGO_SM3_256:
+		return TPM_ALG_SM3_256;
+	default:
+		return TPM_ALG_ERROR;
+	}
+}
+
+#endif /* __LINUX_IMA_MR_H */
diff --git a/security/integrity/ima/ima_mr_tpm.c b/security/integrity/ima/ima_mr_tpm.c
new file mode 100644
index 000000000000..edee83d5a551
--- /dev/null
+++ b/security/integrity/ima/ima_mr_tpm.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Arm Ltd
+ *
+ * Author:
+ * Yeoreum Yun <yeoreum.yun@arm.com>
+ */
+
+#include <linux/kernel.h>
+
+#include "ima.h"
+
+static int tpm_mr_init(struct ima_mr *mr)
+{
+	struct tpm_chip *tpm_chip;
+
+	if (!mr)
+		return -EINVAL;
+
+	tpm_chip = tpm_default_chip();
+	if (!tpm_chip) {
+		pr_info("No TPM chip found!\n");
+		return -ENODEV;
+	}
+
+	mr->data = tpm_chip;
+	mr->nr_banks = tpm_chip->nr_allocated_banks;
+	mr->ops = &ima_mr_tpm_operations;
+
+	return 0;
+}
+
+static int tpm_mr_get_bank_info(struct ima_mr *mr, int bank,
+				mr_bank_info_t *info)
+{
+	struct tpm_chip *tpm_chip;
+
+	if (!mr || !mr->data || !info || (bank >= mr->nr_banks))
+		return -EINVAL;
+
+	tpm_chip = mr->data;
+	info->alg_id = tpm_chip->allocated_banks[bank].alg_id;
+	info->digest_size = tpm_chip->allocated_banks[bank].digest_size;
+	info->crypto_id = tpm_chip->allocated_banks[bank].crypto_id;
+
+	if (WARN_ON_ONCE((info->crypto_id != HASH_ALGO__LAST) &&
+			 (hash_to_alg(info->crypto_id) != info->alg_id)))
+		return -ENODEV;
+
+	return 0;
+}
+
+/*
+ * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
+ * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but with
+ * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
+ * allowing firmware to configure and enable different banks.
+ *
+ * Knowing which TPM bank is read to calculate the boot_aggregate digest
+ * needs to be conveyed to a verifier.  For this reason, use the same
+ * hash algorithm for reading the TPM PCRs as for calculating the boot
+ * aggregate digest as stored in the measurement list.
+ */
+static int tpm_mr_calc_boot_aggregate(struct ima_mr *mr, int bank,
+				      char *digest, struct crypto_shash *tfm)
+{
+	int rc;
+	struct tpm_chip *tpm_chip;
+	mr_digest_t d = { .digest = {0} };
+	u32 pcr_idx;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	if (!mr || !mr->data || !tfm || (bank >= mr->nr_banks))
+		return -EINVAL;
+
+	tpm_chip = mr->data;
+	d.alg_id = tpm_chip->allocated_banks[bank].alg_id;
+
+	shash->tfm = tfm;
+
+	pr_devel("calculating the boot-aggregate based on TPM bank: %04x\n",
+		 d.alg_id);
+
+	rc = crypto_shash_init(shash);
+	if (rc)
+		return rc;
+
+	/* cumulative digest over TPM registers 0-7 */
+	for (pcr_idx = TPM_PCR0; pcr_idx < TPM_PCR8; pcr_idx++) {
+		rc = tpm_pcr_read(tpm_chip, pcr_idx, &d);
+		rc = tpm_ret_to_err(rc);
+		if (rc) {
+			pr_err("Error Communicating to TPM chip\n");
+			return rc;
+		}
+
+		/* now accumulate with current aggregate */
+		rc = crypto_shash_update(shash, d.digest,
+					 crypto_shash_digestsize(tfm));
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * Extend cumulative digest over TPM registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation. Registers 8-9 are only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (d.alg_id != TPM_ALG_SHA1) {
+		for (pcr_idx = TPM_PCR8; pcr_idx < TPM_PCR10; pcr_idx++) {
+			rc = tpm_pcr_read(tpm_chip, pcr_idx, &d);
+			rc = tpm_ret_to_err(rc);
+			if (rc) {
+				pr_err("Error Communicating to TPM chip\n");
+				return rc;
+			}
+
+			rc = crypto_shash_update(shash, d.digest,
+						crypto_shash_digestsize(tfm));
+		}
+	}
+
+	if (!rc)
+		rc = crypto_shash_final(shash, digest);
+	return rc;
+}
+
+static int tpm_mr_extend(struct ima_mr *mr, u32 pcr_idx,
+			 mr_digest_t *digests)
+{
+	int rc;
+	struct tpm_chip *tpm_chip;
+
+	if (!mr || !mr->data)
+		return -EINVAL;
+
+	tpm_chip = mr->data;
+
+	rc = tpm_pcr_extend(tpm_chip, pcr_idx, digests);
+	rc = tpm_ret_to_err(rc);
+	if (rc)
+		pr_err("Error Communicating to TPM chip, result: %d\n", rc);
+
+	return rc;
+}
+
+struct ima_mr_operations ima_mr_tpm_operations = {
+	.name                    = "TPM",
+	.supported               = IS_BUILTIN(CONFIG_TCG_TPM),
+	.mr_init                 = tpm_mr_init,
+	.mr_get_bank_info        = tpm_mr_get_bank_info,
+	.mr_calc_boot_aggregate  = tpm_mr_calc_boot_aggregate,
+	.mr_extend               = tpm_mr_extend,
+};
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 0f1b7e4113c4..637db7c338e2 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -217,16 +217,15 @@ unsigned long ima_get_binary_runtime_size(enum binary_lists binary_list)
 		return val + sizeof(struct ima_kexec_hdr);
 }
 
-static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
+static int ima_mr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result = 0;
 
-	if (!ima_tpm_chip)
+	if (!ima_mr)
 		return result;
 
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
-	if (result != 0)
-		pr_err("Error Communicating to TPM chip, result: %d\n", result);
+	result = ima_mr->ops->mr_extend(ima_mr, pcr, digests_arg);
+
 	return result;
 }
 
@@ -247,7 +246,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	const char *audit_cause = "hash_added";
 	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
 	int audit_info = 1;
-	int result = 0, tpmresult = 0;
+	int result = 0, mresult = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
 
@@ -281,10 +280,10 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	if (violation)		/* invalidate pcr */
 		digests_arg = digests;
 
-	tpmresult = ima_pcr_extend(digests_arg, entry->pcr);
-	if (tpmresult != 0) {
+	mresult = ima_mr_extend(digests_arg, entry->pcr);
+	if (mresult != 0) {
 		snprintf(tpm_audit_cause, AUDIT_CAUSE_LEN_MAX, "TPM_error(%d)",
-			 tpmresult);
+			 mresult);
 		audit_cause = tpm_audit_cause;
 		audit_info = 0;
 	}
@@ -548,25 +547,27 @@ void __init ima_init_reboot_notifier(void)
 
 int __init ima_init_digests(void)
 {
+	int rc, i;
+	mr_bank_info_t bank_info;
 	u16 digest_size;
-	u16 crypto_id;
-	int i;
 
-	if (!ima_tpm_chip)
+	if (!ima_mr)
 		return 0;
 
-	digests = kzalloc_objs(*digests, ima_tpm_chip->nr_allocated_banks,
-			       GFP_NOFS);
+	digests = kzalloc_objs(*digests, NR_BANKS(ima_mr), GFP_NOFS);
 	if (!digests)
 		return -ENOMEM;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
-		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
-		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
-		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
+	for (i = 0; i < NR_BANKS(ima_mr); i++) {
+		rc = ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
+		if (rc)
+			return rc;
+
+		digests[i].alg_id = bank_info.alg_id;
+		digest_size = bank_info.digest_size;
 
 		/* for unmapped TPM algorithms digest is still a padded SHA1 */
-		if (crypto_id == HASH_ALGO__LAST)
+		if (bank_info.crypto_id == HASH_ALGO__LAST)
 			digest_size = SHA1_DIGEST_SIZE;
 
 		memset(digests[i].digest, 0xff, digest_size);
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7034573fb41e..3396e9df22a5 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -358,7 +358,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 				     int template_data_size,
 				     struct ima_template_entry **entry)
 {
-	struct tpm_digest *digests;
+	mr_digest_t *digests;
 	int ret = 0;
 	int i;
 
@@ -368,7 +368,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 		return -ENOMEM;
 
 	digests = kzalloc_objs(*digests,
-			       NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+			       NR_BANKS(ima_mr) + ima_extra_slots,
 			       GFP_NOFS);
 	if (!digests) {
 		kfree(*entry);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 8a89236f926c..12386241b126 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -365,7 +365,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 
 	if ((const char *)event_data->filename == boot_aggregate_name ||
 	    (const char *)event_data->filename == boot_aggregate_late_name) {
-		if (ima_tpm_chip) {
+		if (ima_mr) {
 			hash.hdr.algo = HASH_ALGO_SHA1;
 			result = ima_calc_boot_aggregate(hash_hdr);
 

-- 
2.43.0


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7534E2F3E;
	Wed, 30 Sep 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775880; cv=none; b=Km47sSRrk07Mgm9BxRNhPvZu+jLw+8SMZz57DQzo+TuX2F1l6JoK1XCa39nhvBiZ4gD6DY3i9Ee3urKBunsDVGXECd7jg0C6LTpaeGp4oHYqKR4LFnNk/Bn7JqZHyQOQowAEQmLXbUF0dHzQ6N7h0PsmHQXjosaLWvFesK80m2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775880; c=relaxed/simple;
	bh=d6nZ0CYHV1j5DDfKelAp5NeZoMJ0Ig7FSoRuiZJx2Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVjw7eO7wSwvdfMOYyWCljDljSVjM/8jUA9LDb7wxCniAILBbUFXB+vkI1tdn/b7GzTAxr2vgE2yCHUbNRTucttLw+nKQbjwOpafRP0kGT+c9bATPEi4yCTImpNvitcrZjPIX+qTA63EKii+rOanRDU58rOTczG5rx8sr6u+S2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Bd7o93Qa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Bd7o93Qa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727E6168F;
	Wed, 30 Sep 2026 06:44:24 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02EC3F86F;
	Wed, 30 Sep 2026 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790775867; bh=d6nZ0CYHV1j5DDfKelAp5NeZoMJ0Ig7FSoRuiZJx2Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bd7o93Qa4PFjgVXK07gWvwXZrDcfEFGQIs/QAkCVds9/yksQ8KmpaTwp+ibtmen4s
	 L5sXkl6iJ/NBAzd3gKZNrOuHAV9O0MhB7/oDYEuE5+BXCuJ1EV+KWOpbXPsSA5afbx
	 OKmQYx0RaWyYXk1k31UnALGaqId4G3C0jLf1Tnhw=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 30 Sep 2026 14:44:01 +0100
Subject: [PATCH RFC 3/3] security: IMA: use TSM measurement registers
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ima_tgx_integration_v2-v1-3-722c35370548@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10095; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=d6nZ0CYHV1j5DDfKelAp5NeZoMJ0Ig7FSoRuiZJx2Ko=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqvRIuDp0ses8uekRGMZSlJEtTE++PzOEzQHBGj
 J1jf6ABkYSJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCar0SLgAKCRBt1cPRWsUx
 M3VGDACbmjMwaE1TpUBn0d2fNZbF815kR7BpsXO/j/OxUlJ4cnrthT3T9Ly1HKCEtGT5+RHbiiV
 of2LubVbNpcs42/U9M4oS8fj1swjbbjV0svdny+5QKYsHKBELl4RzlcHEMH7or2iha7a9E/rhRu
 cOgmsPBLCKli0bCn3nE0IXCyWJSu/IaroIE6su2u2Zg4cPhvLJiQNP2Yyp86AzkkYn19d1vHIcz
 6AZm/wz1J6icZe6L48Rj9Ynacif9cKpt1xi12pcViilXMnvPx7vFnwmRa+P0F7+i0XBM8mqSfld
 7ppHaQDx7dMdMhe/Q53YN37fQdsoH+Yud6qbSLEaKDoA/HQjxpjlIRdsy1cxF6DN0XJkU6A9CUc
 Ljrb/EZBLULov+/VWiLHGzOjvp4JGLyHdQ7XNYPiQiD9B7tbyMklcc64OlzsImvdNSwsUqqtEtt
 uJ+Keg0hGSpFU9WtMf3VGeNPyx8aOh5DWkLOoB31Zlsy+YISvCvErSbGyPCWGVjtYum6Q=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

IMA uses TPM PCRs to record measurement digests. When no TPM device is
available, TSM measurement registers can serve as an alternative for guest.

The following mappings are defined for Intel TDX [0] and proposed for
Arm CCA [1]:

  TPM PCR index | Intel TDX register | Arm CCA register
  --------------+--------------------+-----------------
  0             | MRTD               | RIM
  1, 7          | RTMR[0]            | REM[0]
  2-6           | RTMR[1]            | REM[1]
  8-15          | RTMR[2]            | REM[2]

Add support for extending IMA measurement digests into the corresponding
TSM measurement register when no TPM device is available.

Link: [0] https://uefi.org/specs/UEFI/2.11/38_Confidential_Computing.html#intel-trust-domain-extension
Link: [1] https://github.com/tianocore/edk2/issues/11383
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 security/integrity/ima/Makefile     |   3 +-
 security/integrity/ima/ima_mr.c     |   1 +
 security/integrity/ima/ima_mr.h     |   1 +
 security/integrity/ima/ima_mr_tsm.c | 290 ++++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index f2c46b405a00..f0a22e3a5320 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,7 +7,8 @@
 obj-$(CONFIG_IMA) += ima.o ima_iint.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o ima_mr.o ima_mr_tpm.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_mr.o ima_mr_tpm.o \
+	 ima_mr_tsm.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
diff --git a/security/integrity/ima/ima_mr.c b/security/integrity/ima/ima_mr.c
index fe58eb968954..85a66e616f64 100644
--- a/security/integrity/ima/ima_mr.c
+++ b/security/integrity/ima/ima_mr.c
@@ -15,6 +15,7 @@ struct ima_mr *ima_mr;
 
 static struct ima_mr_operations *ima_mr_ops[] = {
 	&ima_mr_tpm_operations,
+	&ima_mr_tsm_operations,
 };
 
 void __init ima_init_mr(void)
diff --git a/security/integrity/ima/ima_mr.h b/security/integrity/ima/ima_mr.h
index 23b85522da34..bc7b06c3adcd 100644
--- a/security/integrity/ima/ima_mr.h
+++ b/security/integrity/ima/ima_mr.h
@@ -51,6 +51,7 @@ struct ima_mr_operations {
 
 extern struct ima_mr *ima_mr;
 extern struct ima_mr_operations ima_mr_tpm_operations;
+extern struct ima_mr_operations ima_mr_tsm_operations;
 
 void __init ima_init_mr(void);
 
diff --git a/security/integrity/ima/ima_mr_tsm.c b/security/integrity/ima/ima_mr_tsm.c
new file mode 100644
index 000000000000..3f88edfb8511
--- /dev/null
+++ b/security/integrity/ima/ima_mr_tsm.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Arm Ltd
+ *
+ * Author:
+ * Yeoreum Yun <yeoreum.yun@arm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/tsm-mr.h>
+
+#include "ima.h"
+
+#define INVALID_MR_IDX		(-1)
+
+struct tsm_context {
+	const struct tsm_measurements *tm;
+	int pcr_map[TPM2_PLATFORM_PCR];
+};
+
+static struct tsm_context tsm_ctx;
+
+static int tsm_mr_idx_by_name(const struct tsm_measurements *tm,
+			      const char *mr_name)
+{
+	int i;
+	const struct tsm_measurement_register *mr;
+
+	for (i = 0; i < tm->nr_mrs; i++) {
+		mr = &tm->mrs[i];
+		if (!strcmp(mr->mr_name, mr_name))
+			return i;
+	}
+
+	return INVALID_MR_IDX;
+}
+
+static __always_inline
+int tsm_mr_idx(const struct tsm_measurements *tm,
+	       const struct tsm_measurement_register *tmr)
+{
+	return tmr - tm->mrs;
+}
+
+static __always_inline
+void __create_tsm_pcr_map(struct tsm_context *ctx,
+			  int mr0, int mr1, int mr2, int mr3)
+{
+	int i;
+
+	ctx->pcr_map[TPM_PCR0] = mr0;
+	ctx->pcr_map[TPM_PCR1] = ctx->pcr_map[TPM_PCR7] = mr1;
+
+	for (i = TPM_PCR2; i < TPM_PCR7; i++) {
+		ctx->pcr_map[i] = mr2;
+	}
+
+	for (i = TPM_PCR8; i < TPM_PCR16; i++) {
+		ctx->pcr_map[i] = mr3;
+	}
+
+	for (i = TPM_PCR16; i < TPM2_PLATFORM_PCR; i++) {
+		ctx->pcr_map[i] = INVALID_MR_IDX;
+	}
+}
+
+static int create_tsm_arm_cca_pcr_map(struct tsm_context *ctx)
+{
+	int rim_idx, rem0_idx, rem1_idx, rem2_idx;
+
+	rim_idx = tsm_mr_idx_by_name(ctx->tm, "rim");
+	rem0_idx = tsm_mr_idx_by_name(ctx->tm, "rem0");
+	rem1_idx = tsm_mr_idx_by_name(ctx->tm, "rem1");
+	rem2_idx = tsm_mr_idx_by_name(ctx->tm, "rem2");
+
+	if ((rim_idx == INVALID_MR_IDX) || (rem0_idx == INVALID_MR_IDX) ||
+	    (rem1_idx == INVALID_MR_IDX) || (rem2_idx == INVALID_MR_IDX))
+		return -ENODEV;
+
+	__create_tsm_pcr_map(ctx, rim_idx, rem0_idx, rem1_idx, rem2_idx);
+
+	return 0;
+}
+
+static int create_tsm_tgx_pcr_map(struct tsm_context *ctx)
+{
+	int mrtd_idx, rtmr0_idx, rtmr1_idx, rtmr2_idx;
+
+	mrtd_idx = tsm_mr_idx_by_name(ctx->tm, "mrtd");
+	rtmr0_idx = tsm_mr_idx_by_name(ctx->tm, "rtmr0");
+	rtmr1_idx = tsm_mr_idx_by_name(ctx->tm, "rtmr1");
+	rtmr2_idx = tsm_mr_idx_by_name(ctx->tm, "rtmr2");
+
+	if ((mrtd_idx == INVALID_MR_IDX) || (rtmr0_idx == INVALID_MR_IDX) ||
+	    (rtmr1_idx == INVALID_MR_IDX) || (rtmr2_idx == INVALID_MR_IDX))
+		return -ENODEV;
+
+	__create_tsm_pcr_map(ctx, mrtd_idx, rtmr0_idx, rtmr1_idx, rtmr2_idx);
+
+	return 0;
+}
+
+static const struct tsm_measurement_register *
+tsm_mr_get(struct tsm_context *ctx, int pcr_idx)
+{
+	int idx;
+
+	if (pcr_idx < 0 || pcr_idx >= ARRAY_SIZE(ctx->pcr_map))
+		return NULL;
+
+	idx = ctx->pcr_map[pcr_idx];
+	if (idx == INVALID_MR_IDX)
+		return NULL;
+
+	return &ctx->tm->mrs[idx];
+}
+
+static int tsm_mr_init(struct ima_mr *mr)
+{
+	int rc;
+	const struct tsm_measurements *tm;
+
+	if (!mr)
+		return -EINVAL;
+
+	tm = tsm_default_tm();
+	if (!tm) {
+		pr_info("No TSM measurement registers found!\n");
+		return -ENODEV;
+	}
+
+	tsm_ctx.tm = tm;
+
+	if (IS_BUILTIN(CONFIG_ARM_CCA_GUEST))
+		rc = create_tsm_arm_cca_pcr_map(&tsm_ctx);
+	else
+		rc = create_tsm_tgx_pcr_map(&tsm_ctx);
+
+	if (rc) {
+		tsm_ctx.tm = NULL;
+		return rc;
+	}
+
+	mr->data = &tsm_ctx;
+	mr->nr_banks = 1;
+	mr->ops = &ima_mr_tsm_operations;
+
+	return 0;
+}
+
+static int tsm_mr_get_bank_info(struct ima_mr *mr, int bank,
+				mr_bank_info_t *info)
+{
+	struct tsm_context *ctx;
+	const struct tsm_measurement_register *tsm_mr;
+
+	if (!mr || !mr->data || !info || (bank >= mr->nr_banks))
+		return -EINVAL;
+
+	ctx = mr->data;
+	tsm_mr = tsm_mr_get(ctx, TPM_PCR0);
+	if (!tsm_mr)
+		return -ENODEV;
+
+	info->crypto_id = tsm_mr->mr_hash;
+	info->digest_size = tsm_mr->mr_size;
+	info->alg_id = hash_to_alg(info->crypto_id);
+
+	if (info->alg_id == TPM_ALG_ERROR)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int tsm_mr_calc_boot_aggregate(struct ima_mr *mr, int bank,
+				      char *digest, struct crypto_shash *tfm)
+{
+	int rc;
+	struct tsm_context *ctx;
+	const struct tsm_measurement_register *tsm_mr;
+	mr_digest_t d = { .digest = {0} };
+	SHASH_DESC_ON_STACK(shash, tfm);
+	int mr_idx, pcr_idx;
+
+	if (!mr || !mr->data || !tfm || (bank >= mr->nr_banks))
+		return -EINVAL;
+
+	ctx = mr->data;
+	tsm_mr = tsm_mr_get(ctx, TPM_PCR0);
+	if (!tsm_mr)
+		return -ENODEV;
+
+	d.alg_id = hash_to_alg(tsm_mr->mr_hash);
+	if (d.alg_id == TPM_ALG_ERROR)
+		return -ENODEV;
+
+	shash->tfm = tfm;
+
+	pr_devel("calculating the boot-aggregate based on TSM bank: %04x\n",
+		 d.alg_id);
+
+	rc = crypto_shash_init(shash);
+	if (rc)
+		return rc;
+
+	/*
+	 * In TSM, PCR 0 mapped into MR 0, PCR 1,7 into MR 1 and
+	 * PCR 2-6 into MR 2. Therefore, accumulate with  MR 0-2.
+	 */
+	for (pcr_idx = TPM_PCR0; pcr_idx <= TPM_PCR2; pcr_idx++) {
+		tsm_mr = tsm_mr_get(ctx, pcr_idx);
+		if (!tsm_mr)
+			return -ENODEV;
+
+		mr_idx = tsm_mr_idx(ctx->tm, tsm_mr);
+		rc = tsm_mr_read(ctx->tm, mr_idx, d.digest, tsm_mr->mr_size);
+		if (rc) {
+			pr_err("Error Communicating to TSM(%d)\n", rc);
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
+	 * Extend cumulative digest over MR 3 which corespondant to
+	 * TPM registers 8-9, which contain measurement for
+	 * the kernel command line (TPM_PCR8) and image (TPM_PCR9)
+	 * in a typical PCR allocation. MR 3 is only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (d.alg_id != TPM_ALG_SHA1) {
+		tsm_mr = tsm_mr_get(ctx, TPM_PCR8);
+		if (!tsm_mr)
+			return -ENODEV;
+
+		mr_idx = tsm_mr_idx(ctx->tm, tsm_mr);
+		rc = tsm_mr_read(ctx->tm, mr_idx, d.digest, tsm_mr->mr_size);
+		if (rc) {
+			pr_err("Error Communicating to TSM(%d)\n", rc);
+			return rc;
+		}
+
+		rc = crypto_shash_update(shash, d.digest,
+					crypto_shash_digestsize(tfm));
+	}
+
+	if (!rc)
+		rc = crypto_shash_final(shash, digest);
+	return rc;
+}
+
+static int tsm_mr_extend(struct ima_mr *mr, u32 pcr_idx,
+			 mr_digest_t *digests)
+{
+	int rc, mr_idx;
+	struct tsm_context *ctx;
+	const struct tsm_measurement_register *tsm_mr;
+
+	if (!mr || !mr->data)
+		return -EINVAL;
+
+	ctx = mr->data;
+	tsm_mr = tsm_mr_get(ctx, pcr_idx);
+	if (!tsm_mr)
+		return -ENODEV;
+
+	mr_idx = tsm_mr_idx(ctx->tm, tsm_mr);
+
+	/* TSM has only one bank. */
+	rc = tsm_mr_write(ctx->tm, mr_idx, digests[0].digest, tsm_mr->mr_size);
+	if (rc)
+		pr_err("Error Communicating to TSM, result: %d\n", rc);
+
+	return rc;
+}
+
+struct ima_mr_operations ima_mr_tsm_operations = {
+	.name                    = "TSM",
+	.supported               = (IS_BUILTIN(CONFIG_ARM_CCA_GUEST) ||
+				    IS_BUILTIN(CONFIG_TDX_GUEST_DRIVER)),
+	.mr_init                 = tsm_mr_init,
+	.mr_get_bank_info        = tsm_mr_get_bank_info,
+	.mr_calc_boot_aggregate  = tsm_mr_calc_boot_aggregate,
+	.mr_extend               = tsm_mr_extend,
+};

-- 
2.43.0


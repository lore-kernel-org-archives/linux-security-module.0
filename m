Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24DDC636D3
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Feb 2023 05:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBDFct (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Feb 2023 00:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjBDFcp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:32:45 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1343A93AD0
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:32:43 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 31459xIQ011642;
        Fri, 3 Feb 2023 23:09:59 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 31459xb4011640;
        Fri, 3 Feb 2023 23:09:59 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 07/14] Add root domain trust implementation.
Date:   Fri,  3 Feb 2023 23:09:47 -0600
Message-Id: <20230204050954.11583-8-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204050954.11583-1-greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The trust.c contains the support infrastructure for anchoring the
root modeling domain in a hardware TPM implementation if it is
available.

The security event state points are extended into Platform
Configuration Register (PCR) 11 in order to provide authentication of
the security execution trajectory for the root domain.  This
value was chosen to avoid the use of PCR register 10 that the
Integrity Measurement Architecture uses to register the integrity
events that it handles.

This file is also responsible for computing the hardware platform
aggregate measurement.  This is the linear extension sum over PCR
rsegisters 0 through 7.  This file contains an accessor function
for surfacing this value to either the internal or external
Trusted Modeling Agent implementations.

The platform hardware aggregate value is designed to be the first
security event state point injected into a model.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/trust.c | 134 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 security/tsem/trust.c

diff --git a/security/tsem/trust.c b/security/tsem/trust.c
new file mode 100644
index 000000000000..77190c07f772
--- /dev/null
+++ b/security/tsem/trust.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2022 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * Implements management of a TPM trust root for the in kernel TMA.
+ */
+
+#include <crypto/hash.h>
+#include <linux/tpm.h>
+
+#include "tsem.h"
+
+#define TSEM_TRUST_ROOT 11
+
+static u8 hardware_aggregate[WP256_DIGEST_SIZE];
+
+static struct tpm_chip *tpm;
+
+static struct tpm_digest *digests;
+
+
+void __init generate_aggregate(struct crypto_shash *tfm)
+{
+	int retn = 0, lp;
+	struct tpm_digest pcr;
+	u8 digest[WP256_DIGEST_SIZE];
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	if (tpm_is_tpm2(tpm))
+		pcr.alg_id = TPM_ALG_SHA256;
+	else
+		pcr.alg_id = TPM_ALG_SHA1;
+	memset(pcr.digest, '\0', TPM_MAX_DIGEST_SIZE);
+
+	for (lp = 0; lp < 8; ++lp) {
+		retn = tpm_pcr_read(tpm, lp, &pcr);
+		if (retn)
+			goto done;
+		memcpy(digest, pcr.digest, sizeof(digest));
+		retn = crypto_shash_update(shash, digest, WP256_DIGEST_SIZE);
+		if (retn)
+			goto done;
+	}
+	if (!retn)
+		retn = crypto_shash_final(shash, hardware_aggregate);
+
+ done:
+	if (retn)
+		pr_info("Unable to generate platform aggregate\n");
+}
+
+static int __init trust_init(void)
+{
+	int retn = -EINVAL, lp;
+	struct crypto_shash *tfm = NULL;
+
+	tpm = tpm_default_chip();
+	if (!tpm) {
+		pr_info("No TPM found for event modeling.\n");
+		return retn;
+	}
+
+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests), GFP_NOFS);
+	if (!digests) {
+		tpm = NULL;
+		return retn;
+	}
+	for (lp = 0; lp < tpm->nr_allocated_banks; lp++)
+		digests[lp].alg_id = tpm->allocated_banks[lp].alg_id;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		retn = PTR_ERR(tfm);
+	else {
+		generate_aggregate(tfm);
+		retn = 0;
+	}
+	crypto_free_shash(tfm);
+
+	return retn;
+}
+
+/**
+ * tsem_trust_aggregate() - Return a pointer to the hardware aggregate.
+ *
+ * This function returns a pointer to the hardware aggregate that
+ * is computed at system boot time.
+ *
+ * Return: A byte pointer is returned to the statically scoped array
+ *	   that contains the hardware aggregate value.
+ */
+u8 *tsem_trust_aggregate(void)
+{
+	return hardware_aggregate;
+}
+
+/**
+ * tsem_trust_add_point() - Add a measurement to the trust root.
+ * @coefficient: A pointer to the event coefficient to be added.
+ *
+ * This function extends the platform configuration register being
+ * used to document the hardware root of trust for internally modeled
+ * domains with a security event coefficient value.
+ *
+ * Return: If the extension fails the error return value from the
+ *	   TPM command is returned, otherwise a value of zero is
+ *	   returned.
+ */
+int tsem_trust_add_event(u8 *coefficient)
+{
+	int amt, bank;
+
+	if (!tpm)
+		return 0;
+
+	for (bank = 0; bank < tpm->nr_allocated_banks; bank++) {
+		if (tpm->allocated_banks[bank].digest_size < WP256_DIGEST_SIZE)
+			amt = tpm->allocated_banks[bank].digest_size;
+		else
+			amt = WP256_DIGEST_SIZE;
+		memcpy(digests[bank].digest, coefficient, amt);
+	}
+
+	return tpm_pcr_extend(tpm, TSEM_TRUST_ROOT, digests);
+}
+
+late_initcall(trust_init);
-- 
2.39.1


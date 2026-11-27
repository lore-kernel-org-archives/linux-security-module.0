Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793619;
	b=05j2diP7PD8B+dRt55qMwnIOxT8hEw5ni3KAPmaIrcZ3/jU5YI3qwkpPLAljJ52FExOt
	 HIDTvXRLaWafjP4On6S0kV/hJnHDxDqEJWbRU5PScmjoN7uBE3AtGIFz/FMwQyS1xDcMP
	 p9DqGiGmlBBXaGkFakcr81TILn2mby2kmbI0xw8jL4fsCRrEAX8643EK3WrkQfTmlXwSt
	 z1+WGBvUUK5ree2sFFgc08GMGctG7qhbDRCtBulTcvGap/InAmx8gH+lqVB0XQPO6Ddjq
	 BR70WUYRTBeM/pdQVPvKtO5WziA0lsojo32IlCmYPdqXFEX8+2qnRhLgUPyPEhGknkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793619;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=x2/8GTDXsaBz6os4hGVL08lTYJ9BhOlgXleR4NHJV8w=;
	b=M2ETUhT+e9sUmVMwcH6W08Zt/Gmi8JLZ1qFiFDPo7U7ZIb3+kBt7FJEyEMJV7Cen6nak
	 FcR+TQI0RnJkXeiBiCcCzLHuePpwc5pBAnfIUvlZlwslWQUPUgmqVEFMv70hErFaUKOf0
	 FHpLdJmGaRPwQ9i0m7asfk4xdP+y7r6QlFX+wja7wu9FRR6BYY6XFzrSoianOWYib94D0
	 utVSS2H34+M5GOXdElE+XrOBBUoiU7vqGvnW9LViTVFVhdcRlKEvqxeBP/DOwFEu8xwNc
	 77qlPDUgsbnptdv9+0fsVe4TQm0MF4mxkCNIj0svNWakIgaOvU6TnvZ13oPP0QzfzYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UDUNkc0V;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D69606A693;
	Fri, 27 Nov 2026 15:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D69606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UDUNkc0V
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438641E8D;
	Fri, 27 Nov 2026 07:33:35 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44743F632;
	Fri, 27 Nov 2026 07:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795793617; bh=4Zzl/j59OHehLKoMwPgwk0T4jEc7l6e+C6+y26ZjNKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UDUNkc0VaMTIvkoWV/n4FyuXdE1pSM81ZRBCbh6Y3jJrVGoDW8Ci2vuC0el6tMBcx
	 6gIDfkRc3+tvULP/cgTffheaTrhNegG+zxIy8szaQO1PheiPx8thYCUOk14c4qOKwk
	 0+8nin1hbe+n5FS4hlCKQGdFGiIBE5BP0fSyVDzQ=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 27 Nov 2026 15:33:02 +0000
Subject: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
In-Reply-To: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Suzuki Poulose <suzuki.poulose@arm.com>, 
 Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>, 
 thuth@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
 Pawel Chmielewski <pawel.chmielewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18620; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=4Zzl/j59OHehLKoMwPgwk0T4jEc7l6e+C6+y26ZjNKM=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBrCaK2GCYuekFVHArTx8O4Db0+IrUOryUHZJOx2
 bB7EOV46LeJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCawmitgAKCRBt1cPRWsUx
 M4GPC/9KWWiJp5MrS5uSmkCbENEYwd6CqgRU6ZLCSMkIbakNjJz46ZpJMGozRGL7P6sGEtnHchn
 7gwvS7vR8f1rC7XAw5ol1VUhjyIzWn+FZjZf1zikNCj60HqY4a2h/l21AA3+GpeXwVjU9isrilY
 0QZ3CtY1ETlskHL2vog0kfM1C96kzWBQWs6yQzMBijezLV4NCkB5Nx3/lrQ/fbUOQuMg8ERWmC4
 ZWNtTHjYAOp/XfQ/fszT0z11YdJxThQgq3s3dazX0xcjPDH9J+cbmNVNO44SykbCwhcxKIRiqeR
 auj176ZaOZls5rxCNl98FrofmcpXjr2EDg9FMvW/swP2kfHIMxDT6SNQqJNwhz8w5IfGzuewH0a
 Mu09O4/cWNTALmHyIeS2VTqyAV8F+HAfd1dZSzceKX0rxyCwWPE8lm2EExC7Jn3OYg7ChYWuJ38
 VShugHaz3qpSOCOB4igcRw0n9OsyQJesZfwoCeTUHjStyxuNaMwcsFtBZALwhpCDQhE24=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Introduce CCA Realm Guest attestation provider for retrieving:

  - RIM, REM0-REM3 measurement registers.
  - CCA attestation token
  - CCEL event log

used for CCA Realm Guest attestation.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/attestation/Kconfig               |  10 +
 drivers/attestation/Makefile              |   5 +
 drivers/attestation/providers/cca_guest.c | 582 ++++++++++++++++++++++++++++++
 3 files changed, 597 insertions(+)

diff --git a/drivers/attestation/Kconfig b/drivers/attestation/Kconfig
index e2391ef4aee2d..e4cfe4554ea1e 100644
--- a/drivers/attestation/Kconfig
+++ b/drivers/attestation/Kconfig
@@ -52,4 +52,14 @@ config ATTESTATION_FIRME
 
 	  If you are unsure, say N.
 
+config ATTESTATION_CCA_GUEST
+	tristate "CCA Realm Guest attestation provider"
+	depends on ARM_RMM_RSI && HAVE_ARM_SMCCC_DISCOVERY
+	depends on ARM_CCA_GUEST = n
+	help
+	  Exposes getting RIM, REM, CCA attestation token and CCEL
+	  eventlog operations through the common attestation CTLV family.
+
+	  If you are unsure, say N.
+
 endif # ATTESTATION
diff --git a/drivers/attestation/Makefile b/drivers/attestation/Makefile
index 2c7a1a09daaed..7949e067d4819 100644
--- a/drivers/attestation/Makefile
+++ b/drivers/attestation/Makefile
@@ -17,3 +17,8 @@ obj-$(CONFIG_ATTESTATION_FIRME) += attestation-firme.o
 
 attestation-firme-y := providers/firme.o \
 		       generated/ctlv_attestation_firme_gen.o
+
+obj-$(CONFIG_ATTESTATION_CCA_GUEST) += attestation-cca-guest.o
+
+attestation-cca-guest-y := providers/cca_guest.o \
+			   generated/ctlv_attestation_cca_guest_gen.o
diff --git a/drivers/attestation/providers/cca_guest.c b/drivers/attestation/providers/cca_guest.c
new file mode 100644
index 0000000000000..abd5a06cb9141
--- /dev/null
+++ b/drivers/attestation/providers/cca_guest.c
@@ -0,0 +1,582 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <crypto/sha2.h>
+#include <linux/acpi.h>
+#include <linux/arm-rsi-cmds.h>
+#include <linux/arm-smccc-bus.h>
+#include <linux/arm-smccc-rsi.h>
+#include <linux/attestation.h>
+#include <linux/ctlv.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tpm_eventlog.h>
+#include <linux/workqueue.h>
+
+#include "../generated/ctlv_attestation_cca_guest_gen.h"
+
+struct cca_guest_attestation {
+	struct attestation_dev att;
+	unsigned long version;
+	unsigned long digest_size;
+	size_t max_token_size;
+	int ccel_obj_idx;
+	void *ccel_eventlog;
+	size_t ccel_eventlog_size;
+	struct work_struct state_work;
+};
+
+static struct cca_guest_attestation *to_cca_guest_attestation(struct attestation_dev *att)
+{
+	return container_of(att, struct cca_guest_attestation, att);
+}
+
+static enum hash_algo cca_guest_attestation_algorithms[] = {
+	HASH_ALGO_SHA512,
+};
+
+static const struct attestation_mr_props cca_guest_attestation_mrs[] = {
+	{
+		.id = 0,
+		.name = "rim",
+		.algorithms = cca_guest_attestation_algorithms,
+		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
+	},
+	{
+		.id = 1,
+		.name = "rem0",
+		.algorithms = cca_guest_attestation_algorithms,
+		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
+		.has_register_index = true,
+		.register_index = 0,
+		.extendable = true,
+	},
+	{
+		.id = 2,
+		.name = "rem1",
+		.algorithms = cca_guest_attestation_algorithms,
+		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
+		.has_register_index = true,
+		.register_index = 1,
+		.extendable = true,
+	},
+	{
+		.id = 3,
+		.name = "rem2",
+		.algorithms = cca_guest_attestation_algorithms,
+		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
+		.has_register_index = true,
+		.register_index = 2,
+		.extendable = true,
+	},
+	{
+		.id = 4,
+		.name = "rem3",
+		.algorithms = cca_guest_attestation_algorithms,
+		.algorithms_count = ARRAY_SIZE(cca_guest_attestation_algorithms),
+		.has_register_index = true,
+		.register_index = 3,
+		.extendable = true,
+	},
+};
+
+static const struct attestation_evidence_format cca_attestation_token_formats[] = {
+	{ .vendor = true, .value = CTLV_ATTESTATION_CCA_GUEST_EVIDENCE_VENDOR_FORMAT_CCA_ATTESTATION_TOKEN },
+};
+
+static const struct attestation_evidence_format cca_guest_attestation_log_formats[] = {
+	{ .value = CTLV_ATTESTATION_EVIDENCE_FORMAT_CCEL },
+};
+
+static const struct attestation_evidence_challenge_length
+cca_guest_attestation_challenge_lengths[] = {
+	{ .min = RSI_ATTEST_CHALLENGE_MIN_SIZE, .max = RSI_ATTEST_CHALLENGE_MAX_SIZE },
+};
+
+static struct attestation_evidence_supported_object
+cca_guest_attestation_evidence_objects[] = {
+	{
+		.evidence_class = ATTESTATION_EVIDENCE_SIGNED,
+		.formats = cca_attestation_token_formats,
+		.formats_count = ARRAY_SIZE(cca_attestation_token_formats),
+		.challenge_lengths = cca_guest_attestation_challenge_lengths,
+		.challenge_lengths_count =
+			ARRAY_SIZE(cca_guest_attestation_challenge_lengths),
+		.max_length = 0,
+		.binds_mrs = true,
+	},
+#ifdef CONFIG_ACPI
+	{
+		.evidence_class = ATTESTATION_EVIDENCE_EVENT_LOG,
+		.formats = cca_guest_attestation_log_formats,
+		.formats_count = ARRAY_SIZE(cca_guest_attestation_log_formats),
+		.max_length = 0,
+	},
+#endif
+	/*
+	 * TODO: add LFA log and need to call
+	 * attestation_device_changed_locked() when LFA is done.
+	 */
+};
+
+static struct attestation_evidence_caps cca_guest_attestation_evidence_caps = {
+	.supports_mr_selection = false,
+	.objects = cca_guest_attestation_evidence_objects,
+};
+
+static const struct attestation_mr_caps cca_guest_attestation_mr_caps;
+
+static int cca_guest_hash_init(unsigned long *digest_size)
+{
+	int ret = 0;
+	unsigned long result;
+	struct realm_config *cfg = NULL;
+
+	cfg = alloc_pages_exact(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	result = rsi_get_realm_config(cfg);
+	if (result != RSI_SUCCESS) {
+		ret = -EINVAL;
+		goto exit_free_realm_config;
+	}
+
+	switch (cfg->hash_algo) {
+	case RSI_HASH_SHA_512:
+		cca_guest_attestation_algorithms[0] = HASH_ALGO_SHA512;
+		*digest_size = SHA512_DIGEST_SIZE;
+		break;
+	case RSI_HASH_SHA_384:
+		cca_guest_attestation_algorithms[0] = HASH_ALGO_SHA384;
+		*digest_size = SHA384_DIGEST_SIZE;
+		break;
+	case RSI_HASH_SHA_256:
+		cca_guest_attestation_algorithms[0] = HASH_ALGO_SHA256;
+		*digest_size = SHA256_DIGEST_SIZE;
+		break;
+	default:
+		/* Unknown/unsupported algorithm. */
+		pr_err("Unknown/unsupported Realm hash algorithm: %u\n", cfg->hash_algo);
+		ret = -EINVAL;
+		break;
+	}
+
+exit_free_realm_config:
+	free_pages_exact(cfg, RSI_GRANULE_SIZE);
+	return ret;
+}
+
+#ifdef CONFIG_ACPI
+static void *cca_guest_ccel_init(size_t *length)
+{
+	int ret;
+	acpi_status status;
+	void *entry, *end, *eventlog = NULL;
+	void __iomem *virt;
+	struct acpi_table_ccel *ccel;
+	size_t entry_size, eventlog_size = 0;
+	struct tcg_pcr_event *event_header;
+
+	status = acpi_get_table(ACPI_SIG_CCEL, 1,
+			       (struct acpi_table_header **)&ccel);
+	if (ACPI_FAILURE(status)) {
+		ret = 0;
+		pr_info("CCEL table is not found\n");
+		goto disable_ccel;
+	}
+
+	if (ccel->CCtype != ACPI_CCEL_CCTYPE_ARM_CCA ||
+	    !ccel->log_area_minimum_length || !ccel->log_area_start_address) {
+		ret = -EINVAL;
+		pr_err("Invalid CCEL table!\n");
+		goto disable_ccel;
+	}
+
+	eventlog = kvmalloc(ccel->log_area_minimum_length, GFP_KERNEL);
+	if (!eventlog) {
+		ret = -ENOMEM;
+		goto disable_ccel;
+	}
+
+	virt = acpi_os_map_iomem(ccel->log_area_start_address,
+				 ccel->log_area_minimum_length);
+	if (!virt) {
+		ret = -ENODEV;
+		goto disable_ccel;
+	}
+	memcpy_fromio(eventlog, virt, ccel->log_area_minimum_length);
+	acpi_os_unmap_iomem(virt, ccel->log_area_minimum_length);
+
+	event_header = entry = eventlog;
+	end = (u8 *)entry + ccel->log_area_minimum_length;
+
+	entry_size = struct_size(event_header, event, event_header->event_size);
+	eventlog_size += entry_size;
+
+	if (eventlog_size > ccel->log_area_minimum_length ||
+	    event_header->event_size == 0) {
+		ret = -EINVAL;
+		goto disable_ccel;
+	}
+
+	do {
+		entry = (u8 *)entry + entry_size;
+		if (entry >= end)
+			break;
+
+		entry_size = __calc_tpm2_event_size(entry, event_header, false);
+
+		eventlog_size += entry_size;
+		if (eventlog_size > ccel->log_area_minimum_length) {
+			ret = -EINVAL;
+			goto disable_ccel;
+		}
+	} while (entry_size);
+
+	acpi_put_table((struct acpi_table_header *)ccel);
+
+	*length = eventlog_size;
+
+	entry = kvrealloc(eventlog, eventlog_size, GFP_KERNEL);
+	if (entry)
+		eventlog = entry;
+
+	return eventlog;
+
+disable_ccel:
+	if (eventlog)
+		kvfree(eventlog);
+
+	acpi_put_table((struct acpi_table_header *)ccel);
+	*length = 0;
+	return ERR_PTR(ret);
+}
+#else
+static void *cca_guest_ccel_init(size_t *length)
+{
+	*length = 0;
+	return NULL;
+}
+#endif
+
+static long cca_guest_get_max_token_size(void)
+{
+	u8 dummy[RSI_ATTEST_CHALLENGE_MAX_SIZE] = { 0x00, };
+
+	return rsi_attestation_token_init(dummy, RSI_ATTEST_CHALLENGE_MAX_SIZE);
+}
+
+static int cca_guest_get_attest_tokens(const struct cca_guest_attestation *cca_guest_att,
+				       const void *challenge, size_t challenge_size,
+				       u8 *token, size_t *token_size)
+{
+	int ret;
+	long max_token_size;
+	void *buf;
+	unsigned long granule, offset, len, rsi_ret;
+
+	guard(migrate)();
+
+	max_token_size = rsi_attestation_token_init(challenge, challenge_size);
+	if (max_token_size <= 0)
+		return -EINVAL;
+
+	if (max_token_size != cca_guest_att->max_token_size)
+		return -ESTALE;
+
+	buf = alloc_pages_exact(RSI_GRANULE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	granule = (unsigned long)virt_to_phys(buf);
+	*token_size = 0;
+
+	do {
+		offset = 0;
+		do {
+			len = 0;
+			rsi_ret = rsi_attestation_token_continue(granule, offset,
+								 RSI_GRANULE_SIZE - offset,
+								 &len);
+			offset += len;
+		} while (rsi_ret == RSI_INCOMPLETE &&
+			 offset < RSI_GRANULE_SIZE);
+
+		if (rsi_ret != RSI_SUCCESS && rsi_ret != RSI_INCOMPLETE) {
+			ret = -ENXIO;
+			*token_size = 0;
+			goto err_out;
+		}
+
+		if (WARN_ON(*token_size + offset > max_token_size))
+			break;
+
+		memcpy(&token[*token_size], buf, offset);
+		*token_size += offset;
+	} while (rsi_ret == RSI_INCOMPLETE);
+
+	ret = 0;
+
+err_out:
+	free_pages_exact(buf, RSI_GRANULE_SIZE);
+	return ret;
+}
+
+static void cca_guest_state_workfn(struct work_struct *work)
+{
+	struct cca_guest_attestation *cca_guest_att =
+		container_of(work, struct cca_guest_attestation, state_work);
+	long max_token_size;
+
+	guard(mutex)(&cca_guest_att->att.lock);
+
+	max_token_size = cca_guest_get_max_token_size();
+	if (WARN_ON(max_token_size <= 0))
+		return;
+
+	if (max_token_size == cca_guest_att->max_token_size)
+		return;
+
+	cca_guest_att->max_token_size = max_token_size;
+	cca_guest_attestation_evidence_objects[0].max_length = max_token_size;
+
+	attestation_state_changed_locked(&cca_guest_att->att);
+	return;
+}
+
+static int
+cca_guest_attestation_evidence_get(struct attestation_dev *att,
+				   const struct attestation_evidence_request *request,
+				   struct attestation_evidence_result *result)
+{
+	struct cca_guest_attestation *cca_guest_att = to_cca_guest_attestation(att);
+	size_t i, length;
+	void *buffer;
+	int ret = 0, ccel_obj_idx;
+
+	ccel_obj_idx = cca_guest_att->ccel_obj_idx;
+
+	for (i = 0; !ret && i < request->objects_count; i++) {
+		const struct attestation_evidence_object_request *object =
+			&request->objects[i];
+		struct attestation_evidence_object_result *produced =
+			&result->objects[i];
+
+		buffer = kvmalloc(object->supported_object->max_length, GFP_KERNEL);
+		if (!buffer)
+		return -ENOMEM;
+
+		if (object->supported_object == &cca_guest_attestation_evidence_objects[0]) {
+			ret = cca_guest_get_attest_tokens(cca_guest_att, request->challenge,
+							  request->challenge_length,
+							  buffer, &length);
+			if (!ret)
+				produced->format = cca_attestation_token_formats[0];
+		} else if (ccel_obj_idx &&
+			   object->supported_object == &cca_guest_attestation_evidence_objects[ccel_obj_idx]) {
+			length = cca_guest_att->ccel_eventlog_size;
+			memcpy(buffer, cca_guest_att->ccel_eventlog, length);
+			produced->format = cca_guest_attestation_log_formats[0];
+			ret = 0;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+
+		if (ret == -ESTALE)
+			schedule_work(&cca_guest_att->state_work);
+
+		if (!ret)
+			ret = attestation_evidence_write(object, buffer, length);
+		if (!ret)
+			produced->length = length;
+
+		kvfree(buffer);
+	}
+
+	return ret;
+}
+
+static int
+cca_guest_attestation_mr_read(struct attestation_dev *att, unsigned int mr_id,
+			      const struct ctlv_cursor *mr_options,
+			      struct attestation_digest_set *values)
+{
+	struct cca_guest_attestation *cca_guest_att = to_cca_guest_attestation(att);
+	unsigned long ret;
+
+	if (mr_id >= ARRAY_SIZE(cca_guest_attestation_mrs) ||
+	    values->values_count != 1)
+		return -EINVAL;
+
+	ret = rsi_measurement_read(mr_id, values->values[0].data,
+				   cca_guest_att->digest_size);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+cca_guest_attestation_mr_extend(struct attestation_dev *att, unsigned int mr_id,
+			  const struct ctlv_cursor *mr_options,
+			  const struct attestation_digest_set *values)
+{
+	struct cca_guest_attestation *cca_guest_att = to_cca_guest_attestation(att);
+	unsigned long ret;
+
+	if (values->values_count != 1)
+		return -EINVAL;
+
+	if (mr_id < 1 || mr_id > 4)
+		return -EOPNOTSUPP;
+
+	ret = rsi_measurement_extend(mr_id, values->values[0].data,
+				     cca_guest_att->digest_size);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct attestation_provider cca_guest_attestation_provider = {
+	.evidence_get = cca_guest_attestation_evidence_get,
+	.mr_read = cca_guest_attestation_mr_read,
+	.mr_extend = cca_guest_attestation_mr_extend,
+	.evidence_caps = &cca_guest_attestation_evidence_caps,
+	.mr_caps = &cca_guest_attestation_mr_caps,
+	.mrs = cca_guest_attestation_mrs,
+	.mrs_count = ARRAY_SIZE(cca_guest_attestation_mrs),
+};
+
+int ctlv_attestation_cca_guest_device_info_fill(struct ctlv *ctlv,
+						struct ctlv_op_ctx *ctx,
+						const struct ctlv_cursor *request,
+						struct ctlv_cursor *record)
+{
+	const struct cca_guest_attestation *cca_guest_att =
+		to_cca_guest_attestation(attestation_from_ctlv(ctlv));
+	bool ok;
+
+	ok = ctlv_attestation_cca_guest_device_info_version_put(record, cca_guest_att->version);
+	return ok ? 0 : -EMSGSIZE;
+}
+
+void ctlv_attestation_cca_guest_device_info_read(struct ctlv *ctlv,
+						 struct ctlv_op_ctx *ctx,
+						 const struct ctlv_cursor *record)
+{
+}
+
+static int cca_guest_attest_drv_probe(struct arm_smccc_device *sdev)
+{
+	int ret, objects_count = 0;
+	unsigned long lower, upper, digest_size;
+	long max_token_size;
+	void *eventlog;
+	size_t eventlog_size;
+	struct cca_guest_attestation *cca_guest_att;
+	int ccel_obj_idx = 0;
+
+	ret = rsi_request_version(RSI_ABI_VERSION, &lower, &upper);
+	if (ret)
+		return ret;
+
+	ret = cca_guest_hash_init(&digest_size);
+	if (ret)
+		return ret;
+
+	max_token_size = cca_guest_get_max_token_size();
+	if (max_token_size <= 0)
+		return -EINVAL;
+
+	eventlog = cca_guest_ccel_init(&eventlog_size);
+	if (IS_ERR(eventlog))
+		return PTR_ERR(eventlog);
+
+	pr_info("CCA Realm guest RSI version %lu.%lu\n",
+		RSI_ABI_VERSION_GET_MAJOR(RSI_ABI_VERSION),
+		RSI_ABI_VERSION_GET_MINOR(RSI_ABI_VERSION));
+	pr_info("Maximum Attestation token size: 0x%lx\n", max_token_size);
+	pr_info("Eventlog Size: 0x%zx\n", eventlog_size);
+
+	cca_guest_attestation_evidence_objects[objects_count++].max_length = max_token_size;
+
+	if (eventlog && eventlog_size > 0) {
+		ccel_obj_idx = objects_count;
+		cca_guest_attestation_evidence_objects[objects_count++].max_length = eventlog_size;
+	}
+
+	if (WARN_ON_ONCE(objects_count > ARRAY_SIZE(cca_guest_attestation_evidence_objects)))
+		return -EINVAL;
+
+	cca_guest_attestation_evidence_caps.objects_count = objects_count;
+
+	cca_guest_att = attestation_alloc(&sdev->dev,
+					  &cca_guest_attestation_provider,
+					  &ctlv_attestation_cca_guest_family,
+					  struct cca_guest_attestation, att);
+	if (IS_ERR(cca_guest_att)) {
+		ret = PTR_ERR(cca_guest_att);
+		goto free_eventlog;
+	}
+
+	cca_guest_att->version = RSI_ABI_VERSION;
+	cca_guest_att->digest_size = digest_size;
+	cca_guest_att->max_token_size = max_token_size;
+	cca_guest_att->ccel_obj_idx = ccel_obj_idx;
+	cca_guest_att->ccel_eventlog = eventlog;
+	cca_guest_att->ccel_eventlog_size = eventlog_size;
+	INIT_WORK(&cca_guest_att->state_work, cca_guest_state_workfn);
+
+	ret = attestation_register(&cca_guest_att->att);
+	if (ret) {
+		attestation_put(&cca_guest_att->att);
+		goto free_eventlog;
+	}
+
+	dev_set_drvdata(&sdev->dev, cca_guest_att);
+
+	pr_info("CCA Realm Guest attestation ctlvdev is registered\n");
+
+	return 0;
+
+free_eventlog:
+	if (eventlog)
+		kvfree(eventlog);
+	return ret;
+}
+
+static void cca_guest_attest_drv_remove(struct arm_smccc_device *sdev)
+{
+	struct cca_guest_attestation *cca_guest_att = dev_get_drvdata(&sdev->dev);
+
+	if (!cca_guest_att)
+		return;
+
+	attestation_unregister(&cca_guest_att->att);
+	cancel_work_sync(&cca_guest_att->state_work);
+	if (cca_guest_att->ccel_eventlog)
+		kvfree(cca_guest_att->ccel_eventlog);
+	attestation_put(&cca_guest_att->att);
+	dev_set_drvdata(&sdev->dev, NULL);
+}
+
+static const struct arm_smccc_device_id cca_guest_attest_id_table[] = {
+	{ .func_id = SMC_RSI_ABI_VERSION, },
+	{ },
+};
+MODULE_DEVICE_TABLE(arm_smccc, cca_guest_attest_id_table);
+
+static struct arm_smccc_driver cca_guest_attest_drv = {
+	.name = KBUILD_MODNAME,
+	.probe = cca_guest_attest_drv_probe,
+	.remove = cca_guest_attest_drv_remove,
+	.id_table = cca_guest_attest_id_table,
+};
+module_arm_smccc_driver(cca_guest_attest_drv);
+
+MODULE_DESCRIPTION("CCA Realm Guest attestation provider");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("ATTESTATION");
+MODULE_IMPORT_NS("CTLV");
+MODULE_IMPORT_NS("CCA_GUEST");

-- 
2.43.0


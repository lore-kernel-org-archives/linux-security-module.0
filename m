Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628033;
	b=ovKBgcmlSNI4PHIxVrOyhKqhX9SjP6XfCjRfyJuBr1egxnJ+sIrVADDPanVnfUjKUct2
	 IvFikrkt5IeeaVXs0uQ278iJIlC9G98Iv3JVHBGvwIw3LPiJUbu9LZX9WayJ3sJ8A7xxG
	 6pQEhZfwfQPCukqKTomfWA+BfPvCa7gHJGmDhS3peEEOCQWIMtPMSx/R2DrIJFxAgPHWe
	 Yq9d89oY9nDpzmuCJyxl2WHoS9ttKNIS3OjrKLzQQ9cxChkZPg5pWP3mWcfQ0+ovWLsMB
	 HD6uHtB5RWXhfIbwKhVH8LkiwbxmkgG7CBPt3ScSY5vwpvHtxSN+2wsXUaKcysKaCdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628033;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=GB/VLmX65XjZJj9xJdNwGdXvO50EqC1ZNq9+LRgQ+XA=;
	b=Sc0xZMCOVRcatcfaWrcT5auS7fwQh6XWJeIgpYBujr1DfAtpuvUtq3BlxSNA3wpRn79K
	 rTP/MIKVJKux9aoj4PeYTflwendcMRO9xoF+NgqlsMUvhjh3dwnygjw2Llt/7vzq+2N4d
	 bDimcBWw/65lEI3uK7yE304/+MgC4kVAaLJ3lpAyGY6NiSFaEZqTXIainvALKeAU+4/Ku
	 Y/7eA5GSf68ALLRgIuRjEkV7rjf4H0dkMx52umvMHCPXfwLUa+Pb6prKl40WRSBjBtKtO
	 gNKRu2XQID88hS9rtI+IeojJKvGwf7w7zEiRot4qsyp6PDdzfgahdVWzep4qEbStIzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpwSVcmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFE60A3808;
	Mon,  2 Nov 2026 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpwSVcmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FC51F00A17;
	Mon,  2 Nov 2026 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628032;
	bh=GB/VLmX65XjZJj9xJdNwGdXvO50EqC1ZNq9+LRgQ+XA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dpwSVcmdSacwVhw2o2sojK+H7kPFehT/c+0wmYVpc6fqQkg77nrwlBuLW7doMEGgj
	 heE/Jd2POcq1Ut2xIOGMcYTVhkKbsnXXvWWNq/WSX9C83V5PwB/izSbRBpxeVycAWd
	 AEnSLTRLmmKV5WPHZFbvRkZ9yR+QhF1KHJCCCmrXh6yTYWMgSZU783osHsASOHxoeL
	 gcO+TjY42dg7e2qWwFOTpkFIxeVovXMiczk9twHxxWGH70Y15ev7vDEzIny/4aPFNy
	 gz2HYwpeL4zfKvn8APs4MhPLNT2fAnvGb/1+Jjqwld2E6QW7dKaaHNw/ZykWzWWYLe
	 jF80nhPBdb3KQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 02 Nov 2026 08:00:26 -0600
Subject: [PATCH 2/2] security: lockdown: Prevent boot with lockdown but no
 IOMMU
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
Message-Id: <20261102-lockdown-iommu-v1-2-00f3c2be4c9f@kernel.org>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
In-Reply-To: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>
X-Mailer: b4 0.16.0

Lockdown is a kernel LSM that restricts access to sensitive kernel
resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
device can perform DMA to arbitrary physical memory, effectively
bypassing all lockdown protections.

A malicious or compromised device can:
- Read kernel memory directly (encryption keys, credentials, secrets)
- Write to kernel memory directly (code patches, rootkits, backdoors)
- Circumvent all lockdown LSM checks (which run inside the kernel)

Add a two-phase check to prevent booting with lockdown enabled and
IOMMU disabled:

1. Early check (in lockdown_lsm_init()): On x86, check the no_iommu
   flag, which is set early by the 'iommu=off' kernel cmdline option.
   If lockdown is active and no_iommu is set, panic with a clear error.

2. Late check (late_initcall): On all architectures, check
   iommu_is_available() which returns true if any IOMMU driver
   registered successfully. This catches cases where:
   - IOMMU hardware is absent on the platform
   - IOMMU was disabled by driver initialization failure
   - IOMMU was not detected (broken firmware, missing ACPI tables)

This follows the precedent set by s390 UV code which panics when
security cannot be guaranteed ("System security cannot be guaranteed
unless the system panics now").

Also update iommu_device_register() to call iommu_set_available() on
successful registration, so all IOMMU drivers automatically signal
their availability.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 security/lockdown/lockdown.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8d46886d2cca0..6ce1490188d5d 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -13,8 +13,14 @@
 #include <linux/security.h>
 #include <linux/export.h>
 #include <linux/lsm_hooks.h>
+#include <linux/init.h>
 #include <uapi/linux/lsm.h>
 
+#if IS_ENABLED(CONFIG_X86)
+#include <asm/iommu.h>
+#endif
+#include <linux/iommu.h>
+
 static enum lockdown_reason kernel_locked_down;
 
 static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
@@ -88,6 +94,25 @@ static int __init lockdown_lsm_init(void)
 #elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
+
+	/*
+	 * If lockdown was activated (via command line or kernel config)
+	 * and IOMMU is disabled, refuse to boot. Without IOMMU, any
+	 * PCI/PCIe device can perform DMA to arbitrary physical memory,
+	 * completely bypassing lockdown protections.
+	 *
+	 * On x86, 'no_iommu' is set early by the 'iommu=off' cmdline
+	 * option during parse_early_param(), before this init function.
+	 */
+#if IS_ENABLED(CONFIG_X86)
+	if (kernel_locked_down > LOCKDOWN_NONE && no_iommu) {
+		pr_err("FATAL: Lockdown is active but IOMMU is disabled.\n");
+		pr_err("FATAL: PCI devices can perform DMA to arbitrary memory,\n");
+		pr_err("FATAL: bypassing all lockdown protections.\n");
+		panic("Lockdown enabled but IOMMU is disabled (no_iommu)\n");
+	}
+#endif
+
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
 			   &lockdown_lsmid);
 	return 0;
@@ -170,3 +195,43 @@ DEFINE_LSM(lockdown) = {
 	.init = lockdown_lsm_init,
 	.initcall_core = lockdown_secfs_init,
 };
+
+/*
+ * Late init call to verify IOMMU availability when lockdown is active.
+ * This catches cases where:
+ *  - IOMMU hardware is absent on the platform
+ *  - IOMMU was disabled by driver initialization failure
+ *  - IOMMU was not detected (e.g. broken firmware, missing ACPI tables)
+ *
+ * On x86, we also check no_iommu here as a double-check. The early check
+ * in lockdown_lsm_init() catches 'iommu=off' from the cmdline before
+ * lockdown_lsm_init() runs, but this late check covers any missed cases.
+ */
+static int __init lockdown_check_iommu(void)
+{
+	if (kernel_locked_down > LOCKDOWN_NONE) {
+		/*
+		 * Check generic IOMMU availability (all architectures).
+		 * iommu_is_available() returns true if any IOMMU driver
+		 * registered successfully.
+		 */
+		if (!iommu_is_available()) {
+			pr_err("FATAL: Lockdown is active but no IOMMU driver\n");
+			pr_err("FATAL: registered. PCI devices can DMA to\n");
+			pr_err("FATAL: arbitrary memory, bypassing lockdown.\n");
+			panic("Lockdown enabled but IOMMU not available\n");
+		}
+#if IS_ENABLED(CONFIG_X86)
+		/*
+		 * Also double-check x86-specific flag.
+		 */
+		if (no_iommu) {
+			pr_err("FATAL: Lockdown is active but IOMMU disabled\n");
+			pr_err("FATAL: via kernel command line (iommu=off).\n");
+			panic("Lockdown enabled but IOMMU disabled (iommu=off)\n");
+		}
+#endif
+	}
+	return 0;
+}
+late_initcall(lockdown_check_iommu);

-- 
2.53.0


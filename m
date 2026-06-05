Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2493CFF6C;
	Fri,  5 Jun 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670627; cv=none; b=EjbstUmzOOH97NN/01h24VrtFNexwTCEhob1s7xmnnab/hEY3h/1RHVCAwM6kn7BbfT2hnPpnprNn6I/skEbD2A3vQW4qi3FSnpdNfrQ+u3AjLUccp3Yu0TTDW6Ht28kvwtyuRWuv4foPOIbi1DVwvjeYiMpYLBucZ9tmsDO4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670627; c=relaxed/simple;
	bh=Q1T/dDNjJpSw5e0YB7HdLHFPMQUq6Qcw8HEO3cVJDsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6hVpe8VpmNILrQFHN9tSSMZhxLzO9sCiXTQNtr777JkVO5Xp5KiIBGvCCz27OjdFpTB/8CUu+aHxlMNj8VRDqBiMhuMg994TxddCW+xD+cgGFUZSkcS8P7bFE0hgEUMcDAkR1qyaxz4E1+EAoCMKlhi0nXgu4gAFPmy0HRszq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K17fqBbA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K17fqBbA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663252BC6;
	Fri,  5 Jun 2026 07:43:38 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AA5E3F7D8;
	Fri,  5 Jun 2026 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670623; bh=Q1T/dDNjJpSw5e0YB7HdLHFPMQUq6Qcw8HEO3cVJDsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K17fqBbA+wjIoD+vHPRYJ/j9UFEE9i2S3w2yCmfmSwpGhgHZkz3YQ8ceH/w6exmON
	 S4pLLSm2iIa25nAw/qIbWTJKiy7FZb2fLPpDFVVrIkMMjJVdNK7eueI1B5NUNyjrG4
	 lv1roe00Ncxtb/4AGzK6FTRFhLg3K3T2Q++XgyX0=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com,
	zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	noodles@earth.li,
	jarkko@kernel.org,
	sudeep.holla@kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jgg@ziepe.ca,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v6 2/4] security: ima: introduce IMA_INIT_LATE_SYNC option
Date: Fri,  5 Jun 2026 15:43:23 +0100
Message-Id: <20260605144325.434436-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605144325.434436-1-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To generate the boot_aggregate log in the IMA subsystem with
TPM PCR values, the TPM driver must be built as built-in and
must be probed before the IMA subsystem is initialized.

However, when the TPM device operates over the FF-A protocol using
the CRB interface, probing fails and returns -EPROBE_DEFER if
the tpm_crb_ffa device — an FF-A device that provides the communication
interface to the tpm_crb driver — has not yet been probed.

To ensure the TPM device operating over the FF-A protocol with
the CRB interface is probed before IMA initialization,
the following conditions must be met:

1. The corresponding ffa_device must be registered,
   which is done via ffa_init().

2. The tpm_crb_driver must successfully probe this device via
   tpm_crb_ffa_init().

3. The tpm_crb driver using CRB over FF-A can then
   be probed successfully. (See crb_acpi_add() and
   tpm_crb_ffa_init() for reference.)

Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()
are all registered with device_initcall, which means
crb_acpi_driver_init() may be invoked before ffa_init() and
tpm_crb_ffa_init() are completed.

When this occurs, probing the TPM device is deferred.
However, the deferred probe can happen after the IMA subsystem
has already been initialized, since IMA initialization is performed
during late_initcall, and deferred_probe_initcall() is performed
at the same level.

And the similar situation is reported on TPM devices attached on SPI
bus[0].

To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
IMA at late_inicall_sync so that IMA is initialized with the TPM
device probed deferred.

When this option is enabled, modules that access files in the
initramfs through usermode helper calls such as request_module()
during initcall must not be built-in. Otherwise, IMA may miss
measuring those files [1].

Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 security/integrity/ima/Kconfig    | 10 ++++++++++
 security/integrity/ima/ima_main.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 862fbee2b174..75f71401fba3 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -332,4 +332,14 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
 	  If set to the default value of 0, an extra half page of memory for those
 	  additional measurements will be allocated.
 
+config IMA_INIT_LATE_SYNC
+	bool "Initialise IMA at late_initcall_sync"
+	default n
+	help
+	  This option initialises IMA at late_initcall_sync for platforms
+	  where TPM device probing is deferred.
+	  When this option is enabled, modules that access files in the
+	  initramfs through usermode helper calls such as request_module()
+	  during initcall must not be built-in. Otherwise, IMA may miss
+	  file measurements for them.
 endif
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5cea53fc36df..1cfae4b83dc5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1337,5 +1337,9 @@ DEFINE_LSM(ima) = {
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
 	/* Start IMA after the TPM is available */
+#ifndef CONFIG_IMA_INIT_LATE_SYNC
 	.initcall_late = init_ima,
+#else
+	.initcall_late_sync = init_ima,
+#endif
 };
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


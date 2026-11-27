Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793605;
	b=ChSqixz2kk9+opGD6lRQYp+0ulQkRdmfeB+wkGErJWvUp28UrWMWugeNY9TRKUiMRKwN
	 llM+A7jqYghiXmBVqxHmi9hhlKf+RT2FrIDNwq27FUblEnE20xF3jiP/yiV8uZABN1Jaf
	 zhYZhm3xpNdAgNu0nH5PA0GuRJ4U1bs6Vwqxcvnudvd4oDAlcmn93wBFHaEl80lW49slR
	 XHsj5hSMBocB5CitT5MnAgwrKR5/2nvr6mkPocjMthMEv5ZYhZNpCANnfFhzIGGJnSYYv
	 pLfO3/9ItVCo6rX41y62OjsYEQemTkTgUUB4NNTxv2ie3x4M6zN2MDL146mv3wywrug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793605;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=oRtgKudCp/VASC+XZuTjAPaIg7QOvB2qmO6nzhhb1yI=;
	b=NXn2WZzQOujR9LaY4X1se9XPcHB/FOc4zgJ27o3F0D6tn9KADU+yGUtdN/slAsvZbklS
	 lz135YfgkBFKADPYgJU5Gpalrghz5RpGvKM/G5XmoJ2QxiDyWYSgi3SioFTgcAHjqQghx
	 MceFnbsF9AIUJuSY89ZOdE4DfOp+FfSU5aLJXyO9YeXB3FPfGpZJjqfOKOkCwgev93zJF
	 T45Dv8ucLhPhHCddFyR6W69cnDtG9lXTHyYZ1vuwpijoBeA4083FeWsGMtQMbINqUxd7A
	 pq03SY+RR6SOEQ60gayWhyv+oysx0y65McWPGwhaJXse4iYItI4c//IRG4KgUnG/Z5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rSJCPZmA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C1606A31C;
	Fri, 27 Nov 2026 15:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rSJCPZmA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4421D70;
	Fri, 27 Nov 2026 07:33:21 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366003F632;
	Fri, 27 Nov 2026 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795793604; bh=LRigvAJhp+2eLJBX6kefUPGIgYbEzkL9gINj2qEXMik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rSJCPZmAVLAT6McHtVMqDDZNAWlk36c1D4BkzXv1OrFuevUAlQbVlJbPEGWUFYlOl
	 c9a4RVnb0n7aYlcqSYAcLpWU4HHrKS9XbUSynUtZ7erovk9Jf6qZD4jPYetKZh29LK
	 IFrx2faozQTDi9MlxebS7vlc+alv5cDBsOcRTGCw=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 27 Nov 2026 15:32:58 +0000
Subject: [PATCH RFC v3 3/8] arm64: acpi: Enable ACPI CCEL support
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
Message-Id: <20261127-arm_cca_mr-v3-3-df3230afce8f@arm.com>
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
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Gavin Shan <gshan@redhat.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=Y0OSdCtnotPMPPdxEFeJ/K5QTuVjcFwxETs3OgoHwHU=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBrCaK0QrrxLQz97qermy0wQEP8E7gn26M5bOINn
 UgzQQ/WVl+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCawmitAAKCRBt1cPRWsUx
 M4f9C/9nSjXn69EzPPM8K6RQUBfOMIwloMkG7YJrYryOPA6cDfPFdBXQ25/PEFaQcSup+8bb4Nw
 4+x4uL3xbUC8AhRWTOxCg1GjmcS27c7YHiOvPGoZsOodsBVKKPMWyfeAzKFeH4u9eEv+AzFggCw
 sRseP1c+bM7A+H/wuCkVXVZ5UG9bM0llrALZ6UQjHVHcEijB/L/wxiDPuJkf1rvvbgXg0nMPGhK
 /qEoZaLWBqgfULONIvsSKj0ODieQS32ZZ9fQkqRvw+7QoqGkvopVcXWm9ry+jNkn7D6PI0smsRC
 s35Arw0UiAVaKXOU0zvobWotKX3HuXCwA8p1w+BxpPJ2pXuIMXVqhGvgq5UMUuqZeL9Tp3BZ7hT
 93bgAIGg5e02FL0/gKMZHUqTSLdi836xgQwUq4NP7uJSH8bnIP1VxwdPfkkbZ26VpI4HXO5XiMm
 eurk7irjMBevkbZfjQd732DS+10uukqYTpUAHqnDsE6LxpzOeLPIzQKOWTmAX9gwiwxFA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for ACPI CCEL by handling the EfiACPIMemoryNVS type memory.
As per UEFI specifications NVS memory is reserved for Firmware use even
after exiting boot services. Thus map the region as read-only.

Cc: Sami Mujawar <sami.mujawar@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kernel/acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 681aa2bbc3995..3d6335db882d3 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -354,6 +354,17 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 			prot = PAGE_KERNEL_RO;
 			break;
 
+		case EFI_ACPI_MEMORY_NVS:
+			/*
+			 * ACPI NVS marks an area reserved for use by the
+			 * firmware, even after exiting the boot service.
+			 * This may be used by the firmware for sharing dynamic
+			 * tables/data (e.g., ACPI CCEL) with the OS. Map it
+			 * as read-only.
+			 */
+			prot = PAGE_KERNEL_RO;
+			break;
+
 		case EFI_ACPI_RECLAIM_MEMORY:
 			/*
 			 * ACPI reclaim memory is used to pass firmware tables

-- 
2.43.0


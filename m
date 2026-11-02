Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628031;
	b=huUq4Ka8L4Y8ac83mNf0O1+2d7l4aiF+W24k4uCsCCzTfhs3+dqW4JqgCXsBZf8ib4ON
	 xqb55YNQb8nlJeFXIB6ZniXutVl7u0I1sT9swvS6ILg7M1FtmJllS4IS2YWy53PPN+dT5
	 6bn5fCp1+agZHWvfOeuk6RVJ7y6ra/qihOlkbSHQggBmpvLm1AkzvWKuQ3nRg2aPFQYbd
	 F6ejKOxDUGvVPSFSCZNSxSx5/qiYD3HkJxVTnfNsgF8WPoF31F6ZSr5e7FtUPsIhiYVv8
	 LP05JK3SNd2xva8ejwECtd3aHr7QcZBsbUewcJV8eAgbDatajZz44arCZo+FpQSUo7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628031;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=KaUEuxrRTuoQH6zZSnhhKmJ5p3zPxmMoHvVEVZALyo8=;
	b=qLGJ+fvGg1QW4HrPq3mRTLVl6E7KtZSzgzLsOcsKu4Utw6Jz++cJv03bK8O5hdPqqF1b
	 7X2NyIclcjdt04G7Zr0+GxqRFc8y/ntqtFjhkROKLqjuWOtL5DbDtOLb9BrL7DTt6dihQ
	 zs8QrE2lVVlgSFrg8xaW8vnZDCnOjJU99GKuhRtYtd3UaM8665xQhdR09ommmlaAdGc2B
	 oL8WLn6u3jMmoWyBpWpIqxI2393kdkAG3tPX/QYrwcyHU84LOTVAOg44P22+Mgf8ynjj/
	 wHT5UhxHaHjwmmUKavVeEUMICD9ZlmxZEUgmpjpP/fZWBgsNdxmEqWpLyr/XfS3zrYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fdb0qfS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DB60A262E;
	Mon,  2 Nov 2026 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fdb0qfS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0991F00A18;
	Mon,  2 Nov 2026 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628030;
	bh=KaUEuxrRTuoQH6zZSnhhKmJ5p3zPxmMoHvVEVZALyo8=;
	h=From:Subject:Date:To:Cc;
	b=Fdb0qfS3NpYSqj4nEOvz9946diDzvK63nknJjAo1G38HjB9a4iYRKL4XsQSkz6kjf
	 syI9hxlyC2kEez/3Z/rfyVbYgE0OP7IQXQBrVxqH7V3tsFgdk128gyThvQiV/q13C0
	 BBFgAEvrtSPzzhDenud65Ysvn0gxiOFwP36imGhFluNIMimVtSjSJUYyfHQVptfsYg
	 EUVT0IUDbUW/Q5DpmPCZCnIO697YWgmdpi4hc1dpXep13vklzYOwgy6aUYv7+SlNL8
	 AZffxU5U05bA9BEPhmLp+E70uxukoxzWURLJAY1G6S8p/Cu0CyZ9i2tFkQ0/Y5nBG2
	 zDXUcwsnHJ02w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Date: Mon, 02 Nov 2026 08:00:24 -0600
Message-Id: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0MT3Zz85OyU/PI83cz83NxSXQOLZHMz4xTLNEvDlBQloK6CotS0zAq
 widGxEH5xaVJWanIJyBil2loARlbfWXMAAAA=
X-Change-ID: 20261014-lockdown-iommu-08c763d9f91dd
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

This series adds a two-phase check to prevent booting with lockdown
enabled and IOMMU disabled:

1. Early check (in lockdown_lsm_init()): On x86, check the no_iommu
   flag, which is set early by the "iommu=off" kernel cmdline option.
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

This also adds a generic iommu_is_available() API in the IOMMU
subsystem, which is used by the lockdown check. Any IOMMU driver
that successfully registers will automatically call
iommu_set_available() from iommu_device_register().

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

---
Mario Limonciello (AMD) (2):
      iommu: Add iommu_is_available() API
      security: lockdown: Prevent boot with lockdown but no IOMMU

 drivers/iommu/iommu.c        | 48 ++++++++++++++++++++++++++++++++
 include/linux/iommu.h        | 14 ++++++++++
 security/lockdown/lockdown.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261014-lockdown-iommu-08c763d9f91dd

Best regards,
--  
Mario Limonciello <superm1@kernel.org>


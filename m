Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382228;
	b=Z2Ujw+C3Zr2bwXMW5upSnPmGLX7RxvI1BiHf2QDMCpCauR7C+2T+uM/VNZa36tPQmtyp
	 6Mo9/hj5ryCCdmAPPwf9xNo2DUjazty55h3OAGTzC2d2DZEqUzoEnVxzT34ko5Tunspws
	 /i1OkgHMNkb6IVRohqukx6fgfjbRWqBa57X3ttSaFw9IkKHVp1nCz7+Bv2ZztFqpqjpSq
	 54Hk/eEzfSz5xNvW1Dekw7b6/MKRBWq0jINpZk7j+7kvF56XCrGSB+945UtFAuKAgUoRW
	 r+rgzwd8lsC4o2HdqWOSLupzIsIHjeuylc8pCwGA/3rYE6VQGX8YnUJFOIHPBBXaBnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382228;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XIw94U2KpC0TpbywRhzU4XUiB4byHp1rQrMAeiqZ4T4=;
	b=n82LzjALgO1pBhMk4A6FYrKkkKlVIzccopHXhG6uRynY2eoGBONiVyfzcfe13S5bNmk3
	 NKn1BWQOA0lGx5LjwBgGDdElxyjYRlPDi2a4wmcruITb0rpnNLQm7EG571to4Yemxyfsv
	 c6fT/ESikiHLZgdhmoRHgYVGiCsXiiSpiMeNx3KTjjdNHj8oN6y6ntkmM6dxrjLYj+238
	 6fzXvrPAfRYgxTi0KZZ4LGL29A/8mBc3hMMLFBWDEXEALvjVBgz8B5zqK10rkBmGtAHev
	 thGclSMuINzHXwoQNdGarbWZG14episnnXWOP9ndFKiBTu/SGb90F3K8KZPVGYfb5uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HzYYQkt6;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82449606A321;
	Wed, 11 Nov 2026 07:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82449606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HzYYQkt6
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XIw94U2KpC0TpbywRhzU4XUiB4byHp1rQrMAeiqZ4T4=;
	b=HzYYQkt6xB0mztJloCq/b5l605vCtbZGh7ZYB8kI6I7qFVwKvdW/Oezn7UnFsZNRnEi+rjXkX
	Wz0il8DYuvgvfjW8puiyGlpcAVGWcYunB1GFRgPsSDuXC4quHzVBlaFTOa3YXsmN8UtAqcRQBAj
	3WY+gESriD0idCWJbevWZKE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jPZt56PB2zmVD2;
	Wed, 11 Nov 2026 15:30:05 +0800 (CST)
Received: from kwepemk300018.china.huawei.com (unknown [7.202.194.246])
	by mail.maildlp.com (Postfix) with ESMTPS id E895140563;
	Wed, 11 Nov 2026 15:30:20 +0800 (CST)
Received: from [10.34.206.67] (10.34.206.67) by kwepemk300018.china.huawei.com
 (7.202.194.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 15:30:20 +0800
Message-ID: <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
Date: Wed, 11 Nov 2026 15:30:19 +0800
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Nicolas Bouchinet
	<nicolas.bouchinet@oss.cyber.gouv.fr>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk300018.china.huawei.com (7.202.194.246)

On 11/2/2026 10:00 PM, Mario Limonciello (AMD) wrote:
> Lockdown is a kernel LSM that restricts access to sensitive kernel
> resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
> BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
> device can perform DMA to arbitrary physical memory, effectively
> bypassing all lockdown protections.
> 
> A malicious or compromised device can:
>    - Read kernel memory directly (encryption keys, credentials, secrets)
>    - Write to kernel memory directly (code patches, rootkits, backdoors)
>    - Circumvent all lockdown LSM checks (which run inside the kernel)
> 

Hi Mario,

Thanks for your contribution.

Let me first make my position clear: I'm not questioning the motivation
behind this series -- "without an IOMMU, PCI/PCIe devices can DMA to
arbitrary physical memory" is a real and legitimate concern. What I'd
like to raise for discussion is: whether this class of problem should be
addressed by lockdown in the first place. I'm honestly doubtful, so I'd
very much welcome other people's views.

My doubt comes from a mismatch between the threat this series is trying
to fix and the threat model lockdown was built around. Lockdown is, by
design, a way to protect the boundary between UID 0 and the kernel: it
came from the UEFI Secure Boot work, and it only limits the ways
software can reach the kernel -- /dev/mem, module loading, kexec, device
access via iopl/MSR/ACPI, and so on. The attacker it thinks about is a
privileged user (root) on the system. The problem in this series,
however, is about a malicious or bad hardware device, whose attack path
lives at the bus/hardware layer rather than in the software access paths
lockdown protects. To me, that looks like a different threat class with
a different owner.

It also does not look like a new question. The DMA-from-untrusted-device
problem was discussed in detail on linux-kernel back in May–June 2020,
in the "RFC Restrict the untrusted devices, to bind to only a set of
'whitelisted' drivers" thread:
	https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/

The conclusion of that discussion, as I read it, is that device-level
DMA threats are handled by the PCI/IOMMU line of defense -- the
untrusted-device marking in the PCI core, IOMMU/ACS settings, and
driver/device review -- not by lockdown. Interestingly, that thread also
  shows that "with an IOMMU or without an IOMMU" is not a clean split in
either direction: ATS and driver bugs can defeat DMA isolation even with
an IOMMU in place, while ACS Translation Blocking can still help on
systems without one. So if my reading is correct, "is there an IOMMU?"
is not a good test here. It does not really stop the DMA attack this
series worries about, and it goes beyond lockdown's original job.

Also worth noting: systems without an IOMMU are not rare. Many embedded
boards and virtual machines have no IOMMU at all. Lockdown, meanwhile,
is often enabled automatically in Secure Boot deployments, On such
systems, a panic-on-no-IOMMU check would turn a normal setup into a boot
failure.

Given what lockdown is for and the earlier discussion, the problem of a
device doing DMA without an IOMMU is probably not a problem for the
lockdown LSM to address, and that it belongs with the PCI/IOMMU
subsystems and platform policy instead.

I would welcome other views on this.

> This series adds a two-phase check to prevent booting with lockdown
> enabled and IOMMU disabled:
> 
> 1. Early check (in lockdown_lsm_init()): On x86, check the no_iommu
>     flag, which is set early by the "iommu=off" kernel cmdline option.
>     If lockdown is active and no_iommu is set, panic with a clear error.
> 
> 2. Late check (late_initcall): On all architectures, check
>     iommu_is_available() which returns true if any IOMMU driver
>     registered successfully. This catches cases where:
>     - IOMMU hardware is absent on the platform
>     - IOMMU was disabled by driver initialization failure
>     - IOMMU was not detected (broken firmware, missing ACPI tables)
> 
> This follows the precedent set by s390 UV code which panics when
> security cannot be guaranteed ("System security cannot be guaranteed
> unless the system panics now").
> 
> This also adds a generic iommu_is_available() API in the IOMMU
> subsystem, which is used by the lockdown check. Any IOMMU driver
> that successfully registers will automatically call
> iommu_set_available() from iommu_device_register().
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> ---
> Mario Limonciello (AMD) (2):
>        iommu: Add iommu_is_available() API
>        security: lockdown: Prevent boot with lockdown but no IOMMU
> 
>   drivers/iommu/iommu.c        | 48 ++++++++++++++++++++++++++++++++
>   include/linux/iommu.h        | 14 ++++++++++
>   security/lockdown/lockdown.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 127 insertions(+)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261014-lockdown-iommu-08c763d9f91dd
> 
> Best regards,
> --
> Mario Limonciello <superm1@kernel.org>
> 
> 


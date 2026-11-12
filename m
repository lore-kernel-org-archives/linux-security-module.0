Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511676;
	b=vKSy5V39HOgpXh+LLTTmEL52oKKoPShg/zxSeyCOXOoSzuB/KTym4QAE+o4flf7lbssP
	 wu7HD9Jm/c34x/hhrYCDQ+OuxbyHzR6cGX4rFkccpdZ+eTlrzmeVrlYA/Iuk0IpHakfX6
	 KuNZWZAP1lnSDr27fEaZPGSZp/62pebc7nZ07z41p+clji++h+mWwyPcaYQpnwjZv2ZI4
	 bqrbdLGiPRjqZbrdOvXIOV04AUoxyS7S4oni3nF6djuiYBie43xXxT6r+Cc1lAIeM5QSg
	 4LzRq/i96M63Pum9lGXifNfAUxCxeYOkJerDAT0Cc9bO+aTFWlEPuFS3rQddfeM/Xdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511676;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LS6k+99+4hy2GmrZ3HxrcZCKcAyTnXj9VkGXuodPJiA=;
	b=uAwch/bDd9EBaM/zjLZFyl7cxpXZsgmnfio5ffsjSS58qHetyAwMcG/H96fs4F/udhS7
	 OKXLc5ycG9ThM6CW7bc1EbHPZtYDhk+Lqn2ztDYHU2gVRQvGAfHxLeUnSMik+wBNwBa0N
	 QAzvPQm0sjOvnSGGtd4WjgdF0Z5yrB3iJr9iggRCe2k/HMGQYpHOzQ/OUfQBbWBFsu1Ih
	 u8/FIvJQjqH75xbDHKNESAV6PkxTcbU4Yck6npDoc1LscHyheAFjiGqC2E1BvGOeAwSgP
	 WNrnavtkp8E6H3FRvBPDOVxbaqwcLokOJHeClFtrStnN/FXkU80Smn7oyNWKlPGGjlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayEuyhyM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2C606A31C;
	Thu, 12 Nov 2026 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayEuyhyM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9797E1F000C4;
	Thu, 12 Nov 2026 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511676;
	bh=LS6k+99+4hy2GmrZ3HxrcZCKcAyTnXj9VkGXuodPJiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ayEuyhyMW49lXSo7jCBHYQShvmVaWwXqIi7k7GEAmoVOWT5vG/n8MunKGRnpWparL
	 kQ+/dAjzXPFprCLeCHu1dD1CYaXkcZLdFXv44ycZw+cQUrxjHgghhp7s2drCDXOfIX
	 n6CNisDQ9ZbjuwOoAMNbDorHAH4PuG+BDkrsKN4GLfY6ajoRF0zMPDzA2lTQf5mh/o
	 1dZDD2+anhUZEO2+Jd+O+7CKTaa6RK2tbZDZIKzCwyvMWVrd7jyLrHWPd4ZRdkKM5M
	 Ty5fqNoBpolTz676uufMM/dm4svnpfYFVQ1PsLVlYEE5gtWyBOISFKquSehsfHdZdR
	 D/vMrSh88UfoA==
Message-ID: <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>
Date: Thu, 12 Nov 2026 13:27:50 -0600
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
Content-Language: en-US
To: Xiu Jianfeng <xiujianfeng@huawei.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/26 01:30, Xiu Jianfeng wrote:
> On 11/2/2026 10:00 PM, Mario Limonciello (AMD) wrote:
>> Lockdown is a kernel LSM that restricts access to sensitive kernel
>> resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
>> BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
>> device can perform DMA to arbitrary physical memory, effectively
>> bypassing all lockdown protections.
>>
>> A malicious or compromised device can:
>>    - Read kernel memory directly (encryption keys, credentials, secrets)
>>    - Write to kernel memory directly (code patches, rootkits, backdoors)
>>    - Circumvent all lockdown LSM checks (which run inside the kernel)
>>
> 
> Hi Mario,
> 
> Thanks for your contribution.
> 
> Let me first make my position clear: I'm not questioning the motivation
> behind this series -- "without an IOMMU, PCI/PCIe devices can DMA to
> arbitrary physical memory" is a real and legitimate concern. What I'd
> like to raise for discussion is: whether this class of problem should be
> addressed by lockdown in the first place. I'm honestly doubtful, so I'd
> very much welcome other people's views.
> 
> My doubt comes from a mismatch between the threat this series is trying
> to fix and the threat model lockdown was built around. Lockdown is, by
> design, a way to protect the boundary between UID 0 and the kernel: it
> came from the UEFI Secure Boot work, and it only limits the ways
> software can reach the kernel -- /dev/mem, module loading, kexec, device
> access via iopl/MSR/ACPI, and so on. The attacker it thinks about is a
> privileged user (root) on the system. The problem in this series,
> however, is about a malicious or bad hardware device, whose attack path
> lives at the bus/hardware layer rather than in the software access paths
> lockdown protects. To me, that looks like a different threat class with

I do agree with you; this is a different type of threat model that's 
being addressed.

> a different owner.

The problem I see is that in today's day it's incredibly easy to hotplug 
an external PCIe device and not "realize" that it's malicious.  For 
example if I leave a dock on my desk and someone inserts malware into it
I might think it's perfectly fine.

The current mitigation that exists is that in the Linux ecosystem we 
don't turn on PCIe tunneling "automatically" unless the IOMMU is active.

Nominally this happens by way of 'bolt' userspace writing a sysfs file 
after it confirmed IOMMU was enabled both pre-boot and by the kernel.

But come back to me being a user.  If I have the IOMMU off already for
whatever reason I'm used to plugging in the dock and accepting the popup 
asking me to authorize it.  Now a malicious device comes along, that's 
on me to know about?

I feel it's not entirely out of the realm of possibility that such a 
malicious device could subvert lockdown (let alone other bad things that 
can happen).

Thus; lockdown is a very convenient tie in to claim security of the 
system against both user and hardware attacks.

> 
> It also does not look like a new question. The DMA-from-untrusted-device
> problem was discussed in detail on linux-kernel back in May–June 2020,
> in the "RFC Restrict the untrusted devices, to bind to only a set of
> 'whitelisted' drivers" thread:
>      https://lore.kernel.org/all/ 
> CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> 
> The conclusion of that discussion, as I read it, is that device-level
> DMA threats are handled by the PCI/IOMMU line of defense -- the
> untrusted-device marking in the PCI core, IOMMU/ACS settings, and
> driver/device review -- not by lockdown. Interestingly, that thread also
>   shows that "with an IOMMU or without an IOMMU" is not a clean split in
> either direction: ATS and driver bugs can defeat DMA isolation even with
> an IOMMU in place, while ACS Translation Blocking can still help on
> systems without one. So if my reading is correct, "is there an IOMMU?"
> is not a good test here. It does not really stop the DMA attack this
> series worries about, and 

Thanks for sharing.

> it goes beyond lockdown's original job.

Right.

> 
> Also worth noting: systems without an IOMMU are not rare. Many embedded
> boards and virtual machines have no IOMMU at all. Lockdown, meanwhile,
> is often enabled automatically in Secure Boot deployments, On such
> systems, a panic-on-no-IOMMU check would turn a normal setup into a boot
> failure.
> 
> Given what lockdown is for and the earlier discussion, the problem of a
> device doing DMA without an IOMMU is probably not a problem for the
> lockdown LSM to address, and that it belongs with the PCI/IOMMU
> subsystems and platform policy instead.
> 
> I would welcome other views on this.

How would you feel about at least blocking the user from turning off 
IOMMU (if it's present on the system) via the kernel command line while 
lockdown was enabled?

Thinking about the case where most distros enable lockdown by default, 
this will strenghten it's use without much downside that I can see.

At least on a properly configured system that contains an IOMMU it would 
prevent a user from subverting lockdown with a malicious device during 
the boot sequence.
> 
>> This series adds a two-phase check to prevent booting with lockdown
>> enabled and IOMMU disabled:
>>
>> 1. Early check (in lockdown_lsm_init()): On x86, check the no_iommu
>>     flag, which is set early by the "iommu=off" kernel cmdline option.
>>     If lockdown is active and no_iommu is set, panic with a clear error.
>>
>> 2. Late check (late_initcall): On all architectures, check
>>     iommu_is_available() which returns true if any IOMMU driver
>>     registered successfully. This catches cases where:
>>     - IOMMU hardware is absent on the platform
>>     - IOMMU was disabled by driver initialization failure
>>     - IOMMU was not detected (broken firmware, missing ACPI tables)
>>
>> This follows the precedent set by s390 UV code which panics when
>> security cannot be guaranteed ("System security cannot be guaranteed
>> unless the system panics now").
>>
>> This also adds a generic iommu_is_available() API in the IOMMU
>> subsystem, which is used by the lockdown check. Any IOMMU driver
>> that successfully registers will automatically call
>> iommu_set_available() from iommu_device_register().
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> ---
>> Mario Limonciello (AMD) (2):
>>        iommu: Add iommu_is_available() API
>>        security: lockdown: Prevent boot with lockdown but no IOMMU
>>
>>   drivers/iommu/iommu.c        | 48 ++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h        | 14 ++++++++++
>>   security/lockdown/lockdown.c | 65 ++++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   3 files changed, 127 insertions(+)
>> ---
>> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>> change-id: 20261014-lockdown-iommu-08c763d9f91dd
>>
>> Best regards,
>> -- 
>> Mario Limonciello <superm1@kernel.org>
>>
>>
> 


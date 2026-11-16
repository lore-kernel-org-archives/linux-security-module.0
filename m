Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835743;
	b=ZCPDLLDcl/9Y70USc2iCiVjgfrAtkPAktOft6x+aBVIpr8cG6HX7i+LIVesf/K2WU6Vj
	 KUVcWvZMI3UXMR1G25gVbJH7iRjUMiJZxQ2hUIK2ezBh8Dr0r8GePLMf+WfFaTyCbALNM
	 mqjCY1Qe7rwCSSFECq9IaknfT7xmYsTxGtrFKNWuWOE29C/4dfoe0sVNaALwegIkMTHl3
	 zYKzg5Di0Ow50vNTYKl8GJ7sGNQIYCr/SUektE2Nt5PFo6l90yYmzKfo/VM6PAW0mfhGf
	 uwdufLIsK9EXkdfX/7XYSzSNjqQlvR0x2QYzIiFzl4g+UWS/W5eWGvvFoeep3xadDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835743;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=uz1Gm9A0XmdWVhMUHrTk33lNXNmGWV8HEH3nc+Vkj8Y=;
	b=4Ezu5zdgssf6fJmouuMI4YIKW5NWik3BoOSmw+E2eecxTpZgYH4lMnYhdRWcbZLZv4du
	 tYHVB12cRoixcwr+Zu4+dqi0PoukY4brMmiFZndvTGk28l9wjW69Tn6RwPx4KbgS80y2N
	 VuYUF7sqlf2n/T9ode+YAzgRKmfXDx2NoFwXCgXK5obLvSMA03kL8VKZAWBT4e+s7H9bk
	 6r9AMiBwFooX5etVvqd6ZEpO+enotgpFDKERqg92XCTSkkHeiJIchOasvIVvFlYjguHU0
	 Agou8rXqDQ49sM9N2LKc6ed0TeLW06YTMO7ZiFIRHJrAUmsEaSTIuZUunXaFpFXg/KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="jcG/ZE9b";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236D606A31C;
	Mon, 16 Nov 2026 13:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D236D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=jcG/ZE9b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uz1Gm9A0XmdWVhMUHrTk33lNXNmGWV8HEH3nc+Vkj8Y=; b=jcG/ZE9be7wxqnb+hjusfCFcQa
	VkHKRP190nzrNWv1zQNgwt4ivNFACfEsPCQHH3GWpFCNFzSb7fEqxhIJi4JapiNoB0AQAq33Bk/c2
	eKSJ0iN5+Ut4bZnvN4SVNdujch+9kU9MuhFRCqTzqWuaUwSEvzCAacdxn0UPypl4tW1Ikcdbryd1e
	t+BT+kBu2OMImSN+sO1GshRrGekhBBsjKDEk4v8BpIOXWs3P1fU/6dXCwttJC2kyQ4eXY6j/Hsk9C
	xYNARwYMiBNXjMzFSnVYa2xD9Ybyxiihw1lMSBa97c9ZhUJRC6k0N9uDn5lvOGDjxNTjMIRK6XuSQ
	w+xkE45w==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:46593 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xSwlY-00000009cTC-2n36;
	Mon, 16 Nov 2026 14:28:59 +0100
Date: Mon, 16 Nov 2026 14:28:55 +0100
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Mario Limonciello <superm1@kernel.org>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Message-ID: <avr31i6M5PqKk_Vf@archlinux>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
 <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Mario,

Thanks for your interrest in Lockdown.

On Thu, Nov 12, 2026 at 01:27:50PM -0600, Mario Limonciello wrote:
> On 11/11/26 01:30, Xiu Jianfeng wrote:
> > On 11/2/2026 10:00 PM, Mario Limonciello (AMD) wrote:
> > > Lockdown is a kernel LSM that restricts access to sensitive kernel
> > > resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
> > > BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
> > > device can perform DMA to arbitrary physical memory, effectively
> > > bypassing all lockdown protections.
> > > 
> > > A malicious or compromised device can:
> > >    - Read kernel memory directly (encryption keys, credentials, secrets)
> > >    - Write to kernel memory directly (code patches, rootkits, backdoors)
> > >    - Circumvent all lockdown LSM checks (which run inside the kernel)
> > > 
> > 
> > Hi Mario,
> > 
> > Thanks for your contribution.
> > 
> > Let me first make my position clear: I'm not questioning the motivation
> > behind this series -- "without an IOMMU, PCI/PCIe devices can DMA to
> > arbitrary physical memory" is a real and legitimate concern. What I'd
> > like to raise for discussion is: whether this class of problem should be
> > addressed by lockdown in the first place. I'm honestly doubtful, so I'd
> > very much welcome other people's views.
> > 
> > My doubt comes from a mismatch between the threat this series is trying
> > to fix and the threat model lockdown was built around. Lockdown is, by
> > design, a way to protect the boundary between UID 0 and the kernel: it
> > came from the UEFI Secure Boot work, and it only limits the ways
> > software can reach the kernel -- /dev/mem, module loading, kexec, device
> > access via iopl/MSR/ACPI, and so on. The attacker it thinks about is a
> > privileged user (root) on the system. The problem in this series,
> > however, is about a malicious or bad hardware device, whose attack path
> > lives at the bus/hardware layer rather than in the software access paths
> > lockdown protects. To me, that looks like a different threat class with
> 
> I do agree with you; this is a different type of threat model that's being
> addressed.
> 
> > a different owner.
> 
> The problem I see is that in today's day it's incredibly easy to hotplug an
> external PCIe device and not "realize" that it's malicious.  For example if
> I leave a dock on my desk and someone inserts malware into it
> I might think it's perfectly fine.
> 
> The current mitigation that exists is that in the Linux ecosystem we don't
> turn on PCIe tunneling "automatically" unless the IOMMU is active.
> 
> Nominally this happens by way of 'bolt' userspace writing a sysfs file after
> it confirmed IOMMU was enabled both pre-boot and by the kernel.
> 
> But come back to me being a user.  If I have the IOMMU off already for
> whatever reason I'm used to plugging in the dock and accepting the popup
> asking me to authorize it.  Now a malicious device comes along, that's on me
> to know about?
> 
> I feel it's not entirely out of the realm of possibility that such a
> malicious device could subvert lockdown (let alone other bad things that can
> happen).
> 
> Thus; lockdown is a very convenient tie in to claim security of the system
> against both user and hardware attacks.
> 

One other scenario I can imagine without a physical access (but to be
honest I'm not completely sure about me), is for a root attacker to
write malicious firmware blob in `/lib/firmware` and somehow force the
kernel to load it thanks to a `request_firmware` call. It might lead to
an dangerous DMA configuration and then to the attack scenario you
described.

If this scenario works it would need to be handled by Lockdown.

> > 
> > It also does not look like a new question. The DMA-from-untrusted-device
> > problem was discussed in detail on linux-kernel back in May–June 2020,
> > in the "RFC Restrict the untrusted devices, to bind to only a set of
> > 'whitelisted' drivers" thread:
> >      https://lore.kernel.org/all/
> > CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > 
> > The conclusion of that discussion, as I read it, is that device-level
> > DMA threats are handled by the PCI/IOMMU line of defense -- the
> > untrusted-device marking in the PCI core, IOMMU/ACS settings, and
> > driver/device review -- not by lockdown. Interestingly, that thread also
> >   shows that "with an IOMMU or without an IOMMU" is not a clean split in
> > either direction: ATS and driver bugs can defeat DMA isolation even with
> > an IOMMU in place, while ACS Translation Blocking can still help on
> > systems without one. So if my reading is correct, "is there an IOMMU?"
> > is not a good test here. It does not really stop the DMA attack this
> > series worries about, and
> 
> Thanks for sharing.
> 
> > it goes beyond lockdown's original job.
> 
> Right.
> 
> > 
> > Also worth noting: systems without an IOMMU are not rare. Many embedded
> > boards and virtual machines have no IOMMU at all. Lockdown, meanwhile,
> > is often enabled automatically in Secure Boot deployments, On such
> > systems, a panic-on-no-IOMMU check would turn a normal setup into a boot
> > failure.
> > 
I do agree with Xiu here, we must be very careful about it and figure
out a solution which would not brick already deployed machines.

> > Given what lockdown is for and the earlier discussion, the problem of a
> > device doing DMA without an IOMMU is probably not a problem for the
> > lockdown LSM to address, and that it belongs with the PCI/IOMMU
> > subsystems and platform policy instead.
> > 
> > I would welcome other views on this.
> 
> How would you feel about at least blocking the user from turning off IOMMU
> (if it's present on the system) via the kernel command line while lockdown
> was enabled?
> 
> Thinking about the case where most distros enable lockdown by default, this
> will strenghten it's use without much downside that I can see.
> 
> At least on a properly configured system that contains an IOMMU it would
> prevent a user from subverting lockdown with a malicious device during the
> boot sequence.

I do agree with you, it could be a great addition. With Lockdown enabled
as an early LSM (CONFIG_SECURITY_LOCKDOWN_LSM_EARLY), this might be
feasible before boot parameter parsing. Lockdown already locks unsafe
module parameters.

If I remember correctly on distro's that have a Lockdown patch that
enables it if secure boot is enabled, it should also be called before
early param parsing.

But taking this threat into account also brings other questions.
i.e, a physical attacker with root access on a system where Lockdown is
enabled and with a bootchain configured with shim+MOK is able to change
kernel cmdline, generate a MOK and sign a compromised kernel
binary. Thus defeating lockdown purpose.

In order to take the physical attacker into account, a securely
configured bootchain where the kernel image can't be tampered with and
where an attacker is not able to inject it owns certificates/hash in
db/MOK is mandatory so that Lockdown makes sense.

Orthogonally, we definitively should work on adding an updated
documentation with Lockdown threat model and more information about what Lockdown locks.

> > 
> > > This series adds a two-phase check to prevent booting with lockdown
> > > enabled and IOMMU disabled:
> > > 
> > > 1. Early check (in lockdown_lsm_init()): On x86, check the no_iommu
> > >     flag, which is set early by the "iommu=off" kernel cmdline option.
> > >     If lockdown is active and no_iommu is set, panic with a clear error.
> > > 
> > > 2. Late check (late_initcall): On all architectures, check
> > >     iommu_is_available() which returns true if any IOMMU driver
> > >     registered successfully. This catches cases where:
> > >     - IOMMU hardware is absent on the platform
> > >     - IOMMU was disabled by driver initialization failure
> > >     - IOMMU was not detected (broken firmware, missing ACPI tables)
> > > 
> > > This follows the precedent set by s390 UV code which panics when
> > > security cannot be guaranteed ("System security cannot be guaranteed
> > > unless the system panics now").
> > > 
> > > This also adds a generic iommu_is_available() API in the IOMMU
> > > subsystem, which is used by the lockdown check. Any IOMMU driver
> > > that successfully registers will automatically call
> > > iommu_set_available() from iommu_device_register().
> > > 
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > 
> > > ---
> > > Mario Limonciello (AMD) (2):
> > >        iommu: Add iommu_is_available() API
> > >        security: lockdown: Prevent boot with lockdown but no IOMMU
> > > 
> > >   drivers/iommu/iommu.c        | 48 ++++++++++++++++++++++++++++++++
> > >   include/linux/iommu.h        | 14 ++++++++++
> > >   security/lockdown/lockdown.c | 65
> > > ++++++++++++++++++++++++++++++++++ ++++++++++
> > >   3 files changed, 127 insertions(+)
> > > ---
> > > base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> > > change-id: 20261014-lockdown-iommu-08c763d9f91dd
> > > 
> > > Best regards,
> > > -- 
> > > Mario Limonciello <superm1@kernel.org>
> > > 
> > > 
> > 
> 

Best regards,

Nicolas Bouchinet

Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F482E62DC;
	Tue, 25 Nov 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105243; cv=none; b=nSG/d/1zGg+QmsRsVQEVMPJlYIWzQggGVrGQzGWxOg1+vgYZ3kHU47dZ0j4dfyOXIxH9Tcz+/2cIZl5BxQmtT2WwWMVP6UfGHI+V3vLEOcRWGCRgSnf1ewSuqlOzMCkN9C3btmBUMLEDhGuJUWwf9j/Iz/457VjolZYQA05wYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105243; c=relaxed/simple;
	bh=I0zXzMJimLpERt+kr1+qHTfxdLKG1GS6UHaA1CsUP4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBqolXxNIRq+6BUtqFok0opH0Lwt4EiwWD/O8AP7dOW8xgRn/+vAa+XCpNHce4UEx8BkCsAUNZSmLinNSAX5+DMAl/4FJs9D2GD2v/vIejAhKLXo/vbErogjrcJ45SBbWKm27PJOWU1AbyVR2qXX3MmQC2WKd432p5JbaevjOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=QQEM3GRi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="QQEM3GRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764105234; x=1764710034; i=deller@gmx.de;
	bh=I0zXzMJimLpERt+kr1+qHTfxdLKG1GS6UHaA1CsUP4o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QQEM3GRi3pj0HGX6lc9iXkSxd34SepdWKZ2xGDtVrBK+jTU8LNnaka6aG5Q90s1q
	 y8Xz0VTnb5kMWX2jGrekArCqdu8bqd12H/85/P4HX7sftDNpsSIIPjASVcFePypS1
	 MIK+8CGNRu6BYr307gpV8k7aKG7wntjJDOhdM7IJHia5c4gFlaFb4YxyVe7wqz3ZU
	 yA12Dmf/IiL1zepP8KWIkG28Yv8queIvHN34SEQnMIczOd5cZN0yIVjO2S2N0WsHK
	 U8fzimvhix6DbhPrgQmxTdvCPSaDYrHRftVPZDyX7TYoRvBMAtfjCW6XJLF+hnAle
	 ulSSQZnAkhMREqcRpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.138]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1vTCcX20Tf-001CEW; Tue, 25
 Nov 2025 22:13:54 +0100
Message-ID: <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
Date: Tue, 25 Nov 2025 22:13:53 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: John Johansen <john.johansen@canonical.com>,
 Helge Deller <deller@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com> <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yDAaLFvRmF3dc7s9qV98p1Y50aM4UnWs79MiJrMXBSZgy9qNXNu
 wsmHtS0c77f9QolGkEfVR9TV9v7vPwKilh4ooSIpqZbls+GILnQuywazoZQttH6WstYJr/W
 4vLSLjMgwvrWYkd7izvLpGcdnpsu56E4JvSgDjPZ7wLrKIRyJr7VM6jgtirdFpezDoulnEO
 UbSwmrCST5M7q6hh2RMUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:997UD/X89w0=;HUR4+lm1AXlHYzLBde+y0IZY5ej
 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

On 11/25/25 20:20, John Johansen wrote:
> On 11/25/25 07:11, Helge Deller wrote:
>> * John Johansen <john.johansen@canonical.com>:
>>> On 11/18/25 04:49, Helge Deller wrote:
>>>> Hi Adrian,
>>>>
>>>> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
>>>>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>>>>>> My patch fixed two call sites, but I suspect you see another call s=
ite which
>>>>>> hasn't been fixed yet.
>>>>>>
>>>>>> Can you try attached patch? It might indicate the caller of the fun=
ction and
>>>>>> maybe prints the struct name/address which isn't aligned.
>>>>>>
>>>>>> Helge
>>>>>>
>>>>>>
>>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>>>>>> index c5a91600842a..b477430c07eb 100644
>>>>>> --- a/security/apparmor/match.c
>>>>>> +++ b/security/apparmor/match.c
>>>>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t=
 size, int flags)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size < sizeof(struct table=
_set_header))
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto f=
ail;
>>>>>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON(((unsigned long)data) & (BITS_PER_L=
ONG/8 - 1)))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("dfa blob strea=
m %pS not aligned.\n", data);
>>>>>> +
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ntohl(*(__be32 *) data) !=
=3D YYTH_MAGIC)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto f=
ail;
>>>>>
>>>>> Here is the relevant output with the patch applied:
>>>>>
>>>>> [=C2=A0=C2=A0 73.840639] ------------[ cut here ]------------
>>>>> [=C2=A0=C2=A0 73.901376] WARNING: CPU: 0 PID: 341 at security/apparm=
or/match.c:316 aa_dfa_unpack+0x6cc/0x720
>>>>> [=C2=A0=C2=A0 74.015867] Modules linked in: binfmt_misc evdev flash =
sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink =
autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
>>>>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali liba=
ta sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common md=
io_bus usb_common
>>>>> [=C2=A0=C2=A0 74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parse=
r Not tainted 6.18.0-rc6+ #9 NONE
>>>>> [=C2=A0=C2=A0 74.536543] Call Trace:
>>>>> [=C2=A0=C2=A0 74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
>>>>> [=C2=A0=C2=A0 74.633757] [<0000000000476438>] __warn+0xd8/0x100
>>>>> [=C2=A0=C2=A0 74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34=
/0x74
>>>>> [=C2=A0=C2=A0 74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x=
720
>>>>> [=C2=A0=C2=A0 74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
>>>>> [=C2=A0=C2=A0 74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0=
x1300
>>>>> [=C2=A0=C2=A0 74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
>>>>> [=C2=A0=C2=A0 75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x=
64/0x1160
>>>>> [=C2=A0=C2=A0 75.130144] [<00000000008d4d90>] policy_update+0xf0/0x2=
80
>>>>> [=C2=A0=C2=A0 75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0=
x100
>>>>> [=C2=A0=C2=A0 75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
>>>>> [=C2=A0=C2=A0 75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
>>>>> [=C2=A0=C2=A0 75.406932] [<0000000000767174>] sys_write+0x14/0x40
>>>>> [=C2=A0=C2=A0 75.472126] [<0000000000406174>] linux_sparc_syscall+0x=
34/0x44
>>>>> [=C2=A0=C2=A0 75.548802] ---[ end trace 0000000000000000 ]---
>>>>> [=C2=A0=C2=A0 75.609503] dfa blob stream 0xfff0000008926b96 not alig=
ned.
>>>>> [=C2=A0=C2=A0 75.682695] Kernel unaligned access at TPC[8db2a8] aa_d=
fa_unpack+0x6e8/0x720
>>>>
>>>> The non-8-byte-aligned address (0xfff0000008926b96) is coming from us=
erspace
>>>> (via the write syscall).
>>>> Some apparmor userspace tool writes into the apparmor ".replace" virt=
ual file with
>>>> a source address which is not correctly aligned.
>>>
>>> the userpace buffer passed to write(2) has to be aligned? Its certainl=
y nice if it
>>> is but the userspace tooling hasn't been treating it as aligned. With =
that said,
>>> the dfa should be padded to be aligned. So this tripping in the dfa is=
 a bug,
>>> and there really should be some validation to catch it.
>>>
>>>> You should be able to debug/find the problematic code with strace fro=
m userspace.
>>>> Maybe someone with apparmor knowledge here on the list has an idea?
>>>>
>>> This is likely an unaligned 2nd profile, being split out and loaded se=
parately
>>> from the rest of the container. Basically the loader for some reason (=
there
>>> are a few different possible reasons) is poking into the container for=
mat and
>>> pulling out the profile at some offset, this gets loaded to the kernel=
 but
>>> it would seem that its causing an issue with the dfa alignment within =
the container,
>>> which should be aligned to the original container.
>>
>>
>> Regarding this:
>>
>>> Kernel side, we are going to need to add some extra verification check=
s, it should
>>> be catching this, as unaligned as part of the unpack. Userspace side, =
we will have
>>> to verify my guess and fix the loader.
>>
>> I wonder if loading those tables are really time critical?
>=20
> no, most policy is loaded once on boot and then at package upgrades. The=
re are some
> bits that may be loaded at application startup like, snap, libvirt, lxd,=
 basically
> container managers might do some thing custom per container.
>=20
> Its the run time we want to minimize, the cost of.
>=20
> Policy already can be unaligned (the container format rework to fix this=
 is low
> priority), and is treated as untrusted. It goes through an unpack, and t=
ranslation to
> machine native, with as many bounds checks, necessary transforms etc don=
e at unpack
> time as possible, so that the run time costs can be minimized.
>=20
>> If not, maybe just making the kernel aware that the tables might be una=
ligned
>> can help, e.g. with the following (untested) patch.
>> Adrian, maybe you want to test?
>>
>=20
>> ------------------------
>>
>> [PATCH] Allow apparmor to handle unaligned dfa tables
>>
>> The dfa tables can originate from kernel or userspace and 8-byte alignm=
ent
>> isn't always guaranteed and as such may trigger unaligned memory access=
es
>> on various architectures.
>> Work around it by using the get_unaligned_xx() helpers.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
> lgtm,
>=20
> Acked-by: John Johansen <john.johansen@canonical.com>
>=20
> I'll pull this into my tree regardless of whether it fixes the issue
> for Adrian, as it definitely fixes an issue.
>=20
> We can added additional patches on top s needed.

My patch does not modify the UNPACK_ARRAY() macro, which we
possibly should adjust as well.
Adrian's testing seems to trigger only a few unaligned accesses,
so maybe it's not a issue currently.

Helge

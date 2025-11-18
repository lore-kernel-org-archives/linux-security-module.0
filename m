Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959522D793;
	Tue, 18 Nov 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470185; cv=none; b=C4yEwKcOrTaj3mrbUacOggpO4/kIKm1CGlM7CpzD7aF06BBlUilW/kXPXaNtnXA+PT0Ox43JalQMJkppjPD9SXYtaXj3z2zvnPMBqtMJmz1wufq33xX6swP/VKtSWGDK7/djnjQ6AhhGO7+PArQnacKpKtvhr+zr7VqTWDckbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470185; c=relaxed/simple;
	bh=0o03xtxhRo/0ewfoYy5QLSowxDAns7gsUHH32hKajvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxyRoOBViMtRPAu8fuRcNpPg7gc4k9Yr9iHvKGIXyHuvr649LStUedgShk41iYSccEZdd1cbrmiA3kTvUPo1IHnW/NyaFH3BkePp0Xf5m1zfcJkr2/UTd/4of3n66H4WJ4JeGsd7Fl2kVxEBsIEsR/3rqRQ7ZjoKnsvxTK8yltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=gbe68x8e; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="gbe68x8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763470163; x=1764074963; i=deller@gmx.de;
	bh=MzPywQ4EX696Crwf8je8LpPBVB6fm69KNEwjVXOwcAE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gbe68x8eYle/h/nOK3JJ3Yw34YAmKCRBkNLx8xdjupGeIumMpDuSS/V7gS9KaYLo
	 VvTnTKX4NLqy+hQJHKwe66s7YvzLlUpWLIu2VHo1o+sk5SPAvV1wnmBpuaQV8tw3/
	 nolxBnZzlUeKrJlRBqr/3ZBb1JQXEKFTio1jFR7GxCmcvVmSMYoynd33TqTThPtom
	 i6ZTK8gBSXIcED/g3A6OfCkCBqFNAqGWCelkEt02ktukER59366pEXuP9+ovkVsGr
	 6KitgFhfd6nZ2zxA9NTEYYygURFd31uTje6r1bU39sO2VAaqhwCW+MuYxWulgnPjb
	 r9n40lVmR9fHMdca0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1vhWhW2XSr-00X6zU; Tue, 18
 Nov 2025 13:49:23 +0100
Message-ID: <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
Date: Tue, 18 Nov 2025 13:49:22 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 John Johansen <john.johansen@canonical.com>,
 linux-security-module@vger.kernel.org
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k7uGqPBX4vyP6nH12PGPTO5sc/p9vWrDRQPWGi8QQ11sy7lJeIP
 tBk7RbzkzBap1MZeDqyzBWxtVXnjKNjfbDiyf9Z4VVRa3ZcXinbqtVMwPtWQ6y7rXmOOTBi
 btHrb3Fcpr8qRmmF3+yFZCrrk6rZYXLVjvc+N96RvCgttm7ha+0UX303X2yHgar6U/R3bMB
 AKZVMh+bzVTILzighisbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jfJ5T5yJd9s=;fK5qNuHbWoepBT/354tnxEkgXSW
 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
 +cCkNlMg=

Hi Adrian,

On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>> My patch fixed two call sites, but I suspect you see another call site =
which
>> hasn't been fixed yet.
>>
>> Can you try attached patch? It might indicate the caller of the functio=
n and
>> maybe prints the struct name/address which isn't aligned.
>>
>> Helge
>>
>>
>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>> index c5a91600842a..b477430c07eb 100644
>> --- a/security/apparmor/match.c
>> +++ b/security/apparmor/match.c
>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t siz=
e, int flags)
>>   	if (size < sizeof(struct table_set_header))
>>   		goto fail;
>>  =20
>> +	if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
>> +		pr_warn("dfa blob stream %pS not aligned.\n", data);
>> +
>>   	if (ntohl(*(__be32 *) data) !=3D YYTH_MAGIC)
>>   		goto fail;
>=20
> Here is the relevant output with the patch applied:
>=20
> [   73.840639] ------------[ cut here ]------------
> [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316=
 aa_dfa_unpack+0x6cc/0x720
> [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_pan=
el_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 c=
rc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata s=
ym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_b=
us usb_common
> [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted =
6.18.0-rc6+ #9 NONE
> [   74.536543] Call Trace:
> [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
> [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
> [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
> [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
> [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
> [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
> [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
> [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
> [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
> [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
> [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
> [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
> [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
> [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
> [   75.548802] ---[ end trace 0000000000000000 ]---
> [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
> [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e=
8/0x720

The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspa=
ce
(via the write syscall).
Some apparmor userspace tool writes into the apparmor ".replace" virtual f=
ile with
a source address which is not correctly aligned.
You should be able to debug/find the problematic code with strace from use=
rspace.
Maybe someone with apparmor knowledge here on the list has an idea?

Helge

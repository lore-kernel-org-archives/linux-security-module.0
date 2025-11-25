Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC382D2394
	for <linux-security-module@vger.kernel.org>; Tue, 25 Nov 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098471; cv=none; b=dpWYIfT5OeCfBH2zdX8c+zo1Eqyoqhs0uqiy+tGQraWi8nIAy5woaPf++QegxCDib+l0Ckmp27yjMsGFk3nNxO6P6j1OIiw3zeKGB/HHkCF3hLv05zI6nahNJ5h36vmaJsCMAv3wLYATM2v6zIb0wzShd3HxSwJ8wyt27c+deL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098471; c=relaxed/simple;
	bh=A84V+OLcCOo27disKzfC+Q+GZO3/lchg8Bspz1v3EQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mH6APbe7i8oqvb63fWS86HpVTjDhbQPrf7okw1nX7wR0BqC8q0V1AQQEzzV7/swzo6garlLwpxMjv20ygq/+9jl+ScaCyfVqTDVjf3YCIcnwKobmY7R45WQAli095Rb+WueayjcO8AIYec6Lt2+riFBRuhO4NmRQzRedCzGESs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=OYR4LNZ3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="OYR4LNZ3"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3EDD240F7E
	for <linux-security-module@vger.kernel.org>; Tue, 25 Nov 2025 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764098459;
	bh=ilALE9XXJutvOOa5a1V5lD4VMk+mGtgaoxKqVgZJ3Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OYR4LNZ3KkL5KDzxvGQgl87moJ2XAj+7W/w4QIvD1ABCqShEwiOjDmoc46iE3aXpk
	 8bcFLWqUyrpq2S8VgQyRCrMcELNBXLe32vc+QHDI3aO1Z8n95uiLZYwD+XqUHPPnwe
	 VDUdW86CySFhn49zTyF4S3Qq7seOhZ2EDG78xKTmhe05j3Ar+rzjQhoX6xiy1QNOqO
	 nRj+2im9QwdC/huhlcI4KWAcOytPAy7hX/lcAm/9AH2JOG0ir/TOzlB8wbYVnwvMnN
	 EgqMs4BYWtOuOzc+lgKIGghE0dbzovblllpnzYzmw1BmoNFEdCQGAVXBzCEHWtzf0K
	 aXaOfTFK2PHpwFvB+r5S/jCGDBZfI+UX54DVdQkLG2dpMoVlCeStvsF2FhOg8I5k96
	 cYAkajC2tcrzlYjqwlZsow6L9dRxNXPzPBrxAvn+MJpJHGDsIc8AippxFKDVKhLWnL
	 8up8X8OFgdxIcERxlzRDXHE7kLNZ6GlNdiZJqkxiCbclAyirkmRqOfjwrP3N0dvmAa
	 1f1E0TG4yBH82MVLtdGBeNMQFCQz9a+TZOWTHTDpGM32QsVSx0Yyxz2r2Uk3MLkfFa
	 LgcR48/80ss8sRsL64vi0w8tgo1jihZlHtOq8eUk22/irlOfxDSM8ETUlhx9ZYu9Oz
	 c/ciNXe2t1B2nTpQ1c9r1brY=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340c261fb38so10275586a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Nov 2025 11:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098457; x=1764703257;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilALE9XXJutvOOa5a1V5lD4VMk+mGtgaoxKqVgZJ3Qg=;
        b=VgmKXYAYUOiosJAGVkyVKqm9Yifkw7O/6598Fk7xeeKaIZ8tqnmuigmQm3L2C2cC6L
         7O6LJF9DCV9pu9e0R8UnRczNd2TqiVsZu3h6/csBP8bABpBCOBJvFOQH2rAhTN4TqBl7
         rJjW5AOGj3m2ymlgcPorHEv1CTDstd76UWlobiSQiDcavfF/XRDbA/7iYrdaakpDZRYj
         PFdsY379I57d3/wxzhB1Sah0V9hL1wrro8U+PSNgEl+97FoFT6HrYFlbC5+H/bz+n0gl
         nUAd2hBmMs6FwgLVD6upRon9V7W/jWHEgwWs48Vm7cCnXt7+yDRLZEWi//O6UkmCOLXR
         asgg==
X-Forwarded-Encrypted: i=1; AJvYcCVI0Cmw6VBWp4rcxlutKs/nJUgPpUp3+extNbMF9wPSp6kGEIbW6fW3GK9zz65FV5XGooB7Ns5HWEGTGkad98tQulXjaHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SWFL7QDRGKoqWqy/kaZSuP+gmINJYLNv1gm/6sMzm/0vaNk9
	kxNDjG9H3WUDPz6w41aeQ5nYVMMuuXp81YIAlEi08l3YWBLT+5ZRpIZTf1+X1jumzddq/7Vw/Ae
	Wo/HUaRfQGHF4n6RzVFqAL/N7k2bFK/GC7ross0ddtw1DKL+XWuLE+s2guhghZdOhupjfjZZL9s
	PJDFSNYddDVedeB6x3pAp7VD6Zhxl9
X-Gm-Gg: ASbGncuFd7kodcuQgbv8ESE9Ekji4IhNp++0YKeeBL3gh1LBetdf31qw1cWkJsWycE1
	ko7fmbBDbHtMNXR+qnKdVqB+++gyUXeUzVlQBNDVT1CRq6K1XVGpNMlbSm+eJApqclQm6aIXKZW
	TGvfBv+9t+BPNqelVrF2/18vVl0mh+xZWClEalPHYCnq90SzVKMWF+7Y+wCzQJHxc5gFB8SQbpy
	7X6a+dWSu7VN0kB9rV+5IT7L4Kik+0QUPBYGPrJRi2lqL6p9y7suSwOJ97phCCzhvzg6sYwBsp4
	wvTXvjLFhkXe5Fl19Y8SsJEgoS/F3BoZJ3Z4G9DxwpoJbX83nvQl8y4t3cBBHOsJGCtYLz3VtHD
	et6uOv1EA+PSqf8BcAqj4llB2
X-Received: by 2002:a17:90b:1d8e:b0:340:ad5e:c3 with SMTP id 98e67ed59e1d1-34733e6b381mr14623538a91.1.1764098457147;
        Tue, 25 Nov 2025 11:20:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWbB1AYibpqkFj3hlCzH1TlLb64N8rifHGsMgbskfeeDTg88vFAQM1grmGsqX6SpfxIh6Ldw==
X-Received: by 2002:a17:90b:1d8e:b0:340:ad5e:c3 with SMTP id 98e67ed59e1d1-34733e6b381mr14623511a91.1.1764098456656;
        Tue, 25 Nov 2025 11:20:56 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3476a5c44e5sm186855a91.13.2025.11.25.11.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 11:20:56 -0800 (PST)
Message-ID: <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
Date: Tue, 25 Nov 2025 11:20:54 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: Helge Deller <deller@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-parisc@vger.kernel.org
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com> <aSXHCyH_rS-c5BgP@p100>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <aSXHCyH_rS-c5BgP@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 07:11, Helge Deller wrote:
> * John Johansen <john.johansen@canonical.com>:
>> On 11/18/25 04:49, Helge Deller wrote:
>>> Hi Adrian,
>>>
>>> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
>>>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>>>>> My patch fixed two call sites, but I suspect you see another call site which
>>>>> hasn't been fixed yet.
>>>>>
>>>>> Can you try attached patch? It might indicate the caller of the function and
>>>>> maybe prints the struct name/address which isn't aligned.
>>>>>
>>>>> Helge
>>>>>
>>>>>
>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>>>>> index c5a91600842a..b477430c07eb 100644
>>>>> --- a/security/apparmor/match.c
>>>>> +++ b/security/apparmor/match.c
>>>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
>>>>>        if (size < sizeof(struct table_set_header))
>>>>>            goto fail;
>>>>> +    if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
>>>>> +        pr_warn("dfa blob stream %pS not aligned.\n", data);
>>>>> +
>>>>>        if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
>>>>>            goto fail;
>>>>
>>>> Here is the relevant output with the patch applied:
>>>>
>>>> [   73.840639] ------------[ cut here ]------------
>>>> [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
>>>> [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
>>>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus usb_common
>>>> [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted 6.18.0-rc6+ #9 NONE
>>>> [   74.536543] Call Trace:
>>>> [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
>>>> [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
>>>> [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
>>>> [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
>>>> [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
>>>> [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
>>>> [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
>>>> [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
>>>> [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
>>>> [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
>>>> [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
>>>> [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
>>>> [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
>>>> [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
>>>> [   75.548802] ---[ end trace 0000000000000000 ]---
>>>> [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
>>>> [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e8/0x720
>>>
>>> The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspace
>>> (via the write syscall).
>>> Some apparmor userspace tool writes into the apparmor ".replace" virtual file with
>>> a source address which is not correctly aligned.
>>
>> the userpace buffer passed to write(2) has to be aligned? Its certainly nice if it
>> is but the userspace tooling hasn't been treating it as aligned. With that said,
>> the dfa should be padded to be aligned. So this tripping in the dfa is a bug,
>> and there really should be some validation to catch it.
>>
>>> You should be able to debug/find the problematic code with strace from userspace.
>>> Maybe someone with apparmor knowledge here on the list has an idea?
>>>
>> This is likely an unaligned 2nd profile, being split out and loaded separately
>> from the rest of the container. Basically the loader for some reason (there
>> are a few different possible reasons) is poking into the container format and
>> pulling out the profile at some offset, this gets loaded to the kernel but
>> it would seem that its causing an issue with the dfa alignment within the container,
>> which should be aligned to the original container.
> 
> 
> Regarding this:
> 
>> Kernel side, we are going to need to add some extra verification checks, it should
>> be catching this, as unaligned as part of the unpack. Userspace side, we will have
>> to verify my guess and fix the loader.
> 
> I wonder if loading those tables are really time critical?

no, most policy is loaded once on boot and then at package upgrades. There are some
bits that may be loaded at application startup like, snap, libvirt, lxd, basically
container managers might do some thing custom per container.

Its the run time we want to minimize, the cost of.

Policy already can be unaligned (the container format rework to fix this is low
priority), and is treated as untrusted. It goes through an unpack, and translation to
machine native, with as many bounds checks, necessary transforms etc done at unpack
time as possible, so that the run time costs can be minimized.

> If not, maybe just making the kernel aware that the tables might be unaligned
> can help, e.g. with the following (untested) patch.
> Adrian, maybe you want to test?
> 

> ------------------------
> 
> [PATCH] Allow apparmor to handle unaligned dfa tables
> 
> The dfa tables can originate from kernel or userspace and 8-byte alignment
> isn't always guaranteed and as such may trigger unaligned memory accesses
> on various architectures.
> Work around it by using the get_unaligned_xx() helpers.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
lgtm,

Acked-by: John Johansen <john.johansen@canonical.com>

I'll pull this into my tree regardless of whether it fixes the issue
for Adrian, as it definitely fixes an issue.

We can added additional patches on top s needed.


> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index c5a91600842a..26e82ba879d4 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -15,6 +15,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/err.h>
>   #include <linux/kref.h>
> +#include <linux/unaligned.h>
>   
>   #include "include/lib.h"
>   #include "include/match.h"
> @@ -42,11 +43,11 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
>   	/* loaded td_id's start at 1, subtract 1 now to avoid doing
>   	 * it every time we use td_id as an index
>   	 */
> -	th.td_id = be16_to_cpu(*(__be16 *) (blob)) - 1;
> +	th.td_id = get_unaligned_be16(blob) - 1;
>   	if (th.td_id > YYTD_ID_MAX)
>   		goto out;
> -	th.td_flags = be16_to_cpu(*(__be16 *) (blob + 2));
> -	th.td_lolen = be32_to_cpu(*(__be32 *) (blob + 8));
> +	th.td_flags = get_unaligned_be16(blob + 2);
> +	th.td_lolen = get_unaligned_be32(blob + 8);
>   	blob += sizeof(struct table_header);
>   
>   	if (!(th.td_flags == YYTD_DATA16 || th.td_flags == YYTD_DATA32 ||
> @@ -313,14 +314,14 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
>   	if (size < sizeof(struct table_set_header))
>   		goto fail;
>   
> -	if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
> +	if (get_unaligned_be32(data) != YYTH_MAGIC)
>   		goto fail;
>   
> -	hsize = ntohl(*(__be32 *) (data + 4));
> +	hsize = get_unaligned_be32(data + 4);
>   	if (size < hsize)
>   		goto fail;
>   
> -	dfa->flags = ntohs(*(__be16 *) (data + 12));
> +	dfa->flags = get_unaligned_be16(data + 12);
>   	if (dfa->flags & ~(YYTH_FLAGS))
>   		goto fail;
>   
> @@ -329,7 +330,7 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
>   	 * if (dfa->flags & YYTH_FLAGS_OOB_TRANS) {
>   	 *	if (hsize < 16 + 4)
>   	 *		goto fail;
> -	 *	dfa->max_oob = ntol(*(__be32 *) (data + 16));
> +	 *	dfa->max_oob = get_unaligned_be32(data + 16);
>   	 *	if (dfa->max <= MAX_OOB_SUPPORTED) {
>   	 *		pr_err("AppArmor DFA OOB greater than supported\n");
>   	 *		goto fail;


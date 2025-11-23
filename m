Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBF1FC0EA
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763863736; cv=none; b=kjCAnK3EPMEngZ56A6FUY4oZAiM1P7T7q0yl4zusAQpMSWMwCDbFBzlb6ZRdTxtg0wxOl1HiKbP+fodnPf/m4C1A9MtWbhZUSHXJvYdlWO38+bJqg68XFzf5b5i1rl9SJ8GbCTaY0qE542hSImrc7tAxEuByR8LREDBNJErUc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763863736; c=relaxed/simple;
	bh=nOLCb1tbMQLfJdr5R+D0OcbA5NGDolsCJ7PMeKOL6bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0VMZs8W3KzjPhafXehyFQsvM4KsVLcphkiI+r5qz0Bp2IiNNQwE+0za1Mcev/Hx6aWtSo7yTNGWLoIUg1gBqrOKLT14F4pmlyq5DIwiqhINRNmfU0NY2Elms8kG0aYMovATIKD0ThPAEioACTGwJqWi7XnjrmlFc71fPOHUOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=S9miimBk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="S9miimBk"
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F29833F2A1
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1763863726;
	bh=8a0z/wk/mu0JDwpB1nlChburcNktUNgCK6fbMb2S5Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=S9miimBk+IRU7xcox1PGgSr4zEleHEktEmhhCPKBdfvXMrEWdDWDp/49raUJ9aAWb
	 rH/kD3WxiGhr17T8GtzR+kW4QzaBpiDSvQufRLf/abUtrKW1Lv3hPAJAPxl0dAynNw
	 8pVG79W8enId66YaiExgnAiItaIkiMbCcJ2mXFiVqX9A+MDHUU+gsTnJsQ3BvKoRn1
	 IajUyuVNLjXQSL57W/H7uN2k+yHPY/gLY7ZEhHSLq2qXfq+16jNaiBlON8IUda1yAx
	 Ec8k26BiR3UqmDRAhthnjO5hDFsqNqEMScRfYQrKaOI9iWe4qEI8oGAW5ieud0lGyB
	 Ybr5qTHswI4twsNZI9k0y9mOKqtx1XEnXQQwG15b9QplaJLUy0nX5Dpxm1i1WBT5Qf
	 dBwNTdCbzkJalBB0oEz/4+AyySplayauTEMfIj9X+MjokEPNgTECLnIRVxtB+fU3Qa
	 1mCtywzEjO19tj63lGoWgVhLR8Kd8Wq2109fRDLK+qaQkcpu1++bJh9lDDNx1TxfDk
	 t1oJMy6rlvAiMbY2XiGUuCt+Kt4eEIKYahF7r349CE04CEu3AD7qnj1/bbB1u2TuHd
	 R4JyBSRMkjHQkZMLaahMr9g6QOPkn6vg/1bTSiNKsCrisVWBkDXfDHv+GcF++XA8+q
	 PRWipZ9qN0Uemf5xjy9XrM2c=
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso2885090b3a.2
        for <linux-security-module@vger.kernel.org>; Sat, 22 Nov 2025 18:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763863724; x=1764468524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a0z/wk/mu0JDwpB1nlChburcNktUNgCK6fbMb2S5Qg=;
        b=pb8vX72EyKWPqSpicp+DFpt/QPhwRjsh7Zk5wJaY7Ngj2VasPqgs9BW4ibiBQpYvWa
         BsL0zEfwyn8TmPopK/rCJ5W3fMCoY0YsNCQq52VU7y6UeOr5YTMAZqtWc+sVKLlVJ9B0
         fKIrHDnTshbqHVbD/SEQzIS4TxvrX2LODALMhoiHP6FIcvYrGpR0IrBSz1okucvDesVz
         HYky1CqRWVj6A/af//97Z27J5yg4g4ye6pyEosOAxw1MYGAqLLVwvkTiadHvDiY0vkcZ
         ZsRWG9kHIbOc1nlH9f2y3esB5tTb4Qs66nxQPsj/bjVCIfiaYqsnYIjSNqE7ciKoQ9Q1
         AhPA==
X-Forwarded-Encrypted: i=1; AJvYcCWSBs7EgCeCuKniI9nlT+k5YFvpfEts4PKJKnAYhgLPtKZNxS2Orz+awWm59EA6aGRqm2xVTkgTYwb2HO5rF8QkBOcVb+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTGE0qmDKDdST5sgSsg+1y+Z6PLIGbDHuIAwKTKKdMznmdAMM
	3ziTbcxsOcC4n3VULjjnwCyIvFnR2exbEjyxEVSoLHKMkvF5Cawp1SbTKWyblgnPbbEt6MhDbbR
	ewbgj0uZVaE60IOnKOdDgMOwVIzv+pMjEbEyO0BeiwgGJQeXg/0+90teEf2H7StpJeuGlT2/c0R
	TuvoY3SWXXXZAPDAl/skZ1MuvTjJYt
X-Gm-Gg: ASbGncvwvqsimYF/zGFpZShJBkLwDjdqCCy8sOYkgfbYHWwJEqkAww/gLBEMT6j/m5/
	THMQkkV3Ys774y2H5+c5Qr3wWs04vNt05SCOM/b8xfGCkKiEX4jSxRarfndPLsKCN1633kfB4F7
	t5/PaY96iIOYfajPRq0gRm8Aqj3GiCNeiYFSVXtvDwcYwcm29giCS0pfBtnSB41phzXCpW5mkmi
	H4TPbwnTkSYfHuKQl8kaAEsiMSyf/mVcJtcomPrVzT1Su2CWBCzMPedwj8iyBowCq8FLYvkpW54
	KGIXPcRQ/2mnIGUE0KyfzGihNSl/BIqkN0gbSnSvfvZ4DXtqFDy3WKDKNqaFOYKR5/q+6aZjIpY
	ozpKQ8OEjguoo6g0CbuV1qz9B
X-Received: by 2002:a05:6a00:2d0a:b0:7aa:5053:f42d with SMTP id d2e1a72fcca58-7c58e607616mr7156858b3a.22.1763863724193;
        Sat, 22 Nov 2025 18:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5EdW7DViLURFiTiYnDZdHr/ASDQFEH7LIzlahpAsWvtIRd3Fq9k5rfNebu9eARHSIFcAxzw==
X-Received: by 2002:a05:6a00:2d0a:b0:7aa:5053:f42d with SMTP id d2e1a72fcca58-7c58e607616mr7156836b3a.22.1763863723731;
        Sat, 22 Nov 2025 18:08:43 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7c3f155d053sm10164138b3a.62.2025.11.22.18.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 18:08:43 -0800 (PST)
Message-ID: <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
Date: Sat, 22 Nov 2025 18:08:42 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: Helge Deller <deller@gmx.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 04:49, Helge Deller wrote:
> Hi Adrian,
> 
> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>>> My patch fixed two call sites, but I suspect you see another call site which
>>> hasn't been fixed yet.
>>>
>>> Can you try attached patch? It might indicate the caller of the function and
>>> maybe prints the struct name/address which isn't aligned.
>>>
>>> Helge
>>>
>>>
>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>>> index c5a91600842a..b477430c07eb 100644
>>> --- a/security/apparmor/match.c
>>> +++ b/security/apparmor/match.c
>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
>>>       if (size < sizeof(struct table_set_header))
>>>           goto fail;
>>> +    if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
>>> +        pr_warn("dfa blob stream %pS not aligned.\n", data);
>>> +
>>>       if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
>>>           goto fail;
>>
>> Here is the relevant output with the patch applied:
>>
>> [   73.840639] ------------[ cut here ]------------
>> [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
>> [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus usb_common
>> [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted 6.18.0-rc6+ #9 NONE
>> [   74.536543] Call Trace:
>> [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
>> [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
>> [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
>> [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
>> [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
>> [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
>> [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
>> [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
>> [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
>> [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
>> [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
>> [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
>> [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
>> [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
>> [   75.548802] ---[ end trace 0000000000000000 ]---
>> [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
>> [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e8/0x720
> 
> The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspace
> (via the write syscall).
> Some apparmor userspace tool writes into the apparmor ".replace" virtual file with
> a source address which is not correctly aligned.

the userpace buffer passed to write(2) has to be aligned? Its certainly nice if it
is but the userspace tooling hasn't been treating it as aligned. With that said,
the dfa should be padded to be aligned. So this tripping in the dfa is a bug,
and there really should be some validation to catch it.

> You should be able to debug/find the problematic code with strace from userspace.
> Maybe someone with apparmor knowledge here on the list has an idea?
> 
This is likely an unaligned 2nd profile, being split out and loaded separately
from the rest of the container. Basically the loader for some reason (there
are a few different possible reasons) is poking into the container format and
pulling out the profile at some offset, this gets loaded to the kernel but
it would seem that its causing an issue with the dfa alignment within the container,
which should be aligned to the original container.

Kernel side, we are going to need to add some extra verification checks, it should
be catching this, as unaligned as part of the unpack. Userspace side, we will have
to verify my guess and fix the loader.




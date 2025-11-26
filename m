Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92E285071
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148315; cv=none; b=kt8TedDaOMMwRDL+j92b0Q+tgsKfBRj+t4GGU3Sv0i12k6LilWWB7xKYvRT6ofEP1YCyAIKDY5k5LfwixGVdIU4fI/6YnNVen0CdW2TPd24HtbQVQnhuIOwksMLKqBSq5NnW8cSotiNvxyblsjWGKF5v05vHIA2Pnqt07StZqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148315; c=relaxed/simple;
	bh=i8D0xyAWUgRn0DHMQ7Fti7HwzE2iQPIm105OGG8xU2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rK7ZUNG0pKR9xXFN4okRCPDNLpGmjY2hulQmVD95DBCu0lRfhtBT8AIicIsWS34MkKgpCk79uo48ktr+wx5Nm5aj09nGH6YoPDylZIxiGt7ORm9DVR5uDNjJ/FdKh2/F9WT3NgJkA8VzLTcTHCpoRh9UbyPFuEM4vWZzR0utwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UrZzfczE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UrZzfczE"
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5FD353F2A9
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764148309;
	bh=a29qN9l7N9PNW6+6IM0JAqe+Ls44OLhlihGNAtWSXRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=UrZzfczENbUjrzgbPsmkFh1eWfnCKzUhspIcxI0SblLl3NMKgarDTr8A9/m7hnh9Q
	 I1Dzbvjlwg4M4cs/3g2CIN0ukr1wHlFvl2/HWt2QCmJK83yjrckdmotrB1I2+W7s+t
	 mdsVUYn1XjdNSzUoTqk3k3gIYFdED8pw8blYvHyL46Yeh9roGxBCMr77JYpCT7ht9i
	 sW1DUQwvVMA1a3PEOiGafrHE44W3gd+3hm8P31yGkm+Ci1BSozkX87ct8Mr0O0lO7m
	 +2l0+S9vmbzqrlDbBiXFP+GB47UrNu9k8zxRrzScZwBqo/EwwYrgu1RZnw2TjP55pG
	 vSY5ybRHR0TYH+C9YO9rbsbxSQPTqoToAheXdcLnAgURvG1EnDHhMaj1IFQBT5sdNQ
	 dPA6xKqS78hhM9DPa4ctryG2k8JY3hmqXqs+P6TAtIsMbfJ3rAJ//F1oC/CMm8hqDl
	 bwOymg125oaPvYasOPyomsA6bueCpnERaYUlAc0gO1XFkqGDbSj4ex4yXNiXuuFcAI
	 33fc6t5ovdvsybn00SwNFHDhpvw5BHofsN8A1kAWNMiwkwY/fIEM6bJv3YC94cRC5v
	 /dXA8ppKbKSYAGdJh4wzCF01/JnRHBpu3orSCMaVQP+aGGY2P0pCOG1tlP8qLaj8kf
	 RpGnnmHta10+W5S60E5UY5Bc=
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bd74e95f05aso450262a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 01:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148308; x=1764753108;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a29qN9l7N9PNW6+6IM0JAqe+Ls44OLhlihGNAtWSXRk=;
        b=sY1WGWIrLnZ6qnEZt5fMMxAop1WOXRgZ4zRDOCOEQ1e3EQjta0B/rXpmlPbWDNVgXV
         v3nHV+qwuqE9INm86k//7qwQSCbXCNfeaM20uNaC9OVHywznFir19vc28bkeXTzBN+CY
         c58k2WidnyvT4zy8m671jbOYfVuhUzcao1g8iCfEs2sKzGTcMOaoxHj3fPrdVaV0tbfL
         xDHcslPezkCs36XF/fKvd5rsAlqztI9hTOVKnVhfrHoH0lK9YNH7ai0/JNPa/61Z3S8P
         7NmmRBVs+wqPSt17+DkoUG360g0v0+W7KD7YrWl1kMcigaIadZfuXoSoyXzPCi7ox1JT
         uulw==
X-Forwarded-Encrypted: i=1; AJvYcCXnqrqL0AgN0+lUBT6ODxReYKMdqueTWZPwu1WbCU8hF5VxdvbSnntiXMTB/lj0tKYI0aI45Rve5hB2jHWZuIAWelGWd0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYboYB5LjKj+90Lk/gfREbG4Xw+1Q4LQdSCidDeinApm8f1kdd
	ia00ZFbIhe4BFZxVw0mTjcrLSOaknVigsTKbHojT0rjR2UslYiH/rebXPSKqgvKjBG121p4dT2g
	C0ijtiGe9v4xHxz7RqLMzdM9eV/TEqug4a5pHX4z9lJKa90jiNX+q1gyRRkzo52lvOhxLOail40
	g4VO/tPpc4DJRrG8aL8V6kTf1m1cW+
X-Gm-Gg: ASbGncvZWC9sz4LRqD0TFX8521PfTlxeu5Gs6SfuHUl3E/OFz4AGFc4+KO8kWGgh/3z
	4wKA7oRhJvIOQmazhmXleP3I7nlPkyq/+qE0kKj/MDlJoa6rZ92SNeaFeLrMhJvWVJup8y0mRFj
	sFq5XTsfwr5GdtnmM/7neGPexVHsNE1yUPf7xOUhCflQfiOBLzO6Nev3qzQoqp0VYua6C7efSDc
	N6DE4mz5oBND2G/JZ/iDaD5ABmZ8b1s3B7Bv6diIMIjDgLJbOjbjrFDSFHvlXr++ZHzEImK/h25
	t0TI5Gl6vIsgYibf9cfzY/mn4xr8Dbu5txq4VSDyyovY/RKizUOlP4YyrnOyb1TTDQg3GTqmGui
	k/fRToIJd4LVvP0aVUwN5zKDP
X-Received: by 2002:a05:6a20:5491:b0:35e:caf1:78e3 with SMTP id adf61e73a8af0-3613e3c5be4mr25718726637.11.1764148307955;
        Wed, 26 Nov 2025 01:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTkqLB2YmgfMxW2OCGqkvGGNja0RxxGfeuG0ewkKGDFNd5+oDzRsV8UCkDTTwvNCLorfzIKQ==
X-Received: by 2002:a05:6a20:5491:b0:35e:caf1:78e3 with SMTP id adf61e73a8af0-3613e3c5be4mr25718691637.11.1764148307436;
        Wed, 26 Nov 2025 01:11:47 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bd75dfeeaffsm18724212a12.5.2025.11.26.01.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:11:46 -0800 (PST)
Message-ID: <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
Date: Wed, 26 Nov 2025 01:11:45 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
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
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 13:13, Helge Deller wrote:
> On 11/25/25 20:20, John Johansen wrote:
>> On 11/25/25 07:11, Helge Deller wrote:
>>> * John Johansen <john.johansen@canonical.com>:
>>>> On 11/18/25 04:49, Helge Deller wrote:
>>>>> Hi Adrian,
>>>>>
>>>>> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
>>>>>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>>>>>>> My patch fixed two call sites, but I suspect you see another call site which
>>>>>>> hasn't been fixed yet.
>>>>>>>
>>>>>>> Can you try attached patch? It might indicate the caller of the function and
>>>>>>> maybe prints the struct name/address which isn't aligned.
>>>>>>>
>>>>>>> Helge
>>>>>>>
>>>>>>>
>>>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>>>>>>> index c5a91600842a..b477430c07eb 100644
>>>>>>> --- a/security/apparmor/match.c
>>>>>>> +++ b/security/apparmor/match.c
>>>>>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
>>>>>>>        if (size < sizeof(struct table_set_header))
>>>>>>>            goto fail;
>>>>>>> +    if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
>>>>>>> +        pr_warn("dfa blob stream %pS not aligned.\n", data);
>>>>>>> +
>>>>>>>        if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
>>>>>>>            goto fail;
>>>>>>
>>>>>> Here is the relevant output with the patch applied:
>>>>>>
>>>>>> [   73.840639] ------------[ cut here ]------------
>>>>>> [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
>>>>>> [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
>>>>>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus usb_common
>>>>>> [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted 6.18.0-rc6+ #9 NONE
>>>>>> [   74.536543] Call Trace:
>>>>>> [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
>>>>>> [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
>>>>>> [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
>>>>>> [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
>>>>>> [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
>>>>>> [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
>>>>>> [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
>>>>>> [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
>>>>>> [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
>>>>>> [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
>>>>>> [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
>>>>>> [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
>>>>>> [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
>>>>>> [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
>>>>>> [   75.548802] ---[ end trace 0000000000000000 ]---
>>>>>> [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
>>>>>> [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e8/0x720
>>>>>
>>>>> The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspace
>>>>> (via the write syscall).
>>>>> Some apparmor userspace tool writes into the apparmor ".replace" virtual file with
>>>>> a source address which is not correctly aligned.
>>>>
>>>> the userpace buffer passed to write(2) has to be aligned? Its certainly nice if it
>>>> is but the userspace tooling hasn't been treating it as aligned. With that said,
>>>> the dfa should be padded to be aligned. So this tripping in the dfa is a bug,
>>>> and there really should be some validation to catch it.
>>>>
>>>>> You should be able to debug/find the problematic code with strace from userspace.
>>>>> Maybe someone with apparmor knowledge here on the list has an idea?
>>>>>
>>>> This is likely an unaligned 2nd profile, being split out and loaded separately
>>>> from the rest of the container. Basically the loader for some reason (there
>>>> are a few different possible reasons) is poking into the container format and
>>>> pulling out the profile at some offset, this gets loaded to the kernel but
>>>> it would seem that its causing an issue with the dfa alignment within the container,
>>>> which should be aligned to the original container.
>>>
>>>
>>> Regarding this:
>>>
>>>> Kernel side, we are going to need to add some extra verification checks, it should
>>>> be catching this, as unaligned as part of the unpack. Userspace side, we will have
>>>> to verify my guess and fix the loader.
>>>
>>> I wonder if loading those tables are really time critical?
>>
>> no, most policy is loaded once on boot and then at package upgrades. There are some
>> bits that may be loaded at application startup like, snap, libvirt, lxd, basically
>> container managers might do some thing custom per container.
>>
>> Its the run time we want to minimize, the cost of.
>>
>> Policy already can be unaligned (the container format rework to fix this is low
>> priority), and is treated as untrusted. It goes through an unpack, and translation to
>> machine native, with as many bounds checks, necessary transforms etc done at unpack
>> time as possible, so that the run time costs can be minimized.
>>
>>> If not, maybe just making the kernel aware that the tables might be unaligned
>>> can help, e.g. with the following (untested) patch.
>>> Adrian, maybe you want to test?
>>>
>>
>>> ------------------------
>>>
>>> [PATCH] Allow apparmor to handle unaligned dfa tables
>>>
>>> The dfa tables can originate from kernel or userspace and 8-byte alignment
>>> isn't always guaranteed and as such may trigger unaligned memory accesses
>>> on various architectures.
>>> Work around it by using the get_unaligned_xx() helpers.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>> lgtm,
>>
>> Acked-by: John Johansen <john.johansen@canonical.com>
>>
>> I'll pull this into my tree regardless of whether it fixes the issue
>> for Adrian, as it definitely fixes an issue.
>>
>> We can added additional patches on top s needed.
> 
> My patch does not modify the UNPACK_ARRAY() macro, which we
> possibly should adjust as well.

Indeed. See the patch below. I am not surprised testing hasn't triggered this
case, but a malicious userspace could certainly construct a policy that would
trigger it. Yes it would have to be root, but I still would like to prevent
root from being able to trigger this.

> Adrian's testing seems to trigger only a few unaligned accesses,
> so maybe it's not a issue currently.
> 
I don't think the userspace compiler is generating one that is bad, but it
possible to construct one and get it to the point where it can trip in
UNPACK_ARRAY

commit 2c87528c1e7be3976b61ac797c6c8700364c4c63
Author: John Johansen <john.johansen@canonical.com>
Date:   Tue Nov 25 13:59:32 2025 -0800

     apparmor: fix unaligned memory access of UNPACK_ARRAY
     
     The UNPACK_ARRAY macro has the potential to have unaligned memory
     access when the unpacking an unaligned profile, which is caused by
     userspace splitting up a profile container before sending it to the
     kernel.
     
     While this is corner case, policy loaded from userspace should be
     treated as untrusted so ensure that userspace can not trigger an
     unaligned access.
     
     Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index 1fbe82f5021b1..203f7c07529f5 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -104,7 +104,7 @@ struct aa_dfa {
  	struct table_header *tables[YYTD_ID_TSIZE];
  };
  
-#define byte_to_byte(X) (X)
+#define byte_to_byte(X) *(X)
  
  #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
  	do { \
@@ -112,7 +112,7 @@ struct aa_dfa {
  		TTYPE *__t = (TTYPE *) TABLE; \
  		BTYPE *__b = (BTYPE *) BLOB; \
  		for (__i = 0; __i < LEN; __i++) { \
-			__t[__i] = NTOHX(__b[__i]); \
+			__t[__i] = NTOHX(&__b[__i]); \
  		} \
  	} while (0)
  
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 26e82ba879d44..3dcc342337aca 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
  				     u8, u8, byte_to_byte);
  		else if (th.td_flags == YYTD_DATA16)
  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u16, __be16, be16_to_cpu);
+				     u16, __be16, get_unaligned_be16);
  		else if (th.td_flags == YYTD_DATA32)
  			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
-				     u32, __be32, be32_to_cpu);
+				     u32, __be32, get_unaligned_be32);
  		else
  			goto fail;
  		/* if table was vmalloced make sure the page tables are synced



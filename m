Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D07313537
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184981; cv=none; b=TIXYoyyv849F19hp+5QHuaa4lnz7Fu0N/x2JRfzZr/cwf7DrBeWgXYgjwrUXNe3wCSK1lmroDFhcfVtPVzEXDIS23NHVA/8EhOnm/DaIelEGL78PxTfkb57mU0sBX+mZjTf9V7wS7CRCoURFxDJnAeOFToI3JjjH6Wj/He0VNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184981; c=relaxed/simple;
	bh=0hirnEOzsvL7R5KJE8xoZhMUGGvRCsOO2pZvgrFpUqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCJqLTtmEoM2D9Xhl/UATvxy4ErnmsApzDiY6rdLabuIyL/Ova7MhfXXprZkvFxd19IYLEo7u56Ggll4s5gxXd07TpzKG7Sg2j9BMaexZLiOFwrWEZRTfkfKSdBxHv+TcPwBjllReXcR4/3DR2+DIkyn7b5wd5YRfwsmoQiwSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=bMdRdw6f; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="bMdRdw6f"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F033F40F18
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764184962;
	bh=HpISxZoFsAswvw2Vev1V7s27tbYB418EnQjvSTZMQCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=bMdRdw6fwjbT4LwDtITfi5KbPPye+Gk0Vt8NIEQAoZtuSOQgQ9Rj4Ju3wc3ECvvGx
	 hRdDGt1Hr4pr5Yy5uGE1ohqbEo+J01mVC6SZWzMZpvsLd4vH5SRyEeFCVVjeU1IXON
	 0WvhiSixq6d1gwxkxIhpQFr+vw8zxrGUSXNYfzGIycm4NOR7pUJVoountXCNOaow4o
	 DEemzjAcPd+X28A+E54jNX+1DZkNl4b9+W8k4ngn+4qVeuzq2Ge3e7SbV3h/b6Sqh7
	 Td2IfqouHx2OWlJY9H7ZKu2N6cXzEqR0ueu1ji84jbE9NMQPW802o6x99Vz+SNm+Iy
	 zHU/C0/z0pt+Ie9ACAhC6Ep/WgcvYK51uQNobOLoxgctomOgArywvmMlu6gRM8MFjS
	 O5eNbHYmZpxWPX1dzHIFto9zXRNRFDqTwQZkYASlrd4Our+G+Pqo9oIJy9z7M7ljCE
	 kKJrKi9Hn0x3z3i0eM7rkCH7h33iEF56D/uNMDQSXueaGMpAtXbPjOzi+1W9ARC2iD
	 cRWx5QDIbDtGscP6vUlwR6u+zXB0MCzYzwJ4q86PBsM2Yt4bBr95kBCU1Z72w3hMWn
	 r5grNb+zwC4kMMh+1cnfRP9+oZ2bSi5zG4mYpg0mHi6kSHTH5sYg+k6s47hC7B3rZF
	 tcs5RuVFZDQf8fPSu7VCcrb4=
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7c240728e2aso73465b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 11:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764184958; x=1764789758;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpISxZoFsAswvw2Vev1V7s27tbYB418EnQjvSTZMQCI=;
        b=LTB9oowQb8w+czuCAzMfQvlwcAaXEw3hmhf9RYFg+Pjqemy7xHEcJBP+//YHa8VLwi
         5lP05rQkAQo5CIlwW6hn77z3EcFApiSoFAooS97K/MXxh8vOx3GT/OXNCANWTW6xfKO/
         f+MDAvvy2vqn5DUZyN/vINMNEc3oXkfWYUc1pwQ2dg75FPfJsh9adrVpmSSnARSK8bLr
         Oav2Zz+6ejLLQHttQ/vjtJVXPfj6TuYs/SqAzm22NK8ReRkXntaP1j4YzxOR9GB/Z+AQ
         Kq/3m3NaIwig+8BYzHxH407W1c0MAYNP3RiRQPKS+ytUZ4P43IkVC6zyHwZkSb8KPfe6
         WNVg==
X-Forwarded-Encrypted: i=1; AJvYcCWAobdi5eRE9/E+QwuwetdcdlU5cC6po874OqyOvfCGlW/C/QJUXNV+IHloVwo9s2MZmbVLBbpAyBmHD2fRP9eOfUEhb+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvfZsw1xGXvuYMtG34YsDyuuSuu7K6e8bNr2CRQaUP8WL2nAU
	OS6fCfDxNYq48O5cnW8xuQj10nrYbOmNXw2naF8UASY5VqsQMgYjzPhl1M7EgKZO5hZ8UDFamPe
	79n9pC+X18pNq9JX77urhbFbS2oZtpYSqH5c8p7kxGqG3ZGibiQMqjF+His0anKjH12c3+BdDVN
	QcoH2+UsEa0mMwSDdB2Q==
X-Gm-Gg: ASbGncvc5dezTDF8AGl5Nb6KULpqxPGlWPz+d6If2S+yEAVAeWh4EN+XooqZku4emoe
	bBcpsXILpWlOaIgAgg87Y6vClYPb7IvsTC3ZNqDgtDwnFkV09hKhskBg7Kl2rTAzRfCgzvEazJ6
	DkH/qX6OPeZZvdGA3whjtn9HYZsWBnEiZrP+4DrJQyQZIDino9a8OGJrliwAc1fCLR2lSG8Hir3
	/cdjFjqHEQbAywvrIQ/YFKVSOsil/9n9NCR9fEi9zpjyEQuSbrDtUaCs86ORAfekOXMFjnzEjoL
	yZ33f9c9SpjS5iBv/wbdpKu+dbsbk0b9udLL+nX538W86YFqsvNVJyoh4gTnUzylBfLJTMEKx3t
	5hcXGq1l/MIHCmV+XE0ku+//e
X-Received: by 2002:a05:6a20:3c89:b0:304:313a:4bcd with SMTP id adf61e73a8af0-3614ed3e0afmr23230842637.30.1764184957865;
        Wed, 26 Nov 2025 11:22:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHVAk9Xw8ILesdGB7m2WNRLS3td28HvyU0BBDFTEqpQmH82HgLZXPQOCT/YX6sbjDlqoy+Jg==
X-Received: by 2002:a05:6a20:3c89:b0:304:313a:4bcd with SMTP id adf61e73a8af0-3614ed3e0afmr23230822637.30.1764184957322;
        Wed, 26 Nov 2025 11:22:37 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-bd7604de9f8sm19878018a12.19.2025.11.26.11.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:22:36 -0800 (PST)
Message-ID: <06056268-bbae-4a35-8a17-9e52ab608e61@canonical.com>
Date: Wed, 26 Nov 2025 11:22:35 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
To: david laight <david.laight@runbox.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20250531150822.135803-1-deller@kernel.org>
 <bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
 <aRxT78fdN5v2Ajyl@p100>
 <90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
 <be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
 <ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com> <aSXHCyH_rS-c5BgP@p100>
 <e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
 <c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
 <d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
 <20251126104444.29002552@pumpkin>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20251126104444.29002552@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/25 02:44, david laight wrote:
> On Wed, 26 Nov 2025 01:11:45 -0800
> John Johansen <john.johansen@canonical.com> wrote:
> 
>> On 11/25/25 13:13, Helge Deller wrote:
>>> On 11/25/25 20:20, John Johansen wrote:
>>>> On 11/25/25 07:11, Helge Deller wrote:
>>>>> * John Johansen <john.johansen@canonical.com>:
>>>>>> On 11/18/25 04:49, Helge Deller wrote:
>>>>>>> Hi Adrian,
>>>>>>>
>>>>>>> On 11/18/25 12:43, John Paul Adrian Glaubitz wrote:
>>>>>>>> On Tue, 2025-11-18 at 12:09 +0100, Helge Deller wrote:
>>>>>>>>> My patch fixed two call sites, but I suspect you see another call site which
>>>>>>>>> hasn't been fixed yet.
>>>>>>>>>
>>>>>>>>> Can you try attached patch? It might indicate the caller of the function and
>>>>>>>>> maybe prints the struct name/address which isn't aligned.
>>>>>>>>>
>>>>>>>>> Helge
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>>>>>>>>> index c5a91600842a..b477430c07eb 100644
>>>>>>>>> --- a/security/apparmor/match.c
>>>>>>>>> +++ b/security/apparmor/match.c
>>>>>>>>> @@ -313,6 +313,9 @@ struct aa_dfa *aa_dfa_unpack(void *blob, size_t size, int flags)
>>>>>>>>>         if (size < sizeof(struct table_set_header))
>>>>>>>>>             goto fail;
>>>>>>>>> +    if (WARN_ON(((unsigned long)data) & (BITS_PER_LONG/8 - 1)))
>>>>>>>>> +        pr_warn("dfa blob stream %pS not aligned.\n", data);
>>>>>>>>> +
>>>>>>>>>         if (ntohl(*(__be32 *) data) != YYTH_MAGIC)
>>>>>>>>>             goto fail;
>>>>>>>>
>>>>>>>> Here is the relevant output with the patch applied:
>>>>>>>>
>>>>>>>> [   73.840639] ------------[ cut here ]------------
>>>>>>>> [   73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/match.c:316 aa_dfa_unpack+0x6cc/0x720
>>>>>>>> [   74.015867] Modules linked in: binfmt_misc evdev flash sg drm drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
>>>>>>>> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sym53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus usb_common
>>>>>>>> [   74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not tainted 6.18.0-rc6+ #9 NONE
>>>>>>>> [   74.536543] Call Trace:
>>>>>>>> [   74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
>>>>>>>> [   74.633757] [<0000000000476438>] __warn+0xd8/0x100
>>>>>>>> [   74.696664] [<00000000004296d4>] warn_slowpath_fmt+0x34/0x74
>>>>>>>> [   74.771006] [<00000000008db28c>] aa_dfa_unpack+0x6cc/0x720
>>>>>>>> [   74.843062] [<00000000008e643c>] unpack_pdb+0xbc/0x7e0
>>>>>>>> [   74.910545] [<00000000008e7740>] unpack_profile+0xbe0/0x1300
>>>>>>>> [   74.984888] [<00000000008e82e0>] aa_unpack+0xe0/0x6a0
>>>>>>>> [   75.051226] [<00000000008e3ec4>] aa_replace_profiles+0x64/0x1160
>>>>>>>> [   75.130144] [<00000000008d4d90>] policy_update+0xf0/0x280
>>>>>>>> [   75.201057] [<00000000008d4fc8>] profile_replace+0xa8/0x100
>>>>>>>> [   75.274258] [<0000000000766bd0>] vfs_write+0x90/0x420
>>>>>>>> [   75.340594] [<00000000007670cc>] ksys_write+0x4c/0xe0
>>>>>>>> [   75.406932] [<0000000000767174>] sys_write+0x14/0x40
>>>>>>>> [   75.472126] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
>>>>>>>> [   75.548802] ---[ end trace 0000000000000000 ]---
>>>>>>>> [   75.609503] dfa blob stream 0xfff0000008926b96 not aligned.
>>>>>>>> [   75.682695] Kernel unaligned access at TPC[8db2a8] aa_dfa_unpack+0x6e8/0x720
>>>>>>>
>>>>>>> The non-8-byte-aligned address (0xfff0000008926b96) is coming from userspace
>>>>>>> (via the write syscall).
>>>>>>> Some apparmor userspace tool writes into the apparmor ".replace" virtual file with
>>>>>>> a source address which is not correctly aligned.
>>>>>>
>>>>>> the userpace buffer passed to write(2) has to be aligned? Its certainly nice if it
>>>>>> is but the userspace tooling hasn't been treating it as aligned. With that said,
>>>>>> the dfa should be padded to be aligned. So this tripping in the dfa is a bug,
>>>>>> and there really should be some validation to catch it.
>>>>>>   
>>>>>>> You should be able to debug/find the problematic code with strace from userspace.
>>>>>>> Maybe someone with apparmor knowledge here on the list has an idea?
>>>>>>>   
>>>>>> This is likely an unaligned 2nd profile, being split out and loaded separately
>>>>>> from the rest of the container. Basically the loader for some reason (there
>>>>>> are a few different possible reasons) is poking into the container format and
>>>>>> pulling out the profile at some offset, this gets loaded to the kernel but
>>>>>> it would seem that its causing an issue with the dfa alignment within the container,
>>>>>> which should be aligned to the original container.
>>>>>
>>>>>
>>>>> Regarding this:
>>>>>   
>>>>>> Kernel side, we are going to need to add some extra verification checks, it should
>>>>>> be catching this, as unaligned as part of the unpack. Userspace side, we will have
>>>>>> to verify my guess and fix the loader.
>>>>>
>>>>> I wonder if loading those tables are really time critical?
>>>>
>>>> no, most policy is loaded once on boot and then at package upgrades. There are some
>>>> bits that may be loaded at application startup like, snap, libvirt, lxd, basically
>>>> container managers might do some thing custom per container.
>>>>
>>>> Its the run time we want to minimize, the cost of.
>>>>
>>>> Policy already can be unaligned (the container format rework to fix this is low
>>>> priority), and is treated as untrusted. It goes through an unpack, and translation to
>>>> machine native, with as many bounds checks, necessary transforms etc done at unpack
>>>> time as possible, so that the run time costs can be minimized.
>>>>   
>>>>> If not, maybe just making the kernel aware that the tables might be unaligned
>>>>> can help, e.g. with the following (untested) patch.
>>>>> Adrian, maybe you want to test?
>>>>>   
>>>>   
>>>>> ------------------------
>>>>>
>>>>> [PATCH] Allow apparmor to handle unaligned dfa tables
>>>>>
>>>>> The dfa tables can originate from kernel or userspace and 8-byte alignment
>>>>> isn't always guaranteed and as such may trigger unaligned memory accesses
>>>>> on various architectures.
>>>>> Work around it by using the get_unaligned_xx() helpers.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>   
>>>> lgtm,
>>>>
>>>> Acked-by: John Johansen <john.johansen@canonical.com>
>>>>
>>>> I'll pull this into my tree regardless of whether it fixes the issue
>>>> for Adrian, as it definitely fixes an issue.
>>>>
>>>> We can added additional patches on top s needed.
>>>
>>> My patch does not modify the UNPACK_ARRAY() macro, which we
>>> possibly should adjust as well.
>>
>> Indeed. See the patch below. I am not surprised testing hasn't triggered this
>> case, but a malicious userspace could certainly construct a policy that would
>> trigger it. Yes it would have to be root, but I still would like to prevent
>> root from being able to trigger this.
>>
>>> Adrian's testing seems to trigger only a few unaligned accesses,
>>> so maybe it's not a issue currently.
>>>    
>> I don't think the userspace compiler is generating one that is bad, but it
>> possible to construct one and get it to the point where it can trip in
>> UNPACK_ARRAY
>>
>> commit 2c87528c1e7be3976b61ac797c6c8700364c4c63
>> Author: John Johansen <john.johansen@canonical.com>
>> Date:   Tue Nov 25 13:59:32 2025 -0800
>>
>>       apparmor: fix unaligned memory access of UNPACK_ARRAY
>>       
>>       The UNPACK_ARRAY macro has the potential to have unaligned memory
>>       access when the unpacking an unaligned profile, which is caused by
>>       userspace splitting up a profile container before sending it to the
>>       kernel.
>>       
>>       While this is corner case, policy loaded from userspace should be
>>       treated as untrusted so ensure that userspace can not trigger an
>>       unaligned access.
>>       
>>       Signed-off-by: John Johansen <john.johansen@canonical.com>
>>
>> diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
>> index 1fbe82f5021b1..203f7c07529f5 100644
>> --- a/security/apparmor/include/match.h
>> +++ b/security/apparmor/include/match.h
>> @@ -104,7 +104,7 @@ struct aa_dfa {
>>    	struct table_header *tables[YYTD_ID_TSIZE];
>>    };
>>    
>> -#define byte_to_byte(X) (X)
>> +#define byte_to_byte(X) *(X)
> 
> Even though is is only used once that ought to be (*(X))
> 
>>    
>>    #define UNPACK_ARRAY(TABLE, BLOB, LEN, TTYPE, BTYPE, NTOHX)	\
>>    	do { \
>> @@ -112,7 +112,7 @@ struct aa_dfa {
>>    		TTYPE *__t = (TTYPE *) TABLE; \
>>    		BTYPE *__b = (BTYPE *) BLOB; \
>>    		for (__i = 0; __i < LEN; __i++) { \
>> -			__t[__i] = NTOHX(__b[__i]); \
>> +			__t[__i] = NTOHX(&__b[__i]); \
>>    		} \
>>    	} while (0)
>>    
>> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
>> index 26e82ba879d44..3dcc342337aca 100644
>> --- a/security/apparmor/match.c
>> +++ b/security/apparmor/match.c
>> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
>>    				     u8, u8, byte_to_byte);
> 
> Is that that just memcpy() ?
> 
yeah for the byte case it is and we should just replace that case of UNPACK_ARRAY

> 	David
> 
>>    		else if (th.td_flags == YYTD_DATA16)
>>    			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
>> -				     u16, __be16, be16_to_cpu);
>> +				     u16, __be16, get_unaligned_be16);
>>    		else if (th.td_flags == YYTD_DATA32)
>>    			UNPACK_ARRAY(table->td_data, blob, th.td_lolen,
>> -				     u32, __be32, be32_to_cpu);
>> +				     u32, __be32, get_unaligned_be32);
>>    		else
>>    			goto fail;
>>    		/* if table was vmalloced make sure the page tables are synced
>>
>>
>>
> 


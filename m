Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8C33E1;
	Thu,  8 Aug 2024 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081264; cv=none; b=DUmcDwSUkq7PGN6To4XHxJ0w2riDgm/uv8uCGy3I7NYBANbzD63o3r/765NYzcNUozXKzn3/hWywVqC2o/93p54tybuoZyvbvrjjv7YRcUP51WIyeon+pIZFRscAZTFhveW8dWeeTt3m3dQGRLFfzP/qjY+6VgXiBZ/DY8OpWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081264; c=relaxed/simple;
	bh=IEAILzpzDQJbvJnA3zj3LZ+xLy+KZC9xEGdMZe9fyQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiogV+mJ2wg+Pz4n1FH/iiRgYN1KeS67k3NAjEO5nQYmFHM+FRenvi3evH3GsUjbqso3R0XU8kTbKWvc3Em3YjlOExf2vThD9en9dxmun92bs0/UVTo2qRCQHBVr9nqnCxF6STqIO+CVPqZF51ko2i+V/BgFGM4QTkCNXCBVzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeD39hHi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeD39hHi"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso389076b3a.2;
        Wed, 07 Aug 2024 18:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723081262; x=1723686062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nglXbj3cjozR0F0kRJiW+Gb9pKTJXi/g+vFQQRkFt/8=;
        b=DeD39hHi+P85SHLzR+EmbGxNOu0f1uCIgDa6kIIrhzhs7qP4K538TLmv7aRnstTzBR
         ulQx/FsoUSOO/Jy73tM60hm7rGN1CkqnWNVY346sG3WY4iGgoRlZotEplO1io2RB/Mng
         +tkTr6HKAc1YMyGuuV4Pgvl36sD2K23Ze+aeTyuuYRh2+44liB9b6dyqMS8MaKZoWA/+
         U/rbg84+TP0mXmxz7NeElK3yAyUzLxtyuljgmLU/q3uEozQ68Tc4WCW6WZM/Y3CZOnNs
         OATngyODtvj/D8ns1V9tgCAaFmVo8weK8wdFxqVpMCSK0rirFpc1v+U2Ght93TP/djM3
         syFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723081262; x=1723686062;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nglXbj3cjozR0F0kRJiW+Gb9pKTJXi/g+vFQQRkFt/8=;
        b=oQnSkpRxKDATJC9nQUyBRy2hy0j9yE/GywaPX0QwTv12WEjopf0/hSEtIMb5T8NR6G
         G5in8f8ybmzl0352J9w2VijnikajsUv73vs9d9Cpl18TLPtSCpiFN4L1YcwVxUOG7ZtK
         +YHGVt6M5xITcw5Lx2CL2O8Ii9iuzjaVScJ2mwfKmTyaDAdBXKc7esihdIyrw9VVzBBP
         YuPun/5E75cYHeM4GxFqpdjQK93LcjG0cvV3fIGjWSVc/AKPj8VehzTjdBsejR4CcrOt
         ja4LIZlBMBjVj8fEAq2TTR47OJngdZ/Z+Fp50ZMHocy6Rw+jwPTEt9NAhJGB+n/U4+0I
         6K8w==
X-Forwarded-Encrypted: i=1; AJvYcCUu+iQ7QmWUfoDkP0DR6TMFn1YimvxTX5Oz9JiqJRvaKSTUgXDgZa34ntd1xPj4zle09XsSZdaKwfi2egc=@vger.kernel.org, AJvYcCVxaHagwrW83XKl2RFIaLVkmb12G0PORvHqWF5Li+bp5YCpYt5udefIRn3EfBTUMTycVel//YQNwjxI844zd4LQ7itcKqcL@vger.kernel.org
X-Gm-Message-State: AOJu0YyO8HHD86i+GlMmXz58Lj4TSN1wXTA5nUnWWHoLVndWhE7a28sC
	8gbn0kOSWQHjq0rb6i2+qwmsETGQkOKcBUsWkuDXP0IrgKB9Yior
X-Google-Smtp-Source: AGHT+IEbLVCrpMUHmSKmWF6wukXtGIGPDRB/vDQrnMvPyvbSDYUiu6cZrfHtkmt/b5CQMgCyEagylg==
X-Received: by 2002:a05:6a20:a11c:b0:1c0:e8a3:dbfa with SMTP id adf61e73a8af0-1c6fce838f7mr414312637.2.1723081261630;
        Wed, 07 Aug 2024 18:41:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a03csm144206b3a.35.2024.08.07.18.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 18:41:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9216940f-cee5-402e-a7f5-71e1df52f452@roeck-us.net>
Date: Wed, 7 Aug 2024 18:40:59 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org
References: <20240801171747.3155893-1-kpsingh@kernel.org>
 <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X>
 <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
 <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 18:18, Paul Moore wrote:
> On Wed, Aug 7, 2024 at 8:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 8/7/24 16:43, Paul Moore wrote:
>>> On Wed, Aug 7, 2024 at 6:45 PM KP Singh <kpsingh@kernel.org> wrote:
>>>> On Wed, Aug 7, 2024 at 10:45 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>> On Tue, Aug 6, 2024 at 5:41 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>>> On Mon, Aug 5, 2024 at 10:20 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>> For what it's worth, I have not noticed any issues in my -next testing
>>>>>>> with this patch applied but I only build architectures that build with
>>>>>>> LLVM due to the nature of my work. If exposure to more architectures is
>>>>>>> desirable, perhaps Guenter Roeck would not mind testing it with his
>>>>>>> matrix?
>>>>>>
>>>>>> Thanks Nathan.
>>>>>>
>>>>>> I think the additional testing would be great, KP can you please work
>>>>>> with Guenter to set this up?
>>>>>
>>>>
>>>> Adding Guenter directly to this thread.
>>>>
>>>>> Is that something you can do KP?  I'm asking because I'm looking at
>>>>> merging some other patches into lsm/dev and I need to make a decision
>>>>> about the static call patches (hold off on merging the other patches
>>>>> until the static call testing is complete, or yank the static call
>>>>> patches until testing is complete and then re-merge).  Understanding
>>>>> your ability to do the additional testing, and a rough idea of how
>>>>
>>>> I have done the best of the testing I could do here. I think we should
>>>> let this run its normal course and see if this breaks anything. I am
>>>> not sure how testing is done before patches are merged and what else
>>>> you expect me to do?
>>>
>>> That is why I was asking you to get in touch with Guenter to try and
>>> sort out what needs to be done to test this across different
>>> architectures.
>>>
>>> With all due respect, this patchset has a history of not being as
>>> tested as well as I would like; we had the compilation warning on gcc
>>> and then the linux-next breakage.  The gcc problem wasn't a major
>>> problem (although it was disappointing, especially considering the
>>> context around it), but I consider the linux-next breakage fairly
>>> serious and would like to have some assurance beyond your "it's okay,
>>> trust me" this time around.  If there really is no way to practically
>>> test this patchset across multiple arches prior to throwing it into
>>> linux-next, so be it, but I want to see at least some effort towards
>>> trying to make that happen.
>>>
>>
>> Happy to run whatever patchset there is through my testbed. Just send me
>> a pointer to it.
>>
>> Note that it should be based on mainline; linux-next is typically too broken
>> to provide any useful signals. I can handle a patchset either on top of v6.10
>> or v6.11-rc2 (meaning 6.10 passes through all my tests, and I can apply and
>> revert patches to/from 6.11-rc2 to get it to pass).
> 
> Thanks Guenter, it looks like KP already make up a branch for you to
> pull, but if you have any problems or need something different let us
> know.
> 
>> Question of course is if that really helps: I don't specifically test features
>> such as LSM or BPF.
> 
> In this particular case we are most interested in testing the LSM
> initializing code so I don't believe you need to worry much about
> LSM/BPF configuration, it's a matter of ensuring the different arches
> are able to boot without any panics/warnings/etc.
> 
> There is some Kconfig needed, KP provided a good snippet earlier in
> this thread, the relevant portion is copied below:
> 
> % cat .config | grep -i LOCKDOWN
> CONFIG_SECURITY_LOCKDOWN_LSM=y
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"
> 

Ah, that might be a bit more challenging. I don't explicitly enable
security LSMs, so just building and loading them on various architectures
might be problematic even without the changes discussed here.

I'll enable all security modules referenced above in my test builds.
If we are lucky everything will pass; otherwise I may need a couple
of runs to establish a baseline.

Thanks,
Guenter


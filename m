Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675131D61AA
	for <linux-security-module@vger.kernel.org>; Tue,  5 Aug 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380986; cv=none; b=vACuLYxpwszvQQ1WhCJqzkOl9zkrr4GCTdbq82hGkujtJO/oJ4EEviuWANC+rtVIgq8drjIhzYfMVPq70JqM2cgU0ppYaRuhd50B7dv3pi/uGqViQvy99ndE3MRrzZNEj7uSxfbJtVTSPF5wRVBNGblgvkXrgLQqCDaIpkqGJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380986; c=relaxed/simple;
	bh=oQm/ztvGyOGwifmduBh40jvKEHQI6Sw3B8DUIu9PyT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTjcfJcgzPuriDHnPCaWAnbh2PQnYfEkA3wqbZ1wJoZO8wmasTOtOehKUZ5+CpnkX6u4r8BdwUXfL1CdqFMj4O/ASUOwPvMOxhSuh00EObEvaOG4x5IfCF6YzmI4+DyOeBCKGE+aVG+WKS+ryT5MUOUFNdfrVUgWyEVyAXpjk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C1QsGGua; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C1QsGGua"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4462677f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 05 Aug 2025 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754380983; x=1754985783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I+ANpje7dfs6pZ7qzQnGOwzuarpMyrDg5V24pULqjSc=;
        b=C1QsGGuaE1kPauyh3rEGbMJmlC+dcymNyu73rtoXjAzwM16mSUfC+bwje98fAeBvb6
         vRqIwRskVI1lnY6s1HrtJF2uLmJ/7ZRptLqethwttfrV2VJxHleuYE9DN+4HGuDqeNsy
         kK1cWedA1jvYTm6ggYPrNhVb78yVCx81ygaX04BL7GSYj3KQG2gULBMNoNZ/RD9khliD
         jzyoCgI/ABK5PXZRFxduAZ/FiKq7v4YM7JnE6BU67SC12Wm7a3kfl8Nk8/8z5nVEphM7
         FbhR133nhmX7mIViIhL9nYufH0407PdX2v4AP1Oe7t+EA74+JmdMHTwTWE5UisXaWGko
         GOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754380983; x=1754985783;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+ANpje7dfs6pZ7qzQnGOwzuarpMyrDg5V24pULqjSc=;
        b=QyosIQ5xdMaSNol3dfCW6u+5thJEuWEt6GvmppHgNvrxJuhAD0oMa2YFnvUultXFiQ
         2qrZmLF//1j3qVZxgEx2Cb46LPrTlKUNvpkwEoMJrxNk98x0ya8L/7Z4kuBef68EnkJ9
         tPw5BEVaxWobDU2ovek651jfSEIi00bx0OxNzYTe350bdmZ90PGZhulyFqChAo4W0Typ
         dscyt5aAb+1b7BAaqX2S+aEztzccR/FNPZq9lQpoNO04cHu2QD9p8GycGLr6KBznav1Q
         NLOvBiBaL7SMnOfSbvMVVYmpKOPlOY7PYSIp7MFZW8RlODywjkd3MWwjxnQBCIHHIY9C
         kF7A==
X-Gm-Message-State: AOJu0YzGZcFDb/i61sh+jDBotudjCWpe8BweicKV71O/zx7ID/80wuku
	nWqWdpLIGjkAnGZ66MKXc1GUtk0jfZTBrCoOFaZ1QRA5E5SV/VtB3u03//2aCN7l3Q4=
X-Gm-Gg: ASbGnctaqYnb0ElCr+PpAtFFSzt2pShJY0PoXi+p6WoJDSmOV2WWTIx68WQgGnE8QTe
	53u6reTAVTF07GP7cblXz3pjVITCBwpa85L9I//0Rg73PDUKMx9URJASfZTydUtMBdLcZ97kwd5
	8LE/fr2rjlvRcnZzK+wPqCaqTp2NhVSHLH1wKavOyq911tSdBp5puUdhBlmP1JanvgbXo5f7lYJ
	teJmOg70Rma+vPemq4kgGh/B4BIw8qwXg7s771ZmaT/+c9h8h9bIpFc3BinzyOSRkcWH0OqTWhK
	DtSUsY6x5lxxPli6LJ0GEW+vCULBS/gGFHVlUq0DQZCgJsY3DSA1/Tc4HrK2Gu32bwwC8kKbdgG
	uetUjDmK7lZ82ivnqQmeey/qvt/ndHNyeoikElvCy8AfBp4HVyw==
X-Google-Smtp-Source: AGHT+IHMG6M7h+w11+BYMtMmX8WemVMsPXxcbMHZpgW5luIfhyB84aA+NcxV5dCTd4atZPw7v8raPg==
X-Received: by 2002:a05:6000:4027:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b8d94720e7mr8536259f8f.17.1754380982575;
        Tue, 05 Aug 2025 01:03:02 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b9159e00sm122794765e9.9.2025.08.05.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 01:03:02 -0700 (PDT)
Message-ID: <3be6b1c2-4b54-4107-8bdd-67d5cbcff58c@suse.com>
Date: Tue, 5 Aug 2025 11:03:00 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
To: xiujianfeng <xiujianfeng@huawei.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org,
 dan.j.williams@intel.com
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
 <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
 <42b2cf1b-417e-1594-d525-f4c84f7405b0@huawei.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <42b2cf1b-417e-1594-d525-f4c84f7405b0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/25 09:57, xiujianfeng wrote:
> 
> 
> On 2025/7/29 20:25, Nikolay Borisov wrote:
>>
>>
>> On 29.07.25 г. 15:16 ч., Nicolas Bouchinet wrote:
>>> Hi Nikolay,
>>>
>>> Thanks for you patch.
>>>
>>> Quoting Kees [1], Lockdown is "about creating a bright line between
>>> uid-0 and ring-0".
>>>
>>> Having a bitmap enabled Lockdown would mean that Lockdown reasons could
>>> be activated independently. I fear this would lead to a false sense of
>>> security, locking one reason alone often permits Lockdown restrictions
>>> bypass. i.e enforcing kernel module signature verification but not
>>> blocking accesses to `/dev/{k,}mem` or authorizing gkdb which can be
>>> used to disable the module signature enforcement.
>>>
>>> If one wants to restrict accesses to `/dev/mem`,
>>> `security_locked_down(LOCKDOWN_DEV_MEM)` should be sufficient.
>>>
>>> My understanding of your problem is that this locks too much for your
>>> usecase and you want to restrict reasons of Lockdown independently in
>>> case it has not been enabled in "integrity" mode by default ?
>>>
>>> Can you elaborate more on the usecases for COCO ?
>>
>> Initially this patchset was supposed to allow us selectively disable
>> /dev/iomem access in a CoCo context [0]. As evident from Dan's initial
>> response that point pretty much became moot as the issue was fixed in a
>> different way. However, later [1] he came back and said that actually
>> this patch could be useful in a similar context. So This v2 is
>> essentially following up on that.
> 
> Hi Nikolay,
> 
> I share a similar view with Nicolas, namely that using a bitmap
> implementation would compromise the goal of Lockdown.
> 
> After reading the threads below, I understand you aim is to block user
> access to /dev/mem, but without having Lockdown integrity mode enabled
> to block other reasons, right? How about using BPF LSM? It seems it
> could address your requirements.
> 

Well the use case that my change allows  (barring the original issue) is 
say if someone wants LOCKDOWN_INTEGRITY_MAX + 1 or 2 things from the 
CONFIDENTIALY_MAX level.

>>
>>
>> [0]
>> https://lore.kernel.org/all/67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> [1]
>> https://lore.kernel.org/all/68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> <snip>


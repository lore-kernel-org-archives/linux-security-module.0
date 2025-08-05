Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDF2904
	for <linux-security-module@vger.kernel.org>; Tue,  5 Aug 2025 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380605; cv=none; b=tkr5ilVSkvtsa2kz0deL3MwrHAHbW3+H9jpOXyZ80fdVTXYpd0zZVPhSdfFCfmeV1OfGywyhFiHYqyaYRGRdMBs5NHgQmPV6qm1J3hfuLaIPbLy8rBYnI6Z6gx7G4L38yvG0BMjyXaDQlx5wU7hxaqzl585zUM84/Wguqnns0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380605; c=relaxed/simple;
	bh=GcCDnzzNKJSLASeE6zY2VMTyOPq534TsQG74RyKmfh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDMbalHO6VwPNIr+fR8GJi+dSvJSvWw7kO4Ofev+HDHPQao0r9lbUNZHf0zvzMFn2EPIzMHBwnedPJs9YSY0J8CX0xM9zp9PIntYPVz2Gj4MyucWz3yEUtq4rPDIzLTwyI9aA6BaS5De5bbW9U9nm7UJ0OTv+UMMK1U5eER0f2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DvV3lIgr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DvV3lIgr"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so1070305566b.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 Aug 2025 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754380600; x=1754985400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YF5VjXxXte7gkCHkX5qgWn0i/bXccD8eilhzu51cehs=;
        b=DvV3lIgrcvNfpbNyM1k7MXfjvvlyII/1poUQETKBphkJnYJpPVxEpguWO3G1rrROU2
         Nq+OZ7NDk5u5ZsBz5jL4clxPpYObyUe6SDxMIDNaFwlksW3dK//dq/rI+eWJAaoMN+cL
         DIfJQMVG4wGlaAh02FGDQhh4TkmxUEidtVZiFiTBNi51wSJTYEcR3ghzveHndhIst8yq
         AvNnaJnQk/6mNMTRLYSLY012LKSXykkeJA/irynhucAiNlJlDaYKAzy2akoFAiskpejQ
         McxZVrPMXZzBjOXVZ9jqj7efkBbYcECgOZmzx5OY4/YCSf63y0bqXPmq+87aA/MvNeJr
         1+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754380600; x=1754985400;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF5VjXxXte7gkCHkX5qgWn0i/bXccD8eilhzu51cehs=;
        b=u7saPvalkDZyNGYI0bTok4z/BLSBHhU4DgWp+RttuzPOXleKtZaH9ujRu6JcwPRsfD
         s5Yvn9WqZTeWJ6qo46iiqN0uNVNlZ9P/Fdn3G5wXBnFATC9shX2c9P46KtKPMM6OuDnb
         F7uumoj6WE9AY9hSnWhXLBCe/az6c83dQGDKoB2blxKV85+GvJ0CkA0vOJd8wsLPot1s
         9AqjnrItlRPvUz0HUvrFSoPX7pMN5+Bdq7n80MRvMvEJH8SRyQW4ssdI5ZvftJb0Zg6b
         tdFOIUlXI6Kfdo2TVRKgEljVwx94MBggVvWR9xdy4yfnMUjM07wbOdHe8eW4Aq9RW4hL
         g3fQ==
X-Gm-Message-State: AOJu0YyBN62vjAIoqVtDDOquhKd8O9lI3zeS8sin7ZPeDmZpftiVPHvN
	gIGFQAU/uy6C+w6fwEhJUTBRPCTE0CSZ6YBN6Mpk+XNhLp/2T7l+1mD2C9Nwgym7m8Y=
X-Gm-Gg: ASbGncuABKjt1V95CyCeZGUNt7Tg5nRuaArXKXe6ycqoLFNMvpHLC6To1ZNpdDux2eC
	3rpBrkVRO7gKIm9HabzBL2w0CjQ9eu9Svxa8JF05zYJaHh+j5AQm+ZxuhtDrmLrw3VTybS49CmU
	ZwqzCaE7cx2m9+ojqWJeU+vgGHovOAOlgMHks+fAebnIReSOduNTnFz3OfYpNHe5SB2tK0Fi6AQ
	hCVd5Je7HmH/FT7ei00oYfZJZuLntqsvHotfklsHVz0Y3GTbUy1a6HmEUgczGM9TiVx5ZLG55bm
	AmdKhqi10ApwfbXtQQe3CqUT7EeMvfiC2RCXtvOzl99MHGiv2pS+eKr/cuYgMsvyzuJYxtzQw9B
	TS/ubZr0JOm55XS7epqjBKahRRWLRq46X997+qIVAKIMPwQ6oiQ==
X-Google-Smtp-Source: AGHT+IH/PBsDE7FiuN1y7XN/F2PGYWGv7aZGHyzG7kFb/hAFbZv6nUUweZy7BW5EfSg4ZFuJhFvTRg==
X-Received: by 2002:a17:907:c13:b0:ae0:a483:7b29 with SMTP id a640c23a62f3a-af94020a369mr1243578366b.49.1754380600248;
        Tue, 05 Aug 2025 00:56:40 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e833dsm848779766b.64.2025.08.05.00.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 00:56:39 -0700 (PDT)
Message-ID: <ec7add92-2865-48dd-9f87-078860d8e57b@suse.com>
Date: Tue, 5 Aug 2025 10:56:38 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lockdown: Use snprintf in lockdown_read
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, jmorris@namei.org, dan.j.williams@intel.com
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <20250728111517.134116-4-nik.borisov@suse.com>
 <aIdvhOEiiPMDY4gW@mail.hallyn.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <aIdvhOEiiPMDY4gW@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/25 15:39, Serge E. Hallyn wrote:
> On Mon, Jul 28, 2025 at 02:15:17PM +0300, Nikolay Borisov wrote:
>> Since individual features are now locked down separately ensure that if
>> the printing code is change to list them a buffer overrun won't be
>> introduced.  As per Serge's recommendation switch from using sprintf to
>> using snprintf and return EINVAL in case longer than 80 char string hasi
>> to be printed.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Thanks, 2 comments below
> 
>> ---
>>   security/lockdown/lockdown.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
>> index 412184121279..ed1dde41d7d3 100644
>> --- a/security/lockdown/lockdown.c
>> +++ b/security/lockdown/lockdown.c
>> @@ -112,11 +112,19 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
>>
>>   		if (lockdown_reasons[level]) {
>>   			const char *label = lockdown_reasons[level];
>> +			int ret = 0;
>> +			int write_len = 80-offset;
> 
> 80 should really be a #define (and used to declare the length of temp as
> well).

ack

> 
>> +
>>
>>   			if (test_bit(level, kernel_locked_down))
>> -				offset += sprintf(temp+offset, "[%s] ", label);
>> +				ret = snprintf(temp+offset, write_len, "[%s] ", label);
>>   			else
>> -				offset += sprintf(temp+offset, "%s ", label);
>> +				ret = snprintf(temp+offset, write_len, "%s ", label);
>> +
>> +			if (ret < 0 || ret >= write_len)
>> +				return -ENOMEM;
> 
> is ENOMEM right here, or should it be something like EINVAL or E2BIG?

Indeed, I was wondering the same when writing the code initially. I 
guess either einval/e2big are both well fitted in this case. If I had to 
choose I'd likely go with E2BIG since it's less prevalent than einval 
and if someone changes the implementation and starts getting E2BIG it 
should be easier to spot where it's coming from. That'd be my only 
consideration between the 2.

However, given that this series seems to be unconvincing for the 
maintainer I'll defer those changes until it's decided that it's 
eventually getting merged :)

> 
>> +
>> +			offset += ret;
>>   		}
>>   	}
>>
>> --
>> 2.34.1
>>


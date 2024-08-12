Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B675187343;
	Mon, 12 Aug 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482431; cv=none; b=jzZaBN/k3uaFUHvVSn0vESZS8muG5mnqa4Oq8IxP0N/co9LN6RTZyLqot7q7EPJhZnXY0w3F+31lCKxpVuyy3K0DXN99R5v4VWJu0z+LHzgBKWSufc54Co1ZdAEV53Nwo+ko3EYyx81CdLVanK5F2Wf3oqXB3N5XWHTuMEDqLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482431; c=relaxed/simple;
	bh=6lRO8qSXCjnwyUAfZ6a2KoGyMWIMnvTpUaO7MDFEurs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsKdDwC3u7eMjSf+cZMWdQYLnMgTgHXa2Bj93Lii0foRPGXpKzZhya7ZZFkoKqhL2hxCsvQjT6YiiGJUztOVuoXX+3ic8uJiBS9suJ2rnXhJUB2hKDQ2e9MZQSefPboXOsgAE6/S8nRnvuhS7A8ukLlNJ41C+JAouzXkIXtqYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q245Ildo; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q245Ildo"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b3ffc570bso21301325ab.3;
        Mon, 12 Aug 2024 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482428; x=1724087228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xjxMScf/umzBfKjEzS4Da/J1mKHJM/1WWdAzOpqreok=;
        b=Q245IldoMoj7wThzK7OJc/mBCxKtvFItWkJev4jsTe3s3Di3aKFiD6PEVVqTFBwOFq
         hmW5QDMF2p17G6H6Z4v9+POnYqVAdJd5i98kKkX3XYLELqHX0SL7/cIG8f2mWVNHwOQV
         kbPCBGWyt5NKtq4E1G4qxDlYF0bWTf8LWd3hdD4CxZS7l184gbpmPwxHrkKtHSUCACfH
         IS4jPLv50ls+xdjUwNtqWTn0TFsT9bVJmTJF5FkgrY96glaQUagWJRh+wLrS/qcTWvsO
         h1eQONoYp9G9LdRMEUBY8SNcNBIw2mQYTkpvk62y4syekBlW1PPnSF2bXnGFwCW7p8Tw
         U0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482428; x=1724087228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjxMScf/umzBfKjEzS4Da/J1mKHJM/1WWdAzOpqreok=;
        b=Us0jhZlHMy+W3TJ/rnk2H3G/2nkrvDnw8fjs8iThQBGKJcXua05TE1XuC3wfksHnCn
         1vnJDmJ0hQ8sulJ/AUPEr3EBjgtQwLsuRN+L02SBvKqyiGnOsW1ErRAB8lE+UKqQrt6a
         EaW0isF1a2AvtbhsplQby7Qy8k0S4PCMrNoQwLXnd+VNcU9SyqHs2360pWDLYKaxMtPR
         4l10aTm3ziK9x9wEqqsnByjyiqISmFOvZls7UGyffmU2/ZXPq8Jzp7IjHGAs3GYSI7it
         KQRr3GCDRFwL7OtI4Jy/KjtWmb58i28tpWpbTTxvvAQdi/YVIZKdXf6Py4bT/4pNMbhF
         03yA==
X-Forwarded-Encrypted: i=1; AJvYcCVBMCok/Eg+CT4geU4D0FhNaNXiH9ZpHr7vUEF17YPXe9p6LoKpuMFynJwUnL2zwjm4q0D2Jj2lOeaMFFbAZ5MjmDeFnibe4V7aJfrZt+XHMiGljJv2wY0vWATcZuXR+u1FLYXNl/rXpI65s8Irz2HubBYc
X-Gm-Message-State: AOJu0Yxuvj8cxAUNfP32ENqCd/E7ndGp5SG55U5T2LS7YhZvZppPrH0v
	1iN40YwAniH0UICODfnv6lFma2FdUhjRcykEpYOVrxculed91PDt
X-Google-Smtp-Source: AGHT+IFHtxwQg4KjFaCR69gG/M/hFE3E1BVFokmm5lOicfbs9m/PAJe6vx8PiX04p70ehl7YT4WShA==
X-Received: by 2002:a05:6e02:1d18:b0:375:9dd4:d693 with SMTP id e9e14a558f8ab-39c477b6319mr9903085ab.3.1723482428544;
        Mon, 12 Aug 2024 10:07:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ad960sm4267570b3a.78.2024.08.12.10.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:07:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <90a90f45-cd24-4d98-868e-ac30317badfe@roeck-us.net>
Date: Mon, 12 Aug 2024 10:07:06 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix policy_unpack_test on big endian systems
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendanhiggins@google.com>,
 Kees Cook <keescook@chromium.org>
References: <20240808155931.1290349-1-linux@roeck-us.net>
 <6a0c69d4-f614-4348-a28f-0d4a6fe08df8@canonical.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6a0c69d4-f614-4348-a28f-0d4a6fe08df8@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 09:55, John Johansen wrote:
> On 8/8/24 08:59, Guenter Roeck wrote:
>> policy_unpack_test fails on big endian systems because data byte order
>> is expected to be little endian but is generated in host byte order.
>> This results in test failures such as:
>>
>>   # policy_unpack_test_unpack_array_with_null_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:150
>>      Expected array_size == (u16)16, but
>>          array_size == 4096 (0x1000)
>>          (u16)16 == 16 (0x10)
>>      # policy_unpack_test_unpack_array_with_null_name: pass:0 fail:1 skip:0 total:1
>>      not ok 3 policy_unpack_test_unpack_array_with_null_name
>>      # policy_unpack_test_unpack_array_with_name: EXPECTATION FAILED at security/apparmor/policy_unpack_test.c:164
>>      Expected array_size == (u16)16, but
>>          array_size == 4096 (0x1000)
>>          (u16)16 == 16 (0x10)
>>      # policy_unpack_test_unpack_array_with_name: pass:0 fail:1 skip:0 total:1
>>
>> Add the missing endianness conversions when generating test data.
>>
>> Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
>> Cc: Brendan Higgins <brendanhiggins@google.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Looks good
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I will pull this into my tree
> 

Thanks!

Guenter


Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5E27C158;
	Tue, 22 Apr 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330478; cv=none; b=NSfCP9MoYaReBQmdl8PD3odlS4CYS6o53MWcityCCLwlVUZTyGS0xdezR0ldg+kiQEChpSil2uUY8vmYijHydHnnDxPXIJAttX9+SFrQgc2mjQr6pM7HcL55mY3k2TYRq2qWwE0+ujcJkC1THACY3WGYwQjQwdKYpP0cAOVLBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330478; c=relaxed/simple;
	bh=mnUHJ7LCfaTAF2I8l+Dp10j68EBqtPd67K/CShdnreo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8FUWpzHTMBDDv6wHAfqDGNWbpsarRyhjrkQcMKxGRRDHsfinYt7PBMvFtAU2zfygZr5C9Ks7DmfWSPiga57l6MYBvEnebQ8krF4BhT8j9moud6mmeO23f/HN/Ur8MXngeOI9RH/Vyj5mCFdv3GwQoJPMRkNATK0sl1Q6ORvH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixik0TrY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixik0TrY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso60766745ad.2;
        Tue, 22 Apr 2025 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330476; x=1745935276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xVeVIDLb4nSV/1ca9okGdJgvrdB9ejLBULGxgaJz4Ws=;
        b=Ixik0TrYV5rYBj1I8A1PO8OeqkqcX5bsStI+G3nq+fteakeat9M6vDU8Z0qSl3WhiY
         uDGJ4W2K1E66ntPjnUZddeyDa5zB9Mhu7QbSGFf6/8cI++ogCWe2jCluymdqGB2nxhh4
         /SNG3Dy8DFgb+kayMnO2FpVvh1Su1hbmIaHPD3WEcJdsMSUlPRXkl6na5qQ5QKD9W3VH
         hv1a8EQzxjIXXQ+EfGCsXjJfvL0dD8VItGxNEwZdBnhu7X9noX+kThqs2jjk8LihInXD
         VUP518d4haE9y7YS2xDSMDkkjtDKeHNy6NWIqU+QG1rie0c2OvdEwTiJM6s3RBwBU4XX
         tgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330476; x=1745935276;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVeVIDLb4nSV/1ca9okGdJgvrdB9ejLBULGxgaJz4Ws=;
        b=mWfL4+ChR1QpzAKwxHlMNp3uF7fExvhk2Ne+g8O9GKdiAJfz7AE9hG6MZo3V4Zz35s
         gphLcyaEGcxYaeb9ZPAvIsmJaUfAFxuWzelRzw+H4kIjMtyYUCJsXOab9lo48/gfv/XJ
         BP52v7BpDEV9aNTPCzPX7uLxGc/SLVwcL/UDzT7Iv4jOfC1SI/GT2ULHy7Fk55x9sS2K
         ZYUiTDNvnlgbN6uzDgSStp7XiBo1xRjSu1zpQF/PgY1nF0HO9bTXm9P8ahmDocgJBLwm
         HUYYCy+6SwUd6KLR2Z6LAlNndmAgSREp1RsyVXtsT/Fje5Iu4APjKyOHtBDTvXz15JoR
         8WQA==
X-Forwarded-Encrypted: i=1; AJvYcCUPTE8oSihfsRPGL0IE5r7QGLxIGfnXM12ML/50wVWBjYwGsoVYPBX0BZGsdWSvzk5Jh/wNh3lkkOzOHEka@vger.kernel.org, AJvYcCX+bVMSAFZiSXV5PCT2A6DJAKADSfbIl8FNugsxw3r+Q9Js0UDLiN2yHxYVogP7bngn3/2Ofx7CM0XA1Y8=@vger.kernel.org, AJvYcCXB+YyZZYgsqZsAva55iIkTFJvBFmYP2pzdMg1Ki/U9MGk61e4wTj21GI4jNvnBafL5SeNDVTb3G2EIyu2ZScQ=@vger.kernel.org, AJvYcCXniY6Iqmqx8fNzNLex8xdMsQ1lYR6DCa53XiO4wTSEusI3n0/Xho3IBJftEiu54xujhdOSWyDe2LA4MJUrR9BeyDF6K9g/@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSdinjw6a7jJOgJ4xx1TJ1veL7mukBxKWG19G9F848VW+XEiz
	gQFQ4KeKf2TcsRZorVVFadP4a39I1+KhT6mjR1pxc5MD4cksRqaD
X-Gm-Gg: ASbGncso07T9NQ5Ediu3ig6CNyUBc2zz+8QFlpG2u708ixVDAUS+c+MNEniWxPJCbeH
	c7MI0B9P3AxvId2yArtMfX8CCMYVJbZJu3ra8FlzBCtBHBELERgmTPTwa6wJUeE28cu3wbof9v5
	sGo59wK6UrlFAkJtEXlTC8i0lT9FlmJOtmHqN9KHdvsMAN9h/huWZdEixurf/XaL0NyFnqBpTAg
	ytLiAepv8a9J4R0QDB1OyqpnSbCCa2fr6ty0Q8t7OVJ36oZe0m9scnak5X+fN35IvtjYLGprRbf
	6W+MAegl1uUlIMzjOXSq+YEIxIw677HKc+vmRGO0/FVZceXiCVQUfdv+lRMDZIwsVzDRf5uM94C
	1BzjgZhocXhJ2Sw==
X-Google-Smtp-Source: AGHT+IGDzMgQgqZS95KgBrawfW7xI/N5kBWPEFQvaOuv2aM8Hr6Yk76vG48SVBNto8mC9a706/z2rw==
X-Received: by 2002:a17:902:e742:b0:224:721:ed9 with SMTP id d9443c01a7336-22c53619d9cmr231590965ad.44.1745330475575;
        Tue, 22 Apr 2025 07:01:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaac832sm8885157b3a.135.2025.04.22.07.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 07:01:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6b4645c4-4343-49ca-bfab-ad38443727be@roeck-us.net>
Date: Tue, 22 Apr 2025 07:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hwmon: (pmbus/tps53679) Add support for TPS53685
To: Chiang Brian <chiang.brian@inventec.com>
Cc: gnoack@google.com, gpiccoli@igalia.com, jdelvare@suse.com,
 kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, mic@digikod.net, tony.luck@intel.com
References: <2628dd1f-1b8f-478a-aa89-4c0f78b27962@roeck-us.net>
 <20250422102057.2846899-1-chiang.brian@inventec.corp-partner.google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250422102057.2846899-1-chiang.brian@inventec.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 03:20, Chiang Brian wrote:
> On 3/14/25 10:44, Guenter Roeck wrote:
>> On 3/13/25 20:30, Chiang Brian wrote:
>>> The TPS53685 is a fully AMD SVI3 compliant step down
>>> controller with trans-inductor voltage regulator
>>> (TLVR) topology support, dual channels, built-in
>>> non-volatile memory (NVM), PMBus interface, and
>>> full compatible with TI NexFET smart power
>>> stages.
>>> Add support for it to the tps53679 driver.
>>>
>>> Signed-off-by: Chiang Brian <chiang.brian@inventec.com>
>>> ---
>>> v4 -> V5:
>>>       1. document the compatible of tps53685 into dt-bindings
>>> 	2. add the buffer length as argument for %*ph
>>> 	3. Add Changelog
>>> v3 -> V4:
>>>       1. Add length comparison into the comparison of "id",or it may be true when
>>> 	   the substring of "id" matches device id.
>>> 	2. Restore `return 0;` in `tps53679_identify_chip()`
>>> V2 -> V3:
>>>       1. Remove the length comparsion in the comparison of "id".
>>> V1 -> V2:
>>> 	1. Modify subject and description to meet requirements
>>> 	2. Add "tps53685" into enum chips with numeric order
>>> 	3. Modify the content of marco "TPS53681_DEVICE_ID" from 0x81 to "\x81"
>>> 	   Add marco "TPS53685_DEVICE_ID" with content "TIShP"
>>> 	4. Modify the type of "id" from u16 to char* in `tps53679_identify_chip()`
>>> 	5. Modify the comparison of "id". It will be true if the string "id" matches
>>> 	   device ID and compare with type char*,
>>> 	6. Add the length comparsion into the comparison of "id".
>>> 	7. Modify "len" as return code in `tps53679_identify_chip()`
>>> 	8. Output device error log with %*ph, instead of 0x%x\n"
>>>       9. Use existing tps53679_identify_multiphase() with argument
>>> 	   "TPS53685_DEVICE_ID" in tps53685_identify() rather than creating one
>>> 	   tps53685_identify_multiphase()
>>>
>>> boot-log:
>>
>> This is completely useless noise.
> 
> Sorry for the delay, I've got the approval for posting the boot-log from our
> customer. I was afraid that there's any confidential information in the boot-log

It still does not belong into the commit log. If you absolutely want to,
at least add it after "---".

> of our project. So, I decided to post a boot-log with my laptop then, and I'll
> append a new one once new patch has been finished and uploaded.
> 
> And thanks for the suggestion of adding a buffer length for %*ph.
> The kernel crashes and keeps rebooting without adding that.
> 
> In addition, should I in-reply-to the existing thread or create a new one
> since the dt-bindings should be included in the same thread as well?
> 

You mean for v6 ? Documentation/process/submitting-patches.rst says:

"... However, for a multi-patch series, it is generally
best to avoid using In-Reply-To: to link to older versions of the
series.  This way multiple versions of the patch don't become an
unmanageable forest of references in email clients.  If a link is
helpful, you can use the https://lore.kernel.org/ redirector (e.g., in
the cover email text) to link to an earlier version of the patch series."

Guenter


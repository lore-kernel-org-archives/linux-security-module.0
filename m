Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2243849A
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764401; cv=none; b=BVv0Yjr8MmdNWeQmuv+Xban1abeyfETyi4h3/tXN20xJFtVehXZpqUXD4386g7mR6I8RpEyJsQC37H5qM54Pjuh+xKal74tT1s3WZIEOuWjZqmzHQH2keNs7yNg8AbUh//0ZZVdeo0kwxia4u9N/0QeCylT7FNlDrcUohTpboDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764401; c=relaxed/simple;
	bh=B5VkqrwNwEJ9XEMfV12YRBXI5jkcZ8OzF+Jofeu4atw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saLBILNnIkQo2A1AWK5ivqcTYeDutKVVOZHojz0ohGKzWIF0zL57cDVN8XfhpelkeiJmWxM0HOPcT4/SYT9WTjgIWB+gmObliC362PD9gjxCsh96JJoB/yLg6bhzMi//fDqFxCVoNIkDRJXNImRCMj7V66SdliNbyOpAei0WsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=iaRNKxL+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="iaRNKxL+"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D6EF03F72E
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 23:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784764395;
	bh=ck4mttyd83IgFYzdwIkwwxOPwEMY8SpHSvr7IAR2rdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=iaRNKxL+1P7TntdBwE/FgThBjPjExErYUfsSvPaRp6RxsdB4+xkjp3N4k1jiXnSPD
	 6Cuae4/zOpsTf0/UwQOqTR5xgkxD9TBCj7M0HVxdbVemKLkmL+g+i4kva7+mqtwp5C
	 i0tJZr3llk8jtUCUnSHbBFgwoS6XMFR7oSl9EoRqkj/0HVi00g75SH/vgFG7cT8itx
	 JpKp84PypjjG6h8QYDtliEaSqdwJy56/JqcDLq2b6abPq4M/3jk6qKM4FMZB0PSXSK
	 AS/WdECAPVM4l7QxYAmdGpYRFd7h5UBkrAUoMskhwpTXYfJxSvSOhn3FCb1UJmRDGQ
	 +b5/GEGFsYVDuP+RSj/4x738sFcCwRhRK0PAqJm1YBiubH8Tg2dvv4SnqX9sVE9CAX
	 ZoicpeawioWg2ofPW/X9MnlGCUyckx9aR9ZZf2nqKF+JTdUHlSDknykw/wf2diMaWw
	 klKXuvgdjEF86uNMKd5TBhlLsJguSpZNjnZ2jgd3QCp8eJCyeWI/5QqD/uxmI4C1dA
	 SRMlvXQ+2leTStSR/5jqwoR2HipGj5/19clFbmoch7Ew3uiwzUNDiNZhUMfVFWtrYa
	 d0uTuX0z914KN6sKIVFalPwrjtunl6o67xlnNzXnveWM3Odg8Kj3e00QUea/HOkEFt
	 ickoHR28eR2TloSGuip2/qeY=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so26085a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 16:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784764394; x=1785369194;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ck4mttyd83IgFYzdwIkwwxOPwEMY8SpHSvr7IAR2rdA=;
        b=JqyuV1EaEEPElzs0h4wmmVaLP4GhZAOP48ZpxOjJGwGHtNfJ8aVFhP9kzcoGZxVJXU
         JQ9fk0/qLJhaPBs/FVl/C5/R0aDwq/2t399UT2/wLygUXRPq7OrAnRUQJ19DLxjhQ6ub
         X3ZjaWBZdcHtzir4OLCoRJmo4ko7zWVbFh+F7zGbOTW7x0smxLwLCj+nRD7iYdBsRbKk
         S7LLqvdxDUdrNA1qYCaU0wxjucWpYcB17J9Jn8El+qtg6xEMqdTssACUlhdwnjhxmo5r
         jE2MIoIGysVUPnoM1FpDNakipjOJ45jEr7jnXpNeOaO+JIMMNHsxtQsoTxL26cUQveXg
         C9sQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnS8LIFvXRi/TPPYr9T8u1R23qDgsTzA5iPa9Gq3NZSGFGqt1viJlVIxwrTf6Y74KLuo0fiHUBpaDkjpkK3eV5a2zJ/Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2R5W1PRZ+Zt/O7+Yx/8lrJ9oN0QOr0yK86d3+QmMk4cX1BTG
	koYPGDs7jBSkjHEFirMDDyn0pt+FthTtnlF73Uo4we8Iw8MO5yIrV8/AnmmDnN0LdVB38AI33Oq
	UGH2WWGYCNZBXSDn+Cq/THikBcZKbRnK/X84NTNsx/ebLMcbBxcMtiDhsDw0K7tuna1NdLXBeH4
	x65PT+ECEBUAY0MYOjmYBQTIYqZw==
X-Gm-Gg: AR+sD1144S3eZr6tVU66nqZqgu04ZlVjgis7SDswujWvu5SxoTgIDKC7ir+Tj43wRjH
	AwU9fNSpAv5sNhRLCuqt2TvtNpQQKu/NZo3BYLvrxjcQz55RIAJOGaWcshEctQD3pDTq8h9dG8u
	A0TtOkmSEL/9GQlL/rhXfGeZmYYavEBcB1rJk7ieuEzamFpOENo05pZa3nJy85bWmQP36wHAMQp
	b89tLY1vBIANZJWUMsgbRLBZVOU9QaLj3EwQTe/D57Yy/esyg38aPk+sw0LII00IgaVB5JbKoff
	bN2rbkzb6r3txeJg2DOC1MsgCX2NGihrDpyheoTMqUSfVNBPL/7r+QUY9h8nMRpLgU3REaWlXSR
	eC/TSKoVGoXG2p0Q=
X-Received: by 2002:a17:90b:17cc:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38ec8524517mr364886a91.21.1784764393941;
        Wed, 22 Jul 2026 16:53:13 -0700 (PDT)
X-Received: by 2002:a17:90b:17cc:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38ec8524517mr364868a91.21.1784764393472;
        Wed, 22 Jul 2026 16:53:13 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38ea78a196dsm1688224a91.5.2026.07.22.16.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 16:53:12 -0700 (PDT)
Message-ID: <ba05df8c-fb79-4a14-a9b9-15e50e7dc4bc@canonical.com>
Date: Wed, 22 Jul 2026 16:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: update website link
To: Serge Hallyn <serge@hallyn.com>, Ryan Lee <ryan.lee@canonical.com>
Cc: Baruch Siach <baruch@tkos.co.il>, John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il>
 <CAKCV-6vP2FKgTj5PT3xB_TDL+zLk7xYf2BNw6mKXfPb3OO2TWA@mail.gmail.com>
 <48d44625-7fa2-4e1c-8821-4d22208421ea@hallyn.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <48d44625-7fa2-4e1c-8821-4d22208421ea@hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/26 15:36, Serge Hallyn wrote:
> Jul 22, 2026 11:41:27 Ryan Lee <ryan.lee@canonical.com>:
> 
>> On Tue, Jul 21, 2026 at 4:40 AM Baruch Siach <baruch@tkos.co.il> wrote:
>>>
>>> apparmor.wiki.kernel.org redirects to the current website.
> 
> 
> Sure, but kernel.org seems less likely to go away, and the redirect can
> easily be updated if needed.  Up to John of course, but i would leave it
> as is.
> 

I am unsure of the best course, but atm I am inclined to leave it with
kernel.org, Like you said the redirect can easily be updated.


> 
> 
>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>> ---
>>> security/apparmor/Kconfig | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
>>> index 1e3bd44643da..472aa38254be 100644
>>> --- a/security/apparmor/Kconfig
>>> +++ b/security/apparmor/Kconfig
>>> @@ -11,7 +11,7 @@ config SECURITY_APPARMOR
>>>            This enables the AppArmor security module.
>>>            Required userspace tools (if they are not included in your
>>>            distribution) and further information may be found at
>>> -         http://apparmor.wiki.kernel.org
>>> +         https://wiki.apparmor.net
>>>
>>>            If you are unsure how to answer this question, answer N.
>>>
>>> --
>>> 2.53.0
>>>
>>>
>>
>> Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
> 


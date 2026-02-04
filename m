Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3F37D115
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193371; cv=none; b=S99ovkOZc/QThUALlkAEuIpwrZRbLFu0jL2ejr+I4zu+8h4oTibQpGnuSRV1n0ZG3TZkTUa1nzisz0aiuY94cu+46iC480ybfX1iA7vZxWYYBsCTL13rNbGLMMBTbNkKaMeuwDmkpDXk4HchyZJc2g3PoB0x3B2VmqkXrM6T6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193371; c=relaxed/simple;
	bh=7PLu/ARa+qnD2Izzk+86I4H4QuHIV+/rL1Ij9XL1r6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIfAMttwUILc1KeQjGkYbFVukX2NxMeoW7zXP1oFEdV8lpIJlcsUF34KyJ5/e7hgsYlRhh9IZC2otOHp1vAoqsDMnFcy9lURvF4sVW557kLC37L3eMZz7iqzM2l+75Tbmjngl+sKchbX+jgQK2Frcn6XFAHW/3bXGOu+oOTTG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gosvyoxL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gosvyoxL"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 79DC53F677
	for <linux-security-module@vger.kernel.org>; Wed,  4 Feb 2026 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1770193363;
	bh=fnu5fidMh9uXV7OSySPR42Ndmsbyued3h42jFd0q6Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=gosvyoxLJuBHrmNytQERSUh40GJYj4w7DzX3X3Q5N8xpab1yowg1nenzoDS32EgNa
	 CsHO+XOunyVSg7nXHg98IDVlpeBoTIXwLv8uy0n38hJd1hhLJyhTr+AHViuFWc0UPD
	 iegeAcibd/bUSYxVjs8q+Y6kfcnYacgfVkF0qyX/oX8LPqWgaP1X4uHguAlgOn2ygu
	 2mBLTn3zxn5sNec4RyW2FFLmJ/PM3Rd2d7kAqnPmbuuwMvFaLTHdbXpwRHlg18Pz33
	 pQZy6/59j7+GK2Oz5qNh37WE4/HDFvWbX4K4UH0SUhiRs1wY3yO+RgmKZ8WjFWuekU
	 xdiHeHfFucP+nHGk7t6MxRpVhKBfDERIihC9xu47xUYmZgRbSwmBVOnnnbZluQbqzc
	 CDU0qYd2VHJ4XPxc6tZUujDN9OEOag07GRWdgV2qwfzOILdJyv1e8K1qZMhpbH0TTz
	 nmJR7mQ4odU+e25vuV6WcQO81iKMKiBjiQpcjr2lgJYWIWuxfzW44QIWl/jYvSWuAb
	 UYnMjNCvDvaTLPFft/cUNDmf0ZDSYD4D2lduQPAy3k5JNDvSK3+bIxatJ0Nwnc0uBi
	 O0m4s3ip0tDyKtt3sFrV6+LqfKnUMS7NlnyCo8bUWbo6C+hNTZQh0No1U23zVLIbhz
	 /tNsDPsxOTUujWYWLWsxYONc=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so5859811a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 00:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770193362; x=1770798162;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnu5fidMh9uXV7OSySPR42Ndmsbyued3h42jFd0q6Wc=;
        b=H8plzlGdyIM9mahWF/xdXWyX/Qezk6O+E3ntbnvu9RahXOEtbvD6XtRCW5AsXa4HxE
         Y5CXwz8M7j6ZLR7PMugbu3MOjLFAzDirQjt59nj6mSu2lNq2yGS0XLhbfj36jkD1FjUi
         NplA24xlSx9svUjGCWZMYIobxC/XbrUAC41ybAvI84qAx2sGMIUJuxXgckA/2rmrOhdo
         3b8cZgAAoeLjAfjFNOmxpoSmCVs5UK/CQgoxvav/YYh3epGNIr//TLF3+/jrfrG/V9Ib
         Pjblq3ZcfH69zszGoYId4H2hhl2NndqX8ayrpdTxxMbxTM8oa1DyrAYZmrn+WpnQVjF2
         zRPw==
X-Forwarded-Encrypted: i=1; AJvYcCVKHcQ7bMCAUyP59TKK2hwZSg0ymDrxCR5NasteBSdquNrsi8CZkMQZLK9a4LdO2F+4MTtZpzjR7fv6uzO4tTHdBZKIzrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7gPeMIog8rE6HbOIwaTIYS1JDJE2Mnu+d+v1DbyXMZEPJYle
	9+pZl/8ebMXbwMkJRk250xVKKfPpng63fA78v4cF9lkvpl50P7HoyNnFmxfGRz9iMhVq54OVASD
	UtzGivfPlw5MidvL1RtvP2oEoIwCXdjnMEgA5HxO/pJ85VbGBHOiZH9sVcU7rG7M168Xva5Aqqc
	L65dMxXHEYSdF8IwWA7Q==
X-Gm-Gg: AZuq6aL1YK0Xwypi5BlLhy+I1XyXcfFAXw+/n+WvpOhGHn25GC9URCOaq8tAPPUNE1T
	hC7ZRyq1FBhwLiuUUjtOcmgKM4LPRhqRNf3dd5e26U4awcS8Mj3s8ODfIZaflH0ighsHa5KbI+v
	M28qdvD7dMwJxUvbbQ2OEFJ8/z/Gsdcz+ax9HgHNPX02YSYe4vNR3GnMJAoXC8Gj8AO7QkE41W4
	4KVZGKqlMF77TGtFcqta8ord4/SbpwHPiNhEv+Vxro0UYGggqmddbkd6qVsvkbGC+Lt7ULurLbq
	3xDUFnF6IlkiFMDcO7ro1OjdC1J0drBwcccaEw9fpkDzRMVdG6zHu16MnzeaEMDMINS8ULpwHdf
	I30H5hP2nGUPb8kbekz73V2dH
X-Received: by 2002:a17:90b:1a89:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-35487190e1emr1958922a91.19.1770193362047;
        Wed, 04 Feb 2026 00:22:42 -0800 (PST)
X-Received: by 2002:a17:90b:1a89:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-35487190e1emr1958902a91.19.1770193361689;
        Wed, 04 Feb 2026 00:22:41 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-354862effa6sm1676639a91.9.2026.02.04.00.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 00:22:40 -0800 (PST)
Message-ID: <68a53bd2-aaa1-4071-9ec7-87b11b935adb@canonical.com>
Date: Wed, 4 Feb 2026 00:22:39 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace deprecated strcpy with memcpy in
 gen_symlink_name
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251126165701.97158-2-thorsten.blum@linux.dev>
 <1da23c89-dc2c-41cb-8260-098deb8ae917@canonical.com>
 <D73FFEAA-F246-4777-8CA8-32807F378423@linux.dev>
 <3CA1F386-2217-405B-AB6E-85195AD09CA8@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <3CA1F386-2217-405B-AB6E-85195AD09CA8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/26 04:42, Thorsten Blum wrote:
> Hi John,
> 
> On 27. Nov 2025, at 11:18, Thorsten Blum wrote:
>> On 27. Nov 2025, at 02:32, John Johansen wrote:
>>> hey Thorsten,
>>>
>>> sorry I have actually pulled these in, and tested them. I didn't send out
>>> the acks yet because I have another patch that I was waiting on a proper
>>> signed-off-by: on.
>>>
>>> I am going to have to pull that one so I can push. I'll add acks now but
>>> the push isn't going to happen for a few hours.
>>>
>>> Acked-by: John Johansen <john.johansen@canonical.com>
>>
>> Ah sorry for resending then, didn't know you looked at them already.
> 
> Did you ever push the commits? I can't find them anywhere.
> 
sorry I am having "fun" email issue atm

it should be in apparmor-next. I have been staging that through gitlab

https://gitlab.com/apparmor/apparmor-kernel
and
https://gitlab.com/jjohansen/apparmor-kernel

trying to get better CI integration with the userspace side. It was stuck
again and I had to manually kick it last week.


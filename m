Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEF283FEB
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761222; cv=none; b=cLoLzbjP3pmK0RZjE5NFpSVC11IvyEetjlqvEbpIi038+siRAJx3Ev/z426XRNG6Q8aOu5AM6QK1H8MeFbOd1Z9VmzcWvkipsv6SEPnqFff1hvJSRl0qCq7oXpxvkRGt+8Vn3ja+LQXEM+neLbpC2wmOgpUUNajFDxGNQSp9LUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761222; c=relaxed/simple;
	bh=hfvkqTAOApD9wjX8xERqq7B9PhJVuhrMgW8OzvJfo8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfYuyPQPOUxp2hs9I0yuvDz8LBsTBlmt6PleuIEYQ/p5nRLVyaZJYza4uE94pdwfeTZSLIqdFOHurv0K4tKwoqmY0niiDWbWJlmXuptXXNVMq1rsT/19eQuGLgv+s0WfrqR9VWaG85y+By7beMm9jSkjSiz/1LrkfaDDn8o6xJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WVZURp/N; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WVZURp/N"
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9ED193F32E
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 07:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755761217;
	bh=ue+OkzzV4KiLpEQiFbe32AtZ1fJoFqD1qTwNljdERLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=WVZURp/Nlw7Uifs1017xsT22qYbrv8FO5kivpB7v78zgF1Kl787CUEsolW/5nSPXz
	 GqnD/SKAJrOKD9BHxdPzjIoMz7liS6/sS0lsyeM2aC8RAUqBpAq6nkPoMxv1Bsyu/o
	 gNL1FG2b2FIFyh6MP25y+gSaMXdqOaeFUOpw6jEMrL3bALrkgq9nAn+pD1gYGI41On
	 uaVjl9gw6RUzA5S4mieYMw3ISsLth6WNroPl/IDSvk11e2F55tIg+DZh8yH5cRxRv9
	 jkGchMTUOjMPP8vckOO6uzl5YX5dlIWeHhZYOiN7J8gX+T2SqTdMhXCXwUg01ua3d9
	 QXMKTwdQ9mppg==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471757d82fso585482a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 00:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761216; x=1756366016;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue+OkzzV4KiLpEQiFbe32AtZ1fJoFqD1qTwNljdERLI=;
        b=MGM67pZ8Eyah/P1fBsYHpZCQMlqbXiGv8wgJOE9Knf1EpzUlMqYxpfsYL6JAg0lRfi
         9lYXaevjT2s43iMsUOkbUzie/xZs27IMAROVv5UaeZpc3z+PRwHVnYaMqs3GFaOE06/M
         9JYuxppfXkSUte3sOB3ikmQ+YG+iA6YQhJuan7um0nxesQ3hwQkiN7qRO9WVSUAD/OZp
         G3H61mPt62vu52i05i15pqvMC+VYwnYtu4pgo7B42CwNS20nr3NevvUjKfe2fv8d77YH
         3kq9lHMHdTWn7JN5qCBzVc3yllN00vaSTcUVO8LnIRPXPcgU5g6EwC/miGueC5K8skhn
         6r5g==
X-Forwarded-Encrypted: i=1; AJvYcCVVorKgN/G725eRmTxydZa0ygtghD1isTLQDSiVlGdNX5lsVsbMkjTQpHesFYSz+0JIzaL8F9NGhc7ZQMCUOR4fM9FCz0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+xaemCiYMsugTpPUqrwrhEW+ooKoV2zb27gsVgGy+m9+SUTC
	Q5JTlgn3ERTQDb8tQIM7CmUcudmwOeFKPYqyZ1hGudEr0CkFb5B7ACqpOFwoH1mC0oCrNw+kgR0
	VGxKo6xsEtk7ebJLzsNh9PSy7MdpbF8plPfhDuJiczp8x5l112F1Hf3pxPJGNuJudW+AEdhOP//
	IJzn7vjOuntrUHuKfC2w==
X-Gm-Gg: ASbGncta+ta4fhPD1W4xiY/0J1IQ23qm5Z5lX1kYXgwAoy6g0Ig++qCggsRGmP/NySu
	ISSOAbyy57HmoGOPisq/LlyrTL1y3v2ORGiLQfR+pUZszpkxqnaYMymS90cESd+7LGKqF51qfo1
	anS0QQc6WWvF/y6ym+zcF90juRQoiTkd4p2IrN0v4QeO4QDNq7OPt/jmkgwHSTBAKD1h2Iig9uC
	clhO49KQyDC4zluOzYeeySpa+0ZiaP1v8GmZ3rf84rrEpUMclbPMw6tKx+QDt6sAPWukgVXrNvR
	yyN7NVgzYblAPZlyqm6UttiCWg201YMVTA+QinS69hYMvcDghw0FrQ==
X-Received: by 2002:a05:6a20:5491:b0:243:78a:82a6 with SMTP id adf61e73a8af0-24330b3d501mr1985587637.60.1755761216177;
        Thu, 21 Aug 2025 00:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjCWtMRF+Hu+oQrp6a212vrecViVy2agy7+gPfMCUx2OtWLBxQ994MtDvOa5rf9EuEWC0mLA==
X-Received: by 2002:a05:6a20:5491:b0:243:78a:82a6 with SMTP id adf61e73a8af0-24330b3d501mr1985543637.60.1755761215241;
        Thu, 21 Aug 2025 00:26:55 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76e7d0d98dfsm7375246b3a.17.2025.08.21.00.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:26:54 -0700 (PDT)
Message-ID: <bd0733d3-02d1-4543-9430-af685b644f24@canonical.com>
Date: Thu, 21 Aug 2025 00:26:53 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <CAEjxPJ7NpSdfUZzzj0SnN8WuUv7E9SEj5v28x_y8R178_JMESA@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAEjxPJ7NpSdfUZzzj0SnN8WuUv7E9SEj5v28x_y8R178_JMESA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 11:58, Stephen Smalley wrote:
> On Tue, Aug 19, 2025 at 2:41 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>> The advantage of a clone flag is that the operation is atomic with
>>> the other namespace flag based behaviors. Having a two step process
>>>
>>>          clone(); lsm_set_self_attr(); - or -
>>>          lsm_set_self_attr(); clone();
>>>
>>> is going to lead to cases where neither order really works correctly.
>>
>> I was envisioning something that works similarly to LSM_ATTR_EXEC
>> where the unshare isn't immediate, but rather happens at a future
>> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
>> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
> 
> I've only implemented support for an immediate unsharing of the
> SELinux namespace, not any kind of deferred unsharing until the next
> exec or clone.
> Not saying that would be impossible, but since I was following the
> example of clone(2) and unshare(2) I didn't do it.
> May be some complications in doing so, but I haven't looked at it yet.

if the hooks are setup correctly I expect it will actually remove some
potential complications. But I haven't deep dived the selinux code
yet so call that an uninformed hunch.


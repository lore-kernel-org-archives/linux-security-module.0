Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494E2EA16A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815226; cv=none; b=VA2fIhifyWB2XVclsnhCs58rwkI/nc8ho8vzSJk0UEesLVxhtfkp5zhIhiilqhaDqV8l1D6IldXHYJmovaAJOA0xXQ5CA1EFhiFkO8SzrDO3UVJYT3Bik2K0R7+O0iWzHDej1pyvxtQj1Jd0ZoKtExM7NIBIif7Ho0f2yRBuedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815226; c=relaxed/simple;
	bh=03Tj6VeICuYYYDrO3KoaCDsMMoyb+UePS+/vbyaESCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+zyIGdIgxprG+3kljbqkuxaB2Fk0XRaUy8JbkQDGuL4rbMNDlMR65qku4k1U3H0ZH+SpuHXdde+Q45AcyHFex4gTnRrfXSCLDATbU2MawNe/i2XQCA08DaX4pdAytvfzY40DaYBDUvO3iKvrqJQi76bzv3NyrFzS0eTecqEo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jA6d0fyr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jA6d0fyr"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 632C03F60A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 06:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773815222;
	bh=e9u2utDffeAat3Jdcbazk5JkvgzpuBoSq9gVDsGwVAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jA6d0fyr9B54X0LbMaWCzVyqztgnXAhaX7dt/MMOw9iDI+jx4EE3YVkAZ7yNHle+4
	 nu8sb4gGUPYX8Nnqma0EwKm93Oh4Ht1kSDpYPEZV1Okf275hFMR4R870phBy8KnGAs
	 t3fsQeZJGDJ0KoVSNfu7LT1jvc6XhmGk14q2OzXQPy2O6Gn5UReLoWfr4BAiKTMI8L
	 8Q89IDd2599K8+re3fGbge7UjyhPgyx0IovUY8jh0iaXdSe+OEgwKMtZPUdOeA/AAJ
	 JVZqETSe6s7EzdCTLh+DVTLaqitt/Fgx41hfZM1L2B7fT0P8A5omxbeaNUOfhM6iee
	 JKcdwMrZS5xk1kljUYU3kTlxPHyAjXS0rooPfKmSWXAkznoYq4oQ8vAyCx5st6PkZG
	 3u+gnr6XgLgdqB85U6i9nBZCPXuQlsfXwtEosODAOtFyg/SpN6ACwuHvir/IIWv+Cg
	 lRHYXHiMaphQDNuLwLGS613sh1l1Y9caafS55uDnnJpSeRouULg2bXTXJpMeD9juSF
	 trciw5Ltg8Sz0NiM3GBqu7WGhvECXOLrqfNypBSgfaMZbevb6AK25ZSI/XwSG5CbjH
	 v60JhFztHpuF2YYR69apKATSG+bBIY9uC/fIojJp5ZR5A9I9cGZGa6VtfQS/54kN/G
	 EbVIDyNxDFw8CBVwoapOW9Os=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aebfa0af7dso400745735ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 23:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815221; x=1774420021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9u2utDffeAat3Jdcbazk5JkvgzpuBoSq9gVDsGwVAg=;
        b=I/sEJRbLOC8OOJOrdXdU+J3aZMlF1TBTBn6XrNGEp9Op7bZ1MEU9r6IVSOX64Mf6QX
         nu6EJ7E8hspawMNrohMp3aoEs34AE2cmZRKiABoc+aI46N/lpoDflMwvqz1an2vewmH9
         MxlbfoUxHqerBBVe4GuLSgYcqbhyyjQ+8R+TNavBkV7/svLRn/cktjLk0RfBb5Bu4h0j
         AaxqmbjHX+B2jLQX+r3x48mMQqJTx1im215A83G8bw5Sy7D+CTRsXzDwTsnf4qyip07n
         xk2XwpVTyotUQ4LSlSbEo8o05uDpa1/GyrmuDYY6ECb4r1Ps0499okCIko7cnx3XwaNJ
         YW2A==
X-Forwarded-Encrypted: i=1; AJvYcCWBlgdNa+FDc75wFiRZSqJEBevBsHyGQvSg4Pcotb3PDwKOnu8RKgU6m3dL98W/Pq6xtncpFRXmfLDbgu5wJ7nWGbi+YiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6ko8qHr0WoC2IrhQsmV/0zHkiHUsxn2aq1NwX7izzcm6QCfe
	kLa1SNV9x6JNuovzUVi3DnhYePsz/eXPG/4GqMcq7cWUsIdQCqW0NxFr5ly4znTQ9SnNt6lqetw
	aTKsqoO5OwCS8knK7JB5GOi7X5uu2UxHmZht/U5nI0zkE1ahX5nhIwGAF7qCr4Tc7k5Nfzg0XDl
	aamD0LvfOgqzxLCSdsng==
X-Gm-Gg: ATEYQzwa9pHg38FBGXf9pzNIEnbBpDnZbbm6J4MN8sLfxGWR3HLNbbMpAKq181X7IRr
	WpYYM0R80E2nGNStx7hWHX3QSdjbhB0KfSNtY5uBuf/9DVvwhIVlO/PatbD9E93KOMM5KNlv/QK
	ZLg4a5cC6T3et4/grI577Qompi7EXMHVzaHitDnBWll3Bre2wZNmUOnJaT55QDeilBeENerIWqf
	tSPn/4fEs9K+0u1ahvXDmkiAbieSKsHqVvweAjNSZNhI3ESi5LDc3wgwACbVKjDpF8mvPj9REpu
	K4BWbWfk9WtaD1ZJdl57JcrauIUbDQJzBwz5VoTl5wlpIYPEMlG04KLgP11HouHCpGMq0VG/jrB
	XDgILeO42FMB96boTz0LqEuajYO7tM35zNV80kw==
X-Received: by 2002:a17:902:d588:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2b06e3bcfb2mr26165545ad.30.1773815221044;
        Tue, 17 Mar 2026 23:27:01 -0700 (PDT)
X-Received: by 2002:a17:902:d588:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2b06e3bcfb2mr26165285ad.30.1773815220700;
        Tue, 17 Mar 2026 23:27:00 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b06e605108sm18492275ad.60.2026.03.17.23.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 23:27:00 -0700 (PDT)
Message-ID: <9aff5d87-e513-47cc-bafd-993e37d97458@canonical.com>
Date: Tue, 17 Mar 2026 23:26:59 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] apparmor: Replace memcpy + NUL termination with
 kmemdup_nul in do_setattr
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260222204645.285727-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260222204645.285727-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/26 12:46, Thorsten Blum wrote:
> Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
> a manual NUL termination.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

sorry this got dropped. It has been now pulled into my tree

> ---
>   security/apparmor/lsm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..49aa6ad68838 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -858,12 +858,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
>   
>   	/* AppArmor requires that the buffer must be null terminated atm */
>   	if (args[size - 1] != '\0') {
> -		/* null terminate */
> -		largs = args = kmalloc(size + 1, GFP_KERNEL);
> +		largs = args = kmemdup_nul(value, size, GFP_KERNEL);
>   		if (!args)
>   			return -ENOMEM;
> -		memcpy(args, value, size);
> -		args[size] = '\0';
>   	}
>   
>   	error = -EINVAL;


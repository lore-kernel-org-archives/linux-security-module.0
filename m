Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885B416879
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830353; cv=none; b=qVsZ0+2N38IzqUojCEyB9c8YbQVv5mkP4jGjIA7XHGlFT+OWXHGaXwPPAz9h7bWKyE4wnQtqyU26rxJ7TmlKA5f4GJHL2QETsMC6zy6mQEiJp+zk4PetHF4BsIGFvZRmk3K8fcIiXsxWrZ+Ry7DFzViUt4Kk7Tl+aX53vAIDBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830353; c=relaxed/simple;
	bh=iTIoVqRjQtP00iOn7hdGRhYxnkeGu+U6z0QYxQ5mKj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFhPYGNZtU7XEPJEyea270+pHtILiANFAJXLS3x5IKrSwPTEpzhJ0Mkto3nlQVb/YJvVf3l+unbY8yZQHw1b40GGL2dHpe75MiMq1Tb3KNGC1x2caEKmAcv9lgQA5mUGnj1bc+uke1Imp2mfqzDeg2yxf6qO8K1QnZDlb22xhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z8EqiWe5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z8EqiWe5"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD7403F20C
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784830344;
	bh=kDx1QJrqFdNp3Xj2Xqp0lk0qPO06jKBaOFtAlqFO2ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Z8EqiWe5hP8cMYX9hDvts/Qj4mtjHxkcvZrmob3WRqlXUaP/pkbzM4bD4mVTGkt0/
	 1J3jexpUkVMoEtBzYLz0faNa+kb208C9xHyEOZTMGsdjz2ypY8rmut5TzHg8E8mHXT
	 fV7aynQDIEOGf9fLfJJH3a8VfQ6+wk3krxalBPFbAxBCgQ7vZ2JiALsEua4slivC56
	 NNSXNginyPdEB8CB81OxqfFfnJ3V3JRBP8Uiy03HexhF81UjFBxq3YGh83+WqnJ5cq
	 5G/wkKi83fdA67vFZJscAhI1ZtVb/q+AcqJVkGN1FjnwolC91fVw34Qfbd5YR1DP6h
	 LKXZWQYJG7a5o7P+rsfcXr+3JsyAp2ekhI7ZLsGC/XlJegEMxaiaXUeHQXBMJyE4Fs
	 9ocLG+hTFRWSpYSFwMXjti+aQCYKkqwnqZ7OonjEBYRmZx1hgk1JMMP7x3k/LkMuvj
	 qOjliqr4RsVppH/wnVIrld+z/3+kHxADmdZz/Rqn+1dairPeL6LF453rjRM+SUAmL/
	 gthBWc3qjpdQmmwd79O0eytOUxMJu+fjkhXpYh7iCWMyp/k6YL2xHGwPbBri5MlTw5
	 nJelxTfu3pu5pDV7nAs0fxRBVxbvYH1az41Va9T+E4J2MmN6Dm3bbjsj0aJfGP/oL5
	 fXcrbGojk9Q+7W4vWioQNMm8=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so2761715ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 11:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784830343; x=1785435143;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kDx1QJrqFdNp3Xj2Xqp0lk0qPO06jKBaOFtAlqFO2ns=;
        b=A1NJ9yoLxONm3aP6Owr0p5UbJiuwx2jdjV3zW6CVbgeEpIhlllUtORy6gdXMA7H/EI
         v1UEocNfePZuIorMCQUbXG1CDGmnkmz+yyBUqw0U6cOBx1CfWNuVfdW2zPpWyZ3H6wwS
         OpeXCuE9B1FlpQGEMjfxFrwVgl8zrf17wZJPce8vabx7rNrf7rZVjWDeyLQDGxPlQxND
         SGwj03K3xRSUzMKbPpKLjS8wDjzDGsthX/HGlDjKSKY6FqsWXTUv7CVgj6C2tdbN2p39
         ZhRGR+VoNwD0V1e/sQiEOTQqWLH9gf3XXumlJ8fttVF0b27Py1Ex3PsdiCu+qhSC6q+7
         qafg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2Y38JrChMDe8NnjOjtdMfTdVLqmMuwFFiAS+D+pcrkPjgBTGtoQwBU9UmJ1ieyineNgETFx2Qh9IJoL9gVBYsrYEhE0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzB0j5hoaR1d6sr36Uxx1HCNlTYbAgHIR8/VZOvuG6OjgkhQAM
	6hYyyHpYz4r++LbpN5TbWLPrjZCtOZei3WzFkOs3uCT3nYdpbfN/K/uTe9CkRbNMWVWQjmLOg9c
	rIjjobdUIEsRSHWYBS972jMF+Fe2exgMaNxbcNeKE4Mn/4uncyoHevDHGG+obPjgnUHSmi9J2kr
	L5U4+lDfz6VOhMNjzkYrLAyZrCPg==
X-Gm-Gg: AR+sD132WUkQ4BjMQbIoVdfUEguC/3BF63zSd8HHNSgTYarRQNsyWMPmc1bdjCURsrr
	L2aYnMu+y0I76iUq+8Zz5HWA8Xd4kvoZyt8A6CckDKvjttTc2SKDuvah742kK6NtnNsC1ayhOXT
	jktUIZZ3Nt+GBYgy/K3M0UzBB4k/lG7sFWk+DTAkYaAp77/gzeHnchsW2eeDE1B5Fs8Ae4DUITq
	fPHzByScEiu9RdAo0d2MRS/ezwLChvC8DhS1/LpGaH4rcgCQ4SDyzuOWDvndQqVch7gIVQtdAoO
	uugv42IiuXzRIW4zE5yQnkT76XRKevMa7ZrIxgCfzkqe1aQea/FrAyrB8MNJXvnvZQO63ZcjtP8
	vMiEpVD+GeTTov/U=
X-Received: by 2002:a17:902:e54b:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2cfa71d96e8mr50630625ad.18.1784830343393;
        Thu, 23 Jul 2026 11:12:23 -0700 (PDT)
X-Received: by 2002:a17:902:e54b:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2cfa71d96e8mr50630425ad.18.1784830343054;
        Thu, 23 Jul 2026 11:12:23 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cf8f2eb72csm38138435ad.46.2026.07.23.11.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 11:12:22 -0700 (PDT)
Message-ID: <0c808f81-8fd7-45df-ac49-4b860d6ae8f8@canonical.com>
Date: Thu, 23 Jul 2026 11:12:21 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: switch website link to https
To: Baruch Siach <baruch@tkos.co.il>, John Johansen <john@apparmor.net>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <5bdb0bfc41a89f58bcf9aa3e0fe062090a1fb2bd.1784827554.git.baruch@tkos.co.il>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <5bdb0bfc41a89f58bcf9aa3e0fe062090a1fb2bd.1784827554.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/26 10:25, Baruch Siach wrote:
> Should make harder for MITM to redirect to somewhere else.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into the apparmor tree

> ---
> This could be considered v2 of the patch linked below, following
> feedback.
> 
>    https://lore.kernel.org/all/2ce1d4ec18b2b47ee7ddd9c1ad7be68e185aa69c.1784632742.git.baruch@tkos.co.il/
> ---
>   security/apparmor/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index 1e3bd44643da..e1bfd164a23a 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -11,7 +11,7 @@ config SECURITY_APPARMOR
>   	  This enables the AppArmor security module.
>   	  Required userspace tools (if they are not included in your
>   	  distribution) and further information may be found at
> -	  http://apparmor.wiki.kernel.org
> +	  https://apparmor.wiki.kernel.org
>   
>   	  If you are unsure how to answer this question, answer N.
>   


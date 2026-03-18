Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6322C324D
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813440; cv=none; b=Euuf5eXelWwULhR1y6Rc4xMskACmTEhEyYCJGNShjORphL3Ax0eehFEBXJwk23RWRJXB8/ykolL+f60NEHwSiDNCCJTNySbF3864vTQRQO/4eU8POuJ5Y/Ot1r+A1dXZHOa/P0bt3XrG+H/C4USvfjIqemDCS9uagpGvdar3OmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813440; c=relaxed/simple;
	bh=3RiMoL75aYcT5LR75RjLFjov2e6r10w9d+eFggAeSXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWYT7R1I4uNxVuuTgVEB7FCKA/t85LblwSAI9wjuMhypb0XbKU684SjHtGsxb77KP/reJHO2LPIp0iM3//DrOIFQyyzHzZu3iYGbNtrXuqdWF3S0/GwIiUv4KPvOaXJ2yjRnBco8OmPbyt0wssCa0dhKeAHSVxatuhmx9uI0GJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=InLqAJid; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="InLqAJid"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E3C613F604
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 05:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773813435;
	bh=tdKTohU/dGRHmKb33jK2uAr6+LR94j48qnN+5dNPdVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=InLqAJidUpinH3+gtURQfIkT/MGEzy4FOGps4WGlUQEp5m9Ht2hi1MlYE/Mu8BGpj
	 MsjRB7i3AzxvN/+WV3HbTh4wzYSurXlQHJHyyHsTiQJC144s/6OnrGIyLB9aAojx8c
	 0uxUxlrSRvDwnYMd3Y2wP3Er9XIxs/9Y/nW23xkwItFfqJvH1cw8I6pnpmne0OVFcy
	 KKQ39pbkqOhwW1LeXlpz1E7IWdBfSoS37jiBf9svU7NLQ/7dgGMJV32+kvA++dGO0e
	 nz78SNOBwe3RN9Meyg3BxHNKW3OZcsfPKaMv8faTK0HYs6PNGsYYxS2xAYUbuwbkbp
	 B4sK8raZoLnChsJWhbjFUM+EZOCBeNA5OGH/BYOp2XLc7jyscsBPHKv/JmWeQc8iA9
	 0bfBhL7pJM8qJkc5gTZOULGE8gUS1LbnLt1bwOwtDDSvaIAvEdycbdSxiNL264lgdU
	 jw9MnPLBuWqafaBR59aD3YGRE7V7wZ87Re0xw5ILoDdJ6v6u+ZazigwZnGbhTsiFu5
	 N6FOk8BZ+ItPxH2Iev1r1UO/ayerhNUbVaBO3y7sqwqoMAgRn+nL8JHUeZM+Nqlcdo
	 7PMIp3IuFJYqVx78qyYuP+ABcZEMhiuuglbmr6KAEleyFuZ9dZG1c5iwxRjO7OX2Ea
	 rbA/APsQYnFLZfouMsagKlE8=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso94429735ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 22:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813434; x=1774418234;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdKTohU/dGRHmKb33jK2uAr6+LR94j48qnN+5dNPdVU=;
        b=QwPePsPEV16hRd9LaUlRAHtlV9M2GPHDZNe+iHgM+NttKCJaBxVhF5L+t1uAC5oBk1
         ea6sfy7Kd4PfFJuSI8S5hma23b6gKXTxFeu2gcn2VjA3ZBnO7vdUARIjCN0D4X+830la
         lOmWwMqx06bY3eKd5oFtbGZGimHR2cJTP9rhww9Hmwai9VQ0J96wFZ3EiVyYz7F+nkxV
         UITx2cww2VZ/DvHelMU4RAUptmglTbZsaiDr/NszqjfVL9uYUf7a8GgFQSnYKGDEPfh5
         dnvsHNy66MVFJTr9TEocXxpedr6GO3ouGHkWTCBPx+65KgdQiZKSY1G3GZ/k7ZT8Ud8v
         bt4g==
X-Forwarded-Encrypted: i=1; AJvYcCVHcKGoUwkq1cu0lbzdTQSeQ7vTS/7pc+HHBTh56ZwXlQwucfldNi+mqZwMZPqafd5AFCoEYyfHW+LwNEYpBgaDaUfJjNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkeoVl1nR0XyAxfwjQtnsqyK/1ys/5KWZky9vngLoUw4F1dPO
	RRjNlyrHyG/4UdRcWZylVdygLRh0dbXv7mmJR8s3CBuxAlt4aTSFucGsJymNRzvBGbUyFHHG4wr
	zO8Mve1leu7SVpNMB3uS86Fg7rxRZz7toI12L2j3GwYD6DAsm6V4w9t5lG0c0du3uoflRaCcUjL
	jyb6/UvYBv3kLLakw1+Q==
X-Gm-Gg: ATEYQzx99V3oS5nZLqSOvrg+FJq7aZz74cqkU2NeTReAJMDKwyo2PTmAt0x2n8ooFQt
	QX2KCwMSBgfkqYE8BGq55bfkb8tue+iiztpytVmvTrIgMDkfjlGv9jC2X+npbhTbOjDx6HKS7Sl
	SH7jD27DEEiJqdAQoZrjFFPP6cwTECwwYBVVVY7r6e0rR25xObEnSQMAGEqB3m7phO5ctSxoxTB
	XWi4u2etbtPfcLxaf7bjpKcM4IjHwu/EFwvhzznHGCwd901eCNUUIrp5OJRkyjNMCLEBt4uhsht
	QT6OaxALKefd8XUdubafukhHnwlk1g9cw1/cF3/HhqbdqgdsxvQ/oRb/8LAlPzRTc2GW4AhDk0u
	kXoTNIGlO7pEuUq8Ct7OLZEEFlJIBLx3e6C91KA==
X-Received: by 2002:a17:90b:2f83:b0:35b:952c:43bd with SMTP id 98e67ed59e1d1-35bb9e45676mr1660154a91.2.1773813434576;
        Tue, 17 Mar 2026 22:57:14 -0700 (PDT)
X-Received: by 2002:a17:90b:2f83:b0:35b:952c:43bd with SMTP id 98e67ed59e1d1-35bb9e45676mr1660144a91.2.1773813434252;
        Tue, 17 Mar 2026 22:57:14 -0700 (PDT)
Received: from [192.168.192.71] ([50.39.102.197])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-35bba4f2321sm1421876a91.2.2026.03.17.22.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 22:57:13 -0700 (PDT)
Message-ID: <3a2bbedc-1469-466e-b0fa-efd1f4df02db@canonical.com>
Date: Tue, 17 Mar 2026 22:57:12 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Replace memcpy + NUL termination with
 kmemdup_nul in do_setattr
To: Thorsten Blum <thorsten.blum@linux.dev>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260125210014.154432-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260125210014.154432-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/26 13:00, Thorsten Blum wrote:
> Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
> a manual NUL termination.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/lsm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index a87cd60ed206..98b92af5890e 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -866,12 +866,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
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


Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5933EAF8
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277281; cv=none; b=ovwTwS3NuY2Hybanh+mgIwTknI0V9KykZvDr7fFEF2AVbdN/o4le04lFEyKulEiAVY96iZVK9vzcdOFZaD3VO6KHbP6aKAXAp+b7bgzp0ycIQ46s1MkIJwIR96UrWSZD0zAvsWHznyCa926BsY7c1OEJSqg16/DWPiKCXg9xfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277281; c=relaxed/simple;
	bh=LxXmRzkWUI5sU+b/EoQqlLiqRK7pr3PQCF6h2eMkRb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jptU8kfLGF10WSeWimNZqw98vs9C2k5N0nNdnjXPqRGiSd0MMXXB/gymUkINhqhLIoGFQ3XjKhkFz/mxX0t5L/iijLiWWzwB6yLAAL0brhmidNEOb0Z+E7C+cm0wro0qJlDYtp9PmBLrQOEAHuVbNfyowOE6jzuMhD28QRV8nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZEgGfJku; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZEgGfJku"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CA6D3F787
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1770277279;
	bh=zxCZUzd2xfkMizEOYKRbaOGQsI1X2IZR0QVgIaFzVaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZEgGfJku8lLHH2UimQ+yHYAMrObB65G6SoQ/NF7R53egv37sJw3Xbw8CLjFcCmq0j
	 DYyRGSyt08spxlS6RbAZ/ZeONmup7Lb5sLtOcwi6iEdP94i/+wf2BdD1zvyxb7D5xx
	 chxG311vmlk/dGwhKBKkwRe6u89pUxpagTvd7fNkS73Ml3tD7Hxu5h5xQ+hIWEK4lr
	 XTu9Z+TN5On+B/qxs8MRceEukhrv3XOucUJFAH2p4EJP68EQKyL2+DKP6Z24ooK6cr
	 z+N3SRlR/6XeG3erT1u5wH2mckixP6eCi05MzHBtZTzt6gG1meyuxFhe8Nt1XIAnXt
	 Rxejw59iMh5i9fp3QGDwHevx2SFixMtQHH7fqQjXcZcCsTMQzsmpMRgpTnzldRvFZB
	 O6TWWoOBB/qmlY3OD1LZG9X366epVvQMwIPcM/kpP5Z2wG+Il38Z5s9MvDq42S7q4G
	 JUI0J3IGIAzhGifgaom8RQ4kmjWYwqZjlPYg51aVRYeXG7ITe8lUrOXS8krWRWUSqA
	 Tgv1vfmGoSfUTaCQxK+nI8uY0iRyWA5OHaNEqKQvdZv6r8o7kvN6HBBZ83vv/m2+Vz
	 7dfHU0YP7lkuHFriCqwXWAQwvRuGH84/I5ApD3FMmpVJXvRHTwiNoObZdJAhrdvOVV
	 UtyeNTXDQwL2UlSJ9IXRW6KE=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso1569387a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Feb 2026 23:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277277; x=1770882077;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxCZUzd2xfkMizEOYKRbaOGQsI1X2IZR0QVgIaFzVaA=;
        b=gM9nO0pa6Y5J87W15K9lNKzPiudJEbYuXr/Qts8kzMJjaarxnBZ4nPS4kf/QBg21eR
         I1JI7gCVePxkIyyjn58QjJxxq5Icdb2JSTkmXSnCNPoCirglWxW1NbVmTUKvDmpE9Dpd
         rgtaeAcHnwNyfV5wBW6+m5HcQFS1sZhSVe7XpLnT+V5ogsZKqqxwoB8xsB/UpFoHQTuI
         qJvfqrh8Ag6UfG5qdKwEgMjEwOejikbMmcUgArtghqEDgAxC8qn7dgsUlXEO9CAb7JGa
         WO1Pk4735vOJPjj424QyxLlWNloeCnZmhGhkHjgnSjO1eoIqUt+GqeUu3oBO1WkkV1H0
         cu+w==
X-Forwarded-Encrypted: i=1; AJvYcCUril8LrFwQWMTaTng2OT1RFph2GWkhEA+CD4TDRUPrSKo0S+/mOWEwF7SnPOlT/sURHb/iShevz+kEcEyckOLwmMwaVCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3Bp/qlBX35NVKSIYb0YUwIomE47M3MJlRT/5vh6o0vTKctqH
	3v3OxZC0lmf66CUshQioxxEFpNlajo+2FV6v9oo31lxzb/iT4X51hcX69mXl3U9zUVqRbhhOst3
	dIxCgHPTIMcGhvLjIHq2RVmCchJqLpF8RRzGa3GJbZBkSwkG2Huug571HHZ6kvsIJnpsBJblSDD
	5FExGblwBieigGuQW9Yg==
X-Gm-Gg: AZuq6aKFA//zgp6g0AesYrao/ZeuttaTIlVINUHjZxlPKNowcP3mAD7RrlgOBW5bLMv
	gRcaAkWO3WN30pA3XeKlGoE0OErVZIfVtp28NfClW/jcEIWB2BM0Fe5HHMhOwCi0+AZA0b224X+
	z5taDxmnT0NXgEMhOUUgBQ3FTeOX7fPvIYAzMQ1/P/qnFAIC4F8zY2DH4tGt3M8LbwqJrS7iuqN
	CacH48zoLeVCYwF7kMu+soxvwTcRz2INNQtsr+YA8dNxHmUfPkn76LUNhZMRekB9+hh7Ba0Bf3C
	lImy0HtlgqN8LM51Bno2eLZmD+d2JFcHUjtO+CrABkcHUKlzZNC5WgNJbIMN26cy9dA6bI/eK2r
	pMv853d/NHXxjSFJM21BDSvAZ
X-Received: by 2002:a17:90b:3c49:b0:353:356c:6840 with SMTP id 98e67ed59e1d1-354870e76abmr4514900a91.14.1770277277742;
        Wed, 04 Feb 2026 23:41:17 -0800 (PST)
X-Received: by 2002:a17:90b:3c49:b0:353:356c:6840 with SMTP id 98e67ed59e1d1-354870e76abmr4514884a91.14.1770277277365;
        Wed, 04 Feb 2026 23:41:17 -0800 (PST)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3549c28204esm1621107a91.10.2026.02.04.23.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:41:16 -0800 (PST)
Message-ID: <1695a9cc-0d50-48f3-8c44-c84f3424924f@canonical.com>
Date: Wed, 4 Feb 2026 23:41:15 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: add .kunitconfig
To: Ryota Sakamoto <sakamo.ryota@gmail.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <20260125-add-apparmor-kunitconfig-v1-1-e815cec415df@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260125-add-apparmor-kunitconfig-v1-1-e815cec415df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/26 02:05, Ryota Sakamoto wrote:
> Add .kunitconfig file to the AppArmor directory to enable easy execution of
> KUnit tests.
> 
> AppArmor tests (CONFIG_SECURITY_APPARMOR_KUNIT_TEST) depend on
> CONFIG_SECURITY_APPARMOR which also depends on CONFIG_SECURITY and
> CONFIG_NET. Without explicitly enabling these configs in the .kunitconfig,
> developers will need to specify config manually.
> 
> With the .kunitconfig, developers can run the tests:
>    $ ./tools/testing/kunit/kunit.py run --kunitconfig security/apparmor
> 
> Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>

Acked-by: John Johansen <john.johansen@canonical.com>

sorry, for the delay I actually pulled this in a while ago, but the initial reply seems
to have gone into the void.

> ---
>   security/apparmor/.kunitconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/security/apparmor/.kunitconfig b/security/apparmor/.kunitconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..aa842a0266e9d33c3333ec2ea180206187b0eb4c
> --- /dev/null
> +++ b/security/apparmor/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_KUNIT=y
> +CONFIG_NET=y
> +CONFIG_SECURITY=y
> +CONFIG_SECURITY_APPARMOR=y
> +CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y
> 
> ---
> base-commit: d91a46d6805af41e7f2286e0fc22d498f45a682b
> change-id: 20260125-add-apparmor-kunitconfig-28aba43c1580
> 
> Best regards,


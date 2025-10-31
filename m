Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91401E834B
	for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915561; cv=none; b=cRJ2HU+hpboD31ySUGIpsawb5V3KxM73HSWbHL9/9Br+krQLQ96mITXvYRYRjxWsPhqUBhMuziPc6rhgh9SORHfD3UMaenproUHZii4mwIydMx2cwC8YdRJ+zJAPYAHdkwqOoxxAIJ1zvPmnM1aCz75/oMJ6Dq2cxGx+gxyVFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915561; c=relaxed/simple;
	bh=dybpf5GKK2n7h4v1nOx6jkvMz/++Xvmg8UxFM+o1u44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvfajiCADft1DvLcUeGNsE67nkIYvIVRiwbTx3p+/aMCVW6pT5YTZBKuigD82K3uKImAyEOgBQUpOk2OO76itZjikdXnpr9B4Jlc5KyH2cBFRxS2UMgO7+Bpb7hbknokc8pO7HDjWEqKmJavoHklExuwN4zxTeIlnIP5d3nfNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+1MvRdz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+1MvRdz"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475d9de970eso15424015e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915558; x=1762520358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGlM34W2lpnnNMlmNv2zHPFLrrOcHYWtAmRmuIiXp8E=;
        b=K+1MvRdzOnmei3By3OmjpkZzb11edmjWQ31LTPPcDNxS4d0YdWOddVi3Dnvdc2PJoA
         +uxJj7ZR1KIiPIy6C3y0o8BQHC8ExSvxB4BcJmxIwCcJifxEFRZByqRuWiysEyqNiMgZ
         duZl6B+D+UtCXQPKI/u/cwQiD535z/WW27t9LE8MbwfbvlDFEcu4tUMTlqrNEePJaFuQ
         X1d9wpySmZ3L4TldozwUMlQQHNBFDvF+8vsUjlj0pgRsqv4ULy9M1P+pID0UiId9YygV
         8gnOPpGaUZxz9srWlO/VZ5OilOv9XeLK/c7LLrDQuFRGdTq3p4m3ekxnU/Yme9cDAwLv
         nR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915558; x=1762520358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGlM34W2lpnnNMlmNv2zHPFLrrOcHYWtAmRmuIiXp8E=;
        b=UYUvNNoLrqOzLqBsA3djQFBGAhaSaR66sykKDxedRctN9kprenjx9/UAQmdRVpLKeP
         3W0dUZVnwFlR6eGuhw6uJeKT2n855GwEGPjpletKqTIERpzWiY7NbExAQGK6p1u64SvJ
         Zy7wvTxa618GJayS7S0w7KZ8vKBHsqegvllSgVzxoK6bC5VVj4LaThu5vbc7cnYpy2K7
         7KCY315OIBSgFBzzEVfGcLJWvPDRhphit5zSTult8djaurcNBy1npDGFqd6wsb8c6rNi
         s2d9NNepQ6EZGBGOXO9kMosfyTfmoDlunmjK+XNzPhDVX5YpjZ+9LleyBCa8LqqTLDr5
         2sGg==
X-Forwarded-Encrypted: i=1; AJvYcCU+urWwhG6IcJfUXtCKU3mbimZejvHnGyDz+m7iirKOeZDq3UTyrfz6A6mABx76/whHxhLyYw1h2OMNK3pZj4IiEPeawIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDBTEsJmq74m33XFoALAbUuQFeOJIuyvmrm6p7bnH/yZr9n4Z
	ohkWeDffAljOgehTOwBaFphhOqx+jDfaqa4i6eKNgJGFRV+dC4P1a/hx
X-Gm-Gg: ASbGncuPUhtUrWRC10uqOZwmr0pqeHXJsrH1cR97aVcsaOKvA0wmKE1q4kgvFqvIzQy
	dNMic6uK84fhFzpiovFANyLH7V3cguUHBX41+j30LXGjNCOiNpDWgqhoaUlE3dSO/TUUE6WbNHr
	UUaQBq3woDOoG9eGO1UrY2GCg6e7awP8P/aMZOQue8To/f4h6/M/65aPctSgH+7dgOCjMNQSAc0
	MH50utzPhlqT8MzkaBzt/USsONd3MwjB7QSxxMEtq4WgiohpT/3nNuw3aCZK8zom4+GLBzuJEI/
	WAhIKhZVNhAmuz5ZriNWYtiBGX6SM0YYjOsMafEUSSKwC6I+gkw6HEL+fTYacWPVYU1cZDDLImX
	QcyPq8CwtC0ZIn+9pm5lUASNF1d8bR1CtUsiCiR6anH/lQOS8C5fuT2VJKYjrxNNt0KUI5bG+T0
	2QsKtZURRVESu/uZh/zn8OqQ9wrZ51R0YSRKpzVoOJDg==
X-Google-Smtp-Source: AGHT+IFzTOTToGktkUKQqr8jh0BWKWUjuCv6bnWZrsKQOk112lKJTQP+IEHPq+CXg603VeI9372WkA==
X-Received: by 2002:a05:600c:5249:b0:477:c37:2ebf with SMTP id 5b1f17b1804b1-4773086dbc6mr29613995e9.22.1761915557693;
        Fri, 31 Oct 2025 05:59:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm3445105f8f.23.2025.10.31.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:59:17 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:59:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
Message-ID: <20251031125916.3b0c8b22@pumpkin>
In-Reply-To: <20251031110647.102728-2-thorsten.blum@linux.dev>
References: <20251031110647.102728-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:06:47 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strcpy() is deprecated and sprintf() does not perform bounds checking
> either. While the current code works correctly, strscpy() and snprintf()
> are safer alternatives that follow secure coding best practices.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/device_cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index dc4df7475081..a41f558f6fdd 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -273,9 +273,9 @@ static char type_to_char(short type)
>  static void set_majmin(char *str, unsigned m)
>  {
>  	if (m == ~0)
> -		strcpy(str, "*");
> +		strscpy(str, "*", MAJMINLEN);
>  	else
> -		sprintf(str, "%u", m);
> +		snprintf(str, MAJMINLEN, "%u", m);
>  }
>  
>  static int devcgroup_seq_show(struct seq_file *m, void *v)

There is no point using sting length limits that aren't passed into the function.

In any case the code seems to be crap (why is 'security' code always bad?)
(See https://elixir.bootlin.com/linux/v6.18-rc3/source/security/device_cgroup.c#L247)
I doubt ex->major or ex->minor can ever be ~0.
So there are two sets of calls, one set passes ~0 and the other doesn't.
The output buffers are then passed into another printf().

Even if ex->major can be ~0 there are much cleaner ways of writing this code.

	David



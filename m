Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5E1FF1B4
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749382; cv=none; b=iTzJGLdC2rmWPkqdunwN9r4Dyp28QokGj4Qitr0ZITwg2TxRY6Ldnv4g7sy6BCO6iiUYgeOtNv5gYAMlWcGr30LopbUcoRghmTYZ8wlFhofJbaShRj8T39m4som+SoC6Y8FTtvHn46YExFeVcuZm7vsR/cyckEUsiKqRTyljVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749382; c=relaxed/simple;
	bh=DRFKsp+Ap5KxmehcMaouR40Asxsi+0n1hhESSY4aars=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2knZTgBmssdUPLIHZXwEULAeb/0IdkwfFuRzecIWnn8+Mfl2/OYLpmyqcfTubED49YezH5SG5XfWGw/43dbm63+NHlOVWn70jmteCr2/DXo/pFPIjzfptGaPblFFM8T18h+VV7dxE2tDs/k8TBHpwa6oHHuprreTdP2Nk04Zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EXmpLceC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EXmpLceC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so1523002a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 17:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767749381; x=1768354181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0pBefQbuso5i5RJAZg20ofCLs/9BTYjoo+5IsxGPF0=;
        b=EXmpLceCA/JRwHAbIUa9rrRMjXPq6V61AFql+i2WJjS1UkFA9aAeJntX1myOSYPqSK
         kVncWerxncXYm+sxXMmBq8CxHXhhdCyLQdRgjYwERnsY/jwI4BS0OSZohl3SdsmC07NU
         CZKyIyjfTA3QwiENe3E1m1wjCrHBKlb5fuXST4A9eO+gTSl9yvUIFdnZjjoKAQ2oAsG/
         pscghClF+K1gNPesTGBoLAEXk5D9cXrHVaIqu5fZKin9t6+4CDnk6kOI1CNrUF/2+PFp
         uzLCDnKoQYKHZppHtwHUqwKwWfZG90jsFBzkZ+xqIsnAPRDoM0QyPBLXVrX6VAofUcHL
         1xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749381; x=1768354181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0pBefQbuso5i5RJAZg20ofCLs/9BTYjoo+5IsxGPF0=;
        b=jOOq2w9EKO1bSK0j85Sd2VLEIEp20ZF/FzHnYR7dzYCSEQSRquVX0kw6hltxRjhhQv
         DkM51Q5CbszF6t8FAzQq754L4X69ZcojPcpV9HLzJWZUWVZkoHrKizBMysBB/KNZwBco
         +DvCEPTIEyDS98XgQA5qvKUUJsaU0vJhxCeCoQSkCTHdXo0zEdrIa/QT3wHvDKCz7h2m
         3pal8ajbPTrbtxQkeigfEFeB6uuYwHwqup8NAh3n4NjCfCR9Rosw23pDkDbv6K52KGoP
         nKm94QRjbxbNhCGQWW6mcUNvro/IK2/DBPqS5vaPZgAPYo8wWhhHB8njbPXDCLdX5qM8
         7ehw==
X-Forwarded-Encrypted: i=1; AJvYcCW8o8qh28BVOKaVpAlfqcgcr7aAAIU2vU0KrWB3shahu+2mJgaJ1pNUuTOgbXXLdVUWwuNC8AmtKzQN2Q1oxdvQdCG+OyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74Uwd5jQiSU+Yk6R2/HYfVBak/c6B4NditNzIaDuVPzQTOXCv
	1yOfUpqFFEbuE5vw9EFnLIRI9SY9TKFwhD+hBbC6vS0E+RLI2Ke2cqGK+BkQDMQKM5wlVkthvkW
	4jckzuusgsTGlkeJ9YNUUjmZp8v0t6Ncne7D+gNevs1t4xrTjlw4=
X-Gm-Gg: AY/fxX6vva8k7aDgihsXRDWIMqiwYwAIsoNfwdOdRwtmgSTQqGgM3Dk5wSLK7JLsFv3
	YoJwLKvvdAYePZ+zRhx/6i30hAQloP0RTvqC5lxb3QqpDPJb8+bHcqxVaRYOU1hgam+dkpJ8IIX
	PozpTrGXWGRCsLGaitUgnrt7vp7WxH7uYp5b3VLkmDjIPQyUNffIGFfU3I2w6CTfUN2/k36+HF4
	lYkCXvzVfKnaMar+J6ZCNVl0KqfcBFW5KtYGMFe6SUS+GBW3uvCOiecqc4z4GCdVAhsq625TlaF
	1nfcWg==
X-Google-Smtp-Source: AGHT+IGfb2A+nhvnNQOx8TMMH9EiNVUlKYqXZyMaRyVzB5cl3V/K+cnLO+l81AYET4vPB/8feGDBkgFNGMZHFYAt6hk=
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-34f68d0bc5fmr895604a91.20.1767749380695; Tue, 06 Jan 2026
 17:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com> <20260105-define-rust-helper-v2-18-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-18-51da5f454a67@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Jan 2026 20:29:29 -0500
X-Gm-Features: AQt7F2renVuLVVe8wWTbuH4q3nq7hx1KIccN0wGk6bVav0-qDU8XzYmfHUWf8lI
Message-ID: <CAHC9VhTscH7SE1WTQrtXRrhNV61f_MAYViF4eJisfEYj0-ZDoA@mail.gmail.com>
Subject: Re: [PATCH v2 18/27] rust: security: add __rust_helper to helpers
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:43=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code.
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-security-module@vger.kernel.org
> ---
>  rust/helpers/security.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Merged into lsm/dev, thanks.

--=20
paul-moore.com

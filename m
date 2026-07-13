Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CF43803E
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jul 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951107; cv=pass; b=PuqH+px7Kq9pIcgjBeG4sMLIdic1E91Ex+QtrcJDxNrZpLCj+qK8lQ1UIq9kwK5ED3JccATXox+YoBHH3Tg+OcsNKULcg08nIIxXUKc+S4JE6akaUWQsh15mIL2vDiJGhJRmXfobZFnWqPv6QNwtIECVYq+LP/oj3XEX79Q7vwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951107; c=relaxed/simple;
	bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INbuerRKDUBlJSaTawd0cgfiArect/FFIQDS/H/zxiiWtWAaFPXGR5n64dxmBcfh7mREf4qk7yfmSfLqjopvUD1QytPQA1+zAfVa9jlM2Q7C4r3O+xZtK4wqjOoTsrUp+/ihO4R9oqwZaB3N8MWDPQMv+2T6Qo8Oak0NMPqUlXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvYQ38bS; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvYQ38bS"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca6a6181273so218300a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jul 2026 06:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951105; cv=none;
        d=google.com; s=arc-20260327;
        b=FDhi2Wddun0krt5fIHEXFzx8DScVmaT0WhPIaD2YxZETvQon1qvyIjQpdVpvkdnbvs
         iTo/lNeZ+oGbxDEUcp2eR0xDd6Sv2Fd1WD67gAve+QuVZqLygCH9EJqSrSYW+zHblaKS
         oVc2Y42QNSR9pDc3abHTeNJQPy06iItnqhKpl9bfzjUe0aIeSZ52nOipmb1aJw41ffuC
         NdfQ0mSUkcdYBTP/jaJkfd7aj0MkOjObq4Gr+71E7fcXAm74AT7hgKjkIDMu7mfBdDku
         9fbGxo0sM8WW/XuKmRptHK1wqCk4QZ71QzXqrQRI7nBHDeM6FUPjHPtd884F22bQOXvR
         NJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
        fh=pjtDJB8eK1cehrx3sRoc7K+Duw1oapSAhhx4Dz6f9o0=;
        b=ER64bNgwENSR567XPg8P4xYl5WICa04hX6qovmbU8LV3oZtyud7lL4nIxyZ08v1N64
         XxwxWsAnZxw0NSxbckcZ7AspiEoz+6yxtY+OxiOnxPu0RUb8nO4NKFHqE+0HxKyVsMST
         C9F1iBW4HzvfUQE5wPEE9ot8uLKnlw8PUJXBvw5IFRm9QGbipxIScdjzrECKaDR92z14
         7eBzJ2oj/6Gle+z8EimL2gbr17+rjQwQmOFaElINZOe0Qlz+8dpnNU6c9X+Jl1PwLDte
         ud2kMxkFHJHSFul7GRHxMn9fVLewiwCo9CJZh6uOHZH+uLn4r0GZZeFQ8O7bxJ13XK0g
         uybQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951105; x=1784555905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
        b=pvYQ38bS5izAb2wG43KIw1P5UZYxb9ft7hJA7sXGuPIk+dz86Pb8VD9ECUgHy+1mla
         d5j9N26TSt7b4oYsqANI0Mc/qtliamFi983eHgT0vJPctREasIMkOgCRGhGHJRfuXY+D
         /6nZCYJdRiNqHZBvgEoZyraCJbtazyb+hb03mnbKxg0EVVic5gtoOzCGrG9spdRd6AM6
         S47eg9rK9IRsythVWjFWxF2PInkXXhuBVJ+1y0zsO61H4ANJ5y23tRP1hMcpBhTyPvqj
         egFmm8XSRWiHIoWUpQsEKEW5yLs7/dx3DlCJQtohvCftiwDJF7DWG/o+6JyRTHV23S0X
         KZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951105; x=1784555905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
        b=sw75A+P5fVpqM+VQOgFmBeCjRb6aDtP2nhVGBRjPVbcissjDUArfKtrCKUXPP0aBsa
         6uPg7MdSiivgNmXRQU9hO7//aW7QbhrDrTsZ3p+gWfH2CW0xJ9lCiIKN7zjEBF8Zsj45
         Sxzydp7E10JkIGE4ZfnEVAsBm4HfiY2qrBKLOXUbS3qwQloe/dkZqWrjG3o4XncTYuII
         uGXfiRoBWfNV1HSuZvTqEfGGQsUaqysiBKYs25vutJSdmCWqBhibDRcGjVDPIcOVtqWP
         vfLL0OrRDL01xNgZx+oZLYVKDICCehyAHZMCeQypDdLX2+ByLRph0pb1ovy+9LYZrAFX
         kMQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxnHKobAKVagtsDgrNMJ/a+jNfHn4JZ1jxvKDMnMIegpPSgCu7iJPk1NMqKJ/xknEqGxH2Lh8679dff0BEM33NkmRuAkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB82URKaluBGfdJmiMlkHpprdKGxulanEzQohgNAJlVRQs71oz
	P43gnlTadMnSjo7r01nANnC/GWBKscFa+rhNLsl/3t7ai1iEtNTd/pfzK7v4zx9/t8Cl8rhOG+9
	tsEw1fJcoatOQPWzQorHOxM3Oxcl+9Xc6gnMl
X-Gm-Gg: AfdE7clw7xqDjY2jhjinQppHLwgh2zEWzQOZrpov9EftT/Uf79lb42TvAReywAvKiC1
	SjWwm/2Aqs1uGgpy7WbenG6yKnMrOtLLSvZlViuZQ2OkmA9gHpAmuCjDBS/Cj3S+anRULk/H2I8
	zdz35O7bjTCcEfFzHntOWokHReMKcR12LeKntD9bTv3sKwq2qTI2UK7YcHhqeEPHMISsoKf5B+p
	sBgp/IqiVRT4W9JS3wfkRNXroyz60ctyPFEJd1vSPuq2T00j2WOkkzJRKMieLIsmP1T+PXti8PB
	4Q93wBNrXfXNvNU7iwJHsJ2JdB7WeDLvY/1S8YoEhXGmH3W9bvDpmH+g2KHn5pegt7ir4bBBE/c
	H+J+11Y3oPHe4
X-Received: by 2002:a17:90b:2685:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38dc781f3d7mr7088440a91.1.1783951105371; Mon, 13 Jul 2026
 06:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org>
 <7cdb2407-924c-44a1-8c68-917efadd4e92@sirena.org.uk> <DJXHTB615I2J.POTXT6L2LM5K@garyguo.net>
In-Reply-To: <DJXHTB615I2J.POTXT6L2LM5K@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 13 Jul 2026 15:58:11 +0200
X-Gm-Features: AUfX_mwVZ0NryDxFqhvpTqzVNlCtwM7HgnYa0pfBRDhjq9-oYDqBTVV0BB9Vf7I
Message-ID: <CANiq72kNYRBW88VwYyDX8_2b1L7dLv_gDwgE5SruMELR7KPmig@mail.gmail.com>
Subject: Re: [PATCH v3] hardening: Default randstruct off with rust for better
 allmodconfig support
To: Gary Guo <gary@garyguo.net>
Cc: Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 3:55=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I thought Miguel wants to add support to properly support RANDSTRUCT with=
 Clang?

I am happy either way, i.e. whatever the hardening folks prefer, but
regardless of what we do, I think recovering the linux-next coverage
is a high priority at the moment.

Cheers,
Miguel

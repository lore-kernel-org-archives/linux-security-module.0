Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F871F4621
	for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829405; cv=none; b=iilOrfJ5lg3k7Spk9kbblZp1Bx9+Gwb9sR1O1eYvHBCw1m8/0oy5F1aE4mtN4xh2R681GUPVbbL0Fhbg3oi/alySw1PRTiwX8OF9roEH60Vse+irgofToKIDhQM+wZl5cYeDrEfNnt0TgBe4+fTZAOWFk3JrdCh22ndOCGS0Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829405; c=relaxed/simple;
	bh=ErljPl4av/QaQOhDCXeS4el6raSxykJe0R1j3QAerS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBtIYvHetJ4+W2/EFNIefOZkLiXBuXDTSTZZy1ZD+X5zWCIjUK+Gh6xL2JwK+F64z+ObgONJCB4i/tAmS9UFMnFHzbVW+NPfRBI/QXDKLIGKWZxApU0Jpupy+RAxoH3iYJrvOaNdwOVAxmQnLNd+GRsCX8GHPPadmlJiKuv7K+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fvmsiW+0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fvmsiW+0"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso418141266b.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1749829401; x=1750434201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcZeGwCm22Kaq6Zayr5a6cqDxVP6CQrhoWJiO/5RmRE=;
        b=fvmsiW+02d1wTe2+2Yal3XC5kXp56jnfxg2XJgmMYVcHYQ+l7kWo/Hr23rVAEMqwor
         GylmhHb1bP6gObuEzgvwXm+75OF3Gls7x/o6th9PyDD/pAnxeFAfVKftuN6hlQAZduEJ
         6HMujP1EKOoRSASOzNDCFWEJicuGyfBe1e+bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829401; x=1750434201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcZeGwCm22Kaq6Zayr5a6cqDxVP6CQrhoWJiO/5RmRE=;
        b=pUlh3k9V/zILuXW3cDyuVBz8U3oNcWTsRJyB7BFDFTeSCIXXxsfUqs15U9U9Q1zpTS
         XwCjkEuoAd3GlrnsdEMyo5cLvhNyTWuuF41puKcrMIxsi+uEbOVuKNrtvNjE0qjC8c1q
         DntHutGt1bK+o5g5A+CGYmbYlRv66yO0Dv99Uhj2m0Awch2WRlkCNLqHNdfzG6P5tAU9
         +rCdS/A4I4rRm3AGCT7fMXVN6NIz4WNoKupUP01aStii0spTZPoUzs0iuVz4zrMtYqWI
         8q3yKkv9Nkg9pTxIFoCD/sRpvBHNH7un5OP1mYWtujwG8mup7ap7Vos1cCfRnjCLnfyu
         oboA==
X-Forwarded-Encrypted: i=1; AJvYcCU1zRhaqbK+qvuHAh9Cb2t36xPnKxpumXB5ksZEqkUCN8idhlVsho4/XCs0GF8D4gYtaXpRRYY1C1XVFn0T6Gbkc8bRmWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxVy1JjYQ9EKQMY1fWgZ3NkB6BPSLPdP77YRsLKUNUC49RvEv
	vyWckCOya51M0SvVbt8w8ikuyo7JDg6JdNZJ1stY0yHXJVdVaD1N3bF15bUAlu8XB5fv+EE+9l3
	QW/8KZEo=
X-Gm-Gg: ASbGncsRil/RoOAxygvjkAl9/na9fjUpq19/Y5obzC+9nWAuzEORtgKPXN5fXeqlGBM
	V8nVLaRwn312RZ1+/eSR2IyETgINwAvxjVRDpW5tm0HzTYTQUq3mxipjD0cEuZ3kZOger6i3xpX
	wWPP3mzTIopUggOb+ZHGeSxAFHWTPE9r4Gqb7Qs5cdLW0j/iKGW2ftWygEJoTZTmxsKkeXpBSUg
	cCTWFHubnKYjrVPx7rrP7bT8si6fgLzrvOYNO8sUmxVAR6W0SgjzQxTZsm2qYXk2QG33KRrMx9n
	yu4wVX+JtrF8nQ44CKdZ3DY2vyUVhFWx0fhn5/53b8ttMAvSWhks002Y4/ZZaKBQiyIgr1AgX+L
	1Ud0/WzZbQxzEyNETutNPuBF9UIEFx2icvTaU
X-Google-Smtp-Source: AGHT+IHz24HNUIpSaLme4KMuoyRZ0XEo6vo0d+ef+xHX9ChCjdQ9S0SzIJ+eYAOlRnExGQ/t7l1dxQ==
X-Received: by 2002:a17:907:2d08:b0:ad1:fa48:da0a with SMTP id a640c23a62f3a-adec56b058emr348510466b.35.1749829401245;
        Fri, 13 Jun 2025 08:43:21 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff06fsm146105666b.102.2025.06.13.08.43.20
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 08:43:20 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso4750027a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jun 2025 08:43:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVnYAkDA+vAS8Zteraw6ef4K4ozNYODrFzjyrv2yft4B/IR4waRM0ZzEyod/C/sW7lCvDR7l7Uty4ZLUwaei4F/841sU0=@vger.kernel.org
X-Received: by 2002:a05:6402:26c7:b0:607:eb04:72f0 with SMTP id
 4fb4d7f45d1cf-608b4910f1emr3292023a12.4.1749829399723; Fri, 13 Jun 2025
 08:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <501216.1749826470@warthog.procyon.org.uk>
In-Reply-To: <501216.1749826470@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Jun 2025 08:43:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYdf08uju5UrDZ9kEgsC9yrtBNOTzSX6zAbOdRfg+JkA@mail.gmail.com>
X-Gm-Features: AX0GCFtHIfBeIIpdLiCaIbjGHR268VNaR19hWtgTk1l0lqwTG5TIoyTmne_dSmw
Message-ID: <CAHk-=wgYdf08uju5UrDZ9kEgsC9yrtBNOTzSX6zAbOdRfg+JkA@mail.gmail.com>
Subject: Re: Module signing and post-quantum crypto public key algorithms
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Stephan Mueller <smueller@chronox.de>, 
	Simo Sorce <simo@redhat.com>, Paul Moore <paul@paul-moore.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Clemens Lang <cllang@redhat.com>, 
	David Bohannon <dbohanno@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 07:54, David Howells <dhowells@redhat.com> wrote:
>
> So we need to do something about the impending quantum-related obsolescence [..]

I'd suggest you worry more about the rumors that Kazakhstan is growing
a veritable army of gerbils, and giving them all ABACUSES!

What's your plan for that imminent attack vector? Because they could
be here any day.

Yes, yes, please stop using RSA and relying over-much on big prime
numbers. But let's not throw the "Post Quantum" word around as if it
was reality.

The reality of kernel security remains actual bugs - both in hardware
and in software - not some buzzword.

             Linus

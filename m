Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202201EB5D0
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657263; cv=none; b=u5VKFIxbMZU7Nlpk/nE1iKbN5LVkNxhk8xdz4JGkyW2lAzlApD/Q4xg3lM/c+TNGc7Enjf97v1KIaMyvcsN8tRdQZ/aSQ41eqXGVSOy6bV426gToelZn33gy7WT9NRahSCj14BudAsvs6X02nw0pzgkSBCMSNZwJ/ud/LPPYeyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657263; c=relaxed/simple;
	bh=MNJifaaW2DKC7Ep+EbGEsZeWuZtW79t5zkE61iueUzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YovZbJjkwOESNqE8p/hnNBrIPyD0mar2+zOOJqW7OHgDruPXgFe+cKvXQ3fylIVOFKoqRK4fkWzT26SdEnJGogYvLtoRZ8uOClPXttvAb374BtE1CDkEavTBT9rrtzf/PcyagyxrIWognlxsNF/WX6/nVYgrhII+2z40+YzTPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VoQZRUnc; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VoQZRUnc"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-710e344bbf9so63278447b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749657261; x=1750262061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBhZQu6BqagB3PC5bDYHjkHrfQ+2AWYQFfsjZus8X6I=;
        b=VoQZRUncykxaGZ7NsMVcqtrTcp5nmfGaQziEJb32XqsWTZI6DGMxeVHR1blITt+Qqs
         F4ZIMuJCaM4dIVkrt1JLT6ircWVM4EmwCb32sw80IEIvBznEZ+gNvVax6xGMEsXWgvEB
         e5AHBdIrSwkRtkYcnPm514FFcCfdtbf3xCt0N4er71YLh31wmQS3O8FPjGaM5JI2c/nA
         fIwMS2I5G6xhiEDD/vAZtQKVLzpB0v1l7d0cHEWOMvqaMKYd2Wp+f8F8pPZYKTdolany
         NmSD6Pf7L8yUSJhryERsnSG/SXuFJ6HeKKqIgpj1Rt0a2/R9t/igWvnflEDMXU8BvDcW
         BClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657261; x=1750262061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBhZQu6BqagB3PC5bDYHjkHrfQ+2AWYQFfsjZus8X6I=;
        b=fyozdgh7clyg1jgsroAGXHMQaFa/wLCggOSzRrczQiwWBQUQADE8H4h9PKk2IrnafB
         BGqWdVe4QlsDMLsz7bI0IhUr1rDlMQrq/ZdhPINz2l6d52fF8sfjOYMUAbyU7w1axzij
         1OnOL3p01VUkcH8ql/y27tLl9RHM4hhbklyaED9QcK0HUAucnKRh7R8YCHac3BNfCamg
         4CEZjiA/6w7cLySRM5Fx9E9hpHYdsw6g2hhuoOBw2/Td/m/7vN688Y29TWInhyUOfM5m
         lntMv4C5Tm1w/KRc4fW36VbFlLpS1q+CAOUoygooIvwVyvrjKUtfm/MEXF1KNpgUHiAE
         vIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFsCQ9moW5dUQmxd57Nl4Qjc9Gr5QkVb/hp+8jA7ev+jmnQzSTZJ35SkJmkQE6LPEpl8U9VeZWYTBhMxEOpwJCf2XjdOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzruAPbHYW7+seoI9gJXqmATWJwzjjSluPNQhGK/epW5xwb8je7
	Ch8OMfDXFeUel54d7gdIyz+rUK7OZDr0WiB4yBU7abQYdsBhF3pv8wJl39eU/Y+pEfD2QyjAQBt
	1f+0bOyg+u43o1/S9Wc2DvAUUbvpW2AUUCC1PbSC+
X-Gm-Gg: ASbGnct0xsJTN6BsEug0C/Sy14JvYcoIEKb2SMOX4kMfWI238NYf8AAB7Q+F93bhxug
	TL/HAQzIvavfRS2LJ6xk8SuhNQQgp/s9myMNmUtRm6yxOXbGCqLjJRL3VwazK5iAnMFZpEU5vsM
	DV2WFrvCaCMSJPSwVmjrR/baPLGpPUdcI5WldTI8Z5Ylk=
X-Google-Smtp-Source: AGHT+IEn+kC/BZ+RXwGYxRkP+XLD0tGlRkO0idFv9DQonG8a7gWIJr8vGNDUYR6rx6ZmmovcVVyDmS1thVUaW8UvqdA=
X-Received: by 2002:a05:690c:f8c:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-71140adb8bamr52684357b3.25.1749657261129; Wed, 11 Jun 2025
 08:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <aElIgixaHGuHEnb8@gondor.apana.org.au>
In-Reply-To: <aElIgixaHGuHEnb8@gondor.apana.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 11:54:10 -0400
X-Gm-Features: AX0GCFs9HQfkD829H3Li4br3UccO43H5X5WtKEy278IEIzt6bh6uwIsmTEf8mkI
Message-ID: <CAHC9VhT9k9+DWh14HEnv6V1T3=hDJFY-fOcE-nexPFv0jdL04g@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:12=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
> On Tue, Jun 10, 2025 at 08:22:59PM -0400, Paul Moore wrote:
> >
> > It doesn't look like this has made its way to Linus.  David or Jarkko,
> > do one of you want to pick this up into a tree and send this to Linus
> > properly?
>
> I can pick it up for the next merge window.

Great, thanks Herbert.

--=20
paul-moore.com

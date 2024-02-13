Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31D629E3
	for <linux-security-module@vger.kernel.org>; Tue, 13 Feb 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865831; cv=none; b=kAjFzFylocmzzTlfLSaCBVrOuHum99D3DIYSEpoc1EWhhPfUwffzC5yUGo+RbC+HXOooxbl6Kq+OCLCty1XSVHawyHtinGzlDHdvA4+SskZOI9wOnznXIbtn/IgqaWATWfRjy0KRslDyUYuW/NusADLwOFzpxPBM1HfPVoNujsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865831; c=relaxed/simple;
	bh=H4Ya62VJEHpDhu++hTcK2UQ0UTlAr/JYK8cX+eIgCHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMnjzdpgEDgoNH3zdPUrleULHrFqjT1hAPEPObdo345VmY2SMI7f7ZCi/E3w5zVwTwpjmAF2H3PgOhItIcUCPLIJVwcNm7LKQZWv3GgwH0TBFAxHuevSPIgxRgRlS3/z7AkTdlLvTwuRtHpmrsRHHHDELWaYWjIfnb55HTUVeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VCEBiO+I; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VCEBiO+I"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60757c46e34so14741247b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Feb 2024 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707865828; x=1708470628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mwhdd/5j73wpResZtvHCdU9GeW8m8WoqAvAYZ4mPHw=;
        b=VCEBiO+IxEYJ1rpNPihkGoMykuSLehF5WmK5rU9hwTlJroa71c3BNMphk2NSpgcBiO
         9vsJtc80965Um+VtW1i30TejVBdivWBNuUea89s9OZ/rop8b9Ct4AB0v7ZOjogW2THmQ
         GNtATU2nqeo270QRR/+LvScx8hMDNPWsrHbWK2+kgjR5yrFi0OgPHdzuQHHiAKDbSMEQ
         QELsuk10Wr52wpTMf7Q3DqkKYRuYUsf4UtRv+B59LBnTu1t6jXDg9hbXhzIB1EBIx8mh
         YYJeqchlGxpoelyo6jNbwYC/msSPgWP90wi0FSEgO1wZlycaF8OAC4isdzeBJyEideKi
         akcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865828; x=1708470628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mwhdd/5j73wpResZtvHCdU9GeW8m8WoqAvAYZ4mPHw=;
        b=UEGtnzdnRJPd3ZhjvYhwChr4KQ6YeqneAdriYaSfx914xcg37k8CoYYsnCcgb4jp3d
         pFkIijGJLGQlWVHDXfp6FlqRjPeWRhdLOAUCsCvArC+J4Esgxx8DKRiFyWZRGuWU1qNF
         sORdpneuFgHjafEA80719mW9OVJdj4sGxtVrmf86L7hcPk40JdpCFw3zpGL8WSh3nfv8
         041uNiEiq6Y+QtKAJdtvHZpsmB/EygqTRaA3YdhnS6y6991gdzO22Z9hiSkuQiEWjvDD
         eUd8RvMYxt2HQANUFFzZeciLeLaOGPvSKTx4PaZN9zqbNx6oiF6h4kqyEZIm9lgzXX5A
         s9+w==
X-Forwarded-Encrypted: i=1; AJvYcCUVgIrkyPZjopdQgNEOI50vpJVJ0WB/JOrPXO1jP6YEcpx6m++JRoZn0tAQe7TZvp1zDjzBjmd7HBjeFx5voKMbSVU/y4JHks80WPYMDEIzMMnqVZeX
X-Gm-Message-State: AOJu0YwwzGsOAe3vp9ASsGO6QGkI+d50do1RcS1+5fbEoAvkFnsoJrvj
	7c9SX+qL3WXXVtA+uEZoI9aXpK3Vnv5kw7xev7Y+VXyLZOQFTKTgHT4PJpCpl59s+GRYXj2dOJd
	trZF6i2QpTdN2BDZZCOMfl8v2di87L9JgajrZu8tLYEUgOw4=
X-Google-Smtp-Source: AGHT+IHPeKasnkX7CWrFUim81j5I5yEj8GkJA1MnfFtwoyICaAL0iUUh2FOLHr9lGTsi02iwciz1wYBZF8vacK9MG+0=
X-Received: by 2002:a0d:cc57:0:b0:604:5a6d:d77b with SMTP id
 o84-20020a0dcc57000000b006045a6dd77bmr825823ywd.4.1707865828521; Tue, 13 Feb
 2024 15:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130125659.1709410-1-omosnace@redhat.com>
In-Reply-To: <20240130125659.1709410-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Feb 2024 18:10:17 -0500
Message-ID: <CAHC9VhRV3BPoJfwpLZrp5DPN-uBkvVxCDp_Qvt8=gqj3xgV1_g@mail.gmail.com>
Subject: Re: [PATCH] security: use default hook return value in call_int_hook()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:57=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Change the definition of call_int_hook() to treat LSM_RET_DEFAULT(...)
> as the "continue" value instead of 0. To further simplify this macro,
> also drop the IRC argument and replace it with LSM_RET_DEFAULT(...).
>
> After this the macro can be used in a couple more hooks, where similar
> logic is currently open-coded. At the same time, some other existing
> call_int_hook() users now need to be open-coded, but overall it's still
> a net simplification.
>
> There should be no functional change resulting from this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/security.c | 525 +++++++++++++++++++-------------------------
>  1 file changed, 221 insertions(+), 304 deletions(-)

Ignoring the minor suggestion from Casey for a moment, I like this
patch, thank you for submitting it, but unfortunately it is a bit
stuck as we wait to see where some other patches land.  I'm not going
to forget about this patch, but it may end up having to wait until
after the upcoming merge window closes before I can merge it.  As
usual, I'll let you know once it's merged.

Thanks for your patience and the patch!

--
paul-moore.com

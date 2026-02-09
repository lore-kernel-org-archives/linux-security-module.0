Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55F1C7012
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656985; cv=pass; b=hwL/EOd1cSdGGBMxxhuzZkom8Hlr0rx8+EL/m9Erd2G01BBSjPIusPCTSTAC9Z+Dwkk+CsS2VQWIWvm27HkdgLYeDBSsThRPCEiKSB4QX+PaisNEZSJXSSBpI6ku9lAvvF+00W5DA4sQJUA9a0PhA39zoLbnnnQtggZliuhmx4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656985; c=relaxed/simple;
	bh=JFlifGuVFCLnYdGOZ6pZKybsaMV8im6ar4/2XY72zYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0+fT+EmqCoDtuAjc5DT5xlU1/CUlYfbASx0D6rXpjS8kRInAciR1NO1YJDXKDt3ghZ2J/fVj8PfwCLzWSwwR7w9OaHoe/3pvOiLwlIYKAKrdPgZOWdzso/bYhgHO+dqqR1bULAhEissqo1q9gHUq+aP5/WRmwTZ5hFfWrPWlME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OMMtwfPx; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OMMtwfPx"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2869312a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 09:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770656984; cv=none;
        d=google.com; s=arc-20240605;
        b=TmYajb4lsz/+lnMVKAH9fv9oiQU4gUuYX90b/OulZZ6kzZTOAsWL6BbYQX4mCIQIJ1
         B56DhWN6CtipeOYYTs9PL/pHgxQUR3aBDXEYbSqokfunPP72SwFKopcfbZubvMPtfxlQ
         oYBdrNz3A3XGFXacF0yVX36IuaCI+TBUgK+Ku5ZqS1ZbNviGKJ0MBcM9PVYH4c5NG9hz
         PZryZ4LAIuurSVjqpBpmIzg1o+EeVY71fi7ZM8Nm+kkEL6naRKqmRxvOk8fYNbObXMRS
         tIdRDUcJs9Rx4aS3Zz0EJJ2YIbagydtkVLo6JbdT39GcpdCZCcya6JStw2LRjqBd6UMW
         L4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8g/Sz2B6dfkHm3aUVh1pQ0SA3wCemzUiZaJkGBiFEwk=;
        fh=psNhYAQsTBTaLahlj5WPf7OZTQp96jVSuPELLfFGiDE=;
        b=kw1WXbjrY/89vY4q+csfgtvmBK/nwaqvC5pXlfl8H9LzJ2nbOErvtFS1i03aDx1VuH
         nbFe69mGH46YogF5NcmSvZaEFGbzMPE9gloCkAs/GZoGAEGszEQEzseEDfTrUWqhe0Ge
         /JPjK3l+I4yTwOYwERIg6g4ybWbu5lvGx5+MtRfnfnDxg/FcE/OaWLo8TlrAKLZBHwxG
         G6VXEJSgRIQsy+V9tpNhJ/lc7P8IZeLSmVOlYHJqicQNH4YNDfa7cKHi/8bK+faKApjM
         IG+e5ecJ1VtzCjDvImTShGK2axR1PM9gGLkmNyIgOWnp1T12Luw0mvcjeHrqewiqrfO7
         KI/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770656984; x=1771261784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g/Sz2B6dfkHm3aUVh1pQ0SA3wCemzUiZaJkGBiFEwk=;
        b=OMMtwfPxokmIr4erA9uXa5IKJDMvVqCvYFMlrdd/P+VSxURw0Xfq7lcG0p5VbeL+8h
         dJcB7yISXoad+q10Oe+si7KDnBAHModISOIzzonFbKA2AqaGX12jRb14GsKqiraMPGrQ
         /x24vEQnFBtd9gMHBCrc56Koj8g4ubeSfUEPYHsNEOdFnblPfVXoCVQBPHzH0kJg4EWP
         8zKuxiPpR6Y16e3Giw8LCgwkS0X3ZUWZtNw02mCy9pBAc2oV2Uhp1S/1HUTBxSFO/hXo
         5MyvgqbzMeUJ26/yxQvcKPSEOZx8DgL40aMYbAWBBzesMcz7x7NKFCtBPileo5etWq1+
         dFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656984; x=1771261784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8g/Sz2B6dfkHm3aUVh1pQ0SA3wCemzUiZaJkGBiFEwk=;
        b=aXydwZRph2IVd0YFaGRtW1BVGgTr4iaNgUGnjcpVO8/lQz46uAFx/mxinzg3BbHB++
         rsmgGesPl7edwMvAN+TXpS2c2Xant9+OWjrNWW807cT5lI2Ya1WYEU0rIJc0jSWAr+P7
         SHhU12XuINolQ0rFweSwBskvveJ2H+4RhqaFnOIKVHcMIffz5HRoN0Z4Ztd7U35vsE7i
         gBHEAw5jpKZkkac/4HqHqabryjSwVTfsQwlDvQoj6aq2slyfggVICofwICelOQAF+dsh
         FOOM8nn/Olb+g8wG65IyHPRuKaIbuWXg31oahIq4FepLvZhPffMmIse+QRA6X/VheIYm
         wR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVHaTWJW0x2EpafZmBtcAFkjgF6mV4U+BWS2JVMRPjGPpztuNxjqB/w9Z8l07rU+eEwvBdzfdX00sUgJf0Qbn9t1/t8fD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXb+c6vE1lPlOrtIP3X2vAg0B/QF8/lJ+m6nyhEeW9kfoS79L/
	bF0GblplndEpoJnLVhHl2bh37pF6h/wXkqP8LXUHtFWt/AhUxMVZ/NjcbTWDu0ZTbly/nFMkwMn
	8TXfx+3m40Wjp4PSzDDi+ugXkW+8ZXUHem/RtpYDl
X-Gm-Gg: AZuq6aJIml3eQD1luxp4ovHtMp8Lse9yIKdwfiOBolXCGqMvk+qtICHk854/q9dPyxY
	t3C/6IxckPOZsnUZ15AnOX+H4Yi09w8JJwLbRQlkH+IsAlRNdSxRwZGd0T8F77iTAZtUf5tg5gb
	0QTJfx1bMDeP44ojod8/Z0AnO+yY+Zo3cbeSzaoL6JGHvaebWsZRf+/i9UOpiM0FeGWON8z9w3A
	a/qyuWlzQt8IXoVhyth4mnIYdf4swq2lKqXoLkOMH5pDpPOuek9F6rO7o4WYnzRZ9W59ZaeoftO
	DHv16w==
X-Received: by 2002:a05:6a20:4393:b0:38b:dd94:936d with SMTP id
 adf61e73a8af0-393acff6da0mr10644453637.21.1770656984440; Mon, 09 Feb 2026
 09:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119203457.97676-2-gnoack3000@gmail.com> <20260119203457.97676-4-gnoack3000@gmail.com>
 <aYMenaSmBkAsFowd@google.com>
In-Reply-To: <aYMenaSmBkAsFowd@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Feb 2026 12:09:32 -0500
X-Gm-Features: AZwV_QgXAhkJahS5lX2x7F9Z3bi4SFggQTKqzh3gTIRBGye7w374wNJUHDc47-8
Message-ID: <CAHC9VhQvsdmzQcQwpFeHnspySPe3GbwXMMo5tBB2rQzUneO4FQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] lsm: Add hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, Tingmao Wang <m@maowtm.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 5:25=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Paul:
>
> You have previously said that you would like hooks to be generic and
> ideally reflect the arguments of the same function that they are
> called from [3].

To clarify, I didn't say that it is generally ideal for the LSM hook
to reflect the arguments of the calling function; while that might be
a good starting point, we have plenty of examples where that is not
desirable.  In this particular case I said it seems like it would be a
good idea to pass the "type" and "flags" parameters from the caller to
the LSM hook.

> Q: Would it be acceptable to change the hook arguments, if we can then
> avoid passing additional data between hooks through that side-storage?

If you're passing the sock, I think we can skip passing the type,
however, I could envision someone wanting the path in addition to just
the sock, but let's wait to hear back from the AppArmor folks.

--=20
paul-moore.com

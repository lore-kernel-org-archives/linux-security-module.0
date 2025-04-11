Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992D157E88
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744336997; cv=none; b=iXEhrpI6dKtR75mQf4/AmU/PQ02vlSIeaxXQMruCNRDEuq35c9xIc6C1mvwWod8iiFIEHH4slhj3yFm6pIErwEpccWoFbD9F9VlzckBEUZZ2t+HAJyQi1wIzy8Jo5KKeX18mWQsclLHCZh3MJfwuJW8hnUiNy+grs43Iux9hC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744336997; c=relaxed/simple;
	bh=zqEjesBUTEYTYVlDtQa/IjtdZA1mRa+TYQfDTZ3ReAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJI8792k8+tuf3fWMYXcyEG9OAmkYQGA+Ckt1b0uEM7EZGuwH2e+weYP1dwjQNBIGcRvjb8YnNhSNfuKj6/jnyX+UmmFX6C/rX1NqaPZaFh+eoH+14Tx4IbG3MY9q3InmTYVECBu4k/0DYWr6GsCZizdZGdsxhYFY5+URfWpqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DHUXj3qw; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DHUXj3qw"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff0c9d1761so14825627b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744336995; x=1744941795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71tu7uxAZA/EIIjhvgNO5v8HNp2prLZHBB+U6u662Co=;
        b=DHUXj3qwp6yYDAIgq7s0Esd9BVDs58v8agJ6mBGB8A3Oh2ltEX2Ry9DaDf02rvPt2l
         0js2lZIdyNvBRPTsPIayU2nl55XJnUf7anBr46Gb/H4oiL+1jJ4z+f6r2uG8XLcG3GPx
         4y0ed/F8cNw2tlZXuulD1Mkbk43UKExUrrnBWS6DoS6pHz5MEixX4aee1/MJd7E9QRJk
         FnDmFxSG3s511B36uEBpsFknHslGA+U4kLa/BV/q+pVu7EmXJyNBUrm9bSY8tZSf7pS+
         r3pIJVX38Td9dgBJ0Vm+5d5qev1za46Le2R6b6fICp8EaFoue8Kz7xNO/x6gfzCXwlc5
         gttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744336995; x=1744941795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71tu7uxAZA/EIIjhvgNO5v8HNp2prLZHBB+U6u662Co=;
        b=Gv+G/ivijQBLN6cgkfZhymL1ueAySZhvA168WISMBixnhoL7Q/YrTTZLxSQD41zcy6
         wp4o5k8C9+Gc8nLmf2rzVaFHYek+MJMBztB1CFB7iexdFXmSh0qi19uFQgVzZjGHgUUW
         LR28ojX1WrrKKqajigzU343RUImzjyzGHgpty5u6biiyMmBr2780RFNrc/JiBuqyEl2B
         4vLqLcxIbBPWDPGap35KDZPbHift0qjei+/u9STwUEgR4xqgf1lceKaqKvadigxQkvgT
         jMtOPMiVLZ3RLzIOQC8IxbT1bmb1cuAB0MZ1IHgm8icyOUWmTSVPyNUVzsCVOCw1LntG
         +kjg==
X-Gm-Message-State: AOJu0Yyl54SIcR7dulR6h//e3I6vsUGRHkiGoUnf1Ie04/TK0g5TAbJA
	MBrQ2OCrleFjmiiMTEdqo+kw6wESzIGCmo4w5zlYarX4V0aYpjdN4JVHKp6GO3wxBgKx6z57XcN
	DiWHKPwZmylI0Rlk+cbkcT8wnP6A6C2YhJMLl
X-Gm-Gg: ASbGnctCMChxO/4OaCc8N+JuGiqpklRC4nIZnJMGs4wlRhj6nl+Rc38xqJBtXOt1Wyf
	MuWjnVcAOl5pI6Srkixo0djLA1Y9Zlg2LdBbXCtQ1wsVTvCcuCuywDeTJmv9FyeDLTmhSK77Vcs
	yitF++zD+3vtPRLJ4ycZaV3Q==
X-Google-Smtp-Source: AGHT+IHwypwN0hZNSzg0rWDW8ucXd+OV5Nc01KhxSn804XHCAthensOMYlEE+zoylD0D3FlUHrfmKn/1wSsg/GHN8ws=
X-Received: by 2002:a05:690c:688c:b0:6f7:55a2:4cf5 with SMTP id
 00721157ae682-7055998ebdfmr21311447b3.2.1744336995136; Thu, 10 Apr 2025
 19:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-40-paul@paul-moore.com>
 <202504091656.21EEF38DCA@keescook> <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
In-Reply-To: <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:03:04 -0400
X-Gm-Features: ATxdqUFem5rTJOQY6HGG2SozimYzIow7vEVpPQMBYs_4QzkNmDKs8WVPGRFtnX0
Message-ID: <CAHC9VhQ5sTo3z3Dig0Uwt9OxUfdPFaKpFU6k683gZMkcrjgoBw@mail.gmail.com>
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled functions
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Apr 9, 2025 at 8:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:

...

> > > -/* Append an LSM to the list of ordered LSMs to initialize. */
> > > -static int last_lsm __initdata;
> > > -static void __init append_ordered_lsm(struct lsm_info *lsm, const ch=
ar *from)
> > > +/**
> > > + * lsm_order_append - Append a LSM to the ordered list
> > > + * @lsm: LSM definition
> > > + * @src: source of the addition
> > > + */
> > > +static void __init lsm_order_append(struct lsm_info *lsm, const char=
 *src)
> > >  {
> > >       /* Ignore duplicate selections. */
> > > -     if (exists_ordered_lsm(lsm))
> > > +     if (lsm_order_exists(lsm))
> > >               return;
> > >
> > > -     if (WARN(last_lsm =3D=3D MAX_LSM_COUNT, "%s: out of LSM static =
calls!?\n", from))
> > > -             return;
> > > +     /* Skip explicitly disabled LSMs. */
> > > +     if (lsm->enabled && !lsm_is_enabled(lsm)) {
> > > +             if (WARN(lsm_count =3D=3D MAX_LSM_COUNT,
> > > +                      "%s: out of LSM static calls!?\n", src))
> > > +                     return;
> > > +             lsm_enabled_set(lsm, true);
> > > +             lsm_order[lsm_count] =3D lsm;
> > > +             lsm_idlist[lsm_count++] =3D lsm->id;
> > > +     }
> > >
> > > -     /* Enable this LSM, if it is not already set. */
> > > -     if (!lsm->enabled)
> > > -             lsm->enabled =3D &lsm_enabled_true;
> > > -     lsm_order[last_lsm] =3D lsm;
> > > -     lsm_idlist[last_lsm++] =3D lsm->id;
> >
> > I don't understand the logic change here. I may be missing something (i=
t
> > feels like a lot of logic changes mixed together again), but this logic=
:
> >
> >      /* Enable this LSM, if it is not already set. */
> >      if (!lsm->enabled)
> >              lsm->enabled =3D &lsm_enabled_true;
> >
> > seems like it has gone missing now?
>
> It's a little confusing as lsm_order_append() gets heavily reworked a
> couple of patches later in "lsm: cleanup the LSM ordered parsing",
> which is essentially this function's end state from a logic
> perspective.  I think the best thing to do might be to squash those
> two patches ... lemme see how ugly that ends up ...

Yeah, it looks *way* better now with those two patches squashed.

--=20
paul-moore.com

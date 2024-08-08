Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DD1854
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723077024; cv=none; b=Ci4pouusmDBjoisAZJEJgwVYgBFu5/6g+vJhdkLZAP1h0WdUiVu/NEvHqti+jfS7hk/rwDhZmBFVtrxPTs8UkosKJ7RB7uNeuMv/GOIxynHnLO0nLirQuCMFs380+OQr+sOaIANE+0xQD7Vsi8VRbQuNRcCBPLc+ITpC4ywN2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723077024; c=relaxed/simple;
	bh=iiCNY2QBUWUwSqZlkrQQ1HPqESG+wrg91n95gisc08w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ22CHmc7zzpgJk46kHJP/IS96SVKEJGyDgye19I7Fq0DQDwfJvbyC4iZMtMGPB+Q1V/nSUYO58gGEemf0oCyP2tVN5PQ11JL2w3qobB1+zk4VFqHrrAdCBBRN6EJrD4eja8E5Rywkkty26tKsbp2hhyMOBt/DFSmkghPt2CALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VExDZ47h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VExDZ47h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FA5C4AF10
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723077023;
	bh=iiCNY2QBUWUwSqZlkrQQ1HPqESG+wrg91n95gisc08w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VExDZ47hQhy7R7P7NHkzyiRk5LjyI4T1ztsMW3eNX943dLAQs9i0xPvSOs72TIccz
	 wxrKDVpCs9jw6fEDe3T0jdQhXR86M2827zTmuIUflTUUg+bA5AzfPQ+K9waua9/jS3
	 J/sl3Cfp2mNaOK83rfxUjRgQ++aYYzbwvbHaxevaow0JsinihFBudy/r4sHrZPmSX/
	 RC5cMPAdDIA+jHlcsj873wOrqCAd2CMFI+EUksCe9/5bZPllIVtdgcjD2HCIZKUiDm
	 /4dNTMG2xknSVcHTZqZsYDME3OQ1oGRAvzRCY0x9GA156bfsytXnmft6POPoIE08M+
	 bN8SWZeta1LQw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso383230a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2024 17:30:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEcnq2Z6Osu97mXRBGDF0Emod5uXnHsn7QCUCZFsmd6LlqeBnIhkxCNihg+hDix+rnX/EWPaOIdeTjeIi5iiGrZsB50iZ10iunWIYNufZdeYNWRLaV
X-Gm-Message-State: AOJu0YzR3eFdTq+nnY+8Mznxltayeh5Ic+00FtVU8LEL9YVKHWCdWhqc
	mOMH64vJQXwL5NCji/z/Ea7e/hdE9DMKJLnOHO3GKyJTEB4Dz0AsjE8pHj+kb02tSIxqf9aJHWq
	mbGRIb/CgUSGS6S4Uv62Z1FqoR9T/WwcZBIaS
X-Google-Smtp-Source: AGHT+IE9oiF0Bgy0abRiyRY2CsX584UeKCcOeO7D/xyuQQyxUaKmgd6Rn02WdW8/ZCgsxnPB7SY6DqtvfhDfy29ORdU=
X-Received: by 2002:a05:6402:5cd:b0:5b6:d0f1:2947 with SMTP id
 4fb4d7f45d1cf-5bbb234cff9mr211960a12.34.1723077021999; Wed, 07 Aug 2024
 17:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com> <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 8 Aug 2024 02:30:11 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4PuOi+iUd-CO8LwwJ_RWGATo0bvZQZJwSGqyCcVqc6fw@mail.gmail.com>
Message-ID: <CACYkzJ4PuOi+iUd-CO8LwwJ_RWGATo0bvZQZJwSGqyCcVqc6fw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:44=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Aug 7, 2024 at 6:45=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@k=
ernel.org> wrote:
> > >
> > > ...
> > >
> > > > > For what it's worth, I have not noticed any issues in my -next te=
sting
> > > > > with this patch applied but I only build architectures that build=
 with
> > > > > LLVM due to the nature of my work. If exposure to more architectu=
res is
> > > > > desirable, perhaps Guenter Roeck would not mind testing it with h=
is
> > > > > matrix?
> > > >
> > > > Thanks Nathan.
> > > >
> > > > I think the additional testing would be great, KP can you please wo=
rk
> > > > with Guenter to set this up?
> > >
> >
> > Adding Guenter directly to this thread.
> >
> > > Is that something you can do KP?  I'm asking because I'm looking at
> > > merging some other patches into lsm/dev and I need to make a decision
> > > about the static call patches (hold off on merging the other patches
> > > until the static call testing is complete, or yank the static call
> > > patches until testing is complete and then re-merge).  Understanding
> > > your ability to do the additional testing, and a rough idea of how
> >
> > I have done the best of the testing I could do here. I think we should
> > let this run its normal course and see if this breaks anything. I am
> > not sure how testing is done before patches are merged and what else
> > you expect me to do?
>
> That is why I was asking you to get in touch with Guenter to try and
> sort out what needs to be done to test this across different
> architectures.
>
> With all due respect, this patchset has a history of not being as
> tested as well as I would like; we had the compilation warning on gcc
> and then the linux-next breakage.  The gcc problem wasn't a major
> problem (although it was disappointing, especially considering the
> context around it), but I consider the linux-next breakage fairly
> serious and would like to have some assurance beyond your "it's okay,
> trust me" this time around.  If there really is no way to practically
> test this patchset across multiple arches prior to throwing it into
> linux-next, so be it, but I want to see at least some effort towards
> trying to make that happen.
>

I did add Guenter to the thread, but really, I cannot offer more
testing than the configs we use in production. I don't use GCC as we
mostly use clang, and we don't use early LSMs which is such a special
case with two extra configs with lockdown. Calling it having a
"history of not being tested is unfair".

If there is a general process / tests you follow before merging
patches, I am happy to run them. In the absence of that, it's not easy
to spot corner cases.

- KP

> --
> paul-moore.com

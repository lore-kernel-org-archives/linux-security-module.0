Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7496155A5B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074252; cv=none; b=m6iYEyGLSmIyWNQ5HltQObiukkume1QIlqXAeu6MRrq8x6Z93UhULCKYjmyoQNWMr50cx9Ud8NlG2p0ocmePjHwdFsepOjuZPj5Ywf4o9+G0rNlA7z6nqfljCBZW7o9SuYsxlCsYQIngHhWkZQZ1zL16LaZhYzT7qJBL9XgTsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074252; c=relaxed/simple;
	bh=qDQiKEv6k9UML3kamA1nH5tNqN81EHmMEWsFVFxtecI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoTrid5ig4xtsTYafQR3rgav0Mlo8tXZn9P47WBUGGe4Bfe+E0BPH1p7Q28HQJxPNE6qbHI0B/jdsyCYTA3Mw7WIBvtw330MX9y/lywpnFMivjxqFyr3v9nnUtb4wineBgBr07Ag7oSybcQkOXg9fyk46I/TnwWQnCTuibei9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bxHDZ1PF; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bxHDZ1PF"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso364482276.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2024 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723074250; x=1723679050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dX9h7u30CCZYgKeYGhflIbAKtLicQOaB5Q+NrRVtTA=;
        b=bxHDZ1PFApFGr8g5xcakA1kcqZ3e93oPwpgcXQFluQ41jf29IDrhdB9nD5UVcK4sCD
         I474DG5yoEy9YbRRPHpw103Ou6SR4BLJ86Flp85ryYQR8O/qd/Q2nOO0rUcBPsrT3oix
         Hr9Lflz44BZm7Z7zI5Wgr60tkyvtIx2c4EBoSxKit92ieddSHJMkKyebaEMGtfOoPefZ
         M9dk9hVSwqgAfJ66eez56sLggO+6Me5juSy4SJ03w2vgyQc3quWBoDs8Fb31PV81Wtsm
         dgkEpt3N6e55UdnwcWWtDqzsTjB0hHoY9Qu/XainbK3QaMdXpRMQV9X57T/z8QopGmR8
         QyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723074250; x=1723679050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dX9h7u30CCZYgKeYGhflIbAKtLicQOaB5Q+NrRVtTA=;
        b=ljnS7+D+GMOH5jy4rAsbbkiYFOrkpzoWGvo33cx+7fybs3Mf+OHYWX1zs3c7zwQ0p3
         u8KRe5C1FlaH//oGB55eo156KC5mcOtJ5WXDLpW1Wr8F4HhFTF4BBkQgXdP1W91YZJf/
         jnrO7bz2lmYrVx+6P9JwlDKt2UoZa4gcVUE4HRcB7vu0EGMi6+jY1UGxHyYcDhPrav5Y
         sli3lX20LIt+JzuaFiJGRAAT3CgBQ9/tMPBG3nEEGb/jQApwHh7WFeNRAecDJhwEJISC
         o24Rth1I/YwI+z3BGSYFm+/L1qj80375ZecUu/06EMxgZOFVX57xc6i1NyAiSfenv5Hi
         nWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFb3SfmCFZfXyu9LS9qopq1CFHaKqSA/nHHxlvMzDMgn/q6XsTjerewO1ori8dcqd42KiOllvde2IZo4piQUYKRALxRK/kHMwNeviN7V8pwdevmv1
X-Gm-Message-State: AOJu0YxVlJRNjEg7m5+k7svXEnCb6Ssw3eEHnNrAXQqa4xP9DNdCxPfg
	EztvaWRMSjOxsVGOAfbjb1yWBD80BlEtzt9Fvmlv18p4MLoEoVtgqs+czxhNWD7cR6jUya4KOBf
	nD40TohTIfKP1Yx0GSJXsmV3VytHoO5wVCT83WcbaV++Os6GORNOB
X-Google-Smtp-Source: AGHT+IEHjqPNJl4NBLXpmlk8UH1R7GzDMR74vtPfZk/5xC8XSotD1uI2NHd2yLQyMszK3pEoXURs00deXIOJmJ8ZyXM=
X-Received: by 2002:a05:6902:240f:b0:e0e:499f:3d88 with SMTP id
 3f1490d57ef6-e0e9db13681mr250205276.26.1723074249935; Wed, 07 Aug 2024
 16:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com> <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 19:43:59 -0400
Message-ID: <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:45=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@ker=
nel.org> wrote:
> >
> > ...
> >
> > > > For what it's worth, I have not noticed any issues in my -next test=
ing
> > > > with this patch applied but I only build architectures that build w=
ith
> > > > LLVM due to the nature of my work. If exposure to more architecture=
s is
> > > > desirable, perhaps Guenter Roeck would not mind testing it with his
> > > > matrix?
> > >
> > > Thanks Nathan.
> > >
> > > I think the additional testing would be great, KP can you please work
> > > with Guenter to set this up?
> >
>
> Adding Guenter directly to this thread.
>
> > Is that something you can do KP?  I'm asking because I'm looking at
> > merging some other patches into lsm/dev and I need to make a decision
> > about the static call patches (hold off on merging the other patches
> > until the static call testing is complete, or yank the static call
> > patches until testing is complete and then re-merge).  Understanding
> > your ability to do the additional testing, and a rough idea of how
>
> I have done the best of the testing I could do here. I think we should
> let this run its normal course and see if this breaks anything. I am
> not sure how testing is done before patches are merged and what else
> you expect me to do?

That is why I was asking you to get in touch with Guenter to try and
sort out what needs to be done to test this across different
architectures.

With all due respect, this patchset has a history of not being as
tested as well as I would like; we had the compilation warning on gcc
and then the linux-next breakage.  The gcc problem wasn't a major
problem (although it was disappointing, especially considering the
context around it), but I consider the linux-next breakage fairly
serious and would like to have some assurance beyond your "it's okay,
trust me" this time around.  If there really is no way to practically
test this patchset across multiple arches prior to throwing it into
linux-next, so be it, but I want to see at least some effort towards
trying to make that happen.

--=20
paul-moore.com

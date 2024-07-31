Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B439FD6
	for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457769; cv=none; b=LUDXg85xuBTuocLsmQW8OigPpIiM/uLGoWmPzpKITLI4djMQ0oF2y0sMMtZZusQ2dLV3iCNGP3LRWuka/E2l5xGV+QY0IDeTQ4JbvF7HWhdwlSJcdayDj4WmrAZ60i+HInCrW8ENYICjXdw17jRE8Q81MThFy6SXGKogrd8F9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457769; c=relaxed/simple;
	bh=55Y2FiMTrimrMXILYu++IX6+eHQpPUGeTFOVYaQNTmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgkH9N4BQIf9WtARy1WKKgUudYNXMr4lhjWhqSL5ow0J1IPg+qpwtUAdSNnrDc72KoZFR+Hj+I0gtF4iyXB443zUBCBqlIEQpPooUziQzmzvVkYEH4DqHLajQ4FSvxErTjydsyolskPRcd7nZ7E3phA9wVC3qyRjYNAml6WzhfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dy+5Q9Mu; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dy+5Q9Mu"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e087264e297so5134831276.3
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2024 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722457767; x=1723062567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSX1c8Ru/j8yxo/auh47ofyUjGotjeSFELYrAnjtnVo=;
        b=Dy+5Q9Mux2ZsOfD1GqlkaSzT/PqVOBeeKfhR1reRfMuPCSW2uUIcTgHX+gfKkZfeyS
         p68xfw5+GU61gSQw9LlgVjmsFnNfy/yzq8rjr8XF5N4sK9GLgJREhv3OmteOn29PSwnZ
         WUDOXtPFwvhk6RKtaqMJtW0MMDYvO3ROxg4YhBqxu7QqhGgDPHPZCrsiE3x3nvlOH3SB
         UEZ7w6P63cTy3fmuBZgbROAZA5EJdLH8lN2NAOD2PD6R50AzxyihNh1Bm53nuafY8aNr
         7uLSVR7FKuPpvhGZALj8AD11rLZm/hpCzUAAV4ELQy+cC1Lpj8zNWvrZjI9c+gRTXzdB
         PYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457767; x=1723062567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSX1c8Ru/j8yxo/auh47ofyUjGotjeSFELYrAnjtnVo=;
        b=vjwEaA45gBTd1EoHH0RPDY+jztqfOqK0BozkuQcp0t1qIKc83TdqnEmSEamch1jjBo
         Hk3+mX2uKZV4kd1ebFBBaIXXizzmvBJS5n/hryKjqfk0U1+7jNgAUETMYZvfE6RFzAqP
         L+6S6h32H6VNNe8O+eUJV9vQzZM4GajDWGU5Kh62ZPdx7PGzsGWXT2WH0UfEPLZEWynU
         X9BLx8Y4kUeUOTYq7wufdf0y+nR5RBS1iRk018SzauRx8YcEQrT+SOInKHiHKGl1HBgu
         E1sk57mDw0EjvjGqyUHzi0po9S6UPfML8WWxSO4sX0LdsyPAwSVS0M6dgP2HEEhMMCel
         FH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYIeCKp977zB1T9CI95+dkuOBT9JC+mAbjwFdGWfsCpPDTmnmfI57y3CmM1u/8eInp90ut2oHnrcYg7y5r9M/mWTdXa8tpGT55sdQJ0MQsVLDoMChg
X-Gm-Message-State: AOJu0YxE/AyDeN+FVrHCv830o4z5yBQqJ1ORwHIK4EzjONGXT8BoyWsu
	128jQBJEMYWG0eRcSg0ecLp6tVYxhjswkWNitg7V7yfowzgW8UnITwuTqiXZKZNd05Qb8WJi02E
	PHX6WCb8+YKGICoTHWDQEDwoIgiVjXJEvpdxc
X-Google-Smtp-Source: AGHT+IFx10AYMBAygpAsRMReCo80r71LTCsmoGAG8m/NF9tKd5CFmX1RfasNmH6AK1pKP7GjMtINChhEtHlz600Jia4=
X-Received: by 2002:a05:6902:210f:b0:e08:655c:af14 with SMTP id
 3f1490d57ef6-e0bcd3fdbb9mr165982276.36.1722457767336; Wed, 31 Jul 2024
 13:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729125846.1043211-1-mic@digikod.net> <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
 <20240729.cho6saegoHei@digikod.net> <CAG48ez1=xbGd8az4+iNJ_v1z4McMN8dsvWff-PH=ozLYnbzPqg@mail.gmail.com>
 <20240729.rayi3Chi9aef@digikod.net> <CAG48ez2HdeKXwwiCck9cvcoS1ZhbGD8Qs2DzV7F6W_6=fSgK5Q@mail.gmail.com>
 <20240729.roSo6soogho8@digikod.net>
In-Reply-To: <20240729.roSo6soogho8@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 16:29:16 -0400
Message-ID: <CAHC9VhRmZOMLwY4AvV+96WU3jyqMt6jX5sRKAos75OjWDo-NvA@mail.gmail.com>
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to ptrace_may_access()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Mon, Jul 29, 2024 at 05:06:10PM +0200, Jann Horn wrote:
> > On Mon, Jul 29, 2024 at 5:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Mon, Jul 29, 2024 at 04:21:01PM +0200, Jann Horn wrote:
> > > > On Mon, Jul 29, 2024 at 4:09=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > On Mon, Jul 29, 2024 at 03:49:29PM +0200, Jann Horn wrote:
> > > > > > On Mon, Jul 29, 2024 at 2:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > > A process can modify its parent's credentials with
> > > > > > > KEYCTL_SESSION_TO_PARENT when their EUID and EGID are the sam=
e.  This
> > > > > > > doesn't take into account all possible access controls.
> > > > > > >
> > > > > > > Enforce the same access checks as for impersonating a process=
.
> > > > > > >
> > > > > > > The current credentials checks are untouch because they check=
 against
> > > > > > > EUID and EGID, whereas ptrace_may_access() checks against UID=
 and GID.
> > > > > >
> > > > > > FWIW, my understanding is that the intended usecase of
> > > > > > KEYCTL_SESSION_TO_PARENT is that command-line tools (like "keyc=
tl
> > > > > > new_session" and "e4crypt new_session") want to be able to chan=
ge the
> > > > > > keyring of the parent process that spawned them (which I think =
is
> > > > > > usually a shell?); and Yama LSM, which I think is fairly widely=
 used
> > > > > > at this point, by default prevents a child process from using
> > > > > > PTRACE_MODE_ATTACH on its parent.
> > > > >
> > > > > About Yama, the patched keyctl_session_to_parent() function alrea=
dy
> > > > > check if the current's and the parent's credentials are the same =
before
> > > > > this new ptrace_may_access() check.
> > > >
> > > > prepare_exec_creds() in execve() always creates new credentials whi=
ch
> > > > are stored in bprm->cred and then later committed in begin_new_exec=
().
> > > > Also, fork() always copies the credentials in copy_creds().
> > > > So the "mycred =3D=3D pcred" condition in keyctl_session_to_parent(=
)
> > > > basically never applies, I think.
> > > > Also: When that condition is true, the whole operation is a no-op,
> > > > since if the credentials are the same, then the session keyring tha=
t
> > > > the credentials point to must also be the same.
> > >
> > > Correct, it's not a content comparison.  We could compare the
> > > credential's data for this specific KEYCTL_SESSION_TO_PARENT call, I
> > > guess this should not be performance sensitive.
> >
> > Yeah, though I guess keyctl_session_to_parent() is already kind of
> > doing that for the UID information; and for LSMs that would mean
> > adding an extra LSM hook?
>
> I'm wondering why security_key_session_to_parent() was never used: see
> commit 3011a344cdcd ("security: remove dead hook key_session_to_parent")

While I was looking at this in another off-list thread I think I came
around to the same conclusion: I think we want the
security_key_session_to_parent() hook back, and while I'm wearing my
SELinux hat, I think we want a SELinux implementation.

Micka=C3=ABl, is this something you want to work on?

--=20
paul-moore.com

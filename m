Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB502155CBA
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265612; cv=none; b=FHKIZpnH9m3uTzv0TqSvjRPWFCk4wcE/+fRC/kTm6/SthtIPKl+3icneVBMmC9Cf86v7tk4WbS/kzC5/u4F789Z8IYvyMce6XC+pjaY1yvq2/U6Awjaw1i5TI8oIoLc/atvnaf+1DCgLMs4bkJhTELvby9zyQ8fJby9RzatLYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265612; c=relaxed/simple;
	bh=781BTajwd1hR5wMvp7cNX2jVIl1+v4PLz5QlLHtL65Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5vu/FNwZR5E/eS5I0voqoPotIvWzkRjS6Bs9kRZlgysWDp8fQ2SfmN7jAfMZ5M4anHQb4hreDOzKxSclZG22Z5lh2dji+85h2eGDFTrBKdmufplHNpVnWDmkPRQhTPVCHXlGPLk48401qj/EzrLNakH1pwYylPxQAIWSdOM36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eY+PTrMO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eY+PTrMO"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so14351a12.1
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722265609; x=1722870409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjeV+QbI7gHUjUzBxliN0skQAqi9SzoY7gAurGQjZfU=;
        b=eY+PTrMO3YlPC5ImRAFguy1j2nwObF8c+R5wgsRaTx6QMj2pgakQzJblyBHjF5iZrs
         qEnxDZASnU7ydfA/oFwDqRMfRxeHxLIUWMGUIyM+ugv81XCFt+l/WVpV4oCP4ucj0ZIB
         gu2TYI8J8AQqZK4YFrIBvrpnmKg0aNa2QlaDuf5uc2zwoCwhK9ZZi6q4GlBc8bPpMYzG
         fGnYozhSbWZ9XA/nmbAM7nJhqoJi8VPck51WY/gMufuVsE8LcNLYprDjWrqwkO35cJgd
         2L1kH3hoImgZsPPlF0KKzCxwp+s4X3HOTX0H6pY9osuYRCpnBVwVErnpcesi4qTaxS3y
         A0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265609; x=1722870409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjeV+QbI7gHUjUzBxliN0skQAqi9SzoY7gAurGQjZfU=;
        b=v8gyIsYdZZ0KeOip35qsnpacZc77qvODUOoCGoo/1F1qzjgmuwtdXMEQPElSSSuBDq
         f8M4HQUspPmF1cQbYNpEZiHEabFwCEvTH/FN/06/vUAvw4ulojk71tf3y5EgFEiT9PXg
         p3qcZqmCFbOz1WJ/A3x5+0tPvLWBC/W4y6qsFoCyO9uFO+FvX1iHO5IaPHuZGKUDX62X
         bOyCWXLlbY1XTFlJsHoD6kDWbxBn9WIquc0yTtAqAQ2zHm1giKFbtpsLwE3B0H/3fmvO
         aWEB2K3sOuOhLC/Y30XQz2Gfu8P07AJx9uYQzZp+1eZ/Bfc677IbYkth4T5o178ypiPk
         hN8g==
X-Forwarded-Encrypted: i=1; AJvYcCW1smGysnVTlMT/VbU3QD0K3pOR8CDwNl5nydXXarxrSP3ix648OAdXSleqD4P6xIsu9eFDzpVIbmKn48eNUauxhi1UNiCIxkAfzRK77ytRuH3TqXes
X-Gm-Message-State: AOJu0YzzGHoBTv6v8IHM2u74eBq8d7KjsjpLqnBiy/rpTckRELOiE20/
	JkU7rt0geaPegqZ6dpGAUmwlVUp3ihgCjuEBBIGKqGJCinzOLAMVWPhsVnBQ2sAw2Z7z/RSxfT2
	fxJsufmgK1WKIqIb8ENYQIn6Qdwb3GpXWnOLh
X-Google-Smtp-Source: AGHT+IH/E3Ay7rs5IsVTjtz/VV0d41Am4qW4KdRIkN3yQqDjl1N+gfsf12Fmr2lEmADi+ZEOo8Nafsdq91obb/8Gjzo=
X-Received: by 2002:a05:6402:50cd:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b40d96bac1mr6385a12.7.1722265608535; Mon, 29 Jul 2024 08:06:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729125846.1043211-1-mic@digikod.net> <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
 <20240729.cho6saegoHei@digikod.net> <CAG48ez1=xbGd8az4+iNJ_v1z4McMN8dsvWff-PH=ozLYnbzPqg@mail.gmail.com>
 <20240729.rayi3Chi9aef@digikod.net>
In-Reply-To: <20240729.rayi3Chi9aef@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 17:06:10 +0200
Message-ID: <CAG48ez2HdeKXwwiCck9cvcoS1ZhbGD8Qs2DzV7F6W_6=fSgK5Q@mail.gmail.com>
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to ptrace_may_access()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Mon, Jul 29, 2024 at 04:21:01PM +0200, Jann Horn wrote:
> > On Mon, Jul 29, 2024 at 4:09=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Mon, Jul 29, 2024 at 03:49:29PM +0200, Jann Horn wrote:
> > > > On Mon, Jul 29, 2024 at 2:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > A process can modify its parent's credentials with
> > > > > KEYCTL_SESSION_TO_PARENT when their EUID and EGID are the same.  =
This
> > > > > doesn't take into account all possible access controls.
> > > > >
> > > > > Enforce the same access checks as for impersonating a process.
> > > > >
> > > > > The current credentials checks are untouch because they check aga=
inst
> > > > > EUID and EGID, whereas ptrace_may_access() checks against UID and=
 GID.
> > > >
> > > > FWIW, my understanding is that the intended usecase of
> > > > KEYCTL_SESSION_TO_PARENT is that command-line tools (like "keyctl
> > > > new_session" and "e4crypt new_session") want to be able to change t=
he
> > > > keyring of the parent process that spawned them (which I think is
> > > > usually a shell?); and Yama LSM, which I think is fairly widely use=
d
> > > > at this point, by default prevents a child process from using
> > > > PTRACE_MODE_ATTACH on its parent.
> > >
> > > About Yama, the patched keyctl_session_to_parent() function already
> > > check if the current's and the parent's credentials are the same befo=
re
> > > this new ptrace_may_access() check.
> >
> > prepare_exec_creds() in execve() always creates new credentials which
> > are stored in bprm->cred and then later committed in begin_new_exec().
> > Also, fork() always copies the credentials in copy_creds().
> > So the "mycred =3D=3D pcred" condition in keyctl_session_to_parent()
> > basically never applies, I think.
> > Also: When that condition is true, the whole operation is a no-op,
> > since if the credentials are the same, then the session keyring that
> > the credentials point to must also be the same.
>
> Correct, it's not a content comparison.  We could compare the
> credential's data for this specific KEYCTL_SESSION_TO_PARENT call, I
> guess this should not be performance sensitive.

Yeah, though I guess keyctl_session_to_parent() is already kind of
doing that for the UID information; and for LSMs that would mean
adding an extra LSM hook?

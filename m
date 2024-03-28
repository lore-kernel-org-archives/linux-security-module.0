Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E609137C3D
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645630; cv=none; b=BQTlz4rzh5x640kguFgUzCy4UBKxnXjNre2iWrOK68Uh3Ng01Rrh1pqu0JDwU/IDVysLAtuT7UrPOUMuAkV7jqHqPotkdWGcbEf3PXpq22Ezboa7LlOK9PcNNCTjpfWGpNDsxf/pMJg/qXFphE5PIbrZnNlEnxzbf0y8UfKTaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645630; c=relaxed/simple;
	bh=RT2a3Bdv5hWixMPHbx2jUxcYJSPoofEnOgS/q+iAklo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa0AIBSTBZdFOOgZBa9VqpJM9KHz4OB7L9DnY13FNMvbuUzszFLTKvlhpLBqqYt9Wk51acIUj+j9tVIhk0elZeGHJzfJ1/H/T0pea8KTs+k5NIfqAQ12k02j/oiwIBYkRPl1MxsiQvPnTPBbVG21G4Dt/6cUlnWCDMJEAw2VssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hn8bkZFr; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hn8bkZFr"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc73148611so1287178276.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711645628; x=1712250428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/9NUgj0N+dhsgqOBL6TaIVx6GIGwNMflW6DF43oEXw=;
        b=Hn8bkZFroaxIYyYv5TEijJDxTt4XPqqvs7pGC4GDk+Oij0QoWAT4KGZDwgj0YpV1CF
         fsmcxpW7mKgw6NAC2MT199wifGEfD2UYG4UYshziWVktoMUyJr6wvejvDMA5yfXfXpkw
         KY+MCVpoDev7nM/jBeWUGrGyHPQyq8j3kDVFCDprJCSZg2JnhddmCf5e1XtZpdsDWyH/
         dqi0Gt3bPQUD1+M/VgfkcOVT/+RUnnp7MQKnTNlkjNlZdjVCfHglLcZluXEKjtSkWPfA
         LPTw7M80+AobHQDD44rUdoFisc21kQqnvwbBw8goIX/wrdVm2lo3z6MRppuifBRYNn+0
         bnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645628; x=1712250428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/9NUgj0N+dhsgqOBL6TaIVx6GIGwNMflW6DF43oEXw=;
        b=skK8DFuI0VVXyU1Awcp1R39LrIWHtzM2pFN6dY5E3UvKJ85R1CzE1vVMM14F7atWaL
         vj8GdA6CbP7tYxDGv3TMNGDzoTmNloKqQV8KIOf/oik7BzNca8jgFVRSY+cjkUZvb0s8
         ykLxXcmzrIeQ4EHVRkcugr/kGifeElfRmfBShbvrEIQqqkxTgIixybst8bWHdHk/qc3S
         vSv6gHZvHpm0NgQRGbJ2TWorPeK6agLBAju8knXpSfl+t1LwQiXuIZBmfg+JctcsgvPU
         UO9kwxgPIKGFg6lUc2PTfVm6+j6REiO/U+yLMzo02JoXYXqXSwh/llMZ7WiTiLgT1xgv
         fz3g==
X-Forwarded-Encrypted: i=1; AJvYcCVYZ2bc27Z3aC1Wj1EeqHvkyGZ3HNhlhDO4YYouSFy2Fh5woSNAFpZ6MNxIFEVWsdhyPvMDO+3agFte11kL7k1u08WBgYtEPlMCQ3JLqZOn7jJ8UXAJ
X-Gm-Message-State: AOJu0YxRcoQpErgUU4/DdLNmLouW+S4SEXiSG7x19FOjLlu39dtz9d/h
	IbJO5J+5jdY2SK75x+c1gAfSVdNqjPFUS2oYXglUbPl1AIvqU5OXzCKUckP5uRp/1YJFqtzZPm6
	OnKqIK+axsgWd5pnYlCZNgylFgrAQP6XBBIuq
X-Google-Smtp-Source: AGHT+IHo+aMKDPWz42mJx5B+i5mcV3g7qEF3Qg44xH2L+OwF7fF86jCgM01cVT0r+ZdiP6L8VMqVdjc3rKEXYeCNlfQ=
X-Received: by 2002:a25:1608:0:b0:dcd:1436:a4ce with SMTP id
 8-20020a251608000000b00dcd1436a4cemr3336294ybw.23.1711645627690; Thu, 28 Mar
 2024 10:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-11-gnoack@google.com>
 <20240328.ahgh8EiLahpa@digikod.net> <CAHC9VhT0SjH19ToK7=5d5hdkP-ChTpEEaeHbM0=K8ni_ECGQcw@mail.gmail.com>
 <20240328.mahn4seChaej@digikod.net>
In-Reply-To: <20240328.mahn4seChaej@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 13:06:57 -0400
Message-ID: <CAHC9VhS=ESSCK6TiTXbqDmvDUwPa3UFBN7ZaJogmj=Qguc_m2w@mail.gmail.com>
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:43=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Thu, Mar 28, 2024 at 09:08:13AM -0400, Paul Moore wrote:
> > On Thu, Mar 28, 2024 at 8:11=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Wed, Mar 27, 2024 at 01:10:40PM +0000, G=C3=BCnther Noack wrote:
> > > > Landlock's IOCTL support needs to partially replicate the list of
> > > > IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> > > > do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policie=
s.
> > > >
> > > > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > > > ---
> > > >  fs/ioctl.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > > index 1d5abfdf0f22..661b46125669 100644
> > > > --- a/fs/ioctl.c
> > > > +++ b/fs/ioctl.c
> > > > @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file =
*file, void __user *argp)
> > > >   *
> > > >   * When you add any new common ioctls to the switches above and be=
low,
> > > >   * please ensure they have compatible arguments in compat mode.
> > > > + *
> > > > + * The commands which are implemented here should be kept in sync =
with the IOCTL
> > > > + * security policies in the Landlock LSM.
> > >
> > > Suggestion:
> > > "with the Landlock IOCTL security policy defined in security/landlock=
/fs.c"
> >
> > We really shouldn't have any comments or code outside of the security/
> > directory that reference a specific LSM implementation.  I'm sure
> > there are probably a few old comments referring to SELinux, but those
> > are bugs as far as I'm concerned (if anyone spots one, please let me
> > know or send me a patch!).
> >
> > How about the following?
> >
> > "The LSM list should also be notified of any command additions or
>
> "The LSM mailing list..."

 ;)

> > changes as specific LSMs may be affected."
>
> Looks good.

--=20
paul-moore.com

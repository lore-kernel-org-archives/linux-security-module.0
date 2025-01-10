Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E9B661
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736482308; cv=none; b=qYGrIsUvCWkK6fDPlS/VYSQA0xSx2adN+TV3YLivLqUIDQKRdVJf4A/ZasB3Tmc8TOdbLEonWWYZllqADQsog4Dm43G8Rh8nJX6wiO/sVPtWWIWcXbKh7mYZrp7EXfJUrpcp1+eKH5ei8EmgTgAFDjnlLZxjeJJI5gxp729tzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736482308; c=relaxed/simple;
	bh=JqgvAn80P9/B+O4aszNh3FyXqN4DPoeTLBHo4Vxy4OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiD6KKrmBxJqEgy9QJ543K9+dJn75Ejj7ZqkcW8QCR0ItcsWnMAVrUHe0qz69ObirAHvtSz32ANsaLyDylIKjEHTIgq04T7QBJ+2kzQrpIa/DIhNdpwO4RSYpD1/LjsK5tyuTVYOmhY5CtkY8vsnqlAQPXuT7dhvAzSDCobQfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R90Dshec; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R90Dshec"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e1597e3b4so472287a34.3
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jan 2025 20:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736482305; x=1737087105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm5KJeCuva77tHLLZ6/+SmgRih/rGG3E/RNdy1qaLrQ=;
        b=R90DshecezGDSN/3LRQMv9/et0O2xe4AcToIRwS/f4/Nb4H7qz9K/b8FiqdUfgBYi3
         jTAe+KHbrXJWOy8f15g7eG/C0q701EGsERZl8EQfogtJwkjUnFghJYEQHzUTwU41Y9Bd
         sLXRS0vHZyqdKo64nfLWtLMSdnX5cNiz+ZNWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736482305; x=1737087105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm5KJeCuva77tHLLZ6/+SmgRih/rGG3E/RNdy1qaLrQ=;
        b=sM557cN64GyITZlAPgeX11fNyIP+PqjWEYhoReSlEYnRUmjB+Nf9mgvKzRLxDiKKhX
         Z2bhxl0Ig/g/VYqHvTmYQYH6Uv1kYqXUStroTh86G+zrOTwRcuUUdzqSUhu/Wen8kDwq
         cPdVC0WACou89qIaL9YRt7otto8lYp6mjVhv4kQOw49wntcUPUg/vitq3OLp3UZZkAt9
         dXNg0OwpPSqZ2QerQ9nsMcGsr+UV/Ukw/xdpCn2JLoy13DEGblOqUU8/QlaSoSA9+Q5A
         YSdd+DjFjCc12ixZLk3XSnpqXQQAWbzsx2FyRG9XCdEOkftzbsPr4MF2Es9vj3QN8nIS
         RdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV11XQ8Ar/Q2iTflqeLGdIL1XelTun9e7Ulh5aBDW2yRtyVnRlyYUD7rgPD30e7U+9/GJ24k72lKqxQRSM8IuqKIcyofZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjGIXNpjsapmvNl/aYxQEAdUJJof1M3Bm112BCMVNisaSZtFP
	uNUgVT7A3XeS0yGxfTdJeodHTJg2oWgwARUIfUfE9pbliM9evjQoywFb8OnEHaBGVcVmv76Uq8i
	P4eerSLRiSpfrevKr+APentO9nV1QZeN5NGuL
X-Gm-Gg: ASbGncsaWW+d+vG7m/5xMid3j6dSlRm6bOoVO0sNmRUC0Ybj2dpAN2bbEc0VJAW9zdw
	sG9TIV0OopWd/ESIP9ty7ttJiIcPcFwtXeqpMf7ovbA0McR36l3P3XJp7thbvFQv5
X-Google-Smtp-Source: AGHT+IHpHndbWLn+i9dBwcUBPXjDIdNjkYfEUFj6WhDqLmfEf8XRRzYCes1BuwP8mcWgQcsl22EWAcZhE8ka2IyBvgc=
X-Received: by 2002:a05:6808:3c47:b0:3eb:4a36:8744 with SMTP id
 5614622812f47-3ef2ec68ca7mr5595091b6e.17.1736482305436; Thu, 09 Jan 2025
 20:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231014632.589049-1-enlightened@chromium.org> <CAHC9VhTHviBcqhC=iOgD0R2Z4XqQifd-F1NysaX2C8oaF00oXA@mail.gmail.com>
In-Reply-To: <CAHC9VhTHviBcqhC=iOgD0R2Z4XqQifd-F1NysaX2C8oaF00oXA@mail.gmail.com>
From: Shervin Oloumi <enlightened@chromium.org>
Date: Thu, 9 Jan 2025 20:11:34 -0800
X-Gm-Features: AbW1kvZnAU0-j5XCsfcQahLuj8UEkaVkwn6ADPEyU0YLURxg_dGu1DD4NjEAy1c
Message-ID: <CAMb9sTj5qp3fxba8hRpUHAB5ShTXL7XgxebS2gihPpJTFOCxpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add loopback/bind mount specific security hook
To: Paul Moore <paul@paul-moore.com>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, gnoack@google.com, shuah@kernel.org, 
	jorgelo@chromium.org, allenwebb@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback Paul, the latest patch should include the
recommendations now.

On Thu, Jan 2, 2025 at 9:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Dec 30, 2024 at 8:46=E2=80=AFPM Shervin Oloumi <enlightened@chrom=
ium.org> wrote:
> >
> > The main mount security hook (security_sb_mount) is called early in the
> > process before the mount type is determined and the arguments are
> > validated and converted to the appropriate format. Specifically, the
> > source path is surfaced as a string, which is not appropriate for
> > checking bind mount requests. For bind mounts the source should be
> > validated and passed as a path struct (same as destination), after the
> > mount type is determined. This allows the hook users to evaluate the
> > mount attributes without the need to perform any validations or
> > conversions out of band, which can introduce a TOCTOU race condition.
> >
> > The newly introduced hook is invoked only if the security_sb_mount hook
> > passes, and only if the MS_BIND flag is detected. At this point the
> > source of the mount has been successfully converted to a path struct
> > using the kernel's kern_path API. This allows LSMs to target bind mount
> > requests at the right stage, and evaluate the attributes in the right
> > format, based on the type of mount.
> >
> > This does not affect the functionality of the existing mount security
> > hooks, including security_sb_mount. The new hook, can be utilized as a
> > supplement to the main hook for further analyzing bind mount requests.
> > This means that there is still the option of only using the main hook
> > function, if all one wants to do is indiscriminately reject all bind
> > mount requests, regardless of the source and destination arguments.
> > However, if one needs to evaluate the source and destination of a bind
> > mount request before making a decision, this hook function should be
> > preferred. Of course, if a bind mount request does not make it past the
> > security_sb_mount check, the bind mount hook function is never invoked.
> >
> > Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> > ---
> >  fs/namespace.c                |  4 ++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  1 +
> >  security/security.c           | 16 ++++++++++++++++
> >  4 files changed, 22 insertions(+)
>
> Like Casey I'm not really excited about such a specific LSM hook, but
> unfortunately we can't simply call kern_path() in the existing
> security_sb_mount() callback as that could end up resolving to
> something different than the call in do_loopback() which would be bad.
> Moving the kern_path() call up into path_mount() just looks like a bad
> idea anyway you look at it.  Unfortunately I don't really see an
> alternative to what you're proposing, so I guess we're kinda stuck
> with this as a solution, unless someone can think of something better.
>
> I'm going to need to see an ACK from the VFS folks on this before I
> merge the new hook.
>
> I'd also stick with the security_sb_bindmount() name as opposed to the
> XXX_path() suggestion from Casey simply to help distinguish it from
> the pathname based LSM hooks.  Yes, this is operating on the pathname,
> but bind mounts are a bit of a special case.
>
> Unrelated, but I just noticed that we are calling security_sb_mount()
> *before* may_mount(); that's the opposite order for most LSM hook
> placements where we do the discretionary/capabilities checks first and
> the LSM checks.  That's something we should look at, perhaps there is
> a good reason for the ordering being different, perhaps it's a
> mistake.
>
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 23e81c2a1e3f..c902608c9759 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const =
char *old_name,
> >         if (err)
> >                 return err;
> >
> > +       err =3D security_sb_bindmount(&old_path, path);
> > +       if (err)
> > +               goto out;
>
> I might make a mention in the commit description that the
> do_reconfigure_mnt() case (MS_REMOUNT|MS_BIND) should be able to be
> handled using the existing security_sb_mount() hook.
>
> >         err =3D -EINVAL;
> >         if (mnt_ns_loop(old_path.dentry))
> >                 goto out;
>
> ...
>
> > diff --git a/security/security.c b/security/security.c
> > index 09664e09fec9..bd7cb3df16f4 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1564,6 +1564,22 @@ int security_sb_mount(const char *dev_name, cons=
t struct path *path,
> >         return call_int_hook(sb_mount, dev_name, path, type, flags, dat=
a);
> >  }
> >
> > +/**
> > + * security_sb_bindmount() - Loopback/bind mount specific permission c=
heck
> > + * @old_path: source of loopback/bind mount
> > + * @path: mount point
> > + *
> > + * This check is performed in addition to security_sb_mount and only i=
f the
> > + * mount type is determined to be loopback/bind mount (flags & MS_BIND=
).  It
> > + * surfaces the mount source as a path struct.
>
> I wouldn't mention security_sb_mount() above as that makes the comment
> somewhat fragile in the face of changing hooks.  I would suggest
> something along these lines:
>
> "Beyond any general mounting hooks, this check is performed on an
>  initial loopback/bind mount (MS_BIND) with the mount source presented
>  as a path struct in @old_path."
>
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_sb_bindmount(const struct path *old_path, const struct pa=
th *path)
> > +{
> > +       return call_int_hook(sb_bindmount, old_path, path);
> > +}
> > +
> >  /**
> >   * security_sb_umount() - Check permission for unmounting a filesystem
> >   * @mnt: mounted filesystem
> >
> > base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
>
> --
> paul-moore.com

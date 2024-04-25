Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879337143
	for <linux-security-module@vger.kernel.org>; Thu, 25 Apr 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079755; cv=none; b=dJjJXsMS4tFox4MxiyJDmvzDYHI/HiygTPH7xZBiSWP5L0/m9Zs1AuuPo/UQLsGHMFZR2+CjdOyoF/Mr1K4fWTmlDl1BcrS9UAX8X+J8/cZx4pERe7ofm9MESBPlH015zn+yjjwD8pnzhNAQVN6Ltz4Di20IUNUWhA/7UMnasx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079755; c=relaxed/simple;
	bh=/FFmdsR9O9Fym31s3IonpaadQSALFxi+gkgXELQJDnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+pqIrdKLTErK+HUGBJOAprMffqs4mtKL8b6IbGjcIdUxyNf5hTqlGg++7rdPy30M3zm4zFlTKzmbkT2dD3/UpLMJj9q2lZ7PZbB5w2TdMYEQy+C7r5m89r2J0Lyg6CDSLXcFY1RLUfbZnZZ6c8YPOfFHHqqpXi5TdXaxZu9qX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZojpZkhq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZojpZkhq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-617e42a3f94so16441477b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 25 Apr 2024 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714079752; x=1714684552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blHg8bPgQUhKFHhF3jugQx9VV2zZlze7Lx295xv8KO8=;
        b=ZojpZkhq/yy3e12S1EdvW7NZ1HQqwDsjipNIlBAwkZHQBp3wL6s4Ak7nUpEXQiX8Ah
         ypZ4D/HjUCmVnLg6/oCHHFLbibbB8os3U2eQUCtn+mrnSNaahEvJxfx2rMMW2/TTMSF+
         I8TzsJEaz3bJNQAVZQoWnFBYA7kz4tGsyHVyWk73o98IxKhctpcdIPR7lnWruDCcO7Jw
         ackP23FAux8skycWtVUt+fd8u8u89H6eUFhALRLfXWEmoT+B+XybtWgjNJtm0uP0QGwR
         8K5U3KhTPOTyAvfrcb2eF8ljc67XdxM18J96xaevr9amVnqwVaoelPwS74TjZtw8/Mga
         Dw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079752; x=1714684552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blHg8bPgQUhKFHhF3jugQx9VV2zZlze7Lx295xv8KO8=;
        b=KckZm/oIprkIpV7G7mJV89+EXGWeNqXBcxG5fO1zS+sePof5IhrjDzxKaVW9b+qZLw
         fybNKw4Do3+f2ZQWDhjda09u5tQhMWEvJfpmfyPOm3gUVMGZlB+EIKjEE1yNsfvQNbyn
         JhBj1PSac5Jp6JBBDGJOOw8v/NPDfiRExdDG+FkDY+pDswi//KFeWBfKX6kLR81SCFA6
         dMkYlg3t7WitW1TQ3UEAWScWCp6OTzP2fZNgmMIVWPwua7blxRVms+Jk8Fm/HBcdmInr
         Zzh/JPhLRMcpzGu5Yf9t3aRHNcwKRqQU8mLhJQ0Hry/oQibTW8/qiv2xIPN4j2c1iupR
         +hgg==
X-Forwarded-Encrypted: i=1; AJvYcCVKT1XSDM2+ieJi/MSokKmzNuBGcLiLhC2OTuCGAt4hP/vRShjaQ/ihPR0h+7LedZgWZu6SvmB8zxImiBoTOKDRYHcjajObCwCtwR5XesH9bX3+mMPz
X-Gm-Message-State: AOJu0YwfS8BW8SRo/vM3mHBK2Fw50UdQ4ggwsosGwoVAK1GU4qFg2KJ1
	3tt7djveMY/aDfzaL0vCQH//b0V5IgzRq8OdrJ2k56Z11JdzxZJ1cDzjKHKsBW4aXolUufSJw9d
	eyFg8HWAqc06jgpGVnwR8tH3uW5FSZYZXrK4O
X-Google-Smtp-Source: AGHT+IFMG9abgUnUOH42JDmyak5//G7o2zxfCzKspMlLs8dzKSAWFr7GjM1qAAC+DwceIip9znmuHzM0W7zyN3KgmQg=
X-Received: by 2002:a05:690c:6803:b0:61b:df5:7876 with SMTP id
 id3-20020a05690c680300b0061b0df57876mr803329ywb.6.1714079752424; Thu, 25 Apr
 2024 14:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-2-omosnace@redhat.com> <0a814ce3acdea2c07cef6f7c31008e19@paul-moore.com>
 <CAFqZXNvsumcLSKKRGzvUDmz=6WYfw3a0tG43juBjnUTdbfsDsw@mail.gmail.com>
In-Reply-To: <CAFqZXNvsumcLSKKRGzvUDmz=6WYfw3a0tG43juBjnUTdbfsDsw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Apr 2024 17:15:41 -0400
Message-ID: <CAHC9VhRdcMS6WQ1QJD1h+YbNGh0x=Ex-+MvKLSaVqaPdfuZueQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cipso: fix total option length computation
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:49=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > As evident from the definition of ip_options_get(), the IP option
> > > IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
> > > the loop that walks the IP options to determine the total IP options
> > > length in cipso_v4_delopt() doesn't take it into account.
> > >
> > > Fix it by recognizing the IPOPT_END value as the end of actual option=
s.
> > > Also add safety checks in case the options are invalid/corrupted.
> > >
> > > Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connectio=
n endpoint")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > > index 8b17d83e5fde4..75b5e3c35f9bf 100644
> > > --- a/net/ipv4/cipso_ipv4.c
> > > +++ b/net/ipv4/cipso_ipv4.c
> > > @@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_=
rcu __rcu **opt_ptr)
> > >                * from there we can determine the new total option len=
gth */
> > >               iter =3D 0;
> > >               optlen_new =3D 0;
> > > -             while (iter < opt->opt.optlen)
> > > -                     if (opt->opt.__data[iter] !=3D IPOPT_NOP) {
> > > -                             iter +=3D opt->opt.__data[iter + 1];
> > > -                             optlen_new =3D iter;
> > > -                     } else
> > > +             while (iter < opt->opt.optlen) {
> > > +                     if (opt->opt.__data[iter] =3D=3D IPOPT_END) {
> > > +                             break;
> > > +                     } else if (opt->opt.__data[iter] =3D=3D IPOPT_N=
OP) {
> > >                               iter++;
> > > +                     } else {
> > > +                             if (WARN_ON(opt->opt.__data[iter + 1] <=
 2))
> > > +                                     iter +=3D 2;
> > > +                             else
> > > +                                     iter +=3D opt->opt.__data[iter =
+ 1];
> > > +                             optlen_new =3D iter;
> >
> > I worry that WARN_ON(), especially in conjunction with the one below,
> > could generate a lot of noise on the console and system logs, let's
> > be a bit more selective about what we check and report on.  Presumably
> > the options have already gone through a basic sanity check so there
> > shouldn't be anything too scary in there.
> >
> >   if (opt =3D=3D IPOPT_END) {
> >     /* ... */
> >   } else if (opt =3D=3D IPOPT_NOP) {
> >     /* ... */
> >   } else {
> >     iter +=3D opt[iter + 1];
> >     optlen_new =3D iter;
> >   }
>
> How about turning it to WARN_ON_ONCE() instead? It's actually the
> better choice in this case (alerts to a possible kernel bug, not to an
> event that would need to be logged every time), I just used WARN_ON()
> instinctively and didn't think of the _ONCE variant.

I'd really prefer to not have the WARN_ON(), even the _ONCE() variant.
We're seeing more and more discussion about avoiding the use of
WARN_ON() similar to the current BUG_ON() guidelines.

> > > +                     }
> > > +             }
> > > +             if (WARN_ON(optlen_new > opt->opt.optlen))
> > > +                     optlen_new =3D opt->opt.optlen;
> >
> > This is also probably not really necessary, but it bothers me less.
>
> I would convert this one to WARN_ON_ONCE() as well, or drop both if
> you still don't like either of them to be there.

My preference would be to drop both, although as I said earlier this
last one bothers me less.

--=20
paul-moore.com

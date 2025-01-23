Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4680034;
	Thu, 23 Jan 2025 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737608489; cv=none; b=Ys+Ssd7H72hKr2HOsP9wKOcsXsPqXP8vQnaRj4Hcy3peKKHy4q0mHxt0aqPT7UUWIMsrHulg72PHhcPGOuyE4e8qkdCXUC7zJ3bNXTD6UM8ru1tUc682lqwdGocxTgmB9IyV6vIfBwf5wVWrmKH1sCjw3Plbolm9axVb4g+Uqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737608489; c=relaxed/simple;
	bh=qi7tICcHDLUqQS4CF5kgNClYbk6dW85UITmX9gUV6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2EjtVL6NPWoXA0Fd9fd8O7d4DcojRJIR/uA2KuGfd3aa1I/LhRQN5YlJKtjUdD2AfEA9CUnhaqHwIBA6oihzG9jRS3drHyXhNg/k8iwAbAJ3L9iMonqN772yqyD5S7m9ZJeyX3prKazxVNfrIJfXfHKDi3AWKRHzFIOyci1Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjJ/K/gX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjJ/K/gX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2A8C4CEE2;
	Thu, 23 Jan 2025 05:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737608489;
	bh=qi7tICcHDLUqQS4CF5kgNClYbk6dW85UITmX9gUV6go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjJ/K/gXkbyOD9/d+mi9L5bZdAqUZNd4rdW5BshBLKv6qkCcMNdEr1aBc8pwHCJJf
	 SejnQM/erYoqKIljKvta/nY8j5xTsh07kXhR/8dwWyGsSdPxtQ6B+2AUDCbOz9cp+s
	 fl2oEwDZcRxA4PuI9utjb0qu9G5A37Cm37Vo484QGmcLe5m2FLhixgmNEsGdTp71yr
	 Hv7q42GmuKSXCiQ5OtI6ZQ2kYEqHF66X6oUeqdW0sZhfTEbl7FMk6H1HgBrH16M0CT
	 P/eLSIvGGU/YSHsR+Z0E/WxB1DFRJ/aYwLLglr237adYcrttncnYq2zI8aI9uG0aFd
	 cYwtX6gd6nHOg==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5773c5901aso2723894276.1;
        Wed, 22 Jan 2025 21:01:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXo/np5T3T3gezAzK/niI+jWjW1Tr8+mzkGe/RnbRU9yhAr0Na1GRIMyi+PYSCIrHQ3WeOS8vyOgkexO08lHFcpVHVX5MP@vger.kernel.org, AJvYcCWJjwtmyYtIV6ia39YSqEBMvnBdce+S98RbtkLXFa9y14RIzGMpjNb1H8dDlpogCfiVlk3fNq+V4w2kzBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3U86awhi2dD7b+HJEWZl/5HioYrUWVNjJl5SyjLkaSbFapE8
	To4wlBZJQ/R3D7WgEwzdBdZWP/KzQEKIK3itZFNCVQJZA0ZiIMUfXrwUTCVTpWBLOl7OoyHLtGm
	DgGCSAX+jxoMH3bEitXLfrqoNzDk=
X-Google-Smtp-Source: AGHT+IECM5W1hdDfi3Fzo2IhPe9ET22o/Hc85IRxDOXQspu9+VNrc8A2jz2Wipt4q+CebkCtv+C47c0UsvlQGlZWw+A=
X-Received: by 2002:a05:690c:9a09:b0:6e2:fcb5:52fa with SMTP id
 00721157ae682-6f748da45f1mr16568727b3.9.1737608488620; Wed, 22 Jan 2025
 21:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122065740.545042-1-code@tyhicks.com> <CAKtyLkG75o=+9UtskB6Qn2ZvzDrzQPi6gBoAYXvio__46Mds8Q@mail.gmail.com>
 <Z5GdlKW09UhO9YYo@redbud>
In-Reply-To: <Z5GdlKW09UhO9YYo@redbud>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 22 Jan 2025 21:01:17 -0800
X-Gmail-Original-Message-ID: <CAKtyLkEELYgMbGhgPyAkpVn=i66Xb3RweHOjj7yP1LbOYRJPTw@mail.gmail.com>
X-Gm-Features: AWEUYZnPHHgpahpGOStYYaEQ45B5MqMAscivmqxD_10Lz9jTaC7a6jALM_xJo90
Message-ID: <CAKtyLkEELYgMbGhgPyAkpVn=i66Xb3RweHOjj7yP1LbOYRJPTw@mail.gmail.com>
Subject: Re: [PATCH] ipe: Search for the boot policy file in the source tree
To: Tyler Hicks <code@tyhicks.com>
Cc: Fan Wu <wufan@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Deven Bowers <deven.desai@linux.microsoft.com>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:38=E2=80=AFPM Tyler Hicks <code@tyhicks.com> wrot=
e:
>
> On 2025-01-22 10:41:07, Fan Wu wrote:
> > Thanks for the fix.
> >
> > My only concern here is the use of wildcard. I'm not sure but if
> > $(CONFIG_IPE_BOOT_POLICY) is a glob pattern it could match multiple
> > files?
>
> Ah, that's a great point. To be honest, I followed the example of
> CONFIG_MODULE_SIG_KEY in scripts/Makefile.modinst and didn't consider thi=
s
> possible issue.
>
> I can reproduce your concern. It doesn't actually cause any problems beca=
use
> only the first matched file is used for the boot policy but it is potenti=
ally
> confusing and boot policy is not something that we want to be unsure abou=
t.
>
> Let me think of something else. It might be a few days before I get a cha=
nce to
> send out a v2.
>
> > Other than that I think the doc of security/ipe/Kconfig needs to be
> > updated as well to reflect the makefile change.
>
> Were you thinking something like this?
>
>           This option specifies a filepath to an IPE policy that is compi=
led
>           into the kernel. The filepath can be absolute or relative from =
either
>           the source tree or the object tree. This policy will be enforce=
d
>           until a policy update is deployed via the
>           $securityfs/ipe/policies/$policy_name/active interface.
>
>           If unsure, leave blank.
>
Thanks, this looks good to me.

-Fan


> I doubt any users actually want a relative path from the object tree but =
that
> has been supported since IPE was initially merged so I think it is worth
> keeping around.
>
> Tyler
>
> >
> > -Fan
> >
> > On Tue, Jan 21, 2025 at 10:58=E2=80=AFPM Tyler Hicks <code@tyhicks.com>=
 wrote:
> > >
> > > Resolve CONFIG_IPE_BOOT_POLICY relative file paths in the source tree=
 if
> > > the file was not found within the object tree and is not an absolute =
path.
> > >
> > > This fixes an IPE build failure that occurs when using an output dire=
ctory,
> > > such as with the `O=3D/tmp/build` make option, during a build with th=
e
> > > CONFIG_IPE_BOOT_POLICY option set to a path that's relative to the ke=
rnel
> > > source tree. For example,
> > >
> > >   $ grep CONFIG_IPE_BOOT_POLICY /tmp/build/.config
> > >   CONFIG_IPE_BOOT_POLICY=3D"ipe-boot-policy"
> > >   $ touch ipe-boot-policy
> > >   $ make O=3D/tmp/build
> > >   make[1]: Entering directory '/tmp/build'
> > >     GEN     Makefile
> > >     UPD     include/config/kernel.release
> > >     UPD     include/generated/utsrelease.h
> > >     CALL    scripts/checksyscalls.sh
> > >     CC      init/version.o
> > >     AR      init/built-in.a
> > >     CC      kernel/sys.o
> > >     AR      kernel/built-in.a
> > >     IPE_POL ipe-boot-policy
> > >   An error occurred during policy conversion: : No such file or direc=
tory
> > >   make[5]: *** [security/ipe/Makefile:14: security/ipe/boot_policy.c]=
 Error 2
> > >   make[4]: *** [scripts/Makefile.build:440: security/ipe] Error 2
> > >   make[3]: *** [scripts/Makefile.build:440: security] Error 2
> > >   make[2]: *** [Makefile:1989: .] Error 2
> > >   make[1]: *** [Makefile:251: __sub-make] Error 2
> > >   make[1]: Leaving directory '/tmp/build'
> > >   make: *** [Makefile:251: __sub-make] Error 2
> > >
> > > Fixes: ba199dc909a2 ("scripts: add boot policy generation program")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Tyler Hicks <code@tyhicks.com>
> > > ---
> > >  security/ipe/Makefile | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> > > index 2ffabfa63fe9..b54d7b7c9e6d 100644
> > > --- a/security/ipe/Makefile
> > > +++ b/security/ipe/Makefile
> > > @@ -10,8 +10,10 @@ quiet_cmd_polgen =3D IPE_POL $(2)
> > >
> > >  targets +=3D boot_policy.c
> > >
> > > -$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(CONFIG_IPE_BOOT_PO=
LICY) FORCE
> > > -       $(call if_changed,polgen,$(CONFIG_IPE_BOOT_POLICY))
> > > +boot-pol :=3D $(if $(wildcard $(CONFIG_IPE_BOOT_POLICY)),,$(srctree)=
/)$(CONFIG_IPE_BOOT_POLICY)
> > > +
> > > +$(obj)/boot_policy.c: scripts/ipe/polgen/polgen $(boot-pol) FORCE
> > > +       $(call if_changed,polgen,$(boot-pol))
> > >
> > >  obj-$(CONFIG_SECURITY_IPE) +=3D \
> > >         boot_policy.o \
> > > --
> > > 2.34.1
> > >

Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437C20F3EA;
	Fri, 25 Oct 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887862; cv=none; b=MLzh0yAfN0SiemjOJBJNl1GT1s8/W78go6CYh0wk3sejO55VwMw+7kG9RQ4jr7OsndQDLdQBbwFeUFrwS9YjgmKNQoZ5ZYOFWhdU42sbE5u4AlDaLaszouXI8Ol8L5zrTy+xsqRCw/hrdfHbKCK7e0u0v2JeEIovfOx+3m2D2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887862; c=relaxed/simple;
	bh=hQ2G8TsV0SO1D0XGNG6vdaOFIf9BUIc2I+In8hTTalA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjybofVwYXNesP5pDW0t+bFwj3D2DBzyWFLXfIq2u80Wyq+07c3ASRzxe7XtvQXH3crkOjzZNt6uVYdkRpxgnBJ8erlMYoMrp0erCk/aTi+PC6hvm/Pc3BSmOc0b9E5FzQmGgHTBVPGaMqMTGh0H3a7v1M+AhDYmYQsPHPsZiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=m0IFbEdG; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="m0IFbEdG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729887857; x=1730492657; i=linux@jordanrome.com;
	bh=iGZWBYOtk4AHhv6Hdg/ZVgYZXcOsl4iuU3bQkQ5IP34=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m0IFbEdG1hVxg7xsbOu+ctK+bEcNe45ER/EO626BaHwv4RBEHNHRAvWNJw75XNbP
	 Yim3dki3Q9gfidqh6rvAlMvUBcNOnWAlW9qSYn4Fz7T1O8Inv/sVNQnzxMtH5R/d2
	 YHuqnLQ3+eifnzMOfOPNkQzHeTCpGiWoUQ5iMZK1y6Q+gUSSSAzGF/EfWMo613CaZ
	 Az12optQbBy97FKeJ2pxkmzqbJYg7iRYdBERdIPL0Rq+usHkKMO0lMAkUwVkVGDuX
	 1HB6FeDISJTj6Il7VR/FKZMymcwZuTKSXsgyfZKh7E9oWS51fHVWNjuHwQfgfYH6v
	 Uh9Iy/zpPVY3C9uP9Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f171.google.com ([209.85.166.171]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lg28r-1teo3v3mjj-00ckHQ; Fri, 25 Oct 2024 22:24:16 +0200
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso9943125ab.3;
        Fri, 25 Oct 2024 13:24:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMFHhag5nbuZorvU4pn1n2fxj2EUYvI54zirVU5bcAD3bGlZE6nvews5/eyco30DewEJ1XXGDvq1egW6TcA85VEZEv@vger.kernel.org, AJvYcCVj82ujgoVCbx2aCC10bwl3pHSwwA8Awt1AOIkFyqI2knf81szR8CzP9wZ7FnsywioTeQ4JfISWccKNnDK3zqx3x+ruIFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoBVugmE7DKuAgZ/6juZERVm8qpEZC+YypoHJUHPi8iaOPu7S
	g1fHm1SADrX7c+1cDVG99HkgVPoYjHJmple6twA41AcnaA/Un7yRXU95/wV7KP0zhFC5ZUZ0jOf
	a2lPLWMgspdhSAt31d05O7CUKgWE=
X-Google-Smtp-Source: AGHT+IHleSAftJ0xcwyR5rPR86/se7E7olljVIVcbyosUsq8yc3gKku+FuWjdSCGfdHxGkdcAwjzEADzke4pPsonN0w=
X-Received: by 2002:a05:6e02:188c:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a4ed2944dbmr5727455ab.12.1729887856420; Fri, 25 Oct 2024
 13:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025151128.1854905-1-linux@jordanrome.com>
 <CAEf4BzYsQsj50hJut3+a4NUenZ+6ajfaFL_31NcvBdyoeBTiPg@mail.gmail.com> <20241025195228.GA99159@mail.hallyn.com>
In-Reply-To: <20241025195228.GA99159@mail.hallyn.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Fri, 25 Oct 2024 16:24:05 -0400
X-Gmail-Original-Message-ID: <CA+QiOd6Ef6V2=DeAc=8VdCJhRtxG5eZCBOPiMzedob1ARnR-zg@mail.gmail.com>
Message-ID: <CA+QiOd6Ef6V2=DeAc=8VdCJhRtxG5eZCBOPiMzedob1ARnR-zg@mail.gmail.com>
Subject: Re: [v2] security: add trace event for cap_capable
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xtoQBTLmtWweUO8vXXl7Nfy1gZmtkRy9IPOL5Jl+KAdjGM3kZR+
 tuKwUu0zhRl81nrdGtKvY6ou1jedawOf5sLb1PKjZQeSbNkDMhL9mwvadvSpKAvTTTabiLe
 qcvVF62bsAGv5W45E29Rv1WJV+Nu9fPlXc2gOUHcdD08jYdBquonnIw6GerJuK4vAyGfkg1
 tut+Z3VvRF0WeM1ElXQig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3arGGpba6L8=;V4qGqjjF9LICCCQCfsRXGzKg2W0
 qNk2JgN2UDwicIGM22fBWiJ/fG4HWF7d5ten/NrEKrOL+JAPil3vu8Se/f9vBGHrIJB8cXmIl
 WyMFX0QRjxNFxr5prqzrghuwqYMUgJ/NhXrkFI5bZ0j8pQ8IWElRqY15rXCipMK9NG3XlLN37
 tgB2wvm/08O2BDxOsLN+b6qRJX8biLJooInu34eO99hbji4w+33YjvahOa247P/9o14NBwuMn
 NlHMrQ2jNOYN803XTuJZK4p1pRTiKgXFThPn6/CXXLVYFNK/4RV9DDZJLUsbPk/VzBNcCmYCt
 HqE7f752OCTBBNMZpTzJHt0lztGaruLVE11Jb1cHQSA3l9WAe4Schon4/3hBopVRuhw/3sJog
 ZZRZwixGB9dVOC3ucJj7vRdHJvG/U2G47nOMUgBjTw/U26jsxyCpryjnrnftCE70rH4UiBzxt
 kI48K7wI77a7fySAn7c4aFrlDA8Zb3XGdDLc12XKafvUgAyWqawM5c6wmfihjUiut0NpQgn/I
 8iqXiaDrR/a5qQmUZmdFvl1Zoz/qM4TFSW5GiGzJL836r+8IWN/fZgq6V/IZseGbHQw6Tu66d
 NL2BHWpqx3TnNSIU4KCQdRLCdwSwyxhWV1UxFvGtcneeJJtCEvKidelllRstjZZd/tFeVO3zf
 7DKnf4LaRuFV1ZEbSkvWVKzetCdF9ywrk/dH2bD0GThfkeX68Ul6PjqR4or8+uTDEPocdMo2w
 NbkVli87OiHV1LsFT13sey9Nk5s+ULlnw==

On Fri, Oct 25, 2024 at 3:52=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Fri, Oct 25, 2024 at 11:37:59AM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 25, 2024 at 8:15=E2=80=AFAM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > In cases where we want a stable way to observe/trace
> > > cap_capable (e.g. protection from inlining and API updates)
> > > add a tracepoint that passes:
> > > - The credentials used
> > > - The user namespace of the resource being accessed
> > > - The user namespace that has the capability to access the
> > > targeted resource
> > > - The capability to check for
> > > - Bitmask of options defined in include/linux/security.h
> > > - The return value of the check
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  MAINTAINERS                       |  1 +
> > >  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++=
++
> > >  security/commoncap.c              | 31 +++++++++++-----
> > >  3 files changed, 84 insertions(+), 8 deletions(-)
> > >  create mode 100644 include/trace/events/capability.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index cc40a9d9b8cd..210e9076c858 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4994,6 +4994,7 @@ M:        Serge Hallyn <serge@hallyn.com>
> > >  L:     linux-security-module@vger.kernel.org
> > >  S:     Supported
> > >  F:     include/linux/capability.h
> > > +F:     include/trace/events/capability.h
> > >  F:     include/uapi/linux/capability.h
> > >  F:     kernel/capability.c
> > >  F:     security/commoncap.c
> > > diff --git a/include/trace/events/capability.h b/include/trace/events=
/capability.h
> > > new file mode 100644
> > > index 000000000000..e706ce690c38
> > > --- /dev/null
> > > +++ b/include/trace/events/capability.h
> > > @@ -0,0 +1,60 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM capability
> > > +
> > > +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ=
)
> > > +#define _TRACE_CAPABILITY_H
> > > +
> > > +#include <linux/cred.h>
> > > +#include <linux/tracepoint.h>
> > > +#include <linux/user_namespace.h>
> > > +
> > > +/**
> > > + * cap_capable - called after it's determined if a task has a partic=
ular
> > > + * effective capability
> > > + *
> > > + * @cred: The credentials used
> > > + * @targ_ns: The user namespace of the resource being accessed
> > > + * @capable_ns: The user namespace in which the credential provides =
the
> > > + *              capability to access the targeted resource.
> > > + *              This will be NULL if ret is not 0.
> > > + * @cap: The capability to check for
> > > + * @opts: Bitmask of options defined in include/linux/security.h
> > > + * @ret: The return value of the check: 0 if it does, -ve if it does=
 not
> > > + *
> > > + * Allows to trace calls to cap_capable in commoncap.c
> > > + */
> > > +TRACE_EVENT(cap_capable,
> > > +
> > > +       TP_PROTO(const struct cred *cred, struct user_namespace *targ=
_ns,
> > > +               struct user_namespace *capable_ns, int cap, unsigned =
int opts, int ret),
> > > +
> > > +       TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(const struct cred *, cred)
> > > +               __field(struct user_namespace *, targ_ns)
> > > +               __field(struct user_namespace *, capable_ns)
> > > +               __field(int, cap)
> > > +               __field(unsigned int, opts)
> > > +               __field(int, ret)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->cred       =3D cred;
> > > +               __entry->targ_ns    =3D targ_ns;
> > > +               __entry->capable_ns =3D capable_ns;
> > > +               __entry->cap        =3D cap;
> > > +               __entry->opts       =3D opts;
> > > +               __entry->ret        =3D ret;
> > > +       ),
> > > +
> > > +       TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, opts %=
u, ret %d",
> > > +               __entry->cred, __entry->targ_ns, __entry->capable_ns,=
 __entry->cap,
> > > +               __entry->opts, __entry->ret)
> > > +);
> > > +
> > > +#endif /* _TRACE_CAPABILITY_H */
> > > +
> > > +/* This part must be outside protection */
> > > +#include <trace/define_trace.h>
> > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > index 162d96b3a676..12c3ddfe0d6e 100644
> > > --- a/security/commoncap.c
> > > +++ b/security/commoncap.c
> > > @@ -27,6 +27,9 @@
> > >  #include <linux/mnt_idmapping.h>
> > >  #include <uapi/linux/lsm.h>
> > >
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/capability.h>
> > > +
> > >  /*
> > >   * If a non-root user executes a setuid-root binary in
> > >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > > @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const char =
*fname)
> > >  /**
> > >   * cap_capable - Determine whether a task has a particular effective=
 capability
> > >   * @cred: The credentials to use
> > > - * @targ_ns:  The user namespace in which we need the capability
> > > + * @targ_ns:  The user namespace of the resource being accessed
> > >   * @cap: The capability to check for
> > >   * @opts: Bitmask of options defined in include/linux/security.h
> > >   *
> > > @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct use=
r_namespace *targ_ns,
> > >                 int cap, unsigned int opts)
> > >  {
> > >         struct user_namespace *ns =3D targ_ns;
> > > +       int ret =3D -EPERM;
> > >
> > >         /* See if cred has the capability in the target user namespac=
e
> > >          * by examining the target user namespace and all of the targ=
et
> > > @@ -75,22 +79,32 @@ int cap_capable(const struct cred *cred, struct u=
ser_namespace *targ_ns,
> > >          */
> > >         for (;;) {
> > >                 /* Do we have the necessary capabilities? */
> > > -               if (ns =3D=3D cred->user_ns)
> > > -                       return cap_raised(cred->cap_effective, cap) ?=
 0 : -EPERM;
> > > +               if (ns =3D=3D cred->user_ns) {
> > > +                       if (cap_raised(cred->cap_effective, cap))
> > > +                               ret =3D 0;
> > > +                       else
> > > +                               ns =3D NULL;
> >
> > This is a bit unfortunate :( so maybe all we needed was `ns =3D
> > ns->parent` for that one use case, and keep the original `ret ? NULL :
> > ns` inside trace_cap_capable().
>
> Yeah, that would be fine with me.  Or maybe just doing
>
>         /* in case of an error, trace should show ns=3DNULL */
>         if (ret)
>                 ns =3D NULL;
>
> right above the trace_cap_capable() call would be clearer.

I feel like having less trace specific logic in this function would be
a good thing,
so I'm for Andrii's suggestion of doing the ret check there but also
fine to do what security folks prefer :)

>
> > But whatever security folks prefer, I'm fine with either.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > +                       break;
> > > +               }
> > >
> > >                 /*
> > >                  * If we're already at a lower level than we're looki=
ng for,
> > >                  * we're done searching.
> > >                  */
> > > -               if (ns->level <=3D cred->user_ns->level)
> > > -                       return -EPERM;
> > > +               if (ns->level <=3D cred->user_ns->level) {
> > > +                       ns =3D NULL;
> > > +                       break;
> > > +               }
> > >
> > >                 /*
> > >                  * The owner of the user namespace in the parent of t=
he
> > >                  * user namespace has all caps.
> > >                  */
> > > -               if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->o=
wner, cred->euid))
> > > -                       return 0;
> > > +               if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->o=
wner, cred->euid)) {
> > > +                       ns =3D ns->parent;
> > > +                       ret =3D 0;
> > > +                       break;
> > > +               }
> > >
> > >                 /*
> > >                  * If you have a capability in a parent user ns, then=
 you have
> > > @@ -99,7 +113,8 @@ int cap_capable(const struct cred *cred, struct us=
er_namespace *targ_ns,
> > >                 ns =3D ns->parent;
> > >         }
> > >
> > > -       /* We never get here */
> > > +       trace_cap_capable(cred, targ_ns, ns, cap, opts, ret);
> > > +       return ret;
> > >  }
> > >
> > >  /**
> > > --
> > > 2.43.5
> > >
> > >

Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B01217F29;
	Sat, 26 Oct 2024 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941770; cv=none; b=tB4RZC0Bt1gT0GaWORDMYKMfIIyF9onUtyjejprfLUMY0jquNTGP77NYOwrTTHvOGSV0EQ7AzRcYGnqsbA5ljfEsGPwbDgIEoe2088ZloTKpejMi0xYcxW7hk+huiGsQGrLLUKPbNo26kyvUknRUmQtjSvzjQuh4YuDYzSMLRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941770; c=relaxed/simple;
	bh=NlFtMB0l5AYLrZFEIh5M7J5PIC9a6A/kVQUfb19+6VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdL/NpAtuz4M/POhRpBQ7Sl0bwuuIrOZ4L89/4jkX0Ij0FwGgmzz1dksaC2O8EAV4ARkbuypFyomlXbXFLarWxIMIVgPZiIW+ydvo0kA0hL4GCLz8nYlm+bxv/+AlhlImieTgw9Z+Jv0lDQa3frZSaPgdAfcRCJKDrkQYNf9ZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=AZFAsMz4; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="AZFAsMz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729941761; x=1730546561; i=linux@jordanrome.com;
	bh=0WB8TJ9WVtxDl6RNQXiDLNnfo173B/nmNdoxlyCjfj8=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AZFAsMz4oK99TdZiH04cgKeCZDMIAyth+lyiNDdYRv5ORuQDRZzKb8+XB6NBXR12
	 9iNFjdjegDJR7nxjjQ9RIp4x9/loVn4uFurwP8okiCuysTc/1kJsbraJe8UdIv/iS
	 UXoQ0amPKqpqE6UenkSDPx2abm0RsI2EEf9vT0rU+65olOaY2N32BWb3dPyZ+qxOv
	 ygtdYUb5Dg+PBAaKHqQP4ZbVUPHDDc+XVvkNGL5yPI3eB4NEmbgXZhC5h4ENsDNof
	 Pnjc75m4BnK9kDddBrZLqq0PixNazUIMHOy0XWeDymXRxR9LCS0IcBLDm3tPtkuW+
	 mUphnhJVQ7HvM+wyNA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-io1-f46.google.com ([209.85.166.46]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LllQs-1tdie91ITw-00oYbV;
 Sat, 26 Oct 2024 13:22:41 +0200
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83aac75fcceso104382739f.0;
        Sat, 26 Oct 2024 04:22:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO9196XQ5FtXrQPt+Hc+V+KsmgSVA0QBedcMuN2nq2djtL3KVKKZk8BghKgK1EksTPFOr2Z4e9/rrs5tqz/k3a8bxz@vger.kernel.org, AJvYcCXwq7HiT2wU7Zgcyg2t8Rrh+Z9ifYRwAHTCktjGk902Rup5F0RZFlOOfVwa2x9FBIt8R1Cb05QNW+1QxoMhRugJpZzJ0x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF76Y5nZ/R9mKoOuhqC9l5Pfn9Bhtotjgmc8T27vlfBc6kw9U7
	1LqPoCxV8eUR7uoxkQBmuIBELmoE4B0AL0+WQpwTdhHD30FjSDSacvr9USKwD+M8eYK9oHdxDk7
	T915uf0/Q8zcGJ3gCctz9vMWNp5s=
X-Google-Smtp-Source: AGHT+IFiODJREVi+sHIKC/hkiYR0DrZu6Af4G/8S3cJgNAThcEDoiwOwv4n3SM3UADQ+mPxca5b2nE4aUYVvtIS5djk=
X-Received: by 2002:a05:6e02:1886:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a4ed2f666amr18571285ab.14.1729941760842; Sat, 26 Oct 2024
 04:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025151128.1854905-1-linux@jordanrome.com>
 <CAEf4BzYsQsj50hJut3+a4NUenZ+6ajfaFL_31NcvBdyoeBTiPg@mail.gmail.com>
 <20241025195228.GA99159@mail.hallyn.com> <CA+QiOd6Ef6V2=DeAc=8VdCJhRtxG5eZCBOPiMzedob1ARnR-zg@mail.gmail.com>
 <20241026100956.GA105650@mail.hallyn.com>
In-Reply-To: <20241026100956.GA105650@mail.hallyn.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Sat, 26 Oct 2024 07:22:29 -0400
X-Gmail-Original-Message-ID: <CA+QiOd6R4VcdqtaM3LX47Vjffuk_rSsdra4bdhe1i-+NGK7NDQ@mail.gmail.com>
Message-ID: <CA+QiOd6R4VcdqtaM3LX47Vjffuk_rSsdra4bdhe1i-+NGK7NDQ@mail.gmail.com>
Subject: Re: [v2] security: add trace event for cap_capable
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lTImLmqSv1TR0hmrNzwycwxzjmdWJj5CXGznYB29tEJHLI8POHV
 jJ1tNtstCK4ohdKWdE0mxhqaUSHnpBZol7V9tK6BhROrK6QhISK6gGifkqvGGtud58g9rXm
 x4dTr7jvL1XbPLqj8WO7/i74pjK/bVHzqnJnd0c2D/MY2rtl02URSwPMWJkUxLTrjetKxnh
 QRNDYA+d1F3Ln3snauVJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tOY8xgB/AUg=;Wp0Ow2pr30aWncYU0mqdBjnVkKz
 504JSCLi8T/yCSQtfnUoOAandaXGyJzUCk4fdUoWBla/XhVqxrL33zJEvC2hoLmIZtwIQd4P5
 9h3PqWolmj3Cwt3In1LR5cBtbjAN/oegfJvgvzotpd1PTHOQ06BgGQCD+pa9htwqfVr0yAw/Z
 7Izkply0/CWQMR6MhYluwq7H9EvmZa3QpzRbHp+8Lsqy6n54GiaXEiMVd8W5oILWecMReN7Kv
 CZJHxldLhXuOoNLWCP2oEl7znqjhnIJXOFjGoF6KsBuBexA0WSkRu/cXAOLjw6t/Fbuec5imp
 h8fQZwXkuNJk/kfTBKvvOx+neRLjQUGonM4KUwmk2CL8IDo82lhE7Qo5gH153n0FoLGUDIfn5
 a4LyhGg8/ytptiZHUX1WLoJ7i1uyPdsA5LuNnwu/mJ7qHmYs/we0Kzhx+Wtd4Fels+waPTC5a
 YUPzLknchVbOOIbYi/9OtOa7ILDxG65wGlNngBiJPH2OxJdp0cvJjhXZX6WXWdyfii8Phy1RA
 ceI92l3nuDMdBWAxHsXBzC9ugjVTAkhRXXHSvnW3llmFx0KgtWdN9oL3oFHUzQD/ZrQRNUORy
 9iLpZUu5pZ9zK4WL1Y9EMgpVEIOGwwiRGy70qTzIvOMiGZp+T+KjDmEyPdlPe9M7RGBst50LR
 YyuvNJ4SYAez16Lcre2+XbIiER2pX3H/dHxCNkVb5E0lrIPm2j89EIz5CwWJIzpHo4vBdMDTM
 J03+w1PVpPvgjNlqKsUvDL72S1fA4VjoQ==

On Sat, Oct 26, 2024 at 6:10=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Fri, Oct 25, 2024 at 04:24:05PM -0400, Jordan Rome wrote:
> > On Fri, Oct 25, 2024 at 3:52=E2=80=AFPM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > >
> > > On Fri, Oct 25, 2024 at 11:37:59AM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Oct 25, 2024 at 8:15=E2=80=AFAM Jordan Rome <linux@jordanro=
me.com> wrote:
> > > > >
> > > > > In cases where we want a stable way to observe/trace
> > > > > cap_capable (e.g. protection from inlining and API updates)
> > > > > add a tracepoint that passes:
> > > > > - The credentials used
> > > > > - The user namespace of the resource being accessed
> > > > > - The user namespace that has the capability to access the
> > > > > targeted resource
> > > > > - The capability to check for
> > > > > - Bitmask of options defined in include/linux/security.h
> > > > > - The return value of the check
> > > > >
> > > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > > ---
> > > > >  MAINTAINERS                       |  1 +
> > > > >  include/trace/events/capability.h | 60 +++++++++++++++++++++++++=
++++++
> > > > >  security/commoncap.c              | 31 +++++++++++-----
> > > > >  3 files changed, 84 insertions(+), 8 deletions(-)
> > > > >  create mode 100644 include/trace/events/capability.h
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index cc40a9d9b8cd..210e9076c858 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -4994,6 +4994,7 @@ M:        Serge Hallyn <serge@hallyn.com>
> > > > >  L:     linux-security-module@vger.kernel.org
> > > > >  S:     Supported
> > > > >  F:     include/linux/capability.h
> > > > > +F:     include/trace/events/capability.h
> > > > >  F:     include/uapi/linux/capability.h
> > > > >  F:     kernel/capability.c
> > > > >  F:     security/commoncap.c
> > > > > diff --git a/include/trace/events/capability.h b/include/trace/ev=
ents/capability.h
> > > > > new file mode 100644
> > > > > index 000000000000..e706ce690c38
> > > > > --- /dev/null
> > > > > +++ b/include/trace/events/capability.h
> > > > > @@ -0,0 +1,60 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +#undef TRACE_SYSTEM
> > > > > +#define TRACE_SYSTEM capability
> > > > > +
> > > > > +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_=
READ)
> > > > > +#define _TRACE_CAPABILITY_H
> > > > > +
> > > > > +#include <linux/cred.h>
> > > > > +#include <linux/tracepoint.h>
> > > > > +#include <linux/user_namespace.h>
> > > > > +
> > > > > +/**
> > > > > + * cap_capable - called after it's determined if a task has a pa=
rticular
> > > > > + * effective capability
> > > > > + *
> > > > > + * @cred: The credentials used
> > > > > + * @targ_ns: The user namespace of the resource being accessed
> > > > > + * @capable_ns: The user namespace in which the credential provi=
des the
> > > > > + *              capability to access the targeted resource.
> > > > > + *              This will be NULL if ret is not 0.
> > > > > + * @cap: The capability to check for
> > > > > + * @opts: Bitmask of options defined in include/linux/security.h
> > > > > + * @ret: The return value of the check: 0 if it does, -ve if it =
does not
> > > > > + *
> > > > > + * Allows to trace calls to cap_capable in commoncap.c
> > > > > + */
> > > > > +TRACE_EVENT(cap_capable,
> > > > > +
> > > > > +       TP_PROTO(const struct cred *cred, struct user_namespace *=
targ_ns,
> > > > > +               struct user_namespace *capable_ns, int cap, unsig=
ned int opts, int ret),
> > > > > +
> > > > > +       TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > > > > +
> > > > > +       TP_STRUCT__entry(
> > > > > +               __field(const struct cred *, cred)
> > > > > +               __field(struct user_namespace *, targ_ns)
> > > > > +               __field(struct user_namespace *, capable_ns)
> > > > > +               __field(int, cap)
> > > > > +               __field(unsigned int, opts)
> > > > > +               __field(int, ret)
> > > > > +       ),
> > > > > +
> > > > > +       TP_fast_assign(
> > > > > +               __entry->cred       =3D cred;
> > > > > +               __entry->targ_ns    =3D targ_ns;
> > > > > +               __entry->capable_ns =3D capable_ns;
> > > > > +               __entry->cap        =3D cap;
> > > > > +               __entry->opts       =3D opts;
> > > > > +               __entry->ret        =3D ret;
> > > > > +       ),
> > > > > +
> > > > > +       TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, op=
ts %u, ret %d",
> > > > > +               __entry->cred, __entry->targ_ns, __entry->capable=
_ns, __entry->cap,
> > > > > +               __entry->opts, __entry->ret)
> > > > > +);
> > > > > +
> > > > > +#endif /* _TRACE_CAPABILITY_H */
> > > > > +
> > > > > +/* This part must be outside protection */
> > > > > +#include <trace/define_trace.h>
> > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > index 162d96b3a676..12c3ddfe0d6e 100644
> > > > > --- a/security/commoncap.c
> > > > > +++ b/security/commoncap.c
> > > > > @@ -27,6 +27,9 @@
> > > > >  #include <linux/mnt_idmapping.h>
> > > > >  #include <uapi/linux/lsm.h>
> > > > >
> > > > > +#define CREATE_TRACE_POINTS
> > > > > +#include <trace/events/capability.h>
> > > > > +
> > > > >  /*
> > > > >   * If a non-root user executes a setuid-root binary in
> > > > >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > > > > @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const c=
har *fname)
> > > > >  /**
> > > > >   * cap_capable - Determine whether a task has a particular effec=
tive capability
> > > > >   * @cred: The credentials to use
> > > > > - * @targ_ns:  The user namespace in which we need the capability
> > > > > + * @targ_ns:  The user namespace of the resource being accessed
> > > > >   * @cap: The capability to check for
> > > > >   * @opts: Bitmask of options defined in include/linux/security.h
> > > > >   *
> > > > > @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct=
 user_namespace *targ_ns,
> > > > >                 int cap, unsigned int opts)
> > > > >  {
> > > > >         struct user_namespace *ns =3D targ_ns;
> > > > > +       int ret =3D -EPERM;
> > > > >
> > > > >         /* See if cred has the capability in the target user name=
space
> > > > >          * by examining the target user namespace and all of the =
target
> > > > > @@ -75,22 +79,32 @@ int cap_capable(const struct cred *cred, stru=
ct user_namespace *targ_ns,
> > > > >          */
> > > > >         for (;;) {
> > > > >                 /* Do we have the necessary capabilities? */
> > > > > -               if (ns =3D=3D cred->user_ns)
> > > > > -                       return cap_raised(cred->cap_effective, ca=
p) ? 0 : -EPERM;
> > > > > +               if (ns =3D=3D cred->user_ns) {
> > > > > +                       if (cap_raised(cred->cap_effective, cap))
> > > > > +                               ret =3D 0;
> > > > > +                       else
> > > > > +                               ns =3D NULL;
> > > >
> > > > This is a bit unfortunate :( so maybe all we needed was `ns =3D
> > > > ns->parent` for that one use case, and keep the original `ret ? NUL=
L :
> > > > ns` inside trace_cap_capable().
> > >
> > > Yeah, that would be fine with me.  Or maybe just doing
> > >
> > >         /* in case of an error, trace should show ns=3DNULL */
> > >         if (ret)
> > >                 ns =3D NULL;
> > >
> > > right above the trace_cap_capable() call would be clearer.
> >
> > I feel like having less trace specific logic in this function would be
> > a good thing,
> > so I'm for Andrii's suggestion of doing the ret check there but also
> > fine to do what security folks prefer :)
>
> I think a comment is needed to remind us (me) in 2 years why the
> seting of ns to NULL is there.  But the comment of trace_cap_capable()
> probably suffices, so sure, go with Andrii's suggestion.  And then
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> for the capability code.
>
> thanks,
> -serge

I think we're suggesting to not set ns =3D NULL here and instead
check the ret value in the trace code e.g.
`__entry->capable_ns =3D ret ? NULL : capable_ns;`

I think the only trace-specific thing, which I can add a comment
for, is this part `ns =3D ns->parent;` after we already set the ret to 0.

Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D4101F7;
	Fri, 25 Oct 2024 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818971; cv=none; b=II9WB4X4Ixc+X1A/5/EedXClJmLv80QxPRAOIfFv/EwdGeb1RxT2JxboXS5aMSi4XNaDWv+cCBsvkfBHvWzs3+uGp3/ksrt2c5wrhmDmc76S1nS3rKjef0V56eyCWrJtXL3a80pPTFC9OADa+kFFazQUsqILsvwc+v1/j0h6WLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818971; c=relaxed/simple;
	bh=DSoKwdtVx2RU9x2lR150NiW6QXi0sPpNlrh7hg0w3nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnyhhKbPceT7H7seMslKQgammw8LMGUgo9u1GdtHgrRay/HqUjn5/Zz86u9CxIbtjwEpOJG6qmjjU2QgDvFg7uGjrSrkbABDHLx25L2ruHTgda+1FkkXTj2iWzgwPzqBaZn883RhfZhVLz2i+sQ5fabs+jIIxh8BMacpNDD8yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e5f07c8fso574945ab.0;
        Thu, 24 Oct 2024 18:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818968; x=1730423768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0bDAOSoTLLEBPyFpbinRYWmY8TDtHoCqFWLZR6/I+A=;
        b=rLc2CYD6L6b7gYlDXIYEcAxcQr2Bjd10z/dvak7AHeCXcDbmV9WSzOm1mGQeI7yE1c
         dt3vL5MoX8ITSfy6z25VJkgyc0hADyZmbwIr8lbRreLY62pvbR4F78wILqf9DDbLthjA
         ioy7zGEJxwreutwncUvVgaEveecDaFLORF9i0a2H/BwcRICyKwQZV23rDsx3GpgwZIV3
         WlWpcY4ut7fLSSuNE9ODq20hlpl62xNDRckTJJJBHN9sj95IlkUwOvc5zwQo0eey45Lz
         Yyjx7VuNOAZffa6ugLMonh46xkNwDMp4VYyJpJ3u9YlSXamsV+gomje4L+EqbVuVJEYw
         t7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVRdcPeIktvlFTWX0T9ei2ppv/umxOBSC4+mUL1VFJAwiZf8U1HloZCD8m+kuldl48AR0ANrDWSq4QXn8zmXR3SsEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUA78CpjtaRWsn8T3NC7HAk45cx9c5tTTwuCVnPN+C8LNu/Tq2
	WV0z1Bya31MTvSpK7D8RzIkN2M95vuDNtqJBZ9votu4NDBCRHmOycNjbkwFgMsCpVo+B2VyXL6p
	qAlkzmz3mh0qBpDHojvMn+JQ7SxI=
X-Google-Smtp-Source: AGHT+IEPhNXi0Mk4buD6KdwwNiwk17Nh5jjUhhhJIyVaPtAFzhjMDL3Ae/nBbcy4aJiDQN5WRuWZ4RUFztbDcq6qJn8=
X-Received: by 2002:a05:6e02:190a:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a4d59e9c79mr91902645ab.22.1729818968087; Thu, 24 Oct 2024
 18:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024104012.1815022-1-linux@jordanrome.com> <Zxqt29vYukIGw8QV@lei>
In-Reply-To: <Zxqt29vYukIGw8QV@lei>
From: Jordan Rome <jordan@jordanrome.com>
Date: Thu, 24 Oct 2024 21:15:56 -0400
Message-ID: <CA+QiOd4J9=7-7v_Vh5YR7+BVTGYPzD6ARKxrrKWtPtKP3Oj8SQ@mail.gmail.com>
Subject: Re: [v1] security: add trace event for cap_capable
To: sergeh@kernel.org
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:28=E2=80=AFPM <sergeh@kernel.org> wrote:
>
> On Thu, Oct 24, 2024 at 03:40:12AM -0700, Jordan Rome wrote:
> > In cases where we want a stable way to observe/trace
> > cap_capable (e.g. protection from inlining and API updates)
> > add a tracepoint that passes:
> > - The credentials used
> > - The user namespace which needs the capability
>
> "the user namespace which needs the capability" is not quite the
> right way to put this.  It's the user namespace against which the
> capability is needed.  It's an object, not a subject.  Or maybe
> "the user namespace of the resource being accessed".
>

I like "The user namespace of the resource being accessed"

> > - The user namespace that actually has the capability (if one exists)
>
> How about "the user namespace in which the task has the
> capability targeted at the resource"?  (It's not the user
> namespace itself that has the capability)
>

This phrasing seems a little confusing. How about:
"The user namespace that has the capability to access the targeted resource=
" ?

> > - The capability to check for
> > - Bitmask of options defined in include/linux/security.h
> > - The return value of the check
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  MAINTAINERS                       |  1 +
> >  include/trace/events/capability.h | 58 +++++++++++++++++++++++++++++++
> >  security/commoncap.c              | 21 +++++++----
> >  3 files changed, 74 insertions(+), 6 deletions(-)
> >  create mode 100644 include/trace/events/capability.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cc40a9d9b8cd..210e9076c858 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4994,6 +4994,7 @@ M:      Serge Hallyn <serge@hallyn.com>
> >  L:   linux-security-module@vger.kernel.org
> >  S:   Supported
> >  F:   include/linux/capability.h
> > +F:   include/trace/events/capability.h
> >  F:   include/uapi/linux/capability.h
> >  F:   kernel/capability.c
> >  F:   security/commoncap.c
> > diff --git a/include/trace/events/capability.h b/include/trace/events/c=
apability.h
> > new file mode 100644
> > index 000000000000..092b8e77063a
> > --- /dev/null
> > +++ b/include/trace/events/capability.h
> > @@ -0,0 +1,58 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM capability
> > +
> > +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_CAPABILITY_H
> > +
> > +#include <linux/cred.h>
> > +#include <linux/tracepoint.h>
> > +#include <linux/user_namespace.h>
> > +
> > +/**
> > + * capable - called after it's determined if a task has a particular
> > + * effective capability
> > + *
> > + * @cred: The credentials used
> > + * @targ_ns:  The user namespace which needs the capability
>
> (same here)
>
> > + * @capable_ns:  The user namespace that actually has the capability
> > + *               if ret is 0 otherwise this will be NULL
> > + * @cap: The capability to check for
> > + * @opts: Bitmask of options defined in include/linux/security.h
> > + * @ret: The return value of the check: 0 if it does, -ve if it does n=
ot
> > + *
> > + * Allows to trace calls to cap_capable in commoncap.c
> > + */
> > +TRACE_EVENT(capable,
> > +
> > +     TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> > +             struct user_namespace *capable_ns, int cap, unsigned int =
opts, int ret),
> > +
> > +     TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(const struct cred *, cred)
> > +             __field(struct user_namespace *, targ_ns)
> > +             __field(struct user_namespace *, capable_ns)
> > +             __field(int, cap)
> > +             __field(unsigned int, opts)
> > +             __field(int, ret)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->cred       =3D cred;
> > +             __entry->targ_ns    =3D targ_ns;
> > +             __entry->capable_ns =3D capable_ns;
> > +             __entry->cap        =3D cap;
> > +             __entry->opts       =3D opts;
> > +             __entry->ret        =3D ret;
> > +     ),
> > +
> > +     TP_printk("cap %d, opts %u, ret %d",
> > +             __entry->cap, __entry->opts, __entry->ret)
> > +);
> > +
> > +#endif /* _TRACE_CAPABILITY_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 162d96b3a676..675d40fbaa77 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -27,6 +27,9 @@
> >  #include <linux/mnt_idmapping.h>
> >  #include <uapi/linux/lsm.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/capability.h>
> > +
> >  /*
> >   * If a non-root user executes a setuid-root binary in
> >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_=
namespace *targ_ns,
> >               int cap, unsigned int opts)
> >  {
> >       struct user_namespace *ns =3D targ_ns;
> > +     int ret =3D 0;
> >
> >       /* See if cred has the capability in the target user namespace
> >        * by examining the target user namespace and all of the target
> > @@ -75,22 +79,26 @@ int cap_capable(const struct cred *cred, struct use=
r_namespace *targ_ns,
> >        */
> >       for (;;) {
> >               /* Do we have the necessary capabilities? */
> > -             if (ns =3D=3D cred->user_ns)
> > -                     return cap_raised(cred->cap_effective, cap) ? 0 :=
 -EPERM;
> > +             if (ns =3D=3D cred->user_ns) {
> > +                     ret =3D cap_raised(cred->cap_effective, cap) ? 0 =
: -EPERM;
> > +                     break;
> > +             }
> >
> >               /*
> >                * If we're already at a lower level than we're looking f=
or,
> >                * we're done searching.
> >                */
> > -             if (ns->level <=3D cred->user_ns->level)
> > -                     return -EPERM;
> > +             if (ns->level <=3D cred->user_ns->level) {
> > +                     ret =3D -EPERM;
> > +                     break;
> > +             }
> >
> >               /*
> >                * The owner of the user namespace in the parent of the
> >                * user namespace has all caps.
> >                */
> >               if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid))
> > -                     return 0;
> > +                     break;
> >
> >               /*
> >                * If you have a capability in a parent user ns, then you=
 have
> > @@ -99,7 +107,8 @@ int cap_capable(const struct cred *cred, struct user=
_namespace *targ_ns,
> >               ns =3D ns->parent;
> >       }
> >
> > -     /* We never get here */
>
> With this change, I become less comfortable with us assuming that it is
> the case that we'll never just drop off the end of the while loop.  I'd
> be more comfortable if you set ret =3D -EPERM at the top, and set it to 0
> in the last break.
>

Sure. I can make this change.

> > +     trace_capable(cred, targ_ns, ret =3D=3D 0 ? ns : NULL, cap, opts,=
 ret);
> > +     return ret;
> >  }
> >
> >  /**
> > --
> > 2.43.5
> >

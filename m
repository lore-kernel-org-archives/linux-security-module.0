Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9549175D4A;
	Sun, 27 Oct 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730053301; cv=none; b=uaQkYUndyH27aJQNgihY42cCRqxYGXpCmumt+69gJyZL9tymU5e4DZuVe7hvkNyMNDOQCEIRj2WPR7FsHGlsHBI+ZWeilkoSjbe2ptAJA73BPj6IovjRAuWLZdfVvJRPkHxQaLWqXTdjgvtXHtutQCr9nWkxm4yQK6Yzl/q1Uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730053301; c=relaxed/simple;
	bh=xFjRz0W5GU/jMN+73C/HusZiBed8KHgK8PHYiA4lQLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6A7rBY7JN+GGIxSYuzL1OqUjn6dfXuEEzid7GH6N+aFT6fUCAex1mpihgbGAJwlkhQBNJ+9jikZUvRBZpedj4LTwUiR153Mq8NvH7lxBUqGNH4N1Wab0sN5GMKsUawontKHd8QC66Dk8ihoSe2NJvWnoOkk9Cx1xjI4im6jwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a398638ff9so13593655ab.3;
        Sun, 27 Oct 2024 11:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730053298; x=1730658098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBVlJWzdLy/ya8eL90YFMh4p1F3X3tt8XKuflte087o=;
        b=Bev5+L9MfeoFLnGy+7tTpEn3axTDQ15JjjQNOfHN+AEqK0tGhMFJVRc8yuGue5z48s
         Kc+8+u7W2/CdNxmpOTZdqfr1gH5MUPq7fit+tXXvps7QqT5Uog1mYixO+n1CV6pHuetV
         NzFBHGdSWkNKBbOIxNhwZ/ag1my3Q01Z6fkwPyhR8toDrMf7wKORI0BFaL1xszn7IOY3
         GAUQb1zjCPWo8a+dwdRmjrELYl5Nd1t5guA9Mif56yfvipeGk2uEYnDkRt7riqnmJK79
         SlrNrgsZw3jMJihH7myojy4cBOJ5AIGPhW1lIduxJJbmKEjaI9GE4NbnfQoIsVW/AEN6
         cP1A==
X-Forwarded-Encrypted: i=1; AJvYcCV6kFWFyyBpSq9UXknQDlMWNZzovvws5LtdeJ4PPj6HFavG3xEchPovNHh1IXlmUD6mRFxm0PulMohMxYBV2mZP4rMvwtI=@vger.kernel.org, AJvYcCXYlJOtjuh1Lnw/nbBok+QOIpCJ0N1cKcu+BBzxPVu0dQ1CoV8W8NXNAlanZMRRxR+VvF70sZ7/7Ko6RbkKsiQXhk5V@vger.kernel.org
X-Gm-Message-State: AOJu0YyDb5bOxzLlSdfo00ngSvGKC8NxHQ3pOyskpg0m3e2OGu/x6SOo
	hRdZjh51hOQlHNeg67VL1nikwarORBsAUMdxSdUYwxxOPI87/7S9rwynQmKt5YmbCax/Bh5nnE/
	WdzNwiW2qnbVAGR1lYFF19tP4SHg=
X-Google-Smtp-Source: AGHT+IFkUZqTQrQDofXcxJE2YOGBMxuxk6S2mMIyQDCVCRY3may9Cv40aInvayxBenz7IhrrEv7tRIO69tMVIutQbxI=
X-Received: by 2002:a05:6e02:b49:b0:3a0:bc89:612 with SMTP id
 e9e14a558f8ab-3a4ed296443mr52283285ab.8.1730053297718; Sun, 27 Oct 2024
 11:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025151128.1854905-1-linux@jordanrome.com>
 <CAEf4BzYsQsj50hJut3+a4NUenZ+6ajfaFL_31NcvBdyoeBTiPg@mail.gmail.com>
 <20241025195228.GA99159@mail.hallyn.com> <CA+QiOd6Ef6V2=DeAc=8VdCJhRtxG5eZCBOPiMzedob1ARnR-zg@mail.gmail.com>
 <20241026100956.GA105650@mail.hallyn.com> <CA+QiOd6R4VcdqtaM3LX47Vjffuk_rSsdra4bdhe1i-+NGK7NDQ@mail.gmail.com>
 <20241026130011.GA106868@mail.hallyn.com>
In-Reply-To: <20241026130011.GA106868@mail.hallyn.com>
From: Jordan Rome <jordan@jordanrome.com>
Date: Sun, 27 Oct 2024 14:21:26 -0400
Message-ID: <CA+QiOd7GeAaZgps80dyAFpOV=uMQssaBLuHXb-dQBBs85RWKgQ@mail.gmail.com>
Subject: Re: [v2] security: add trace event for cap_capable
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 9:00=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Sat, Oct 26, 2024 at 07:22:29AM -0400, Jordan Rome wrote:
> > On Sat, Oct 26, 2024 at 6:10=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > >
> > > On Fri, Oct 25, 2024 at 04:24:05PM -0400, Jordan Rome wrote:
> > > > On Fri, Oct 25, 2024 at 3:52=E2=80=AFPM Serge E. Hallyn <serge@hall=
yn.com> wrote:
> > > > >
> > > > > On Fri, Oct 25, 2024 at 11:37:59AM -0700, Andrii Nakryiko wrote:
> > > > > > On Fri, Oct 25, 2024 at 8:15=E2=80=AFAM Jordan Rome <linux@jord=
anrome.com> wrote:
> > > > > > >
> > > > > > > In cases where we want a stable way to observe/trace
> > > > > > > cap_capable (e.g. protection from inlining and API updates)
> > > > > > > add a tracepoint that passes:
> > > > > > > - The credentials used
> > > > > > > - The user namespace of the resource being accessed
> > > > > > > - The user namespace that has the capability to access the
> > > > > > > targeted resource
> > > > > > > - The capability to check for
> > > > > > > - Bitmask of options defined in include/linux/security.h
> > > > > > > - The return value of the check
> > > > > > >
> > > > > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > > > > ---
> > > > > > >  MAINTAINERS                       |  1 +
> > > > > > >  include/trace/events/capability.h | 60 +++++++++++++++++++++=
++++++++++
> > > > > > >  security/commoncap.c              | 31 +++++++++++-----
> > > > > > >  3 files changed, 84 insertions(+), 8 deletions(-)
> > > > > > >  create mode 100644 include/trace/events/capability.h
> > > > > > >
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index cc40a9d9b8cd..210e9076c858 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -4994,6 +4994,7 @@ M:        Serge Hallyn <serge@hallyn.co=
m>
> > > > > > >  L:     linux-security-module@vger.kernel.org
> > > > > > >  S:     Supported
> > > > > > >  F:     include/linux/capability.h
> > > > > > > +F:     include/trace/events/capability.h
> > > > > > >  F:     include/uapi/linux/capability.h
> > > > > > >  F:     kernel/capability.c
> > > > > > >  F:     security/commoncap.c
> > > > > > > diff --git a/include/trace/events/capability.h b/include/trac=
e/events/capability.h
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..e706ce690c38
> > > > > > > --- /dev/null
> > > > > > > +++ b/include/trace/events/capability.h
> > > > > > > @@ -0,0 +1,60 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > +#undef TRACE_SYSTEM
> > > > > > > +#define TRACE_SYSTEM capability
> > > > > > > +
> > > > > > > +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MU=
LTI_READ)
> > > > > > > +#define _TRACE_CAPABILITY_H
> > > > > > > +
> > > > > > > +#include <linux/cred.h>
> > > > > > > +#include <linux/tracepoint.h>
> > > > > > > +#include <linux/user_namespace.h>
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * cap_capable - called after it's determined if a task has =
a particular
> > > > > > > + * effective capability
> > > > > > > + *
> > > > > > > + * @cred: The credentials used
> > > > > > > + * @targ_ns: The user namespace of the resource being access=
ed
> > > > > > > + * @capable_ns: The user namespace in which the credential p=
rovides the
> > > > > > > + *              capability to access the targeted resource.
> > > > > > > + *              This will be NULL if ret is not 0.
> > > > > > > + * @cap: The capability to check for
> > > > > > > + * @opts: Bitmask of options defined in include/linux/securi=
ty.h
> > > > > > > + * @ret: The return value of the check: 0 if it does, -ve if=
 it does not
> > > > > > > + *
> > > > > > > + * Allows to trace calls to cap_capable in commoncap.c
> > > > > > > + */
> > > > > > > +TRACE_EVENT(cap_capable,
> > > > > > > +
> > > > > > > +       TP_PROTO(const struct cred *cred, struct user_namespa=
ce *targ_ns,
> > > > > > > +               struct user_namespace *capable_ns, int cap, u=
nsigned int opts, int ret),
> > > > > > > +
> > > > > > > +       TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > > > > > > +
> > > > > > > +       TP_STRUCT__entry(
> > > > > > > +               __field(const struct cred *, cred)
> > > > > > > +               __field(struct user_namespace *, targ_ns)
> > > > > > > +               __field(struct user_namespace *, capable_ns)
> > > > > > > +               __field(int, cap)
> > > > > > > +               __field(unsigned int, opts)
> > > > > > > +               __field(int, ret)
> > > > > > > +       ),
> > > > > > > +
> > > > > > > +       TP_fast_assign(
> > > > > > > +               __entry->cred       =3D cred;
> > > > > > > +               __entry->targ_ns    =3D targ_ns;
> > > > > > > +               __entry->capable_ns =3D capable_ns;
> > > > > > > +               __entry->cap        =3D cap;
> > > > > > > +               __entry->opts       =3D opts;
> > > > > > > +               __entry->ret        =3D ret;
> > > > > > > +       ),
> > > > > > > +
> > > > > > > +       TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d=
, opts %u, ret %d",
> > > > > > > +               __entry->cred, __entry->targ_ns, __entry->cap=
able_ns, __entry->cap,
> > > > > > > +               __entry->opts, __entry->ret)
> > > > > > > +);
> > > > > > > +
> > > > > > > +#endif /* _TRACE_CAPABILITY_H */
> > > > > > > +
> > > > > > > +/* This part must be outside protection */
> > > > > > > +#include <trace/define_trace.h>
> > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > index 162d96b3a676..12c3ddfe0d6e 100644
> > > > > > > --- a/security/commoncap.c
> > > > > > > +++ b/security/commoncap.c
> > > > > > > @@ -27,6 +27,9 @@
> > > > > > >  #include <linux/mnt_idmapping.h>
> > > > > > >  #include <uapi/linux/lsm.h>
> > > > > > >
> > > > > > > +#define CREATE_TRACE_POINTS
> > > > > > > +#include <trace/events/capability.h>
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * If a non-root user executes a setuid-root binary in
> > > > > > >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > > > > > > @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(con=
st char *fname)
> > > > > > >  /**
> > > > > > >   * cap_capable - Determine whether a task has a particular e=
ffective capability
> > > > > > >   * @cred: The credentials to use
> > > > > > > - * @targ_ns:  The user namespace in which we need the capabi=
lity
> > > > > > > + * @targ_ns:  The user namespace of the resource being acces=
sed
> > > > > > >   * @cap: The capability to check for
> > > > > > >   * @opts: Bitmask of options defined in include/linux/securi=
ty.h
> > > > > > >   *
> > > > > > > @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, st=
ruct user_namespace *targ_ns,
> > > > > > >                 int cap, unsigned int opts)
> > > > > > >  {
> > > > > > >         struct user_namespace *ns =3D targ_ns;
> > > > > > > +       int ret =3D -EPERM;
> > > > > > >
> > > > > > >         /* See if cred has the capability in the target user =
namespace
> > > > > > >          * by examining the target user namespace and all of =
the target
> > > > > > > @@ -75,22 +79,32 @@ int cap_capable(const struct cred *cred, =
struct user_namespace *targ_ns,
> > > > > > >          */
> > > > > > >         for (;;) {
> > > > > > >                 /* Do we have the necessary capabilities? */
> > > > > > > -               if (ns =3D=3D cred->user_ns)
> > > > > > > -                       return cap_raised(cred->cap_effective=
, cap) ? 0 : -EPERM;
> > > > > > > +               if (ns =3D=3D cred->user_ns) {
> > > > > > > +                       if (cap_raised(cred->cap_effective, c=
ap))
> > > > > > > +                               ret =3D 0;
> > > > > > > +                       else
> > > > > > > +                               ns =3D NULL;
> > > > > >
> > > > > > This is a bit unfortunate :( so maybe all we needed was `ns =3D
> > > > > > ns->parent` for that one use case, and keep the original `ret ?=
 NULL :
> > > > > > ns` inside trace_cap_capable().
> > > > >
> > > > > Yeah, that would be fine with me.  Or maybe just doing
> > > > >
> > > > >         /* in case of an error, trace should show ns=3DNULL */
> > > > >         if (ret)
> > > > >                 ns =3D NULL;
> > > > >
> > > > > right above the trace_cap_capable() call would be clearer.
> > > >
> > > > I feel like having less trace specific logic in this function would=
 be
> > > > a good thing,
> > > > so I'm for Andrii's suggestion of doing the ret check there but als=
o
> > > > fine to do what security folks prefer :)
> > >
> > > I think a comment is needed to remind us (me) in 2 years why the
> > > seting of ns to NULL is there.  But the comment of trace_cap_capable(=
)
> > > probably suffices, so sure, go with Andrii's suggestion.  And then
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > >
> > > for the capability code.
> > >
> > > thanks,
> > > -serge
> >
> > I think we're suggesting to not set ns =3D NULL here and instead
> > check the ret value in the trace code e.g.
> > `__entry->capable_ns =3D ret ? NULL : capable_ns;`
>
> Perfect.  Was originally going to suggest this, but then thought well
> the rest of the ns logic is purely capability not tracing related.
> But since the comment is in trace_cap_capable(), putting the assignment
> there makes sense.
>

Actually, I had another idea. What about just having a separate
variable in the `cap_capable` function for `capable_ns` that only gets
set if ret is 0. Then we're not changing the `ns` variable at all for
the purposes of the trace function.

> > I think the only trace-specific thing, which I can add a comment
> > for, is this part `ns =3D ns->parent;` after we already set the ret to =
0.

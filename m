Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF61D54FE;
	Fri, 25 Oct 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855374; cv=none; b=P/Z5s+Dn836W4Q/RR6UXn/I4AOJvsHzMZsU3QIgPX5BobPC1ln9yxleY2OaC9oMp2l65JwcW8oHW9QsjDE0Ie7HwupsZMJZKPdjJODBLiOHzGyxMCz5ID6iXuiiimAE/VsXGSxHf6elQPT4/LNvXPXm8HATJxEY8x5VYkYkajJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855374; c=relaxed/simple;
	bh=rrI45wf5CBc27Admq4q2stn59cCbzi4LzHIv5YZ+rYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXfFWfYLS+pu7MOdKwK+o6DSRVBor50xxLiEKnCiaSSj1WKGY0e71UL2o3fa0WGboRzX/7UA05jM72+oSZEHgn30Iu3LREjP7qoTl+ALBrz/FEzLCwRsLuFu4+BMrK9/BavUCeEtNPDQf6bqbwI+maC+TuSgqUzn6US93ql2mL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=i1EWZ1Rs; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="i1EWZ1Rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729855363; x=1730460163; i=linux@jordanrome.com;
	bh=Difhpxy1BDme4NlrdDcsv2pJKm1STBHDdCAHNycYE2Y=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i1EWZ1RsUhxaC8K/19bmGXItxZ0kHXj1D1hOFeF+Wv5RH/iZLJ4SyY9j7zcNLpxU
	 VY1iM43o3L3EwhfbviiVZzNhMo+1YeaoRgw+B90WfS1HNPA1ve9JrO4VnmJJApRNa
	 8BqpVQT7VAri62FKaxXdS1X1MMvqMsuPCF/cK5T+QqT6jFapnoE/Z8oEVQzV5BR9V
	 gNBIJKJUy6gWz8JGXJkg4IGDX9UXJMibHzocuyGYghDgWPHGGCxX5rUhTTnqKez7Y
	 b/iHgS/0CY5eX6jX+h6RAoY9SHHxNmHVJUBOPBNPLItTP3IPKc6qY/dAgMintE4sZ
	 OFZWF/+NNE1XZ/NzXg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f175.google.com ([209.85.166.175]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M5MVt-1tonr22q8l-011w86; Fri, 25 Oct 2024 13:22:43 +0200
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e474983fso3314655ab.1;
        Fri, 25 Oct 2024 04:22:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3EAUK+1sg1BU22dvVan2q+rIqW8PpTnPsGo0S5FrUEXvvxbuTl/ds3BmjmxiEIHIligQgw2ALnl3kbhDh9An7EdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRs34guXcYmAVSSOtmQcqJmCLOowOuNyaYdWfkMNzmK/Vg8f+
	m2IKGALN/B0OIXbbQaGcxIxcNh8J6i0CPCLZHW5TiUJsHK7653Ci5mYMwA9gjDSAlfYChzgSTqP
	JjHWvlJiCqpJg56vNBazaGT8kKDk=
X-Google-Smtp-Source: AGHT+IG9pTnT5wHA0IwToKEYRKPZ8ycXu/t+1My6uVEyjr5XYKP6oeioDph0e2R4aK67omb06BNlhKsX2nsocP+tAMs=
X-Received: by 2002:a05:6e02:2196:b0:3a3:35f0:4c19 with SMTP id
 e9e14a558f8ab-3a4d59cfb10mr102031305ab.21.1729855363153; Fri, 25 Oct 2024
 04:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024104012.1815022-1-linux@jordanrome.com>
 <Zxqt29vYukIGw8QV@lei> <CA+QiOd4J9=7-7v_Vh5YR7+BVTGYPzD6ARKxrrKWtPtKP3Oj8SQ@mail.gmail.com>
 <Zxt-cRp3QMP6dpCa@lei>
In-Reply-To: <Zxt-cRp3QMP6dpCa@lei>
From: Jordan Rome <linux@jordanrome.com>
Date: Fri, 25 Oct 2024 07:22:31 -0400
X-Gmail-Original-Message-ID: <CA+QiOd6rLrjw7E04vaqdb49smFrYU9X7zfXRhTSP2oCPsCFuUA@mail.gmail.com>
Message-ID: <CA+QiOd6rLrjw7E04vaqdb49smFrYU9X7zfXRhTSP2oCPsCFuUA@mail.gmail.com>
Subject: Re: [v1] security: add trace event for cap_capable
To: sergeh@kernel.org
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X4wbN+ABfrLnqAmK1+MVJvnwgLp3vraIqV+YW7t7BQ93z+bJD5m
 FImBTYKUr/CQpxR2U2PPR+EtvYKeoTcwZVhTnp332Zmxp+m7K1vKtlFj/5ZvBl5+J0GDrIH
 FUQ1rSpacdLRF7KlPlFuw2J+uC93NKUULg+tvMgR/ddlqGnNp78q6ymcQ23tm7YV45rW+Mz
 zV6sWlJ9v557//wgiPWaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A9pSRrXv6ns=;3Nrx5p/oaeR6LeZ+prLfL4/KFm/
 /Ir67e9C+bOkgm+eP4iShJpBSG0au66eIHpgoNmw558JFLEB39BECqxpjDWmbVtiMid79BtlK
 8N9/FC5aI1EV+9OUrfylciLLj22tOV3LmJj+/vIkDDAlx4FIrolGcwFbDuko0NVvp73eUouX3
 2znSOJtbgOgiiAUFA+gJmPa2kx5rXQy2l/gdaNFERrUM1DKSBNFvTuyn57XfY+40SvZocTbjB
 Mwnqo3oCU2p+MQY8XqQ6MLHicQ7BFzkUlb4ZaxqPkTMxmtLlWY3iF8+w87iWDom9TuSmthmjn
 G7cVbY981OUAPOGrUaCn87h4YzZB7PhQLYsFG2+/76YRWogtdA00eLqq2g3IAYXPThDy5j15N
 36VdrQvvDU2E885NaiecR93BKJsGqytlbiN+YJgKLMJ/zHAVz+DpXovSRJ0LjfDJiX2zAJXyt
 qwpzRVM/0WIHtYdRMaJY34z8egk2rB1sGD2tE31BBQiebCARWVnQor5qDAU2SYcHBonWfj923
 hyQEUi3CWXcT2ApMLl4+xLXy+9UEnyYJV1lb5DJ99kTFH1vYKx8DHolgHysl6J/qabe9K679C
 JwBOCjPyt6cm8vqxrxcjol8hWt77iWZV9Mknu1JcGHV4xt2FdnfOOsNamzQZXFBl6JjwE5LuV
 8F3WrXI37qqUH/ClhYX1a8WCxeW+gil5D1oNX3XwY/4MGPqd7vMWEf+CHFnAYdfwob0wLfv0w
 dsJWjJP7E3ik2Z43rYOvd9lip65h+vafA==

On Fri, Oct 25, 2024 at 7:18=E2=80=AFAM <sergeh@kernel.org> wrote:
>
> On Thu, Oct 24, 2024 at 09:15:56PM -0400, Jordan Rome wrote:
> > On Thu, Oct 24, 2024 at 4:28=E2=80=AFPM <sergeh@kernel.org> wrote:
> > >
> > > On Thu, Oct 24, 2024 at 03:40:12AM -0700, Jordan Rome wrote:
> > > > In cases where we want a stable way to observe/trace
> > > > cap_capable (e.g. protection from inlining and API updates)
> > > > add a tracepoint that passes:
> > > > - The credentials used
> > > > - The user namespace which needs the capability
> > >
> > > "the user namespace which needs the capability" is not quite the
> > > right way to put this.  It's the user namespace against which the
> > > capability is needed.  It's an object, not a subject.  Or maybe
> > > "the user namespace of the resource being accessed".
> > >
> >
> > I like "The user namespace of the resource being accessed"
> >
> > > > - The user namespace that actually has the capability (if one exist=
s)
> > >
> > > How about "the user namespace in which the task has the
> > > capability targeted at the resource"?  (It's not the user
> > > namespace itself that has the capability)
> > >
> >
> > This phrasing seems a little confusing. How about:
> > "The user namespace that has the capability to access the targeted reso=
urce" ?
>
> The problem again is that it's not the user namespace that has the
> capability.  The cred has the capability in that user namespace.
>
> "The user namespace in which the credential has the capability to access
> the targeted resource"?
>
> Or maybe s/has/provides/.
>

This sounds good to me with "provides"

> > > > - The capability to check for
> > > > - Bitmask of options defined in include/linux/security.h
> > > > - The return value of the check
> > > >
> > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > ---
> > > >  MAINTAINERS                       |  1 +
> > > >  include/trace/events/capability.h | 58 +++++++++++++++++++++++++++=
++++
> > > >  security/commoncap.c              | 21 +++++++----
> > > >  3 files changed, 74 insertions(+), 6 deletions(-)
> > > >  create mode 100644 include/trace/events/capability.h
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index cc40a9d9b8cd..210e9076c858 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -4994,6 +4994,7 @@ M:      Serge Hallyn <serge@hallyn.com>
> > > >  L:   linux-security-module@vger.kernel.org
> > > >  S:   Supported
> > > >  F:   include/linux/capability.h
> > > > +F:   include/trace/events/capability.h
> > > >  F:   include/uapi/linux/capability.h
> > > >  F:   kernel/capability.c
> > > >  F:   security/commoncap.c
> > > > diff --git a/include/trace/events/capability.h b/include/trace/even=
ts/capability.h
> > > > new file mode 100644
> > > > index 000000000000..092b8e77063a
> > > > --- /dev/null
> > > > +++ b/include/trace/events/capability.h
> > > > @@ -0,0 +1,58 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#undef TRACE_SYSTEM
> > > > +#define TRACE_SYSTEM capability
> > > > +
> > > > +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_RE=
AD)
> > > > +#define _TRACE_CAPABILITY_H
> > > > +
> > > > +#include <linux/cred.h>
> > > > +#include <linux/tracepoint.h>
> > > > +#include <linux/user_namespace.h>
> > > > +
> > > > +/**
> > > > + * capable - called after it's determined if a task has a particul=
ar
> > > > + * effective capability
> > > > + *
> > > > + * @cred: The credentials used
> > > > + * @targ_ns:  The user namespace which needs the capability
> > >
> > > (same here)
> > >
> > > > + * @capable_ns:  The user namespace that actually has the capabili=
ty
> > > > + *               if ret is 0 otherwise this will be NULL
> > > > + * @cap: The capability to check for
> > > > + * @opts: Bitmask of options defined in include/linux/security.h
> > > > + * @ret: The return value of the check: 0 if it does, -ve if it do=
es not
> > > > + *
> > > > + * Allows to trace calls to cap_capable in commoncap.c
> > > > + */
> > > > +TRACE_EVENT(capable,
> > > > +
> > > > +     TP_PROTO(const struct cred *cred, struct user_namespace *targ=
_ns,
> > > > +             struct user_namespace *capable_ns, int cap, unsigned =
int opts, int ret),
> > > > +
> > > > +     TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > > > +
> > > > +     TP_STRUCT__entry(
> > > > +             __field(const struct cred *, cred)
> > > > +             __field(struct user_namespace *, targ_ns)
> > > > +             __field(struct user_namespace *, capable_ns)
> > > > +             __field(int, cap)
> > > > +             __field(unsigned int, opts)
> > > > +             __field(int, ret)
> > > > +     ),
> > > > +
> > > > +     TP_fast_assign(
> > > > +             __entry->cred       =3D cred;
> > > > +             __entry->targ_ns    =3D targ_ns;
> > > > +             __entry->capable_ns =3D capable_ns;
> > > > +             __entry->cap        =3D cap;
> > > > +             __entry->opts       =3D opts;
> > > > +             __entry->ret        =3D ret;
> > > > +     ),
> > > > +
> > > > +     TP_printk("cap %d, opts %u, ret %d",
> > > > +             __entry->cap, __entry->opts, __entry->ret)
> > > > +);
> > > > +
> > > > +#endif /* _TRACE_CAPABILITY_H */
> > > > +
> > > > +/* This part must be outside protection */
> > > > +#include <trace/define_trace.h>
> > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > index 162d96b3a676..675d40fbaa77 100644
> > > > --- a/security/commoncap.c
> > > > +++ b/security/commoncap.c
> > > > @@ -27,6 +27,9 @@
> > > >  #include <linux/mnt_idmapping.h>
> > > >  #include <uapi/linux/lsm.h>
> > > >
> > > > +#define CREATE_TRACE_POINTS
> > > > +#include <trace/events/capability.h>
> > > > +
> > > >  /*
> > > >   * If a non-root user executes a setuid-root binary in
> > > >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > > > @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct u=
ser_namespace *targ_ns,
> > > >               int cap, unsigned int opts)
> > > >  {
> > > >       struct user_namespace *ns =3D targ_ns;
> > > > +     int ret =3D 0;
> > > >
> > > >       /* See if cred has the capability in the target user namespac=
e
> > > >        * by examining the target user namespace and all of the targ=
et
> > > > @@ -75,22 +79,26 @@ int cap_capable(const struct cred *cred, struct=
 user_namespace *targ_ns,
> > > >        */
> > > >       for (;;) {
> > > >               /* Do we have the necessary capabilities? */
> > > > -             if (ns =3D=3D cred->user_ns)
> > > > -                     return cap_raised(cred->cap_effective, cap) ?=
 0 : -EPERM;
> > > > +             if (ns =3D=3D cred->user_ns) {
> > > > +                     ret =3D cap_raised(cred->cap_effective, cap) =
? 0 : -EPERM;
> > > > +                     break;
> > > > +             }
> > > >
> > > >               /*
> > > >                * If we're already at a lower level than we're looki=
ng for,
> > > >                * we're done searching.
> > > >                */
> > > > -             if (ns->level <=3D cred->user_ns->level)
> > > > -                     return -EPERM;
> > > > +             if (ns->level <=3D cred->user_ns->level) {
> > > > +                     ret =3D -EPERM;
> > > > +                     break;
> > > > +             }
> > > >
> > > >               /*
> > > >                * The owner of the user namespace in the parent of t=
he
> > > >                * user namespace has all caps.
> > > >                */
> > > >               if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->o=
wner, cred->euid))
> > > > -                     return 0;
> > > > +                     break;
> > > >
> > > >               /*
> > > >                * If you have a capability in a parent user ns, then=
 you have
> > > > @@ -99,7 +107,8 @@ int cap_capable(const struct cred *cred, struct =
user_namespace *targ_ns,
> > > >               ns =3D ns->parent;
> > > >       }
> > > >
> > > > -     /* We never get here */
> > >
> > > With this change, I become less comfortable with us assuming that it =
is
> > > the case that we'll never just drop off the end of the while loop.  I=
'd
> > > be more comfortable if you set ret =3D -EPERM at the top, and set it =
to 0
> > > in the last break.
> > >
> >
> > Sure. I can make this change.
> >
> > > > +     trace_capable(cred, targ_ns, ret =3D=3D 0 ? ns : NULL, cap, o=
pts, ret);
> > > > +     return ret;
> > > >  }
> > > >
> > > >  /**
> > > > --
> > > > 2.43.5
> > > >

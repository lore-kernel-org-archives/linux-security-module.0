Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB51E0DE9;
	Wed, 30 Oct 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283409; cv=none; b=MyIrcpBakP8IC5we6EKN8Z11g/S+m5vEqJOo3tP7gH16UzKh0+bC1LagpInZLSonZCjDHpFGSxY90jYmFMa7rKnnhdWGTB2y6QFmjWWpsvXIEpQP7H2Qf/0bgXUWbhrKfITMaNKpizEDxVaBAX2kHcIQmpzqqXMoRvPbMgltAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283409; c=relaxed/simple;
	bh=E/rFvdJApUpJyph2gfJJQldyxcLs+xTKl8rfjRUBZT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYCRSEDeGv/afQjV660TFpS7xY1VCfXtKgygbV/hlI7V5+QFHioNFukuUvOCdBqU1iOGf0mcXNLfyULoAKl9uGi40NWA0rAw/WaDd90tL19qTDbfvoWMxMO7LLR/Sz94Gmfk4n6YtZe3gSvjrzujlODzg3gF5CJDe5mPd5u+8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=hAvqv8rF; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="hAvqv8rF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1730283399; x=1730888199; i=linux@jordanrome.com;
	bh=M1am8RhwqqcMhGm3t1+7hgRBjUeVvT2ZjDy8RKIo3os=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hAvqv8rFaHX+VSl0b2ULmFbZRpliYfyXmhU1mupJ1rvpBFfH6bpRbNKQ6S2ossyT
	 Oin1JTw7isq7GP1kTPYOsMxBd2c8kRoGYf1tEQBOfwYJ9ZSWI6eSnKEk33PjirK+C
	 9F/HdOaEospX0xkojocP6fkstP1ocz3GHgQ8uNNY7wNOWIsXOwf+cMDE2S9GLoKfG
	 vExS56EYbAlcVibFVVk86RDe96YvwyRoA1qa5+saKd1+2HcId7nYvDCgPZeLWbevf
	 Y2Osvr5ifa7RuwfNPgDB9J0m4PF06NCecb/bDTuFbOZGmMZQeJudgP3zeto9BBn+q
	 cJk1m30MHZHNS61r6A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f171.google.com ([209.85.166.171]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LsBFB-1trM5o0B7H-00xaL0; Wed, 30 Oct 2024 11:16:39 +0100
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b2499c65so21070785ab.0;
        Wed, 30 Oct 2024 03:16:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwSKIqJC4uhFfZWVq1uGRHxWsHyrch3/GdwbYz4X+mU0s8iXN3jKMFLwEZSEVnnIipxlfA0geL7XTd7UZsh6jNY1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpYB13dfNMbi8aHmMoegE9sEv0lzoEAC+YEFEJtHopd0D04cg
	kQEHkbFeUrspffdKHWS+2pbDcakJ5hX1HREMN7oj+QxAMuB8NWlGts4MYe2ZZ3EabqyLvPA+VH0
	nQtlBiOn+UsjrzjQdwL5/3tNSYuk=
X-Google-Smtp-Source: AGHT+IHC12LIa6iajDQrSXsUGuABTKPtPzWE0LXGDO0/8ik9TwdfZ14myWksrtyJJLPuRl51j39w0zdRkJztRoH00TI=
X-Received: by 2002:a05:6e02:1fcc:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a4ed3057c0mr123503285ab.22.1730283398543; Wed, 30 Oct 2024
 03:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030013314.2188163-1-linux@jordanrome.com> <20241030031801.GA149820@mail.hallyn.com>
In-Reply-To: <20241030031801.GA149820@mail.hallyn.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Wed, 30 Oct 2024 06:16:27 -0400
X-Gmail-Original-Message-ID: <CA+QiOd7Fs6v15V+K7ecvzND5bFHR1PYGPESQeutm19W_iJkn-A@mail.gmail.com>
Message-ID: <CA+QiOd7Fs6v15V+K7ecvzND5bFHR1PYGPESQeutm19W_iJkn-A@mail.gmail.com>
Subject: Re: [v4] security: add trace event for cap_capable
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BgeZJdpYP5tNJ9gwSM0gygq8rbqmNll/qOiCU9T3SxAGEPFqcC6
 KP2fRrpBFgDH6d19v583uwYGMIFji7HT9PyboBqu3SERsBeM79RQwtdwXWyp4Whgdzdgk7d
 5ZbYXr6xFzwvMQVhDP82T0NtocD1c0p+B07b5R6Kd8SkYWiFqJYJu8VG6cwKRNTOpu9CkVp
 cL7esdtZ4ugpXFKCpNQtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rQW8ZdRtjE0=;YWOFQoiH4siv9xMqBQzAH3dBppj
 PFZxujEb27qXJN6exYtcoG2eQ1TVElJKJ/MjQnoKPwQN7Ij2gSEkrZ7sC+ebM5MMRVRIkw09u
 PKFnUKnUWBDY+mU6RuM18iw9BN7JlfKUWt1pS4LP3qlVbvj0frQcdLOwjwNAo92hrUU2GMEGE
 uyfXFkYKz+sF8JMPJQ2bVGV0I3ctWVimwb/PqSAi8GDiQnWAKDSo1KhwEvEy+lwYBRks0C2rz
 wWKMF2g3Ea0tfMnRWyQ0tVwga84qCETyrp5MFLwB0ODAnatql6SqCZ0S1uLDxb7oh+MrBKkD8
 IGvMiOR9OPnehY+8A4YknO6Gm8GuORK/lv+zb1uoXSmwxtiWEM43gooSGRXbnLOGGTQ7qhBKs
 7waSi8pK4LsvNw1Qiq2UDk/yfW35oYTmfKLMEEqLo38auCIm28pEfeneLaECMvk9OjjsrqhRs
 1b74PUpFfwUUGTORRZ/ZfpvKyuUhDkMj1mdlMqPx8iEZQ6jemdZc0/2KQP7npW/87nXxzzo5d
 y3hILkTIIW9C910O1K1cFNSjKFhvFgY3V/H80ZlesXR9pEVwQIR7V6plLx9s6StaYqjJSMhKh
 R/OrHanDc4ugm5ToP5kLAVjWiFjL1vdov2btyOP7sZBsYzddZFZ7nKcHEcjCNFK9x/diYxEWb
 L28q+7BxvQkgpLHSbg4yjov7HP/52lyENEVvhW6b/g/Oy7tRGHqMEUXdj1O+LfQYet7fLiEln
 RzapDBnM+OSaGdaRjgIQYYfEKP/dRepaA==

On Tue, Oct 29, 2024 at 11:18=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
>
> On Tue, Oct 29, 2024 at 06:33:14PM -0700, Jordan Rome wrote:
> > In cases where we want a stable way to observe/trace
> > cap_capable (e.g. protection from inlining and API updates)
> > add a tracepoint that passes:
> > - The credentials used
> > - The user namespace of the resource being accessed
> > - The user namespace in which the credential provides the
> > capability to access the targeted resource
> > - The capability to check for
> > - Bitmask of options defined in include/linux/security.h
> > - The return value of the check
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
>
> Thanks.  I'll pull this into the capability tree tomorrow so it can be
> tested in linux-next  (and Andrii's ack unless he objects).
>

Awesome. Thanks for the review, Serge!

> > ---
> >  MAINTAINERS                       |  1 +
> >  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
> >  security/commoncap.c              | 30 +++++++++++-----
> >  3 files changed, 83 insertions(+), 8 deletions(-)
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
> > index 000000000000..e706ce690c38
> > --- /dev/null
> > +++ b/include/trace/events/capability.h
> > @@ -0,0 +1,60 @@
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
> > + * cap_capable - called after it's determined if a task has a particul=
ar
> > + * effective capability
> > + *
> > + * @cred: The credentials used
> > + * @targ_ns: The user namespace of the resource being accessed
> > + * @capable_ns: The user namespace in which the credential provides th=
e
> > + *              capability to access the targeted resource.
> > + *              This will be NULL if ret is not 0.
> > + * @cap: The capability to check for
> > + * @opts: Bitmask of options defined in include/linux/security.h
> > + * @ret: The return value of the check: 0 if it does, -ve if it does n=
ot
> > + *
> > + * Allows to trace calls to cap_capable in commoncap.c
> > + */
> > +TRACE_EVENT(cap_capable,
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
> > +     TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, opts %u, r=
et %d",
> > +             __entry->cred, __entry->targ_ns, __entry->capable_ns, __e=
ntry->cap,
> > +             __entry->opts, __entry->ret)
> > +);
> > +
> > +#endif /* _TRACE_CAPABILITY_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 162d96b3a676..7a74eb27eebf 100644
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
> > @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const char *f=
name)
> >  /**
> >   * cap_capable - Determine whether a task has a particular effective c=
apability
> >   * @cred: The credentials to use
> > - * @targ_ns:  The user namespace in which we need the capability
> > + * @targ_ns:  The user namespace of the resource being accessed
> >   * @cap: The capability to check for
> >   * @opts: Bitmask of options defined in include/linux/security.h
> >   *
> > @@ -67,7 +70,9 @@ static void warn_setuid_and_fcaps_mixed(const char *f=
name)
> >  int cap_capable(const struct cred *cred, struct user_namespace *targ_n=
s,
> >               int cap, unsigned int opts)
> >  {
> > -     struct user_namespace *ns =3D targ_ns;
> > +     int ret =3D -EPERM;
> > +     struct user_namespace *capable_ns =3D NULL,
> > +             *ns =3D targ_ns;
> >
> >       /* See if cred has the capability in the target user namespace
> >        * by examining the target user namespace and all of the target
> > @@ -75,22 +80,30 @@ int cap_capable(const struct cred *cred, struct use=
r_namespace *targ_ns,
> >        */
> >       for (;;) {
> >               /* Do we have the necessary capabilities? */
> > -             if (ns =3D=3D cred->user_ns)
> > -                     return cap_raised(cred->cap_effective, cap) ? 0 :=
 -EPERM;
> > +             if (ns =3D=3D cred->user_ns) {
> > +                     if (cap_raised(cred->cap_effective, cap)) {
> > +                             capable_ns =3D ns;
> > +                             ret =3D 0;
> > +                     }
> > +                     break;
> > +             }
> >
> >               /*
> >                * If we're already at a lower level than we're looking f=
or,
> >                * we're done searching.
> >                */
> >               if (ns->level <=3D cred->user_ns->level)
> > -                     return -EPERM;
> > +                     break;
> >
> >               /*
> >                * The owner of the user namespace in the parent of the
> >                * user namespace has all caps.
> >                */
> > -             if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid))
> > -                     return 0;
> > +             if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid)) {
> > +                     capable_ns =3D ns->parent;
> > +                     ret =3D 0;
> > +                     break;
> > +             }
> >
> >               /*
> >                * If you have a capability in a parent user ns, then you=
 have
> > @@ -99,7 +112,8 @@ int cap_capable(const struct cred *cred, struct user=
_namespace *targ_ns,
> >               ns =3D ns->parent;
> >       }
> >
> > -     /* We never get here */
> > +     trace_cap_capable(cred, targ_ns, capable_ns, cap, opts, ret);
> > +     return ret;
> >  }
> >
> >  /**
> > --
> > 2.43.5

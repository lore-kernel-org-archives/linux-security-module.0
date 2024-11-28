Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F59463;
	Thu, 28 Nov 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813779; cv=none; b=a7In/T7aCqALvAk+iVMPafh8biUDwusFDrZzF5dQJduJCJJKcb/Yk6KE7fpPGhcXPwn7zfBZK+u570Wu7IHiZo1iTW9rfD13OyFHZeWlyg7ABM+juuWfKKBRgZcCVzYng8DeCQOepgrjOtqjbVt2GpVWP/V7kbhq+RejXaPhQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813779; c=relaxed/simple;
	bh=oM8f9l8HvAg5WiiDu5rzeNBsk7VK++ik0XX68UPePUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=japHUy+0sxaEvZXR/HH+c6qWsqr/wKcnYJij9uAkH7og9uKkAH91VMbym9T6WuGry/3OzjGuJcXHZqO6Ygpkfm+5i3IfB6fOJvTaj/mv6DigS7/BH8CdxbLXssfJDM3IUN/+OYFn9tvcINTv4C6KMnaMjGMsYTgSsX46cCeUGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=jwl03Iot; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="jwl03Iot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1732813775; x=1733418575; i=linux@jordanrome.com;
	bh=J/TFCL0zXH6mVMd6vTkxQ1dtVIIDPAmta/f1woAppzg=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jwl03IotXlur/d3qZ/GlLzAilaOrfvQVYmfj3npn7BF53rPYSnF3H2xoUPH6A87l
	 Nyp5i5Z+q5VInx5qMuu9TAV0pYebpFJsPbwKWKfTmAIub79xDgS33FQvNPI7f8STx
	 4Wd1eMbs79Ogec81BHbSQanZvlLWLc6b6jkgGFJq8cVxZRe8YY9uy/TcjmMWI6PQ6
	 yLMYvnXpgZnxLSLpF4BZGo9KydeqwSusLKmlxxY28iwOOykcjsVjxn2sLROrYOPsS
	 t7jc9tBf0QYl+EG3UQCqsHuYFXvJtxe8+omqPxLsOH9YcdvUxQKT3DxwwwbPRAeEb
	 snDTs0WMrQGpWeyaZw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f178.google.com ([209.85.166.178]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MPoLf-1t4Pvw1K8R-00P1IG; Thu, 28 Nov 2024 18:09:35 +0100
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a73e045cf3so4113105ab.1;
        Thu, 28 Nov 2024 09:09:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpdibE0Z9QBgWeJXHoprxaxqKUKQZgODr26KeRS+npoAodXGcXbKzk9ejPf58XH6gjZTG4qf4cpIeKG3NRH3XYUgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOyJ5OOchkzg+wsgzDy5h7f8mCSRaYnsWq/ytpWSIWq7Z1jB9
	QRuZ9yf2Yp0s+J4f8Ix1wdaldVlpK6LPkSra14HbgP3DK83J+AIgS2wnMcTCunFkC+MHtgcSPOk
	ox+cin4TqDYrkSH2ibrhuNcAB1R8=
X-Google-Smtp-Source: AGHT+IFxvm8jhT2X8NQX3qVSR4wTgd8VmF2foZNcFDYiiJxMt2HbzZIFIIg5Qk9G3GF7oBjZCe9FTqi4l8eM4TaZoUg=
X-Received: by 2002:a05:6e02:1a03:b0:3a7:8720:9dec with SMTP id
 e9e14a558f8ab-3a7c5525428mr72689865ab.2.1732813774766; Thu, 28 Nov 2024
 09:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128153733.1542817-1-linux@jordanrome.com> <20241128163452.GA40476@mail.hallyn.com>
In-Reply-To: <20241128163452.GA40476@mail.hallyn.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Thu, 28 Nov 2024 12:09:23 -0500
X-Gmail-Original-Message-ID: <CA+QiOd7QE-mzdYar=jNTkkqrVOxZNrrZLSii8_-rANBBJNiMRQ@mail.gmail.com>
Message-ID: <CA+QiOd7QE-mzdYar=jNTkkqrVOxZNrrZLSii8_-rANBBJNiMRQ@mail.gmail.com>
Subject: Re: [v7] security: add trace event for cap_capable
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <sergeh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zq2kEeO3dTBijr0b8XBmAQLlKrcDS/7LPes8DBVcEKwRkQ5ArPG
 CNWOu8Qn7qc9UU2I4RR6btWepa7Jo/JZYzqlDADTE6VAlSeqKA6Pp1bfW/XKWRpsVlmhnd3
 /0jW2zfZ+Jg7a6M7mvi1nBK5eh0GDoKuscKMkJL9lQTgxQ3IIIURuWuaYOdUIC8b4tZTrxV
 eGQu0tBjKecuyRcvUmg8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h1j48uDeI74=;JaBgGb5RRLoCqX9mIuZS8CAieYp
 dBo/AieiC99ljWvgFRZ7DXjSO85WaB3XKZDpKpcQf2acna6EvucMnnxhYmACmMxvSCWjynaUx
 3eoVoYp8mPPekrqDmO0VtgmxCqsGtSEFGqEiaD4t0hXDmZpbaixkjubiBvctTQsA7poFPqjdC
 7XW74xJUR5M6zJ9ugwwIKQIDJHGrASYsx6v4wEeJBlnCbzBVgmImDwzHVOmJkkMZ2nlx67OOL
 zq7lynZOEJtFS/AGnWvba42gyHBnhOqybTrTFEdnKqq0uBBbG5LqGFnLPrZfsX9HJnpFs/mS0
 VeL2U0yKoKa2P1FW7IenlSwsgCz01fRKZ0XQtZj17mL46E/T48aHuFuJK7r9pIjjsubXsiw1b
 5TxegJTz1Jewk6d8jshftKa0bP6Ktq9R0856hPUA3eikhy2w1QMbxb1mELlOaf1bEv90vI88E
 RyNPukaVl2lMqK5kN3+FvIi9612fcS35XEcMcLovtrtQQSc1SADgyFXThBA3MWlnUNc/JQblm
 rF9ZWBZQ4/C+Rjr7bnANFGsMqJZeHXG4SPD7Hy49bBNPgx2E74U9p8eB7thLF4n3a3mdd0OPJ
 nLpIIKpzcFuETB/t8EjSIkUfoo0FjZZloeLzcGUQa/OodW713LtR4n4R6MQAq5zqhN4TV4iNr
 q0k2cqiG90Rzq7qRLhXQR4uQYW1IEq/ddhqu+LUeXqRoUCH5/LWNo8XWiEgfxtQyFVrmZDJfX
 f3kVxAP/aRHhgCQ4H6Wcg0v+pkrCT1UC9q2WPzoALgDffd1SguRkHK7KDzMQOqmmhMkc1QHZn
 3v7WoVU4rGIoJ3rlvc7ChiJJv022Jw50X8ocDhAw7fGILEyO1w+uniuPqXIrvXD3glarGz40X
 h5GonZtyhh/rhjHt9bn6uVhzmQch2BEqnkE2q046y5GpyHGaJxZHSzq3kVWCe+G4MZhoKXOhU
 1a4uf+odFotF8+uM7z54vsulHLEdqIaT/ExIjWm8sNqDZWpRFxPwmJ/edrcG0e6vnGdSK3JzJ
 W1t65rsgX487QwjqVsnMExMrsf6lri71jUtoK+k

On Thu, Nov 28, 2024 at 11:34=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
>
> On Thu, Nov 28, 2024 at 07:37:33AM -0800, Jordan Rome wrote:
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
> > ---
> >  MAINTAINERS                       |  1 +
> >  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
> >  security/commoncap.c              | 57 +++++++++++++++++++----------
> >  3 files changed, 100 insertions(+), 18 deletions(-)
> >  create mode 100644 include/trace/events/capability.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f870842fad9c..b90df58f6030 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5103,6 +5103,7 @@ M:      Serge Hallyn <serge@hallyn.com>
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
> > index 000000000000..65311c2652f7
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
> > + * @target_ns: The user namespace of the resource being accessed
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
> > +     TP_PROTO(const struct cred *cred, struct user_namespace *target_n=
s,
> > +             const struct user_namespace *capable_ns, int cap, unsigne=
d int opts, int ret),
>
> Hi,
>
> you're still sending opts in here.  Will that really be helpful for
> your use case, given that cap_capable() ignores it as Linus pointed
> out?
>

Ah, my bad. I'll remove.

> > +
> > +     TP_ARGS(cred, target_ns, capable_ns, cap, opts, ret),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(const struct cred *, cred)
> > +             __field(struct user_namespace *, target_ns)
> > +             __field(const struct user_namespace *, capable_ns)
> > +             __field(int, cap)
> > +             __field(unsigned int, opts)
> > +             __field(int, ret)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->cred       =3D cred;
> > +             __entry->target_ns    =3D target_ns;
> > +             __entry->capable_ns =3D ret =3D=3D 0 ? capable_ns : NULL;
> > +             __entry->cap        =3D cap;
> > +             __entry->opts       =3D opts;
> > +             __entry->ret        =3D ret;
> > +     ),
> > +
> > +     TP_printk("cred %p, target_ns %p, capable_ns %p, cap %d, opts %u,=
 ret %d",
> > +             __entry->cred, __entry->target_ns, __entry->capable_ns, _=
_entry->cap,
> > +             __entry->opts, __entry->ret)
> > +);
> > +
> > +#endif /* _TRACE_CAPABILITY_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index cefad323a0b1..9fa9aba3961d 100644
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
> > @@ -50,24 +53,17 @@ static void warn_setuid_and_fcaps_mixed(const char =
*fname)
> >  }
> >
> >  /**
> > - * cap_capable - Determine whether a task has a particular effective c=
apability
> > - * @cred: The credentials to use
> > - * @targ_ns:  The user namespace in which we need the capability
> > - * @cap: The capability to check for
> > - * @opts: Bitmask of options defined in include/linux/security.h
> > + * cap_capable_helper - Determine whether a task has a particular effe=
ctive
> > + * capability.
> >   *
> > - * Determine whether the nominated task has the specified capability a=
mongst
> > - * its effective set, returning 0 if it does, -ve if it does not.
> > - *
> > - * NOTE WELL: cap_has_capability() cannot be used like the kernel's ca=
pable()
> > - * and has_capability() functions.  That is, it has the reverse semant=
ics:
> > - * cap_has_capability() returns 0 when a task has a capability, but th=
e
> > - * kernel's capable() and has_capability() returns 1 for this case.
> > + * See cap_capable for more details.
> >   */
> > -int cap_capable(const struct cred *cred, struct user_namespace *targ_n=
s,
> > -             int cap, unsigned int opts)
> > +static inline int cap_capable_helper(const struct cred *cred,
> > +                                  struct user_namespace *target_ns,
> > +                                  const struct user_namespace *cred_ns=
,
> > +                                  int cap)
> >  {
> > -     struct user_namespace *ns =3D targ_ns;
> > +     struct user_namespace *ns =3D target_ns;
> >
> >       /* See if cred has the capability in the target user namespace
> >        * by examining the target user namespace and all of the target
> > @@ -75,21 +71,21 @@ int cap_capable(const struct cred *cred, struct use=
r_namespace *targ_ns,
> >        */
> >       for (;;) {
> >               /* Do we have the necessary capabilities? */
> > -             if (ns =3D=3D cred->user_ns)
> > +             if (likely(ns =3D=3D cred_ns))
> >                       return cap_raised(cred->cap_effective, cap) ? 0 :=
 -EPERM;
> >
> >               /*
> >                * If we're already at a lower level than we're looking f=
or,
> >                * we're done searching.
> >                */
> > -             if (ns->level <=3D cred->user_ns->level)
> > +             if (ns->level <=3D cred_ns->level)
> >                       return -EPERM;
> >
> >               /*
> >                * The owner of the user namespace in the parent of the
> >                * user namespace has all caps.
> >                */
> > -             if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid))
> > +             if ((ns->parent =3D=3D cred_ns) && uid_eq(ns->owner, cred=
->euid))
> >                       return 0;
> >
> >               /*
> > @@ -102,6 +98,31 @@ int cap_capable(const struct cred *cred, struct use=
r_namespace *targ_ns,
> >       /* We never get here */
> >  }
> >
> > +/**
> > + * cap_capable - Determine whether a task has a particular effective c=
apability
> > + * @cred: The credentials to use
> > + * @target_ns:  The user namespace of the resource being accessed
> > + * @cap: The capability to check for
> > + * @opts: Bitmask of options defined in include/linux/security.h
> > + *
> > + * Determine whether the nominated task has the specified capability a=
mongst
> > + * its effective set, returning 0 if it does, -ve if it does not.
> > + *
> > + * NOTE WELL: cap_has_capability() cannot be used like the kernel's ca=
pable()
> > + * and has_capability() functions.  That is, it has the reverse semant=
ics:
> > + * cap_has_capability() returns 0 when a task has a capability, but th=
e
> > + * kernel's capable() and has_capability() returns 1 for this case.
> > + */
> > +int cap_capable(const struct cred *cred, struct user_namespace *target=
_ns,
> > +             int cap, unsigned int opts)
> > +{
> > +     const struct user_namespace *cred_ns =3D cred->user_ns;
> > +     int ret =3D cap_capable_helper(cred, target_ns, cred_ns, cap);
> > +
> > +     trace_cap_capable(cred, target_ns, cred_ns, cap, opts, ret);
> > +     return ret;
> > +}
> > +
> >  /**
> >   * cap_settime - Determine whether the current process may set the sys=
tem clock
> >   * @ts: The time to set
> > --
> > 2.43.5
> >

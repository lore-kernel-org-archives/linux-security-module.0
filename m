Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB411FC7F6;
	Thu, 24 Oct 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792253; cv=none; b=oTOwAB5c8RNP5aY/4KRIySoZeOZ27KwBLvNf82BI/tF1hWP8rgcAk/gRs1ISiuIHqgXyi8twNaF+oC7SN82FTeioLVqr2iilNGV/XompLxs/uX9A5imZCrEozcSgtz1/KqE4GIKPjLubsR1/+QFneP8frgSXWg4kyhbrrSXtttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792253; c=relaxed/simple;
	bh=ePxtA9ibl8mGCexU5e3k6ufEN9i+IRxWmd3lv9J5aNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkkCyH5VAOJHISYmTrnmRTq3bKaUZ1VAuKfML7GEVhf5UVw9g1HCVYQkll1aauSN9qd1ZcVUi/RoHYrZM+lNzS9xxFT/mgHl4yiE2zHmkp0JnjeDRE1DgQ6w6J39ZffNYcpY1MaAo6ySCjgTRcrgW9K32/62uoz6Z9nrp49Dv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFUBok4C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFUBok4C"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so971405b3a.1;
        Thu, 24 Oct 2024 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729792250; x=1730397050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+cPuItU2Qup8nDkfzVI70nJCDy/rsNDn+ncMCnWNy8=;
        b=SFUBok4CK0+bHsUYflccT2yy/zR/JQoscZ69X1XiWe5vHvcu9uh/5PmcsCzuX26+py
         ESir+IJDyFnOyuhodSfrrNryUEnM9gbN9Uhtyajuix64ATwqniQKuc7UaolYtE9vIUky
         OgGOZatuJgITJwiUwB+Q9dMzK+iK6NmvvL5rUlAlGYXiXmmGoSW6/3oex63jLzSZOn+C
         towtYkTFTNXiOY3hIpUiV3X1KbH2uBYpivaATVPqbtoTGk+BsaliA0P1ioy/0l4Fy/fy
         QZnts4SU91kGptosaaSvN0IVeXxHdVetCPZNeeTMViJf5yBqSs8kCnfqb/daYYwGmpt5
         z8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792250; x=1730397050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+cPuItU2Qup8nDkfzVI70nJCDy/rsNDn+ncMCnWNy8=;
        b=iTGgX3RP1Bg105WggJUYxvPEJoai20vsGr1l0US6MGBEhn6YABhPgdwyQZnpRVx6gU
         HWo6kn/4slplWR2hBAtckL1SqZ97ymrcbF/s8Z+xIN7aTZa+n8LNzhpyJELEe+5gcaSh
         NmpDvrIF26atvc/en4AXV6gmVeO3mTRJhOXSyRgA5AiKyISYV9TpgJuFgxgyDBAHMABe
         cAuiBk/XPEeAWldECHYP9FGjIcH8oJxX8WDSW73lITQCw8KO0UCpFE8ZJy7sICBOw2MX
         0No2UTrnoodE875RmfrkwFDu3ysgf1vxoUdB5SNT56YnG1fiHBxUx6RYQxzTf8I5dj//
         wfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0Mpp/8EQcY0ACIsD4TbiTDcZ/YPdIOz1wDINIGxH+Ig0OrfnPaBJKFCh6CVQQriJKI0XydJdnTzH0x59IgBTCc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCYtLPbx6lf7OwOseOdMYLWP+W7bflvNuKgBDmmIB12beH88v
	VB/UskY0a41ZnszRWYSE9qs3KOyt3WTEDwvUQDIusxigkzLiuHTA9Hat3mtq1J9F0MeXegP/45G
	SwLi8a1P+oY2jcuRku+YEUVr69Ic=
X-Google-Smtp-Source: AGHT+IHrYbbGdNWssux5csLTeDBlJDPlpt7WCS4fuefXRw472cYGQABHrKgkA4YdRqjxKWPXI+GLg64dj0YmPOFHAA0=
X-Received: by 2002:a05:6a00:b50:b0:70b:176e:b3bc with SMTP id
 d2e1a72fcca58-72045f8a518mr3880370b3a.28.1729792250325; Thu, 24 Oct 2024
 10:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024104012.1815022-1-linux@jordanrome.com>
In-Reply-To: <20241024104012.1815022-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 10:50:38 -0700
Message-ID: <CAEf4BzY6QxzuhN9MgBb_aWLpBCoxCnWhCoCjuiOZ1T5ORxTXGA@mail.gmail.com>
Subject: Re: [v1] security: add trace event for cap_capable
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 3:40=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace which needs the capability
> - The user namespace that actually has the capability (if one exists)
> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 58 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 21 +++++++----
>  3 files changed, 74 insertions(+), 6 deletions(-)
>  create mode 100644 include/trace/events/capability.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc40a9d9b8cd..210e9076c858 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4994,6 +4994,7 @@ M:        Serge Hallyn <serge@hallyn.com>
>  L:     linux-security-module@vger.kernel.org
>  S:     Supported
>  F:     include/linux/capability.h
> +F:     include/trace/events/capability.h
>  F:     include/uapi/linux/capability.h
>  F:     kernel/capability.c
>  F:     security/commoncap.c
> diff --git a/include/trace/events/capability.h b/include/trace/events/cap=
ability.h
> new file mode 100644
> index 000000000000..092b8e77063a
> --- /dev/null
> +++ b/include/trace/events/capability.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM capability
> +
> +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_CAPABILITY_H
> +
> +#include <linux/cred.h>
> +#include <linux/tracepoint.h>
> +#include <linux/user_namespace.h>
> +
> +/**
> + * capable - called after it's determined if a task has a particular
> + * effective capability
> + *
> + * @cred: The credentials used
> + * @targ_ns:  The user namespace which needs the capability
> + * @capable_ns:  The user namespace that actually has the capability
> + *               if ret is 0 otherwise this will be NULL
> + * @cap: The capability to check for
> + * @opts: Bitmask of options defined in include/linux/security.h
> + * @ret: The return value of the check: 0 if it does, -ve if it does not
> + *
> + * Allows to trace calls to cap_capable in commoncap.c
> + */
> +TRACE_EVENT(capable,
> +
> +       TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> +               struct user_namespace *capable_ns, int cap, unsigned int =
opts, int ret),
> +
> +       TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> +
> +       TP_STRUCT__entry(
> +               __field(const struct cred *, cred)
> +               __field(struct user_namespace *, targ_ns)
> +               __field(struct user_namespace *, capable_ns)
> +               __field(int, cap)
> +               __field(unsigned int, opts)
> +               __field(int, ret)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cred       =3D cred;
> +               __entry->targ_ns    =3D targ_ns;
> +               __entry->capable_ns =3D capable_ns;
> +               __entry->cap        =3D cap;
> +               __entry->opts       =3D opts;
> +               __entry->ret        =3D ret;
> +       ),
> +
> +       TP_printk("cap %d, opts %u, ret %d",
> +               __entry->cap, __entry->opts, __entry->ret)
> +);
> +
> +#endif /* _TRACE_CAPABILITY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..675d40fbaa77 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -27,6 +27,9 @@
>  #include <linux/mnt_idmapping.h>
>  #include <uapi/linux/lsm.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/capability.h>
> +
>  /*
>   * If a non-root user executes a setuid-root binary in
>   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_na=
mespace *targ_ns,
>                 int cap, unsigned int opts)
>  {
>         struct user_namespace *ns =3D targ_ns;
> +       int ret =3D 0;
>
>         /* See if cred has the capability in the target user namespace
>          * by examining the target user namespace and all of the target
> @@ -75,22 +79,26 @@ int cap_capable(const struct cred *cred, struct user_=
namespace *targ_ns,
>          */
>         for (;;) {
>                 /* Do we have the necessary capabilities? */
> -               if (ns =3D=3D cred->user_ns)
> -                       return cap_raised(cred->cap_effective, cap) ? 0 :=
 -EPERM;
> +               if (ns =3D=3D cred->user_ns) {
> +                       ret =3D cap_raised(cred->cap_effective, cap) ? 0 =
: -EPERM;
> +                       break;
> +               }
>
>                 /*
>                  * If we're already at a lower level than we're looking f=
or,
>                  * we're done searching.
>                  */
> -               if (ns->level <=3D cred->user_ns->level)
> -                       return -EPERM;
> +               if (ns->level <=3D cred->user_ns->level) {

I'd do

ns =3D NULL;

here

> +                       ret =3D -EPERM;
> +                       break;
> +               }
>
>                 /*
>                  * The owner of the user namespace in the parent of the
>                  * user namespace has all caps.
>                  */
>                 if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid))

and this needs `ns =3D ns->parent;` (because that's the namespace that
grants capability, is that right?)

> -                       return 0;
> +                       break;
>
>                 /*
>                  * If you have a capability in a parent user ns, then you=
 have
> @@ -99,7 +107,8 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
>                 ns =3D ns->parent;
>         }
>
> -       /* We never get here */
> +       trace_capable(cred, targ_ns, ret =3D=3D 0 ? ns : NULL, cap, opts,=
 ret);

with the above changes just pass ns directly, no need for `ret =3D=3D 0`
check (and it seems it's wrong for one of the case due to ns->parent
use)

> +       return ret;
>  }
>
>  /**
> --
> 2.43.5
>

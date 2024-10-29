Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCC17D355;
	Tue, 29 Oct 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221425; cv=none; b=GTuCXrt3BKQ9d0OEF6rNl3l2wR4L/vuz2RdB53CdmJ+G5hcyQLAv7iDAhMgPYoRYkDPzAUGS8j8M88/EUQ0RDZykzZhxZ0UimaQFsShMYh9+jTaEukAzsC2cfvH2wRCbfEcYPSmWEWDNvxC71UbCeS2eyon0HpOUt0sE3eJGlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221425; c=relaxed/simple;
	bh=lwSUtwFr79ROiNYooLMev1A9P7sWUQF/Kw1fEhWjRmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJWzHJzbc/Rr+EZRaObl4b6NU9d1z78W0k9DDYnLhqE4WcuRBHucNX/JztlUwBV3FtzdVPfq67BvvpxIeyfYnSjJsavwa7pcWnzuFr48pSBcJBjy6HcJF3UneOrsZe9ufcyVgVw/TR6gTjRciV/n6mqdFto6G21naCE61j1IGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j14GxWXA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j14GxWXA"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7205646f9ebso3509287b3a.0;
        Tue, 29 Oct 2024 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730221422; x=1730826222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ5quqpYjVLMPdDfo3tC4CbHBEIdaRKYCIRCKB/c8rk=;
        b=j14GxWXAN1z6gEmNjeGIvTUKadkZeT0T7gvXFkOanyqP98xWONKI/Hd9LvrpJ0dIEE
         jQSTOdGdwcnLp6qp+Q6ZnV4R6jDlPo79LBdqWAvSM0UQoD0+KlRLpqjgcQNK0dQWsQhL
         NiBpcQacEAdKwP9iuR71d7Z/8LrDE4HAVZ5gpv362fgvKtKz3H5lWhwJZbJ1xqYiXjT7
         tXWIs8ZvPqA+WKR5GqDsgZpAjdkjjbVhz5XS5bbf1Telwvo8Xpvo1ByqkAl7Cp7haknU
         NG36MMBtSxsH1PHplWFpJSnSVs52LSTOctFXzGI/oknPV4Mh6aiQU4pVdzr7FOUr1H0t
         XCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221422; x=1730826222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ5quqpYjVLMPdDfo3tC4CbHBEIdaRKYCIRCKB/c8rk=;
        b=lWA95AOAlM7x2BCjxtIuPc84kyvy/kcgfbTDP4Rnul0JudeJlSvl4in/UTqht64BFD
         JGWVwgYHy6nTVgyWIRGyhb44iMqvBWDN0gKM4PG3dANkQvsoSfhWsGozwsTqLnJ6DE5z
         aZNy5F8ETWDbg3PXDnpCNu0Shs9+4W3sNIZ4DNUvuybHb6fAitSj35k8E15UkHNL0Vbh
         7acHJU29+YP/A9WRQIg2PvwMPxjjvUmy2z7du7k0LiY/LvjUB28q5AK43rXI5qXy7Uqi
         IBbcCgWKUHnEj36fMVbnjummSgQPx4+Il4atwtRbr5As3GeiibbLyl9Tzw3q/VAVa39t
         V7pw==
X-Forwarded-Encrypted: i=1; AJvYcCUtD1UTwo+T0xfSXCIqAxXTgawsYc7q0tJu6HZt+48HYKRfQEP6sQi+0hgvqZqxtT6Q2eI4r+IQz4MU9+k/11GYfDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOuo2RrmG9Xx+XYBMX/0ULbnRjQoXrsLq3IuKcc1CTvdxK+udT
	nQn7x/wtQA7kFw7F7Z2ji6Cu/JOWSjARQzAgMUT98by4eSCTuT3T64/AOcSFg9f5Q45fb6pt7FM
	b/Gig06wi7l0HPRoNWLlc/Pzs/Bc=
X-Google-Smtp-Source: AGHT+IEue7iBJj2Mj+iH3oT9owLiI48gCKprAadAwmjFXyskGJ9+LC077vW73HCNOpgtPRL254wpb/lCxqfQz4c1fg8=
X-Received: by 2002:a05:6a00:2e07:b0:71e:6743:7599 with SMTP id
 d2e1a72fcca58-72062fa19b0mr19725711b3a.7.1730221422183; Tue, 29 Oct 2024
 10:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029112038.1225847-1-linux@jordanrome.com>
In-Reply-To: <20241029112038.1225847-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 10:03:29 -0700
Message-ID: <CAEf4BzZJ6RMPx52EShBOFFuo3mfdKBCW8PzzpBCG1HhM=2bmcQ@mail.gmail.com>
Subject: Re: [v3] security: add trace event for cap_capable
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:21=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace in which the credential provides the
> capability to access the targeted resource
> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 32 ++++++++++++-----
>  3 files changed, 85 insertions(+), 8 deletions(-)
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
> index 000000000000..e706ce690c38
> --- /dev/null
> +++ b/include/trace/events/capability.h
> @@ -0,0 +1,60 @@
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
> + * cap_capable - called after it's determined if a task has a particular
> + * effective capability
> + *
> + * @cred: The credentials used
> + * @targ_ns: The user namespace of the resource being accessed
> + * @capable_ns: The user namespace in which the credential provides the
> + *              capability to access the targeted resource.
> + *              This will be NULL if ret is not 0.
> + * @cap: The capability to check for
> + * @opts: Bitmask of options defined in include/linux/security.h
> + * @ret: The return value of the check: 0 if it does, -ve if it does not
> + *
> + * Allows to trace calls to cap_capable in commoncap.c
> + */
> +TRACE_EVENT(cap_capable,
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
> +       TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, opts %u, r=
et %d",
> +               __entry->cred, __entry->targ_ns, __entry->capable_ns, __e=
ntry->cap,
> +               __entry->opts, __entry->ret)
> +);
> +
> +#endif /* _TRACE_CAPABILITY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..7287feee0683 100644
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
> @@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fna=
me)
>  /**
>   * cap_capable - Determine whether a task has a particular effective cap=
ability
>   * @cred: The credentials to use
> - * @targ_ns:  The user namespace in which we need the capability
> + * @targ_ns:  The user namespace of the resource being accessed
>   * @cap: The capability to check for
>   * @opts: Bitmask of options defined in include/linux/security.h
>   *
> @@ -67,7 +70,11 @@ static void warn_setuid_and_fcaps_mixed(const char *fn=
ame)
>  int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
>                 int cap, unsigned int opts)
>  {
> -       struct user_namespace *ns =3D targ_ns;
> +       int ret =3D -EPERM;
> +       struct user_namespace *capable_ns, *ns;
> +
> +       capable_ns =3D NULL;
> +       ns =3D targ_ns;

nit:

struct user_namespace *capable_ns =3D NULL, *ns =3D targ_ns;
int ret =3D -EPERM;

would be more succinct.

But regardless:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
>         /* See if cred has the capability in the target user namespace
>          * by examining the target user namespace and all of the target
> @@ -75,22 +82,30 @@ int cap_capable(const struct cred *cred, struct user_=
namespace *targ_ns,
>          */
>         for (;;) {
>                 /* Do we have the necessary capabilities? */
> -               if (ns =3D=3D cred->user_ns)
> -                       return cap_raised(cred->cap_effective, cap) ? 0 :=
 -EPERM;
> +               if (ns =3D=3D cred->user_ns) {
> +                       if (cap_raised(cred->cap_effective, cap)) {
> +                               capable_ns =3D ns;
> +                               ret =3D 0;
> +                       }
> +                       break;
> +               }
>
>                 /*
>                  * If we're already at a lower level than we're looking f=
or,
>                  * we're done searching.
>                  */
>                 if (ns->level <=3D cred->user_ns->level)
> -                       return -EPERM;
> +                       break;
>
>                 /*
>                  * The owner of the user namespace in the parent of the
>                  * user namespace has all caps.
>                  */
> -               if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid))
> -                       return 0;
> +               if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner=
, cred->euid)) {
> +                       capable_ns =3D ns->parent;
> +                       ret =3D 0;
> +                       break;
> +               }
>
>                 /*
>                  * If you have a capability in a parent user ns, then you=
 have
> @@ -99,7 +114,8 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
>                 ns =3D ns->parent;
>         }
>
> -       /* We never get here */
> +       trace_cap_capable(cred, targ_ns, capable_ns, cap, opts, ret);
> +       return ret;
>  }
>
>  /**
> --
> 2.43.5
>

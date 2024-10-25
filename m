Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40618C039;
	Fri, 25 Oct 2024 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881494; cv=none; b=kq+iGujAjmG7VJn4vYOuA5GpfEvyuaGXUitOJc73KkHxwU2X4CUfpiiLbYKUNgfcANqbT4KYUggzbI3vp8SnLc/f3xiS33pFPQOmTdtt1h5TWbiqdcsXKYXDPP/G1TpdbWfZ8dCsRJEa2K2djTfmlAFZxiAIHdYsHZ+hO++WzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881494; c=relaxed/simple;
	bh=2xzsvE3kIGudnSv8SlGniGJo4HGUFhQ8RZS9725cK7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAS8XFUKUy+Dj8JuF8kw9xkntP4ieQJWoz/SsbXJ+T+te9W+T2TLYPs7eCSMUr4wRqyhQfHCQ0XzeqyFqaNUmqkY+FRAEflapnMGRoGbnjv3vyOrmPXzcXQB6dUFbo303emhPOuN75Nv/VJPHboBWJ/ox/tHC24n1DPk0kXvSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsUXgweW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsUXgweW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so569749b3a.1;
        Fri, 25 Oct 2024 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729881491; x=1730486291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V3dQ2FTa6/dXnKezmP5VMdcgqLtQQhA5QkgI3xmYXI=;
        b=WsUXgweW9gzd5q9fgJgV0VgnkqYybeC+QPmcXd0NJLrmaIMpq9UzWp9VNIkG1MMnV2
         Em7eT2d+Z7F/vAW6RgYW+KTIEQ7yE5BQMyy67cmm+HXnxM5nBKwOq9Ac/yM6He+lyr0j
         T+lJFeCs5l4QUNV6MWFz6H8MQFtyULtEDVKhVM2mDgKX/rD+ZBxLWV2THNPXR3cpfhoG
         ivzPHRr5+3knaHq9Vte35YtRUuiXYJS1W0qqDzHS5u/eBzOkG2vy1vdtyUXM3YFx+ngo
         x2GG7psmGY8TCX/n2Xs31igWSf/4z6vWmGqHV6wRTSQKAyxiB6PZJJe2PprC9i4Kr8i/
         FreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881491; x=1730486291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V3dQ2FTa6/dXnKezmP5VMdcgqLtQQhA5QkgI3xmYXI=;
        b=ks40SggWDk/qfdGy61jWtRdvHSJyAB3YnO/xI96kzpimOfKM5qK1/IAoXj4aJ1iF5G
         RD/wwoVIdpXXx0byq7XgocJyhGIJ4slz0VZR9RlKqS1UpkL8or5McvRS31YwXmvN24eh
         TJPvcQXUuuvyounKFKDFYraLfllwV5xH1SKScOrcpuEjzo4lUBNBvX+LySMT9nNebM/A
         uSUdHBQdOvh2QxWXftEpQUNcqmHlYNW5ez3bZaOmyWi6+Hahwc5jdYAVftfU94NHYnX4
         C/uEPpljQKo5CHGDY/yg7trIDsQfTrWw3scx7SgSHmLyoN4TpFzrzocuFmg4F2Qoel+3
         iAVg==
X-Forwarded-Encrypted: i=1; AJvYcCXP+vqALvlrIToUvFf5NevcMbzS8KhOQv4WDUukIw0k6QbjV6m6w8cjL369drXU8oN5RtATGoBSow7HSQE4Km5Zm5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YziCsRxVJHXcTmYU5J7eN+GG2No3QN8pcDT8X07ZG5Lrbfjc48Q
	caDStTHfcU3wJj52ki0xum/YjtiGID1fjaqsBsB06mOmkO6v2dLAYu6Epp9M27VLo/Kjq0ZQpuj
	+0x/zIhxVzaPivIFn21I6zLp/03Y=
X-Google-Smtp-Source: AGHT+IFCQXtq3oT+xafL+9u34A8H8heJEUUrpM3Jw/JIUX69bsxfvjQPAdIs7YWB7/dQH8OUwGyL0zAncfkSjZ0zoIQ=
X-Received: by 2002:a05:6a00:3d4d:b0:71e:a3:935b with SMTP id
 d2e1a72fcca58-7206306ebbfmr576676b3a.25.1729881491314; Fri, 25 Oct 2024
 11:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025151128.1854905-1-linux@jordanrome.com>
In-Reply-To: <20241025151128.1854905-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Oct 2024 11:37:59 -0700
Message-ID: <CAEf4BzYsQsj50hJut3+a4NUenZ+6ajfaFL_31NcvBdyoeBTiPg@mail.gmail.com>
Subject: Re: [v2] security: add trace event for cap_capable
To: Jordan Rome <linux@jordanrome.com>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:15=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace of the resource being accessed
> - The user namespace that has the capability to access the
> targeted resource
> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 31 +++++++++++-----
>  3 files changed, 84 insertions(+), 8 deletions(-)
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
> index 162d96b3a676..12c3ddfe0d6e 100644
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
> @@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_na=
mespace *targ_ns,
>                 int cap, unsigned int opts)
>  {
>         struct user_namespace *ns =3D targ_ns;
> +       int ret =3D -EPERM;
>
>         /* See if cred has the capability in the target user namespace
>          * by examining the target user namespace and all of the target
> @@ -75,22 +79,32 @@ int cap_capable(const struct cred *cred, struct user_=
namespace *targ_ns,
>          */
>         for (;;) {
>                 /* Do we have the necessary capabilities? */
> -               if (ns =3D=3D cred->user_ns)
> -                       return cap_raised(cred->cap_effective, cap) ? 0 :=
 -EPERM;
> +               if (ns =3D=3D cred->user_ns) {
> +                       if (cap_raised(cred->cap_effective, cap))
> +                               ret =3D 0;
> +                       else
> +                               ns =3D NULL;

This is a bit unfortunate :( so maybe all we needed was `ns =3D
ns->parent` for that one use case, and keep the original `ret ? NULL :
ns` inside trace_cap_capable().

But whatever security folks prefer, I'm fine with either.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

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
> +                       ns =3D NULL;
> +                       break;
> +               }
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
> +                       ns =3D ns->parent;
> +                       ret =3D 0;
> +                       break;
> +               }
>
>                 /*
>                  * If you have a capability in a parent user ns, then you=
 have
> @@ -99,7 +113,8 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
>                 ns =3D ns->parent;
>         }
>
> -       /* We never get here */
> +       trace_cap_capable(cred, targ_ns, ns, cap, opts, ret);
> +       return ret;
>  }
>
>  /**
> --
> 2.43.5
>
>

Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65501EF927;
	Fri,  4 Oct 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067708; cv=none; b=YPGF2P30Xu+Nv0jGSvy6qU9W6w4a8ILD+y3lS5DZ/sjJAvkdIoBkylPDWobUYQDt12K89SRYKqGWmQB/isogcMR35vZ+gkN6SeoubH/nrssa/j8YRZ5/fDKjqpQc1F1Zkv8E4x3kUTNTbXfem/D6e9svBgGmbZ485srgwuHhm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067708; c=relaxed/simple;
	bh=ji34y9m3JNoj4xmNOaRuHTmJoLzrL7XEtankYx1PobY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvoG+AbpoqY8gBG709XlHwlVlDQhFjIAyeiCwUJ5qEt5Ro1UmAuOsdqQnv5qI6jda1eMXNKS8S0ZuMPt895n8ciSTGQlNOk3HCjcLyCKs7EE26S+OXrEkusvIwgmfsN/3CgQyLnWm+tBsT6xuLvO9AI5yqBn0RZXU7EOoWp/+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWJL/Slo; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWJL/Slo"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dde476d3dfso18999667b3.3;
        Fri, 04 Oct 2024 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728067706; x=1728672506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDJ7CzWS8BYgyEa+1aUfpxDHORBOxc/T4XVGwWZLO1A=;
        b=AWJL/SloUVIWfImktLBR5jN7mAwS7HgE0iBBU0in3YUogNphnoTjqnwzi+8Y6w0zfT
         VTwpT9bHRLl3BRBtGtEe5NrNBcXUcThXpYvKESl9P4AlhrThyDrOEjxCax/+WqIiGwWo
         f0Xhlpw/Cq30lxxvXI/0bTfPz0AQbcbQ9FOrwvSqUM1RoEYV/p3554s0BK+jpXH5aLvU
         bNNm+Xemg4nuK49ad53BdAAyWB5uupLoh9Rlg1/opVhWTajJNt20XVRP7i2x8l0poD74
         vdIIQ6nFtxwPICKjleijF31s3H3RUO9YEQbENfcAWkW/BfS844f9MJliJxCB+oK6qsxK
         prYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067706; x=1728672506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDJ7CzWS8BYgyEa+1aUfpxDHORBOxc/T4XVGwWZLO1A=;
        b=NDsCV9cNEzbzJRmcTGIVmYv6SHHedmZAuNwGAm5zUtC238cSyeB8gnnZeyXGfsR44h
         4IjaGOFVVi82jH/2IEBZxf9jsATfIUN6EV/24kU8WxjKjwIpUE6h18BZZRNi5TzCxOZz
         TCzQ5Aed4yWmPWVH2/bltnliJw+Zc4WkWq483zdPVckw/YaIlp0wMkW0nE/de1Ka2oQ0
         hkKcIZDCXCumXcIpaAeiCv5DbkJAkjZxLOHWquKSNUuuiqvfyj7300+JA03bAm3Fepgv
         aE/7OTp3bGGRYNkbVjc2GOut9AtWaCN7eAwXpzs80i/GL43Snw/0Fjd8FrB1jSIM8VCW
         j36Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmVYLZoIAwgv89Kj14pH3e8xjVhqZQuzKcZE4GIt4R2rFvuyHNG0EdNu1J1jYn76iZU+WzZFZSBd50wMCEAIUccy06pcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypToXyuBM/4jxNxaQBYx2PqvgP+BvrulUqP/9Orjt5+4smMCFN
	u7CP2UFSk/WyT9FjKXYYgyvpMv37HkBIQvM7Ki1cRiaW3DBSxuMuxgXCZwc5QSz0VWyN/aqwEp2
	kjVOJeyHuhSITTrnJaCA56NBqfxM=
X-Google-Smtp-Source: AGHT+IF0vhRjP0YeWa9+wIWQR5A8z6QvYZRaSXc0grvJ5GXUz0S7FVxoOZ8diwZsoJ1meN9sgFxvlI0KwZLC2RCvTfI=
X-Received: by 2002:a05:690c:2d11:b0:6e2:63e:f087 with SMTP id
 00721157ae682-6e2c72b2c87mr28755247b3.42.1728067705863; Fri, 04 Oct 2024
 11:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com> <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 4 Oct 2024 19:48:14 +0100
Message-ID: <CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 at 15:48, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.com> wrote:
> >
> > From: Luca Boccassi <bluca@debian.org>
> >
> > A common pattern when using pid fds is having to get information
> > about the process, which currently requires /proc being mounted,
> > resolving the fd to a pid, and then do manual string parsing of
> > /proc/N/status and friends. This needs to be reimplemented over
> > and over in all userspace projects (e.g.: I have reimplemented
> > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > requires additional care in checking that the fd is still valid
> > after having parsed the data, to avoid races.
> >
> > Having a programmatic API that can be used directly removes all
> > these requirements, including having /proc mounted.
> >
> > As discussed at LPC24, add an ioctl with an extensible struct
> > so that more parameters can be added later if needed. Start with
> > exposing: pid, uid, gid, groupid, security label (the latter was
> > requested by the LSM maintainer).
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> >  fs/pidfs.c                                    | 61 ++++++++++++++++++-
> >  include/uapi/linux/pidfd.h                    | 17 ++++++
> >  .../testing/selftests/pidfd/pidfd_open_test.c | 50 ++++++++++++++-
> >  3 files changed, 126 insertions(+), 2 deletions(-)
>
> ...
>
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > index 565fc0629fff..bfd0965e01f3 100644
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -16,6 +16,22 @@
> >  #define PIDFD_SIGNAL_THREAD_GROUP      (1UL << 1)
> >  #define PIDFD_SIGNAL_PROCESS_GROUP     (1UL << 2)
> >
> > +/* Flags for pidfd_info. */
> > +#define PIDFD_INFO_PID                 (1UL << 0)
> > +#define PIDFD_INFO_CREDS                   (1UL << 1)
> > +#define PIDFD_INFO_CGROUPID                (1UL << 2)
> > +#define PIDFD_INFO_SECURITY_CONTEXT        (1UL << 3)
> > +
> > +struct pidfd_info {
> > +        __u64 request_mask;
> > +        __u32 size;
> > +        uint pid;
> > +        uint uid;
> > +        uint gid;
> > +        __u64 cgroupid;
> > +        char security_context[NAME_MAX];
>
> [NOTE: please CC the LSM list on changes like this]
>
> Thanks Luca :)
>
> With the addition of the LSM syscalls we've created a lsm_ctx struct
> (see include/uapi/linux/lsm.h) that properly supports multiple LSMs.
> The original char ptr "secctx" approach worked back when only a single
> LSM was supported at any given time, but now that multiple LSMs are
> supported we need something richer, and it would be good to use this
> new struct in any new userspace API.
>
> See the lsm_get_self_attr(2) syscall for an example (defined in
> security/lsm_syscalls.c but effectively implemented via
> security_getselfattr() in security/security.c).

Thanks for the review, makes sense to me - I had a look at those
examples but unfortunately it is getting a bit beyond my (very low)
kernel skills, so I've dropped the string-based security_context from
v2 but without adding something else, is there someone more familiar
with the LSM world that could help implementing that side?

Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE7C10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA9420656
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idFk9+NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfDRNC7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:02:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37656 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNC7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 09:02:59 -0400
Received: by mail-ua1-f67.google.com with SMTP id l17so729398uar.4
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2019 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B159q/GdPumYsf60r4ZSqaSbZu23wcJCsTF1H5HvzH4=;
        b=idFk9+NMExlVVo7sZQjJVKt4bgXV2EQgxrRgZjTusdlRKvplCo/zitPvynileGqh1M
         4PI5fbdOaH2xWbvMPes8uWPzJZxposiqmXhckNECWTegtb4ykqcEFdxLiKm4cZ/FOWHT
         AcnRtXiWoAXmUDFrdoAjRuQsnatM2mdit1EHtn8XkismPcSMXuk3C1IUt9rQMxBvhvH9
         iOtiH0WGRjBWb2dlkD4Oh4ryx/tA0bJY/VobSgmp3fiE53+O3ByIC3EaYm8RYe3624Lf
         ch8lX7m1INuIDPj5SSPa2C3MlB13HiqQ4wAcOBDTx/SRVkkJenIE/4xx1hhhS2whAVN9
         3IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B159q/GdPumYsf60r4ZSqaSbZu23wcJCsTF1H5HvzH4=;
        b=X6KLAstKKyab4kMQ+MbhOqYZwRRk45HqeFPg9BVazOeR3D6tK7v1Tdh+vJDFqPX83D
         +FLlzq812zH0IaZMSOLJo4G1nvm3yP1GQ772qkYuv9MUhWMyoAMC7FW6Z3rbiAc+Zj0C
         3vtyOCxVxPaKROWhDCd/8uoUpDoeO/0pU+IILCaCgkNStHEccLwAxjxWZMjWd3IXVva9
         8GptbIKIqQ1Jzja9x/aMaXdKCzkqjOd/1D4H7Oq+fC0XQBVjysqm05FLmxLkuDdpOrpW
         6IU3utaYLMooYFs2XN6/A8Sq6Lru9FkSGDkEXulEXvmpMTWDUjrHSbt/nRtzWDfoL8bm
         1f9g==
X-Gm-Message-State: APjAAAW1kbVS7BnaNl0aDC/PnS8ba78wVw0i5kDK7HwCJPr8WdQQUGK/
        g59DaoD7XxPxHJOvLpwiQ4Mbe/nJxlTvq0IY1r4NaQ==
X-Google-Smtp-Source: APXvYqyd+y2h7+S/D+2f4Uw4o37JaPAREXDfo0UzI9xyK8p0N164o4UoCEAuZDpKPsU3gTZ1BbO3MDIFyiP34j9MBN0=
X-Received: by 2002:ab0:44e:: with SMTP id 72mr49898087uav.110.1555592577865;
 Thu, 18 Apr 2019 06:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-3-glider@google.com>
 <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com>
In-Reply-To: <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 18 Apr 2019 15:02:46 +0200
Message-ID: <CAG_fn=WhBxSLkD3BdTP3Z72B7mGkegezwkjyMjmY7oVjb+kVWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Laura Abbott <labbott@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 8, 2019 at 6:43 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 3/8/19 5:27 AM, Alexander Potapenko wrote:
> > This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
> > without the need to pass any boot parameters.
> >
> > No performance optimizations are done at the moment to reduce double
> > initialization of memory regions.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Kostya Serebryany <kcc@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Sandeep Patil <sspatil@android.com>
> > Cc: linux-security-module@vger.kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: kernel-hardening@lists.openwall.com
> > ---
> >   mm/page_poison.c         |  5 +++++
> >   mm/slub.c                |  2 ++
> >   security/Kconfig.initmem | 11 +++++++++++
> >   3 files changed, 18 insertions(+)
> >
> > diff --git a/mm/page_poison.c b/mm/page_poison.c
> > index 21d4f97cb49b..a1985f33f635 100644
> > --- a/mm/page_poison.c
> > +++ b/mm/page_poison.c
> > @@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
> >
> >   static int __init early_page_poison_param(char *buf)
> >   {
> > +#ifdef CONFIG_INIT_ALL_HEAP
> > +     want_page_poisoning =3D true;
> > +     return 0;
> > +#else
> >       if (!buf)
> >               return -EINVAL;
> >       return strtobool(buf, &want_page_poisoning);
> > +#endif
> >   }
> >   early_param("page_poison", early_page_poison_param);
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1b08fbcb7e61..00e0197d3f35 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1287,6 +1287,8 @@ static int __init setup_slub_debug(char *str)
> >       if (*str =3D=3D ',')
> >               slub_debug_slabs =3D str + 1;
> >   out:
> > +     if (IS_ENABLED(CONFIG_INIT_ALL_HEAP))
> > +             slub_debug |=3D SLAB_POISON;
> >       return 1;
> >   }
> >
>
> I've looked at doing something similar in the past (failing to find
> the thread this morning...) and while this will work, it has pretty
> serious performance issues. It's not actually the poisoning which
> is expensive but that turning on debugging removes the cpu slab
> which has significant performance penalties.
>
> I'd rather go back to the proposal of just poisoning the slab
> at alloc/free without using SLAB_POISON.
Hi Laura,

May I wonder what were the performance numbers you were seeing?
I've found this patch:
https://www.openwall.com/lists/kernel-hardening/2016/01/26/1, but
that's around 100% slowdown.
> Thanks,
> Laura
>
>
> > diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> > index 27aec394365e..5ce49663777a 100644
> > --- a/security/Kconfig.initmem
> > +++ b/security/Kconfig.initmem
> > @@ -13,6 +13,17 @@ config INIT_ALL_MEMORY
> >
> >   if INIT_ALL_MEMORY
> >
> > +config INIT_ALL_HEAP
> > +     bool "Initialize all heap"
> > +     depends on INIT_ALL_MEMORY
> > +     select CONFIG_PAGE_POISONING
> > +     select CONFIG_PAGE_POISONING_NO_SANITY
> > +     select CONFIG_PAGE_POISONING_ZERO
> > +     select CONFIG_SLUB_DEBUG
> > +     default y
> > +     help
> > +       Enable page poisoning and slub poisoning by default.
> > +
> >   config INIT_ALL_STACK
> >       bool "Initialize all stack"
> >       depends on INIT_ALL_MEMORY
> >
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

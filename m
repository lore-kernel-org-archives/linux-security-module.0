Return-Path: <SRS0=BhGd=TO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CBC04AB4
	for <linux-security-module@archiver.kernel.org>; Tue, 14 May 2019 14:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17342085A
	for <linux-security-module@archiver.kernel.org>; Tue, 14 May 2019 14:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcTWXERQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfENOkK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 May 2019 10:40:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43883 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfENOkJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 May 2019 10:40:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id d128so10461289vsc.10
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2019 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y9elDrG5a0+F5kcEhLlKdiEIdllXd8Jo5lrH+iv1S3k=;
        b=ZcTWXERQUjmj2QwQIbFGnj39+bcTt8zmjam78wn6i6h9/7xg03z2XYlSaQ8cHpeoCY
         guUpxGO0cXM4i2c3G8deAceAikaEUKjij0nW0aHk4HyQ+gRoOelIUeP+VgwPnXzWnRkV
         LkNT5Q8yQBe06a7btM3bVgqu8jUv5sKwOuRGGkvZXq1KRk78gmWImqoFlpJ0vgATk6nW
         sCnuzQvpXQjR+IQfrwj7QM2uvkCP01Pu3pnQEjrOJpFSXo7i26PkoZoJZougihhaqUNr
         irl7wVGn63hxTHymxdj4CK9PYN2aelLMvjHDwmReblXxIKZm/glwKfnRwqQqGOIwztK+
         5MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y9elDrG5a0+F5kcEhLlKdiEIdllXd8Jo5lrH+iv1S3k=;
        b=egatX+aZuPq70onfDQZN7MM8QVqndrOYjn51vaxcXVpbHHuwC0Ybs1e9wLT0v7KKj2
         0biKJxJ3mtx2twlC4FG6Uo0gXGheyPRnnRBvvrUxnJSBqVi6jUppH/zskiCP977aofzR
         J4Ez2id2kdZFN1u/yTgy1WUthGYWvpz5H9gHLRNzoPi5H5YHzrf0YmgCONFB0f1OGdn2
         1XG+gnyOBeQffzMcZh8tIF2u45+2Ypy31BrUfOvL2CUWBASvzFpcaxORqsIrQUlYAf63
         68Bevh/ccj7yucVFGj6tTQHyll1ymiZOdWrVFEmfnUUyk7mFcElRGY1G82X9HK7NsDW8
         Ipsg==
X-Gm-Message-State: APjAAAVXIiXr8nj2uRMP2+UIZed/2k00jdv6FTFpbSkqWdSlqBfkPhDg
        kIEi5kfHbMZGUs7/5xX+MOLDOvfDfMXzJuPP6+bGmQ==
X-Google-Smtp-Source: APXvYqzV+X//RAjmEdX/1LhxUFJSBZDJ8YuwVfHmpMyjQL0u0/UdaqtrKVuZ7H23X6BGjtPvNdxJYGe9v7h+/LMYF4M=
X-Received: by 2002:a67:7241:: with SMTP id n62mr16465896vsc.217.1557844808216;
 Tue, 14 May 2019 07:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190508153736.256401-1-glider@google.com> <20190508153736.256401-4-glider@google.com>
 <CAGXu5jJS=KgLwetdmDAUq9+KhUFTd=jnCES3BZJm+qBwUBmLjQ@mail.gmail.com>
 <CAG_fn=VbJXHsqAeBD+g6zJ8WVTko4Ev2xytXrcJ-ztEWm7kOOA@mail.gmail.com> <CAFqt6zY1oY4YTfAd4RdV0-V8iUfK65LTHsdmxrSWs7KRnWrrCg@mail.gmail.com>
In-Reply-To: <CAFqt6zY1oY4YTfAd4RdV0-V8iUfK65LTHsdmxrSWs7KRnWrrCg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 May 2019 16:39:56 +0200
Message-ID: <CAG_fn=XzWcF=_L1zEU6Gd++u00N=j9GptVLvYOj0_kF0HRu+ig@mail.gmail.com>
Subject: Re: [PATCH 3/4] gfp: mm: introduce __GFP_NOINIT
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, May 11, 2019 at 9:28 AM
To: Alexander Potapenko
Cc: Kees Cook, Andrew Morton, Christoph Lameter, Laura Abbott,
Linux-MM, linux-security-module, Kernel Hardening, Masahiro Yamada,
James Morris, Serge E. Hallyn, Nick Desaulniers, Kostya Serebryany,
Dmitry Vyukov, Sandeep Patil, Randy Dunlap, Jann Horn, Mark Rutland,
Matthew Wilcox

> On Thu, May 9, 2019 at 6:53 PM Alexander Potapenko <glider@google.com> wr=
ote:
> >
> > From: Kees Cook <keescook@chromium.org>
> > Date: Wed, May 8, 2019 at 9:16 PM
> > To: Alexander Potapenko
> > Cc: Andrew Morton, Christoph Lameter, Kees Cook, Laura Abbott,
> > Linux-MM, linux-security-module, Kernel Hardening, Masahiro Yamada,
> > James Morris, Serge E. Hallyn, Nick Desaulniers, Kostya Serebryany,
> > Dmitry Vyukov, Sandeep Patil, Randy Dunlap, Jann Horn, Mark Rutland
> >
> > > On Wed, May 8, 2019 at 8:38 AM Alexander Potapenko <glider@google.com=
> wrote:
> > > > When passed to an allocator (either pagealloc or SL[AOU]B), __GFP_N=
OINIT
> > > > tells it to not initialize the requested memory if the init_on_allo=
c
> > > > boot option is enabled. This can be useful in the cases newly alloc=
ated
> > > > memory is going to be initialized by the caller right away.
> > > >
> > > > __GFP_NOINIT doesn't affect init_on_free behavior, except for SLOB,
> > > > where init_on_free implies init_on_alloc.
> > > >
> > > > __GFP_NOINIT basically defeats the hardening against information le=
aks
> > > > provided by init_on_alloc, so one should use it with caution.
> > > >
> > > > This patch also adds __GFP_NOINIT to alloc_pages() calls in SL[AOU]=
B.
> > > > Doing so is safe, because the heap allocators initialize the pages =
they
> > > > receive before passing memory to the callers.
> > > >
> > > > Slowdown for the initialization features compared to init_on_free=
=3D0,
> > > > init_on_alloc=3D0:
> > > >
> > > > hackbench, init_on_free=3D1:  +6.84% sys time (st.err 0.74%)
> > > > hackbench, init_on_alloc=3D1: +7.25% sys time (st.err 0.72%)
> > > >
> > > > Linux build with -j12, init_on_free=3D1:  +8.52% wall time (st.err =
0.42%)
> > > > Linux build with -j12, init_on_free=3D1:  +24.31% sys time (st.err =
0.47%)
> > > > Linux build with -j12, init_on_alloc=3D1: -0.16% wall time (st.err =
0.40%)
> > > > Linux build with -j12, init_on_alloc=3D1: +1.24% sys time (st.err 0=
.39%)
> > > >
> > > > The slowdown for init_on_free=3D0, init_on_alloc=3D0 compared to th=
e
> > > > baseline is within the standard error.
> > > >
>
> Not sure, but I think this patch will clash with Matthew's posted patch s=
eries
> *Remove 'order' argument from many mm functions*.
Not sure I can do much with that before those patches reach mainline.
Once they do, I'll update my patches.
Please let me know if there's a better way to resolve such conflicts.
> > > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > Cc: Kostya Serebryany <kcc@google.com>
> > > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Sandeep Patil <sspatil@android.com>
> > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-security-module@vger.kernel.org
> > > > Cc: kernel-hardening@lists.openwall.com
> > > > ---
> > > >  include/linux/gfp.h | 6 +++++-
> > > >  include/linux/mm.h  | 2 +-
> > > >  kernel/kexec_core.c | 2 +-
> > > >  mm/slab.c           | 2 +-
> > > >  mm/slob.c           | 3 ++-
> > > >  mm/slub.c           | 1 +
> > > >  6 files changed, 11 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > index fdab7de7490d..66d7f5604fe2 100644
> > > > --- a/include/linux/gfp.h
> > > > +++ b/include/linux/gfp.h
> > > > @@ -44,6 +44,7 @@ struct vm_area_struct;
> > > >  #else
> > > >  #define ___GFP_NOLOCKDEP       0
> > > >  #endif
> > > > +#define ___GFP_NOINIT          0x1000000u
> > >
> > > I mentioned this in the other patch, but I think this needs to be
> > > moved ahead of GFP_NOLOCKDEP and adjust the values for GFP_NOLOCKDEP
> > > and to leave the IS_ENABLED() test in __GFP_BITS_SHIFT alone.
> > Do we really need this blinking GFP_NOLOCKDEP bit at all?
> > This approach doesn't scale, we can't even have a second feature that
> > has a bit depending on the config settings.
> > Cannot we just fix the number of bits instead?
> >
> > > >  /* If the above are modified, __GFP_BITS_SHIFT may need updating *=
/
> > > >
> > > >  /*
> > > > @@ -208,16 +209,19 @@ struct vm_area_struct;
> > > >   * %__GFP_COMP address compound page metadata.
> > > >   *
> > > >   * %__GFP_ZERO returns a zeroed page on success.
> > > > + *
> > > > + * %__GFP_NOINIT requests non-initialized memory from the underlyi=
ng allocator.
> > > >   */
> > > >  #define __GFP_NOWARN   ((__force gfp_t)___GFP_NOWARN)
> > > >  #define __GFP_COMP     ((__force gfp_t)___GFP_COMP)
> > > >  #define __GFP_ZERO     ((__force gfp_t)___GFP_ZERO)
> > > > +#define __GFP_NOINIT   ((__force gfp_t)___GFP_NOINIT)
> > > >
> > > >  /* Disable lockdep for GFP context tracking */
> > > >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> > > >
> > > >  /* Room for N __GFP_FOO bits */
> > > > -#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
> > > > +#define __GFP_BITS_SHIFT (25)
> > >
> > > AIUI, this will break non-CONFIG_LOCKDEP kernels: it should just be:
> > >
> > > -#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
> > > +#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
> > >
> > > >  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) -=
 1))
> > > >
> > > >  /**
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index ee1a1092679c..8ab152750eb4 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -2618,7 +2618,7 @@ DECLARE_STATIC_KEY_FALSE(init_on_alloc);
> > > >  static inline bool want_init_on_alloc(gfp_t flags)
> > > >  {
> > > >         if (static_branch_unlikely(&init_on_alloc))
> > > > -               return true;
> > > > +               return !(flags & __GFP_NOINIT);
> > > >         return flags & __GFP_ZERO;
> > >
> > > What do you think about renaming __GFP_NOINIT to __GFP_NO_AUTOINIT or=
 something?
> > >
> > > Regardless, yes, this is nice.
> > >
> > > --
> > > Kees Cook
> >
> >
> >
> > --
> > Alexander Potapenko
> > Software Engineer
> >
> > Google Germany GmbH
> > Erika-Mann-Stra=C3=9Fe, 33
> > 80636 M=C3=BCnchen
> >
> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> > Registergericht und -nummer: Hamburg, HRB 86891
> > Sitz der Gesellschaft: Hamburg
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

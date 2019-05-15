Return-Path: <SRS0=njb8=TP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A409C04E53
	for <linux-security-module@archiver.kernel.org>; Wed, 15 May 2019 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173B020881
	for <linux-security-module@archiver.kernel.org>; Wed, 15 May 2019 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfTOzfQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOKHN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 May 2019 06:07:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43715 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfEOKHN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 May 2019 06:07:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so1936151lji.10
        for <linux-security-module@vger.kernel.org>; Wed, 15 May 2019 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mscevK37/4nnD6iDAhQMYOtk0/NBE7+GVVa+J+i/xbw=;
        b=VfTOzfQHAEh1LniZ7/hjqkQRXVW6w0NiARMgkQz8fdmWPYx+YFlHjKrWW9SFetMWs3
         G9DBebsTzY+TzQqgaUZXHhuaJrAvPguyvG5rKygzDGVFRgykAzD9rO3eppEFQXrUDl0t
         KiCIAIs50XeDjdechjn9tNOpCIzTltid3TPjj4d5um53TgSRkcuBRE+Vm8tHVDQSZq3j
         4F5qTovSxa830D/kbxTzCF5Od4cASnkmz5b2FS8aG6wMt7X9c6XUSbGzNiMGEIJ+3WjJ
         66h2W9OJYMa8ypZNTZ+p2ZcKlrFs73YpMOW0vtYnMkyh9XXQW7DWfejdxzaJMmnDynAB
         L+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mscevK37/4nnD6iDAhQMYOtk0/NBE7+GVVa+J+i/xbw=;
        b=YdJj6hkmhqoCmn5ztaNUFVF/95uV71iTXmNpbxFvdh506Q7S8TrMmiX+nqu22q0Y9m
         5ekOfYv1Efmxis0jkyWD/7Sk+LPgigtgYv/PobRBtT66uRAGkQMZNVaINoF81axaWP+U
         UEqDOSp3DfjP4m3phz/VItN2XOeiSMICdhbDDG8YxqJVzgN1RV4I920ZMefeJJT3ifYo
         TWu/VsHB4SXZLLfbGQqlcsHG4iYtf4qk/OU04/pFx41UKFp1SUuWgffXHx5flULrUFo3
         kHaJip2ihGdCRjtbF+XNBH2nW7sBHISrgMasYo4xuR0SNU7SSt4Yjwr9Ko804BrGkn0x
         dBfA==
X-Gm-Message-State: APjAAAVHkd/+PwfEP5K4O9N6gghO5nOSx6Rzp00Gidp1Y59bMnyk1QOW
        A5AqKAADy4K4OXwuPqxjmo9j3ypman/ggH5vQXA=
X-Google-Smtp-Source: APXvYqyq++NbMOADSqcuCndB8YwWAw8htvvh4qqGDhAqxC5mnRCZl3FTp2S7oPZzjTciowd41OY1QaLvEK3AiS3oH/o=
X-Received: by 2002:a2e:960e:: with SMTP id v14mr4236733ljh.31.1557914830398;
 Wed, 15 May 2019 03:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190508153736.256401-1-glider@google.com> <20190508153736.256401-4-glider@google.com>
 <CAGXu5jJS=KgLwetdmDAUq9+KhUFTd=jnCES3BZJm+qBwUBmLjQ@mail.gmail.com>
 <CAG_fn=VbJXHsqAeBD+g6zJ8WVTko4Ev2xytXrcJ-ztEWm7kOOA@mail.gmail.com>
 <CAFqt6zY1oY4YTfAd4RdV0-V8iUfK65LTHsdmxrSWs7KRnWrrCg@mail.gmail.com> <CAG_fn=XzWcF=_L1zEU6Gd++u00N=j9GptVLvYOj0_kF0HRu+ig@mail.gmail.com>
In-Reply-To: <CAG_fn=XzWcF=_L1zEU6Gd++u00N=j9GptVLvYOj0_kF0HRu+ig@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 15 May 2019 15:36:57 +0530
Message-ID: <CAFqt6zYvftTKDbpc-PyHw_uNvAnYuswevAe=F12ACFrBP1N6xA@mail.gmail.com>
Subject: Re: [PATCH 3/4] gfp: mm: introduce __GFP_NOINIT
To:     Alexander Potapenko <glider@google.com>
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

On Tue, May 14, 2019 at 8:10 PM Alexander Potapenko <glider@google.com> wro=
te:
>
> From: Souptick Joarder <jrdr.linux@gmail.com>
> Date: Sat, May 11, 2019 at 9:28 AM
> To: Alexander Potapenko
> Cc: Kees Cook, Andrew Morton, Christoph Lameter, Laura Abbott,
> Linux-MM, linux-security-module, Kernel Hardening, Masahiro Yamada,
> James Morris, Serge E. Hallyn, Nick Desaulniers, Kostya Serebryany,
> Dmitry Vyukov, Sandeep Patil, Randy Dunlap, Jann Horn, Mark Rutland,
> Matthew Wilcox
>
> > On Thu, May 9, 2019 at 6:53 PM Alexander Potapenko <glider@google.com> =
wrote:
> > >
> > > From: Kees Cook <keescook@chromium.org>
> > > Date: Wed, May 8, 2019 at 9:16 PM
> > > To: Alexander Potapenko
> > > Cc: Andrew Morton, Christoph Lameter, Kees Cook, Laura Abbott,
> > > Linux-MM, linux-security-module, Kernel Hardening, Masahiro Yamada,
> > > James Morris, Serge E. Hallyn, Nick Desaulniers, Kostya Serebryany,
> > > Dmitry Vyukov, Sandeep Patil, Randy Dunlap, Jann Horn, Mark Rutland
> > >
> > > > On Wed, May 8, 2019 at 8:38 AM Alexander Potapenko <glider@google.c=
om> wrote:
> > > > > When passed to an allocator (either pagealloc or SL[AOU]B), __GFP=
_NOINIT
> > > > > tells it to not initialize the requested memory if the init_on_al=
loc
> > > > > boot option is enabled. This can be useful in the cases newly all=
ocated
> > > > > memory is going to be initialized by the caller right away.
> > > > >
> > > > > __GFP_NOINIT doesn't affect init_on_free behavior, except for SLO=
B,
> > > > > where init_on_free implies init_on_alloc.
> > > > >
> > > > > __GFP_NOINIT basically defeats the hardening against information =
leaks
> > > > > provided by init_on_alloc, so one should use it with caution.
> > > > >
> > > > > This patch also adds __GFP_NOINIT to alloc_pages() calls in SL[AO=
U]B.
> > > > > Doing so is safe, because the heap allocators initialize the page=
s they
> > > > > receive before passing memory to the callers.
> > > > >
> > > > > Slowdown for the initialization features compared to init_on_free=
=3D0,
> > > > > init_on_alloc=3D0:
> > > > >
> > > > > hackbench, init_on_free=3D1:  +6.84% sys time (st.err 0.74%)
> > > > > hackbench, init_on_alloc=3D1: +7.25% sys time (st.err 0.72%)
> > > > >
> > > > > Linux build with -j12, init_on_free=3D1:  +8.52% wall time (st.er=
r 0.42%)
> > > > > Linux build with -j12, init_on_free=3D1:  +24.31% sys time (st.er=
r 0.47%)
> > > > > Linux build with -j12, init_on_alloc=3D1: -0.16% wall time (st.er=
r 0.40%)
> > > > > Linux build with -j12, init_on_alloc=3D1: +1.24% sys time (st.err=
 0.39%)
> > > > >
> > > > > The slowdown for init_on_free=3D0, init_on_alloc=3D0 compared to =
the
> > > > > baseline is within the standard error.
> > > > >
> >
> > Not sure, but I think this patch will clash with Matthew's posted patch=
 series
> > *Remove 'order' argument from many mm functions*.
> Not sure I can do much with that before those patches reach mainline.
> Once they do, I'll update my patches.
> Please let me know if there's a better way to resolve such conflicts.

I just thought to highlight about a possible conflict. Nothing else :)
IMO, if other patch series merge into -next tree before this,
then this series can be updated against -next.

... And I am sure others will have a better suggestion.

> > > > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > Cc: James Morris <jmorris@namei.org>
> > > > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Cc: Kostya Serebryany <kcc@google.com>
> > > > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Cc: Sandeep Patil <sspatil@android.com>
> > > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > > > Cc: Jann Horn <jannh@google.com>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: linux-mm@kvack.org
> > > > > Cc: linux-security-module@vger.kernel.org
> > > > > Cc: kernel-hardening@lists.openwall.com
> > > > > ---
> > > > >  include/linux/gfp.h | 6 +++++-
> > > > >  include/linux/mm.h  | 2 +-
> > > > >  kernel/kexec_core.c | 2 +-
> > > > >  mm/slab.c           | 2 +-
> > > > >  mm/slob.c           | 3 ++-
> > > > >  mm/slub.c           | 1 +
> > > > >  6 files changed, 11 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > index fdab7de7490d..66d7f5604fe2 100644
> > > > > --- a/include/linux/gfp.h
> > > > > +++ b/include/linux/gfp.h
> > > > > @@ -44,6 +44,7 @@ struct vm_area_struct;
> > > > >  #else
> > > > >  #define ___GFP_NOLOCKDEP       0
> > > > >  #endif
> > > > > +#define ___GFP_NOINIT          0x1000000u
> > > >
> > > > I mentioned this in the other patch, but I think this needs to be
> > > > moved ahead of GFP_NOLOCKDEP and adjust the values for GFP_NOLOCKDE=
P
> > > > and to leave the IS_ENABLED() test in __GFP_BITS_SHIFT alone.
> > > Do we really need this blinking GFP_NOLOCKDEP bit at all?
> > > This approach doesn't scale, we can't even have a second feature that
> > > has a bit depending on the config settings.
> > > Cannot we just fix the number of bits instead?
> > >
> > > > >  /* If the above are modified, __GFP_BITS_SHIFT may need updating=
 */
> > > > >
> > > > >  /*
> > > > > @@ -208,16 +209,19 @@ struct vm_area_struct;
> > > > >   * %__GFP_COMP address compound page metadata.
> > > > >   *
> > > > >   * %__GFP_ZERO returns a zeroed page on success.
> > > > > + *
> > > > > + * %__GFP_NOINIT requests non-initialized memory from the underl=
ying allocator.
> > > > >   */
> > > > >  #define __GFP_NOWARN   ((__force gfp_t)___GFP_NOWARN)
> > > > >  #define __GFP_COMP     ((__force gfp_t)___GFP_COMP)
> > > > >  #define __GFP_ZERO     ((__force gfp_t)___GFP_ZERO)
> > > > > +#define __GFP_NOINIT   ((__force gfp_t)___GFP_NOINIT)
> > > > >
> > > > >  /* Disable lockdep for GFP context tracking */
> > > > >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> > > > >
> > > > >  /* Room for N __GFP_FOO bits */
> > > > > -#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
> > > > > +#define __GFP_BITS_SHIFT (25)
> > > >
> > > > AIUI, this will break non-CONFIG_LOCKDEP kernels: it should just be=
:
> > > >
> > > > -#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
> > > > +#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))
> > > >
> > > > >  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT)=
 - 1))
> > > > >
> > > > >  /**
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index ee1a1092679c..8ab152750eb4 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -2618,7 +2618,7 @@ DECLARE_STATIC_KEY_FALSE(init_on_alloc);
> > > > >  static inline bool want_init_on_alloc(gfp_t flags)
> > > > >  {
> > > > >         if (static_branch_unlikely(&init_on_alloc))
> > > > > -               return true;
> > > > > +               return !(flags & __GFP_NOINIT);
> > > > >         return flags & __GFP_ZERO;
> > > >
> > > > What do you think about renaming __GFP_NOINIT to __GFP_NO_AUTOINIT =
or something?
> > > >
> > > > Regardless, yes, this is nice.
> > > >
> > > > --
> > > > Kees Cook
> > >
> > >
> > >
> > > --
> > > Alexander Potapenko
> > > Software Engineer
> > >
> > > Google Germany GmbH
> > > Erika-Mann-Stra=C3=9Fe, 33
> > > 80636 M=C3=BCnchen
> > >
> > > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> > > Registergericht und -nummer: Hamburg, HRB 86891
> > > Sitz der Gesellschaft: Hamburg
> > >
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg

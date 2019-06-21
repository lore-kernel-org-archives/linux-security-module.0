Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF601C48BE3
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 09:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E79E215EA
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 09:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJHRiZPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFUJSS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:18:18 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46510 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUJSS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 05:18:18 -0400
Received: by mail-vs1-f66.google.com with SMTP id l125so3395010vsl.13
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOA7F+74ao7xItWlpCMzlTnVq8LgdylLejX+BF9m8ic=;
        b=eJHRiZPtw/d7axvsQeCGaSQlLwSR3EzO3fA4AyvotmmVB+jkv8BvAOub0dpbDsecU8
         XHWlhZlAu3ccxEtYssD63iqhae7pZHrR3prAg5R2v8zh3O37uGqvndnkscxUbANPolGX
         bkgYFVR+TtJRuYEFR91PWHKZdLtmLSB3ulWq/ifj4a0ccjQ/BrLqeIjtyHLy6fsKuO5r
         2N5VWOBB8S0POJaHSQZDQkhZNCbCwPfHvdqAi6JvKvbls39a1fwHpCB95DmBjGzD3XOY
         zPceflY9rG1zjrdnY4mxSeTATcwQwVtTAT4hhiaEXS6v1zKQoJAyqc4t/yidcw24sfFk
         ymNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOA7F+74ao7xItWlpCMzlTnVq8LgdylLejX+BF9m8ic=;
        b=i9/8Tnu9ZIEIRJbghwrPa8nPzN4pFthw/gbSJiivY6XoaPzDejOP2sZKZL8lhpX8zL
         yhjHJRMTgvJrkMF6Mjj9DOufr13pT6fpazIOrzBxQOImTBZr0umqfxmpZ9d1QRMm5PJw
         YlSNkLaCrpzkqnqj9avsxvtwidF3HMFNoQt921d87qI+Pay/ES7WE0oRiNPdMDz5myOP
         l4rHhpPArb0tYVOoxtx4ewKbCZdPpIkEkW1a3H/3XWVqC0/1qUFruVm9Y8e9TkIAQvON
         ZhFIhFcu+FlNrJELFPF/Km6qRRTQ8LGtghD3ep7Inx13vMxy3yUGd38IoJ34yWDF1UXI
         LrcA==
X-Gm-Message-State: APjAAAXnX2wYWA5g0xNYaPYMllk+6C3pRRlMc3aqDykEhQEQpm2IpJ0I
        e/6q6BHkQ6FvWRIbLeB0IryiDRFzHAsLflio/Bu06g==
X-Google-Smtp-Source: APXvYqwd4qZYIVgmr5b8Xmp9jXK08gGTYRL0mOMr/IXslodesRYa3VNJ2znEn4tLbyfGSeteJkHHrP0+paaz0A9sgxc=
X-Received: by 2002:a67:2ec8:: with SMTP id u191mr15058824vsu.39.1561108697273;
 Fri, 21 Jun 2019 02:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190617151050.92663-1-glider@google.com> <20190617151050.92663-2-glider@google.com>
 <20190621070905.GA3429@dhcp22.suse.cz> <CAG_fn=UFj0Lzy3FgMV_JBKtxCiwE03HVxnR8=f9a7=4nrUFXSw@mail.gmail.com>
 <20190621091159.GD3429@dhcp22.suse.cz>
In-Reply-To: <20190621091159.GD3429@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 Jun 2019 11:18:06 +0200
Message-ID: <CAG_fn=Vhn4x_wVcftQUC4wh4JOgy8budA4+jj=dnRpPwqEz2TA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 11:12 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 21-06-19 10:57:35, Alexander Potapenko wrote:
> > On Fri, Jun 21, 2019 at 9:09 AM Michal Hocko <mhocko@kernel.org> wrote:
> [...]
> > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > index fd5c95ff9251..2f75dd0d0d81 100644
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -315,7 +315,7 @@ static struct page *kimage_alloc_pages(gfp_t gf=
p_mask, unsigned int order)
> > > >               arch_kexec_post_alloc_pages(page_address(pages), coun=
t,
> > > >                                           gfp_mask);
> > > >
> > > > -             if (gfp_mask & __GFP_ZERO)
> > > > +             if (want_init_on_alloc(gfp_mask))
> > > >                       for (i =3D 0; i < count; i++)
> > > >                               clear_highpage(pages + i);
> > > >       }
> > >
> > > I am not really sure I follow here. Why do we want to handle
> > > want_init_on_alloc here? The allocated memory comes from the page
> > > allocator and so it will get zeroed there. arch_kexec_post_alloc_page=
s
> > > might touch the content there but is there any actual risk of any kin=
d
> > > of leak?
> > You're right, we don't want to initialize this memory if init_on_alloc =
is on.
> > We need something along the lines of:
> >   if (!static_branch_unlikely(&init_on_alloc))
> >     if (gfp_mask & __GFP_ZERO)
> >       // clear the pages
> >
> > Another option would be to disable initialization in alloc_pages() usin=
g a flag.
>
> Or we can simply not care and keen the code the way it is. First of all
> it seems that nobody actually does use __GFP_ZERO unless I have missed
> soemthing
>         - kimage_alloc_pages(KEXEC_CONTROL_MEMORY_GFP, order); # GFP_KERN=
EL | __GFP_NORETRY
>         - kimage_alloc_pages(gfp_mask, 0);
>                 - kimage_alloc_page(image, GFP_KERNEL, KIMAGE_NO_DEST);
>                 - kimage_alloc_page(image, GFP_HIGHUSER, maddr);
>
> but even if we actually had a user do we care about double intialization
> for something kexec related? It is not any hot path AFAIR.
Yes, sounds good. Spraying the code with too many checks for
init_on_alloc doesn't really look nice.

> --
> Michal Hocko
> SUSE Labs



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

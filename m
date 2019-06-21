Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF39C43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD1C2089E
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 15:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Orrh03bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUPYe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:24:34 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42493 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUPYe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 11:24:34 -0400
Received: by mail-ua1-f67.google.com with SMTP id a97so3099437uaa.9
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=amUyKy/Lgb0XxSBaEjjhtM0Eo45SjaPoxv+deIw86VE=;
        b=Orrh03bfO4aJYjMke+4LWCWkC5w7vaywjOm7sMgTDaogBQJkmp4uomtEoruNeHvXd2
         wrFFjNZjkg9BjWHJ022RdUhZHglEuVmdtxZhRx0tOMqawEIBURchGPgfPlRj+a8uxPhP
         JX7n4iiDXIP+0JEApmdlwKD/3M2IK7LKVFDrSVbORdw5UYpwP33WvmSo1xgIQ1mF8URV
         CpjrlFZib0+riIcxhJsF+r9Q6aor+CUCS5+r6W5oWWyhoNk2kahaBYe+zmaLbLSfArA9
         tIFjs3SCWMUiX9Z3BF0xEM+M/Z+AdXOT++bJRk7DdW0a9XEcD1YrbOeecsxWtuTYKrTv
         5l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=amUyKy/Lgb0XxSBaEjjhtM0Eo45SjaPoxv+deIw86VE=;
        b=bYiFNFG71U2YiUgWQ/MP3oDLDgs7wW9n0jYEbgn+l9eT1OTI4HW6fcoHkSPkuSb2gQ
         r5vzEF4LUf3FJdrnpip3hm3Vq9LoD81c4prRt4fhoqqIw61ZTvJ48AxuHfFU5FAFxkxf
         by/V3W/PQSp/FOikGGkGdVT6yHrnT/C3ouYoAwCNPYFQr27BzdbAfmKYtAUxvsaeL4Ze
         AGncF0RMT2BEM7ew06y0dtA1Zy094/o93QuGMyhMxZAJIZ6qFUL5KJHHdIMNeBeOvvYs
         OztzsmfiV9i/p8yIwyYEgl8azdk8Q3GVlRM4lu057oRvuiA+6smjZ4bPvzgjYnKGRidx
         Qgaw==
X-Gm-Message-State: APjAAAWWqsBXkFaNBbu3TWQNKM9uYCgKpUlkGUNYNHvjBdzPF0+a4w4t
        rKYeZeYJCpESn3zlBMoH6CPyZ1mEWxYd8BLoaWKMFQ==
X-Google-Smtp-Source: APXvYqya9eZAEQgsoWb9uXlO3KmWacfsgpndqCO4dX8FLhHaJ4fELI+m+POxQSeCWNXsEFT6mpjddhLn9tBh04jJ7r0=
X-Received: by 2002:ab0:30a3:: with SMTP id b3mr12857232uam.3.1561130673280;
 Fri, 21 Jun 2019 08:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190617151050.92663-1-glider@google.com> <20190617151050.92663-2-glider@google.com>
 <20190621070905.GA3429@dhcp22.suse.cz> <CAG_fn=UFj0Lzy3FgMV_JBKtxCiwE03HVxnR8=f9a7=4nrUFXSw@mail.gmail.com>
 <CAG_fn=W90HNeZ0UcUctnbUBzJ=_b+gxMGdUoDyO3JPoyy4dGSg@mail.gmail.com> <20190621151210.GF3429@dhcp22.suse.cz>
In-Reply-To: <20190621151210.GF3429@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 21 Jun 2019 17:24:21 +0200
Message-ID: <CAG_fn=W2fm5zkAUW8PcTYpfH57H89ukFGAoBHUOmyM-S1agdZg@mail.gmail.com>
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

On Fri, Jun 21, 2019 at 5:12 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 21-06-19 16:10:19, Alexander Potapenko wrote:
> > On Fri, Jun 21, 2019 at 10:57 AM Alexander Potapenko <glider@google.com=
> wrote:
> [...]
> > > > > diff --git a/mm/dmapool.c b/mm/dmapool.c
> > > > > index 8c94c89a6f7e..e164012d3491 100644
> > > > > --- a/mm/dmapool.c
> > > > > +++ b/mm/dmapool.c
> > > > > @@ -378,7 +378,7 @@ void *dma_pool_alloc(struct dma_pool *pool, g=
fp_t mem_flags,
> > > > >  #endif
> > > > >       spin_unlock_irqrestore(&pool->lock, flags);
> > > > >
> > > > > -     if (mem_flags & __GFP_ZERO)
> > > > > +     if (want_init_on_alloc(mem_flags))
> > > > >               memset(retval, 0, pool->size);
> > > > >
> > > > >       return retval;
> > > >
> > > > Don't you miss dma_pool_free and want_init_on_free?
> > > Agreed.
> > > I'll fix this and add tests for DMA pools as well.
> > This doesn't seem to be easy though. One needs a real DMA-capable
> > device to allocate using DMA pools.
> > On the other hand, what happens to a DMA pool when it's destroyed,
> > isn't it wiped by pagealloc?
>
> Yes it should be returned to the page allocator AFAIR. But it is when we
> are returning an object to the pool when you want to wipe the data, no?
My concern was that dma allocation is something orthogonal to heap and
page allocator.
I also don't know how many other allocators are left overboard, e.g.
we don't do anything to lib/genalloc.c yet.

> Why cannot you do it along the already existing poisoning?
I can sure keep these bits.
Any idea how the correct behavior of dma_pool_alloc/free can be tested?
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

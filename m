Return-Path: <SRS0=MGza=UZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E83C48BD6
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A9120663
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DK/n2Vrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFZPA5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:00:57 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37174 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZPA5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 11:00:57 -0400
Received: by mail-ua1-f67.google.com with SMTP id z13so873741uaa.4
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2019 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zoBpYP6DnaC2e4XaW1/B4gA/As2GEKNd5dW1F1ry1DA=;
        b=DK/n2VrqOoEDzclYHyq2tl89y1S1BefzXcCfPYtMbncmdAEousuPD4nlrlFXjn1yAf
         0UZ2zw7aNcVImRdErGoO1CbC7dXKUVSHtuP/yzBJwyIo0zemDC+R1hWnWRVjgVrAnU/G
         cvK2xJ+dmRwfI/NlGzWTm84i2qOlJR71o3B40rbm5P6vctgPwQKEgs1Tg5/t6YaLCHdC
         NspZwHSWueky8RI+rBqgzac4hPLgVsWXreGq8arKJv49UONak6A2T0SZgr27vzlXESkF
         A2h4u/1rIlOtZdFXckVdzyVlUD6I+t5bFeMa4UmxkyNAZS24W5IdZKhDlhFU8RIuBuk/
         acXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zoBpYP6DnaC2e4XaW1/B4gA/As2GEKNd5dW1F1ry1DA=;
        b=QrfXtItgQ0QdFUANMRiL6HlXs8T5m7GDVNqPQ49M2Hf1Gd16nxER4x8bSUI5rNE11d
         dYlbsZLZM8GHHCixWDbgpaZ1IFPSmPLkmexPpvoDD9TdWc9Nbv6JeYvEBU6CwPQIrGh3
         EqePj88YHQ0FR1k+j0wBU84r6AAKLGXUQudabANyU6u/sfncKHXQ/aXFpHLFfaqFIJO9
         f9HeJzx8pp22nxw1u1K0M+QlVXTc8WpT3CjFBbt5cUWduDAPZGnMiy8VMFutgLz+T3Y1
         MNzZdlpd46GG8fQ7Ni+OdbtAy064Np7KsX3edZoUyyBaXxAO1bKdlkuthXY4zD7NLKdT
         NxZg==
X-Gm-Message-State: APjAAAU++4hKEpKt/tB+K6vjpjAl7G3A7/W/t21ZaMIYFo+lXu7Fst9B
        41floRDQGqKzG9ItaE55pFzOdqVKphj9oZpRHOd5+A==
X-Google-Smtp-Source: APXvYqxOM1Qhb4bYwyr4BHkaaqPHuZq394nkXxdn6QI/Fj8/wCimkp9o3YMPWPV8de9K2LGJFGbIpbZSCKxhz9J77fk=
X-Received: by 2002:ab0:3d2:: with SMTP id 76mr2748402uau.12.1561561255636;
 Wed, 26 Jun 2019 08:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121943.131390-1-glider@google.com> <20190626121943.131390-2-glider@google.com>
 <20190626144943.GY17798@dhcp22.suse.cz>
In-Reply-To: <20190626144943.GY17798@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 26 Jun 2019 17:00:43 +0200
Message-ID: <CAG_fn=Xf5yEuz7JyOt-gmNx1uSM6mmM57_jFxCi+9VPZ4PSwJQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
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
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 4:49 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 26-06-19 14:19:42, Alexander Potapenko wrote:
> [...]
> > diff --git a/mm/dmapool.c b/mm/dmapool.c
> > index 8c94c89a6f7e..fe5d33060415 100644
> > --- a/mm/dmapool.c
> > +++ b/mm/dmapool.c
> [...]
> > @@ -428,6 +428,8 @@ void dma_pool_free(struct dma_pool *pool, void *vad=
dr, dma_addr_t dma)
> >       }
> >
> >       offset =3D vaddr - page->vaddr;
> > +     if (want_init_on_free())
> > +             memset(vaddr, 0, pool->size);
>
> any reason why this is not in DMAPOOL_DEBUG else branch? Why would you
> want to both zero on free and poison on free?
This makes sense, thanks.

> >  #ifdef       DMAPOOL_DEBUG
> >       if ((dma - page->dma) !=3D offset) {
> >               spin_unlock_irqrestore(&pool->lock, flags);
>
> [...]
>
> > @@ -1142,6 +1200,8 @@ static __always_inline bool free_pages_prepare(st=
ruct page *page,
> >       }
> >       arch_free_page(page, order);
> >       kernel_poison_pages(page, 1 << order, 0);
> > +     if (want_init_on_free())
> > +             kernel_init_free_pages(page, 1 << order);
>
> same here. If you don't want to make this exclusive then you have to
> zero before poisoning otherwise you are going to blow up on the poison
> check, right?
Note that we disable initialization if page poisoning is on.
As I mentioned on another thread we can eventually merge this code
with page poisoning, but right now it's better to make the user decide
which of the features they want instead of letting them guess how the
combination of the two is going to work.
> >       if (debug_pagealloc_enabled())
> >               kernel_map_pages(page, 1 << order, 0);
> >
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

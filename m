Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601DC04E87
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B042173C
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfCTHd4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfEQOjF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 10:39:05 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42003 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfEQOjF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 10:39:05 -0400
Received: by mail-vk1-f196.google.com with SMTP id u131so2072796vke.9
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ddYknnyy251jUXjF119a2VyFqAoO0MJ7lwXqU8aG9CY=;
        b=ZfCTHd4njmwJ6LmyMIrWpboajTklaeBflvOkckUG57zSTiCO9V6zZ/F4wxPdk/qNUQ
         PVYMluJEt88jyugSzqc0nG7UZR7DLvqpFQzEFftB05/78KyrZltNrXCTTPfD64+BZVrD
         petSewDBThIM52+IEcDFxCTrwU4XGvwQzXx2OnY7RGaGl7FzEu9k9MeOMqSnQQ9BAkCW
         oGVCwrkpIb4glulSXJTh+pRPJrqZboKu7VuIf2urRTJSx9c6Q/Pq/jAHZhhJ81Od6+24
         +t1zJKIIPbGUXy6ajnaWTV/1OoHtLOlwMLRNj475X7xcV2GizLUQNcqPSE4CshTe69LP
         g0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ddYknnyy251jUXjF119a2VyFqAoO0MJ7lwXqU8aG9CY=;
        b=oZRLxW21H2i2T62AZD1iA1umDX5Ac8tRrYNQe2waZKdnHkACKzF4tg0TicNRQ3SuLS
         FuS6Qo0++ey28s508yMkroLI/KWgmFIktWlAnGW2E4aj2qyRFVNFVBFsGO4kj9sOaq8X
         9CcmhIy/uQrUth0l1cnpLcegfMcNGXGcPVaL+cuSF70zKqIAFwLrYZJnBbQH6Zo4StiQ
         v4jaTa/oJqS9wSSn7z9B3lgzistaOJNEwuRxUeKZQusboXaUppueDrU4qtcWpYaS+oHb
         7mLZXmrJpJ2WiAbAe5YwIz8Yog8km6MDMXyJl57nxtz1+a9i2OGiS7/G+U1ClozuI7gr
         IAnQ==
X-Gm-Message-State: APjAAAUFiA4cVgSFiKRh29iRpd+Vfvq8A7Clhe2LAY/I3Mxr6GkWkZ58
        tGkvUsdCaIxMpQgfE4vjAdaREp2uvyIL5tnj6TS4Dg==
X-Google-Smtp-Source: APXvYqzmJFfH7vnjyDXwEt0PEao3F5jTjrlEKGaCN9GO7PVaS+H8433b6AZMGQxWDooobwXiz1H5CeN39cIPFc6Nv50=
X-Received: by 2002:a1f:ae4b:: with SMTP id x72mr2631730vke.29.1558103943898;
 Fri, 17 May 2019 07:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-1-glider@google.com> <20190514143537.10435-2-glider@google.com>
 <201905161824.63B0DF0E@keescook>
In-Reply-To: <201905161824.63B0DF0E@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 May 2019 16:38:51 +0200
Message-ID: <CAG_fn=U-8XiBVRDhr9QxLj0Yj+1ud41KvmUqEt9Gih9MAznuPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
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
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 3:26 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 14, 2019 at 04:35:34PM +0200, Alexander Potapenko wrote:
> > [...]
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 43ac818b8592..24ae887359b8 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -524,4 +524,20 @@ static inline int cache_random_seq_create(struct k=
mem_cache *cachep,
> > [...]
> > +static inline bool slab_want_init_on_free(struct kmem_cache *c)
> > +{
> > +     if (static_branch_unlikely(&init_on_free))
> > +             return !(c->ctor);
>
> BTW, why is this checking for c->ctor here? Shouldn't it not matter for
> the free case?
It does matter, see e.g. the handling of __OBJECT_POISON in slub.c
If we just return true here, the kernel crashes.
> > +     else
> > +             return false;
> > +}
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

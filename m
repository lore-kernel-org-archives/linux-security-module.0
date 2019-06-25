Return-Path: <SRS0=mxSC=UY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C20C48BD4
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jun 2019 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D74A208E3
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jun 2019 15:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sV9oh2RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfFYPm7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:42:59 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37200 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbfFYPm6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jun 2019 11:42:58 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so11204575vsq.4
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jun 2019 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUfwNQBOi/BNFV+4gDSnqcbmOZ2eF/S7imxNo+MJGuw=;
        b=sV9oh2RASS5zpqZVHKKGJxJRy8QFppvn8NhWda7yYLYazc+1NfrJf9c8Q7Ksdh2qVh
         GbInfrz3Q/R804KazPTI6pqZiuW+qA7fYZ6cfuv0A/uIX2cuoIagmY+grmarNxXB3KIV
         CV0UsAeEvPzhkSV1srYnweXyIbNpXJ4VT7ftbANfQK0824ixV9yBnxvk00lmyNtZwFVE
         aCBREhp7Yk+TKyPI2y64zwDJXfSy5yR3jAV9OXrsTlc7KSLZBfy51GL7RUozIDDGh89J
         fltXE72SZLR3f6f6wZtvwP5llYax4JMBuGoS0RwTp8VL7XajJkixwkdta5C6Eqz7NIxH
         8tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUfwNQBOi/BNFV+4gDSnqcbmOZ2eF/S7imxNo+MJGuw=;
        b=EaxAOgr7oWXj1j6T8OXNvErDeoNpCytXJ1bUyj0hxJoXWIzl8VLLwGURLgTEKB2vt5
         V0zUyuLKrC2qkLHfq/bPTrQ5N/TTucbq+2nID7JoJQrkTvqNUUHKuBdV03WcMEaZow4p
         f5hC+0WsOp9s+XcjFoDQDbGcMIsGuJY9XLFsxKY6IxVN7liDr9IUokZPmiT83HVDuPQi
         ucNC5N/kLHctz3i9XE8Wbsg9E+IOR1YYYq5k3bunW/WrNSi9jJmDcc3YrN6sAXLXzK04
         w5emO5lNdcaEhY4QOH4RvatMUcD1vogQZYmbUazjVklNJOqelbYn8RXzBECprv22DHIS
         p4AA==
X-Gm-Message-State: APjAAAX5oXWsJHqtKFEtPaDPHIW4eK5+N589O66XQC+6V48HYL/W/4ST
        whlSIj5ud0a3h3o6JcyxxldzAGXSHaJwApnnJjiHxw==
X-Google-Smtp-Source: APXvYqzLHIJfk/IhqSGoXbjZlH6E7iaTV0wslA1Ml/4Nyhq4SwItBVki34mlaIunyOmV/cW1HTz21auucu/pZvDGzbc=
X-Received: by 2002:a67:11c1:: with SMTP id 184mr58499747vsr.217.1561477377591;
 Tue, 25 Jun 2019 08:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190606164845.179427-1-glider@google.com> <20190606164845.179427-2-glider@google.com>
 <201906070841.4680E54@keescook> <201906201821.8887E75@keescook>
In-Reply-To: <201906201821.8887E75@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 25 Jun 2019 17:42:45 +0200
Message-ID: <CAG_fn=VceGkQPuJ45ffmy-9rRdx515z10N97FApeZR9YrXSHVA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
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

On Fri, Jun 21, 2019 at 3:37 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 07, 2019 at 08:42:27AM -0700, Kees Cook wrote:
> > On Thu, Jun 06, 2019 at 06:48:43PM +0200, Alexander Potapenko wrote:
> > > [...]
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index cd04dbd2b5d0..9c4a8b9a955c 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > [...]
> > > @@ -2741,8 +2758,14 @@ static __always_inline void *slab_alloc_node(s=
truct kmem_cache *s,
> > >             prefetch_freepointer(s, next_object);
> > >             stat(s, ALLOC_FASTPATH);
> > >     }
> > > +   /*
> > > +    * If the object has been wiped upon free, make sure it's fully
> > > +    * initialized by zeroing out freelist pointer.
> > > +    */
> > > +   if (unlikely(slab_want_init_on_free(s)) && object)
> > > +           *(void **)object =3D NULL;
>
> In looking at metadata again, I noticed that I don't think this is
> correct, as it needs to be using s->offset to find the location of the
> freelist pointer:
>
>         memset(object + s->offset, 0, sizeof(void *));
In the cases we support s->offset is always zero (we don't initialize
slabs with ctors or RCU), but using its value is a sane
generalization.

> > >
> > > -   if (unlikely(gfpflags & __GFP_ZERO) && object)
> > > +   if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
> > >             memset(object, 0, s->object_size);
>
> init_on_alloc is using "object_size" but init_on_free is using "size". I
> assume the "alloc" wipe is smaller because metadata was just written
> for the allocation?
As noted in another thread, using "size" is incorrect, because it may
overwrite the redzone after the object.
I'll send a patch to fix that.
Overwriting the metadata indeed shouldn't make sense in the allocation case=
.
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

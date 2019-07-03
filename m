Return-Path: <SRS0=lFJQ=VA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B47C06513
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jul 2019 11:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3B7218A3
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jul 2019 11:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWENStUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCLkl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:40:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37030 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLkl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jul 2019 07:40:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so2429231wrr.4
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jul 2019 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zHeU17lmmKwn4HqZvPfxORCzKm21XY5rEHkO8j8X2vA=;
        b=FWENStURUf6QH7xHmCVgopjHfyiKu/4SooEMN/M3xfHJoiRlaDcJryuPhpcSa0QXJc
         L2OGx1unh2jzwLITaBnnjL+GuoJtraiLxKV6yuuwcCe9pvwq9hZx4z0p8rb1dKW1pVTO
         3Q4wN347G+HW/3WVDHqpEhiUXAqyeTgLhRTdEIjcxCWtcWipzbrlrk/VUbqy14PnRWq1
         dwEL4HkXik9GgnBAfxtna96yVwHmS8enJF7i9gJaHU+sghXXOMe6qAYrz7Ybqjl/ZHGh
         xuwM9y8QeTH/YAWTdB9V5MSkTN3NZwzYfhkIeupxk5QgP3HNq4qblB4rqUBIrxxGkVov
         hbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHeU17lmmKwn4HqZvPfxORCzKm21XY5rEHkO8j8X2vA=;
        b=qEqha07HEglAG+uXHNUaJk2IL5+e2dIE3cLRenA7BPQaiw1lLEhkptJ64yCGr06Q1M
         eBdpncuwsfDTO2wf+GhyWlcxMIEBHz6Y2za6bdYwAU5PMkZOhtIlvlWpIdZ3MWa9HQ15
         qArwXki5C1pDxG5t/2ZBp8TIhpmY3518HuFdtKIlDkShnSUMkYapdNg7z+v/nXRkNUSJ
         JOUjRpmt8LOtDmcwjI9Em+nLfQVDGKRw53Bd9HKmu9qS/TlG6FQ9DAeGeSsRnEZ4NufQ
         6RKf1Di5voikcdWgbN/F/fMngITtehDdbPn84pZZNihUJBW1SXH1S6ABDvoP0DHNhhBj
         YWUA==
X-Gm-Message-State: APjAAAUm7lHEC68hSjOgK+Ow0Qe+OykXYSefyLl5cNaj9kawA0rohvdX
        5uP6qASlTrSeJgJQD53UX0Up9kvSbnUKXWEzVqH/kA==
X-Google-Smtp-Source: APXvYqw4s3sYsNizBmCtzQpw8k78tkfYpE3dYnEnwrtdq2L+zw7BXTL3xh1CoycHraoMSTwIPbxeB+18b/h0kSxWd1g=
X-Received: by 2002:adf:f64a:: with SMTP id x10mr20291629wrp.287.1562154037981;
 Wed, 03 Jul 2019 04:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190628093131.199499-1-glider@google.com> <20190628093131.199499-2-glider@google.com>
 <20190702155915.ab5e7053e5c0d49e84c6ed67@linux-foundation.org>
In-Reply-To: <20190702155915.ab5e7053e5c0d49e84c6ed67@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Jul 2019 13:40:26 +0200
Message-ID: <CAG_fn=XYRpeBgLpbwhaF=JfNHa-styydOKq8_SA3vsdMcXNgzw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        James Morris <jamorris@linux.microsoft.com>,
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
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 3, 2019 at 12:59 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Fri, 28 Jun 2019 11:31:30 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > The new options are needed to prevent possible information leaks and
> > make control-flow bugs that depend on uninitialized values more
> > deterministic.
> >
> > This is expected to be on-by-default on Android and Chrome OS. And it
> > gives the opportunity for anyone else to use it under distros too via
> > the boot args. (The init_on_free feature is regularly requested by
> > folks where memory forensics is included in their threat models.)
> >
> > init_on_alloc=3D1 makes the kernel initialize newly allocated pages and=
 heap
> > objects with zeroes. Initialization is done at allocation time at the
> > places where checks for __GFP_ZERO are performed.
> >
> > init_on_free=3D1 makes the kernel initialize freed pages and heap objec=
ts
> > with zeroes upon their deletion. This helps to ensure sensitive data
> > doesn't leak via use-after-free accesses.
> >
> > Both init_on_alloc=3D1 and init_on_free=3D1 guarantee that the allocato=
r
> > returns zeroed memory. The two exceptions are slab caches with
> > constructors and SLAB_TYPESAFE_BY_RCU flag. Those are never
> > zero-initialized to preserve their semantics.
> >
> > Both init_on_alloc and init_on_free default to zero, but those defaults
> > can be overridden with CONFIG_INIT_ON_ALLOC_DEFAULT_ON and
> > CONFIG_INIT_ON_FREE_DEFAULT_ON.
> >
> > If either SLUB poisoning or page poisoning is enabled, those options
> > take precedence over init_on_alloc and init_on_free: initialization is
> > only applied to unpoisoned allocations.
> >
> > Slowdown for the new features compared to init_on_free=3D0,
> > init_on_alloc=3D0:
> >
> > hackbench, init_on_free=3D1:  +7.62% sys time (st.err 0.74%)
> > hackbench, init_on_alloc=3D1: +7.75% sys time (st.err 2.14%)
> >
> > Linux build with -j12, init_on_free=3D1:  +8.38% wall time (st.err 0.39=
%)
> > Linux build with -j12, init_on_free=3D1:  +24.42% sys time (st.err 0.52=
%)
> > Linux build with -j12, init_on_alloc=3D1: -0.13% wall time (st.err 0.42=
%)
> > Linux build with -j12, init_on_alloc=3D1: +0.57% sys time (st.err 0.40%=
)
> >
> > The slowdown for init_on_free=3D0, init_on_alloc=3D0 compared to the
> > baseline is within the standard error.
> >
> > The new features are also going to pave the way for hardware memory
> > tagging (e.g. arm64's MTE), which will require both on_alloc and on_fre=
e
> > hooks to set the tags for heap objects. With MTE, tagging will have the
> > same cost as memory initialization.
> >
> > Although init_on_free is rather costly, there are paranoid use-cases wh=
ere
> > in-memory data lifetime is desired to be minimized. There are various
> > arguments for/against the realism of the associated threat models, but
> > given that we'll need the infrastructure for MTE anyway, and there are
> > people who want wipe-on-free behavior no matter what the performance co=
st,
> > it seems reasonable to include it in this series.
> >
> > ...
> >
> >  v10:
> >   - added Acked-by: tags
> >   - converted pr_warn() to pr_info()
>
> There are unchangelogged alterations between v9 and v10.  The
> replacement of IS_ENABLED(CONFIG_PAGE_POISONING)) with
> page_poisoning_enabled().
In the case I send another version of the patch, do I need to
retroactively add them to the changelog?
>
> --- a/mm/page_alloc.c~mm-security-introduce-init_on_alloc=3D1-and-init_on=
_free=3D1-boot-options-v10
> +++ a/mm/page_alloc.c
> @@ -157,8 +157,8 @@ static int __init early_init_on_alloc(ch
>         if (!buf)
>                 return -EINVAL;
>         ret =3D kstrtobool(buf, &bool_result);
> -       if (bool_result && IS_ENABLED(CONFIG_PAGE_POISONING))
> -               pr_warn("mem auto-init: CONFIG_PAGE_POISONING is on, will=
 take precedence over init_on_alloc\n");
> +       if (bool_result && page_poisoning_enabled())
> +               pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will=
 take precedence over init_on_alloc\n");
>         if (bool_result)
>                 static_branch_enable(&init_on_alloc);
>         else
> @@ -175,8 +175,8 @@ static int __init early_init_on_free(cha
>         if (!buf)
>                 return -EINVAL;
>         ret =3D kstrtobool(buf, &bool_result);
> -       if (bool_result && IS_ENABLED(CONFIG_PAGE_POISONING))
> -               pr_warn("mem auto-init: CONFIG_PAGE_POISONING is on, will=
 take precedence over init_on_free\n");
> +       if (bool_result && page_poisoning_enabled())
> +               pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, will=
 take precedence over init_on_free\n");
>         if (bool_result)
>                 static_branch_enable(&init_on_free);
>         else
> --- a/mm/slub.c~mm-security-introduce-init_on_alloc=3D1-and-init_on_free=
=3D1-boot-options-v10
> +++ a/mm/slub.c
> @@ -1281,9 +1281,8 @@ check_slabs:
>  out:
>         if ((static_branch_unlikely(&init_on_alloc) ||
>              static_branch_unlikely(&init_on_free)) &&
> -           (slub_debug & SLAB_POISON)) {
> -               pr_warn("mem auto-init: SLAB_POISON will take precedence =
over init_on_alloc/init_on_free\n");
> -       }
> +           (slub_debug & SLAB_POISON))
> +               pr_info("mem auto-init: SLAB_POISON will take precedence =
over init_on_alloc/init_on_free\n");
>         return 1;
>  }
>
> _
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

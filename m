Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC3C10F13
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5E3206BA
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 12:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBRSf+Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDPMWL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:22:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40104 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPMWL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Apr 2019 08:22:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id b8so6632629uaq.7
        for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2019 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bdEs7uYsw1GOSiu24cA7C0KHfg2lyObuKuQzd3OIlyk=;
        b=JBRSf+Ji0s54jJi+6Lpqy370y89sX7kIKPg+sfBOKk/mLimssDnGKH9zXMjCE89lG8
         IR9sjMMTs0rwQvkaDLSe+ZlHEyt04Ur3x6it1Aap2kZbQTwEF/NGXRkpdGM8Ee5TyTSC
         V8JPndQF+f3TsfWTcvRmz4nrDY21rpmgij5TXJC4858ZL+uPIbOHFERn9EFJhHg7INSK
         +Jj0taGaG4Xcjde402fKSp89nZ1FQT2lWuZsGMBDQid4apwhl8SZZ/7UNsmS2CwSufrn
         umDsHypZ4yKWxONLl1Bie35QqbmJhGecQXHhxKRAviEKuDaJOyJhNZSMb70zy3F1evwS
         w/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bdEs7uYsw1GOSiu24cA7C0KHfg2lyObuKuQzd3OIlyk=;
        b=DKUjFZLRs8ZHz2EQ0sXt6MjWZGPNYQaDmSx1USGnLyQphI2SbZq2DJyP7Ty/AE80QZ
         t4t0LfLTos/Gwm6BaX9qENr0la6fir5y0RroJhcgMR4qpttH8jfhLzSBbgrpnPj85pSG
         sZTtdz4WaFu0w0nMspCzUVSHpen8LpnZpEvZBO7JrEVvSWn3FUm9yA1nN91+V4mML8L/
         DVlrqa8mUsDjTuwbmEMhtH8AXe0QzqH01Uzf2H75SuAUKP3Z07Rf4v0DlhMk31QouguK
         wwulRjwq6vmSvabhrRE9bFFuj0VO3VyVKbfhxXtgLbAhWWiqCEcsst0kTgIQWq6zmsg/
         1jNw==
X-Gm-Message-State: APjAAAUUTxFvgGEa/csui95Q7Zf73gMijPGRNE3LmZDVm/3yu4srKjIU
        /Yyjp7tnYamJBbkUFAdydeWWxCr1KLG/p/7HLwB2rQ==
X-Google-Smtp-Source: APXvYqyVe76DswO88r/webO5iCtniBizYS3WbdFa5kvuIF7qLTsDqkoZD1+jZ+BupMeU3+8JZRVAi/HGBcaW150CI1U=
X-Received: by 2002:ab0:2495:: with SMTP id i21mr41234515uan.49.1555417330235;
 Tue, 16 Apr 2019 05:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190412124501.132678-1-glider@google.com> <20190415190213.5831bbc17e5073690713b001@linux-foundation.org>
In-Reply-To: <20190415190213.5831bbc17e5073690713b001@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 16 Apr 2019 14:21:59 +0200
Message-ID: <CAG_fn=W1rELLO4mx1RoM01shFVkyQjT3eU5wyqMRjprzVD5oMQ@mail.gmail.com>
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 16, 2019 at 4:02 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Fri, 12 Apr 2019 14:45:01 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > This config option adds the possibility to initialize newly allocated
> > pages and heap objects with zeroes.
>
> At what cost?  Some performance test results would help this along.
I'll make more measurements for the new implementation, but the
preliminary results are:
~0.17% sys time slowdown (~0% wall time slowdown) on hackbench (1 CPU);
1.3% sys time slowdown (0.2% wall time slowdown) when building Linux with -=
j12;
4% sys time slowdown (2.6% wall time slowdown) on af_inet_loopback benchmar=
k;
up to 100% slowdown on netperf (caused by sk buffers being initialized
multiple times; also netperf is too fast to perform any precise
measurements)

Are there any benchmarks you can recommend?
> > This is needed to prevent possible
> > information leaks and make the control-flow bugs that depend on
> > uninitialized values more deterministic.
> >
> > Initialization is done at allocation time at the places where checks fo=
r
> > __GFP_ZERO are performed. We don't initialize slab caches with
> > constructors or SLAB_TYPESAFE_BY_RCU to preserve their semantics.
> >
> > For kernel testing purposes filling allocations with a nonzero pattern
> > would be more suitable, but may require platform-specific code. To have
> > a simple baseline we've decided to start with zero-initialization.
> >
> > No performance optimizations are done at the moment to reduce double
> > initialization of memory regions.
>
> Requiring a kernel rebuild is rather user-hostile.
This is intended to be used together with other hardening measures,
like CONFIG_INIT_STACK_ALL (see a patchset by Kees).
All of those require a kernel rebuild, but we assume users don't push
and pull that lever back and forth often.

> A boot option
> (early_param()) would be much more useful and I expect that the loss in
> coverage would be small and acceptable?  Could possibly use the
> static_branch infrastructure.
I'll try that out and see if there's a notable performance difference.

> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -167,6 +167,16 @@ static inline slab_flags_t kmem_cache_flags(unsign=
ed int object_size,
> >                             SLAB_TEMPORARY | \
> >                             SLAB_ACCOUNT)
> >
> > +/*
> > + * Do we need to initialize this allocation?
> > + * Always true for __GFP_ZERO, CONFIG_INIT_HEAP_ALL enforces initializ=
ation
> > + * of caches without constructors and RCU.
> > + */
> > +#define SLAB_WANT_INIT(cache, gfp_flags) \
> > +     ((GFP_INIT_ALWAYS_ON && !(cache)->ctor && \
> > +       !((cache)->flags & SLAB_TYPESAFE_BY_RCU)) || \
> > +      (gfp_flags & __GFP_ZERO))
>
> Is there any reason why this *must* be implemented as a macro?  If not,
> it should be written in C please.
Agreed. Even in the case we want GFP_INIT_ALWAYS_ON to be known at
compile time there's no reason for this to be a macro.
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

Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42BAC04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 08:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02C2082E
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 08:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L17n4MiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfEQItQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 04:49:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32788 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEQItQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 04:49:16 -0400
Received: by mail-vs1-f67.google.com with SMTP id y6so4161836vsb.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dcKNTtASXX61Q+VQr8INe49VkZfJpp38n/5rM4hpO6M=;
        b=L17n4MiMW7VFyQE9PCxCtQ37t2a1Wc5Jn9V0cOf+nXVc7WbgrEA+XNwEHw1OgXi3V7
         QR5kHf/KQyqtT9tgUeeWuaf7EW91762vRWCIxrrkLG0EeghJYGV9+A/HrETuO5I2jVuL
         0alBtY+sHd2baPoT3zytaA3Jh8D+kQmT4m7FxWr21/zZoLv6VBFF/ObluRCJrPTYt/fx
         fCmNr/z0F+W7jB2p3hdd2dcW5Db93F9IseCYmKAwmVMmAZ+qe5+a6ITXxZv9i5MOjlYK
         0LC2uyo6WYi/VcMZiWRCrLFeS/41MURPF4f42J7VREGI9brrmoCceTUeyI/xDEmUIZfI
         lyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dcKNTtASXX61Q+VQr8INe49VkZfJpp38n/5rM4hpO6M=;
        b=Pi/6uAkUuM+6d1lzG4uNugrr7XNCagXf6NyJtJg8sCPlsuZDtW3B+auo8gzXK44gy0
         J0fvqp2StGMsSA//EBKDDtyxDxHb55SnPsKRaqefilzUbl096lM/urk2bu0/B0v+u5Ig
         VyxP7uz+Q2gr+xnl6f7lXq/mQYSuEMy/SVuBuOm19gHLpJoB+TqmSXnZeSneshaRkOAo
         JM4iH8euG0Fi73VCgMMtD6jn6H1W55lVBQ10yrqGW+PxU8cXXrqJKAlFoC7sr1xOFFTD
         5inocOO4LIBJdy78TGRhpW3FHqanXSwlWOquiVzmbZX7fwpvDDT/Yvf3nJkfUFmOWOWQ
         wwjA==
X-Gm-Message-State: APjAAAVUNS+QolDM6ISx0jFlbtwxXCyg0FCLbl8rKY+uNUqNRNn306//
        F9XDPI9HY1bSnGPMhvG2SjwUNGzj6Z5yB0fyPv2o7A==
X-Google-Smtp-Source: APXvYqzjUD0ahzXEakEX3krc2+ox/87AMfIOaCIz/6rEh7xXajD9IsIsVNzi0hRDQJd9iq5DpU4tQU0ApbW3Gj4ZDrA=
X-Received: by 2002:a67:7241:: with SMTP id n62mr3594300vsc.217.1558082954585;
 Fri, 17 May 2019 01:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-1-glider@google.com> <20190514143537.10435-5-glider@google.com>
 <201905160923.BD3E530EFC@keescook> <201905161714.A53D472D9@keescook>
In-Reply-To: <201905161714.A53D472D9@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 May 2019 10:49:03 +0200
Message-ID: <CAG_fn=Vj6Jk_DY_-0+x6EpbsVh+abpEVcjycBhJxeMH3wuy9rw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] net: apply __GFP_NO_AUTOINIT to AF_UNIX sk_buff allocations
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

On Fri, May 17, 2019 at 2:26 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, May 16, 2019 at 09:53:01AM -0700, Kees Cook wrote:
> > On Tue, May 14, 2019 at 04:35:37PM +0200, Alexander Potapenko wrote:
> > > Add sock_alloc_send_pskb_noinit(), which is similar to
> > > sock_alloc_send_pskb(), but allocates with __GFP_NO_AUTOINIT.
> > > This helps reduce the slowdown on hackbench in the init_on_alloc mode
> > > from 6.84% to 3.45%.
> >
> > Out of curiosity, why the creation of the new function over adding a
> > gfp flag argument to sock_alloc_send_pskb() and updating callers? (Ther=
e
> > are only 6 callers, and this change already updates 2 of those.)
> >
> > > Slowdown for the initialization features compared to init_on_free=3D0=
,
> > > init_on_alloc=3D0:
> > >
> > > hackbench, init_on_free=3D1:  +7.71% sys time (st.err 0.45%)
> > > hackbench, init_on_alloc=3D1: +3.45% sys time (st.err 0.86%)
>
> So I've run some of my own wall-clock timings of kernel builds (which
> should be an pretty big "worst case" situation, and I see much smaller
> performance changes:
How many cores were you using? I suspect the numbers may vary a bit
depending on that.
> everything off
>         Run times: 289.18 288.61 289.66 287.71 287.67
>         Min: 287.67 Max: 289.66 Mean: 288.57 Std Dev: 0.79
>                 baseline
>
> init_on_alloc=3D1
>         Run times: 289.72 286.95 287.87 287.34 287.35
>         Min: 286.95 Max: 289.72 Mean: 287.85 Std Dev: 0.98
>                 0.25% faster (within the std dev noise)
>
> init_on_free=3D1
>         Run times: 303.26 301.44 301.19 301.55 301.39
>         Min: 301.19 Max: 303.26 Mean: 301.77 Std Dev: 0.75
>                 4.57% slower
>
> init_on_free=3D1 with the PAX_MEMORY_SANITIZE slabs excluded:
>         Run times: 299.19 299.85 298.95 298.23 298.64
>         Min: 298.23 Max: 299.85 Mean: 298.97 Std Dev: 0.55
>                 3.60% slower
>
> So the tuning certainly improved things by 1%. My perf numbers don't
> show the 24% hit you were seeing at all, though.
Note that 24% is the _sys_ time slowdown. The wall time slowdown seen
in this case was 8.34%

> > In the commit log it might be worth mentioning that this is only
> > changing the init_on_alloc case (in case it's not already obvious to
> > folks). Perhaps there needs to be a split of __GFP_NO_AUTOINIT into
> > __GFP_NO_AUTO_ALLOC_INIT and __GFP_NO_AUTO_FREE_INIT? Right now
> > __GFP_NO_AUTOINIT is only checked for init_on_alloc:
>
> I was obviously crazy here. :) GFP isn't present for free(), but a SLAB
> flag works (as was done in PAX_MEMORY_SANITIZE). I'll send the patch I
> used for the above timing test.
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

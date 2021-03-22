Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE10C433C1
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 11:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9440261974
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Mar 2021 11:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCVLqN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCVLp7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Mar 2021 07:45:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA051C061574
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 04:45:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o126so11259487lfa.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Mar 2021 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRuJKDLONwqvRSEZw7q4XL+dQi5no/glykgD4QfcHoc=;
        b=P9wPcvkHTDs1x5aCD8ZWEAWDiHPlrSVjFG0tZV2TfulePyEkQ6FYDKFVNHR6Ba67JP
         +H1qdwoME5OWNcW8CR860GNbI4yTWPM4F38y+Qspah6LrVzJbg2URQH7AQkh/n8Nrd+u
         75kTundK0bGBQWyzxgfo4/sPM5u8o9bnRP3Mg8pVx7w/PkkwGy9B7uwE75ypeSpiqDc4
         vZNiuAxUb38EJR50GOUr5lEySgXSaMMvVRltUk4fJzdmzrMb/RG9VRDkCx7PlzPRBlHf
         w7Tg0Jv89mm5EnWdjrnl2kNdb2GCGWSV3pR3ULzG+Tk3zRwXI63yTjFI7bOfs5DUTIrR
         azeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRuJKDLONwqvRSEZw7q4XL+dQi5no/glykgD4QfcHoc=;
        b=RyoFqQT3U5x69UZ0/xv4EwNPefa0J91gemOkohBIfg/QABCtyEFBNwGghZCesgXaVp
         c9Q5E+XE+H9q024n0Iq9BUyWtzQ9ZfoOAdYzzCo9AOi9wF4OCY+5/5UBBsfLDDuFKxNa
         GgAjh44KzjcYyBD72dg8yhApHNHWZBxMA30lRB0eyyghQdf3Cj/xKtfO+KjV9EnF9i4y
         C+vPVrl9xJvo20a24jL8v24xGQsIA+vlKsp6RlOGx+A0ErJJm7jkWOJfcXICCtKByM+p
         O5LQfzIip1s0v30wC0hRTSQniEa0gfhTZL6YY1OhRRxxuJmP+odwpbnv2afB+/IfMu/V
         JPxw==
X-Gm-Message-State: AOAM530Dtn0ajZxWQQfpsku3UaTMVxbz9np2xUsViqKISzrmTdaRgufI
        gB3dL3GwWWje/hgDHC+WaDAVjS0R6rkGL4eueUUhow==
X-Google-Smtp-Source: ABdhPJys1oU0GEM6faShhioXUDfwSD5LX0IoMQgOqke2KKHhM6OxUhkzXyD0wPqFp09wOreA6rq0SxHKh/GVYbssc/g=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr8543421lfa.291.1616413557065;
 Mon, 22 Mar 2021 04:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
 <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
 <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com>
 <CACRpkdYrqy78EfB_+UY0QtA0v0tD+_+O09Pod8-1Vd-p-VyMWA@mail.gmail.com> <CA+SOCLLo2MdxCH3gFONHsKdvmGGm2vZuML9QdQfWuX2--qFEOA@mail.gmail.com>
In-Reply-To: <CA+SOCLLo2MdxCH3gFONHsKdvmGGm2vZuML9QdQfWuX2--qFEOA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 12:45:45 +0100
Message-ID: <CACRpkdbF43_CjSFNu_4FUCEqOB8CebrpXJpkzeW8TnPpRELBtg@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: Implement SLS mitigation
To:     Jian Cai <jiancai@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 10, 2021 at 5:43 AM Jian Cai <jiancai@google.com> wrote:
> On Sat, Mar 6, 2021 at 4:25 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Mar 5, 2021 at 12:23 AM Jian Cai <jiancai@google.com> wrote:
> > > On Wed, Mar 3, 2021 at 7:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > > I think gcc also has these options.
> > > https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html
> >
> > And how does that work with this part of your patch:
> >
> > +#define SLS_TEXT                                       \
> > +       ALIGN_FUNCTION();                              \
> > +       *(.text.__llvm_slsblr_thunk_*)
> >
> > This does not look compiler agnostic?
>
> You are right, GCC does generate different oraphan section names. I
> will address it in the next version of the patch. Also it seems only
> arm64 gcc supports -mharden-sls=* at this moment, arm32 gcc does not
> support it yet. I don't know if there is any plan to implement it for
> 32-bit gcc, but should we patch arm32 linker script preemptively,
> assuming the sections will be named with the same pattern like how
> clang does so the kernel would not fail to boot when the flag is
> implemented?

I think the best thing is to have something like this:
Implement a macro such as this in
include/linux/compiler-clang.h

#define SLS_TEXT_SECTION *(.text.__llvm_slsblr_thunk_*)

then the corresponding in include/linux/compiler-gcc.h
but here also add a

#define SLS_TEXT_SECTION #error "no compiler support"

if the compiler version does not have this.

I don't know the exact best approach sadly, as the patch
looks now it seems a bit fragile, I wonder if you get linker
warnings when this section is unused?

Yours,
Linus Walleij

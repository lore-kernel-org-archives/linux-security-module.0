Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF8C433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7660619D8
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Mar 2021 22:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhCWWkb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhCWWkD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Mar 2021 18:40:03 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7AC061763
        for <linux-security-module@vger.kernel.org>; Tue, 23 Mar 2021 15:40:02 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id c16so9908102oib.3
        for <linux-security-module@vger.kernel.org>; Tue, 23 Mar 2021 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K8tLkChb+506zF+z/6B3jJAVVp0oMTr1r3/3aTgbn4=;
        b=Pe81cQ60l5HI2BEwB08JrmJgjyYI5GsI3IG5+NoNvN7VxFUlwWmEy8vXEIyGwtmzwW
         PMhpc0Uoys2+0YlJncs+JwzktMZ4f7sMDoja0mnZeF9Av0u9MAKIbVp6r2SqjdHhCwl4
         91CyfWajYrMgrHW+aut9mDhFzzUElhDwht9/MjUcojOa+L+0nxzHZiE2W5ucqb5Cm/G+
         0kn9cLuHDDhFx2cfgZs538uCneOninzEY03vpioj/99K2O9tZk5aEH1w8TsBOYitABPk
         NEKvMo6kq01IAKkKBlZAOaNYMcnXQJyDKKPo5l1L5qhGIO8xwAtsCn3VcYlm69I5+d+w
         DZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K8tLkChb+506zF+z/6B3jJAVVp0oMTr1r3/3aTgbn4=;
        b=KpO9Iy0smqyHAds9U98zWG7WkXrmq9stf9r88fNgkMtIvGcyuSSjoKvpRAW/0eET2e
         /aEXk+HxQv940TzOwcrmHY0RZYYM/2drKSLDczwvi9SOWGLHcrTZYKtzMK9+a+4iABOM
         htuxi0Z8yiMan6fMU3NyHywA1bjCh1/JolVKo0+uF5fnofbgAQAAd9k9QZ569sZq1s9i
         P3Xvjf4Jd/17xA8fW7WF7e1npfCup3qiXnD6YSeFItX7ov4TmAgkvkb4+El7HcdRaUMS
         q1gs+4dXHuUDk7KI9aArKj1G1Um1wllD1/8MM0CtiAhceDHRDwT3l5vlHFV9bsoFjaVP
         Y+EA==
X-Gm-Message-State: AOAM532MRlzZ1VhZ/p4eJxCqOq+80xQbc7TCQmTsbK7a+MXLskm1nAXM
        gTaznNEvCmz4cfHn4T7SScn8KnreAAoz6f16a1EBZw==
X-Google-Smtp-Source: ABdhPJzKT7oZFNSdPkzKR6RwxWfh1Wycs7N3YoemOpk0yIsAn2ibj4rUZ4fk7mjWToK526aRsi+/tUqJdhVxceAbusw=
X-Received: by 2002:aca:c683:: with SMTP id w125mr263549oif.43.1616539201756;
 Tue, 23 Mar 2021 15:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
 <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
 <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com>
 <CACRpkdYrqy78EfB_+UY0QtA0v0tD+_+O09Pod8-1Vd-p-VyMWA@mail.gmail.com>
 <CA+SOCLLo2MdxCH3gFONHsKdvmGGm2vZuML9QdQfWuX2--qFEOA@mail.gmail.com> <CACRpkdbF43_CjSFNu_4FUCEqOB8CebrpXJpkzeW8TnPpRELBtg@mail.gmail.com>
In-Reply-To: <CACRpkdbF43_CjSFNu_4FUCEqOB8CebrpXJpkzeW8TnPpRELBtg@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Tue, 23 Mar 2021 15:39:50 -0700
Message-ID: <CA+SOCLJTSHs9CZc+h0bWz=k5UUp5zLSLFwLyVGdr1v7O3VUOew@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: Implement SLS mitigation
To:     Linus Walleij <linus.walleij@linaro.org>
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

Thanks for the suggestion. I've sent an inquiry to the author of
-mharden-sls* in GCC and hopefully that would shed some more light. We
do get warnings for oraphon sections when using lld. The other linkers
do not seem to provide such warnings, although the boot failure also
does not seem to happen with them.

On Mon, Mar 22, 2021 at 4:45 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Mar 10, 2021 at 5:43 AM Jian Cai <jiancai@google.com> wrote:
> > On Sat, Mar 6, 2021 at 4:25 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Fri, Mar 5, 2021 at 12:23 AM Jian Cai <jiancai@google.com> wrote:
> > > > On Wed, Mar 3, 2021 at 7:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > > I think gcc also has these options.
> > > > https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html
> > >
> > > And how does that work with this part of your patch:
> > >
> > > +#define SLS_TEXT                                       \
> > > +       ALIGN_FUNCTION();                              \
> > > +       *(.text.__llvm_slsblr_thunk_*)
> > >
> > > This does not look compiler agnostic?
> >
> > You are right, GCC does generate different oraphan section names. I
> > will address it in the next version of the patch. Also it seems only
> > arm64 gcc supports -mharden-sls=* at this moment, arm32 gcc does not
> > support it yet. I don't know if there is any plan to implement it for
> > 32-bit gcc, but should we patch arm32 linker script preemptively,
> > assuming the sections will be named with the same pattern like how
> > clang does so the kernel would not fail to boot when the flag is
> > implemented?
>
> I think the best thing is to have something like this:
> Implement a macro such as this in
> include/linux/compiler-clang.h
>
> #define SLS_TEXT_SECTION *(.text.__llvm_slsblr_thunk_*)
>
> then the corresponding in include/linux/compiler-gcc.h
> but here also add a
>
> #define SLS_TEXT_SECTION #error "no compiler support"
>
> if the compiler version does not have this.
>
> I don't know the exact best approach sadly, as the patch
> looks now it seems a bit fragile, I wonder if you get linker
> warnings when this section is unused?
>
> Yours,
> Linus Walleij

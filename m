Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBFC433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 04:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F55E64FE8
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Mar 2021 04:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhCJEoE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 23:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhCJEnk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 23:43:40 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BFEC06174A
        for <linux-security-module@vger.kernel.org>; Tue,  9 Mar 2021 20:43:40 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id t16so15171672ott.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Mar 2021 20:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sVW/yEh768vDJxep1QYojM5RquL8YGeRAgcKVSj11Q=;
        b=tQoIjHIjxlyxEXvV1M3f7zlUJ0EJ6iuPzwotpyuWgFl3QSRHEI/bk0ZGiM7zP0WHTe
         IxNVgTaEfb12GuNXnQ/GGGAZzzRnWFennElHJ1uxROn337JWx0RvEYIQzDBMIaSoEMsP
         Dqjs+FvtrSNT72rmcwHLgyxfa+CLqBvGXwGRw6J3p7SGgEyzO9lkA/K6No3i9Zuc46fa
         MQRy2hcY16n4Yowp/8mbuiPCZ76oh4O+vh8FkWitoQqcm82eRlLCAkwqjWVtwupZnv+m
         Li15kvDeZ3AE3HrfIpV2Ijlg67tEdxHj4EinK2P9c7l22vScMGm3tYlRwg4gYVhvYeIJ
         ujBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sVW/yEh768vDJxep1QYojM5RquL8YGeRAgcKVSj11Q=;
        b=q2/BNI5udEvrDoV3A3rULvOS5k5jugpyKNPGDVE2FBii+8gcSIw0SeyZohiOlpPc1O
         GAJAGkgn4iIXUjRww9L8rLVjBwGzs6JaeLF411+rOyLwidZ/hqa0mzJolcsQTuPGCwJ0
         noTmeyD3Rv5HXEaEZ9AoK54kGooGtKmAAsXIJrtA7syd4GE/kyxnltjvyflYD4v5BL6/
         IYXLsBUQzwonFYlPFL1ecOC+WXUkFDK8lv6dmt8t7TYQzgQ60KDP4iIrCJLip0lY1Do4
         TbM1nxO0xzH3lINqrPLugrBmE/h0RUl+jGefjcAeswKh5Y2Xz3iVcevAXpEy4EdDNtwj
         CWnQ==
X-Gm-Message-State: AOAM533NmHZ4sPWqQQCwTdRWg+J5Wvj1mdQ8TwzvQEkT+P2mawGw5w9c
        HsOMFAcfd/xdZNZtE2EfXeorCVoo3XSS64t3yBcPww==
X-Google-Smtp-Source: ABdhPJyOGjWtX6nB6q1KbIXqVa//GzzWHXB0cMKYBQljKwpdoINAclycVgplnf2W/5qj7af9/axzpZKFK9esTSwpeJc=
X-Received: by 2002:a9d:66c9:: with SMTP id t9mr1219555otm.111.1615351419664;
 Tue, 09 Mar 2021 20:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
 <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
 <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com> <CACRpkdYrqy78EfB_+UY0QtA0v0tD+_+O09Pod8-1Vd-p-VyMWA@mail.gmail.com>
In-Reply-To: <CACRpkdYrqy78EfB_+UY0QtA0v0tD+_+O09Pod8-1Vd-p-VyMWA@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Tue, 9 Mar 2021 20:43:28 -0800
Message-ID: <CA+SOCLLo2MdxCH3gFONHsKdvmGGm2vZuML9QdQfWuX2--qFEOA@mail.gmail.com>
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

On Sat, Mar 6, 2021 at 4:25 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Mar 5, 2021 at 12:23 AM Jian Cai <jiancai@google.com> wrote:
> > On Wed, Mar 3, 2021 at 7:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Tue, Feb 23, 2021 at 3:36 AM Jian Cai <jiancai@google.com> wrote:
> > >
> > > > This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> > > > -mharden-sls=all, which mitigates the straight-line speculation
> > > > vulnerability, speculative execution of the instruction following some
> > > > unconditional jumps. Notice -mharden-sls= has other options as below,
> > > > and this config turns on the strongest option.
> > > >
> > > > all: enable all mitigations against Straight Line Speculation that are implemented.
> > > > none: disable all mitigations against Straight Line Speculation.
> > > > retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> > > > blr: enable the mitigation against Straight Line Speculation for BLR instructions.
> > >
> > > I heard about compiler protection for this, so nice to see it happening!
> > >
> > > Would you happen to know if there is any plan to do the same for GCC?
> > > I know you folks at Google like LLVM, but if you know let us know.
> >
> > I think gcc also has these options.
> > https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html
>
> And how does that work with this part of your patch:
>
> +#define SLS_TEXT                                       \
> +       ALIGN_FUNCTION();                              \
> +       *(.text.__llvm_slsblr_thunk_*)
>
> This does not look compiler agnostic?
>

You are right, GCC does generate different oraphan section names. I
will address it in the next version of the patch. Also it seems only
arm64 gcc supports -mharden-sls=* at this moment, arm32 gcc does not
support it yet. I don't know if there is any plan to implement it for
32-bit gcc, but should we patch arm32 linker script preemptively,
assuming the sections will be named with the same pattern like how
clang does so the kernel would not fail to boot when the flag is
implemented?

Thanks,
Jian

> Yours,
> Linus Walleij

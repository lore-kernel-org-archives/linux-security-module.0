Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4228C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42BB6115C
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 18:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhINSzK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhINSzJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 14:55:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA733C061574
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 11:53:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y6so566624lje.2
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaHzCeqz3d/GqpsnFBtK63j5q/ArTL6SIw+4YS9rlLw=;
        b=J/saYQynIM2X/4guXTj6phyk0pk9kPNeyMN1MMrYWugRxKF5v46ckYr01b8y2ZH48C
         0cAm0LfXAw+b09/e44x7gSrBb129qhRALOFIEBrajU/Uurfb+8IS5aCYGVPJW4CVHEXf
         ng9hed14b/lorCRVBegOw/78skcLggZCds+mIIXoXEveY550QpOrE9P1p1aq/yP8PYYH
         jKlbSMVrXSyQ1wp9TGBckUJ84ipH1jOLCHitARG6VvyQ+GgpGjoJyMWJVyIb9XSeihYA
         lPisIrdoBxBzftvoXwYFWXCs8DTNuF1v+SDxtSOAOhEF+D1/EHRslzlXiEECap8/CGP4
         4eMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaHzCeqz3d/GqpsnFBtK63j5q/ArTL6SIw+4YS9rlLw=;
        b=arWZoJefUUevzm5OPFauukjCJcRFAQEDXokDx58ybTDCzplmW2LeTPzRQ08H8Ca6dr
         qByAquhYzUYg5NkSC3SrW/LV+BWNsd6mcMQcIFxhQy1XRwtpHscoAbUzd1p6SbjnEitq
         f+pbIqvM3audx2KSh4Nk+tMBbHoaNMPNu+36nwzb87pnTxUJk7bivj8tJOhMjgQDcqe5
         LLGGI/ot9ebcm9ps2bZFVLDq8+EOUJ6Dq+w4y/OQEV6UMXljDVo8ZZIEFb2ED819SAks
         HtHXBdYA7d0/LtLbGUoo3wpRO3op+R7qkPZzz9rHPG2tL9jUeVpv3cfAsU5H1hQw9Naf
         kzXg==
X-Gm-Message-State: AOAM533DgjLwIcUHGOlIWq6ZBoTIJ1raUKvKlQYzPd5H7Fm/Z0pTzzGZ
        qWADX4NGPbaAsuUu0E1tmGkC5QqcUhgTYEgFJXhECQ==
X-Google-Smtp-Source: ABdhPJw4SOIbyKdU67cGXN1zRoc1VI82s1eU3PHcTvVoWtadIp+L1NjH67hA1cRFTVjCenSJMiK6DaYpIcPyoTPDxMo=
X-Received: by 2002:a2e:b551:: with SMTP id a17mr16552074ljn.128.1631645630128;
 Tue, 14 Sep 2021 11:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210914102837.6172-1-will@kernel.org> <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook>
In-Reply-To: <202109140958.11DCC6B6@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 11:53:38 -0700
Message-ID: <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

`On Tue, Sep 14, 2021 at 10:21 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 14, 2021 at 08:58:12AM -0700, Nathan Chancellor wrote:
> > On 9/14/2021 3:28 AM, Will Deacon wrote:
> > > CC_HAS_AUTO_VAR_INIT_ZERO requires a supported set of compiler options
> > > distinct from those needed by CC_HAS_AUTO_VAR_INIT_PATTERN, Fix up
> > > the Kconfig dependency for INIT_STACK_ALL_ZERO to test for the former
> > > instead of the latter, as these are the options passed by the top-level
> > > Makefile.
> > >
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Fixes: dcb7c0b9461c ("hardening: Clarify Kconfig text for auto-var-init")
> > > Signed-off-by: Will Deacon <will@kernel.org>
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > One comment below.
> >
> > > ---
> > >
> > > I just noticed this while reading the code and I suspect it doesn't really
> > > matter in practice.
> > >
> > >   security/Kconfig.hardening | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > > index 90cbaff86e13..341e2fdcba94 100644
> > > --- a/security/Kconfig.hardening
> > > +++ b/security/Kconfig.hardening
> > > @@ -29,7 +29,7 @@ choice
> > >     prompt "Initialize kernel stack variables at function entry"
> > >     default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> > >     default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> > > -   default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> > > +   default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
> > >     default INIT_STACK_NONE
> > >     help
> > >       This option enables initialization of stack variables at
> > >
> >
> > While I think this change is correct in and of itself,
> > CONFIG_INIT_STACK_ALL_ZERO is broken with GCC 12.x, as
> > CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO won't be set even though GCC now supports
> > -ftrivial-auto-var-init=zero because GCC does not implement the
> > -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> > flag for obvious reasons ;) the cc-option call probably needs to be
> > adjusted.
>
> GCC silently ignores the -enable flag, so things actually work correctly
> as-is.

So then would that mean that CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
evaluates to true then, in your patch below?

Rather than create 2 new kconfigs with 1 new invocation of the
compiler via cc-option, how about just adding an `ifdef
CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
`KBUILD_CFLAGS` in the top level Makefile?

> But, yes, it makes the command line long and doesn't make sense.
> How about we do this instead:
>
> diff --git a/Makefile b/Makefile
> index 34a0afc3a8eb..34439deac939 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -831,12 +831,11 @@ endif
>
>  # Initialize all stack variables with a zero value.
>  ifdef CONFIG_INIT_STACK_ALL_ZERO
> -# Future support for zero initialization is still being debated, see
> -# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> -# renamed or dropped.
>  KBUILD_CFLAGS  += -ftrivial-auto-var-init=zero
> +ifdef CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
>  KBUILD_CFLAGS  += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
>  endif
> +endif
>
>  # While VLAs have been removed, GCC produces unreachable stack probes
>  # for the randomize_kstack_offset feature. Disable it for all compilers.
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 90cbaff86e13..beea81df3081 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -22,14 +22,22 @@ menu "Memory initialization"
>  config CC_HAS_AUTO_VAR_INIT_PATTERN
>         def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
>
> +config CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE
> +       def_bool $(cc-option,-ftrivial-auto-var-init=zero)
> +
> +config CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
> +       # https://bugs.llvm.org/show_bug.cgi?id=45497
> +       def_bool !CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE && \
> +                $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
> +
>  config CC_HAS_AUTO_VAR_INIT_ZERO
> -       def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
> +       def_bool CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE || CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
>
>  choice
>         prompt "Initialize kernel stack variables at function entry"
>         default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
>         default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> -       default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> +       default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
>         default INIT_STACK_NONE
>         help
>           This option enables initialization of stack variables at
>
>
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers

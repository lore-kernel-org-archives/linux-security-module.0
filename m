Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40DAC433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EBB610CE
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 19:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhINTX6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhINTX5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 15:23:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D316C061574
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 12:22:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g14so677100ljk.5
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgqPc9G3kEzrx4a9xU6WJRNLMMqujZAV7WWA24EODcg=;
        b=B7a2T/vWkandCsB27/jpPgZImnu46XBPtNlUpD22KxdbM1FhOhF2vGT8afNq9gpWHP
         sJqxZ0BJNT5KcVCN04TGHBAIsa+zsxMVuSEbUMXiA+1WdMk1cjTcoTobbohQ7RgeZbrO
         qY+SR583jpL9bTsYAfVzwqcrCgh9HG79xO7zdBNmaGL7nXHan6i4zEtmqtLcOClJxH9d
         VbVzZj6tQBwXRjJkcB4j48au/AVdL0rRFGLYEu55uSc1sN1fvT+6QEsKRe31OWaRwzo2
         kP1zz5FCzcfmVGOMkk2kTTnT3L8mgJxYU4HSMozh5gkA4UABdF5OJIYR0xGk+gnsB1ci
         Fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgqPc9G3kEzrx4a9xU6WJRNLMMqujZAV7WWA24EODcg=;
        b=l6PI9CI4bLT4hyFXNVQeu6WdjNQ2+S0ERr+Tiey0JjC1QXOMBcrBcnIx0YGD+04Cyd
         hEbqKohOJnD35KSU3lN3ou6F5Nfq6atoZM7dZQoA/An66goxz1mv5u4vVYbqa+v59Xuu
         GZR/eq7elNuMyp0sU3c8Sh4cvWGT/pbuwJCCujtmYJD80Jv1ApmYgmEyffncGLx968Aq
         dIbu7q2awFrP7ToYt8x9NWaI/p7lk33XYFPIVnjCv3SkaOB925hvzyZp9KJGNbjqX1Zx
         AzrRTubTONUyX10GeW96xUET7I9jxPxtF7jFBrmYuKOc1oovMciY3SszvInWpAn7GQ3J
         B2jQ==
X-Gm-Message-State: AOAM530ZWWtaLx1tf1cOViDxFFFVc3YNnX3I43DXfa/+r7IN7Ry1AoY0
        lncIVvWIVz06laMGf6A5rsH2p/UXAiWCXbL1bW7DuzD+6fA=
X-Google-Smtp-Source: ABdhPJwa7yL3vXUNDq0XxlCpymQppX1uWzQS6zEjAC1wqfD6PUQ6AH9Jk8yNqHqbph8WiBjGBnSH7AOvrA/KuPEzBR8=
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr17337321ljp.526.1631647355826;
 Tue, 14 Sep 2021 12:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210914102837.6172-1-will@kernel.org> <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook> <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
 <202109141214.630BB3A@keescook>
In-Reply-To: <202109141214.630BB3A@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 12:22:24 -0700
Message-ID: <CAKwvOdmP6mYwZ+0Z5iXFv5dtd_96SxYsUn469ZC=C=SFw-Hs-A@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 12:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 14, 2021 at 11:53:38AM -0700, Nick Desaulniers wrote:
> > Rather than create 2 new kconfigs with 1 new invocation of the
> > compiler via cc-option, how about just adding an `ifdef
> > CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
> > `KBUILD_CFLAGS` in the top level Makefile?
>
> v2:

LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I think the formal patch should have Will's Suggested-by on it.

>
> diff --git a/Makefile b/Makefile
> index 34a0afc3a8eb..72d165ffabdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -831,12 +831,12 @@ endif
>
>  # Initialize all stack variables with a zero value.
>  ifdef CONFIG_INIT_STACK_ALL_ZERO
> -# Future support for zero initialization is still being debated, see
> -# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> -# renamed or dropped.
>  KBUILD_CFLAGS  += -ftrivial-auto-var-init=zero
> +ifdef CONFIG_CC_IS_CLANG
> +# https://bugs.llvm.org/show_bug.cgi?id=45497
>  KBUILD_CFLAGS  += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
>  endif
> +endif
>
>  # While VLAs have been removed, GCC produces unreachable stack probes
>  # for the randomize_kstack_offset feature. Disable it for all compilers.
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 90cbaff86e13..ded17b8abce2 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -23,13 +23,16 @@ config CC_HAS_AUTO_VAR_INIT_PATTERN
>         def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
>
>  config CC_HAS_AUTO_VAR_INIT_ZERO
> +       # GCC ignores the -enable flag, so we can test for the feature with
> +       # a single invocation using the flag, but drop it as appropriate in
> +       # the Makefile, depending on the presence of Clang.
>         def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
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
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers

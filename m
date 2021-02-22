Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F4C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 21:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D45B64E02
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 21:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhBVVvA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBVVu6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 16:50:58 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B176AC06174A
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 13:50:18 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id l16so4563546oti.12
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XvA1Gvev4npN0zTNKBUEQYu6pllkjUp8fGvFiKGsaw=;
        b=oPaglzkjKqzjUBBPUjqw1unuPnLeRIg+r2e+b5ukaQtb/CbFhejThtt83WKjf+uRWe
         KFn/OkCiXG7jSjp1nQqXY7tjbvTf6QKmcEGby7qkIb8lTX8W2xZOw+NEjkaHyfb0y83y
         ZL+/Nco8WNGPOhZcKSnj8kGXbTy3hmoHvPFDTRmyYdxWIcPQ54CtQgUtuwa8DFf9vEGZ
         pUm8rMXHgVXxuoQucIETk3LjqO7v1JwBhPM7k+lXRB6icRyOfS9oD86WvjI17VK+uYfp
         ZyD1JnASki0fT4pyG0rrTfuzd7T0o/Nhsr55gPy5LF7wJRo15112lYcAy/Ycx2KGYYJc
         WSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XvA1Gvev4npN0zTNKBUEQYu6pllkjUp8fGvFiKGsaw=;
        b=DX8/GKw4J/mUn54zCUVZAXpI2+rzAT0Pcawfh/ceVtc3PC3UsNwAu0li0A7j2juwbg
         fijVEESn/WEQsrryasJTJdqPo71OiXF1OBGgQExxf7IRVKNTrOB6V+8FKwWYtyBA/J1E
         nuRnxX9bRniAAGJLT7F4fPMS1vh29/kObzGMKCOeiphOzlqIIxFQm5sm9d1KnYEmJTCh
         4QUdgY8k8cdlP92wx6RvpCY2i9I3+t1fqDdFupum9BllkiVjOGKoPpEGI2uwP/JBVOmS
         859u533u8DC5CqhYEcUgrVBa76scVgIiRDBTezRZP8rZWszj+yvkHicun17ATg/ZGPRz
         n4jA==
X-Gm-Message-State: AOAM533iyNZDAry6XOqLmivleCdN6JdXVKf320kEYYV6h5cRN6CeRSRM
        CfxXTJqcHJkW85rFgdedIjWbvgzVpYwQU1hABtywEw==
X-Google-Smtp-Source: ABdhPJxMYKRODjg5XZiabTyJz9ooiRtNu/86y64qGHku2dN8574FUKIwnz31nIc7J8RgCH9i500XWk553hkczvcZYCM=
X-Received: by 2002:a05:6830:1def:: with SMTP id b15mr18107040otj.111.1614030617845;
 Mon, 22 Feb 2021 13:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20210219201852.3213914-1-jiancai@google.com> <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck>
In-Reply-To: <20210222115816.GA8605@willie-the-truck>
From:   Jian Cai <jiancai@google.com>
Date:   Mon, 22 Feb 2021 13:50:06 -0800
Message-ID: <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please see my comments inlined below.

Thanks,
Jian

On Mon, Feb 22, 2021 at 3:58 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Feb 19, 2021 at 03:08:13PM -0800, Jian Cai wrote:
> > This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> > -mharden-sls=all, which mitigates the straight-line speculation
> > vulnerability, speculative execution of the instruction following some
> > unconditional jumps. Notice -mharden-sls= has other options as below,
> > and this config turns on the strongest option.
> >
> > all: enable all mitigations against Straight Line Speculation that are implemented.
> > none: disable all mitigations against Straight Line Speculation.
> > retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> > blr: enable the mitigation against Straight Line Speculation for BLR instructions.
> >
> > Links:
> > https://reviews.llvm.org/D93221
> > https://reviews.llvm.org/D81404
> > https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
> > https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2
> >
> > Suggested-by: Manoj Gupta <manojgupta@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Nathan Chancellor  <nathan@kernel.org>
> > Suggested-by: David Laight <David.Laight@aculab.com>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Jian Cai <jiancai@google.com>
> > ---
>
> Please can you reply to my previous questions?
>
> https://lore.kernel.org/linux-arm-kernel/20210217094859.GA3706@willie-the-truck/
>
> (apologies if you did, but I don't see them in the archive or my inbox)

I should have clarified the suggested-by tag was in regard to the
Kconfig text change. Regarding your earlier questions, please see my
comments below.

> So I think that either we enable this unconditionally, or we don't enable it
> at all (and people can hack their CFLAGS themselves if they want to).

Not sure if this answers your question but this config should provide
a way for people to turn on the mitigation at their own risk.

> It would be helpful for one of the Arm folks to chime in, as I'm yet to see any
> evidence that this is actually exploitable. Is it any worse that Spectre-v1,
> where we _don't_ have a compiler mitigation?

> Finally, do we have to worry about our assembly code?

I am not sure if there are any plans to protect assembly code and I
will leave it to the Arm folks since they know a whole lot better. But
even without that part, we should still have better protection,
especially when overhead does not look too bad: I did some preliminary
experiments on ChromeOS, code size of vmlinux increased 3%, and there
were no noticeable changes to run-time performance of the benchmarks I
used.

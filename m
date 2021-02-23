Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739DCC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 10:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C526148E
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 10:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBWKFo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Feb 2021 05:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBWKFm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Feb 2021 05:05:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 389EE64E22;
        Tue, 23 Feb 2021 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614074701;
        bh=Wei69MTAw3cAoHZzehtkt6nVDExu19SQg53rlhzIYkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZOqzYAfqkinjCDFARp7S1HJXXBR9/a5BpaM0vR+ODhDKzZDPfF/ye7XjKQMUez35
         gNYf4tHz2dZXzh6zzeOdB4V3qV1z9r5sgXIXTCI0aO5M02BEsGDwODUFLCu1Lt0bOf
         0DK9G68zNyFKRYC1hCUEsoWO6316kYRolzd+VXquDUZT8xx0YR4ZC9pYlEAwapnwSR
         iFZl+6xr5ZixbyOTXA4xJh9vWEFM0si3FfsI5NrErO2BOcvcjSnsbqxWi1qJke/gga
         uJI0eyUbRiuqihtgi0hZ2CyAWZ72G2AC/8FGKqtO9r7yqQCxJpGGZu4aJGwqnQT86v
         k3LlYOeONI6cg==
Date:   Tue, 23 Feb 2021 10:04:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Jian Cai <jiancai@google.com>
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
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
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
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
Message-ID: <20210223100453.GB10254@willie-the-truck>
References: <20210219201852.3213914-1-jiancai@google.com>
 <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck>
 <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 22, 2021 at 01:50:06PM -0800, Jian Cai wrote:
> Please see my comments inlined below.
> 
> Thanks,
> Jian
> 
> On Mon, Feb 22, 2021 at 3:58 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, Feb 19, 2021 at 03:08:13PM -0800, Jian Cai wrote:
> > > This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> > > -mharden-sls=all, which mitigates the straight-line speculation
> > > vulnerability, speculative execution of the instruction following some
> > > unconditional jumps. Notice -mharden-sls= has other options as below,
> > > and this config turns on the strongest option.
> > >
> > > all: enable all mitigations against Straight Line Speculation that are implemented.
> > > none: disable all mitigations against Straight Line Speculation.
> > > retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> > > blr: enable the mitigation against Straight Line Speculation for BLR instructions.
> > >
> > > Links:
> > > https://reviews.llvm.org/D93221
> > > https://reviews.llvm.org/D81404
> > > https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
> > > https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2
> > >
> > > Suggested-by: Manoj Gupta <manojgupta@google.com>
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Suggested-by: Nathan Chancellor  <nathan@kernel.org>
> > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > Suggested-by: Will Deacon <will@kernel.org>
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Jian Cai <jiancai@google.com>
> > > ---
> >
> > Please can you reply to my previous questions?
> >
> > https://lore.kernel.org/linux-arm-kernel/20210217094859.GA3706@willie-the-truck/
> >
> > (apologies if you did, but I don't see them in the archive or my inbox)
> 
> I should have clarified the suggested-by tag was in regard to the
> Kconfig text change. Regarding your earlier questions, please see my
> comments below.
> 
> > So I think that either we enable this unconditionally, or we don't enable it
> > at all (and people can hack their CFLAGS themselves if they want to).
> 
> Not sure if this answers your question but this config should provide
> a way for people to turn on the mitigation at their own risk.

I'm not sure I see the point; either it's needed or its not. I wonder if
there's a plan to fix this in future CPUs (another question for the Arm
folks).

> > It would be helpful for one of the Arm folks to chime in, as I'm yet to see any
> > evidence that this is actually exploitable. Is it any worse that Spectre-v1,
> > where we _don't_ have a compiler mitigation?
> 
> > Finally, do we have to worry about our assembly code?
> 
> I am not sure if there are any plans to protect assembly code and I
> will leave it to the Arm folks since they know a whole lot better. But
> even without that part, we should still have better protection,
> especially when overhead does not look too bad: I did some preliminary
> experiments on ChromeOS, code size of vmlinux increased 3%, and there
> were no noticeable changes to run-time performance of the benchmarks I
> used.

If the mitigation is required, I'm not sure I see a lot of point in only
doing a half-baked job of it. It feels a bit like a box-ticking exercise,
in which case any overhead is too much.

Will

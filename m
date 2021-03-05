Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C455BC433DB
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B2B64EE1
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 09:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEJxi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhCEJxG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Mar 2021 04:53:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F75A64FF0;
        Fri,  5 Mar 2021 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614937985;
        bh=HISQ8FVK1FEQR2uPQffgIVaQdAag9fQWCstT9nYNRR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROvsjQ369W4Mti4eFRR1Wc1FOLTKKFKDEmwei6CFzaQJ6Qz9XT2wuHNZm6UJ42/Wq
         mswZpqhpLsCDqTifukAomcs2qL1z4XIMdjcBZZM7Wjbm48ywRY6plez2k5ozqzGN6W
         D3VlwYCsFcbXFXY6lSs6p/h6jvgiebLp+/iyQEFkvAKLED4VKfA9g5+J8lNWwOiO1V
         X4eqtyYUhRI5GSk8s/r3nXkcn58FKOIvEYxyu1IxhWaEviTywIQHxMLqCRsNsNJUCc
         2hEA6hswMuFWi6efEqyoq0eVdEwptFb7eTf8f7HTG1XX63xQuAE4gu7x2Rv4uYt3QD
         17AhWxXZziwpg==
Date:   Fri, 5 Mar 2021 09:52:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Joey Gouly <joey.gouly@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6] ARM: Implement SLS mitigation
Message-ID: <20210305095256.GA22536@willie-the-truck>
References: <20210223023542.2287529-1-jiancai@google.com>
 <20210305005327.405365-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005327.405365-1-jiancai@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 04, 2021 at 04:53:18PM -0800, Jian Cai wrote:
> This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> -mharden-sls=all, which mitigates the straight-line speculation
> vulnerability, speculative execution of the instruction following some
> unconditional jumps. Notice -mharden-sls= has other options as below,
> and this config turns on the strongest option.
> 
> all: enable all mitigations against Straight Line Speculation that are implemented.
> none: disable all mitigations against Straight Line Speculation.
> retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> blr: enable the mitigation against Straight Line Speculation for BLR instructions.
> 
> Links:
> https://reviews.llvm.org/D93221
> https://reviews.llvm.org/D81404
> https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
> https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2
> 
> Suggested-by: Manoj Gupta <manojgupta@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: David Laight <David.Laight@aculab.com>
> Suggested-by: Will Deacon <will@kernel.org>

I'm still reasonably opposed to this patch, so please don't add my
"Suggested-by" here as, if I were to suggest anything, it would be not
to apply this patch :)

I still don't see why SLS is worth a compiler mitigation which will affect
all CPUs that run the kernel binary, but Spectre-v1 is not. In other words,
the big thing missing from this is a justification as to why SLS is a
problem worth working around for general C code.

Will

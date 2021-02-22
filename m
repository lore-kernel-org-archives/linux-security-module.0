Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96797C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 11:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F18164E24
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 11:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhBVL7K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 06:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhBVL7H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 06:59:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4914A64E15;
        Mon, 22 Feb 2021 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613995104;
        bh=cX6+zcAFvYLB9KQP4npgFv9p/Y9T3UFAefLKaAVJ7cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MEtBdS+pzZVBPR9ZfrHvwUbU8LRoQz7FCSZ16Ws+XJQEGovFiXQj0n6bcaFJadohy
         QzV37B4gnkaa1wRZY0DBHM2Y9vYSwdb9ITEyVkeDkTnC/xPn9uextV4FkzGIcKWJR+
         dJrUhg8x7sR8Okocjn0cLzGuy1nMW0YOTn2YiADr5DEtzNVlUiFi/dppws4uCUpbCr
         2oQ/u39Uwjm1LWPZEISNNeZ7XtAZWPhrUdMINVz5qmj3v/mokXgde1++ClEeRllpdX
         YOJCy+1h9hqYCONnAjuzHHCJTgqWY14/Zep5CfTvo/Tlo1tyLMY22L1dG1zxP5RRR9
         43oHdPbH9KTyQ==
Date:   Mon, 22 Feb 2021 11:58:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
Message-ID: <20210222115816.GA8605@willie-the-truck>
References: <20210219201852.3213914-1-jiancai@google.com>
 <20210219230841.875875-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219230841.875875-1-jiancai@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 03:08:13PM -0800, Jian Cai wrote:
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
> Suggested-by: Nathan Chancellor  <nathan@kernel.org>
> Suggested-by: David Laight <David.Laight@aculab.com>
> Suggested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---

Please can you reply to my previous questions?

https://lore.kernel.org/linux-arm-kernel/20210217094859.GA3706@willie-the-truck/

(apologies if you did, but I don't see them in the archive or my inbox)

Will

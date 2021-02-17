Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C0C433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Feb 2021 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B1164D9A
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Feb 2021 09:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBQJts (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Feb 2021 04:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhBQJts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Feb 2021 04:49:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9EEF64D9A;
        Wed, 17 Feb 2021 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613555347;
        bh=Xt/pQSPwnxdeV+GK8xvNK5JorjBJhSGXtix1A7YYkHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmHOlOJSrtLNdApKnF1/VctQ8ghvtak+WGJq46qyDCg5JefXgafmbZC9mDPfSd3KB
         rhv+okJgtmULUfVaMG8fgTlLK430NC94GnMK5If9O72D1lwBcaBhNbmP+9EWoL8g8w
         h1QTXkhPytla+f17A6on0yqlagF1AB9V/CzBtPpasiojS0pliXVG/OaXDjWY7DMSIx
         GgBX8fhfwU8RloN2syZjG7CaBizB5Yqc/cJjGsEC0OWGe+gpus6TUKIv1Ej17XKokh
         Aq16i9tFXzN1gNGaLRjiES3MHp3c3SXgDWimMtsZBfDFRkpvXyltTZThaaecwuq+eJ
         U92mKBijH3UdA==
Date:   Wed, 17 Feb 2021 09:49:00 +0000
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] ARM: Implement Clang's SLS mitigation
Message-ID: <20210217094859.GA3706@willie-the-truck>
References: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com>
 <20210212195255.1321544-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212195255.1321544-1-jiancai@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 12, 2021 at 11:52:53AM -0800, Jian Cai wrote:
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

What exactly does this mitigation do? This should be documented somewhere,
maybe in the Kconfig text?

> Link: https://reviews.llvm.org/D93221
> Link: https://reviews.llvm.org/D81404
> Link: https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
> https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2
> 
> Suggested-by: Manoj Gupta <manojgupta@google.com>
> Suggested-by: Nathan Chancellor  <nathan@kernel.org>
> Suggested-by: David Laight <David.Laight@aculab.com>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
> 
> Changes v1 -> v2:
>  Update the description and patch based on Nathan and David's comments. 
> 
>  arch/arm/Makefile          | 4 ++++
>  arch/arm64/Makefile        | 4 ++++
>  security/Kconfig.hardening | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 4aaec9599e8a..11d89ef32da9 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -48,6 +48,10 @@ CHECKFLAGS	+= -D__ARMEL__
>  KBUILD_LDFLAGS	+= -EL
>  endif
>  
> +ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
> +KBUILD_CFLAGS  += -mharden-sls=all
> +endif
> +
>  #
>  # The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
>  # later may result in code being generated that handles signed short and signed
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 90309208bb28..ca7299b356a9 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -34,6 +34,10 @@ $(warning LSE atomics not supported by binutils)
>    endif
>  endif
>  
> +ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
> +KBUILD_CFLAGS  += -mharden-sls=all
> +endif

The big problem I have with this is that it's a compile-time decision.
For the other spectre crap we have a combination of the "mitigations=off"
command-line and CPU detection to avoid the cost of the mitigation where
it is not deemed necessary.

So I think that either we enable this unconditionally, or we don't enable it
at all (and people can hack their CFLAGS themselves if they want to). It
would be helpful for one of the Arm folks to chime in, as I'm yet to see any
evidence that this is actually exploitable. Is it any worse that Spectre-v1,
where we _don't_ have a compiler mitigation?

Finally, do we have to worry about our assembly code?

Will

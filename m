Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AFAC433DB
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 05:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A264DCE
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 05:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhBLFzz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Feb 2021 00:55:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhBLFzv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Feb 2021 00:55:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C28364E65;
        Fri, 12 Feb 2021 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613109309;
        bh=C7IjeXnEiMIsSoAKBw6Y+Dee0rBFq1JQmangfsZ1Gkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxIi9IdZEv/hiTrG8lUIHCvidGFzSpLw2eylflYAJ3Qup5CLDUtgTQE+8K94CIYEe
         Opc9gOZagxgWC44hDL7HkP2ahh1gX8HB9oMQr+9JbQPx1l1dDu2HLjN4zMT751BmeW
         8hHbrX6Pe5jonPdDsVeNVivxY2h2MUXLSAywfY1aRw0VouzfN5AtmdqwiVdPndRB5y
         //HjNFNBE/yKzHr+xRvKi0gxIzHGcBjQh0xo2gNm+PdAucL/a55DbIycNLke0lqae1
         bbrzdJnWlek9Tp3s0kf7Prxd8ltSQMkNu5+dc6n1k19ssiT1iPYyewvFLorqXh0w1s
         iFxoiE989QuZQ==
Date:   Thu, 11 Feb 2021 22:55:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>, ndesaulniers@google.com,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux@googlegroups.com,
        linux-security-module@vger.kernel.org, manojgupta@google.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        llozano@google.com, James Morris <jmorris@namei.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] ARM: Implement Clang's SLS mitigation
Message-ID: <20210212055508.GA3822196@ubuntu-m3-large-x86>
References: <20210212051500.943179-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212051500.943179-1-jiancai@google.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jian,

On Thu, Feb 11, 2021 at 09:14:58PM -0800, Jian Cai wrote:
> This patch adds a config CONFIG_HARDEN_SLS_ALL that can be used to turn

Drop "a config".

> on -mharden-sls=all, which mitigates the straight-line speculation
> vulnerability, or more commonly known as Spectre, Meldown.

                 ^ I would drop "or" here
                                                  ^ drop comma,
                                                    use "and",
                                                    typo: "Meltdown"

Although, is that a fair statement? SLS is not called Spectre or
Meltdown by ARM, it is a speculative processor vulnerabilty. It
might just be better to drop eerything after the first comma (although
maybe that is just being pedantic).

> 
> Notice -mharden-sls= has other options as below, and this config turns
> on the strongest option.
> 
> all: enable all mitigations against Straight Line Speculation that are implemented.
> none: disable all mitigations against Straight Line Speculation.
> retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> blr: enable the mitigation against Straight Line Speculation for BLR instructions.

I cannot comment on whether or not this is worth doing, I will leave
that up to Will, Catalin, et al. The following comments are more from a
"regular kernel developer" perspective, rather than an "arm64 kernel
developer" :)

> Link: https://reviews.llvm.org/D93221
> Link: https://reviews.llvm.org/D81404
> Link: https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation

This is also a useful article it seems:

https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2

> Link: https://crbug.com/1171521

This crbug is private. If it is going into a commit message, please
publicize it.

> Suggested-by: Manoj Gupta <manojgupta@google.com>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
>  arch/arm/Makefile          |  4 ++++
>  arch/arm64/Makefile        |  5 +++++
>  security/Kconfig.hardening | 11 +++++++++++
>  3 files changed, 20 insertions(+)
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
> index 90309208bb28..8fd0ccd87eca 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -34,6 +34,11 @@ $(warning LSE atomics not supported by binutils)
>    endif
>  endif
>  
> +ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
> +KBUILD_CFLAGS  += -mharden-sls=all
> +endif
> +
> +

Extra space here

>  cc_has_k_constraint := $(call try-run,echo				\
>  	'int main(void) {						\
>  		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 269967c4fc1b..d83c406c81a3 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -121,6 +121,17 @@ choice
>  
>  endchoice
>  
> +
> +config CC_HAS_HARDEN_SLS_ALL
> +	def_bool $(cc-option,-mharden-sls=all)

I do not think that CONFIG_CC_HAS_HARDEN_SLS_ALL serves much purpose.
Moving the cc-option into CONFIG_HARDEN_SLS_ALL is just as clean.

config HARDEN_SLS_ALL
	bool "enable SLS vulnerability hardening"
	depends on $(cc-option,-mharden-sls=all)
	help
	  Enables straight-line speculation vulnerability hardening
	  at highest level.

> +
> +	config HARDEN_SLS_ALL
> +               bool "enable SLS vulnerability hardening"

The spacing here seems messed up, I corrected it above.

> +               depends on CC_HAS_HARDEN_SLS_ALL
> +               help
> +                 Enables straight-line speculation vulnerability hardening
> +		 at highest level.
> +
>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>  	bool "Report forcefully initialized variables"
>  	depends on GCC_PLUGIN_STRUCTLEAK
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
> 

Cheers,
Nathan

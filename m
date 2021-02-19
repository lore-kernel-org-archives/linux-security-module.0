Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CABCC433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Feb 2021 20:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F1C64EC7
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Feb 2021 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBSUbh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBSUbh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Feb 2021 15:31:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FF7164EBF;
        Fri, 19 Feb 2021 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613766655;
        bh=t60MtijxFQRBj7x3qDETkxU78fn61+W8UwCXWCiwnQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xb+ScodtC5g1cJwFwirDpie276j9W21+W9T9eLgOfC1SHJHdUX8DF1ZTbCMDDl2b1
         CtXaFvrALlvelQT3VHb1fb1I86UFmxhQJyn5fh0c5IL6LWz6mIIwNz+tYoqzxdOJCy
         6d+orlD4NDIUUVKmW0I/71fEFGtMTUbKQZ5aFKuMbZsoy2xe+LETtfBDJfJx7Akyt6
         B4/WgocoAhw4iwSgoLn7iqvcsyLrqgMXRTbsL4BkCDMasEqQH5I1SXRzoM8xQ9zOkA
         tbpYniBMZUEMcoUiVFHqZS0Tz2GL7muRsPcEn1dxAxfQEk+fPjQ7WLqspYcsb7Nrs3
         Mdc9Pm/eMthbg==
Date:   Fri, 19 Feb 2021 13:30:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
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
        Olof Johansson <olof@lixom.net>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] ARM: Implement SLS mitigation
Message-ID: <20210219203053.GA53507@24bbad8f3778>
References: <20210212195255.1321544-1-jiancai@google.com>
 <20210219201852.3213914-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219201852.3213914-1-jiancai@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jian,

On Fri, Feb 19, 2021 at 12:18:40PM -0800, 'Jian Cai' via Clang Built Linux wrote:
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

My review still stands but in the future, if you significantly change
how a patch is structured or works, please drop my tag and let me re-add
it.

One comment below.

> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
> 
> Changes v2 -> v3:
>   Modify linker scripts as Nick suggested to address boot failure
>   (verified with qemu). Added more details in Kconfig.hardening
>   description. Disable the config by default.
> 
>  arch/arm/Makefile                  |  4 ++++
>  arch/arm/include/asm/vmlinux.lds.h |  4 ++++
>  arch/arm/kernel/vmlinux.lds.S      |  1 +
>  arch/arm64/Makefile                |  4 ++++
>  arch/arm64/kernel/vmlinux.lds.S    |  5 +++++
>  security/Kconfig.hardening         | 10 ++++++++++
>  6 files changed, 28 insertions(+)
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
> diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> index 4a91428c324d..c7f9717511ca 100644
> --- a/arch/arm/include/asm/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -145,3 +145,7 @@
>  		__edtcm_data = .;					\
>  	}								\
>  	. = __dtcm_start + SIZEOF(.data_dtcm);
> +
> +#define SLS_TEXT							\
> +		ALIGN_FUNCTION();					\
> +		*(.text.__llvm_slsblr_thunk_*)
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index f7f4620d59c3..e71f2bc97bae 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -63,6 +63,7 @@ SECTIONS
>  	.text : {			/* Real text segment		*/
>  		_stext = .;		/* Text and read-only data	*/
>  		ARM_TEXT
> +		SLS_TEXT
>  	}
>  
>  #ifdef CONFIG_DEBUG_ALIGN_RODATA
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
> +
>  cc_has_k_constraint := $(call try-run,echo				\
>  	'int main(void) {						\
>  		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 4c0b0c89ad59..f8912e42ffcd 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -93,6 +93,10 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT
>  #endif
>  
> +#define SLS_TEXT					\
> +	ALIGN_FUNCTION();				\
> +	*(.text.__llvm_slsblr_thunk_*)
> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from _stext to _edata, must be a round multiple of the PE/COFF
> @@ -144,6 +148,7 @@ SECTIONS
>  			HIBERNATE_TEXT
>  			TRAMP_TEXT
>  			*(.fixup)
> +			SLS_TEXT
>  			*(.gnu.warning)
>  		. = ALIGN(16);
>  		*(.got)			/* Global offset table		*/
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 269967c4fc1b..e70f227019e1 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -121,6 +121,16 @@ choice
>  
>  endchoice
>  
> +config HARDEN_SLS_ALL
> +	bool "enable SLS vulnerability hardening"
> +	default n
> +	def_bool $(cc-option,-mharden-sls=all)

This is a much more convoluted way of writing:

depends on $(cc-option,-mharden-sls=all)

"default n" is the default and "def_bool" is short for:

bool
default <expr>

which is defeated by the "default n".

> +	help
> +	  Enables straight-line speculation vulnerability hardening on ARM and ARM64
> +	  architectures. It inserts speculation barrier sequences (SB or DSB+ISB
> +	  depending on the target architecture) after RET and BR, and replacing
> +	  BLR with BL+BR sequence.
> +
>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>  	bool "Report forcefully initialized variables"
>  	depends on GCC_PLUGIN_STRUCTLEAK
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 

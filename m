Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CAFC636C9
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221766120E
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 22:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhGTVdw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhGTVdd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jul 2021 17:33:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89BEE61004;
        Tue, 20 Jul 2021 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626819236;
        bh=C9xEUpcszWLTz7G41tiUMq/T9ZUtgRdO9miCXuErFAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCwQ6QDKbh4e8g/K0osooLvKZkiaAMJ2oNiYhzQNUNfAuxqVUzeTrb1yf7TPmlLDg
         sY+7dmKGhZR/FjKYc6QUD16dVjp2ZB3pmUKBwEWwQhatxJnA7dK/zKEQBVzAxab2NP
         jG1u9nMG1LOWkqpXOLe4lHZGaQJ1OYDDxivsqJjAY9F+Li4SavlT1bBNvKWh2ZwBJV
         c2J1HgvuuslUa4p6PmZ+rd/A5IGhGHfXOZ/utSipTatuniGEWxdoHqEJKqxSnGIQSI
         wPpBJa7W51aT7+VUhHr+xWBL0Cv5/FZsfBwtLP/Q3ATmU2kjnR9ZPks65rxK9VdoiL
         lTmCfWPAQAFrA==
Date:   Tue, 20 Jul 2021 17:16:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, glider@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] hardening: Clarify Kconfig text for auto-var-init
Message-ID: <20210720221617.GA94423@embeddedor>
References: <20210720215957.3446719-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720215957.3446719-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 20, 2021 at 02:59:57PM -0700, Kees Cook wrote:
> Clarify the details around the automatic variable initialization modes
> available. Specifically this details the values used for pattern init
> and expands on the rationale for zero init safety. Additionally makes
> zero init the default when available.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  security/Kconfig.hardening | 52 +++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 023aea5e117c..90cbaff86e13 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -29,6 +29,7 @@ choice
>  	prompt "Initialize kernel stack variables at function entry"
>  	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
>  	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> +	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
>  	default INIT_STACK_NONE
>  	help
>  	  This option enables initialization of stack variables at
> @@ -39,11 +40,11 @@ choice
>  	  syscalls.
>  
>  	  This chooses the level of coverage over classes of potentially
> -	  uninitialized variables. The selected class will be
> +	  uninitialized variables. The selected class of variable will be
>  	  initialized before use in a function.
>  
>  	config INIT_STACK_NONE
> -		bool "no automatic initialization (weakest)"
> +		bool "no automatic stack variable initialization (weakest)"
>  		help
>  		  Disable automatic stack variable initialization.
>  		  This leaves the kernel vulnerable to the standard
> @@ -80,7 +81,7 @@ choice
>  		  and is disallowed.
>  
>  	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> -		bool "zero-init anything passed by reference (very strong)"
> +		bool "zero-init everything passed by reference (very strong)"
>  		depends on GCC_PLUGINS
>  		depends on !(KASAN && KASAN_STACK)
>  		select GCC_PLUGIN_STRUCTLEAK
> @@ -91,33 +92,44 @@ choice
>  		  of uninitialized stack variable exploits and information
>  		  exposures.
>  
> +		  As a side-effect, this keeps a lot of variables on the
> +		  stack that can otherwise be optimized out, so combining
> +		  this with CONFIG_KASAN_STACK can lead to a stack overflow
> +		  and is disallowed.
> +
>  	config INIT_STACK_ALL_PATTERN
> -		bool "0xAA-init everything on the stack (strongest)"
> +		bool "pattern-init everything (strongest)"
>  		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
>  		help
> -		  Initializes everything on the stack with a 0xAA
> -		  pattern. This is intended to eliminate all classes
> -		  of uninitialized stack variable exploits and information
> -		  exposures, even variables that were warned to have been
> -		  left uninitialized.
> +		  Initializes everything on the stack (including padding)
> +		  with a specific debug value. This is intended to eliminate
> +		  all classes of uninitialized stack variable exploits and
> +		  information exposures, even variables that were warned about
> +		  having been left uninitialized.
>  
>  		  Pattern initialization is known to provoke many existing bugs
>  		  related to uninitialized locals, e.g. pointers receive
> -		  non-NULL values, buffer sizes and indices are very big.
> +		  non-NULL values, buffer sizes and indices are very big. The
> +		  pattern is situation-specific; Clang on 64-bit uses 0xAA
> +		  repeating for all types and padding except float and double
> +		  which use 0xFF repeating (-NaN). Clang on 32-bit uses 0xFF
> +		  repeating for all types and padding.
>  
>  	config INIT_STACK_ALL_ZERO
> -		bool "zero-init everything on the stack (strongest and safest)"
> +		bool "zero-init everything (strongest and safest)"
>  		depends on CC_HAS_AUTO_VAR_INIT_ZERO
>  		help
> -		  Initializes everything on the stack with a zero
> -		  value. This is intended to eliminate all classes
> -		  of uninitialized stack variable exploits and information
> -		  exposures, even variables that were warned to have been
> -		  left uninitialized.
> -
> -		  Zero initialization provides safe defaults for strings,
> -		  pointers, indices and sizes, and is therefore
> -		  more suitable as a security mitigation measure.
> +		  Initializes everything on the stack (including padding)
> +		  with a zero value. This is intended to eliminate all
> +		  classes of uninitialized stack variable exploits and
> +		  information exposures, even variables that were warned
> +		  about having been left uninitialized.
> +
> +		  Zero initialization provides safe defaults for strings
> +		  (immediately NUL-terminated), pointers (NULL), indices
> +		  (index 0), and sizes (0 length), so it is therefore more
> +		  suitable as a production security mitigation than pattern
> +		  initialization.
>  
>  endchoice
>  
> -- 
> 2.30.2
> 

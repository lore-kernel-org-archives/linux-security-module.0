Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A36C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 09:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF4020679
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 09:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ezt4NfB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgFPJIL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPJIL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 05:08:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE443C05BD43
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 02:08:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v11so937669pgb.6
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eu2oq0yjr6Eq5I9NRCK1BJJMT0oPPDxPZXG6oIi1TI0=;
        b=ezt4NfB4JG+xSwwNShZEsNSM9PWNfoR57G0ueDUBHNAzAqMLXb6Kft8YjHXYBqLP4f
         87N1XLEK4GD+Q3c1r7MUl0tiKmcWsW+4HnCO5HAm3Ut0a8IivFBhk6eBibNilpHhqaxG
         HT9HIss0WFfQ5nn45hXP0J1caAdgZEkzMS660=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eu2oq0yjr6Eq5I9NRCK1BJJMT0oPPDxPZXG6oIi1TI0=;
        b=ls5vYPOobB6SQWKAZz+lKDuXH4f8ea0L2Zz7r2pwpvNYh4F+S8aIPmO6MAZ8epW2IC
         o5MZQGHHkPVe/PWLpT/f0taJktnPJ4goh46f2kj+R+3co6Ng0hg8+lNkpiiEyMX50/Ba
         BYe/4EyPae44xfzQ1JReYy8bGWazg+o4eukMC/Xtkjk5qAn6+Kk1hrCQNOSsKHzN2CCI
         Lre9EIn09TL20/C10n3j83aCwLWEu9jD4Wfeh6p0auigZuYlfQlg9f6mNLCC3DvPKr1o
         jux9L9E7qTvrkq+GfKE0ZxSZWYUH1R8/MIewP19H3JYV3xLrQBmvZF7CUoDqJg5x6bwk
         Ktog==
X-Gm-Message-State: AOAM530Ncw6TLqGI7wff5nl7IzFYEHeuPhLDdQKfVYukCNeJ92iPqveC
        diTQG1Kxj8qq64FoBrw0cP2dGg==
X-Google-Smtp-Source: ABdhPJxa1M9lfXKWXXotDl+Tv4E6TsIr+bwNAHx7um2PrBzY3tZEsYxiPRDcdZ6Eova+j1giK6zZhQ==
X-Received: by 2002:a62:3645:: with SMTP id d66mr1252372pfa.275.1592298490417;
        Tue, 16 Jun 2020 02:08:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm16449421pfi.170.2020.06.16.02.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:08:09 -0700 (PDT)
Date:   Tue, 16 Jun 2020 02:08:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     glider@google.com
Cc:     yamada.masahiro@socionext.com, jmorris@namei.org, maze@google.com,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
Message-ID: <202006160207.E9C6FDDB7@keescook>
References: <20200616083435.223038-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616083435.223038-1-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 10:34:35AM +0200, glider@google.com wrote:
> In addition to -ftrivial-auto-var-init=pattern (used by
> CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
> locals enabled by -ftrivial-auto-var-init=zero.
> The future of this flag is still being debated, see
> https://bugs.llvm.org/show_bug.cgi?id=45497
> Right now it is guarded by another flag,
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> which means it may not be supported by future Clang releases.
> Another possible resolution is that -ftrivial-auto-var-init=zero will
> persist (as certain users have already started depending on it), but the
> name of the guard flag will change.
> 
> In the meantime, zero initialization has proven itself as a good
> production mitigation measure against uninitialized locals. Unlike
> pattern initialization, which has a higher chance of triggering existing
> bugs, zero initialization provides safe defaults for strings, pointers,
> indexes, and sizes. On the other hand, pattern initialization remains
> safer for return values.
> Performance-wise, the difference between pattern and zero initialization
> is usually negligible, although the generated code for zero
> initialization is more compact.
> 
> This patch renames CONFIG_INIT_STACK_ALL to
> CONFIG_INIT_STACK_ALL_PATTERN and introduces another config option,
> CONFIG_INIT_STACK_ALL_ZERO, that enables zero initialization for locals
> if the corresponding flags are supported by Clang.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Thanks! I've applied this to my for-next/kspp tree (with a few small
tweaks).

> --

^^ note, this separator should be "---" for diff tools to do the right
thing, etc.

> v2:
>  - as suggested by Kees Cook, make CONFIG_INIT_STACK_ALL_PATTERN and
>    CONFIG_INIT_STACK_ALL_ZERO separate options.
> ---
>  Makefile                   | 12 ++++++++++--
>  init/main.c                |  6 ++++--
>  security/Kconfig.hardening | 29 +++++++++++++++++++++++++----
>  3 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fd31992bf918..fa739995ee12 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -802,11 +802,19 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
>  endif
>  endif
>  
> -# Initialize all stack variables with a pattern, if desired.
> -ifdef CONFIG_INIT_STACK_ALL
> +# Initialize all stack variables with a 0xAA pattern.
> +ifdef CONFIG_INIT_STACK_ALL_PATTERN
>  KBUILD_CFLAGS	+= -ftrivial-auto-var-init=pattern
>  endif
>  
> +# Initialize all stack variables with a zero pattern.
> +ifdef CONFIG_INIT_STACK_ALL_ZERO
> +# Future support for zero initialization is still being debated, see
> +# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> +# renamed or dropped.
> +KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> +endif
> +
>  DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
>  
>  ifdef CONFIG_DEBUG_INFO
> diff --git a/init/main.c b/init/main.c
> index 0ead83e86b5a..ee08cef4aa1a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -779,8 +779,10 @@ static void __init report_meminit(void)
>  {
>  	const char *stack;
>  
> -	if (IS_ENABLED(CONFIG_INIT_STACK_ALL))
> -		stack = "all";
> +	if (IS_ENABLED(CONFIG_INIT_STACK_ALL_PATTERN))
> +		stack = "all (pattern)";
> +	else if (IS_ENABLED(CONFIG_INIT_STACK_ALL_ZERO))
> +		stack = "all (zero)";
>  	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
>  		stack = "byref_all";
>  	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index af4c979b38ee..7b705611ccaa 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -19,13 +19,16 @@ config GCC_PLUGIN_STRUCTLEAK
>  
>  menu "Memory initialization"
>  
> -config CC_HAS_AUTO_VAR_INIT
> +config CC_HAS_AUTO_VAR_INIT_PATTERN
>  	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
>  
> +config CC_HAS_AUTO_VAR_INIT_ZERO
> +	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
> +
>  choice
>  	prompt "Initialize kernel stack variables at function entry"
>  	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> -	default INIT_STACK_ALL if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT
> +	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
>  	default INIT_STACK_NONE
>  	help
>  	  This option enables initialization of stack variables at
> @@ -88,15 +91,33 @@ choice
>  		  of uninitialized stack variable exploits and information
>  		  exposures.
>  
> -	config INIT_STACK_ALL
> +	config INIT_STACK_ALL_PATTERN
>  		bool "0xAA-init everything on the stack (strongest)"
> -		depends on CC_HAS_AUTO_VAR_INIT
> +		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
>  		help
>  		  Initializes everything on the stack with a 0xAA
>  		  pattern. This is intended to eliminate all classes
>  		  of uninitialized stack variable exploits and information
>  		  exposures, even variables that were warned to have been
>  		  left uninitialized.
> +		  Pattern initialization is known to provoke many existing bugs
> +		  related to uninitialized locals, e.g. pointers receive
> +		  non-NULL values, buffer sizes and indices are very big.
> +
> +	config INIT_STACK_ALL_ZERO
> +		bool "zero-init everything on the stack (strongest and safest)"
> +		depends on CC_HAS_AUTO_VAR_INIT_ZERO
> +		help
> +		  Initializes everything on the stack with a zero
> +		  pattern. This is intended to eliminate all classes
> +		  of uninitialized stack variable exploits and information
> +		  exposures, even variables that were warned to have been
> +		  left uninitialized.
> +		  Zero initialization provides safe defaults for strings,
> +		  pointers, indices and sizes, and is therefore more suitable as
> +		  a security mitigation measure.
> +		  The corresponding flag isn't officially supported by Clang and
> +		  may sooner or later go away or get renamed.
>  
>  endchoice
>  
> -- 
> 2.27.0.290.gba653c62da-goog
> 

-- 
Kees Cook

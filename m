Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC17C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D1B60F6F
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 19:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhINTiB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232252AbhINTiA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 15:38:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4759E60F11;
        Tue, 14 Sep 2021 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631648203;
        bh=EpYP61q3ILFoGQehdJpA1cuxI7Ow2PsbWkjVVP/DSWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEQovUohmeVzk4AWLjKtD13AF1Y5tRPrZOKpzagZjGUnN3IbMkBIw0Eicrm9WeM8W
         K8mubn2O5qEdscjrdZ8jdXTgecynE8GYPAuw9+NnSgkh7jYtEKzvj1Lye6gdlTkO4L
         7OU9QdpQZEIpbOf/Wu1XUR8CWHgdui+L6MC6GWI2lvtedMQZNQN9yEa5XRrqQJjMqh
         mUaJWv6Ue20zNTtYzc3zm8qgesE08xVjHVgeC49AlCpvMrNhhDbGLtve7eVlAzby3D
         htT95osIKAV22cd5Y9/wpJkLXHqxEbGctV2tj1FEk06TY3RhMSpXSV8Lvf9xi9hcUz
         2XbDuIISb7rOw==
Date:   Tue, 14 Sep 2021 12:36:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if
 CC_HAS_AUTO_VAR_INIT_ZERO
Message-ID: <YUD5xfIDzrQmPE6D@archlinux-ax161>
References: <20210914102837.6172-1-will@kernel.org>
 <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook>
 <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
 <202109141214.630BB3A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109141214.630BB3A@keescook>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 14, 2021 at 12:14:47PM -0700, Kees Cook wrote:
> On Tue, Sep 14, 2021 at 11:53:38AM -0700, Nick Desaulniers wrote:
> > Rather than create 2 new kconfigs with 1 new invocation of the
> > compiler via cc-option, how about just adding an `ifdef
> > CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
> > `KBUILD_CFLAGS` in the top level Makefile?
> 
> v2:

Thanks for clarifying! (since I did not actually test before making the
comment...)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
>  KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
> +ifdef CONFIG_CC_IS_CLANG
> +# https://bugs.llvm.org/show_bug.cgi?id=45497
>  KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
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
>  	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
>  
>  config CC_HAS_AUTO_VAR_INIT_ZERO
> +	# GCC ignores the -enable flag, so we can test for the feature with
> +	# a single invocation using the flag, but drop it as appropriate in
> +	# the Makefile, depending on the presence of Clang.
>  	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
>  
>  choice
>  	prompt "Initialize kernel stack variables at function entry"
>  	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
>  	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> -	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> +	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
>  	default INIT_STACK_NONE
>  	help
>  	  This option enables initialization of stack variables at
> 
> -- 
> Kees Cook
> 

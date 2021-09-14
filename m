Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C10EC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 15:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A49C60F8F
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhINP7d (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235068AbhINP7c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 11:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFE9C61157;
        Tue, 14 Sep 2021 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631635095;
        bh=S40ApYu3+8/mXjIC0MgqMN4flPXp1mC5JHBKiqjo1mU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FFSrDnn337ksWTJSmQHorLozHC1AvfksczrybxHQxAff6uMmH6Dwf4OP/4Bczmmj4
         7J+S47J4TnkJ+N3nEd+rwHyjQ5xvABF/+yKlmcr22rLMjuTlbFLrEqNqI+FG+S8f+G
         iVUagUnpq9N9upNv0kaKgFFGn/ESt//P2W+3X1r1NpDN5OdZEfdahn7DHznBGOj9RA
         vBTR4FQpIsV0z8KywH0Zbjb//tlfx/celRbb+L+GqyvInUcJhLZqZbNMLCcqm8cre2
         W7Xkz/TT2OxoNlnYavIz+mNT/UnHi+IO/i6LbZrzMUmwi5EjejiEGCKB886Xb3+3uh
         j8QGaBQWEMRvQ==
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if
 CC_HAS_AUTO_VAR_INIT_ZERO
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210914102837.6172-1-will@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
Date:   Tue, 14 Sep 2021 08:58:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914102837.6172-1-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/14/2021 3:28 AM, Will Deacon wrote:
> CC_HAS_AUTO_VAR_INIT_ZERO requires a supported set of compiler options
> distinct from those needed by CC_HAS_AUTO_VAR_INIT_PATTERN, Fix up
> the Kconfig dependency for INIT_STACK_ALL_ZERO to test for the former
> instead of the latter, as these are the options passed by the top-level
> Makefile.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: dcb7c0b9461c ("hardening: Clarify Kconfig text for auto-var-init")
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One comment below.

> ---
> 
> I just noticed this while reading the code and I suspect it doesn't really
> matter in practice.
> 
>   security/Kconfig.hardening | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 90cbaff86e13..341e2fdcba94 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -29,7 +29,7 @@ choice
>   	prompt "Initialize kernel stack variables at function entry"
>   	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
>   	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> -	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> +	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
>   	default INIT_STACK_NONE
>   	help
>   	  This option enables initialization of stack variables at
> 

While I think this change is correct in and of itself, 
CONFIG_INIT_STACK_ALL_ZERO is broken with GCC 12.x, as 
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO won't be set even though GCC now 
supports -ftrivial-auto-var-init=zero because GCC does not implement the 
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang 
flag for obvious reasons ;) the cc-option call probably needs to be 
adjusted.

Cheers,
Nathan

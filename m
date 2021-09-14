Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EAC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB74E60F48
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 17:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhINRWy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhINRWx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 13:22:53 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7443C061574
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 10:21:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y8so7587792pfa.7
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3KcfDuI+vgr3UdYnojYVnwtddmopW4ZL19RdmRiChyg=;
        b=OEn7CkGqtIQ1V2B5tVX1veXUmmJU/H8x6RbgAohTflrWRul98mmNl8/moi95Kw9cvQ
         CwG7tgc07l5WqRDxKEc37+CzXebBe4tw46muukaX9mqpdImVEoPRlpWStg2aHP7MOlqQ
         pWnoDLtr4tIkPdKUve41e/nyUnxGWdeZ99Euc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KcfDuI+vgr3UdYnojYVnwtddmopW4ZL19RdmRiChyg=;
        b=j4dzxSECBQzrpwLJbdmPtUd0eoTVM/qCyM7knxg9adfhSOjbgv+b+HlpQU6dMgj2fI
         jZhogle6PLzFX+AyYHXoJYM1ddxFEWCZddTRN2Nj+Y9ETnoWqyRLbFpJit8Or/yxjT6i
         0l8Awb6MepL1/4n/HW7Y2TkLHYZS4oiYzym77XuKirmVYStFVkrffZW2tL5TrSY9qNeC
         hwp3Eusg/5Y9f3ELTCdPEIZnCK6sosd+c7zHYa1cxcxOeIYOk4YqdA9q7Rj9ffcPbGqL
         IEIFb1LXwZw/WGWX363/bRL2raugweZOEPuuXL+PZ85QjEdxRlCl/IKN5W2+fc8F7u9t
         ldNw==
X-Gm-Message-State: AOAM531OQBIQVJf/PMbw3sY/lNNrVtWAOFAHlIIKw0irBitXveuUtOYO
        Un+aMXnObvF5BiedSSGistjOoQ==
X-Google-Smtp-Source: ABdhPJwZaIOCxR+FZgWf2C1M/JBUB+WGGlaZttSC8Dhrxf5K2EGIsAngtp9JUJOo+4HsDA5oXXvQPA==
X-Received: by 2002:a63:ea58:: with SMTP id l24mr16568444pgk.334.1631640095450;
        Tue, 14 Sep 2021 10:21:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm12074192pgk.37.2021.09.14.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:21:34 -0700 (PDT)
Date:   Tue, 14 Sep 2021 10:21:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if
 CC_HAS_AUTO_VAR_INIT_ZERO
Message-ID: <202109140958.11DCC6B6@keescook>
References: <20210914102837.6172-1-will@kernel.org>
 <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 14, 2021 at 08:58:12AM -0700, Nathan Chancellor wrote:
> On 9/14/2021 3:28 AM, Will Deacon wrote:
> > CC_HAS_AUTO_VAR_INIT_ZERO requires a supported set of compiler options
> > distinct from those needed by CC_HAS_AUTO_VAR_INIT_PATTERN, Fix up
> > the Kconfig dependency for INIT_STACK_ALL_ZERO to test for the former
> > instead of the latter, as these are the options passed by the top-level
> > Makefile.
> > 
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Fixes: dcb7c0b9461c ("hardening: Clarify Kconfig text for auto-var-init")
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> One comment below.
> 
> > ---
> > 
> > I just noticed this while reading the code and I suspect it doesn't really
> > matter in practice.
> > 
> >   security/Kconfig.hardening | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index 90cbaff86e13..341e2fdcba94 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -29,7 +29,7 @@ choice
> >   	prompt "Initialize kernel stack variables at function entry"
> >   	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> >   	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
> > -	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
> > +	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
> >   	default INIT_STACK_NONE
> >   	help
> >   	  This option enables initialization of stack variables at
> > 
> 
> While I think this change is correct in and of itself,
> CONFIG_INIT_STACK_ALL_ZERO is broken with GCC 12.x, as
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO won't be set even though GCC now supports
> -ftrivial-auto-var-init=zero because GCC does not implement the
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> flag for obvious reasons ;) the cc-option call probably needs to be
> adjusted.

GCC silently ignores the -enable flag, so things actually work correctly
as-is. But, yes, it makes the command line long and doesn't make sense.
How about we do this instead:

diff --git a/Makefile b/Makefile
index 34a0afc3a8eb..34439deac939 100644
--- a/Makefile
+++ b/Makefile
@@ -831,12 +831,11 @@ endif
 
 # Initialize all stack variables with a zero value.
 ifdef CONFIG_INIT_STACK_ALL_ZERO
-# Future support for zero initialization is still being debated, see
-# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
-# renamed or dropped.
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
+ifdef CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
+endif
 
 # While VLAs have been removed, GCC produces unreachable stack probes
 # for the randomize_kstack_offset feature. Disable it for all compilers.
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 90cbaff86e13..beea81df3081 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -22,14 +22,22 @@ menu "Memory initialization"
 config CC_HAS_AUTO_VAR_INIT_PATTERN
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
+config CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE
+	def_bool $(cc-option,-ftrivial-auto-var-init=zero)
+
+config CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
+	# https://bugs.llvm.org/show_bug.cgi?id=45497
+	def_bool !CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE && \
+		 $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
+
 config CC_HAS_AUTO_VAR_INIT_ZERO
-	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
+	def_bool CC_HAS_AUTO_VAR_INIT_ZERO_WITHOUT_ENABLE || CC_HAS_AUTO_VAR_INIT_ZERO_WITH_ENABLE
 
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
 	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
-	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
+	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at



-- 
Kees Cook

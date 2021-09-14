Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F270C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2709560E8B
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhINTQI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhINTQH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 15:16:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41FBC061574
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 12:14:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id dw14so374464pjb.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNioXU0MaGQyZ5RIrwYsgFEeu2lEK50VeMha94pJwX4=;
        b=UAKO/UOiaU1PdKht7PRKzibqGkYgD0KbO9jsMrGya4DN6yCpz985EUHJRH/aJ+dFZy
         d4pHkAx+nm9Af7tvOJUvrb2hol2EvPP0ao7cK4fubZPZl7iI5qat4PKpZsncuY/DjHui
         lzghFTXEB3lwcoMeZVKL4MtiVxOEsCWZZu4Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNioXU0MaGQyZ5RIrwYsgFEeu2lEK50VeMha94pJwX4=;
        b=tN95CPTqcrIkAw7uq7algTAefXBytm/EHtMnmdjlW4CrHACaNkCZmu2yKGRX31Hpiq
         5nydOr7bVQn5jYXaTkztgcJGgeo/Dh/IpOhvhNOg4n+08X4YOcPN4viNeMP8YJ8osF08
         nJ5NmhBT+oIUAIk/hNBs8MOjQ+2bQzC2gtQXIJ2a9iLgNkBY1wQE7ivnn1bp4gcJ5Ytx
         AKfwBuG6xug/L1GdnpK3KjvIu/r9rhUI4yJJG0/Z9SC2gi9dsjO3ZPKUye76tXcaZgh3
         oaVsCrFiF4ZLaGoSRKsyl77CyuYYNNS4MRfnAHUITZ/9aBZlYUhmB/+9svU9P/mzeFAW
         rgHg==
X-Gm-Message-State: AOAM531MD9v38lD/WXm4UNEJy0WHWJ3xNPm3BeNtika+IYiQI9tydMqL
        Yg+xJqM3qix5GJQ+sVhtfEeZvA==
X-Google-Smtp-Source: ABdhPJyI0mKpstT5jhiy8B2h3aJvoFwAGl1qSX+Q8TZdh3HNl/2QvRHQXqiqf8Ds36tXnifLp970sA==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr3813147pjb.172.1631646889515;
        Tue, 14 Sep 2021 12:14:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4sm11402339pff.11.2021.09.14.12.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:14:48 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:14:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hardening: Default to INIT_STACK_ALL_ZERO if
 CC_HAS_AUTO_VAR_INIT_ZERO
Message-ID: <202109141214.630BB3A@keescook>
References: <20210914102837.6172-1-will@kernel.org>
 <01f572ab-bea2-f246-2f77-2f119056db84@kernel.org>
 <202109140958.11DCC6B6@keescook>
 <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnrO7X8h-g9Pn8RmfJhqj2zn3HJwpQ0p2EONNtFF0w-uA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 14, 2021 at 11:53:38AM -0700, Nick Desaulniers wrote:
> Rather than create 2 new kconfigs with 1 new invocation of the
> compiler via cc-option, how about just adding an `ifdef
> CONFIG_CC_IS_CLANG` guard around adding the obnoxious flag to
> `KBUILD_CFLAGS` in the top level Makefile?

v2:

diff --git a/Makefile b/Makefile
index 34a0afc3a8eb..72d165ffabdb 100644
--- a/Makefile
+++ b/Makefile
@@ -831,12 +831,12 @@ endif
 
 # Initialize all stack variables with a zero value.
 ifdef CONFIG_INIT_STACK_ALL_ZERO
-# Future support for zero initialization is still being debated, see
-# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
-# renamed or dropped.
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
+ifdef CONFIG_CC_IS_CLANG
+# https://bugs.llvm.org/show_bug.cgi?id=45497
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
+endif
 
 # While VLAs have been removed, GCC produces unreachable stack probes
 # for the randomize_kstack_offset feature. Disable it for all compilers.
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 90cbaff86e13..ded17b8abce2 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -23,13 +23,16 @@ config CC_HAS_AUTO_VAR_INIT_PATTERN
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
 config CC_HAS_AUTO_VAR_INIT_ZERO
+	# GCC ignores the -enable flag, so we can test for the feature with
+	# a single invocation using the flag, but drop it as appropriate in
+	# the Makefile, depending on the presence of Clang.
 	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
 
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

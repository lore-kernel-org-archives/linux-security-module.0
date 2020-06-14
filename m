Return-Path: <SRS0=sigj=73=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2DC433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CBC20775
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RVm8y0NI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFNSnT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFNSnT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 14:43:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A50DC08C5C2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:43:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so6632816pgm.0
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7eEzri1LW7M6GH9/MKZp/D43yNKgA0imFtveBKQb4Ro=;
        b=RVm8y0NIG1CFwK1KIeiJUulXIr5sgRiIPFr8R/dzsAmrvD/EM9Lt6mCcpQw9e7i7K1
         EwIUdE+R+hf/1HBpzqla0K+yMyA1FDJ6fzrE385vKbabwu6zwA+PCPSBPvj2AyVcPwcy
         5NubnSa2WBsHr8LMVm89M8C6IE8U6hw7LG6Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7eEzri1LW7M6GH9/MKZp/D43yNKgA0imFtveBKQb4Ro=;
        b=iNuPUqwz680rGT9kuxhNyEvIB8HRFOKZN9ihNmUTb9b/u+Bg/ui0gOxPl1chr9ehYp
         1EopQgJI2SzqjPz4bjXMrsi9Qk/urdJsa5gKdd7WvYLQSazUc8gZyzHE47wujp/sB7hm
         BpijYkHJjHySZYfiBQJ0C6kHmHKKJu0KlMFFvoWh8bNqMrx6+v9PHiGrgR1swbcwwAs9
         5dhh/Sh5jpQ9V968s/LCOYd1WTfLEjuxkHeLJNBFDuGpZ0ic/Bch+h/CIqVKjZF+T6oL
         6Om1Hr0Rb06u8NRAlw+VwhbdhyZbcOvRQ0RPMbrrLxkZqYPCq8iYablMsDqGg0lIP0W6
         zNlw==
X-Gm-Message-State: AOAM5330Ypv9nM67WAu2wXIfg4MhNmiizqCNxUNnH1gnkL+4xMghsc+Z
        kO0NBaoVnLaPC6ePSYo22f/1sA==
X-Google-Smtp-Source: ABdhPJwIw2Xf+NzqU3bOtyA5MpZZjRIh8MW+CdWqNYrsrIt/uw6Kvw4UaYo+HfiSt0ivWWN8zm4a2g==
X-Received: by 2002:a63:c501:: with SMTP id f1mr18353034pgd.324.1592160198661;
        Sun, 14 Jun 2020 11:43:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm8840318pfb.110.2020.06.14.11.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 11:43:17 -0700 (PDT)
Date:   Sun, 14 Jun 2020 11:43:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] security: allow using Clang's zero initialization
 for stack variables
Message-ID: <202006141140.81AAA907D@keescook>
References: <20200614144534.237035-1-glider@google.com>
 <202006141000.B93DF245@keescook>
 <CAG_fn=V0w2OShK+iQODkwdPoG094VpiPkhZ8O_F37m=g2XWwug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=V0w2OShK+iQODkwdPoG094VpiPkhZ8O_F37m=g2XWwug@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 14, 2020 at 07:16:33PM +0200, Alexander Potapenko wrote:
> On Sun, Jun 14, 2020 at 7:04 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sun, Jun 14, 2020 at 04:45:34PM +0200, glider@google.com wrote:
> > > In addition to -ftrivial-auto-var-init=pattern (used by
> > > CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
> > > locals enabled by -ftrivial-auto-var-init=zero.
> > > The future of this flag is still being debated, see
> > > https://bugs.llvm.org/show_bug.cgi?id=45497
> > > Right now it is guarded by another flag,
> > > -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> > > which means it may not be supported by future Clang releases.
> > > Another possible resolution is that -ftrivial-auto-var-init=zero will
> > > persist (as certain users have already started depending on it), but the
> > > name of the guard flag will change.
> > >
> > > In the meantime, zero initialization has proven itself as a good
> > > production mitigation measure against uninitialized locals. Unlike
> > > pattern initialization, which has a higher chance of triggering existing
> > > bugs, zero initialization provides safe defaults for strings, pointers,
> > > indexes, and sizes. On the other hand, pattern initialization remains
> > > safer for return values.
> > > Performance-wise, the difference between pattern and zero initialization
> > > is usually negligible, although the generated code for zero
> > > initialization is more compact.
> > >
> > > The proposed config, CONFIG_USE_CLANG_ZERO_INITIALIZATION, makes
> > > CONFIG_INIT_STACK_ALL use zero initialization if the corresponding flags
> > > are supported by Clang.
> > >
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > ---
> > >  Makefile                   | 15 ++++++++++++++-
> > >  security/Kconfig.hardening | 16 ++++++++++++++++
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index fd31992bf918..2860bad7e39a 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -802,9 +802,22 @@ KBUILD_CFLAGS    += -fomit-frame-pointer
> > >  endif
> > >  endif
> > >
> > > -# Initialize all stack variables with a pattern, if desired.
> > > +# Initialize all stack variables, if desired.
> > >  ifdef CONFIG_INIT_STACK_ALL
> > > +
> > > +# Use pattern initialization by default.
> > > +ifndef CONFIG_USE_CLANG_ZERO_INITIALIZATION
> > >  KBUILD_CFLAGS        += -ftrivial-auto-var-init=pattern
> > > +else
> > > +
> > > +ifdef CONFIG_CC_HAS_AUTO_VAR_ZERO_INIT
> > > +# Future support for zero initialization is still being debated, see
> > > +# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> > > +# renamed or dropped.
> > > +KBUILD_CFLAGS        += -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> > > +endif
> > > +
> > > +endif
> > >  endif
> >
> > I'd prefer this be split instead of built as a nested if (i.e. entirely
> > control section via the Kconfig -- see below).
> >
> > >
> > >  DEBUG_CFLAGS := $(call cc-option, -fno-var-tracking-assignments)
> > > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > > index af4c979b38ee..299d27c6d78c 100644
> > > --- a/security/Kconfig.hardening
> > > +++ b/security/Kconfig.hardening
> > > @@ -22,6 +22,9 @@ menu "Memory initialization"
> > >  config CC_HAS_AUTO_VAR_INIT
> > >       def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
> > >
> > > +config CC_HAS_AUTO_VAR_ZERO_INIT
> > > +     def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
> > > +
> >
> > I'd like to be more specific here. Let's rename CC_HAS_AUTO_VAR_INIT to
> > CC_HAS_AUTO_VAR_INIT_PATTERN, and change the other to
> > CC_HAS_AUTO_VAR_INIT_ZERO (they then both match the word order of the
> > option, and the thing that changes is the last word).
> >
> > >  choice
> > >       prompt "Initialize kernel stack variables at function entry"
> > >       default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> > > @@ -100,6 +103,19 @@ choice
> > >
> > >  endchoice
> > >
> > > +config USE_CLANG_ZERO_INITIALIZATION
> > > +     bool "Use Clang's zero initialization for local variables"
> > > +     depends on CC_HAS_AUTO_VAR_ZERO_INIT
> > > +     depends on INIT_STACK_ALL
> > > +     help
> > > +       If set, uses zeros instead of 0xAA to initialize local variables in
> > > +       INIT_STACK_ALL. Zeroing the stack provides safer defaults for strings,
> > > +       pointers, indexes, and sizes. The downsides are less-safe defaults for
> > > +       return values, and exposing fewer bugs where the underlying code
> > > +       relies on zero initialization.
> > > +       The corresponding flag isn't officially supported by Clang and may
> > > +       sooner or later go away or get renamed.
> > > +
> >
> > Similarly, I'd like to rename INIT_STACK_ALL to INIT_STACK_ALL_PATTERN
> > and then add INIT_STACK_ALL_ZERO.
> 
> What are the policies regarding keeping the existing config flags?
> Don't we need to preserve INIT_STACK_ALL?

There isn't a strong policy -- it's mostly a question of "how painful
will it be for end-users to change this?" Given the users of this are
the Clang folks, and it's a very new option, I would prefer we just
change it and carry on.

That said, I'd also like at some point do:

 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
-	default INIT_STACK_ALL_ZERO if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_ZERO
+	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at

But not at this time...

-- 
Kees Cook

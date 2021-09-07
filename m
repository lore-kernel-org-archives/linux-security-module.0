Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE3C4332F
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A6761106
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 22:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347401AbhIGWPf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbhIGWPe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Sep 2021 18:15:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0BC061757
        for <linux-security-module@vger.kernel.org>; Tue,  7 Sep 2021 15:14:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so188013wrc.11
        for <linux-security-module@vger.kernel.org>; Tue, 07 Sep 2021 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xFotH6edqMtbbzTy8uk9QzUuC79ZGdry8KcHax9XaBY=;
        b=gtcgoNKwgWnIDZ2Z40MNQJmSvNZ52dGCJcEg40Gfizpfbg7yVKLf92pJt6VNj8TYuu
         zaK3+JkBFQVfz6Vwa/D8JskhGC9dm4RlcTZrXwn14Y3RyAfkoh3mF95wjV78oB1fWpLY
         9ZQ2TpCaDoJmoAV0eEx0ACZ2bPJ/PCGNalTLmifc5mtZjsA9hdp6RQ/Jz/eKZzrVwByY
         YtfRYfshqiBK/XdhXbdt3EgiEPjLWU84B/D2FQD0oZWALfe5l0b8qT1SziKaYbnpCCsJ
         QvtSd0Rzd3ParrdD4km/C+QkGx8ErrJrylIWE7KLnL/5W+d3saGKTlNEO5MP1DK8ntkN
         X4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFotH6edqMtbbzTy8uk9QzUuC79ZGdry8KcHax9XaBY=;
        b=JFmYyj0OwqQhX4yYTS2i8rWzjlCjetg0zEJIjU0s/7UbQiwvG9UEq/kNex4ReEWUIO
         /ZBM1d79Vy+UEPi63Z3Q72+WuJFeGO3EyOje2OKheUDcs+rk+FR3Xx30JBNA2/x/iKJK
         IUmvbLP5niKgSa5Nxiy0b7Di7zPsjF9A5LWxtVcb4p2PW2nfSmTF9faa8xdvhTBCohmb
         7oon1IpH/Nn25t54aG7aW8sWk2AaS5kw+t1EFEkNlm51vG19OHJgpJdssocZe9EgLQpZ
         sUdyQ0Iaw727KDJ/dqvxQlxG5+ES0Sin5ZWYbvWRd4FhR0tS609zwNl1zopKqDNM8gSA
         IR6g==
X-Gm-Message-State: AOAM532KS/ffxDaEDCTjBIyCn0EqEd8q6G4LmCkFnotlijnvgD/9X+Mx
        c/NTBb44+OqLdfwpeoXVxAZYx4xtxvWugQ==
X-Google-Smtp-Source: ABdhPJzQNzjoIYl7hnw1VXbwu33mfc9UTzINbge4K/7xHYwNuhhESeISiVC+cGG9ow29/yOs+86PPA==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr524571wrf.405.1631052865921;
        Tue, 07 Sep 2021 15:14:25 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
        by smtp.gmail.com with ESMTPSA id i11sm264098wrb.48.2021.09.07.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:14:25 -0700 (PDT)
Date:   Wed, 8 Sep 2021 00:14:19 +0200
From:   Marco Elver <elver@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     llvm@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-toolchains@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "Enable '-Werror' by default for all kernel
 builds"
Message-ID: <YTfkO2PdnBXQXvsm@elver.google.com>
References: <20210907183843.33028-1-ndesaulniers@google.com>
 <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
 <CAKwvOdkuYoke=Sa8Qziveo9aSA2zaNWEcKW8LZLg+d3TPwHkoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkuYoke=Sa8Qziveo9aSA2zaNWEcKW8LZLg+d3TPwHkoA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 07, 2021 at 01:30PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 7, 2021 at 12:16 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
[...]
> > I'm not going to revert that change. I probably will have to limit it
> > (by making that WERROR option depend on certain expectations), but
> > basically any maintainer who has code that causes warnings should
> > expect that they will have to fix those warnings.
> 
> I'm not 100% against it; I think it could land in a more useful
> variation. But it would be good to discuss that on-list, and give it
> time to soak. This is a conversation we should be having with CI
> maintainers IMO, and folks that maintain the build infra, at least.
> I'm happy to kick off that discussion with this RFC.

Here's a datapoint: I had to disable CONFIG_WERROR on a bunch of syzbot
instances which started failing because of -Werror [1], because syzbot's
time is better spent on fuzzing, and having the odd warning in some
subsystem penalize fuzzing of the entire kernel is not appropriate.

[1] https://github.com/google/syzkaller/commit/e096c0a2a414e487412c9669426780ce5acdde9d

Getting the kernel built is a hard requirement for any sort of runtime
testing. Once the kernel is built, runtime testing of various subsystems
can proceed in parallel. A single warning in some odd subsystem
penalizing the _entire_ kernel's testing progress is inappropriate. The
severity of a use-after-free bug found by runtime testing is orders of
magnitude more severe than some "unused variable" warning. Now such a
warning would delay finding bugs at runtime on many CI systems that
haven't yet disabled the warning.

I'm predicting most distributions and runtime-focused CIs will disable
the warning.

I have formulated this in the form of a patch below, that might move
this new Kconfig option towards its appropriate usecases by default.

The intent is not to dispute the usefulness of -Werror, but select the
appropriate usecases by default, limiting friction for all those who can
do little more than say CONFIG_WERROR=n.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 7 Sep 2021 23:12:08 +0200
Subject: [PATCH] kbuild: Only default to -Werror if COMPILE_TEST

The cross-product of the kernel's supported toolchains, architectures,
and configuration options is large. So large, that it's generally
accepted to be infeasible to enumerate and build+test them all
(many compile-testers rely on randomly generated configs).

Without the possibility to enumerate all possible combinations of
toolchains, architectures, and configuration options, it is inevitable
that compiler warnings in this space exist.

With -Werror, this means that an innumerable set of kernels are now
broken, yet had been perfectly usable before (confused compilers, code
with warnings unused, or luck).

Distributors will necessarily pick a point in the toolchain X arch X
config space, and if unlucky, will have a broken build. Granted, those
will likely disable CONFIG_WERROR and move on.

The kernel's default configuration is unlikely to be suitable for all
users, but it's inappropriate to force many users to set CONFIG_WERROR=n.

This also holds for CI systems which are focused on runtime testing,
where the odd warning in some subsystem will disrupt testing of the rest
of the kernel. Many of those runtime-focused CI systems run tests or
fuzz the kernel using runtime debugging tools. Runtime testing of
different subsystems can proceed in parallel, and potentially uncover
serious bugs; halting runtime testing of the entire kernel because of
the odd warning (now error) in a subsystem or driver is simply
inappropriate.

Therefore, runtime-focused CI systems will likely choose CONFIG_WERROR=n
as well.

The appropriate usecase for -Werror is therefore compile-test focused
builds (often done by developers or CI systems).

Reflect this in the Kconfig option by making the default value of WERROR
match COMPILE_TEST.

Signed-off-by: Marco Elver <elver@google.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8cb97f141b70..11f8a845f259 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -139,7 +139,7 @@ config COMPILE_TEST
 
 config WERROR
 	bool "Compile the kernel with warnings as errors"
-	default y
+	default COMPILE_TEST
 	help
 	  A kernel build should not cause any compiler warnings, and this
 	  enables the '-Werror' flag to enforce that rule by default.
-- 
2.33.0.153.gba50c8fa24-goog


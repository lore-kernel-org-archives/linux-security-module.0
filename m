Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E8C41620
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F3F64F10
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhCCX7r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhCCPFw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 10:05:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B491C06175F
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 07:04:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v9so19804730lfa.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAU+oF5abLpOatKR6GoNs0xhW7zYpMa0vIglwnJvvdg=;
        b=TXjhTZG7o4n5bxO+2rz3ZIatg4fz7wrYFZRfWehMJbbvQvWXqTzvq7Yyxc/V+rxHSP
         fLDpnURO2RHIGMA0mJnT2UfCmKwc152iZKeIXdKhkO2ZKVx0F7067lsAeLTrO+wteFXE
         h2C7EnX3ZjEudvNE1bIupubFD88jPsxE+uh8vr5zD8wBjFtgE/hgCEdlCVdsrYs7KwaS
         6V7VVBhAky65ZFa+aKvy9i8fNgIgTe6ZVsDBYWpjblE++wUpIA+YWuUOf1Uu9dx/qkUW
         8UDFtPLiF/Vd1jHQnjnJB6FGzbw+gvB1PQB3CC4npvI0IMcllIhbZO7wZytSfUDf38Oe
         wvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAU+oF5abLpOatKR6GoNs0xhW7zYpMa0vIglwnJvvdg=;
        b=fRD7sk38x/qQbZmMVwlt9FR1K5UgGQ1Nfg4i/btPkNm/ZBy/iLshU1c45baq1LtWV6
         84MFySixmewRnStHJtpa69dsRwFmDOC1FPqYQSRu4d98Yrl2sbCovfFvDRQgHqoPxzDj
         DZs13q77gsZ4/Tn2Us5HVioRqkpQ0VkzvINYQW9RCVZAqn0upWX3KUp3uaHKzr1PexFM
         3sjw5geuzx8gqoIC9zByCNYENzfbAA/Ttjj4kVj+BY6CJUT0YRqkDAs5CgQeTJqEtcaM
         MvPPvt1n2CxiAZMi2nxLrv0/4/3L8aCAANHDnKphaCzhn/oRs4yBWKCxGSQEEpZcaedn
         4qmQ==
X-Gm-Message-State: AOAM533e6gdjr/Ol4hacG5hC62F6X+ihbqS0vQykhJpPWT4LanuBs8Df
        rGTzt6KoAgEUXNzdtSBCOZ3kP/pSOlZjU8KyGYARXg==
X-Google-Smtp-Source: ABdhPJzhn3AMqF86AcKRF6zE/lHio+2SRjlvtPdzQzkcMe7iFMLKCCIbtQi+Q4Qq7MhFPtEH8qf3gLsz5rcxlUqR6Yw=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr16105295lfe.29.1614783893687;
 Wed, 03 Mar 2021 07:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
In-Reply-To: <20210223023542.2287529-1-jiancai@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:04:42 +0100
Message-ID: <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: Implement SLS mitigation
To:     Jian Cai <jiancai@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, manojgupta@google.com,
        llozano@google.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 23, 2021 at 3:36 AM Jian Cai <jiancai@google.com> wrote:

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

I heard about compiler protection for this, so nice to see it happening!

Would you happen to know if there is any plan to do the same for GCC?
I know you folks at Google like LLVM, but if you know let us know.

> +config HARDEN_SLS_ALL
> +       bool "enable SLS vulnerability hardening"

I would go in and also edit arch/arm/mm/Kconfig under:
config HARDEN_BRANCH_PREDICTOR add
select HARDEN_SLS_ALL

Because if the user wants hardening for branch prediction
in general then the user certainly wants this as well, if
available. The help text for that option literally says:

 "This config option will take CPU-specific actions to harden
   the branch predictor against aliasing attacks and may rely on
   specific instruction sequences or control bits being set by
   the system firmware."

Notice this only turns on for CPUs with CPU_SPECTRE
defined which makes sense. Also it is default y which fulfils
Will's request that it be turned on by default where
applicable. Notably it will not be turned on for pre-v7 silicon
which would be unhelpful as they don't suffer from
these bugs.

Reading Kristofs compiler patch here:
https://reviews.llvm.org/rG195f44278c4361a4a32377a98a1e3a15203d3647

I take it that for affected CPUs we should also patch all assembly
in the kernel containing a RET, BR or BLR with
DSB SYS followed by ISB?

I suppose we would also need to look for any mov PC, <>
code...

I guess we can invent a "SB" macro to mimic what Aarch64 is
doing so the code is easy to read. (Thinking aloud.)

Yours,
Linus Walleij

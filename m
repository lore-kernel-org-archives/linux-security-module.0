Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8203DC433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469D364F2C
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 23:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhCDXXE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhCDXXE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 18:23:04 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2B4C061756
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 15:23:03 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o3so370521oic.8
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 15:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KX90TntfNSVDI/d+8xow5Mh17Q6zvuilvP5em04oWjY=;
        b=evlkDz3tOC0PRm2yFOMRmARwNKsKxDT+D/sjkRuXV1enp+iw0RNNX7PXb0LeA4PIuk
         a4adaa26mplL1TvI3Oa6QpU9gkZwS7NqO5vFN9NGwWQG96gOnbRstdXXREnPse4zOCSJ
         wmClzqRUYMTOHDnkjYhUnQeri3Kv6FraqdTVDrzJ+lbM8lI+UDnw03PX3A418wQZtQcf
         Qty0fett7YCVsVMlvaQIp+jkOWSAXv9la1FwplnqLjBg8hmMGdMAkstxUTFh25zy5YbH
         nR6oxYgIpHy15AjyF447AWS3rjlhHbeqgPZfA0olvaACefhOKfONldoRjh0EIossCuOe
         7fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KX90TntfNSVDI/d+8xow5Mh17Q6zvuilvP5em04oWjY=;
        b=bw0NSaDQzlTQocVvekQoTcSusGy9dg4Er+klMLKgBo36LfFl4glTDkHfgaIEEI5r3p
         GCByMFNEeTJGDcjEOWySTofC8kSfvI+dJJWkdDrbtH/wiPw/kTyfLj5PHRJASmcSmyXw
         PG6Gjnjo/qqSiF8vkOf+xOVpCeWuXZylSI8+TeT7pi1iPcSPVGdDdrrPolAz+EEnb3lo
         /EuoDJ30L4uyhsEhk4nVoq0IjpEsU9jjudUv5x4eNMvGauJBjZH56+uyajmWaGSfXRhz
         e04ppfAYMQGNQHBOpimu5bO1hvQdVWSEn1KnTLHlXK91ruAEOOtu0P5SsZxQv8DmR84+
         AmDA==
X-Gm-Message-State: AOAM530cy3xd/XxOuwqd3o8AZC+GU5+SODxakeUus1G11A+wpfXlSjH1
        BhCPNVWaUQYr8Lco+2Dk+bRU61Jnbuf2xVaOf+N6LQ==
X-Google-Smtp-Source: ABdhPJw5EMlZ2AtRwL99MLJuH8cQy6gfiGn2xNzO1c+09YeQxhf5xOt/ZHongEMMOoo1+Yg3FJeqgp4hisY4vJzlurE=
X-Received: by 2002:aca:4892:: with SMTP id v140mr4795362oia.66.1614900183011;
 Thu, 04 Mar 2021 15:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com> <20210223023542.2287529-1-jiancai@google.com>
 <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
In-Reply-To: <CACRpkdYC3iDD23SESM0j2=f56kr6ByKeedDQvkGwXbUC0br0fw@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Thu, 4 Mar 2021 15:22:51 -0800
Message-ID: <CA+SOCL+M5YfhygG=ogqvqp7y40v+32RiteGr=53THzwvdGugyA@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: Implement SLS mitigation
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
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

On Wed, Mar 3, 2021 at 7:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Feb 23, 2021 at 3:36 AM Jian Cai <jiancai@google.com> wrote:
>
> > This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> > -mharden-sls=all, which mitigates the straight-line speculation
> > vulnerability, speculative execution of the instruction following some
> > unconditional jumps. Notice -mharden-sls= has other options as below,
> > and this config turns on the strongest option.
> >
> > all: enable all mitigations against Straight Line Speculation that are implemented.
> > none: disable all mitigations against Straight Line Speculation.
> > retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> > blr: enable the mitigation against Straight Line Speculation for BLR instructions.
>
> I heard about compiler protection for this, so nice to see it happening!
>
> Would you happen to know if there is any plan to do the same for GCC?
> I know you folks at Google like LLVM, but if you know let us know.

I think gcc also has these options.
https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html

>
> > +config HARDEN_SLS_ALL
> > +       bool "enable SLS vulnerability hardening"
>
> I would go in and also edit arch/arm/mm/Kconfig under:
> config HARDEN_BRANCH_PREDICTOR add
> select HARDEN_SLS_ALL
>
> Because if the user wants hardening for branch prediction
> in general then the user certainly wants this as well, if
> available. The help text for that option literally says:
>
>  "This config option will take CPU-specific actions to harden
>    the branch predictor against aliasing attacks and may rely on
>    specific instruction sequences or control bits being set by
>    the system firmware."
>
> Notice this only turns on for CPUs with CPU_SPECTRE
> defined which makes sense. Also it is default y which fulfils
> Will's request that it be turned on by default where
> applicable. Notably it will not be turned on for pre-v7 silicon
> which would be unhelpful as they don't suffer from
> these bugs.

Thanks for the suggestion. I will update the patch.

>
> Reading Kristofs compiler patch here:
> https://reviews.llvm.org/rG195f44278c4361a4a32377a98a1e3a15203d3647
>
> I take it that for affected CPUs we should also patch all assembly
> in the kernel containing a RET, BR or BLR with
> DSB SYS followed by ISB?
>
> I suppose we would also need to look for any mov PC, <>
> code...
>
> I guess we can invent a "SB" macro to mimic what Aarch64 is
> doing so the code is easy to read. (Thinking aloud.)
>
> Yours,
> Linus Walleij

Return-Path: <SRS0=rJXW=IE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E5C433E6
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Mar 2021 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A175B64E25
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Mar 2021 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCFM2c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Mar 2021 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCFM2H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Mar 2021 07:28:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADEC06174A
        for <linux-security-module@vger.kernel.org>; Sat,  6 Mar 2021 04:28:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d3so10520672lfg.10
        for <linux-security-module@vger.kernel.org>; Sat, 06 Mar 2021 04:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRTQ//F7vNrpXNh19Edx5ubUS+rURU5261q44/OgIzo=;
        b=KvukWuCfw83vo46oTWeRvFRZJgMeXNa9R0A/STP7d8ctuY79MRLKWQhVOxJJIqoCYX
         tMH6Q/wxfEi7I7xqcQlIkgsmSiZ0CdG9/v9qWJ4nLwDqK+O1I5nBWRZG9N1bsGk40V3a
         +SEg3EO45uAs7SODjiHGH7Z0PtjnAflKuDcz0D//DOA/Mttjxb8uHpeVW1JnfajBBktZ
         9cBU6cMH3nRcJE2Cnb5nJJmCA0ciQyBDxNBsgGuJSLCSBWmeXMyy8EE/7PxTnV5cQZFs
         8DOYjK+SXog/ZIYmXtUBNTRuUa1Os82J1UA6imBqvE8XasbNntNtFLazG2jCjPY9x++h
         0KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRTQ//F7vNrpXNh19Edx5ubUS+rURU5261q44/OgIzo=;
        b=Hg4OHwonU6Y1c+iSS15XvtcwOtf6hHCW835Jwzz11NS433F2a19GlZRdSXZP1yyV79
         soOQvcpiYDAWrC2BOvFscau+wQh8mD0z76g6hsiz5p6PkIRRJeBb14b3z0i9w8WJr/+S
         /kNGx40sUF7/wmDv0wMNtfBaBJie+8INiJirIxNS9SqiIba8Frq73+SURWHOr0A2caPq
         MRDVTHtaj07z7sxvMtNr3F9FabJ4fp4dHRvZGSGLQbgP5luZUl3v93vP0wNttTRcRJwM
         ucEvymUtBiwuK+sU6qXP5DCqdyL60ztvmCTUo+qxHftoZVjidSqLFL8u0RNfCo+b2gui
         TJDg==
X-Gm-Message-State: AOAM531oSLHPtK+jvKwTgoDjLo0HAk1OeFdJurYJLdspWX4PFowZBrX8
        G/Y60lJvmTQBkSaycH22ZzpFvkgOmbxlAKp3VcmrdA==
X-Google-Smtp-Source: ABdhPJxsezPXGG6d12GtIidYiYpxjWCDPotp7me8at3R92BahOlAU/jM8vd+0ieMIEF2d72FZB6fanVHn8PZlBWLfmA=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr9045702lfe.29.1615033685580;
 Sat, 06 Mar 2021 04:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20210223023542.2287529-1-jiancai@google.com> <20210305005327.405365-1-jiancai@google.com>
 <20210305095256.GA22536@willie-the-truck>
In-Reply-To: <20210305095256.GA22536@willie-the-truck>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 Mar 2021 13:27:54 +0100
Message-ID: <CACRpkdYioQs4poAbUp1zCennOfFhGEY59q3Qht6s9NC0fOUNEg@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: Implement SLS mitigation
To:     Will Deacon <will@kernel.org>
Cc:     Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Joey Gouly <joey.gouly@arm.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 5, 2021 at 10:53 AM Will Deacon <will@kernel.org> wrote:

> I still don't see why SLS is worth a compiler mitigation which will affect
> all CPUs that run the kernel binary, but Spectre-v1 is not. In other words,
> the big thing missing from this is a justification as to why SLS is a
> problem worth working around for general C code.

I might be on the Dunning Kruger-scale of a little knowledge is dangerous
here, but AFAICT it is because it is mitigating all branches that result
from the compilation.

I think the people who devised this approach didn't think about the
kernel problem per se but about "any code".

They would have to go back to the compilers, have them introduce
a marker instead for each branch or return, and then emit symbols
that the kernel can run-time patch to mitigate the vulnerability.
Something like that. (I guess.)

Notice that these symbols/pointers would first have a
footprint impact, though maybe they could be discarded if
not applicable.

The patch says:

   It inserts speculation barrier sequences (SB or DSB+ISB
   depending on the target architecture) after RET and BR, and
   replacing BLR with BL+BR sequence.

How would you do that at runtime? If you slot in NOPs
around the branch for mitigating, there will still be impact.
If you want to make the code look the same unless vulnerable,
you would have to patch the branch with a branch to another
place to do the barriers... that patched branch in turn could
be speculated? I feel stupid here. But I guess someone could
come up with something?

So instead of a simple straight-forward solution that becomes a
really complicated awkward solution that generate a few thousand
more man-hours and delays the mitigations. So I understand if
the authors would want to try the simple approach
first.

It may however be our job to say "no, go do the really
complicated thing", I guess that is what you're saying. :)

Yours,
Linus Walleij

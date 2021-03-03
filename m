Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6298EC43333
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DC064F4D
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhCCX7s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383656AbhCCPdD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 10:33:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745DC06175F
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 07:31:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y12so16288631ljj.12
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7aMRHBSl7NHJrCVQqtGWHia3CjmS5YDu6hw58y3144=;
        b=hkdy5FBkaxL7oFI9pp6BeMVjXk1o2Zt23WsIuuhAsSqtfX/Lkdh5QXZgzfKaUqS23u
         K1jHi7CUCZWk0Tkq6ilWcqzhkppJcMDQOoYIxXUmwHI2+IaLdiUHbPxeswfkA7qqhSpS
         pKYdrnKYGY5zt2oWiN6416OdUPfJu0fiXi//jCyntJwgs/F1zHyBTUmwr/An0H1g3sMV
         oJZt/kEFBbGvwmrsSdX3jRgJWTFiUjUTu25FSHX53XSGUD5hVjhAwZSTTuH+ALJIyY0M
         cN/yOfXiA+5ZEUP7GtBNG6upTHFbP7F3jvQDN5n5C09CWxqFX03vtp9XWckYZv0S1u+e
         aPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7aMRHBSl7NHJrCVQqtGWHia3CjmS5YDu6hw58y3144=;
        b=WTlYCP1z9ncztyhhTGvqCQuCKz3ikxn6lzsu/u/RHyR/ZSTt7eJbS1k61AemDkiKpX
         4ub54ACTfB9M0oOC5i3gB+HjVOVC6Zrs9ciLvgxtcZfbIuNrsVuvbXWodK9URp4cAHNO
         b05Jk+6zIgAHBjHl5h01kNLvX3+Y9EzLsyuxxgrhmakmlwXnQO6wP6MEsMMQXpU4CEEv
         0YfJ6o1wMRsf1+Y14a0vlQuP+eFJHvFEv52zRBWJq3olJnUQ7s/+2Iw3XnFC100+zb43
         X/3Mae0la7lahx/erPMN5V99uQJT+kOayUrMUAGHo1O3txo9JKP0TKzcHLIYle2S8e7U
         dUhA==
X-Gm-Message-State: AOAM5304+WpKJ1pwrYeV7utLt+/Opr1W0hue0H0BTd8GsX4ALPMetPjv
        rCoYhfl3tBxv31DvE6M3asDAB97X7xel+aGi9qiggg==
X-Google-Smtp-Source: ABdhPJzAav+i0MnJO4TXhlAbYWsXCSj1Sqlgf1GE1KDm/iMLl0vYd0ihsE6lM2OO6Q6m4gLeLJTMLiHnS0JztKnAFus=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr14866199ljj.467.1614785512273;
 Wed, 03 Mar 2021 07:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20210219201852.3213914-1-jiancai@google.com> <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck> <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
 <20210223100453.GB10254@willie-the-truck> <CACRpkdYaSEb8bAztR-s_K17K+Zqusiofwa_dSjz-cwM2+N=57A@mail.gmail.com>
 <49e8725f29ab4ecda6d669e9216bca29@AcuMS.aculab.com>
In-Reply-To: <49e8725f29ab4ecda6d669e9216bca29@AcuMS.aculab.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:31:41 +0100
Message-ID: <CACRpkdYM3x6pJU3Vi+EEHtC3wD1DkrtVbGDd3PFHWL0fxjSA9g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
To:     David Laight <David.Laight@aculab.com>
Cc:     Will Deacon <will@kernel.org>, Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 3, 2021 at 4:29 PM David Laight <David.Laight@aculab.com> wrote:
> > On Tue, Feb 23, 2021 at 11:05 AM Will Deacon <will@kernel.org> wrote:

> > I wrote some suggestions on follow-ups in my reply, and I can
> > help out doing some of the patches, I think.
> >
> > Since ARM32 RET is mov pc, <>
> > git grep 'mov.*pc,' | wc -l gives 93 sites in arch/arm.
> > I suppose these need to come out:
> >
> > mov pc, lr
> > dsb(nsh);
> > isb();
>
> Won't that go horribly wrong for conditional returns?

It will so I would not insert it after those. It has to be
on a case-by-base basis, I am not planning any
search and replace operations.

Yours,
Linus Walleij

Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5A0C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Mar 2021 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3591C61864
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Mar 2021 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhCYOCD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Mar 2021 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCYOBd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Mar 2021 10:01:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E11C06175F
        for <linux-security-module@vger.kernel.org>; Thu, 25 Mar 2021 07:01:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b83so2652960lfd.11
        for <linux-security-module@vger.kernel.org>; Thu, 25 Mar 2021 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmF8zMMhSJr2UbOoYiZqtv8YBPrRUBEDP7fTi81KAEk=;
        b=ySCJ54ICDE6200wEeFqVJv/p1kR197zEWndwv2ypByqKlhCXXhWFp8/SLHr5XEWYN8
         97L3YlomdDH9+yIicnZJt0XCSWZ6LfsEGo/Uc10dXf8YhTttlLJfGwIJqy3mVtxTlp7B
         1/Ct2gYKCrxR/T7G4+DrDJLfyfIGAgXqUpTEb3DE1U7OdVSRn2JS46gpwUF3/VektYED
         cviJesFIXSxfUFqjNV5JtVZZGXZPZZpUt4UAND002egeiXa+uOEXrcLommLqWcVX8vxx
         UzN20W0zHk8DABO2nVpledwJz2npmWit2ZxuobV51siQhqslP3p/LYZae6ZeZx3BUUf8
         f5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmF8zMMhSJr2UbOoYiZqtv8YBPrRUBEDP7fTi81KAEk=;
        b=t4JMFLGUBCugEbLhbZkU0a3MsOaeLwiEr2F5WrzFT8gaD+LCpn7LcTEGG4nmJ0P3Gx
         9blXxBoQzlJJLIQwXsUt3QO6880kIVUrq3IUJIjB84GXqr8cwctYwwcwcCfOWNJnhFox
         /24Ti0XeIPYxw78/i2S4yR7WE6PxjXzXWP6mj+03xgddU0BXKKhk+5mYNgB+JYIh02CP
         XJuRvFrFNU/7Vi7aUb/QkYtfKO4Hnv2dNNKOW4MQw5eUvjyBH+SOTuEnzejneLtt4nSl
         cSFmlwwS9agL5SOkhQd4rb+49RkFuRLcmAM48kkfmaj/tGuNg9HMpIrgb3fSEvcl8Ko3
         NS4w==
X-Gm-Message-State: AOAM532A0eLYk+I0sv+nqDdzk54u9vgalrsY2Sq6Qw6o7bXS4cIfsSea
        Vp/qxqI4OiNTUquMTfqGkm6yT3A68ZE1+BIbRKCclg==
X-Google-Smtp-Source: ABdhPJwN9qo9jK5N4Qbvi4l62f5Ye52sRZLOgrlXWLb5uvDKoV3liGbEnF0y5GhyhtVdQ0++fd/nRNIdObtNPuZNGvU=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr4917148lfa.157.1616680886895;
 Thu, 25 Mar 2021 07:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com>
 <20210212195255.1321544-1-jiancai@google.com> <20210217094859.GA3706@willie-the-truck>
In-Reply-To: <20210217094859.GA3706@willie-the-truck>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 15:01:15 +0100
Message-ID: <CACRpkdYHXrMPtkG09x9tscBzp2O=Ps-8m_03J6DcBnYcQuvWGg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Implement Clang's SLS mitigation
To:     Will Deacon <will@kernel.org>
Cc:     Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Kristof Beyls <kristof.beyls@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Will,

I went back and found this feedback which is kind of the heart of the
issues regarding SLS.

On Wed, Feb 17, 2021 at 10:51 AM Will Deacon <will@kernel.org> wrote:

> The big problem I have with this is that it's a compile-time decision.
> For the other spectre crap we have a combination of the "mitigations=off"
> command-line and CPU detection to avoid the cost of the mitigation where
> it is not deemed necessary.

For newcomers, the way this works today can be found in e.g.:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/proton-pack.c
mitigations=off turns off Spectre v2 and v4 mitigations.

AFAICT this is achived with misc parameterization to firmware
and hypervisors and no runtime-patching of any code
at all?

(On ARM32 it has no effect whatsoever, we just turn on all
spectre v2 mitigations by default. No runtime choice.)

The way I understand it is that for SLS the compiler must at least
put in some kind of placeholders, but that it *might* be possible to do
runtime mitigations on top of that.

We need feedback from the compiler people as to what is
possible here.

If it is *not* possible to mitigate at run-time, then I don't know
what is the right thing to do. Certainly not to turn it on by default
as is done today?

> So I think that either we enable this unconditionally, or we don't enable it
> at all (and people can hack their CFLAGS themselves if they want to). It
> would be helpful for one of the Arm folks to chime in, as I'm yet to see any
> evidence that this is actually exploitable.
(...)
> Is it any worse that Spectre-v1,
> where we _don't_ have a compiler mitigation?

There is such a compiler mitigation for Spectre v1, under
the name "Speculative load hardening" the kernel
is not (yet) enabling it.

https://llvm.org/docs/SpeculativeLoadHardening.html
it comes with the intuitive command line switch
-mspeculative-load-hardening

Certainly a separate patch can add speculative load
hardening support on top of this, or before this patch,
if there is desire and/or feels like a more coherent
approach.

As the article says "The performance overhead of this style of
comprehensive mitigation is very high (...) most large applications
seeing a 30% overhead or less."

I suppose it can be enabled while compiling the kernel just
like this patch enables -mharden-sls=all

I don't know if your comment means that if we enable one
of them we should just as well enable both or none as
otherwise there is no real protection, as attackers can
just use the other similar attack vector?

> Finally, do we have to worry about our assembly code?

AFAICT yes, and you seem to have hardened
Aarch64's ERET:s which seemed especially vulnerable
in commit
679db70801da9fda91d26caf13bf5b5ccc74e8e8
"arm64: entry: Place an SB sequence following an ERET instruction"
Link for people without kernel source:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=679db70801da9fda91d26caf13bf5b5ccc74e8e8

So it seems the most vulnerable spot was already
fixed by you, thanks! But I bet there are some more
spots.

Yours,
Linus Walleij

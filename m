Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0668FC433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E851E61078
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 19:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbhIGTRu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTRt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Sep 2021 15:17:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F6C061575
        for <linux-security-module@vger.kernel.org>; Tue,  7 Sep 2021 12:16:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h16so5086lfk.10
        for <linux-security-module@vger.kernel.org>; Tue, 07 Sep 2021 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fpdy3b2qMHUETeuDFTFbKg8FYwDRtrIQO5YjCA4iis=;
        b=gvtqQqQ0P76l17nNx5gKAZmX9q0gXmkKiJplZ5GrV0Rp5D/GmeTFvutVYxXDmohdU0
         Rg7GZWtGpo79LRFlloX9NBLbD7hga1UGVHT5sYVxcyx+e++dSBWbGFVZEFJrEiiMD80f
         lT+vaaeWPC4g7dOg7Pm63HBqJdzPD3ESYM7uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fpdy3b2qMHUETeuDFTFbKg8FYwDRtrIQO5YjCA4iis=;
        b=ZzyIymv3UuwQ+8xtNRgJ1JdGMmDO4k/0+TVdPW6mSjB/2g8QdihoGRcTYYsBjl5gw0
         BU+ppsIMvRdwp8ckrN5deNsdHnQBzJCwM8uRSxS8Dq49aGMM5dIGaF6vKLVhvD0Q5jIX
         jG+lv9A0ztoADOIWiAaq2GaKD17Z1CW4TZNRS6ltnGhGAdzhCu3boYq5EX305K0TvOKE
         szdYMzstzUHU2hi+EEVVhHd2pQtc1nUtU4nN5v9unpopbLQRYJS1xK5eurFE6EvU2f/A
         sS13rVhOcBliuJ1lqkxW6OKFHww4aC7sfHI7jZZ2wZunHSAq0PrppQI6a6gMsbZAOCfT
         1y9A==
X-Gm-Message-State: AOAM5327uG60bsbu7SGc7KPcDHglLTE3JYo6Ykb+WWRLm219uEuRf/zH
        WsBYz/CsBAjN2aHLKV0zlcuKubGnO3OziANr7K0=
X-Google-Smtp-Source: ABdhPJy6NT0N22GmldgJI80JekbOWpvrMsaeGzGy1nUg8sCC5yS2DbpkBy+P+aMB+BJqoRQxlsByaQ==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr13775948lfe.49.1631042200283;
        Tue, 07 Sep 2021 12:16:40 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v15sm1085265lfq.142.2021.09.07.12.16.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 12:16:38 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c8so82534lfi.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Sep 2021 12:16:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr14175340lfv.655.1631042198154;
 Tue, 07 Sep 2021 12:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210907183843.33028-1-ndesaulniers@google.com>
In-Reply-To: <20210907183843.33028-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 12:16:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
Message-ID: <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Enable '-Werror' by default for all kernel builds"
To:     Nick Desaulniers <ndesaulniers@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 7, 2021 at 11:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The above commit seems as though it was merged in response to
> https://lore.kernel.org/linux-hardening/CAHk-=wj4EG=kCOaqyPEq5VXa97kyUHsBpBn3DWwE91qcnDytOQ@mail.gmail.com/.

No. It was merged in response of _years_ of pain, with the last one
just being the final drop.

I'm not going to revert that change. I probably will have to limit it
(by making that WERROR option depend on certain expectations), but
basically any maintainer who has code that causes warnings should
expect that they will have to fix those warnings.

If it's clang that generates bogus warnings, then we'll have to start
disable clang warnings. The clang people tend to be proud of thir
fewer false positives, but so far looking at things, I am not
convinced.

And I'm most definitely not convinced when the "let's finally enable
-Werror after years of talking about it", people end up going "but but
but I have thousands of warnings".

That's the POINT of that commit. That "but but but I have thousands of
warnings" is not acceptable.

I spent hours yesterday getting rid of some warnings. It shouldn't be
on me fixing peoples code. It shouldn't be on me noticing that people
send me crap that warns.

And it really shouldn't be "Linus cares about warnings, so
configurations that Linus doesn't test can continue for years to have
them".

My "no warnings" policy isn't exactly new, and people shouldn't be
shocked when I then say "time to clean up *YOUR* house too".

            Linus

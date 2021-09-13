Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4133C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A873610CF
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 17:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbhIMRvk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbhIMRvk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 13:51:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10067C061574
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 10:50:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b10so16133208ejg.11
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fXusuKKh/e5rHl3WvKLT7/eIYqq9n/M32FO5AEfQZ4=;
        b=Bb8jIWZyUA2JnH1dNvqA8PhazKDoFToI8m/EWHAoOqKLNqV8zTPjzKX6vSeXFJuKyf
         tIz9q+4BcBJIZrm/Iu+TQqerdjnjQiXXxiZVROuzlUAiYHdpJ05Qtsggzr+XxSztzHDf
         1zrSjLLUXzKthlfdL5NA8jPU2NHbiFKkxBxww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fXusuKKh/e5rHl3WvKLT7/eIYqq9n/M32FO5AEfQZ4=;
        b=s8Y3gh1MtAEfhONr7wc71wQ8A9n1L2aM16ShTKD39plOZ6BS1rx1iGhMjpzPOhFaqy
         wXOhbrgzGTX7VsONgFOckPyUzoVILiaovrDHgCLsQece82YH/Xv4bJpyYesAK/1DzGsb
         F9Y3804wFC0W35B8orwIwUv7yRujIr0vcXEXSBDqxXE2KAuM8npe/BpbR8xqI215Y3g3
         M1UiFZTbblHD2HeGCYLMnCSpHTK74FS6ZKtdFJHJHcDyRHBki5vdJz1S8F4ZVQbv9Ik6
         jczHBq+F5ilZ2NaBMqbC/nj9XGWhI6fi5xTE0t2KNtfQd9/X8sfXoXaYGmqaQRwO0hA+
         uEjg==
X-Gm-Message-State: AOAM53187UzUrrs5b6chNm2hpB+nPi4V6vT/mQJwXspdsqpYzgSLdpFW
        L4tha0zuS98QlIqOrwHDgV5GF3NVw5AJgDb+EcQ=
X-Google-Smtp-Source: ABdhPJyep7xyAwazYOOdFHApNZaa/IjZq4YIfjDv6iUJy6iSM7lc9paNhnLh+9hXUaRmrU+x/3Avmg==
X-Received: by 2002:a17:907:7844:: with SMTP id lb4mr13918814ejc.381.1631555422415;
        Mon, 13 Sep 2021 10:50:22 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id k12sm4171721edo.9.2021.09.13.10.50.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:50:22 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id i21so22879338ejd.2
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 10:50:22 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr11735241ljv.249.1631554960750;
 Mon, 13 Sep 2021 10:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210907183843.33028-1-ndesaulniers@google.com>
 <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
 <CAKwvOdkuYoke=Sa8Qziveo9aSA2zaNWEcKW8LZLg+d3TPwHkoA@mail.gmail.com>
 <YTfkO2PdnBXQXvsm@elver.google.com> <CAHk-=wgPaQsEr+En=cqCqAC_sWmVP6x5rD2rmZRomH9EnTQL7Q@mail.gmail.com>
 <c8fb537f-26e5-b305-6bc5-06f0d27a4029@infradead.org> <20210913093256.GA12225@amd>
 <87a6kgerdk.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87a6kgerdk.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 10:42:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7M1_BXG2MXLv4OhjzjV-opy=5fE7+vafW5fHOyDrg+w@mail.gmail.com>
Message-ID: <CAHk-=wj7M1_BXG2MXLv4OhjzjV-opy=5fE7+vafW5fHOyDrg+w@mail.gmail.com>
Subject: Re: [PATCH] Revert "Enable '-Werror' by default for all kernel builds"
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev,
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

On Mon, Sep 13, 2021 at 2:50 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> But there are also warnings which are emitted by the GCC middle-end (the
> optimizers), and turning on -Werror for those is very problematic.

People say that, but let's face it, that's simply not true.

There are real problematic warnings, and we just turn those warnings
off. People who want the self-flagellation can enable them with W=1
(or bigger values), and spend their life fighting stupid random
compiler warnings that have tons of false positives.

But the fact is, I've required a warning-free build on x86-64 for
anything I notice for the last several years by now, and it really
hasn't been a problem.

What _has_ been a problem is that (a) build bots don't care about and
(b) the configs I don't personally test (other non-x86-64
architectures stand out, but there's certainly been other
configuration issues too).

But "bogus compiler warnings" is very much *not* in that list of problems.

I've looked at a lot of the warnings that are now errors, and while a
number of them have made me go "So why didn't we see that on x86-64?"
not one of them has actually made me go "-Werror was wrong".

Because EVERY single one I've seen has been for something that should
have been fixed. Presumably long long ago, but the warning it
generated had been ignored.

So stop with the "some warnings just happen" crap. Outside of actual
compiler bugs, and truly stupid warnings (that we turn off), that's
simply not true.

And yes, those compiler bugs happen. The new warning already found one
issue with current gcc trunk (non-released). So right now the count is
"lots of valid warnings, and one compiler bug that was found _thanks_
to me enabling -Werror".

Yes, we have issues with having to work around older compiler bugs.
Those aren't going away, and yes, -Werror may well mean that
non-x86-64 people now have to deal with them.

And yes, this is painful. I'm very much aware of that. But we just
need to do it. Because the warnings don't go away on their own, and
not making them fatal clearly just means that they'll stay around
forever.

           Linus

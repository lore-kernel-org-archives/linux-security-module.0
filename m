Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A5C64EC4
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 01:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCDB3y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCDB3x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Mar 2023 20:29:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32060D5E
        for <linux-security-module@vger.kernel.org>; Fri,  3 Mar 2023 17:29:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x3so17090718edb.10
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 17:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677893390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojXXPezHnTj/nJEULaE+dKCCVgGQ8e1VodiuDXnPVj0=;
        b=gB+wzeeBpnsPVMJFZSF6NgLsvY7qw5xRPrwFqXafeHBUK2TQP0fBzq5UcfFKCIgz0r
         zGnAZTV7yRegzou4XTWSBI1oQbHPoAMbw2pzpGf0rpwSC0Vc9IXax1WQVWir6fYpJiYo
         uiKVn9LOvy+v9Tt9/fFoqOdbeJy7OmKGg6gqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677893390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojXXPezHnTj/nJEULaE+dKCCVgGQ8e1VodiuDXnPVj0=;
        b=H6britweIi7mUVukOvhRDVAzpk7NFhcdfhb7V3akasGAW87KLIPTXSubFSLvMuCXKt
         hiY4fOKPnNgfpJvUD6kMZrOMj9N5LeMhGzrrEe5DTgPzSCUMkreErhcXc5036FqFPG8A
         0B6c8kWXtLYKePE2kjSxp3BJR05BmdqxXgppLsGASV7ykUwVYHY+kuzE6/GtHhushtS/
         /wEIWH5YshiQkHz6DvgR7PH2MTvJuSRnVwMNd2GKCdoBg9USKXjVy4IiYdppaxtWYLGf
         pb/SxN5LswwkcEeVV4lGG2lQlWkFlTsDgrVJJJR3vBYGpluKFnDEG5SAVKUxe+tVhOUX
         8/Eg==
X-Gm-Message-State: AO0yUKXRuSNIal4zDZ9UVhnD9/47wJ3BxWuChvhs4kluLanYif14VArC
        ybXu/2ojUoAmLVLPRGPHk/wJCsDhUb53fnWtgiHCXw==
X-Google-Smtp-Source: AK7set+VC20Pdwchykm+QTmXUsKdTqqoo+EpOZKhlnjipCZIWuPCEmBKZlvlrYMFoqPpARPttzs8yQ==
X-Received: by 2002:a17:907:6eab:b0:86f:64bb:47eb with SMTP id sh43-20020a1709076eab00b0086f64bb47ebmr4347259ejc.3.1677893390762;
        Fri, 03 Mar 2023 17:29:50 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id v30-20020a50955e000000b004bf2d58201fsm1816762eda.35.2023.03.03.17.29.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 17:29:48 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id o12so17150102edb.9
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 17:29:48 -0800 (PST)
X-Received: by 2002:a50:bae3:0:b0:4c0:ef64:9299 with SMTP id
 x90-20020a50bae3000000b004c0ef649299mr2172186ede.5.1677893387987; Fri, 03 Mar
 2023 17:29:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com> <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
In-Reply-To: <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 17:29:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
Message-ID: <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 3, 2023 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> as an example here is a one-liner to show crappers which do 0-sized ops:
> bpftrace -e 'kprobe:memset,kprobe:memcpy /arg2 =3D=3D 0/ { @[probe,
> kstack(2)] =3D count(); }'

Looking not at 0-sized ops, but crazy small memset() ops, at least
some of these seem to have grown from the bitmap "optimizations".

In particular, 'cpumask_clear()' should just zero the cpumask, and on
the config I use, I have

    CONFIG_NR_CPUS=3D64

so it should literally just be a single "store zero to cpumask word".
And that's what it used to be.

But then we had commit aa47a7c215e7 ("lib/cpumask: deprecate
nr_cpumask_bits") and suddenly 'nr_cpumask_bits' isn't a simple
constant any more for the "small mask that fits on stack" case, and
instead you end up with code like

        movl    nr_cpu_ids(%rip), %edx
        addq    $63, %rdx
        shrq    $3, %rdx
        andl    $-8, %edx
        ..
        callq   memset@PLT

that does a 8-byte memset because I have 32 cores and 64 threads.

Now, at least some distro kernels seem to be built with CONFIG_MAXSMP,
so CONFIG_NR_CPUS is something insane (namely 8192), and then it is
indeed better to calculate some minimum size instead of doing a 1kB
memset().

But yes, it does look like we've had several regressions in various
areas, where we do insane "memset()" calls with variable size that
should never have been that. Both with kzalloc() and with cpumasks.

There are probably lots of other cases, I just happened to notice the
cpumask one when looking at "why is there a memset call in a function
that shouldn't have any at all".

I don't think this is a "rep stos" problem in general. Obviously it
might be in some cases, but I do think that the deeper problem is that
those small memset() calls generally should not have existed at all,
and were actual bugs. That cpumask_clear() should never have been a
function call in the first place for the "clear one or a couple of
words" case.

The kernel very seldom acts on byte data, so a memset() or memcpy()
that looks like individual bytes is some very odd stuff. We have lots
of often fairly small structures with fixed sizes, though. And maybe
there are other cases like that bogus "let's try to optimize the
bitmap range"...

Of course, then we *do* have distros that do actively detrimental
things. You have Ubuntu with that CONFIG_INIT_ON_ALLOC_DEFAULT_ON, and
if I didn't just rebuild my kernel with sane config options, I'd have
Fedora with CONFIG_MAXSMP that is meant to be a "check worst case"
option, not something you *use*.

Oh well.

          Linus

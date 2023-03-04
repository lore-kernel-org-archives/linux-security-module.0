Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2AC678DB
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 20:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCDUs2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Mar 2023 15:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCDUs1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Mar 2023 15:48:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96EACA1D
        for <linux-security-module@vger.kernel.org>; Sat,  4 Mar 2023 12:48:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id da10so23677238edb.3
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677962905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn2gZXKlQFGR+IhNp/0q9B10wC8MYWo3Xkj5MLWqjns=;
        b=dJtwGIMLUvRVLfyftU83pXDQ7ZHeelQh9GKUmyXSKtJeY3w4b312g5jt3ZndGIk/1O
         o7cFw1LXjGZtGD940+EOSfSvH8B4OsfTM9OHbsFssJ2p0NL2mORe0tL+ByQcH0geWJwy
         EM3CjLMmA/BxyrLWut5Hg5wT7BCb4ocNQoaAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677962905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn2gZXKlQFGR+IhNp/0q9B10wC8MYWo3Xkj5MLWqjns=;
        b=5BVE5kNw82BIJ9X35ah9suA6DN4/u0RwmeMqW+UwMzajGrP6/NNaeWW0tX9tLocStd
         X7wMt/YfkBK6HibGdhF925XQH7nrycGYMseirza9icA/8dG8wNiEimwKVAJy1kRIaaiB
         CKjjs+ncdkUIbnu5W7RFPL6aRq+16QmRljt4dw91dfO0CAd2+iYXCQhE/LL83pNUuvR0
         jS4WyQeBvlpzOSEn0/TWsMKxwXzOt/qAeMz1rOb5lIEnNzDwkxulXPrx/J94bxYZffMm
         ECDmrPVQUaVw1U2NPHQsh7twq33JNuD9lsnahr7HT5AEwEZY+OA8wPrTOIGD4yOZFGAl
         GL4Q==
X-Gm-Message-State: AO0yUKUQcUIWu4S770K5iaNf2CwGhBUbA4NoWh/7LeTjUf8Y3MSdggHT
        KN+iKd8Ug3MadKIFSzYGJBrxUaJHi7U9OdIa97uEmA==
X-Google-Smtp-Source: AK7set9F6DslsjXEjRoGhc8hQNmhISjd67qx62Hq+ebF1sX/6PPuXTTBUfN+hUGfIZrGeEZ4mrGLtw==
X-Received: by 2002:a17:907:a80f:b0:8b1:3a18:9daf with SMTP id vo15-20020a170907a80f00b008b13a189dafmr5716313ejc.74.1677962904784;
        Sat, 04 Mar 2023 12:48:24 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id lc9-20020a170906f90900b008e34bcd7940sm2392967ejb.132.2023.03.04.12.48.23
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 12:48:24 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id o12so23536092edb.9
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 12:48:23 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr2818736eju.0.1677962903549; Sat, 04 Mar
 2023 12:48:23 -0800 (PST)
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
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgz51x2gaiD4=6T3UGZtKOSm3k56iq=h4tqy3wQsN-VTA@mail.gmail.com>
 <CAGudoHH8t9_5iLd8FsTW4PBZ+_vGad3YAd8K=n=SrRtnWHm49Q@mail.gmail.com> <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
In-Reply-To: <CAGudoHFPr4+vfqufWiscRXqSRAuZM=S8H7QsZbiLrG+s1OWm1w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 12:48:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
Message-ID: <CAHk-=wh17G6zo6Rfut++SHzDgXdvtrupfSX+bNL08v=LpHU0Lg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>, Borislav Petkov <bp@suse.de>
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

On Sat, Mar 4, 2023 at 12:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Good news: gcc provides a lot of control as to how it inlines string
> ops, most notably:
>        -mstringop-strategy=3Dalg

Note that any static decision is always going to be crap somewhere.
You can make it do the "optimal" thing for any particular machine, but
I consider that to be just garbage.

What I would actually like to see is the compiler always generate an
out-of-line call for the "big enough to not just do inline trivially"
case, but do so with the "rep stosb/movsb" calling convention.

Then we'd just mark those with objdump, and patch it up dynamically to
either use the right out-of-line memset/memcpy function, *or* just
replace it entirely with 'rep stosb' inline.

Because the cores that do this right *do* exist, despite your hatred
of the rep string instructions. At least Borislav claims that the
modern AMD cores do better with 'rep stosb'.

In particular, see what we do for 'clear_user()', where we effectively
can do the above (because unlike memset, we control it entirely). See
commit 0db7058e8e23 ("x86/clear_user: Make it faster").

Once we'd have that kind of infrastructure, we could then control
exactly what 'memset()' does.

And I note that we should probably have added Borislav to the cc when
memset came up, exactly because he's been looking at it anyway. Even
if AMD seems to have slightly different optimization rules than Intel
cores probably do. But again, that only emphasizes the whole "we
should not have a static choice here".

                 Linus

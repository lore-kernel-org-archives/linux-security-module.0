Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21473C7EE2F
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Mar 2023 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjCCUIY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Mar 2023 15:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCCUIX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Mar 2023 15:08:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339881285D
        for <linux-security-module@vger.kernel.org>; Fri,  3 Mar 2023 12:08:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so14950110edb.3
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677874100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icUeuEqvqPbQnLnoTJFmZqOp/anQ4LMobszRgORXgsw=;
        b=f2MLzsq14+IZ8TyfPiFoG9W1v55K/iJwVqrLY+ExatakJDVAxbzI3HEhLavhUvW88+
         e0OAp1q6aIj6Hr7vee/Jkxfuz5A4MuBoRwjTQbSouqPLRLdC1Mp/P9Rpj5qLX1AaGVGt
         +1dOjBj8u+KCYqfbHCSCkSlfKCWOZirPrNnH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677874100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icUeuEqvqPbQnLnoTJFmZqOp/anQ4LMobszRgORXgsw=;
        b=KH4pn2rZ6FbJpuXoylDGlt4/YR2liy8kXjuRYZPZLBaPyOP82dfgIq59PwuYcPnxd5
         f410B6tG5tAI4HaDtUXOoxuF/rAZhpHsKcxnzJ+86h720Guj429jZFnCg3xYBR2uV0d/
         6dBA9nOpCo3NFJK7972UxUn84hH8wxE7xy/gfQmLBxR4kLJhjR2OmABW64SrXmqPnYrz
         98qRyoLMd7kBK4cmNJ/4XO0GAPrXQFUYzYdLoc9TaKYAp6rJGkgdOe2FSw61OW7n5kE0
         4bnQjVMNBgGTyIVW03LtfgtqsWhL70w4wv5gnqxZwirKmmnYepJGgmz4TEZoeUHtgVKb
         ORxw==
X-Gm-Message-State: AO0yUKWOfBr94GE+XU/zIeVG2uE6wYDCLEDB0dKCJdaAj+SrFf+TBHfO
        SY33n9yM8RIDzK7AGUnK/SuDbnSm7n+hlHwER+g=
X-Google-Smtp-Source: AK7set+GCeldgBzuuxsRdN/CsSamayFQh/Q48xjEczrrsI8zlIxSNFv+M3TIIoha+YKA5Sp+HlPD6w==
X-Received: by 2002:a17:906:a3c3:b0:8f2:5c64:d53b with SMTP id ca3-20020a170906a3c300b008f25c64d53bmr7002521ejb.24.1677874100409;
        Fri, 03 Mar 2023 12:08:20 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090674c100b008e3bf17fb2asm1319274ejl.19.2023.03.03.12.08.19
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:08:19 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id s11so14836632edy.8
        for <linux-security-module@vger.kernel.org>; Fri, 03 Mar 2023 12:08:19 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr1471718eju.0.1677874098906; Fri, 03 Mar
 2023 12:08:18 -0800 (PST)
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
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com> <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
In-Reply-To: <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 12:08:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
Message-ID: <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
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

On Fri, Mar 3, 2023 at 11:37=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> I mentioned in the previous e-mail that memset is used a lot even
> without the problematic opt and even have shown size distribution of
> what's getting passed there.

Well, I *have* been pushing Intel to try to fix memcpy and memset for
over two decades by now, but with FSRM I haven't actually seen the
huge problems any more.

It may just be that the loads I look at don't have issues (or the
machines I've done profiles on don't tend to show them as much).

Hmm. Just re-did my usual kernel profile. It may also be that
something has changed. I do see "clear_page" at the top, but yes,
memset is higher up than I remembered.

I actually used to have the reverse of your hack for this - I've had
various hacks over the year that made memcpy and memset be inlined
"rep movs/stos", which (along with inlined spinlocks) is a great way
to see the _culprit_ (without having to deal with the call chains -
which always get done the wrong way around imnsho).

            Linus

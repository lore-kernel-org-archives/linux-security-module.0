Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD5C678DB
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCDVD3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Mar 2023 16:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCDVD2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Mar 2023 16:03:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7E6D50E
        for <linux-security-module@vger.kernel.org>; Sat,  4 Mar 2023 13:03:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id da10so23754258edb.3
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677963805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc3ttMvepwzFWVo6udVksEFHtSzqK6XOPV7RiZqfde4=;
        b=OVRr1Xtm41f/Vcw9KhdqRl13hClLRcHXk2rZiZ3Qck7HP1jNEgIxGULY0Sb4GJVFGd
         bH8EektFMUsW3uMwDxV5gDamyvJvjxzHGLRA6Ivi2/gmB7JwTmFgoqcrPQgyVOAD5T6j
         A5eLHbfnfikk+mTusCd/h+LXQwxlc4pPJ9tXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677963805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc3ttMvepwzFWVo6udVksEFHtSzqK6XOPV7RiZqfde4=;
        b=khtbXx4tw3yqzzLd6R+PLUy108B0XPPbDGK5Sj+ulS2T1s4RVfoMlmWwKgFIjebFrC
         dSY/CFqW2HSyCaWHmszAKQX0+BP4quBFju2tkYa6It4qYi6Rj3V6KEgGWLgIfU/gAzFP
         PvbHcBDxaYbbBFkjCE36r7MD5BV/WO4WKat01mN2730uQTNwuZjs6bji8SxCZk5qNtsQ
         AwaNkQOsXEVfFm9wNijFM05jlULZFmeGIS0wVT40+LcX4Pq/lg872YsNRD/x9LzIQBAN
         yknxojI5yWylzpAkVI5RoKE66WDFKaS+PTrHYXt1npgkN2zphUIjB90XaF5j6xI/5GlQ
         0YXA==
X-Gm-Message-State: AO0yUKVJEa0nNZpBPJlM1kArBUbcIzjFED/ajjgd2QZ+e1bDX+Nratlz
        b0LPJWTMl2EtBjbxps5d6D25jGHmOMYs5Q1Lb/+ndg==
X-Google-Smtp-Source: AK7set9nscflMh1cYW4CozRnfam160uvAmEhI2CtVtUNpCXGA8R4+ThaYZf94SMIOY8Z8lLjp8qbuw==
X-Received: by 2002:a17:906:4783:b0:8af:2107:6ce5 with SMTP id cw3-20020a170906478300b008af21076ce5mr7164855ejc.35.1677963805379;
        Sat, 04 Mar 2023 13:03:25 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709061d4f00b008b17cc28d3dsm2425523ejh.20.2023.03.04.13.03.24
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 13:03:24 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id a25so23916875edb.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 13:03:24 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr2890993ejb.0.1677963804011; Sat, 04 Mar
 2023 13:03:24 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop> <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
In-Reply-To: <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 13:03:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaJdaKCDaVa0B1wGKYHjnnQMYpf91ze-fTvCdMMchNFg@mail.gmail.com>
Message-ID: <CAHk-=wgaJdaKCDaVa0B1wGKYHjnnQMYpf91ze-fTvCdMMchNFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
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

On Sat, Mar 4, 2023 at 1:01=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Silly useless cases are just that - silly and useless. They should not
> be arguments for the real cases then being optimized and simplified.

There's a missing "not" above, that was hopefully obvious from the
context: "They should not be arguments for the real cases then NOT
being optimized and simplified"

               Linus

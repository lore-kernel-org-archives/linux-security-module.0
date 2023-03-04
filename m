Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CAEC678DB
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 21:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCDVKy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Mar 2023 16:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDVKx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Mar 2023 16:10:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F8F749
        for <linux-security-module@vger.kernel.org>; Sat,  4 Mar 2023 13:10:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so20021370edb.11
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677964250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvqbdnccqQxI74XYqpTTG4hk8zHvB1aY939htM9r+Ro=;
        b=earxbLvpoKcycEyV1mC5LAqrLyw+YOEEASU2OmlZNFe/KkJho1+2az7OyAylurxLKj
         jFSebmJyp9j2GFQqwToWPWHaqLarNJZOVLhNkALiMe2/GKizEk6dk+1L8HCjb2DXOoRO
         UhY1/B8PbnaFmGrFYMorLiPW15KtfvPOKprjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677964250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvqbdnccqQxI74XYqpTTG4hk8zHvB1aY939htM9r+Ro=;
        b=MGp9STsCVeh/nn4TqXyalZISXUktIMxCL+TpFoj2Nh/sGrwUPAQmY3PBaye9xb85q9
         nSu8+yyF7zTpp/xFjA/XM7mUZZlo70DixCjnwco2XuNdpoBJDPX60QIaNTx+xBMlrJP5
         0jepHgFquoB1wtZnrEKygygHT5rxY37uZo4fmCIr7fC7fQpJfznRPZK8fX0Wc/W7+6U0
         J/E2YR8SiLuBecY/wmjBSLUb3XjK8nohgJrcEXRb73EeKQfG2eVFV3l6ptJWgBT49Dyd
         oxGGlNO9Sx1P4OVXS2TXrZUEXrlVd/Rha/M/0Q2cXc/I6gKzp7ClG2yuSzImjnI7lwrH
         h5OA==
X-Gm-Message-State: AO0yUKWNLsMswzKzWVCCYGrH4yiT84BJV4qyBRcp77SKQX5O873ewXQO
        dQh3xCkuOGqc/l+N09WiSbWUwkCYHsBMydJOm/lBJQ==
X-Google-Smtp-Source: AK7set9fPSJ2iKcEgcie6/EKgojXaAHvdXNtgMmhR54Wfp9iyLCGHksbPZ7nHkrn4iQfECrK0u0irQ==
X-Received: by 2002:a17:906:f18a:b0:887:8f6:c1d7 with SMTP id gs10-20020a170906f18a00b0088708f6c1d7mr6308772ejb.38.1677964250560;
        Sat, 04 Mar 2023 13:10:50 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906255700b008d9c518a318sm2471776ejb.142.2023.03.04.13.10.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 13:10:50 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id s11so23680443edy.8
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 13:10:49 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr2690435ejf.0.1677964249715; Sat, 04 Mar
 2023 13:10:49 -0800 (PST)
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
Date:   Sat, 4 Mar 2023 13:10:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
Message-ID: <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
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
> It's still completely untested. Treat this very much as a "Let's make
> the common cases faster, at least for !MAXSMP".

Ok, so I started "testing" it in the sense that I actually looked at
the code it generated, and went all "why didn't it make any
difference".

And that's because the patch had the

  #ifdef CONFIG_CPUMASK_OFFSTACK

condition exactly the wrong way around.

So if somebody actually wants to play with that patch, you need to
change that to be

  #ifndef CONFIG_CPUMASK_OFFSTACK

(and then you obviously need to have a kernel config that does *not*
have MAXSMP set).

That at least simplifies some of the code generation when I look at
it. Whether the end result _works_ or not, I still haven't checked.
That patch is still very much meant as a "look, something like this
should make our cpumask handling much more efficient"

              Linus

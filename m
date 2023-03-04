Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CCC678D5
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Mar 2023 19:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCDTC7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Mar 2023 14:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDTC6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Mar 2023 14:02:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF330E5
        for <linux-security-module@vger.kernel.org>; Sat,  4 Mar 2023 11:02:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so23274097edb.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677956575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nulv/YbaIdsPYIu/TyuXgIK5szxQR3P85oOKBpQEjds=;
        b=Y4jFqiPVN6ZvXlcEWlXhhwV3rOFOosDPDSXZxtf5GfztoSu+Zs4s2m5U0vX4mEXNn0
         GO1jy7LINSCiXz4k304O34u8j6ENpioXQbi9SuFJMaqjcSnJJXl1Q1afefooOlth2Dn1
         ENiInfIbHdNoyUEhYiS3kJGcKAdR7ZjLTksRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677956575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nulv/YbaIdsPYIu/TyuXgIK5szxQR3P85oOKBpQEjds=;
        b=mpg6qsN5wuGx5NAHo4pMtAylfFNNs+zzhpOAh4RZF6QnEUmZGpkKky4VaAg8/kElGk
         CzKAeII83FqHI1ZOflaldBe/lnWotgG+yVgKfqUdqZxkCDidlKyRdtjkOb/2At0q/Woi
         D0FEOTM83tLiL3+RtmJ/BqAK05QHoSoq2M3LqXOf7OQ+Mo+8CDe0lubyEG+JkZFoIDoN
         4idO1t4DH3zyInHg1+6TytF8IFx7hX5Lz7AXezaVoYse1JWXMayEbcH9d7hfC9hvaySU
         pXY85lX5cczvbGphuHkzepVNUSOG2a38L+wUz/97jucUlB721VJFJxghoEXb6/pkqBA1
         KlDA==
X-Gm-Message-State: AO0yUKVvMdcrnaa/xdazhfePFsFqa0mtzyGb+XolrXtLHI/Xs0gOQOep
        /CzhUEIwYK+qDYhoLdVzj+48zhT6qn7OjpPjVNCZkA==
X-Google-Smtp-Source: AK7set+qOZ1MnQFQON6gh6avtdn3ei2UISkznw/S7FUfbtOzwXhvsIiJtfU1T9nGA9xbc73gtPLQrg==
X-Received: by 2002:aa7:c245:0:b0:4ac:c44e:a493 with SMTP id y5-20020aa7c245000000b004acc44ea493mr5312182edo.2.1677956574831;
        Sat, 04 Mar 2023 11:02:54 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id gj14-20020a170906e10e00b008df7d2e122dsm2306413ejb.45.2023.03.04.11.02.53
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 11:02:54 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id f13so23022824edz.6
        for <linux-security-module@vger.kernel.org>; Sat, 04 Mar 2023 11:02:53 -0800 (PST)
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr2787706ejb.0.1677956573508; Sat, 04 Mar
 2023 11:02:53 -0800 (PST)
MIME-Version: 1.0
References: <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop>
In-Reply-To: <ZALcbQoKA7K8k2gJ@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 11:02:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJSXQfPGjpj8SAgEn5bOHOGvHPvFQM6GutcUU7kS8qXw@mail.gmail.com>
Message-ID: <CAHk-=whJSXQfPGjpj8SAgEn5bOHOGvHPvFQM6GutcUU7kS8qXw@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 9:51=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> At that time you was OK with CONFIG_FORCE_NR_CPUS, only suggested to
> hide it behind CONFIG_EXPERT:

I think there was a mis-communication.

I as violently *not* ok with that question at all. I think our Kconfig
phase is really annoying and nasty, and we should not ask people
questions that they don't know what they mean.

So putting it behind EXPERT was a "at that point, the question is
gone", and I'm ok with the config variable existing.

But..

I am *not* ok with you then thinking that "oh, the config variable
exists, so our default code generation can be complete crap".

The kernel should do well by default. No amount of "but you could go
into magic config variables and then force options that might be ok
for embedded systems to make it generate ok code".

I think it's completely crazy that the distros enable MAXSMP. But
that's their choice. A *sane* distro should not do that, and then we
limit the normal kernel to something sane like a couple of hundreds of
CPUs rather than thousands of them (and the associated huge overhead).

At that point, things like cpumap_clear() should be a couple of stores
- not a call-out to a variable-sized memset().

Notice? Simple and understandable Kconfig questions like "do you
*really* need to support thousands of CPU's"

Not that FORCE_NR_CPUS that is _completely_ useless to any
distribution and thus completely unacceptable as a regular question.

See the difference?

          Linus

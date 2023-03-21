Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF8AC74A5B
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Mar 2023 19:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCUTEr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCUTEo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Mar 2023 15:04:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96F1A492
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 12:04:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ew6so761150edb.7
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679425443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86Y1u5mLe9v/pBUgkOz+GqSgxjFJqe1/jbcXyRYiTnE=;
        b=flGgnsoy2zA9nwYcGJNTRsyctDtIDckL2GqnI2TIwCNHrfNhGbyfl0vzhMEASxp1Fy
         T/A/1w9Kr4ji9Pvl/2AxLUDqc/HU7yq4NQzEHfA0URTc/GmspvlQBsV63VY80iXpBj5l
         zAp2RomfgS+QF2V2+e5DaAVGGqyuYp2aSgJPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86Y1u5mLe9v/pBUgkOz+GqSgxjFJqe1/jbcXyRYiTnE=;
        b=7UB/uEtRj3mq9jPsho4akebFDL5Q5j12QWKf1wv6b2I7PFCLfo8c8UhQttMCvXrDkI
         uVUmkDaNz791R6Tz1mYjc/0cZcxPro70Tee5gjCr0ZTUpWlkjwOTSPowZg7jZNmZl98v
         kKTUdHJoq7wEY3NHWet2DCZyfvzPC5DYAmdFqSHTxn0c+fY+aAY8CqcjkOXZ18Lta9+Y
         H+NqsE+7Fgw5kjtgMSVDxfhYiwlStXSfmrZ9Ci+LxfJNsOE2sQQ2hU7eoxhYfHPcqiaU
         JZYU8wQQemMhKsyd+6uT2MwNu/ufWIWpV7DAj8Q/fYS2/dWQNvmyjbUDPgtD+OrnQPYR
         h2cw==
X-Gm-Message-State: AO0yUKWJiGvNG5+2xJ6X4ouWtodx1nyXnICmNpffhm5v6KwNAm2k8HPj
        1ZepSZUbvmjyztyS88uLWiDmEuQMyMzB71UiXiDT7NDT
X-Google-Smtp-Source: AK7set8yXf+on4IcMfz6mEPuQE1VtwIgloCuNrbHvyP/lzzQKoHJR69XXQzfiGm9/+P+MRvnN8DSCg==
X-Received: by 2002:aa7:de82:0:b0:500:3a14:82c2 with SMTP id j2-20020aa7de82000000b005003a1482c2mr4495878edv.15.1679425443273;
        Tue, 21 Mar 2023 12:04:03 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id u20-20020a50a414000000b004fd1ee3f723sm6648982edb.67.2023.03.21.12.04.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:04:02 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id cn12so18099412edb.4
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 12:04:02 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2435070ejc.4.1679425442225; Tue, 21 Mar
 2023 12:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205617.GA1434@sol.localdomain> <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
 <20230320225934.GB21979@sol.localdomain> <20230321020313.GA108653@mit.edu>
In-Reply-To: <20230321020313.GA108653@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 12:03:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVTfej6+D62rzedjY_wzBVFqH0+U5vbq+ava8VhYPH3g@mail.gmail.com>
Message-ID: <CAHk-=wjVTfej6+D62rzedjY_wzBVFqH0+U5vbq+ava8VhYPH3g@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 20, 2023 at 7:03=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> Another option is WARN_RATELIMITED.

I don't think that exists.

There's 'pr_warn_ratelimited()', but honestly, the rate limiting is a
joke. It's fine for things that never happen, but if you can flood
things without the rate limiting, you can still flood things with the
rate limiting.

The default rate limiting is "max five reports every five seconds".

For some "this should never happen", a reasonable rate limit might be
"once every 24 hours" or something like that. Just make sure that if
the machine stays up for months or years at a time, it doesn't get
hidden in all the *other* noise.

Our rate limiting sucks. The only thing that really saves it is that
rate limiting is used for things that never happen in the first place,
and the default values are basically picked for "this is a network DoS
attempt, let's make sure it stands out in the logs without completely
bogging down the machine".

So no. Please don't use "ratelimited" for "this shouldn't happen".
It's still going to suck. We had that *exact* thing just a couple of
weeks ago:

   https://lore.kernel.org/all/CAHk-=3DwjTMgB0=3DPQt8synf1MRTfetVXAWWLOibnM=
Kvv1ETn_1uw@mail.gmail.com/

where the networking people thought that ratelimiting would be a good idea.

It's not a good idea.

                    Linus

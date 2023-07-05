Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64676EB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 17:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGERDT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGERDS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 13:03:18 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FD01713
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 10:03:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c4e4c258ba9so4770028276.1
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688576596; x=1691168596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRfFcwVlZCH2jeyPyuvYyHy1xfybR/pyaakzSQXWsJA=;
        b=azct1cHnGrd0gKi3PhlSvOtXLtxka7hMaxNwg7NnX0+Pj3hnMYSRUFpzlMMlY+PjX6
         7AHfvtEOZn2hGOBj1Sof5GTpetaxKDVxf9FVUK5Kl4xhZ9luAyipXr4GHVRNPUXd16zy
         OG2HzxxhBjLyw3iaceQDZh6dk/oXgpbZDeWGa0LVC3X6yOmUXYcHgv3VrrGiU/jx4j0t
         4s3SE95cVqintkKMzs8JD6h1iVymlQUsZbbXjO5cl3WmgcuIksMzrGf2ZQZEcIwfaRB+
         tTlNxFAhf34iAwWWAsh8SaTt3kxY1LBx9RKHgkdYRkO5mgXQUS1Nfq6EDdDyhcrfVYde
         lpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576596; x=1691168596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRfFcwVlZCH2jeyPyuvYyHy1xfybR/pyaakzSQXWsJA=;
        b=RZhq/TygqB3bzrHYOAyFElsTJq9nHiCFy/DUJ9ssqT/BD5j2cGjYHlZzp/wpAvs4Vd
         AuWzfTzixlzG9aVrtmi8CRTTNUsQEAGt6oLVpkB7pfyYxouEP9HWYAiH6bQu4w/i8eZm
         ZLE0u6mWbkXchR1iuBUlvZef+VTjN7GEhQmG5/qZCgUXclYiZQ6TmD14rk30tUOWyTpJ
         yaUaR2bUt09U0XNIBBGTLQyuotcak503LZ7kWzKvZzC/nC1KgFPdnCQhzF4K8XHu8buN
         smiS0ZLY786iXaEHm3I1plBMS9a6dmF+vO+GgjhaPTaOyPPTzaDdXjwkAqR3CDgDx3E4
         V1MQ==
X-Gm-Message-State: ABy/qLbAbix28smhpym7b4J944rUwg79cXh1qhvmueBZ5Np/n06S7kXX
        pX0MAH4yW0wdxx+FRX18cQ5eiHz8SuUgMjOUpkp8QT5xtzW3Xzg=
X-Google-Smtp-Source: APBJJlFMggsNpjnBgS02/kpRGZcKzAqQxMpzjwrdvKlZ0v8N37usnyCNdaM0ZQJcUYLc+xHjdNfexafYyiup/vBr/KI=
X-Received: by 2002:a25:8143:0:b0:c49:ece4:8063 with SMTP id
 j3-20020a258143000000b00c49ece48063mr10884965ybm.17.1688576596303; Wed, 05
 Jul 2023 10:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230630192526.271084-2-paul@paul-moore.com> <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
In-Reply-To: <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 13:03:05 -0400
Message-ID: <CAHC9VhQ21ef+oamr5m9RdzN_Do38Pfu6Up3M_2vwu564zq5G1w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update SafeSetID entry
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 4, 2023 at 2:33=E2=80=AFPM Micah Morton <mortonm@chromium.org> =
wrote:
> On Fri, Jun 30, 2023 at 12:25=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Micah Morton, the SafeSetID maintainer, last posted to any of the
> > public kernel mailing lists in early August 2022 and has not
> > commented on any SafeSetID patches posted since that time.  Attempts
> > to contact Micah directly over email have also failed.  Until Micah
> > reappears I'll plan to continue accepting SafeSetID patches via the
> > LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for now,
> > and add the LSM mailing list to the MAINTAINERS entry so that the
> > LSM list will be properly CC'd on any new SafeSetID patches.
>
> Hi Paul, I've moved on from working on ChromeOS and checking my
> @chromium.org email on a regular basis. I was trying to check in once
> per month or so but I guess its been a couple months since I've signed
> on -- sorry about that. This sounds good to me, I can't necessarily
> make any guarantees that I will be a responsive maintainer going
> forward (especially since I expect changes to the SafeSetID code to be
> very few and far between). I'm good with whatever you think is best
> here. Thanks!

Thanks for the update Micah.

Generally speaking, serving as a maintainer requires checking email on
a regular basis.  There isn't a well defined requirement that I'm
aware of, but once every couple months, or even once a month, is
outside what many expect, myself included.  I know you have moved on
from ChromeOS, but do you have a personal desire to continue
maintaining SafeSetID?  Linux has a rich history of maintainers who
maintain subsystems outside of a paying job, and I would be happy to
support you in such a role, but in order to do so I think you would
need to check your email at least once a week.  However, if you aren't
able to commit to that at this point in time we probably should mark
SafeSetID as being in the "Orphan" state, with patches accepted via
the LSM tree until a suitable maintainer can be found.

--=20
paul-moore.com

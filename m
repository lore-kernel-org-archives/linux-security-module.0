Return-Path: <SRS0=iE4T=BP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6FC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 07:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C433622B40
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 07:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Feg85hqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHEHqH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHEHqG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Aug 2020 03:46:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F72C061757
        for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2020 00:46:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so31483192ejr.5
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2020 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcRNpeqICVUMdW+eQV6cNmoTKrDCq48jfX1KaVHDvwQ=;
        b=Feg85hqy7+vcolCIrLFilOaGgrOtXj8thXykBp3Bp0XpYsuPfElOh4nm8I3SnyS62b
         64JD9H/zVxxGypHdTvYO2f1EJ0uPlTosWe53MpIC26xzA7XHbleGbFMLSSofhpx5X7gL
         6fThps3gz64rNFTjpg3m0BIu77PqTCGcRQciM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcRNpeqICVUMdW+eQV6cNmoTKrDCq48jfX1KaVHDvwQ=;
        b=a7W2UFUOiopLwhc9BLQJ0k5FJRmFuPeP10J2/l3adl/39hqtar8gKlO+0a9AkOA6li
         1Mv1viP8kMIT3DJoICB7a2Cfvi3elaYeysISe9OUwr5aREnZ5HuVB8bsoJWB272H6yPA
         6i3LLiP0t7+6X9sk6+vjQywbnHCi8rQQn4fz2Xg7UZFj1q2Ty1sMTT7tZVhjsx7ZkWNK
         DBpjSNt5eJbekZz6FICEUieoITpkQCl+log+r/jF8wvGdzssUtHBxaw/JxzA71ZpxWHD
         666Kw1zoFs0dG7MszzV+Ejpx6BYJPab5yqf2gkGJyNdxEhX8K09xSnDQV7KRaBhFi6oW
         pJsA==
X-Gm-Message-State: AOAM533Y77navWmv7PO0hnD6Ce7ZgkvaKtFWpFQTOQ2vwZ9CT4Or+H+k
        3oqAW/0SaGdmyyQRV260nHvIodbM869UnI7VTGFCBg==
X-Google-Smtp-Source: ABdhPJwSzf7ZyfM06Ap8zJ46vCH2qMZs0q/mJf/FF/mKV8B2cn3vTn5+kSxcusIr/7oVCz9jGqzaVrb7ONfCeuEjpiI=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr1832194ejb.511.1596613563524;
 Wed, 05 Aug 2020 00:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
 <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
In-Reply-To: <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 09:45:52 +0200
Message-ID: <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 5, 2020 at 4:46 AM Ian Kent <raven@themaw.net> wrote:
>

> Coming back to an actual use case.
>
> What I said above is one aspect but, since I'm looking at this right
> now with systemd, and I do have the legacy code to fall back to, the
> "just reset everything" suggestion does make sense.
>
> But I'm struggling to see how I can identify notification buffer
> overrun in libmount, and overrun is just one possibility for lost
> notifications, so I like the idea that, as a library user, I can
> work out that I need to take action based on what I have in the
> notifications themselves.

Hmm, what's the other possibility for lost notifications?

Thanks,
Miklos

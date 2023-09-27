Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E215E810AC
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Sep 2023 08:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjI0IrQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Sep 2023 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjI0IrP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Sep 2023 04:47:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A3DBF
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 01:47:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8a822508so1347088366b.0
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695804430; x=1696409230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7R44+izV15PlpetL04YRf6tEqOd3u3v63DX/FqhKvw=;
        b=BSixiHM40Hz7zXgVBsquclElSHBWJPjKLKm4PSVZlZUu56huUr+ubBK32UzVHMflA4
         fc6RvqojFeDS2hQvqi9tOEfyiDDM5r7HbjJrDYkcudBPVRZAoJ6V6ZmYNExtkRcUqtIP
         qX8ugJMer4WEzg8E9W2U2A7dT+we3Z20U3wAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804430; x=1696409230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7R44+izV15PlpetL04YRf6tEqOd3u3v63DX/FqhKvw=;
        b=Yz1YX3fnVQ2glyILTCsT2NDqExBrCfbGQqSKqT9/cDfd1IZzkW55K+SXpihyc0ffIl
         mqS2QWx7vTbA2sFshAcyuP8u3svYK/abh2lZatr3r1OtZl41UntBROgHks3dMmnGqglI
         wlIBySWFCPzJCKnzDkFQnE+xAbY1XK3YkIXQV4Dit9YVaRTe7RDjK5ESw25uBxCjB96J
         uPoDvtOQSbvvE4n5x8KGWrKodfWm2YctvXjJPiD/2Lz9fVqN2QHfOjTxFv3L/+BlbrC0
         gr1J2znGNX++6AVLhofunXjnH5ftmjBda0LJCcWL6wdqR8ghWcmENKIBCP61saDnabV/
         Db1A==
X-Gm-Message-State: AOJu0Yxqf8R+eZsb+jubPoAXqpzWesbSpO8TsJUNqmGZAVPgMQUXyxW7
        x/IfU08NuvQ1AXYyvQlDvgd64TgvhBLC9HmJjjgSZw==
X-Google-Smtp-Source: AGHT+IHakFZR3B3G8zMwyXaAUpbmlxEnten3LWsWQmOVVXf706DBV8ir31XKJVFq7fysuifFgh/a2olHdT2hG4uPu94=
X-Received: by 2002:a17:907:7e91:b0:9a6:426f:7dfd with SMTP id
 qb17-20020a1709077e9100b009a6426f7dfdmr1366881ejc.66.1695804430509; Wed, 27
 Sep 2023 01:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com> <20230925-total-debatten-2a1f839fde5a@brauner>
 <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
 <20230925-wahlrecht-zuber-3cdc5a83d345@brauner> <CAJfpegvAVJUhgKZH2Dqo1s1xyT3nSopUg6J+8pEFYOnFDssH8g@mail.gmail.com>
In-Reply-To: <CAJfpegvAVJUhgKZH2Dqo1s1xyT3nSopUg6J+8pEFYOnFDssH8g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Sep 2023 10:46:58 +0200
Message-ID: <CAJfpegu3BKXE+b51cj3=QwAsxe3QyKOEG_10muEsAsGD=_vkAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 25 Sept 2023 at 15:20, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 25 Sept 2023 at 15:19, Christian Brauner <brauner@kernel.org> wrote:
> >
> > > How about passing u64 *?
> >
> > struct statmnt_req {
> >         __u64 mnt_id;
> >         __u64 mask;
> > };
> >
> > ?
>
> I'm fine with that as well.

So after a bit more thinking: this is okay to make life easier for
32bit archs, but only on the kernel ABI.

On the library API the args should *not* be multiplexed, as it's just
a pointless complication.  This is just an internal implementation
detail for the sake of legacy architectures, instead of being good API
design.

And because it's an internal thingy, my feeling is that this struct
could be reused for passing mnt_id to listmount(2) as well, despite
the fact that the mask would be unused.   But I'm ready to be
convinced otherwise...

Thanks,
Miklos

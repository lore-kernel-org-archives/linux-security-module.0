Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE37DC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C775E207F5
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OO0Hsoq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgFOQ2g (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQ2f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 12:28:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76D1C061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:28:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o15so18082328ejm.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmwX7P1qa5AxhzzJ+vXMBvRvKi99lt5x3CENqnU7BDw=;
        b=OO0Hsoq7pEyhd+RhOtlLw3eIuo0gsRaaDxCHKadHohKQfIIQ/9Mtk36ofZ79Xn/fVe
         2/SghCCNBVGjo+xthRh9+r0HrA9X+gLQVqwl6PPJc5GPGE9c21JAZYxrzaO4vushKDIY
         yDMmXHJAHEDwQlurhRRU+LadbJm/2cTz8GR4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmwX7P1qa5AxhzzJ+vXMBvRvKi99lt5x3CENqnU7BDw=;
        b=GktqgBQQ0sumU8hnxIyXAhMMFQcRSMZOO19uq7PN4XXH3I3TdvL6QAGTtjgw3Ny3cz
         YrjJAUYZupQqQitJ/ZzQzDOnZiBVlHlol1KaOa6VTPDkMYH8h+g/DCM6L7pJpHL7VkRM
         bI9qdgOGCabF2ZRj5trmlL6JrJIAoc5WidSp6MM2fZjFIhkWFGbYNlHzTMPj643n3rV7
         06tGoyybblUT7IA1aa4asZfRtNx+jcecdzj7yYVv7MAN44ndAaRZ/37GxRvjvKM9Hkly
         ZbSCjcGHYwYJSns5323e8W1R29EjT9lY2QZNVnLIlQVUhwuK3bdYuNierQ+5XmirAhkt
         jLKw==
X-Gm-Message-State: AOAM530IM0eFC56bK3Gr0AW4Gcln6meIsBQcR4+QcUoF6egJHNVmmIM7
        PmcjFSbM4QrrXzGRj2z2G4jEuPxuYKJNuWtSE9BmRuGu
X-Google-Smtp-Source: ABdhPJzzuW9ljsYYvg62Bc4EVtQsy0MDdXnrP9JjQj14fiHarxB1DQyUyFTLx2JgD06teVbGPjK1cYlEJYt+THXpesU=
X-Received: by 2002:a17:906:d973:: with SMTP id rp19mr25139408ejb.475.1592238513568;
 Mon, 15 Jun 2020 09:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
 <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
 <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com> <CAHk-=wipG5Wpfydn7YUbahDV_G0GZqeUqEWax_mSLBuVeiT0yg@mail.gmail.com>
In-Reply-To: <CAHk-=wipG5Wpfydn7YUbahDV_G0GZqeUqEWax_mSLBuVeiT0yg@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jun 2020 09:28:22 -0700
Message-ID: <CAJ-EccN3c73xOXXy+C3UEt0=jiNMaKb2Ps9Bv1ucZnXBeW28VA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 14, 2020 at 12:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jun 14, 2020 at 12:12 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > That said I'm a little fuzzy on where to draw the line for which kinds
> > of changes really should be required to have bake time in -next. If
> > you think this is one of those cases, we can hold off on this until we
> > have some bake time for v5.9.
>
> It's merged, but in general the rule for "bake in -next" should be
> absolutely everything.
>
> The only exception is just pure and plain fixes.

Sounds good, that makes it pretty clear.

Thanks

>
> This SafeSetID change should in fact have been there for two different
> reasons: not only was it a new feature rather than a fix (in
> linux-next just for testing), it was one that crossed subsystem
> borders (should be in linux-next just for cross-subsystem testing). It
> touched files that very much aren't touched by just you.
>
> "Looks obvious" has nothing to do with avoiding linux-next.
>
> I suspect most of the bugs we have tend to be in code that "looked
> obvious" to somebody.
>
>                      Linus

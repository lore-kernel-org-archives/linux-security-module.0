Return-Path: <SRS0=Tise=DA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1DDC47426
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Sep 2020 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700C12220D
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Sep 2020 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TwRx/Vpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIWRr5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWRrv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Sep 2020 13:47:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F0C0613CE
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2020 10:47:50 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e23so840107eja.3
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2020 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUS2UZxRGpO2YaOW6upGWdToFOcqQ6pHgW0MxAB1v5c=;
        b=TwRx/Vpm0AVkYDAIyvb5u4332cy+86WpDpNRdE5W1yAiw4urdW7fyPIUS/CEA8Bytc
         pc9cnEHcqa7cFaaoAJy0ORxLSH5gvle75kucYTAezwmGf34OSyVbeGCPGEHYnBAk8Rq6
         stmjEuSL707J5UgkY4TZXp1TO635GCtf3XIC5Vy1FKMVqEwYlWsRljNhcFgJ/cVv9ARC
         vE5FTDfIFT5XJKu3ozrj2lBoR/pIwrhVV0b18KSd5xVq5v/uEGFOwn1eUtZwPuQvgAKm
         ozh+Z6V2hlu/h4MRqbg0TKXACd/BSrtJqtK5BLxfOeLENNp5Qwmjm1kJ6GVXxo74x5au
         WZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUS2UZxRGpO2YaOW6upGWdToFOcqQ6pHgW0MxAB1v5c=;
        b=cVzkcaHCNbDdtcmDDTSSb1V7GZNnhDM7umyRi+COiZrN/JNP3TBoHz13c9802AKL/c
         QrveJ9PNWYtJ4Spol6+js3zt1hAqaNf5QtsKMprqzQhh/NY98lZDi1H0I/ADDBUDji6R
         BnoJ0fT7NAmo6HMqtSUJ67g5NlN2tEsTBUoVIdfAKZVyyOZauW6sPm7+E4GKlQJG/lNR
         PJbRDMe9N2YW/L7Et1H8abFbkcqGYVdZB3Rp78rlpNkfZlhKtps/a9HHwevdDWsK8Xp/
         9v4A590jzCpGqhePpITqQQZ+cq9UEaR44CanZTxCsVKgNk3PI7332GxJWQ7DRlfTOdEC
         /NVg==
X-Gm-Message-State: AOAM533KZf+sIbt2DXFtz9mzAwuyaRX4/wRAAmjKkTvUFQRH2X1XBaI3
        G0PtmTvkzO17kL8zILt9WaJfHxFjQ2HQh6T8hv7i
X-Google-Smtp-Source: ABdhPJxJ+5OmXZaampvYMsc4KTyV/pMqSMPlrkTf341wG+iTjZFNqNcPd/Y92fwJWPJ5VK+eJTITMavL6zHZYqWaMdc=
X-Received: by 2002:a17:906:3553:: with SMTP id s19mr815876eja.178.1600883269547;
 Wed, 23 Sep 2020 10:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
 <CAHC9VhSPk2RiMsnjTKw02_+_1Kagm06m+-r=ooNruT+fuuixYQ@mail.gmail.com> <20200923144852.GK822320@madcap2.tricolour.ca>
In-Reply-To: <20200923144852.GK822320@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Sep 2020 13:47:38 -0400
Message-ID: <CAHC9VhRu4KEyp+e0tbSbObL1y0+90z_Znp+0z-hmnj5V68bh0w@mail.gmail.com>
Subject: Re: [PATCH ghak120 V5] audit: trigger accompanying records when no
 rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 23, 2020 at 10:49 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-09-23 10:29, Paul Moore wrote:
> > I've gone over this revision a couple of times now and it looks okay,
> > but past experience is whispering in my ear that perhaps this is
> > better to wait on this for the next cycle so it gets a full set of
> > -rcX releases.  Thoughts?
>
> I thought I had lots of time since we were just at the end of the
> previous cycle when this failed the previous time...  Ran out yet
> again...  (there were two weeks of PTO and a devel system rebuild in
> there somewhere...)

We are at -rc6 and assuming v5.9 is released after -rc7 that would
give this roughly a week and a half in v5.9-rcX; considering the
history of this patch (reverted, obvious problems in development) I'm
not confident -rc6 provides enough soak time (even if we go to -rc8 I
remain skeptical).  In addition, we've got a history of not taking new
work that isn't a bug-fix past the -rc5/-rc6 timeframe.  This is why
I'm debating holding this until after the merge window.

> It isn't my call.

I asked for your thoughts on the matter, surely you have the liberty
to comment on your own opinion :)

-- 
paul moore
www.paul-moore.com

Return-Path: <SRS0=ebHT=ED=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D2C4363A
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Oct 2020 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEF520759
	for <linux-security-module@archiver.kernel.org>; Wed, 28 Oct 2020 23:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Y47tug5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgJ1XOw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389509AbgJ1XNB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Oct 2020 19:13:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCFBC0613CF
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 16:13:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y12so808108wrp.6
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jVxeGv6lE9HxG3ioZ1jNMfiO7oQfXoYg0ePUwTMDgQ=;
        b=Y47tug5b8PS5GVPWZ5arNveYafl4JnStVgSr/qZmy4WMW6wLuDTGfKhQt582GpTP9n
         VaX4J1iOOfcC9cqURSGuBTpjB5MHJyq1mNBcQTvCskhYUqF6bkLCy5AQk3k1tAi11Zlj
         InKArBY6f0SHcVV6CdqF5hqhWXzbBTzIbMK8EO/b0Trpp/V1bwmsJ5iTQXadbQUpXO93
         gVT6KwN/yGKCVG9w8JM2XKakHZ2v7HUoGkEUjlIlnzZp8L9L71mAsvpQuk9v+oa7XOAs
         tqHKWRGPBACtP/01HsIquOdIS4+cs+Ld2MZqc5GHCGyGS6uhT0AJb9uwlt6FqK25Kryw
         iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jVxeGv6lE9HxG3ioZ1jNMfiO7oQfXoYg0ePUwTMDgQ=;
        b=rO24zkxG3iBsNdwowXYRm08zxj/+IvfW8ZZKKiek8d2g+9tS4Rayfoxe2wHKWCXVyN
         qSTxFV9Ofl77DrH5O6Yk9w3zmZnvpc7JQyUv3IHNFn8AHKiD4TMRbWuMT8OP3XOlapm1
         IJxLwwH6huSUys0Gh91JywJPh6XprHR+wU+mHc7MLwRp5BoBE2O714IRcz4ye/Q1ZSKb
         xvO80ymd+yBtaSpvPmuYVvf8UiVym446BQtLs60S8KkbB5LY+vJuD3gRr0eGjERDg6lP
         Mxld+qNmKlxwJBDPSctEBxfE4nEkgGkkTPV2t7R9PF/BTTn0OBqXwRvMRqMWn9N1RlSQ
         XsMQ==
X-Gm-Message-State: AOAM531NqhGwPIux+Wp2CpBOu3qfyuxaZtS1I1DIJ94FY88GhXgsuH5K
        Cniq4WL31VGqUz1grA2fiJEtouUlpTHGfap/Onh0Pw+oXQ==
X-Google-Smtp-Source: ABdhPJwEzZ6iuiYaqP3D8WgJUCMcZ88Ip3ZyPs/mRAVgBH9lthbImUjuYFxHiRFl7WkTjg/dMh67mJNU6KVwr/0CDdc=
X-Received: by 2002:a17:906:af87:: with SMTP id mj7mr5178601ejb.178.1603848385218;
 Tue, 27 Oct 2020 18:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
 <CAHC9VhSPk2RiMsnjTKw02_+_1Kagm06m+-r=ooNruT+fuuixYQ@mail.gmail.com>
 <20200923144852.GK822320@madcap2.tricolour.ca> <CAHC9VhRu4KEyp+e0tbSbObL1y0+90z_Znp+0z-hmnj5V68bh0w@mail.gmail.com>
In-Reply-To: <CAHC9VhRu4KEyp+e0tbSbObL1y0+90z_Znp+0z-hmnj5V68bh0w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 21:26:14 -0400
Message-ID: <CAHC9VhTBxdtC8YF_Vze54WQgfhf3kH+2RAGnsjzf2whwJw8SOA@mail.gmail.com>
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

On Wed, Sep 23, 2020 at 1:47 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Sep 23, 2020 at 10:49 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-09-23 10:29, Paul Moore wrote:
> > > I've gone over this revision a couple of times now and it looks okay,
> > > but past experience is whispering in my ear that perhaps this is
> > > better to wait on this for the next cycle so it gets a full set of
> > > -rcX releases.  Thoughts?
> >
> > I thought I had lots of time since we were just at the end of the
> > previous cycle when this failed the previous time...  Ran out yet
> > again...  (there were two weeks of PTO and a devel system rebuild in
> > there somewhere...)
>
> We are at -rc6 and assuming v5.9 is released after -rc7 that would
> give this roughly a week and a half in v5.9-rcX; considering the
> history of this patch (reverted, obvious problems in development) I'm
> not confident -rc6 provides enough soak time (even if we go to -rc8 I
> remain skeptical).  In addition, we've got a history of not taking new
> work that isn't a bug-fix past the -rc5/-rc6 timeframe.  This is why
> I'm debating holding this until after the merge window.
>
> > It isn't my call.
>
> I asked for your thoughts on the matter, surely you have the liberty
> to comment on your own opinion :)

I never heard back on this, but the patch is in audit/next now.

-- 
paul moore
www.paul-moore.com

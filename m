Return-Path: <SRS0=n1M3=DT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB2C433E7
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Oct 2020 02:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA952078A
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Oct 2020 02:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uFrh1lzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgJLCKS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 11 Oct 2020 22:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgJLCJZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 11 Oct 2020 22:09:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B2C0613D2
        for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2020 19:09:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x7so10869293eje.8
        for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2020 19:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK2bWzHz5KjOV6B+R5X2SLhKXSVJscVhCITZfEKF1hY=;
        b=uFrh1lzryALn96VPKRBduZb3Uw2dS7GwoDmDor/yq4sltdj4FZMEe0Kz7zWWYkgsvZ
         Bhk0XJiKrLAD9vM9R6Rp6oGNiAmOEBkfW2FHbS9htw4ttGMgoNiPjHbV82SaJQOh72n1
         KOn0XHZV3yhQ5ML83+/WRHEK5fGEH2My0vKHk0vWBZcvp/We8Mi77DTEs0R36Uy8AS/q
         j6qvKFbzpZ0Q5slqBpraYrzgMnWaci+4n4rLKl+4qMGdM1msS0I9pJxg6ZHb7zpBNGAx
         fFoUIMSVQeSle6ceuXri4Gebr/dVtNHjJ5L0A+m6O9ky0R0lJJWu82TvgfOsprzdtiDv
         1FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK2bWzHz5KjOV6B+R5X2SLhKXSVJscVhCITZfEKF1hY=;
        b=DMjDEZEOYYLm+ZlHTGYw6wlHduDtmY2XXMfPde1B2wt/RMlFjtKuZLTE6PNkVrahnj
         IvExugrbAJT6v3XKllgejT061r6csPcIRrzylmo/5GQC5rlZKH/CmFMhnlHhi5Ir0Y1i
         /PINfOQau1LFZOMb6s2YmoeVu40v6/AaueqGWbMTsvfPeDH5OiOqamCKOT9Xk9eRxaHZ
         Pm8lBmDhh3csqHz7uS9OfdVYtrdSozsojAav93kKxz4HwVytlKgcbVgdyaMNHge6QWff
         w9QrylGhuUI0wdMaTqAgW5UaCdkS610qL5CWXsUdph8NBKu2gG8ELcAQCL+Fow8/rChT
         LAdw==
X-Gm-Message-State: AOAM531XVhcegMttmQa6VT4/UOxS0B1iInx3L8/qrVvG2UokRV0VRQKO
        CEpyFaXCClbm8ajMWy7EBUDQnXPWwUJMODTWTbwu
X-Google-Smtp-Source: ABdhPJxvp+jOMwz02L056HcUjWpx3NzOVbT79WBzEmzyJsbpZ9wPiEuXnLr6OVSinkWqQieYV8eSaJPP3ELMwP9kJIg=
X-Received: by 2002:a17:906:ce5a:: with SMTP id se26mr25334590ejb.106.1602468562791;
 Sun, 11 Oct 2020 19:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200930094934.32144-1-richard_c_haines@btinternet.com>
 <20200930094934.32144-4-richard_c_haines@btinternet.com> <20200930110153.GT3871@nataraja>
 <33cf57c9599842247c45c92aa22468ec89f7ba64.camel@btinternet.com> <20200930133847.GD238904@nataraja>
In-Reply-To: <20200930133847.GD238904@nataraja>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 11 Oct 2020 22:09:11 -0400
Message-ID: <CAHC9VhT5HahBhow0RzWHs1yAh5qQw2dZ-3vgJv5GuyFWrXau1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: Add SELinux GTP support
To:     Harald Welte <laforge@gnumonks.org>, pablo@netfilter.org,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 30, 2020 at 9:39 AM Harald Welte <laforge@gnumonks.org> wrote:
> Hi Richard,
>
> On Wed, Sep 30, 2020 at 01:25:27PM +0100, Richard Haines wrote:
>
> > As in the reply to Pablo, I did it for no particular reason other than
> > idle curiosity, and given the attempted move to Open 5G I thought
> > adding MAC support might be useful somewhere along the line.
>
> ...
>
> I think it would not be the best idea to merge SELinux support patches for the
> GTP kernel driver without thoroughly understanding the use case, and/or having
> some actual userspace implementations that make use of them.  In the end, we may
> be introducing code that nobody uses, and which only turns out to be insufficient
> for what later actual users may want.
>
> So like Pablo suggested, it would probably be best to focus on
> submitting / merging features for things that are either well-defined (e.g.
> specified in a standerd), and/or have existing userspace implementations.

Having a solid use case or two is also helpful for those of us who
don't have a GTP/GPRS background.  I did spend some time reading a few
things on GTP, but I don't feel like I've made much of a dent on
understanding how it is actually used.

Harald, Pablo - I know you both suggested taking a slow iterative
approach to merging functionality, perhaps you could also help those
of us on the SELinux side better understand some of the common GTP use
cases?

-- 
paul moore
www.paul-moore.com

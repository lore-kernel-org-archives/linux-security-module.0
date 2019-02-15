Return-Path: <SRS0=pLHH=QW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B91C4360F
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0498821B18
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pWhGfyv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfBOUEj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:04:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46176 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbfBOUEj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Feb 2019 15:04:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so8057880lfc.13
        for <linux-security-module@vger.kernel.org>; Fri, 15 Feb 2019 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1niQ3pYxtgp6Mtfo356boquUrBnwdlNYwRbtwNCGuJU=;
        b=pWhGfyv61mpQlon38Tv46098W1AeXNS3LmeQfYM5W0J9mS6Y3Md+CfGJSanl38plCS
         5vyEsbziRSpXFyS8LU0s9JpxRavimbV/Bb98bnHIhp3EbtJ42Q+Efr3p411OC64m4MMr
         YaDhnlE14WgsV9v//ChRsRrSOwgzm80/kmgtbdN1C7gx+EdA/jsbakPvAdH3+ynVwZhr
         zeTpq5upw4UDRmttriC7uV9N7TGjAC14ajn4i0EhOhx3HnvrvpDbxr7M9DK73RRBBlB7
         kYwysMYOAF62uL+sxjpELuuAdLY9xxdns02SS3qYsjb1vctwBMpnEKxrpV7ZKsneamyG
         qBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1niQ3pYxtgp6Mtfo356boquUrBnwdlNYwRbtwNCGuJU=;
        b=Kg/DP9YsLjs+PQ9Whj5pCq2YUoGeWeDZ5CRI7pztuF7YrTxo1HBumk7wFNaeKQOYL4
         uQ3hbYudqn/LyyzKhs0l3GKJei/bloWCvEjYSoQL6d/kwo2An+xtjWclG5xiiVV/MseX
         /tqfHIQ9U8aDq0atmllcwKiJG4VawDZh5GHq6/xaOhCiRXQg/hl4/pei5Lb0coymH2mH
         w0U3GWTwT+Tj+7RI32Xwdh2Zjh+hR5igV6PkEVbPjzho7LxBujaHU8gS57LtgRj40ogz
         /5dSeOB5pFtoageOvGaDjQmCXiGc0m6zUYkFtuFOE6cVQueRYG9SmnCVUK0pyvjAtiQT
         94gg==
X-Gm-Message-State: AHQUAubnorriWqCEbGn6oYYUUgwULFD3oordofkMwzJwT1KFvxMAopTC
        REGPUxF7uoIyzmEfL5fU4IsHVtsh2h0fRZYCBz8q
X-Google-Smtp-Source: AHgI3IYa0RNtHV1ueNnzSoo6U9p/1J3RjplNk9QOYRnnHHvAaY5Pv+9g4VdpWnY+fjmKy0Th/3hCLmdZuxFfCxXLcHE=
X-Received: by 2002:ac2:4191:: with SMTP id z17mr6434424lfh.117.1550261074847;
 Fri, 15 Feb 2019 12:04:34 -0800 (PST)
MIME-Version: 1.0
References: <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
 <20190214.084343.1138362153341500718.davem@davemloft.net> <CAHC9VhQK6Cmcx5kwYAPipR4YGyBHdkLEe3UH+VmNYGHu4PWqjQ@mail.gmail.com>
 <20190215.120009.1549205062473501080.davem@davemloft.net>
In-Reply-To: <20190215.120009.1549205062473501080.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 15:04:23 -0500
Message-ID: <CAHC9VhRys7Efm=aQqph2ug9c8Ryra9imEG66avjeEeY8QZWTqw@mail.gmail.com>
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
To:     David Miller <davem@davemloft.net>
Cc:     s-nazarov@yandex.ru, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 15, 2019 at 3:00 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Fri, 15 Feb 2019 14:02:31 -0500
>
> > On Thu, Feb 14, 2019 at 11:43 AM David Miller <davem@davemloft.net> wrote:
> >> From: Nazarov Sergey <s-nazarov@yandex.ru>
> >> Date: Tue, 12 Feb 2019 18:10:03 +0300
> >>
> >> > Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
> >> > icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
> >> > But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
> >> > above IP layer.
> >> > This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
> >> > introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
> >> >
> >> > The original discussion is here:
> >> > https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
> >> >
> >> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> >>
> >> This problem is not unique to Cipso, net/atm/clip.c's error handler
> >> has the same exact issue.
> >>
> >> I didn't scan more of the tree, there are probably a couple more
> >> locations as well.
> >
> > David, are you happy with Sergey's solution as a fix for this?
> >
> > If so, would you prefer a respin of this patch to apply the to the
> > other broken callers (e.g. net/atm/clip.c), or would you rather merge
> > this patch and deal with the other callers in separate patches?
>
> I'd like the other broken callers to be handled.

Sergey, do you think you could fix the other callers too, or do you
want some help with that?

-- 
paul moore
www.paul-moore.com

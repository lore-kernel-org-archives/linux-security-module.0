Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B8C4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Nov 2021 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C4B61216
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Nov 2021 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKDTN0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbhKDTNT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Nov 2021 15:13:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44CC061714
        for <linux-security-module@vger.kernel.org>; Thu,  4 Nov 2021 12:10:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o8so24914834edc.3
        for <linux-security-module@vger.kernel.org>; Thu, 04 Nov 2021 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NH1hAfvi+I4370XeV24vwAJMjY68rCJZqPqZJpWaQC8=;
        b=CTFC0aT1kl3ldDGN7A63/pPZn/knkHUG1Y86+2vgLApjmgjAXNfv4QsK78E7ZmmMhF
         OvLF4OEtRu2b2mrzOG7fk8r25FQ5hn0HWf034uc8ml9d/OfOJWnqX6ikLbr8FBXSekxU
         IQg1JVMOqVVdCN7KqM0a3kMVSVSHfPPK9obose8M40j8hJf7qWjvA4zHwNu4dwatAsZT
         sJSfxrVnkCr1LqrIRbexoMhk76V6J9oOW1bBGQxsYRkBCi1F4jAZn3qkpxHEQR98oFC5
         vqZ0w7iw6cFjLHTfA4otkRwl53QM+gnpV/yn2yfkbfNQ7YaiL5q2kkiMyZW/nt9VUphS
         iEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NH1hAfvi+I4370XeV24vwAJMjY68rCJZqPqZJpWaQC8=;
        b=Zt8wtRUNmM2dtNyBo4E4gu/h0vZ/pWELrCBfNGe7mYAChM2gamkdwn+Mv6fJHJonWV
         bQgUoHTVJu+i4QRZC8C8aqN6L0y4TSQ68y3mAiZ9UWw6LsGJQg8ORM8xR1mGr9n3RG+H
         0ntsJtFMEJhgNPtW1V8+vKi4U5PXWt0Y4xnSWLr7ITggLFt2nyYgy72UcyFWgPJ79toW
         tuM77q7xBTDN29tiTwITloNePUxBrZqwDEssk/BZXKSsyAToIG8T7Hl0UeK+YoGuk1fr
         8+VuZju9fi3sxaAhOJoVOIgK2hNLWecSGLh9jPcGSfGXD4DoV6dj9/gdpJkkFHEOXd73
         Cifw==
X-Gm-Message-State: AOAM531YamchrqCoDS4xOs/fHOVvfhCJyWddyIyiSIQlaEMl8vpUd+gS
        tuOpH8TA170zpIM8DeIO2RZ5dea4hq/Fg+6kOARJ
X-Google-Smtp-Source: ABdhPJxwMN13Ohq4ksEEAgvk2n+Rrl8sdlV2f6hojDOE00hlUM8/gLrBdZwdU+SDaAJW4dxN5kG3X04PDE8YRvZnWLM=
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr9997327edc.93.1636053039080;
 Thu, 04 Nov 2021 12:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRQ3wGRTL1UXEnnhATGA_zKASVJJ6y4cbWYoA19CZyLbA@mail.gmail.com>
 <CADvbK_fVENGZhyUXKqpQ7mpva5PYJk2_o=jWKbY1jR_1c-4S-Q@mail.gmail.com>
 <CAHC9VhSjPVotYVb8-ABescHmnNnDL=9B3M0J=txiDOuyJNoYuw@mail.gmail.com> <20211104.110213.948977313836077922.davem@davemloft.net>
In-Reply-To: <20211104.110213.948977313836077922.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Nov 2021 15:10:28 -0400
Message-ID: <CAHC9VhQUdU6iXrnMTGsHd4qg7DnHDVoiWE9rfOQPjNoasLBbUA@mail.gmail.com>
Subject: Re: [PATCHv2 net 4/4] security: implement sctp_assoc_established hook
 in selinux
To:     David Miller <davem@davemloft.net>
Cc:     lucien.xin@gmail.com, omosnace@redhat.com, netdev@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sctp@vger.kernel.org, kuba@kernel.org,
        marcelo.leitner@gmail.com, jmorris@namei.org,
        richard_c_haines@btinternet.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 4, 2021 at 7:02 AM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Wed, 3 Nov 2021 23:17:00 -0400
> >
> > While I understand you did not intend to mislead DaveM and the netdev
> > folks with the v2 patchset, your failure to properly manage the
> > patchset's metadata *did* mislead them and as a result a patchset with
> > serious concerns from the SELinux side was merged.  You need to revert
> > this patchset while we continue to discuss, develop, and verify a
> > proper fix that we can all agree on.  If you decide not to revert this
> > patchset I will work with DaveM to do it for you, and that is not
> > something any of us wants.
>
> I would prefer a follow-up rathewr than a revert at this point.
>
> Please work with Xin to come up with a fix that works for both of you.

We are working with Xin (see this thread), but you'll notice there is
still not a clear consensus on the best path forward.  The only thing
I am clear on at this point is that the current code in linux-next is
*not* something we want from a SELinux perspective.  I don't like
leaving known bad code like this in linux-next for more than a day or
two so please revert it, now.  If your policy is to merge substantive
non-network subsystem changes into the network tree without the proper
ACKs from the other subsystem maintainers, it would seem reasonable to
also be willing to revert those patches when the affected subsystems
request it.

I understand that if a patchset is being ignored you might feel the
need to act without an explicit ACK, but this particular patchset
wasn't even a day old before you merged into the netdev tree.  Not to
mention that the patchset was posted during the second day of the
merge window, a time when many maintainers are busy testing code,
sending pull requests to Linus, and generally managing merge window
fallout.

-- 
paul moore
www.paul-moore.com

Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5516C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 23:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAABF2068E
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 23:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bs/swTR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFOXKt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXKs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 19:10:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3043C061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 16:10:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t21so12799068edr.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sO9aavsjRug36hOzi/DvYkEeHMoO809ou9ovXUWnr4=;
        b=bs/swTR49hDR8nO/VG1xpkJ2vnTneY6JWcCN4ArchkGRMufW7fzjmtnwC78/UZi8Xa
         4LBdQiJkVFZbar8XgTedlWBbj4YITt9QvwMrK/1OszlWid9QvAfRSNlDBPQG6IgEalAj
         9nD5o00IOZsCwGit4vA2a7+TJtDA2hyO8Auq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sO9aavsjRug36hOzi/DvYkEeHMoO809ou9ovXUWnr4=;
        b=qAtcgVts6LSY28TKozDXOPtai3qsi9x0ZBq11tHULP6+WhHxlmnjTbTytuORpBe06K
         QkhaZhIB41M61fGgggd39H0WfYN8huFCYHV/5H/qejNbeD06aI20+7qfF/nAQyC3SEyE
         jb0br08RRhpyAGRiQvlD1cMVt9LAy8nuM3epETd0yc6b/F/l5rmbZ16VA58qEX9ioKMo
         uzYDx4m3o1sWgtzFCdgm4eIrmRAgpuNsMUCXoictggHtmd9+y5U0XE2YEnuhNeua61Hz
         FMtf2qAQSx1jal5SA/kJodK+BUDuphLSYW0UM065ISc3baK9UE5EaAzly59uNYxfgKyY
         MogQ==
X-Gm-Message-State: AOAM532/BmzJ/j1JGy6srF+5xDXa4WSFWW/Ba6B+HLgRvjB8YYfRK/NI
        TBqZR5mVkXClx6yNzkbGvsGJi93pF8aDwaZJ3Cz+Zu8u
X-Google-Smtp-Source: ABdhPJwoVHdweXtzKCFW9ODH4sHBkY/FWCmaYf1dOoGhFage4f3QMjAzYHz8C84lai/kGNeqnMikQpBMK1u0/lfUiPo=
X-Received: by 2002:aa7:cb53:: with SMTP id w19mr98909edt.328.1592262647271;
 Mon, 15 Jun 2020 16:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccP7W5h1dZ4PfmiiE0r7ngxoSrD+tq3o_P03XM55DK806A@mail.gmail.com>
 <20200616085329.5f22f954@canb.auug.org.au>
In-Reply-To: <20200616085329.5f22f954@canb.auug.org.au>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jun 2020 16:10:36 -0700
Message-ID: <CAJ-EccPAGmyysRrbYhQQqS63AwrtOZEAf8RppwDQQBSBe8tTJA@mail.gmail.com>
Subject: Re: Add SafeSetID LSM tree to linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 15, 2020 at 3:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Micah,
>
> On Mon, 15 Jun 2020 13:26:33 -0700 Micah Morton <mortonm@chromium.org> wrote:
> >
> > Could you add my safesetid-next branch from my tree to linux-next? It
> > can be found here:
> > https://github.com/micah-morton/linux.git#safesetid-next
> >
> > Let me know if there is anything else I need to do.
>
> Added from today.

Sounds good, thanks!

>
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
>
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and
>      * destined for the current or next Linux merge window.
>
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
>
> --
> Cheers,
> Stephen Rothwell
> sfr@canb.auug.org.au

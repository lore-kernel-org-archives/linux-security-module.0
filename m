Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F7C19F28
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Aug 2022 16:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiHCQGg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiHCQGe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Aug 2022 12:06:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031131A82F
        for <linux-security-module@vger.kernel.org>; Wed,  3 Aug 2022 09:06:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o22so6602945edc.10
        for <linux-security-module@vger.kernel.org>; Wed, 03 Aug 2022 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5szB0Yt8wfbiTaP8/uH11/lZ59NOlpGeFsdpgoLNvJ8=;
        b=ic+vNPABuREX+PIjwaM+VOGEJw6oF2ebKuLtvGvb4/Hb7YaZRdZFas4fPAdzbAg7jx
         aesjy+76DTWh4E6VOx93inA8iC/941RMQo8fsSmtWm07+lOlWWxdSUMOghm1jrWvVoR4
         U/LivSCQiuMwcebAF9+j1uTdx7DTBfUBhs5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5szB0Yt8wfbiTaP8/uH11/lZ59NOlpGeFsdpgoLNvJ8=;
        b=L1naw6iAYiJwqe/JUKtFSSrzZEG8U/s569E5R4rH6UwZo7jJUojSf14gZb1SwSmVoQ
         jqbhXZU5vR11J5ajCDn1/7LL7F+wy7g6LRgH+Qm+OZ0oL/5WJwqbNNmiQ/KCgPe9dguN
         AuK3yimNTklnBeVrwLNQ5tjA8u5iTQmwfNny8SF+HgwXjg8Tq/dof983ATD4c6hwC+J5
         fDlva/A7ed03kbirjFJpyQTzxYm/Yyq+msJEzdScgVf6dKvMr/XNv8agS/xGnB3ObRJt
         +VBj8TWVEkfTolxvJZBMW5LV9YUWl5GyM/M7XZV4xRrzKaX2mZCMeQvC+t2NsORQUcjT
         Caeg==
X-Gm-Message-State: AJIora8C6KmfBMlMe+Jpm/mmO+j5Ezf/LjCHZrrxSE1d1MV2nz8S2o/i
        GmORVkFsh+731dKl1VDwuY4d7eWwdpDHusy5zOXKrQ==
X-Google-Smtp-Source: AGRyM1tY9355tF5SR98IYTJw6jtydsojrQZtfOZY+tbbLicCH00rJyvlJeK55pfPj3vsy9eOthOXBZnjsNPgYb7wPm8=
X-Received: by 2002:aa7:d813:0:b0:43c:dedd:b4e8 with SMTP id
 v19-20020aa7d813000000b0043cdeddb4e8mr26254900edq.231.1659542792573; Wed, 03
 Aug 2022 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
 <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
In-Reply-To: <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 3 Aug 2022 09:08:22 -0700
Message-ID: <CAJ-EccOP4Yq4RSBSkA_71kagqvA=a+tUV63UbHWZVM2uqJMDFQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 2, 2022 at 3:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Aug 1, 2022 at 7:40 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > This pull request contains one commit that touches common kernel code,
> >
> > one that adds functionality internal to the SafeSetID LSM code, and a
> >
> > few other commits that only modify the SafeSetID LSM selftest.
> [...]
>
> What odd MUA do you use that causes this double-spaced text email?
>
> I can read it, but it really is a bit strange. It was all plain text,
> and marked as utf-8, and otherwise looked normal except for that
> double spacing.
>
> I get flashbacks to my "writing papers at university" days.

I know, it was ugly. I just switched laptops to a Mac and thought for
sure the mail message preview I was seeing in gmail after copy+paste
from a terminal window was just some weird scaling issue on my
external monitor or something. Sure enough the message was sent off
looking like a double spaced book report from 8th grade :)

I'll have to find what's going wrong with the copy+paste to gmail on
this particular device.

>
>              Linus

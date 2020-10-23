Return-Path: <SRS0=sNlH=D6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0670FC55179
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Oct 2020 19:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5A720E65
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Oct 2020 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jmIOXw9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755687AbgJWTPC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750025AbgJWTPC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Oct 2020 15:15:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A70C0613CE
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2020 12:15:00 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l24so2568091edj.8
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2020 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icMK60GhKKKQhTV5Pyj9suVv+bBVVFbJ7wD/aCD2HK4=;
        b=jmIOXw9USFhftMZ9bsMglijHYHwg5XRQXt4roQQd8+vPY1RSnDZML19fjAPKGNz6A3
         fHLQsmrSMMWqY4FD8z9wGvG3fru1zS1ZvcDENI8ua3pA7lVDQo5PUsCNoAlYmfZpF6L4
         4rrGMJyavlk8/4PqBf9ZXjpdqSB/vcD7S0lRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icMK60GhKKKQhTV5Pyj9suVv+bBVVFbJ7wD/aCD2HK4=;
        b=eAcwg9m9fnqrJaPYOJe2WzM3ISrsdO8Otvw5FJosdGMNBmQwvHfP4iJMZOte06Q/LG
         ukmbyQJihsvhXVnzYL1kqRSP59IFv/ozB9gG3bBIrL0IIM6jjJA4bG2VOt6qOXRiPWUf
         ZV3gBVrP3ozElGKAOj9V7NO/nWKpBzvYok4/np/0sYopSTAB7uyiFOS7ny4rib6HH9/S
         YAaKvcQfYFyCa6GNNS6ZbfQyHPfOPkeI9xqGgUQX+ZSj4pOxZoEs9wAg5Imocs2m1YBa
         Ku+sZy2TuM5Dx71HDbvpDBi2v6BuqkdZOV4mZmx/qSHyZQFSdlUfvT8vPrWuGvexf015
         4buQ==
X-Gm-Message-State: AOAM530F2QzjwbxtxhlySD5kxu4poaicpQ+z43CVxDNcIGaASCrsU1gl
        gU0oHE1e839phmWH0oGkzFM8vkYiQhyQfsNbP4dp1g==
X-Google-Smtp-Source: ABdhPJzpws9M76h1oM8kMw86Lv4HFd4d+oXrZ6W+m0fuw9WVnlApbCE8QbzRooWTTpTP222JHLdK6pzRn41ISnC4AZY=
X-Received: by 2002:aa7:cf93:: with SMTP id z19mr3690893edx.26.1603480499235;
 Fri, 23 Oct 2020 12:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
 <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com> <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
In-Reply-To: <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 23 Oct 2020 12:14:47 -0700
Message-ID: <CAJ-EccMu_AGfOYASyteGosdOc1SMHeVTLax5aoZSQf7_n0Xq2Q@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 23, 2020 at 10:57 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 15, 2020 at 5:01 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > I just rebased to v5.9 to make sure the 1-line changes that touch
> > kernel/capability.c, kernel/groups.c and kernel/sys.c still applied
> > cleanly without conflicts. Should I have rebased onto one of the -rc's
> > for v5.9 instead?
>
> No. You shouldn't have rebased at all.

Ok so before the rebase ("reparent"), the commits were based on top of
some commit that was months old at this point (can't quite remember
now, I think one of the -rc's for v5.8).

I guess the lesson here is never rebase or fast-forward merge my
upstream-bound -next branch until it has emptied entirely into the
mainline? And if that doesn't happen for whatever reason during one
merge window and I have to wait for the next one, I just send you
un-reparented/un-fastforwarded possibly outdated commits and you will
resolve conflicts if any?

The reason for the rebase making sense to me here was that the changes
to common kernel code are very simple (a few one line changes) and
easy to quickly verify after the rebase -- and the vast majority of
the complexity of the code in the pull request was confined to the
SafeSetID code base, which had no changes over the time span from
original base to the reparented base. So I had basically considered it
a no-op rebase. I probably should have explained this in the pull
request.

Thanks

>
> Making sure something applies cleanly is simply not a reason to rebase.
>
> See
>
>   Documentation/maintainer/rebasing-and-merging.rst
>
> for some common rules.
>
>              Linus

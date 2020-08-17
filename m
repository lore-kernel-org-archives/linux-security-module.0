Return-Path: <SRS0=ORYe=B3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E05C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Aug 2020 22:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C099A20760
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Aug 2020 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597704723;
	bh=BLNiL+DLsRVFIcOkeCwPvYUOudP2ncDTYkPeW/BHm2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KFaR9S1O0MyAGA7ro77HnuMuLn0UvngRMFTE3QgQ8ZPymyxi6QygAN6MuMjscDv/i
	 znhjHUBd61YmK5cDEzC5rxQB3Hj/i9PoxKJBf/nWm3JSqCsJr9jbt2r/uG2uqpZn6Z
	 UnMZH0J/UYU6Y5eG22qmrQWYiM/Hh+R6kg72AgCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHQWwD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgHQWwC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Aug 2020 18:52:02 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF9C061389
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2020 15:52:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v22so13720179edy.0
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2020 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4oCLwSFAMfX0jUk1zRXnY7OWQRSXzVnX6hrYGZa4vs=;
        b=Ot97LDuE1VQD/tFXQHGZ9kal3BL+Bs8jJUmcjt3HaQFhxwhsmdVZmU7bqaxx6SHCOi
         Am2J3ry3DoqYNnlkX0YdsYu0rNFw9zoYcgEwV5ZpYnntndFXmS3jFlz+g59jSMMLNjLs
         FbV6xSzh8EqoGh9CvhAN6frNL/9IP9BgJF/YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4oCLwSFAMfX0jUk1zRXnY7OWQRSXzVnX6hrYGZa4vs=;
        b=UKJxIrdz9IXZvAUuBYrAKA3Sz+XH+8AnDsfT2JAFmvkiuNMFpqQcwp+nmDaNB5tLC2
         qVBagEXXCrZ580x0lq1qQ59AacLirPZ+mhWf+8eKHD5qIqUa1kHK6w86x4ARabm9edph
         GYsiMSCQKHm9gYJPBMofW7NhyBXYt8BazTiKJaBJ6oSSVEu7WHzeT/IfVwJCuYDrpw1B
         OltqiTWwequkn7zA7hTM9BDr8SP/TKG2Cj3jrgbPIHM/gfQxepTJKomMdpYV2VOef6kA
         lsKbPIYptw2yQ5Wi6/cm7V2R695hzb72kynuFEPJdDpWEP4hRT+rIuEb70T2kwTo9GjQ
         vR2w==
X-Gm-Message-State: AOAM532d8FTVSL8RV4OKqWw+QXS9OFKURmjmrgWj0xR76qoasyNc+QzV
        5m/zQj/oTjJBJJ3UQiKdC24cJcYRUs0H2g==
X-Google-Smtp-Source: ABdhPJwxXb46/R3LdC6iWuUT9sZC2PChenxbpNEDvaNk1Bu+HYHXmc8W3Bie6RQTa+UXgpiYlPXh9g==
X-Received: by 2002:aa7:d607:: with SMTP id c7mr16953788edr.184.1597704720279;
        Mon, 17 Aug 2020 15:52:00 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id g21sm14131720edm.65.2020.08.17.15.51.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 15:52:00 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a26so19800557ejc.2
        for <linux-security-module@vger.kernel.org>; Mon, 17 Aug 2020 15:51:59 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr8046290lju.102.1597704285617;
 Mon, 17 Aug 2020 15:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
In-Reply-To: <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 15:44:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
Message-ID: <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 17, 2020 at 10:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So it has this very complex "random structures of random things"
> implementation. It's a huge sign of over-design and "I don't know what
> the hell I want to expose, so I'll make this generic thing that can
> expose anything, and then I start adding random fields".

You can see the overdesign in other places too: that "time
granularity" is some very odd stuff. It doesn't actually even match
the kernel granularity rules, so that fsinfo interface is basically
exporting random crap that doesn't match reality.

In the kernel, we give the granularity in nsec, but for some reason
that fsinfo stuff gives it in some hand-written pseudo-floating-point
format. Why? Don't ask me.

And do we really want to have that whole odd Nth/Mth thing?
Considering that it cannot be consistent or atomic, and the complaint
against the /proc interfaces have been about that part, it really
smells completely bogus.

So please. Can we just make a simple extended statfs() and be done
with it, instead of this hugely complex thing that does five different
things with the same interface and makes it really odd as a result?

                  Linus
So honestly,  there's a

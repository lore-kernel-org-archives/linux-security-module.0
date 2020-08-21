Return-Path: <SRS0=891B=B7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE3C433E3
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A7920724
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NU0Mcks7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgHUNST (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHUNSP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Aug 2020 09:18:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF9C061387
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2020 06:18:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so1565632ejz.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2020 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ewq1eqi128tS/YtHe1Hdp0zK/pkzPgQy1G+gIZ86vk=;
        b=NU0Mcks72tdUBoRxTtGff5uEDLvy5q+04uOXS/JLA0SJHrmqdiP6jaEKtTvuhKsMgU
         lDfci7M0dnl3iqCTEKGFvbcUksW7F5hk3a91SmK7L3wWBKVmDsI9uP/rUVnGbwAsuDli
         PjLRD2P5KK/Uqcps5LzpvzKRXm9f6EQs1OMtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ewq1eqi128tS/YtHe1Hdp0zK/pkzPgQy1G+gIZ86vk=;
        b=o0DCVH7LD6i/tdKXD/ioGCAtSavzaZWxaBswvEZgMlxNgkfAd/eDoKVr3UXf02GeM0
         hN6JSuHQEZOvtL64JGn09RahCgB0GuJGFv2IqAK2gHF7RHDgAvvnhburbztLm01nzb3L
         xDqZfGeNxztzpXYGnZG1/FwsrmG9cF2sa/fLj4P73/xj1/V6iAnnU8yVcvXBgXrlUrUJ
         xZUwBiNQMayoouCkrG/GMFzKiJXz9dxEYCgS5r/Hrh8d1MypZdh4dLMwk6+IRuFXFkQR
         iPK73fz5lScp4UJB/GDDgSf9jOTUF2QAUQRyZpAMUOrnj5eiOWmGp3QxWklB5UKqwMCD
         ZJVQ==
X-Gm-Message-State: AOAM531ZW3xy4cakjYDWIpYbiE2eLCkGXZrqWtkoquVggyt6W6Y9BpEx
        Dp5JT4xUc4iXPj1VfCcYszeaXndr5raxv7sttC70oEGPNn362g==
X-Google-Smtp-Source: ABdhPJx3TSW7MukTCaIid5gIoeUYGZLVJD0O+yZ7UPk2PTQBJG9g/hYdPVKEFV4KdfwhkvYvNtwBHnp0gKnoaXGmvjM=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr2811015ejb.113.1598015890534;
 Fri, 21 Aug 2020 06:18:10 -0700 (PDT)
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
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
 <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
 <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
 <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com> <CAHk-=wiUcfgC1PdbS_4mfAj2+VTacOwD_uUu6krSxjpvh42T7A@mail.gmail.com>
In-Reply-To: <CAHk-=wiUcfgC1PdbS_4mfAj2+VTacOwD_uUu6krSxjpvh42T7A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Aug 2020 15:17:59 +0200
Message-ID: <CAJfpegsBSsMkSXReN6Sheye1cksCO2pcqcx_3VwY4C1J9kDhaw@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Aug 18, 2020 at 10:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Basically, I think a rough rule of thumb can and should be:
>
>  - stuff that the VFS knows about natively and fully is clearly pretty
> mount-agnostic and generic, and can be represented in whatever
> extended "struct statfs_x" directly.
>
>  - anything that is variable-format and per-fs should be expressed in
> the ASCII buffer
>
> Look at our fancy new fs_context - that's pretty much what it does
> even inside the kernel. Sure, we have "binary" fields there for core
> basic information ("struct dentry *root", but also things like flags
> with MNT_NOSUID), but the configuration stuff is ASCII that the
> filesystem can parse itself.
>
> Exactly because some things are very much specific to some
> filesystems, not generic things.
>
> So we fundamentally already have a mix of "standard FS data" and
> "filesystem-specific options", and it's already basically split that
> way: binary flag fields for the generic stuff, and ASCII text for the
> odd options.

Okay.

Something else:  do we want a separate statmount(2) or is it okay to
mix per-mount and per-sb attributes in the same syscall?

/proc/mounts concatenates mount and sb options (since it copies the
/etc/mtab format)

/proc/self/mountinfo separates per-mount and per-sb data into
different fields at least, but the fields themselves are mixed

If we are introducing completely new interfaces, I think it would make
sense to separate per-mount and per-sb attributes somehow.  Atomicity
arguments don't apply since they have separate locking.  And we
already have separate interfaces for configuring them...

Thanks,
Miklos

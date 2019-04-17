Return-Path: <SRS0=FWzS=ST=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A80C282DC
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42D920872
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ez4i+71s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfDQOOp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:14:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35801 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbfDQOOo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Apr 2019 10:14:44 -0400
Received: by mail-it1-f193.google.com with SMTP id w15so4565583itc.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2019 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVHgwUYB7Owzu77x+l9sz/yWkcb/YNK0x9i5/Zt2H9s=;
        b=Ez4i+71sPiwDGSFgZyWlRtbPSsTi21FdzghrDGt/UCzUncd6cp+5vuN/HcBvwPIhG9
         jt7Jt4M95/67nzmM7cyaDmhu5b3+AlXoESvEry8BxLgXzYNv0UYizeIyeVy4UHOcjjyQ
         3F5pEoKD2+tsJZNojH2FP4BgNxvFAhwxtHPGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVHgwUYB7Owzu77x+l9sz/yWkcb/YNK0x9i5/Zt2H9s=;
        b=dnNAJtBqplY53YiSY3izIAoAjo6QtWafJrI0tfulnZvDgnjsQeL3aBoG8bKZTwYGlt
         oAT/wbl73umCamOVEEeyrDricKC5ZXRfKWU7zFCvbwQt3A3DzewDJCw9BOQOoIaXbKcW
         RWmclQwOiMTsmPOky/alyy/0DS1p87mDXN7nyPcoyJcxlj1WPFv4l7zTuyby170GvzbY
         V5gOMod+HeAVSpqyaJ/wFIEc/2glzH1skCul9meuIVp8LrMUfZ38S2R2llurECxsgQBo
         6G6+hfSAdVo6Ea60MfB6cZiIQUIhjQ+rnm9sgBzBmqCfy6/deHT6JfN+hYUqT/UP98zI
         fg8g==
X-Gm-Message-State: APjAAAV7FKbr/i3qVRCQHbp3BuNZl8xEoOiuO9L/ucq2CC1VhyOmp55j
        PoihuKTf8ZF/WpeKKrzu5dUkwnUOCU9lWHG/08ZWHw==
X-Google-Smtp-Source: APXvYqwLxKGSmvh3f4KxvRaPgmLWPcF2WSpiPi7PryLDxtWJ8hNR0F3eJ64BSX2fbErVpsGSNGfLfeiyW1sSxjAhqZg=
X-Received: by 2002:a02:a50a:: with SMTP id e10mr60419474jam.104.1555510483817;
 Wed, 17 Apr 2019 07:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz> <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz> <CAJfpegsyzYTkUw7rgpQfB0BKqK-LBZh6fBMUO5iq2JHv1youzw@mail.gmail.com>
 <20190417140558.GB15563@quack2.suse.cz>
In-Reply-To: <20190417140558.GB15563@quack2.suse.cz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Apr 2019 16:14:32 +0200
Message-ID: <CAJfpegvYnnjv7uoQjL1avx5tO-0H0ZecmVK9Sgk-F1NoW0HAuw@mail.gmail.com>
Subject: Re: fanotify and LSM path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 17, 2019 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 17-04-19 14:14:58, Miklos Szeredi wrote:
> > On Wed, Apr 17, 2019 at 1:30 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > > > > I'm not so sure about directory pre-modification hooks. Given the amount of
> > > > > problems we face with applications using fanotify permission events and
> > > > > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > > > > you want to use such hooks for recording (and persisting) that some change
> > > > > is going to happen and provide crash-consistency guarantees for such
> > > > > journal?
> > > > >
> > > >
> > > > That's the general idea.
> > > > I have two use cases for pre-modification hooks:
> > > > 1. VFS level snapshots
> > > > 2. persistent change tracking
> > > >
> > > > TBH, I did not consider implementing any of the above in userspace,
> > > > so I do not have a specific interest in extending the fanotify API.
> > > > I am actually interested in pre-modify fsnotify hooks (not fanotify),
> > > > that a snapshot or change tracking subsystem can register with.
> > > > An in-kernel fsnotify event handler can set a flag in current task
> > > > struct to circumvent system deadlocks on nested filesystem access.
> > >
> > > OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
> > > handlers stay within the kernel, I'm fine with that. After all this is what
> > > LSMs are already doing. Just exposing this to userspace for arbitration is
> > > what I have a problem with.
> >
> > There's one more usecase that I'd like to explore: providing coherent
> > view of host filesystem in virtualized environments.  This requires
> > that guest is synchronously notified when the host filesystem changes.
> >   I do agree, however, that adding sync hooks to userspace is
> > problematic.
> >
> > One idea would be to use shared memory instead of a procedural
> > notification.  I.e. application (hypervisor) registers a pointer to a
> > version number that the kernel associates with the given inode.  When
> > the inode is changed, then the version number is incremented.  The
> > guest kernel can then look at the version number when verifying cache
> > validity.   That way perfect coherency is guaranteed between host and
> > guest filesystems without allowing a broken guest or even a broken
> > hypervisor to DoS the host.
>
> Well, statx() and looking at i_version can do this for you. So I guess
> that's too slow for your purposes?

Okay, missing piece of information: we want to make use of the dcache
and icache in the guest kernel, otherwise lookup/stat will be
painfully slow.  That would preclude doing statx() or anything else
that requires a synchronous round trip to the host for the likely case
of a valid cache.

> Also how many inodes do you want to
> monitor like this?

Everything that's in the guest caches.  Which means: a lot.

Thanks,
Miklos

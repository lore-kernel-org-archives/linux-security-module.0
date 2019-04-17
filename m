Return-Path: <SRS0=FWzS=ST=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06015C282DA
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A5C21773
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfDQOGC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:06:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731960AbfDQOGC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Apr 2019 10:06:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7222BAC52;
        Wed, 17 Apr 2019 14:06:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 52DC81E15AE; Wed, 17 Apr 2019 16:05:58 +0200 (CEST)
Date:   Wed, 17 Apr 2019 16:05:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: fanotify and LSM path hooks
Message-ID: <20190417140558.GB15563@quack2.suse.cz>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz>
 <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz>
 <CAJfpegsyzYTkUw7rgpQfB0BKqK-LBZh6fBMUO5iq2JHv1youzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsyzYTkUw7rgpQfB0BKqK-LBZh6fBMUO5iq2JHv1youzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed 17-04-19 14:14:58, Miklos Szeredi wrote:
> On Wed, Apr 17, 2019 at 1:30 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > > > I'm not so sure about directory pre-modification hooks. Given the amount of
> > > > problems we face with applications using fanotify permission events and
> > > > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > > > you want to use such hooks for recording (and persisting) that some change
> > > > is going to happen and provide crash-consistency guarantees for such
> > > > journal?
> > > >
> > >
> > > That's the general idea.
> > > I have two use cases for pre-modification hooks:
> > > 1. VFS level snapshots
> > > 2. persistent change tracking
> > >
> > > TBH, I did not consider implementing any of the above in userspace,
> > > so I do not have a specific interest in extending the fanotify API.
> > > I am actually interested in pre-modify fsnotify hooks (not fanotify),
> > > that a snapshot or change tracking subsystem can register with.
> > > An in-kernel fsnotify event handler can set a flag in current task
> > > struct to circumvent system deadlocks on nested filesystem access.
> >
> > OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
> > handlers stay within the kernel, I'm fine with that. After all this is what
> > LSMs are already doing. Just exposing this to userspace for arbitration is
> > what I have a problem with.
> 
> There's one more usecase that I'd like to explore: providing coherent
> view of host filesystem in virtualized environments.  This requires
> that guest is synchronously notified when the host filesystem changes.
>   I do agree, however, that adding sync hooks to userspace is
> problematic.
> 
> One idea would be to use shared memory instead of a procedural
> notification.  I.e. application (hypervisor) registers a pointer to a
> version number that the kernel associates with the given inode.  When
> the inode is changed, then the version number is incremented.  The
> guest kernel can then look at the version number when verifying cache
> validity.   That way perfect coherency is guaranteed between host and
> guest filesystems without allowing a broken guest or even a broken
> hypervisor to DoS the host.

Well, statx() and looking at i_version can do this for you. So I guess
that's too slow for your purposes? Also how many inodes do you want to
monitor like this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

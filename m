Return-Path: <SRS0=FWzS=ST=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B03FC282DA
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452A22073F
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 11:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfDQLaS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:30:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfDQLaS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Apr 2019 07:30:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D265DAF8D;
        Wed, 17 Apr 2019 11:30:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 99F8B1E15AE; Wed, 17 Apr 2019 13:30:12 +0200 (CEST)
Date:   Wed, 17 Apr 2019 13:30:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: fanotify and LSM path hooks
Message-ID: <20190417113012.GC26435@quack2.suse.cz>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz>
 <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > I'm not so sure about directory pre-modification hooks. Given the amount of
> > problems we face with applications using fanotify permission events and
> > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > you want to use such hooks for recording (and persisting) that some change
> > is going to happen and provide crash-consistency guarantees for such
> > journal?
> >
> 
> That's the general idea.
> I have two use cases for pre-modification hooks:
> 1. VFS level snapshots
> 2. persistent change tracking
> 
> TBH, I did not consider implementing any of the above in userspace,
> so I do not have a specific interest in extending the fanotify API.
> I am actually interested in pre-modify fsnotify hooks (not fanotify),
> that a snapshot or change tracking subsystem can register with.
> An in-kernel fsnotify event handler can set a flag in current task
> struct to circumvent system deadlocks on nested filesystem access.

OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
handlers stay within the kernel, I'm fine with that. After all this is what
LSMs are already doing. Just exposing this to userspace for arbitration is
what I have a problem with.

> My current implementation of overlayfs snapshots [1] uses a stackable
> filesystem (a.k.a. snapshot fs) as a means for pre-modify hooks.
> This approach has some advantages and some disadvantages
> compared to fsnotify pre-modify hooks.
> 
> With fsnotify pre-modify hooks it would be possible to protect
> the underlying filesystem from un-monitored changes even when
> filesystem is accessed from another mount point or another namespace.
> 
> As a matter of fact, the protection to underlying filesystem changes
> needed for overlayfs snapshots is also useful for standard overlayfs -
> Modification to underlying overlayfs layers are strongly discouraged,
> but there is nothing preventing the user from making such modifications.
> If overlayfs were to register for fsnotify pre-modify hooks on underlying
> filesystem, it could prevent users from modifying underlying layers.
> 
> And not only that - because security_inode_rename() hook is called
> with s_vfs_rename_mutex held, it is safe to use d_ancestor() to
> prevent renames in and out of overlay layer subtrees.
> With that protection in place, it is safe (?) to use is_subdir() in other
> hooks to check if an object is under an overlayfs layer subtree,
> because the entire ancestry below the layers roots is stable.

Uf, OK, should be. But it looks subtle. Not sure what Al will say about it
;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

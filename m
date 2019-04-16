Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE49C10F13
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E934C20868
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 15:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDPPpR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbfDPPpR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Apr 2019 11:45:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7184AEEE;
        Tue, 16 Apr 2019 15:45:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2EDC31E15B4; Tue, 16 Apr 2019 17:45:13 +0200 (CEST)
Date:   Tue, 16 Apr 2019 17:45:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: fanotify and LSM path hooks
Message-ID: <20190416154513.GB13422@quack2.suse.cz>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Amir!

On Sun 14-04-19 19:04:14, Amir Goldstein wrote:
> I started to look at directory pre-modification "permission" hooks
> that were discussed on last year's LSFMM:
> https://lwn.net/Articles/755277/
> 
> The two existing fanotify_perm() hooks are called
> from security_file_permission() and security_file_open()
> and depend on build time CONFIG_SECURITY.
> If you look at how the fsnotify_perm() hooks are planted inside the
> generic security hooks, one might wonder, why are fanotify permission
> hooks getting a special treatment and are not registering as LSM hooks?
> 
> One benefit from an fanotify LSM, besides more generic code, would be
> that fanotify permission hooks could be disabled with boot parameters.
> 
> I only bring this up because security hooks seems like the most natural
> place to add pre-modify fanotify events for the purpose of maintaining
> a filesystem change journal. It would be ugly to spray more fsnotify hooks
> inside security hooks instead of registering an fanotify LSM, but maybe
> there are downsides of registering fanotify as LSM that I am not aware of?

I kind of like the idea of generating fanotify permission events from
special LSM hooks.

I'm not so sure about directory pre-modification hooks. Given the amount of
problems we face with applications using fanotify permission events and
deadlocking the system, I'm not very fond of expanding that API... AFAIU
you want to use such hooks for recording (and persisting) that some change
is going to happen and provide crash-consistency guarantees for such
journal?

> Another observation relates to the security_path_ hooks.
> Let's take rename as an example.
> LSM could implement security_path_rename() and/or security_inode_rename()
> hooks and rename syscalls will end up calling both hooks.
> The security_path_ hooks are more attractive for fanotify, because the path
> information could be used to setup pre-modification permission mask on
> mount marks and not only on filesystem/inode marks.
> 
> One problem with security_path_ hooks is that they require an extra
> build time CONFIG_SECURITY_PATH.
> Another problem is that they seem to be bypassed by several subsystems.
> cachefiles, ecryptfs, overlayfs and nfsd all call the vfs_rename() helper, but
> only cachefiles bothers to call the security_path_rename() hook.
> This is of course true for all other security_path_ hooks.
> I think that is something that requires fixing regardless of the fanotify pre
> modification hooks. I wonder if tomoyo and apparmor developers
> (LSM that implement security_path_ hooks) are aware of those missing
> hooks?
> 
> Would love to get feedback about whether or not fanotify LSM sounds
> like a good or bad idea and about the security_path_ hooks questions.

I don't have strong opinion on using security_path_ hooks. I guess if
they're not used everywhere then it's just easier to avoid them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

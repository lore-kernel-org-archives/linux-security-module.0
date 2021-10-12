Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F758C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 10:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A74D61078
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 10:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhJLKkf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235900AbhJLKkf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 06:40:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B716961050;
        Tue, 12 Oct 2021 10:38:32 +0000 (UTC)
Date:   Tue, 12 Oct 2021 12:38:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security/landlock: use square brackets around
 "landlock-ruleset"
Message-ID: <20211012103830.s7kzijrn25ucjasr@wittgenstein>
References: <20211011133704.1704369-1-brauner@kernel.org>
 <06b6f249-06e6-f472-c74c-bb3ff6f4b4ee@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06b6f249-06e6-f472-c74c-bb3ff6f4b4ee@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 11, 2021 at 04:38:55PM +0200, Mickaël Salaün wrote:
> 
> On 11/10/2021 15:37, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Make the name of the anon inode fd "[landlock-ruleset]" instead of
> > "landlock-ruleset". This is minor but most anon inode fds already
> > carry square brackets around their name:
> > 
> >     [eventfd]
> >     [eventpoll]
> >     [fanotify]
> >     [fscontext]
> >     [io_uring]
> >     [pidfd]
> >     [signalfd]
> >     [timerfd]
> >     [userfaultfd]
> > 
> > For the sake of consistency lets do the same for the landlock-ruleset anon
> > inode fd that comes with landlock. We did the same in
> > 1cdc415f1083 ("uapi, fsopen: use square brackets around "fscontext" [ver #2]")
> > for the new mount api.
> 
> Before creating "landlock-ruleset" FD, I looked at other anonymous FD
> and saw this kind of inconsistency. I don't get why we need to add extra
> characters to names, those brackets seem useless. If it should be part

Past inconsistency shouldn't justify future inconsistency. If you have a
strong opinion about this for landlock I'm not going to push for it.
Exchanging more than 2-3 email about something like this seems too much.

> of the interface, why is it not enforced by anon_inode_getfd()?

Sure, we can add that too.

> 
> There is a lot of other names that come without brackets (e.g. inotify,
> bpf-*, btf, kvm-*, iio*). Do you plan to send patches for those too?
> Changing such FD names could break user space because they may already
> be exposed and used (e.g. through SELinux).

We didn't do it for bpf and kvm stuff because it has been that way for
a long time. We try to do it for all new ones.

Christian

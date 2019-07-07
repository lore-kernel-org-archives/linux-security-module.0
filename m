Return-Path: <SRS0=bFgB=VE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25701C5B578
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jul 2019 02:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E694420836
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jul 2019 02:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfGGCpG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Jul 2019 22:45:06 -0400
Received: from namei.org ([65.99.196.166]:33926 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfGGCpG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 22:45:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x672ihi7003745;
        Sun, 7 Jul 2019 02:44:44 GMT
Date:   Sat, 6 Jul 2019 19:44:43 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
In-Reply-To: <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1907061944050.2662@namei.org>
References: <0000000000004f43fa058a97f4d3@google.com> <201906060520.x565Kd8j017983@www262.sakura.ne.jp> <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp> <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp> <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp> <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 4 Jul 2019, Tetsuo Handa wrote:

> Hello.
> 
> Since it seems that Al has no comments, I'd like to send this patch to
> linux-next.git . What should I do? Do I need to set up a git tree?

Yes, you can create one at github or similar.


> 
> On 2019/06/22 13:45, Tetsuo Handa wrote:
> > From c63c4074300921d6d1c33c3b8dc9c84ebfededf5 Mon Sep 17 00:00:00 2001
> > From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date: Sat, 22 Jun 2019 13:14:26 +0900
> > Subject: [PATCH v2] tomoyo: Don't check open/getattr permission on sockets.
> > 
> > syzbot is reporting that use of SOCKET_I()->sk from open() can result in
> > use after free problem [1], for socket's inode is still reachable via
> > /proc/pid/fd/n despite destruction of SOCKET_I()->sk already completed.
> > 
> > But there is no point with calling security_file_open() on sockets
> > because open("/proc/pid/fd/n", !O_PATH) on sockets fails with -ENXIO.
> > 
> > There is some point with calling security_inode_getattr() on sockets
> > because stat("/proc/pid/fd/n") and fstat(open("/proc/pid/fd/n", O_PATH))
> > are valid. If we want to access "struct sock"->sk_{family,type,protocol}
> > fields, we will need to use security_socket_post_create() hook and
> > security_inode_free() hook in order to remember these fields because
> > security_sk_free() hook is called before the inode is destructed. But
> > since information which can be protected by checking
> > security_inode_getattr() on sockets is trivial, let's not be bothered by
> > "struct inode"->i_security management.
> > 
> > There is point with calling security_file_ioctl() on sockets. Since
> > ioctl(open("/proc/pid/fd/n", O_PATH)) is invalid, security_file_ioctl()
> > on sockets should remain safe.
> > 
> > [1] https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Reported-by: syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
> > ---
> >  security/tomoyo/tomoyo.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> > index 716c92e..8ea3f5d 100644
> > --- a/security/tomoyo/tomoyo.c
> > +++ b/security/tomoyo/tomoyo.c
> > @@ -126,6 +126,9 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
> >   */
> >  static int tomoyo_inode_getattr(const struct path *path)
> >  {
> > +	/* It is not safe to call tomoyo_get_socket_name(). */
> > +	if (S_ISSOCK(d_inode(path->dentry)->i_mode))
> > +		return 0;
> >  	return tomoyo_path_perm(TOMOYO_TYPE_GETATTR, path, NULL);
> >  }
> >  
> > @@ -316,6 +319,9 @@ static int tomoyo_file_open(struct file *f)
> >  	/* Don't check read permission here if called from do_execve(). */
> >  	if (current->in_execve)
> >  		return 0;
> > +	/* Sockets can't be opened by open(). */
> > +	if (S_ISSOCK(file_inode(f)->i_mode))
> > +		return 0;
> >  	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
> >  					    f->f_flags);
> >  }
> > 
> 

-- 
James Morris
<jmorris@namei.org>


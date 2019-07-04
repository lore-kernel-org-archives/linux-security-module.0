Return-Path: <SRS0=UcS9=VB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F5C06513
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jul 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F42184B
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Jul 2019 11:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfGDL64 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:58:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64348 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGDL6z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Jul 2019 07:58:55 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x64Bwod2018089;
        Thu, 4 Jul 2019 20:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 04 Jul 2019 20:58:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x64BwiPK018055
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 4 Jul 2019 20:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
 <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
 <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
Message-ID: <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
Date:   Thu, 4 Jul 2019 20:58:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello.

Since it seems that Al has no comments, I'd like to send this patch to
linux-next.git . What should I do? Do I need to set up a git tree?

On 2019/06/22 13:45, Tetsuo Handa wrote:
> From c63c4074300921d6d1c33c3b8dc9c84ebfededf5 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 22 Jun 2019 13:14:26 +0900
> Subject: [PATCH v2] tomoyo: Don't check open/getattr permission on sockets.
> 
> syzbot is reporting that use of SOCKET_I()->sk from open() can result in
> use after free problem [1], for socket's inode is still reachable via
> /proc/pid/fd/n despite destruction of SOCKET_I()->sk already completed.
> 
> But there is no point with calling security_file_open() on sockets
> because open("/proc/pid/fd/n", !O_PATH) on sockets fails with -ENXIO.
> 
> There is some point with calling security_inode_getattr() on sockets
> because stat("/proc/pid/fd/n") and fstat(open("/proc/pid/fd/n", O_PATH))
> are valid. If we want to access "struct sock"->sk_{family,type,protocol}
> fields, we will need to use security_socket_post_create() hook and
> security_inode_free() hook in order to remember these fields because
> security_sk_free() hook is called before the inode is destructed. But
> since information which can be protected by checking
> security_inode_getattr() on sockets is trivial, let's not be bothered by
> "struct inode"->i_security management.
> 
> There is point with calling security_file_ioctl() on sockets. Since
> ioctl(open("/proc/pid/fd/n", O_PATH)) is invalid, security_file_ioctl()
> on sockets should remain safe.
> 
> [1] https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
> ---
>  security/tomoyo/tomoyo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92e..8ea3f5d 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -126,6 +126,9 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>   */
>  static int tomoyo_inode_getattr(const struct path *path)
>  {
> +	/* It is not safe to call tomoyo_get_socket_name(). */
> +	if (S_ISSOCK(d_inode(path->dentry)->i_mode))
> +		return 0;
>  	return tomoyo_path_perm(TOMOYO_TYPE_GETATTR, path, NULL);
>  }
>  
> @@ -316,6 +319,9 @@ static int tomoyo_file_open(struct file *f)
>  	/* Don't check read permission here if called from do_execve(). */
>  	if (current->in_execve)
>  		return 0;
> +	/* Sockets can't be opened by open(). */
> +	if (S_ISSOCK(file_inode(f)->i_mode))
> +		return 0;
>  	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
>  					    f->f_flags);
>  }
> 


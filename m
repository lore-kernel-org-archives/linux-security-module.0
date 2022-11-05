Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FD0C4332F
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Nov 2022 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKEXvO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Nov 2022 19:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEXvN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 19:51:13 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BB12775
        for <linux-security-module@vger.kernel.org>; Sat,  5 Nov 2022 16:51:12 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 63B57839; Sat,  5 Nov 2022 18:51:11 -0500 (CDT)
Date:   Sat, 5 Nov 2022 18:51:11 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 03/10] fs,kernel: Export
 d_absolute_path()/find_task_by_pid_ns()/find_task_by_vpid()
Message-ID: <20221105235111.GA23747@mail.hallyn.com>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-3-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102171025.126961-3-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 03, 2022 at 02:10:18AM +0900, Tetsuo Handa wrote:
> CaitSith module which can be loaded using /sbin/insmod needs to be able to
> access these functions. TOMOYO module will also access these functions when
> CONFIG_SECURITY_TOMOYO=m becomes possible.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/d_path.c  | 1 +
>  kernel/pid.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 56a6ee4c6331..417e74414f19 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -234,6 +234,7 @@ char *d_absolute_path(const struct path *path,
>  		return ERR_PTR(-EINVAL);
>  	return extract_string(&b);
>  }
> +EXPORT_SYMBOL_GPL(d_absolute_path);
>  
>  static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 3fbc5e46b721..9e5224d8769c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -416,11 +416,13 @@ struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *ns)
>  			 "find_task_by_pid_ns() needs rcu_read_lock() protection");
>  	return pid_task(find_pid_ns(nr, ns), PIDTYPE_PID);
>  }
> +EXPORT_SYMBOL_GPL(find_task_by_pid_ns);
>  
>  struct task_struct *find_task_by_vpid(pid_t vnr)
>  {
>  	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
>  }
> +EXPORT_SYMBOL_GPL(find_task_by_vpid);

It would be neat if you could avoid the need for these by instead using
pidfds.

>  struct task_struct *find_get_task_by_vpid(pid_t nr)
>  {
> -- 
> 2.18.4

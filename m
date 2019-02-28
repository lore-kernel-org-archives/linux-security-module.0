Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF2C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 03:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8320815
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 03:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfB1DLY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:11:24 -0500
Received: from mail.hallyn.com ([178.63.66.53]:45716 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbfB1DLY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 22:11:24 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 2469C18; Wed, 27 Feb 2019 21:11:22 -0600 (CST)
Date:   Wed, 27 Feb 2019 21:11:22 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     mortonm@chromium.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] LSM: SafeSetID: gate setgid transitions
Message-ID: <20190228031121.GA30957@mail.hallyn.com>
References: <CAJ-EccN6FYCsHbmuWaDQmN-wseNVVJvRAwdzAu-K7_9w+nNrog@mail.gmail.com>
 <20190227200003.143808-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227200003.143808-1-mortonm@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 27, 2019 at 12:00:03PM -0800, mortonm@chromium.org wrote:
> From: Micah Morton <mortonm@chromium.org>
> 
> This patch adds a 'task_fix_setgid' LSM hook, which is analogous to the
> existing 'task_fix_setuid' LSM hook, and calls this new hook from the
> setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
> govern setgid transitions in addition to setuid transitions. This change
> also makes sure the setgid functions in kernel/sys.c call
> security_capable_setid rather than the ordinary security_capable
> function, so that the security_capable hook in the SafeSetID LSM knows
> it is being invoked from a setid function.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
> Changes since the last patch: took out the cap_task_fix_setgid stuff
> from include/linux/security.h since this hook won't be hooked by
> security/commoncap.c.
>  include/linux/lsm_hooks.h | 12 ++++++++++++
>  include/linux/security.h  |  9 +++++++++
>  kernel/sys.c              | 27 +++++++++++++++++++++------
>  security/security.c       |  6 ++++++
>  4 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 22fc786d723a..f252ed3e95ef 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -603,6 +603,15 @@
>   *	@old is the set of credentials that are being replaces
>   *	@flags contains one of the LSM_SETID_* values.
>   *	Return 0 on success.
> + * @task_fix_setgid:
> + *      Update the module's state after setting one or more of the group
> + *      identity attributes of the current process.  The @flags parameter
> + *      indicates which of the set*gid system calls invoked this hook.
> + *      @new is the set of credentials that will be installed.  Modifications
> + *      should be made to this rather than to @current->cred.
> + *      @old is the set of credentials that are being replaced
> + *      @flags contains one of the LSM_SETID_* values.
> + *      Return 0 on success.
>   * @task_setpgid:
>   *	Check permission before setting the process group identifier of the
>   *	process @p to @pgid.
> @@ -1596,6 +1605,8 @@ union security_list_options {
>  				     enum kernel_read_file_id id);
>  	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
>  				int flags);
> +	int (*task_fix_setgid)(struct cred *new, const struct cred *old,
> +				int flags);
>  	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
>  	int (*task_getpgid)(struct task_struct *p);
>  	int (*task_getsid)(struct task_struct *p);
> @@ -1887,6 +1898,7 @@ struct security_hook_heads {
>  	struct hlist_head kernel_post_read_file;
>  	struct hlist_head kernel_module_request;
>  	struct hlist_head task_fix_setuid;
> +	struct hlist_head task_fix_setgid;
>  	struct hlist_head task_setpgid;
>  	struct hlist_head task_getpgid;
>  	struct hlist_head task_getsid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 13537a49ae97..e28ef6bf6280 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -326,6 +326,8 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id);
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>  			     int flags);
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +			     int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
>  int security_task_getsid(struct task_struct *p);
> @@ -930,6 +932,13 @@ static inline int security_task_fix_setuid(struct cred *new,
>  	return cap_task_fix_setuid(new, old, flags);
>  }
>  
> +static inline int security_task_fix_setgid(struct cred *new,
> +					   const struct cred *old,
> +					   int flags)
> +{
> +	return 0;
> +}
> +
>  static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>  	return 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c5f875048aef..76f1c46ac66f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -372,7 +372,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>  	if (rgid != (gid_t) -1) {
>  		if (gid_eq(old->gid, krgid) ||
>  		    gid_eq(old->egid, krgid) ||
> -		    ns_capable(old->user_ns, CAP_SETGID))
> +		    ns_capable_setid(old->user_ns, CAP_SETGID))
>  			new->gid = krgid;
>  		else
>  			goto error;
> @@ -381,7 +381,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>  		if (gid_eq(old->gid, kegid) ||
>  		    gid_eq(old->egid, kegid) ||
>  		    gid_eq(old->sgid, kegid) ||
> -		    ns_capable(old->user_ns, CAP_SETGID))
> +		    ns_capable_setid(old->user_ns, CAP_SETGID))
>  			new->egid = kegid;
>  		else
>  			goto error;
> @@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>  		new->sgid = new->egid;
>  	new->fsgid = new->egid;
>  
> +	retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
> +	if (retval < 0)
> +		goto error;
> +
>  	return commit_creds(new);
>  
>  error:
> @@ -427,13 +431,17 @@ long __sys_setgid(gid_t gid)
>  	old = current_cred();
>  
>  	retval = -EPERM;
> -	if (ns_capable(old->user_ns, CAP_SETGID))
> +	if (ns_capable_setid(old->user_ns, CAP_SETGID))
>  		new->gid = new->egid = new->sgid = new->fsgid = kgid;
>  	else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
>  		new->egid = new->fsgid = kgid;
>  	else
>  		goto error;
>  
> +	retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
> +	if (retval < 0)
> +		goto error;
> +
>  	return commit_creds(new);
>  
>  error:
> @@ -735,7 +743,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>  	old = current_cred();
>  
>  	retval = -EPERM;
> -	if (!ns_capable(old->user_ns, CAP_SETGID)) {
> +	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
>  		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
>  		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
>  			goto error;
> @@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>  		new->sgid = ksgid;
>  	new->fsgid = new->egid;
>  
> +	retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
> +	if (retval < 0)
> +		goto error;
> +
>  	return commit_creds(new);
>  
>  error:
> @@ -858,10 +870,13 @@ long __sys_setfsgid(gid_t gid)
>  
>  	if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
>  	    gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
> -	    ns_capable(old->user_ns, CAP_SETGID)) {
> +	    ns_capable_setid(old->user_ns, CAP_SETGID)) {
>  		if (!gid_eq(kgid, old->fsgid)) {
>  			new->fsgid = kgid;
> -			goto change_okay;
> +			if (security_task_fix_setgid(new,
> +						old,
> +						LSM_SETID_FS) == 0)
> +				goto change_okay;
>  		}
>  	}
>  
> diff --git a/security/security.c b/security/security.c
> index ed9b8cbf21cf..7e936f944a66 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1574,6 +1574,12 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
>  	return call_int_hook(task_fix_setuid, 0, new, old, flags);
>  }
>  
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +			     int flags)
> +{
> +	return call_int_hook(task_fix_setgid, 0, new, old, flags);
> +}
> +
>  int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>  	return call_int_hook(task_setpgid, 0, p, pgid);
> -- 
> 2.21.0.352.gf09ad66450-goog

Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75466C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F972184A
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kYVB+Hg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbfB1QuO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:50:14 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:43177
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727861AbfB1QuO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 11:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551372612; bh=D5x/6FMbUVCHf6nMclwxB9n1ugBxGD5wQ8bqx4dGqJw=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=kYVB+Hg5BxHGIoaV5dcZWb+SqO1Ow3dYUaNby02OPLopic4SO52xvSRL1cHAjknRjR4vdPB7ibsJNmp/fX3z4KAfWUXSsBto22bD5AdFOEncbIJf6qF6qxiYdxI2AIfUACyET+wIZypyVdnyEZ4Ere1LqZURmyvmF8cg700CY4p6SNjIiyEwvvPgNYE5UEAhtDI8QaB4TfcCicAUB8qMAGFbo7WxTkfSroyAlaCjwGyOD2MIYiHvof/LHjhKzItSbPhv++AuCyPffyApan7VxNKGr58LxNzlQMC6gojP9sBX54MlP+zQO9uSU9GblkJEZDHJJEOnhTiJfSnRcBaJ0w==
X-YMail-OSG: TDt55t8VM1nBBEOzNoafOB0y81MBp8VvE3sQ6o4Q24gJbNxtqQUrfB5S9FxJGSC
 TZJMQ1SGpI6WtzArshr5Gw0DVPTB.KfCN9vrVNbZlpVeaRqYIxDBsH919g.KCZNtDoSRxlUWO87z
 zdDd5h3PHYURAdwsrsGeSCfe80Uw5z43SfxC4l_aVAQd0AehkgCrsHvuAoY5uJevtePn4Kj9MhiS
 Br9Tz4EQ8oM2K_IOeVBZ22dYY.SWV83FLwN64tt7CXF7oIwtfnMfUENrrul0G36NUL8xWeBTkefO
 QLCgTAEsUY.HNzlRLDGw5_t7CkH9Jm0ztR6tzNCpS7.NDG_asry7aY_OtoC9O5rPlLsarPusZyP3
 _uMKQeapYMQk2Yuoc7UTMy5AYTFt.P4JgkOQ1Yi7DROlJh1M5wZamX24dpmku51ZyP7XdkpB8Azl
 CmrkeQrB2eZJgyCp2aESmEHSCdraOJegw3F8IWbPlrGdefBDLsjtkUW4uiVlxlK2FWEb7JsmXasX
 4AYOIxMiriXXp5vefjynyY2_v6mPgI0huFxAQMu4OG0oUApmt.jgTevTPpuTzCGa_7ECihk6FD.T
 CFcoTVdSbugej0sr29jxViAwtjxCb07xz1LnM7Lmk4MDRJ4LMQS82DkU3zX7kIt2PrF.t2L9w4dt
 Dj5sOs3FLj4rmr_gqtgC24chmWMsIclL8NRwFHpXE9LSzU_QZMqXVOgOzUX8.aoZpAu0MApSy2I7
 l9lKSd2wC6ZrixP.9KjT23gveXsJKVsSBv_zVoIX7zxNuEltxJxaNi46ZrrhRrOFstdS1UzmtOoH
 AsEhCmxITdVMnjCAJPY0BGsnEXjto3D2LKV5Fw5Np6jE6lSd45oV_7EJ3Uv_2bGzDjfE2y4Wgh_j
 MWltFRPmq5gr8RkRDi_tY_9KmezJdkFW2D7W7DuGcp5fon6vEJ_6RErM_w2y0nGZT2.Ipcm9MGTX
 u0J.9lXU7OUb_ItudOZV5ibpOVIfW.rabG4ZQhdWQgYr48uosnCPMr9FE4q8wNae1o.Ja7RNroBr
 EoC19fWAM9GAt2oes8oVk.qM6H12TISwxGknDPFHLVZDeEqQuY_kvu6_1Sp46V_002eHDgnFwIF0
 17qjr9zLib6SJrzJpXnDlZcG_fJa6l8zJHQIw9nO4snZcUw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 Feb 2019 16:50:12 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1b83f0df145c593cdc3830ed84a1c6cd;
          Thu, 28 Feb 2019 16:50:10 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] LSM: SafeSetID: gate setgid transitions
To:     mortonm@chromium.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
References: <CAJ-EccN6FYCsHbmuWaDQmN-wseNVVJvRAwdzAu-K7_9w+nNrog@mail.gmail.com>
 <20190227200003.143808-1-mortonm@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey@schaufler-ca.com
Message-ID: <7b956d91-8cad-6678-3cc2-bfdbee95e760@schaufler-ca.com>
Date:   Thu, 28 Feb 2019 08:50:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190227200003.143808-1-mortonm@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/27/2019 12:00 PM, mortonm@chromium.org wrote:
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
> ---
> Changes since the last patch: took out the cap_task_fix_setgid stuff
> from include/linux/security.h since this hook won't be hooked by
> security/commoncap.c.
>   include/linux/lsm_hooks.h | 12 ++++++++++++
>   include/linux/security.h  |  9 +++++++++
>   kernel/sys.c              | 27 +++++++++++++++++++++------
>   security/security.c       |  6 ++++++
>   4 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 22fc786d723a..f252ed3e95ef 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -603,6 +603,15 @@
>    *	@old is the set of credentials that are being replaces
>    *	@flags contains one of the LSM_SETID_* values.
>    *	Return 0 on success.
> + * @task_fix_setgid:
> + *      Update the module's state after setting one or more of the group
> + *      identity attributes of the current process.  The @flags parameter
> + *      indicates which of the set*gid system calls invoked this hook.
> + *      @new is the set of credentials that will be installed.  Modifications
> + *      should be made to this rather than to @current->cred.
> + *      @old is the set of credentials that are being replaced
> + *      @flags contains one of the LSM_SETID_* values.
> + *      Return 0 on success.
>    * @task_setpgid:
>    *	Check permission before setting the process group identifier of the
>    *	process @p to @pgid.
> @@ -1596,6 +1605,8 @@ union security_list_options {
>   				     enum kernel_read_file_id id);
>   	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
>   				int flags);
> +	int (*task_fix_setgid)(struct cred *new, const struct cred *old,
> +				int flags);

Do you suppose that it be better to have one task_fix_id() hook and
use the flags to differentiate between uid and gid requests? Since you're
the only user of the hooks no one else should complain, and it will help
keep the LSM infrastructure from expanding unnecessarily.

>   	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
>   	int (*task_getpgid)(struct task_struct *p);
>   	int (*task_getsid)(struct task_struct *p);
> @@ -1887,6 +1898,7 @@ struct security_hook_heads {
>   	struct hlist_head kernel_post_read_file;
>   	struct hlist_head kernel_module_request;
>   	struct hlist_head task_fix_setuid;
> +	struct hlist_head task_fix_setgid;
>   	struct hlist_head task_setpgid;
>   	struct hlist_head task_getpgid;
>   	struct hlist_head task_getsid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 13537a49ae97..e28ef6bf6280 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -326,6 +326,8 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>   				   enum kernel_read_file_id id);
>   int security_task_fix_setuid(struct cred *new, const struct cred *old,
>   			     int flags);
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +			     int flags);
>   int security_task_setpgid(struct task_struct *p, pid_t pgid);
>   int security_task_getpgid(struct task_struct *p);
>   int security_task_getsid(struct task_struct *p);
> @@ -930,6 +932,13 @@ static inline int security_task_fix_setuid(struct cred *new,
>   	return cap_task_fix_setuid(new, old, flags);
>   }
>   
> +static inline int security_task_fix_setgid(struct cred *new,
> +					   const struct cred *old,
> +					   int flags)
> +{
> +	return 0;
> +}
> +
>   static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
>   {
>   	return 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c5f875048aef..76f1c46ac66f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -372,7 +372,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>   	if (rgid != (gid_t) -1) {
>   		if (gid_eq(old->gid, krgid) ||
>   		    gid_eq(old->egid, krgid) ||
> -		    ns_capable(old->user_ns, CAP_SETGID))
> +		    ns_capable_setid(old->user_ns, CAP_SETGID))
>   			new->gid = krgid;
>   		else
>   			goto error;
> @@ -381,7 +381,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>   		if (gid_eq(old->gid, kegid) ||
>   		    gid_eq(old->egid, kegid) ||
>   		    gid_eq(old->sgid, kegid) ||
> -		    ns_capable(old->user_ns, CAP_SETGID))
> +		    ns_capable_setid(old->user_ns, CAP_SETGID))
>   			new->egid = kegid;
>   		else
>   			goto error;
> @@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>   		new->sgid = new->egid;
>   	new->fsgid = new->egid;
>   
> +	retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
> +	if (retval < 0)
> +		goto error;
> +
>   	return commit_creds(new);
>   
>   error:
> @@ -427,13 +431,17 @@ long __sys_setgid(gid_t gid)
>   	old = current_cred();
>   
>   	retval = -EPERM;
> -	if (ns_capable(old->user_ns, CAP_SETGID))
> +	if (ns_capable_setid(old->user_ns, CAP_SETGID))
>   		new->gid = new->egid = new->sgid = new->fsgid = kgid;
>   	else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
>   		new->egid = new->fsgid = kgid;
>   	else
>   		goto error;
>   
> +	retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
> +	if (retval < 0)
> +		goto error;
> +
>   	return commit_creds(new);
>   
>   error:
> @@ -735,7 +743,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>   	old = current_cred();
>   
>   	retval = -EPERM;
> -	if (!ns_capable(old->user_ns, CAP_SETGID)) {
> +	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
>   		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
>   		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
>   			goto error;
> @@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
>   		new->sgid = ksgid;
>   	new->fsgid = new->egid;
>   
> +	retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
> +	if (retval < 0)
> +		goto error;
> +
>   	return commit_creds(new);
>   
>   error:
> @@ -858,10 +870,13 @@ long __sys_setfsgid(gid_t gid)
>   
>   	if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
>   	    gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
> -	    ns_capable(old->user_ns, CAP_SETGID)) {
> +	    ns_capable_setid(old->user_ns, CAP_SETGID)) {
>   		if (!gid_eq(kgid, old->fsgid)) {
>   			new->fsgid = kgid;
> -			goto change_okay;
> +			if (security_task_fix_setgid(new,
> +						old,
> +						LSM_SETID_FS) == 0)
> +				goto change_okay;
>   		}
>   	}
>   
> diff --git a/security/security.c b/security/security.c
> index ed9b8cbf21cf..7e936f944a66 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1574,6 +1574,12 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
>   	return call_int_hook(task_fix_setuid, 0, new, old, flags);
>   }
>   
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +			     int flags)
> +{
> +	return call_int_hook(task_fix_setgid, 0, new, old, flags);
> +}
> +
>   int security_task_setpgid(struct task_struct *p, pid_t pgid)
>   {
>   	return call_int_hook(task_setpgid, 0, p, pgid);

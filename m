Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED31C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 19:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CA8218CD
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 19:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Kk4m7N8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfB1TM3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:12:29 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:43074 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbfB1TM3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 14:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551381146; bh=NuRGV+s5U5nJakrgS3jK22/Fy+5OvPUFzNFHpaLVWkM=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=Kk4m7N8BsIUKjFV/ipLfg7QXS9a8gcJbq8xRw/4j4UmmDFHCFchSvdq5uErN5gG4ecZZmxUwH448G0V6vqmLHN5NH5AQg5p0qUI1+LNQckz75OlEGH7GGC4Qg3HoBnu3vbgdf2J350F/AwLXtfICoEmb4XxUfTo36KoC4YNcdV+toxc3N2/dOUJesRDUdrdd0gHw9+LT0diklgoR5IiATJKsZZJORJ6tbsfgJJjvs9qqUbXBjJmLEAIbXiD2jccyP4u/rTgtNgNYLo6RgibpFcE+EofhdrsvUYgOZnLQsJp6/xPpt0CRoOYSpJV1vKxU5iL9o6B3cIl0D9ILY/BeSA==
X-YMail-OSG: hgz6yPQVM1k_.JZZhE1r11G5ZLDhfKtXwDV.nnZGQ1repEE9gzu8er893Bm_b5P
 Hxt5KKKWvDBbd_oJSyAmEKTEyX2OknSPp8n5onvfxHcuLYrgRRcCvPolvSaWt3bzdUEnmBreVdfL
 z.SMq7utH8opmqz0PlSL2HTe8upKvE.zdBRREyKMqkzK4BCDbpa9s2V_OtsVDqRygbwEsWjSlEY_
 DzZm3kj.z34R_O2AvG7hJUFlhfAfzv2b7.LmtkfVEFN1AR2LZY.L8ehW0ubKZjv6fNwiPbJ9oaBh
 DOzcAxMZPgSQ7GUeWfJ0MGc5Awe0x3R_TSLPKqlQ9BKvGYyTk2AkFycRcoawDF4uIf0ktbvk8Hz8
 rohEzCvqwIu_y5sbg6AtbpghFKmkf6zqgwwjs50KtRYom.sifz.1.w6SQSsyRv35qHQoYphCICSr
 eBBRm93Ky5rX2eLFfPXetfiot9Mgt5AiksZ3cfjby2YU0t_LRUKHlXPZanPIcR2vfAjYOpMnudq8
 Q94Sb05x_B9hyGkWxguDIYAHbgWvQKIS97jyK7ptyKch1gXhhxZfGaojezGjBVBmNt7H0mPqfKKG
 t5RTJ9XMXCuFDApBtEhQdhc6A7kAnzMcg4AkhWpSpQ00cHffRLN7HB9AhgpzLE6oC_4RYaTTo2RU
 mMu8VAe5SS909Q94b2nuW5b9JU6xPftV906ueetxL1adSMldglk1N7d4jNQvgZAVwBmhwUbfGJsH
 i25Gi7cyuuOzTzTkohPMOZXw1wUBDyJ3bd4hnDqO3z0OeBg0iCw4I7p_BCMBdPg4HbR6O5joQ2Tz
 YLmpfi5UWoHXOLN9ScVMx6DHFBjOtfJE5Nw8XsWqyWjJN8gkU3aeH1lkMMBOV5nQPoUQJMB4CHr5
 gL3uap9pNMADO7n53A7CIXKkPOcGvGn0ulEO0UoYakhakZhJInpAcQXo5Ni2Q29s8KeCenNmd7hN
 EPdtz9h3UYtrfKy_jsQlNxqeswxgCYKsWJfjiml4yQnX_wsNy5EFt6Vp6wvuFRYP2FMye0XgeInV
 bP3VRrQHNSo1v2VOX_HemiZnDj4cCz1CxrWtYY5e24Wb353PbkkgMI9oiLoiZH9rKd4xJXs37.W5
 Aq9GBZzbri8k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 19:12:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e9f9a530006637ee3be9209e58e37010;
          Thu, 28 Feb 2019 19:12:21 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] LSM: SafeSetID: gate setgid transitions
To:     mortonm@chromium.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
References: <7b956d91-8cad-6678-3cc2-bfdbee95e760@schaufler-ca.com>
 <20190228190645.39360-1-mortonm@chromium.org>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5729464a-ff99-7ba4-531f-eadc9f64d104@schaufler-ca.com>
Date:   Thu, 28 Feb 2019 11:12:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190228190645.39360-1-mortonm@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/28/2019 11:06 AM, mortonm@chromium.org wrote:
> From: Micah Morton <mortonm@chromium.org>
>
> This patch generalizes the 'task_fix_setuid' LSM hook to enable hooking
> setgid transitions as well as setuid transitions. The hook is renamed to
> 'task_fix_setid'. The patch introduces calls to this hook from the
> setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
> govern setgid transitions in addition to setuid transitions. This patch
> also makes sure the setgid functions in kernel/sys.c call
> security_capable_setid rather than the ordinary security_capable
> function, so that the security_capable hook in the SafeSetID LSM knows
> it is being invoked from a setid function.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> Changes since the last patch: Combine the 'task_fix_setuid' and
> 'task_fix_setgid' hooks into one hook called 'task_fix_setid'.

Thank you.

>
>   Documentation/admin-guide/LSM/SafeSetID.rst |  2 +-
>   include/linux/lsm_hooks.h                   |  8 ++---
>   include/linux/security.h                    | 36 ++++++++++++++-------
>   kernel/sys.c                                | 35 ++++++++++++++------
>   security/commoncap.c                        | 20 +++++++-----
>   security/safesetid/lsm.c                    | 12 +++----
>   security/security.c                         |  4 +--
>   7 files changed, 74 insertions(+), 43 deletions(-)
>
> diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
> index 212434ef65ad..670a6544fd39 100644
> --- a/Documentation/admin-guide/LSM/SafeSetID.rst
> +++ b/Documentation/admin-guide/LSM/SafeSetID.rst
> @@ -88,7 +88,7 @@ other system interactions, including use of pid namespaces and device creation.
>   Use an existing LSM
>   -------------------
>   None of the other in-tree LSMs have the capability to gate setid transitions, or
> -even employ the security_task_fix_setuid hook at all. SELinux says of that hook:
> +even employ the security_task_fix_setid hook at all. SELinux says of that hook:
>   "Since setuid only affects the current process, and since the SELinux controls
>   are not based on the Linux identity attributes, SELinux does not need to control
>   this operation."
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 22fc786d723a..47fd04410fde 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -594,14 +594,14 @@
>    *	@size length of the file contents.
>    *	@id kernel read file identifier
>    *	Return 0 if permission is granted.
> - * @task_fix_setuid:
> + * @task_fix_setid:
>    *	Update the module's state after setting one or more of the user
>    *	identity attributes of the current process.  The @flags parameter
>    *	indicates which of the set*uid system calls invoked this hook.  If
>    *	@new is the set of credentials that will be installed.  Modifications
>    *	should be made to this rather than to @current->cred.
>    *	@old is the set of credentials that are being replaces
> - *	@flags contains one of the LSM_SETID_* values.
> + *	@flags contains one of the LSM_SET*ID_* values.
>    *	Return 0 on success.
>    * @task_setpgid:
>    *	Check permission before setting the process group identifier of the
> @@ -1594,7 +1594,7 @@ union security_list_options {
>   	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
>   	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>   				     enum kernel_read_file_id id);
> -	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
> +	int (*task_fix_setid)(struct cred *new, const struct cred *old,
>   				int flags);
>   	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
>   	int (*task_getpgid)(struct task_struct *p);
> @@ -1886,7 +1886,7 @@ struct security_hook_heads {
>   	struct hlist_head kernel_read_file;
>   	struct hlist_head kernel_post_read_file;
>   	struct hlist_head kernel_module_request;
> -	struct hlist_head task_fix_setuid;
> +	struct hlist_head task_fix_setid;
>   	struct hlist_head task_setpgid;
>   	struct hlist_head task_getpgid;
>   	struct hlist_head task_getsid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 13537a49ae97..76df3e22fed1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -95,7 +95,7 @@ extern int cap_inode_getsecurity(struct inode *inode, const char *name,
>   extern int cap_mmap_addr(unsigned long addr);
>   extern int cap_mmap_file(struct file *file, unsigned long reqprot,
>   			 unsigned long prot, unsigned long flags);
> -extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
> +extern int cap_task_fix_setid(struct cred *new, const struct cred *old, int flags);
>   extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>   			  unsigned long arg4, unsigned long arg5);
>   extern int cap_task_setscheduler(struct task_struct *p);
> @@ -128,17 +128,29 @@ extern unsigned long dac_mmap_min_addr;
>   /*
>    * Values used in the task_security_ops calls
>    */
> -/* setuid or setgid, id0 == uid or gid */
> -#define LSM_SETID_ID	1
> +/* setuid, id0 == uid */
> +#define LSM_SETUID_ID	1
>   
> -/* setreuid or setregid, id0 == real, id1 == eff */
> -#define LSM_SETID_RE	2
> +/* setreuid, id0 == real, id1 == eff */
> +#define LSM_SETUID_RE	2
>   
> -/* setresuid or setresgid, id0 == real, id1 == eff, uid2 == saved */
> -#define LSM_SETID_RES	4
> +/* setresuid, id0 == real, id1 == eff, uid2 == saved */
> +#define LSM_SETUID_RES	4
>   
> -/* setfsuid or setfsgid, id0 == fsuid or fsgid */
> -#define LSM_SETID_FS	8
> +/* setfsuid, id0 == fsgid */
> +#define LSM_SETUID_FS	8
> +
> +/* setgid, id0 == gid */
> +#define LSM_SETGID_ID	16
> +
> +/* setregid, id0 == real, id1 == eff */
> +#define LSM_SETGID_RE	32
> +
> +/* setresgid, id0 == real, id1 == eff, uid2 == saved */
> +#define LSM_SETGID_RES	64
> +
> +/* setfsgid, id0 == fsgid */
> +#define LSM_SETGID_FS	128
>   
>   /* Flags for security_task_prlimit(). */
>   #define LSM_PRLIMIT_READ  1
> @@ -324,7 +336,7 @@ int security_kernel_load_data(enum kernel_load_data_id id);
>   int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
>   int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>   				   enum kernel_read_file_id id);
> -int security_task_fix_setuid(struct cred *new, const struct cred *old,
> +int security_task_fix_setid(struct cred *new, const struct cred *old,
>   			     int flags);
>   int security_task_setpgid(struct task_struct *p, pid_t pgid);
>   int security_task_getpgid(struct task_struct *p);
> @@ -923,11 +935,11 @@ static inline int security_kernel_post_read_file(struct file *file,
>   	return 0;
>   }
>   
> -static inline int security_task_fix_setuid(struct cred *new,
> +static inline int security_task_fix_setid(struct cred *new,
>   					   const struct cred *old,
>   					   int flags)
>   {
> -	return cap_task_fix_setuid(new, old, flags);
> +	return cap_task_fix_setid(new, old, flags);
>   }
>   
>   static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c5f875048aef..615b44939238 100644
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
> +	retval = security_task_fix_setid(new, old, LSM_SETGID_RE);
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
> +	retval = security_task_fix_setid(new, old, LSM_SETGID_ID);
> +	if (retval < 0)
> +		goto error;
> +
>   	return commit_creds(new);
>   
>   error:
> @@ -539,7 +547,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
>   		new->suid = new->euid;
>   	new->fsuid = new->euid;
>   
> -	retval = security_task_fix_setuid(new, old, LSM_SETID_RE);
> +	retval = security_task_fix_setid(new, old, LSM_SETUID_RE);
>   	if (retval < 0)
>   		goto error;
>   
> @@ -597,7 +605,7 @@ long __sys_setuid(uid_t uid)
>   
>   	new->fsuid = new->euid = kuid;
>   
> -	retval = security_task_fix_setuid(new, old, LSM_SETID_ID);
> +	retval = security_task_fix_setid(new, old, LSM_SETUID_ID);
>   	if (retval < 0)
>   		goto error;
>   
> @@ -672,7 +680,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
>   		new->suid = ksuid;
>   	new->fsuid = new->euid;
>   
> -	retval = security_task_fix_setuid(new, old, LSM_SETID_RES);
> +	retval = security_task_fix_setid(new, old, LSM_SETUID_RES);
>   	if (retval < 0)
>   		goto error;
>   
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
> +	retval = security_task_fix_setid(new, old, LSM_SETGID_RES);
> +	if (retval < 0)
> +		goto error;
> +
>   	return commit_creds(new);
>   
>   error:
> @@ -817,7 +829,7 @@ long __sys_setfsuid(uid_t uid)
>   	    ns_capable_setid(old->user_ns, CAP_SETUID)) {
>   		if (!uid_eq(kuid, old->fsuid)) {
>   			new->fsuid = kuid;
> -			if (security_task_fix_setuid(new, old, LSM_SETID_FS) == 0)
> +			if (security_task_fix_setid(new, old, LSM_SETUID_FS) == 0)
>   				goto change_okay;
>   		}
>   	}
> @@ -858,10 +870,13 @@ long __sys_setfsgid(gid_t gid)
>   
>   	if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
>   	    gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
> -	    ns_capable(old->user_ns, CAP_SETGID)) {
> +	    ns_capable_setid(old->user_ns, CAP_SETGID)) {
>   		if (!gid_eq(kgid, old->fsgid)) {
>   			new->fsgid = kgid;
> -			goto change_okay;
> +			if (security_task_fix_setid(new,
> +						old,
> +						LSM_SETGID_FS) == 0)
> +				goto change_okay;
>   		}
>   	}
>   
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f1d117c3d8ae..f79d5b949a2f 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1026,27 +1026,27 @@ static inline void cap_emulate_setxuid(struct cred *new, const struct cred *old)
>   }
>   
>   /**
> - * cap_task_fix_setuid - Fix up the results of setuid() call
> + * cap_task_fix_setid - Fix up the results of setid() call
>    * @new: The proposed credentials
>    * @old: The current task's current credentials
>    * @flags: Indications of what has changed
>    *
> - * Fix up the results of setuid() call before the credential changes are
> + * Fix up the results of setid() call before the credential changes are
>    * actually applied, returning 0 to grant the changes, -ve to deny them.
>    */
> -int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
> +int cap_task_fix_setid(struct cred *new, const struct cred *old, int flags)
>   {
>   	switch (flags) {
> -	case LSM_SETID_RE:
> -	case LSM_SETID_ID:
> -	case LSM_SETID_RES:
> +	case LSM_SETUID_RE:
> +	case LSM_SETUID_ID:
> +	case LSM_SETUID_RES:
>   		/* juggle the capabilities to follow [RES]UID changes unless
>   		 * otherwise suppressed */
>   		if (!issecure(SECURE_NO_SETUID_FIXUP))
>   			cap_emulate_setxuid(new, old);
>   		break;
>   
> -	case LSM_SETID_FS:
> +	case LSM_SETUID_FS:
>   		/* juggle the capabilties to follow FSUID changes, unless
>   		 * otherwise suppressed
>   		 *
> @@ -1066,6 +1066,10 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
>   		}
>   		break;
>   
> +	case LSM_SETGID_RE:
> +	case LSM_SETGID_ID:
> +	case LSM_SETGID_RES:
> +	case LSM_SETGID_FS:
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1355,7 +1359,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
>   	LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
>   	LSM_HOOK_INIT(mmap_file, cap_mmap_file),
> -	LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),
> +	LSM_HOOK_INIT(task_fix_setid, cap_task_fix_setid),
>   	LSM_HOOK_INIT(task_prctl, cap_task_prctl),
>   	LSM_HOOK_INIT(task_setscheduler, cap_task_setscheduler),
>   	LSM_HOOK_INIT(task_setioprio, cap_task_setioprio),
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..5deffa92f25f 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -120,7 +120,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
>    * set*uid to user under new cred struct, or the UID transition is allowed (by
>    * Linux set*uid rules) even without CAP_SETUID.
>    */
> -static int safesetid_task_fix_setuid(struct cred *new,
> +static int safesetid_task_fix_setid(struct cred *new,
>   				     const struct cred *old,
>   				     int flags)
>   {
> @@ -130,7 +130,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>   		return 0;
>   
>   	switch (flags) {
> -	case LSM_SETID_RE:
> +	case LSM_SETUID_RE:
>   		/*
>   		 * Users for which setuid restrictions exist can only set the
>   		 * real UID to the real UID or the effective UID, unless an
> @@ -152,7 +152,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>   			return check_uid_transition(old->euid, new->euid);
>   		}
>   		break;
> -	case LSM_SETID_ID:
> +	case LSM_SETUID_ID:
>   		/*
>   		 * Users for which setuid restrictions exist cannot change the
>   		 * real UID or saved set-UID unless an explicit whitelist
> @@ -163,7 +163,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>   		if (!uid_eq(old->suid, new->suid))
>   			return check_uid_transition(old->suid, new->suid);
>   		break;
> -	case LSM_SETID_RES:
> +	case LSM_SETUID_RES:
>   		/*
>   		 * Users for which setuid restrictions exist cannot change the
>   		 * real UID, effective UID, or saved set-UID to anything but
> @@ -187,7 +187,7 @@ static int safesetid_task_fix_setuid(struct cred *new,
>   			return check_uid_transition(old->suid, new->suid);
>   		}
>   		break;
> -	case LSM_SETID_FS:
> +	case LSM_SETUID_FS:
>   		/*
>   		 * Users for which setuid restrictions exist cannot change the
>   		 * filesystem UID to anything but one of: the current real UID,
> @@ -256,7 +256,7 @@ void flush_safesetid_whitelist_entries(void)
>   }
>   
>   static struct security_hook_list safesetid_security_hooks[] = {
> -	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> +	LSM_HOOK_INIT(task_fix_setid, safesetid_task_fix_setid),
>   	LSM_HOOK_INIT(capable, safesetid_security_capable)
>   };
>   
> diff --git a/security/security.c b/security/security.c
> index ed9b8cbf21cf..450784fd1d2b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1568,10 +1568,10 @@ int security_kernel_load_data(enum kernel_load_data_id id)
>   }
>   EXPORT_SYMBOL_GPL(security_kernel_load_data);
>   
> -int security_task_fix_setuid(struct cred *new, const struct cred *old,
> +int security_task_fix_setid(struct cred *new, const struct cred *old,
>   			     int flags)
>   {
> -	return call_int_hook(task_fix_setuid, 0, new, old, flags);
> +	return call_int_hook(task_fix_setid, 0, new, old, flags);
>   }
>   
>   int security_task_setpgid(struct task_struct *p, pid_t pgid)

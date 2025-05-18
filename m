Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210A4A33;
	Sun, 18 May 2025 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747532143; cv=none; b=WeOSwemTz68V8gVNvp/ym+v82h2CSGBGYzqR3IwIEKnUfejjRBZ8YrqlBhwbyMVPu3EMtwTLyrdiIZf+wDwyqjgThRctIRvE4rE1NCkW6hSeW2NNccdv58BWV9+YIp45iGJ1qsx0qbelLboliTwHsSQUTmkvjK1JmVp80LhlOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747532143; c=relaxed/simple;
	bh=dY2bdDU2UDC8F5QqwzVljSy2e2MSA5CMm9j/pwKHWdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIj3aeL/lqnFkwo9dhEIv5KKGjjGgI2Mhhzr+xIdjzixWjEXRPvZltz3QP4f2B5IVDCB7kem/qJ/UjGfA8DrEDstltZSR5D7rcHfTU29K98qKCv7ho8ce/VeYYc8y36icDC6UGl1lLA/S1VJ8izKGI4NL2si2uiQqwcyVMPFNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PBQmDDj2; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PBQmDDj2"
Received: from [10.20.129.112] (unknown [204.239.251.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 508B13F788;
	Sun, 18 May 2025 01:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747532137;
	bh=brWXz+SrArjZvKTk/liqQ4oX/q3YR5Jg3vwRRoGbgp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PBQmDDj2JmE4oszu5nRL2p+ClsdK9Np88xpov+iEMYiaxFXPplMlkFyfbjF3agWT7
	 TAga0H+SJ0gDLrdcG+fc0REHk1qLDImJzYaDqBGzYz0ib96S9TA5RvGsD8nrSMOinA
	 iNoPT2RQGfRVzNqSMoYbq3asHrEvKEE5PZuf1jQEJVaW524mZwf+/dV7+i4eJT9jlU
	 czz2Hq1nnXkJALyIbaI9VNWgSYsf/VlcxahiRObvT6w5WFocmekM4osK9MmW0lCOU9
	 aLW7+D9kgtz3swTc68aD8xDaZatmcXr5R0VborUFf3SwJ5o5QZN4t4p8aM9bxT0lQQ
	 UzAUT9jVec2vg==
Message-ID: <a9588785-e03a-4a25-9172-045d3857d046@canonical.com>
Date: Sat, 17 May 2025 18:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: make __begin_current_label_crit_section()
 indicate whether put is needed
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, linux-kernel@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20250318220641.1811093-1-mjguzik@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250318220641.1811093-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 15:06, Mateusz Guzik wrote:
> Same as aa_get_newest_cred_label_condref().
> 
> This avoids a bunch of work overall and allows the compiler to note when no
> clean up is necessary, allowing for tail calls.
> 
> This in particular happens in apparmor_file_permission(), which manages to
> tail call aa_file_perm() 105 bytes in (vs a regular call 112 bytes in
> followed by branches to figure out if clean up is needed).
> 
do we have any numbers on the difference? And why not also the none underscore
versions. ie. begin_current_XXX and end_current_XXX. Admittedly they can sleep
an almost never degrade into needs put situation.


> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>   security/apparmor/include/cred.h | 21 ++++++---
>   security/apparmor/lsm.c          | 75 ++++++++++++++++++++------------
>   security/apparmor/policy.c       | 12 ++---
>   3 files changed, 67 insertions(+), 41 deletions(-)
> 
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index 7265d2f81dd5..fc5791937694 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -114,7 +114,12 @@ static inline struct aa_label *aa_get_current_label(void)
>   	return aa_get_label(l);
>   }
>   
> -#define __end_current_label_crit_section(X) end_current_label_crit_section(X)
> +static inline void __end_current_label_crit_section(struct aa_label *label,
> +						    bool needput)
> +{
> +	if (unlikely(needput))
> +		aa_put_label(label);
> +}
>   
>   /**
>    * end_label_crit_section - put a reference found with begin_current_label..
> @@ -142,13 +147,16 @@ static inline void end_current_label_crit_section(struct aa_label *label)
>    * critical section between __begin_current_label_crit_section() ..
>    * __end_current_label_crit_section()
>    */
> -static inline struct aa_label *__begin_current_label_crit_section(void)
> +static inline struct aa_label *__begin_current_label_crit_section(bool *needput)
>   {
>   	struct aa_label *label = aa_current_raw_label();
>   
> -	if (label_is_stale(label))
> -		label = aa_get_newest_label(label);
> +	if (label_is_stale(label)) {
> +		*needput = true;
> +		return aa_get_newest_label(label);
> +	}
>   
> +	*needput = false;
>   	return label;
>   }
>   
> @@ -184,10 +192,11 @@ static inline struct aa_ns *aa_get_current_ns(void)
>   {
>   	struct aa_label *label;
>   	struct aa_ns *ns;
> +	bool needput;
>   
> -	label  = __begin_current_label_crit_section();
> +	label  = __begin_current_label_crit_section(&needput);
>   	ns = aa_get_ns(labels_ns(label));
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return ns;
>   }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 7952e8cab353..c2be3c6f9d3e 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -127,14 +127,15 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
>   	struct aa_label *tracer, *tracee;
>   	const struct cred *cred;
>   	int error;
> +	bool needput;
>   
>   	cred = get_task_cred(child);
>   	tracee = cred_label(cred);	/* ref count on cred */
> -	tracer = __begin_current_label_crit_section();
> +	tracer = __begin_current_label_crit_section(&needput);
>   	error = aa_may_ptrace(current_cred(), tracer, cred, tracee,
>   			(mode & PTRACE_MODE_READ) ? AA_PTRACE_READ
>   						  : AA_PTRACE_TRACE);
> -	__end_current_label_crit_section(tracer);
> +	__end_current_label_crit_section(tracer, needput);
>   	put_cred(cred);
>   
>   	return error;
> @@ -145,14 +146,15 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
>   	struct aa_label *tracer, *tracee;
>   	const struct cred *cred;
>   	int error;
> +	bool needput;
>   
> -	tracee = __begin_current_label_crit_section();
> +	tracee = __begin_current_label_crit_section(&needput);
>   	cred = get_task_cred(parent);
>   	tracer = cred_label(cred);	/* ref count on cred */
>   	error = aa_may_ptrace(cred, tracer, current_cred(), tracee,
>   			      AA_PTRACE_TRACE);
>   	put_cred(cred);
> -	__end_current_label_crit_section(tracee);
> +	__end_current_label_crit_section(tracee, needput);
>   
>   	return error;
>   }
> @@ -221,12 +223,13 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
>   {
>   	struct aa_label *label;
>   	int error = 0;
> +	bool needput;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	if (!unconfined(label))
>   		error = aa_path_perm(op, current_cred(), label, path, 0, mask,
>   				     cond);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -524,14 +527,15 @@ static int common_file_perm(const char *op, struct file *file, u32 mask,
>   {
>   	struct aa_label *label;
>   	int error = 0;
> +	bool needput;
>   
>   	/* don't reaudit files closed during inheritance */
> -	if (file->f_path.dentry == aa_null.dentry)
> +	if (unlikely(file->f_path.dentry == aa_null.dentry))
>   		return -EACCES;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	error = aa_file_perm(op, current_cred(), label, file, mask, in_atomic);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -664,15 +668,16 @@ static int apparmor_uring_override_creds(const struct cred *new)
>   	struct aa_profile *profile;
>   	struct aa_label *label;
>   	int error;
> +	bool needput;
>   	DEFINE_AUDIT_DATA(ad, LSM_AUDIT_DATA_NONE, AA_CLASS_IO_URING,
>   			  OP_URING_OVERRIDE);
>   
>   	ad.uring.target = cred_label(new);
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	error = fn_for_each(label, profile,
>   			profile_uring(profile, AA_MAY_OVERRIDE_CRED,
>   				      cred_label(new), CAP_SYS_ADMIN, &ad));
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -688,14 +693,15 @@ static int apparmor_uring_sqpoll(void)
>   	struct aa_profile *profile;
>   	struct aa_label *label;
>   	int error;
> +	bool needput;
>   	DEFINE_AUDIT_DATA(ad, LSM_AUDIT_DATA_NONE, AA_CLASS_IO_URING,
>   			  OP_URING_SQPOLL);
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	error = fn_for_each(label, profile,
>   			profile_uring(profile, AA_MAY_CREATE_SQPOLL,
>   				      NULL, CAP_SYS_ADMIN, &ad));
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -706,6 +712,7 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
>   {
>   	struct aa_label *label;
>   	int error = 0;
> +	bool needput;
>   
>   	/* Discard magic */
>   	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
> @@ -713,7 +720,7 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
>   
>   	flags &= ~AA_MS_IGNORE_MASK;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	if (!unconfined(label)) {
>   		if (flags & MS_REMOUNT)
>   			error = aa_remount(current_cred(), label, path, flags,
> @@ -732,7 +739,7 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
>   			error = aa_new_mount(current_cred(), label, dev_name,
>   					     path, type, flags, data);
>   	}
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -742,12 +749,13 @@ static int apparmor_move_mount(const struct path *from_path,
>   {
>   	struct aa_label *label;
>   	int error = 0;
> +	bool needput;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	if (!unconfined(label))
>   		error = aa_move_mount(current_cred(), label, from_path,
>   				      to_path);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -756,11 +764,12 @@ static int apparmor_sb_umount(struct vfsmount *mnt, int flags)
>   {
>   	struct aa_label *label;
>   	int error = 0;
> +	bool needput;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	if (!unconfined(label))
>   		error = aa_umount(current_cred(), label, mnt, flags);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -984,10 +993,12 @@ static void apparmor_bprm_committed_creds(const struct linux_binprm *bprm)
>   
>   static void apparmor_current_getlsmprop_subj(struct lsm_prop *prop)
>   {
> -	struct aa_label *label = __begin_current_label_crit_section();
> +	struct aa_label *label;
> +	bool needput;
>   
> +	label = __begin_current_label_crit_section(&needput);
>   	prop->apparmor.label = label;
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   }
>   
>   static void apparmor_task_getlsmprop_obj(struct task_struct *p,
> @@ -1002,13 +1013,16 @@ static void apparmor_task_getlsmprop_obj(struct task_struct *p,
>   static int apparmor_task_setrlimit(struct task_struct *task,
>   		unsigned int resource, struct rlimit *new_rlim)
>   {
> -	struct aa_label *label = __begin_current_label_crit_section();
> +	struct aa_label *label;
>   	int error = 0;
> +	bool needput;
> +
> +	label = __begin_current_label_crit_section(&needput);
>   
>   	if (!unconfined(label))
>   		error = aa_task_setrlimit(current_cred(), label, task,
>   					  resource, new_rlim);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> @@ -1019,6 +1033,7 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
>   	const struct cred *tc;
>   	struct aa_label *cl, *tl;
>   	int error;
> +	bool needput;
>   
>   	tc = get_task_cred(target);
>   	tl = aa_get_newest_cred_label(tc);
> @@ -1030,9 +1045,9 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
>   		error = aa_may_signal(cred, cl, tc, tl, sig);
>   		aa_put_label(cl);
>   	} else {
> -		cl = __begin_current_label_crit_section();
> +		cl = __begin_current_label_crit_section(&needput);
>   		error = aa_may_signal(current_cred(), cl, tc, tl, sig);
> -		__end_current_label_crit_section(cl);
> +		__end_current_label_crit_section(cl, needput);
>   	}
>   	aa_put_label(tl);
>   	put_cred(tc);
> @@ -1133,10 +1148,11 @@ static int apparmor_unix_stream_connect(struct sock *sk, struct sock *peer_sk,
>   	struct aa_sk_ctx *new_ctx = aa_sock(newsk);
>   	struct aa_label *label;
>   	int error;
> +	bool needput;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	error = unix_connect_perm(current_cred(), label, sk, peer_sk);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	if (error)
>   		return error;
> @@ -1163,8 +1179,9 @@ static int apparmor_unix_may_send(struct socket *sock, struct socket *peer)
>   	struct aa_sk_ctx *peer_ctx = aa_sock(peer->sk);
>   	struct aa_label *label;
>   	int error;
> +	bool needput;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	error = xcheck(aa_unix_peer_perm(current_cred(),
>   					 label, OP_SENDMSG, AA_MAY_SEND,
>   					 sock->sk, peer->sk, NULL),
> @@ -1172,7 +1189,7 @@ static int apparmor_unix_may_send(struct socket *sock, struct socket *peer)
>   					 peer_ctx->label, OP_SENDMSG,
>   					 AA_MAY_RECEIVE,
>   					 peer->sk, sock->sk, label));
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return error;
>   }
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index 1f532fe48a1c..a60bb7d9b583 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -870,11 +870,11 @@ bool aa_policy_admin_capable(const struct cred *subj_cred,
>   bool aa_current_policy_view_capable(struct aa_ns *ns)
>   {
>   	struct aa_label *label;
> -	bool res;
> +	bool needput, res;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	res = aa_policy_view_capable(current_cred(), label, ns);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return res;
>   }
> @@ -882,11 +882,11 @@ bool aa_current_policy_view_capable(struct aa_ns *ns)
>   bool aa_current_policy_admin_capable(struct aa_ns *ns)
>   {
>   	struct aa_label *label;
> -	bool res;
> +	bool needput, res;
>   
> -	label = __begin_current_label_crit_section();
> +	label = __begin_current_label_crit_section(&needput);
>   	res = aa_policy_admin_capable(current_cred(), label, ns);
> -	__end_current_label_crit_section(label);
> +	__end_current_label_crit_section(label, needput);
>   
>   	return res;
>   }


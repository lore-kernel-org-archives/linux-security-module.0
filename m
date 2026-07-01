Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6A44103D
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903922; cv=none; b=EfvIvt5Xns0S+Qk2mq5F8OBBIkJxsMr9C0wO8NM3mnXIJGBE52VedjwS1oXiShwm5+KVRbEmroO+IVjSACZ44vpQnl8ZiNc4Sy0WW8cnCZ351pvgk+kT4+M9m+LT1vk9ehgk7VvCV0E5IPQFTtsS9nHtAEGTW6gQKAGJxBLUkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903922; c=relaxed/simple;
	bh=ERwP+vvrsoVRPiWZ2EwacmfSDUEn2yL7LSd55+I6A8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Waud7lK7M4X4UgSE9TKSeeoQPw2ed4hqirkNHzRDJXpNYHvM6k6UjgjvBldB/hC96T1Xa+k5TW8bbqD5G37MJQCxnuCPkQoxmtF7eIhl5KYNWtJZCC/Q91bQmu8LXzHINHkkVKc9gAaHz6bh+p9AXMd+F3qmfYArsq+8yLE4c8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Bc4dVbBe; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Bc4dVbBe"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gqxpx0P94z8qW;
	Wed,  1 Jul 2026 12:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782903560;
	bh=KHXM4Q8cgqdCYuc5TxXspS/wooq4sO7u69lklwMmjZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bc4dVbBe8lAZk8zH+jpvXQBRjyAv6cCdzyykpY5lO/ybWwV2G28OtMrKLkhpRSEvD
	 FhOGvxSsW+UMDSkHrzQQadkYWrqMIh+FTca2gx9frInRj9XVaJSNrp5/q3nkuCe3QU
	 oZ0pPyZcprjnd1NyBIPkEd3jBsbseaB7JHbif9EM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gqxpt51fhzbFq;
	Wed,  1 Jul 2026 12:59:18 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:59:14 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, 
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <20260701.ze4eph1eKo7a@digikod.net>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407200157.3874806-7-utilityemal77@gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> Create 2 kfuncs exposing control over Landlock functionality to BPF
> callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> from accessing unstable internal Landlock fields.
> 
> 1) bpf_landlock_put_ruleset releases a reference on a bpf_landlock_ruleset.
> This is properly passed to the verifier with the KF_RELEASE annotation.
> 
> 2) bpf_landlock_restrict_binprm alters the pre-committed credentials in the
> linux_binprm struct, ensuring the program will start with the specified
> landlock ruleset. Normal domain inheritance, for existing and future
> domains apply as normal.
> 
> To enable proper reference counting and destruction, a destructor is
> registered for the bpf_landlock_ruleset.
> 
> Additionally, both kfuncs are restricted to LSM programs attached to
> bprm_creds_for_exec or bprm_creds_from_file, and only sleepable varients
> of these hooks. Landlock may block because a ruleset is protected by a
> lock, so both of the above kfuncs may sleep and are KF_SLEEPABLE.
> 
> If RESTRICT_FLAGS_NO_NEW_PRIVS is set, and the task doesn't have
> CAP_SYS_ADMIN or is not already running with no_new_privs, we set the
> set_nnp_on_point_of_no_return to ensure that the next execution
> transition (but not the current one) will be subject to no_new_privs.
> 
> Running task_set_no_new_privs directly is unsafe in this path, as a
> failed execution will result in a lingering side effect of no_new_privs
> being set on the original thread.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/bpf_lsm.h |  15 +++++
>  kernel/bpf/bpf_lsm.c    | 145 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 160 insertions(+)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..1fc019c0db44 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -31,6 +31,21 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
>  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
>  
> +/*
> + * Opaque type for BPF landlock ruleset.  This is used to prevent BPF programs
> + * from directly accessing the landlock_ruleset structure, which is not designed
> + * for external use and may change in the future.
> + */
> +struct bpf_landlock_ruleset {};
> +BTF_ID_LIST_SINGLE(bpf_landlock_ruleset_btf_ids, struct, bpf_landlock_ruleset)
> +__bpf_kfunc void
> +bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset);
> +__bpf_kfunc int
> +bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
> +			     const struct bpf_landlock_ruleset *ruleset,
> +			     u32 flags);
> +__bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset);
> +
>  static inline struct bpf_storage_blob *bpf_inode(
>  	const struct inode *inode)
>  {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 0c4a0c8e6f70..5da9950aa555 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -16,6 +16,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/ima.h>
>  #include <linux/bpf-cgroup.h>
> +#include <linux/landlock.h>
>  
>  /* For every LSM hook that allows attachment of BPF programs, declare a nop
>   * function where a BPF program can be attached. Notably, we qualify each with
> @@ -447,3 +448,147 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  	}
>  	return 0;
>  }
> +
> +BTF_SET_START(bpf_landlock_kfunc_hooks)
> +BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
> +BTF_ID(func, bpf_lsm_bprm_creds_from_file)
> +BTF_SET_END(bpf_landlock_kfunc_hooks)
> +
> +BTF_KFUNCS_START(bpf_landlock_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_landlock_put_ruleset, KF_RELEASE | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_landlock_restrict_binprm, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_landlock_kfunc_btf_ids)
> +
> +BTF_ID_LIST(bpf_landlock_dtor_ids)
> +BTF_ID(struct, bpf_landlock_ruleset)
> +BTF_ID(func, bpf_landlock_put_ruleset_dtor)
> +
> +static int bpf_landlock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&bpf_landlock_kfunc_btf_ids, kfunc_id))
> +		return 0;
> +
> +	/* BPF_LSM_CGROUP programs run under classic RCU and cannot sleep. */
> +	if (prog->expected_attach_type == BPF_LSM_CGROUP)
> +		return -EACCES;
> +
> +	if (!btf_id_set_contains(&bpf_landlock_kfunc_hooks,
> +				 prog->aux->attach_btf_id))
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_landlock_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_landlock_kfunc_btf_ids,
> +	.filter = bpf_landlock_kfunc_filter,
> +};
> +
> +static int __init bpf_landlock_kfunc_init(void)
> +{
> +	const struct btf_id_dtor_kfunc bpf_landlock_dtors[] = {
> +		{
> +			.btf_id = bpf_landlock_dtor_ids[0],
> +			.kfunc_btf_id = bpf_landlock_dtor_ids[1],
> +		},
> +	};
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +					&bpf_landlock_kfunc_set);
> +	if (ret)
> +		return ret;
> +
> +	return register_btf_id_dtor_kfuncs(bpf_landlock_dtors,
> +					   ARRAY_SIZE(bpf_landlock_dtors),
> +					   THIS_MODULE);
> +}
> +
> +late_initcall(bpf_landlock_kfunc_init);
> +
> +__bpf_kfunc_start_defs();
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
> +
> +/**
> + * bpf_landlock_put_ruleset - put a Landlock ruleset
> + * @ruleset: Landlock ruleset to put
> + */
> +__bpf_kfunc void
> +bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
> +{
> +	landlock_put_ruleset((struct landlock_ruleset *)ruleset);
> +}
> +
> +/**
> + * bpf_landlock_restrict_binprm - enforce a Landlock ruleset on exec credentials
> + * @bprm: execution context providing the prepared credentials to restrict
> + * @ruleset: Landlock ruleset to enforce, may be NULL only with
> + *	LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
> + * @flags: landlock_restrict_self() flags
> + *
> + * When @flags contains LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, the request is
> + * staged through @bprm and committed only after exec reaches point-of-no-return.
> + * This guarantees that the resulting task cannot gain more privileges through
> + * later exec transitions, including when called from bprm_creds_from_file.
> + * The current execution is unaffected, and may escalate as usual until the next
> + * exec.
> + */
> +__bpf_kfunc int
> +bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
> +			     const struct bpf_landlock_ruleset *ruleset,
> +			     u32 flags)
> +{
> +	int err = landlock_restrict_cred_precheck(flags, false);

Landlock domain creation allocates memory with GFP_KERNEL_ACCOUNT, but
when called by eBPF, this should not be the case.

> +
> +	if (err)
> +		return err;
> +
> +	err = landlock_restrict_cred(bprm->cred,
> +				     (struct landlock_ruleset *)ruleset,
> +				     flags);
> +
> +	if (err)
> +		return err;
> +	/*
> +	 * Stage no_new_privs through @bprm so exec can honor it without
> +	 * mutating the current task before point-of-no-return.
> +	 */
> +	if ((flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS)
> +	    && !task_no_new_privs(current)
> +	    && !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> +		bprm->set_nnp_on_point_of_no_return = 1;
> +
> +	return err;
> +}
> +
> +/* We define stubs for these to allow ebpf programs using landlock kfuncs to load
> + * even when CONFIG_SECURITY_LANDLOCK is not enabled.
> + */
> +#else /* IS_ENABLED(CONFIG_SECURITY_LANDLOCK) */
> +
> +__bpf_kfunc void
> +bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
> +{
> +}
> +
> +__bpf_kfunc int
> +bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
> +			     const struct bpf_landlock_ruleset *ruleset,
> +			     u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif /* IS_ENABLED(CONFIG_SECURITY_LANDLOCK) */
> +
> +/* Destructor does nothing when Landlock is not enabled */
> +__bpf_kfunc void bpf_landlock_put_ruleset_dtor(void *ruleset)
> +{
> +	bpf_landlock_put_ruleset(ruleset);
> +}
> +
> +CFI_NOSEAL(bpf_landlock_put_ruleset_dtor);
> +
> +__bpf_kfunc_end_defs();
> -- 
> 2.53.0
> 
> 

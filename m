Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB499322A;
	Tue,  6 Oct 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249038; cv=none; b=kLEN9TtF3s069wNNckc67O7dwfK9i+B6Utx7fKFvob7KNbOAANpOX1slYuZuYh9WhLhx2oM1JmCSmyo/c78uV6sWc1KIgU0ELbJulC89BD+glUgYlmuFu60H8KyEBcVOh2NJQfpxBJzazmCqWMjyLGuk5uN1PTJfIgxwVjNITXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249038; c=relaxed/simple;
	bh=uKhfH3EIX8NmKWzjTKqhRERLmX3elvcDb1F2PrRI/n0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U7x6+d3P1IKyKce33Nsdz57NkSZY2H0L0Y95JZjQhTw4sHaLMB2o1RhW+i9YNXzyzDK98GSu+8Vqy449YfORQaK1A0xS8MelTMEK/tPOO+Bo9mC6iryklE9MDiAHd8ZDK0U2yOdVMn53f8CDKtDfoSMoXiTPoKQmOYpl67WqpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMGSDenC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMGSDenC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B74D1F000FF;
	Tue,  6 Oct 2026 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249036;
	bh=05HNlbXoSaSjV4USkIh4YwN1VEQltH31S4wz8K6pOAc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YMGSDenC90lH0EWTvN7ofKzeVNbjbZL32EZ6mB/GEb4catu6roKWl1oh7+gHsW4wL
	 vekUf3tCy8NSWOI/A9tWVYiccdIkhvREoeknKLYXfqdfoqhTMOQi8QwGNSuHCBZxtz
	 3KWd0qgEHXEbDAII7ezIshysT2mwPCICCiXfqGTyA4Zk7Mg1zWNz7aFmns4iVfLN1d
	 oowviIBPfbkDfXvtwKUDKtc6LyaK8rmU3aOpJvSuXRYi2sjyU7WI2r37MWInZv8shS
	 oZSMUNSYBUNMXs4otaeHjvPX0Sc/uCMZDKhki8EBS2uUaLiKEkP3oYeLeIPEon0Sks
	 s4G8L2iJAVoSg==
Content-Type: multipart/mixed; boundary="===============5123553496737365803=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <efdfa80872c26e9e1b6fe11957ecba8e1b5ffcdad421e34281ed3ebd017b5752@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-5-utilityemal77@gmail.com>
References: <20261006002020.2890858-5-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 04/12] bpf: mark struct path trusted
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:10:33 +0000 (UTC)

--===============5123553496737365803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: mark struct path trusted

TL;DR: Marking struct path trusted may let a MEM_RCU path's dentry (from the
later RCU ancestor iterator) be typed PTR_TRUSTED, so sleepable kfuncs could
possibly use a freed dentry after RCU unlock.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6308,6 +6308,10 @@ BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args) {
>  	struct sched_ext_ops *ops;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED(struct path) {
> +	struct dentry *dentry;
> +};
> +

Can this entry also apply to a struct path pointer that is MEM_RCU rather
than trusted?

check_ptr_to_btf_access() consults the same allow-list for both kinds of
parent:

	} else if (is_trusted_reg(env, reg) || is_rcu_reg(reg)) {
		...
		if (type_is_trusted(env, reg, field_name, btf_id)) {
			flag |= PTR_TRUSTED;

The commit message only justifies the entry for a trusted struct path:
"Walking a trusted struct path yields a trusted dentry - a live path never
carries a NULL dentry".  The comment above the SAFE_TRUSTED group also says
these fields are trusted even outside of an RCU critical section.  That
holds for LSM hook arguments and for paths returned by an acquiring kfunc,
but it does not seem to hold for a MEM_RCU struct path pointer.

Later commits in this series create such a pointer.  Commit 47d25368b3cc
("bpf: add a lockless path ancestor iterator") adds
bpf_iter_path_ancestors_rcu_new() with KF_RCU_PROTECTED, and
bpf_iter_path_ancestors_rcu_next() with KF_ITER_NEXT | KF_RET_NULL and no
KF_ACQUIRE.  check_kfunc_call() types the result of an iter_next on a
MEM_RCU iterator as PTR_TO_BTF_ID | MEM_RCU, and the kfunc returns
&kit->aw.pos, the walk's own borrowed position.  That commit's message says
nothing read out of the position may be passed to a kfunc demanding a
trusted argument, but with this patch the first thing a program does
breaks that rule:

	pos = bpf_iter_path_ancestors_rcu_next(&rit);	/* PTR_TO_BTF_ID | MEM_RCU */
	d = pos->dentry;	/* now PTR_TO_BTF_ID | PTR_TRUSTED */

The register d carries only PTR_TRUSTED, not MEM_RCU.
invalidate_rcu_protected_refs() only downgrades MEM_RCU registers, so d
stays trusted after bpf_rcu_read_unlock().  A sleepable LSM program could
then do:

	bpf_rcu_read_lock();
	bpf_iter_path_ancestors_rcu_new(&rit, path, 0);
	pos = bpf_iter_path_ancestors_rcu_next(&rit);
	d = pos->dentry;
	...
	bpf_iter_path_ancestors_rcu_destroy(&rit);
	bpf_rcu_read_unlock();
	bpf_get_dentry_xattr(d, ...);	/* or bpf_set_dentry_xattr() /
					   bpf_remove_dentry_xattr() */

The verifier would accept this because d is PTR_TRUSTED.  In an rcu-walk
the position holds no reference on the dentry, so the dentry may already
have been killed and freed once the RCU section has ended.  Can the
sleepable kfunc then operate on a freed dentry?

Even inside the critical section, "trusted" promises a non-zero refcount,
which the lockless walk does not provide.

The position is also storage inside the iterator on the BPF stack, and pos
is not invalidated by bpf_iter_path_ancestors_rcu_destroy().  The destroy
releases the iterator's reference id, but the registers returned by
iter_next carry neither that id nor a parent_id.  So pos->dentry can be
re-read after the slot has been overwritten with program-chosen data, and
the result is still typed as a trusted dentry.  Before this patch the same
load gave a non-trusted pointer, which kfuncs reject.

Nothing later in the series restores the invariant: the verifier.c diff for
the rest of the series (7ed5aa71ad77..70352ce0817c) does not touch
type_is_trusted(), check_ptr_to_btf_access() or this path entry.  The
selftests only read pos->dentry on the referenced iterator, so they do not
exercise this case.

Should this entry apply only to trusted/referenced struct path parents, for
example by not consulting the SAFE_TRUSTED list for MEM_RCU parents of this
type?  Alternatively, could the rcu iterator return a position that the
verifier marks PTR_UNTRUSTED, or could the rcu variant return a dentry that
is MEM_RCU-tagged instead of PTR_TRUSTED?

[ ... ]

> @@ -6360,6 +6364,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_cpu_release_args));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_attach_args));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct scx_sub_detach_args));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct path));
>
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============5123553496737365803==--

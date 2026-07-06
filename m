Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDF3806C0;
	Mon,  6 Jul 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350548; cv=none; b=iXLs8Kwg+VZ9z/KD3r95S7aED42ZwtOL1ic4qpCXUBGKpOfKNDtqI2Vlx503xDTC+9D5LrXaouCLg7A03P54spDz+m+Nh93h66y2e3rFJLiwhNOari4a4uJi9XzsHopvoUrhp9ziVMdKmTx1TZzsDjAVtkzI6fS+zyFSAJSBtO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350548; c=relaxed/simple;
	bh=IfJsPiHWWoXrbbJWVkXD3tRpkAGLCtWJ2ozFwvwMwk8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Wn2Pd7XhEuHn1T3x/cExDGQjm8LxhAkfwqHWOgx/aEx3ryLHdln5rrOEBLWzt2v+nPTLDUNfD9K7tFR3N/kSbTudvX0rQrM+H9bFG//8hkOEWUBm8f2Chfn30NiKUDdAG7319cKjlN1sR8g7WsB0YuyB63Cw1kfMh873VRU7SSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD8IHUan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD8IHUan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5991F1F00A3A;
	Mon,  6 Jul 2026 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350546;
	bh=RsPecLga164SQsQmPK7mDZo0DnyxgR5iY8eFLYfvRYY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WD8IHUank0qzKnIM/JZzAjqhjQgRboP37j/HnZbTqWSaYIgCSdsF7ZcAPQaUI6nBc
	 0uEoXK3U1UfDfI6zeR9dizpzNQogVwh1NjFrUBeRE5uNEgqJRB97FKhq31DEHhAypO
	 dx4lWTKLGAGxFQxGdC4WtOPzfmWMr3zH5iAUiEKq+ZxbuXx682RpreuSBM7vIhJUVv
	 65UQaRTzd5TH4nyD5Jgl7mtAz8bAycIecJavQsPc3jXUUv7NVvG8yuwm0AqIVGyM9U
	 6Hdwf9N9kuFgMgaC/4GTzDdoTQnIHo/UlveYJp650UGr72XLlcVFeFE2tlXsPOiHt3
	 q85eRi2Xbo12w==
Content-Type: multipart/mixed; boundary="===============6539218509217251055=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e62852261b1cd4c9e6eb790869db96faeea22280f30f603cd3545a1ce5b28c9@mail.kernel.org>
In-Reply-To: <20260706135644.326006-4-daniel@iogearbox.net>
References: <20260706135644.326006-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 3/9] bpf: Verify signed loader metadata at load time
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: kpsingh@kernel.org,James.Bottomley@hansenpartnership.com,paul@paul-moore.com,bboscaccy@linux.microsoft.com,memxor@gmail.com,torvalds@linux-foundation.org,a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 15:09:06 +0000 (UTC)

--===============6539218509217251055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A signed gen_loader program carries the programs, maps and relocations
> it installs in a metadata array map. The loader instructions are covered
> by the PKCS#7 signature, but the metadata map is not: Today the loader
> compares the map contents from within BPF against a hash baked into its
> (signed) instructions, using the kernel-cached map hash. The kernel
> itself never actually attests that the metadata the loader installs is
> the metadata that was signed.
>
> [ ... ]
>
> A signed loader binds its metadata map(s) through the existing fd_array,
> and an exclusive map is already bound to a program digest (excl_prog_hash).
> So when a signature is present, collect the exclusive maps from fd_array
> and append their frozen contents to the instructions before verification:
> The signature now covers insns || metadata_0 || metadata_1 || [...] in
> the fd_array order, and verification completes in bpf_check(), once the
> fd_array maps are resolved into used_maps, before the LSM admission hook
> and the rest of verification.
>
> [ ... ]
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This changes how the existing BPF program signing scheme attests the
loader payload, and reworks the verification that was added when
signature support first landed.

Should it carry a Fixes: tag pointing at the commit that introduced the
signing scheme, for example:

  Fixes: 349271568303 ("bpf: Implement signature verification for BPF programs")

That commit added attr->signature/signature_size/keyring_id and the
original bpf_prog_verify_signature() that only covered prog->insnsi. The
later commit ea1535e28bb3 ("bpf: Limit bpf program signature size")
already uses this same target.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e227c76a8dd9..65f53128fc33 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19909,11 +20068,27 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
>  	if (ret)
>  		goto err_free_env;
> +	if (env->signature) {
> +		ret = bpf_prog_calc_tag(env->prog);
> +		if (ret < 0)
> +			goto err_prep;
> +	}
>
>  	ret = process_fd_array(env, attr, uattr);
>  	if (ret)
>  		goto err_prep;
>
> +	if (env->signature) {
> +		ret = bpf_prog_verify_signature(env, attr, uattr.is_kernel);
> +		if (ret)
> +			goto err_prep;
> +	}
> +
> +	ret = security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
> +				     uattr.is_kernel);
> +	if (ret)
> +		goto err_prep;

This moves the security_bpf_prog_load() admission hook out of
bpf_prog_load() in syscall.c and into bpf_check(), now placed after
process_fd_array().

At this point the program instructions have already been allocated and
copied in, up to the maximum program size. Does relocating the hook here
mean that for a policy which denies a load, the denial now happens only
after that allocation, rather than before it as in the previous
placement?

This placement carries a Nacked-by from the LSM maintainer on the same
grounds, and the code keeps the hook in the new location. Is it worth
resolving that objection before this lands, or is the intent to leave it
for the merge-window decision?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28797884155
--===============6539218509217251055==--

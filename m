Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614B3803C2;
	Fri, 31 Jul 2026 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536655; cv=none; b=nllwzvXCDmsMy9zpNFi0IMlzBFIFb47Dz/QvoITeO6BX3eDNVZIntiRha1ufH08tyyWNlDZsDtOZwEKFxvk38H4VYSSq1I41rccVSznnn7oBisvjtHcbbAWdRQCSnPp8MGAGNbmlCOR2ytUZyRjQWUkk7hL63oNyhs+w5f6TK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536655; c=relaxed/simple;
	bh=dg7DH4ECrWng20zzuyJCELM/d3VJPph0b+FnHyLnIws=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ni37YdOb2rC6wZlRlraY9YszOmx00lOW/fKhvW1WhLENw5YacEqNl/KDN04N1cLRd2EnxoqUV+H9efs/J7Rybno4NC4JmyjUiSkvKr2Sj3bFcE69bQO0iE1pVs7t2sJKChs8fSIxkxHfWegGsa4+K253+osPrQjzxBMhgCzJRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZzOURUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZzOURUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB921F00AC4;
	Fri, 31 Jul 2026 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536654;
	bh=5urc2xWMNSgcZhf6FYk+0M7kGq9KoeQskqLlhD0e+Ns=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bZzOURUWbr5VlKBSNgZLztoAeYp0FaWmbCXt7tOO3DM2rmIOjdeYwYNi8wyRVW3jn
	 UnqcrtPM/ydQatf/cxKkzeASdXFVPmMZStg2mehE4jIrtKEzOBLWnscTiq8QD7q8LK
	 U2wq2NYoSIW0+6XqAU5gglSkyTU4+P1ul7stiGB0dGQYqBiA7fYyVbz9IsyIAN8QwF
	 Jzv8GYbxgsdCrwazdSxKYd6z0kKU5586dPLvwiT8qRLwXGIxe23cErBTPer7gG1PCl
	 kZtgCCTUci23ontkdT4HH7d8OGxBKx1yq4PdI8flrx/T74YOfoCRowAEenSY6hhe3x
	 YSlMDZP+I3lWw==
Content-Type: multipart/mixed; boundary="===============4593987830475460541=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7878225c787db2849d0465739ef607edc8d131207eee3af737bfed688dbdd064@mail.kernel.org>
In-Reply-To: <20260731022047.189137-8-utilityemal77@gmail.com>
References: <20260731022047.189137-8-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next 07/13] bpf: Add the LSM policy kfunc infrastructure
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:24:13 +0000 (UTC)

--===============4593987830475460541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Prepare kernel/bpf/bpf_lsm.c to host kfuncs that let BPF programs
> apply a userspace-created Landlock ruleset to an execution. The
> kfuncs will be thin front ends to the generic LSM policy kptr hooks
> (security_policy_kptr_from_fd(), security_policy_kptr_put(),
> security_bprm_enforce_policy_kptr()), invoked with LSM_ID_LANDLOCK
> so that the LSM framework's targeted dispatch only ever reaches
> Landlock's hook implementations.
>
> Because of the hook indirection, kernel/bpf/ has no build-time
> dependency on Landlock: the kfuncs are registered whenever
> CONFIG_BPF_LSM is enabled, and calling them while Landlock is
> compiled out or not enabled in the LSM order fails at runtime with
> -EOPNOTSUPP through the dispatch miss, keeping BPF program loading
> independent of the boot-time LSM configuration.
>
> Add the section hosting the kfuncs: struct bpf_landlock_ruleset, the
> opaque BTF-typed handle for a Landlock ruleset that only Landlock
> resolves; the kfunc id set, registered for both BPF_PROG_TYPE_LSM and
> BPF_PROG_TYPE_SYSCALL; and the kfunc filter.  The two program types
> share their kfunc lookup buckets with other program types, so
> restricting the kfuncs to them requires a filter.  The set starts
> empty and the filter has no per-kfunc rules yet; the following
> patches add the kfuncs together with their filter rules.

This isn't a bug, but could the last paragraph be trimmed to the
shared-bucket rationale? The rest enumerates what the diff already shows,
and the same sentence about shared buckets appears as a comment above the
filter function.

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index d847a180489f9..dd58c5bd01193 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -473,3 +473,53 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  	}
>  	return 0;
>  }
> +
> +/* LSM policy kfuncs */
> +
> +/*
> + * Opaque handle for a Landlock ruleset.  Only Landlock resolves it.
> + */
> +struct bpf_landlock_ruleset {};
> +
> +BTF_KFUNCS_START(bpf_landlock_kfunc_ids)
> +BTF_KFUNCS_END(bpf_landlock_kfunc_ids)

[ ... ]

> +static int __init bpf_lsm_policy_kfunc_init(void)
> +{
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +					&bpf_landlock_kfunc_set);
> +	if (ret)
> +		return ret;
> +
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&bpf_landlock_kfunc_set);
> +}
> +late_initcall(bpf_lsm_policy_kfunc_init);

This isn't a bug, but since the empty set makes both
register_btf_kfunc_id_set() calls return early in btf_populate_kfunc_set(),
this patch has no effect on its own.

Would it read more naturally folded into the patch that adds the first
kfunc, so the set, the filter arms, and the registration land together with
a user?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30599733854
--===============4593987830475460541==--

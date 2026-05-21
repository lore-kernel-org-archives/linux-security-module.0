Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215736896D;
	Thu, 21 May 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379408; cv=none; b=qVsuHdI2/VEqI6Ajiy6EmefI+q97rlNQxVB7Fp2wyF08qCFxScWfJgAbRBn9FVTq+w/aywv5QZ1vOwvWjhcmuIqB4uJNW7/UnKoiTatWwvpyIB88mzRNG80vD7taxoTRPbkLAA6K7Z/FcpSPwixC3x1FZOp1Q5cSKSuO4yJv7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379408; c=relaxed/simple;
	bh=1dnmh8xogi5NWZrg1ekb4PvjpkiCj37/yUJi67sS9A4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s9k5uI4KhYdlgKKqwqbnTtCCBEnFO0JRACAPFnWW055ry5swxLZd3MQ1yvM5p1ZUUcTzDWbjyExTr1dJW3N0MiyA9wzLtqlEehr5iX0bDs+DvBt/PBF0f7aONdVEAb7/68rA5uoT7ZbjpD5kcmYodXso53mv9ieBB4ubAJZZbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO4T5T3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO4T5T3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799641F000E9;
	Thu, 21 May 2026 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379406;
	bh=5nJ80421wV3UxtJpKcwIrzMmrkGpKYFW2EvDCz9f2HU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nO4T5T3iREq6OgMEra1das9TuMhUElw1cLqLvRtTTCGtE2rbRv4OPrG6WlaXEOvnO
	 NFjbyEJawcCU9kK65tG0CHPAocdbt48Lihh56N3smvpSDDGH7f7ZwFaZB195W8JVPx
	 ElMyrwBHjq6Pqrhxm2XleEyT2/5IhlAXgXgcH0HYTLzCC3g8+l40Kzx2wtLtS7v5Ih
	 2DjBoba6j1r3vJNMHGSlw2YCX9PDm5J60rWnuKAPqXZKkoTd1h6w1ZapzeKwnDtfei
	 kbgv1PF1P0Zxcig4dli55Ehiy8ucKZz2hzGj83Glq+dJ7rtA0wfjoGjn6ENcen1iye
	 Q1j3/z79spplw==
Content-Type: multipart/mixed; boundary="===============6055013505125852880=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <175434ddb7a67a9b1b6fcbd284a7ce5c41e9372658573faf7afbfac8f499a893@mail.kernel.org>
In-Reply-To: <20260521152217.2345235-3-kpsingh@kernel.org>
References: <20260521152217.2345235-3-kpsingh@kernel.org>
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
From: bot+bpf-ci@kernel.org
To: kpsingh@kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 16:03:26 +0000 (UTC)

--===============6055013505125852880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1b28cacc3075..5f1ed0823892 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -295,6 +295,7 @@ struct bpf_map_owner {
>
>  struct bpf_map {
>  	u8 sha[SHA256_DIGEST_SIZE];
> +	__bpf_md_ptr(char *, excl_prog_sha);
>  	const struct bpf_map_ops *ops;
>  	struct bpf_map *inner_map_meta;
>  #ifdef CONFIG_SECURITY
> @@ -335,7 +336,6 @@ struct bpf_map {
>  	atomic64_t sleepable_refcnt;
>  	s64 __percpu *elem_count;
>  	u64 cookie; /* write-once */
> -	char *excl_prog_sha;
>  };

[ ... ]

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f26..fee35c26deb8 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -600,6 +600,22 @@ static void emit_signature_match(struct bpf_gen *gen)
>  			gen->error = -ERANGE;
>  		}
>  	}
> +
> +	/* Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */

This isn't a bug, but the multi-line comment opening should follow the
BPF subsystem style with /* on its own line.

> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE * sizeof(__u64)));
> +	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
> +	if (is_simm16(off)) {
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
> +	} else {
> +		gen->error = -ERANGE;
> +	}
>  }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> index e2767d27d8aa..baef2e93cb41 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> @@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
>  	: __clobber_all);
>  }
>
> -/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, accessing
> - * into this array is valid. The opts field is now at offset 33.
> +/* The first 32 bytes of struct bpf_map are the SHA256 hash; accessing into
> + * this array is valid. excl_prog_sha follows at offset 32 (8 bytes via
> + * __bpf_md_ptr), then ops at offset 40. Reading at offset 41 crosses into
> + * the ops pointer and must be rejected.
>   */
>  SEC("socket")
>  __description("bpf_map_ptr: read non-existent field rejected")
>  __failure
> -__msg("cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4")
> +__msg("cannot access ptr member ops with moff 40 in struct bpf_map with off 41 size 4")
>  __failure_unpriv
>  __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
>  __flag(BPF_F_ANY_ALIGNMENT)
> @@ -85,7 +87,7 @@ __naked void read_non_existent_field_rejected(void)
>  	asm volatile ("					\
>  	r6 = 0;						\
>  	r1 = %[map_array_48b] ll;			\
> -	r6 = *(u32*)(r1 + 33);				\
> +	r6 = *(u32*)(r1 + 41);				\
>  	r0 = 1;						\
>  	exit;						\
>  "	:


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26236267798
--===============6055013505125852880==--

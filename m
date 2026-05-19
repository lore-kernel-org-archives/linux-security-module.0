Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6956372B2F;
	Tue, 19 May 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231044; cv=none; b=GihvGQt/qA0hE9Ofx/i95mlJtfIAc5SYhSPGRu3jJwOV0fjWOyHkP6UMI9MblRf2wIt8lvWC3o1NdcOlBVct17Jzpwly0djUwrK9gagAyrz/Rl/BFTueGGeqcCZoZ7fGIdQKyZVcLAIL8ROwyDygsvyjq4oub8UJjjVDnSfEhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231044; c=relaxed/simple;
	bh=ma37e1TvqJ+8cp03536G5SjWX+UC49CPuNlXF4hBRp8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iW+Kmb6gO1AEWNKxnO9ifpevt8huxzEoObzs9H4LKGVZfLlnfZ4mpBB4SzNLsOJpg69eGn5o2Gn0psno9+YSpnAgWRZyJ9l6P+8f2TZ1d8Z40uWBkSOHxn4XYKSGARuY4IF6/mxpc2tDqsN/9jT2i68olywPUUxpwAN4+Ps1rsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/78I1Z+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/78I1Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858181F000E9;
	Tue, 19 May 2026 22:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231039;
	bh=e07dYOZ1O7O9xiRSQh1fFgPYQyT0Cf4CPuHRsReHHoc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a/78I1Z+hx/JgYIQTbCB9hlbbqGwdZBp/Wu7rA3hWocZIuM+wFibH86PvcKHQbW7h
	 pQgOgiQjSrkJpQDUBYESQ9bANiZ3iL2wssezlg1rClxPJsseah+l7lAf2MTqomvHTl
	 wQxJEoOsHXpvVSF0NXnMuemQ1keZT/lRvcMWA1MX6e8rz8WfAAgMIXJvpESMvI79hs
	 qEZBZ9/M801Ocx0z1PjChj5kfg4MVUPtlStPdJEgxy18SU5wUNaqMzX9lZRO4jZiTq
	 L0/yPxQ5DWTrvmkKWvowPFr1iFgm/8INQBbpoKy1xJePKiMmtwqeHeqmUYx6ECTr6I
	 mnkelTTOcyrfg==
Content-Type: multipart/mixed; boundary="===============7211316248304961177=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65f684d9106f36c0005386ed635e64c794eeecff31e86f3352111cc9f9a9d846@mail.kernel.org>
In-Reply-To: <20260519215358.126364-1-kpsingh@kernel.org>
References: <20260519215358.126364-1-kpsingh@kernel.org>
Subject: Re: [PATCH] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
From: bot+bpf-ci@kernel.org
To: kpsingh@kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 22:50:39 +0000 (UTC)

--===============7211316248304961177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Signed-off-by: KP Singh <kpsingh@kernel.org>

This looks like a bug fix for the signed loader.  Should this include:

  Fixes: 66a1025f7f0b ("Merge tag 'soc-newsoc-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h

[ ... ]

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d..becfda5b9025 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -601,6 +601,23 @@ static void emit_signature_match(struct bpf_gen *gen)
>  			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
>  		}
>  	}
> +
> +	/* Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */

This isn't a bug, but the BPF subsystem coding-style rule requires
multi-line comments to have the opening /* on its own line, with the
comment text starting on the next line. This applies to tools/lib/bpf/
even when surrounding code in the same file uses the old style:

    /*
     * Reject if the metadata map is not exclusive. Without exclusivity
     * the cached map->sha[] verified above can be stale: another BPF
     * program with map access could have mutated the contents between
     * BPF_OBJ_GET_INFO_BY_FD and loader execution.
     */

> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE * sizeof(__u64)));
> +	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
> +	if (is_simm16(off)) {
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
> +	} else {
> +		gen->error = -ERANGE;
> +		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> +	}
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26127913079
--===============7211316248304961177==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC373391851;
	Fri, 22 May 2026 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489692; cv=none; b=g3QOz5/Er/bO2iTOkfzQIOWoLwe8v/gBzU4/IJkzpwO3jm9OO6rJ9Gu9G/NsKuiI+c2YpLFAWeKsFKKedFc5qtDzt5ca/5xJTMp4ZyXdrlZKWEreRsE8/G8Vx99biVzJXPmUR22RoFs3O1fotE1wdURx3Ne+RaVCd7iBRNHRh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489692; c=relaxed/simple;
	bh=pZke+IVMt8oCaCV7MpkA3p+Ni22gDPUzdWZu4B3C/DE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D802WwyZNSO0UUZQfSoNCARZXNrS99oMhcQCsvXrTEG2SC44UtpcMgBtN2BDAqwDS1j7/WlMnXVnBPriHd3bG0JDPNyTv8Fasvwo+Lf5rPcveA3vGepsihH8iZ0duJRYYpG0K54MCl77zzBKTQgGVUOJnlhoBE0EvkYT1CEep00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmBNBX88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmBNBX88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C1E1F000E9;
	Fri, 22 May 2026 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489690;
	bh=+9B1KgSR5HXxdioJsjoITH3Qkcn/wKgVGsFeHFUyjBs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FmBNBX88nyS2L4/hpjC1OhhnpK16Vjit3GbUql+sxWZINKEwl4CSQtlF3DTyk7i4f
	 jAc2A2XQaugDSDJAPb0At/QUMBBDr3hQ8cvCkIYmHVPaApgpikT962eEczut1g2pKf
	 OiLj5iQNSFDQUF1i8bWRn8MT6STfNvzXiJjLd4UNzSeNBrYmHPqQLyH+EJC1+149Qx
	 /tJzgCKfQB270Fey8C+vJBaoNni9wDhGgz42tdcXCf8SKDjlQ4Vwf5dudS3W15A2Ob
	 DvDSyWQfx+A21l2Bp4Zs+vllxOoJNhz9qIvMrE69O8CZqm8QWl8yD+c21VQIX2ATUf
	 DGu9xEURhFDmw==
Content-Type: multipart/mixed; boundary="===============0407177260780052583=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <353cdf9930517e168ad8ca869faddae35855a57380c02c320c63409fccfb1e63@mail.kernel.org>
In-Reply-To: <20260522215337.662271-3-kpsingh@kernel.org>
References: <20260522215337.662271-3-kpsingh@kernel.org>
Subject: Re: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
From: bot+bpf-ci@kernel.org
To: kpsingh@kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 22 May 2026 22:41:30 +0000 (UTC)

--===============0407177260780052583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd191c5fdb0a..11bec73db199 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -295,6 +295,7 @@ struct bpf_map_owner {
>
>  struct bpf_map {
>  	u8 sha[SHA256_DIGEST_SIZE];
> +	char *excl_prog_sha;

Daniel Borkmann suggested adding BUILD_BUG_ON checks to validate the
struct layout assumptions that gen_loader relies on. Specifically:

  BUILD_BUG_ON(offsetof(struct bpf_map, sha) != 0);
  BUILD_BUG_ON(offsetof(struct bpf_map, excl_prog_sha) != SHA256_DIGEST_SIZE);
  BUILD_BUG_ON(sizeof_field(struct bpf_map, excl_prog_sha) != sizeof(__u64));

Would this make the code more robust against future struct layout changes?

>  	const struct bpf_map_ops *ops;
>  	struct bpf_map *inner_map_meta;
>  #ifdef CONFIG_SECURITY

[ ... ]

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f26..5077472b9fd2 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -600,6 +600,23 @@ static void emit_signature_match(struct bpf_gen *gen)
>  			gen->error = -ERANGE;
>  		}
>  	}
> +
> +	/*
> +	 * Reject if the metadata map is not exclusive. Without exclusivity
> +	 * the cached map->sha[] verified above can be stale: another BPF
> +	 * program with map access could have mutated the contents between
> +	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> +	 */
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +					 0, 0, 0, 0));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE * sizeof(__u64)));

Will this BPF_DW (8-byte) read pass the BPF verifier on 32-bit
architectures?

Sashiko AI flagged this in v2, and you confirmed through testing on a
32-bit kernel that the verifier rejects this with 'cannot access ptr
member excl_prog_sha with moff 0 in struct (anon) with off 0 size 8'.
The issue is that __bpf_md_ptr doesn't emit padding in BTF; the kernel's
BTF represents the pointer member with a size of 4 bytes on 32-bit
systems, while btf_struct_walk() enforces exact size matching.

The commit message acknowledges this: 'The 8-byte read of the pointer
field limits this to 64-bit kernels; gen_loader needs target pointer
size tracking to emit the right sized read on 32-bit (follow-up).'

This means the security check will be silently bypassed on 32-bit
systems until the follow-up is implemented.

Could SHA256_DIGEST_SIZE be used here instead of 'SHA256_DWORD_SIZE *
sizeof(__u64)'? Daniel Borkmann pointed out that SHA256_DWORD_SIZE is
already SHA256_DIGEST_SIZE / sizeof(__u64), so the multiplication
essentially reconstructs SHA256_DIGEST_SIZE.

> +	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
> +	if (is_simm16(off)) {
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
> +	} else {
> +		gen->error = -ERANGE;
> +	}
>  }

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26314489328
--===============0407177260780052583==--

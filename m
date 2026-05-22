Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF3255F2C;
	Fri, 22 May 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489690; cv=none; b=b/nkrrRCGqP3Jx5EMHLWnDKUfgGP5ridMmXVNFo08eEl5LCtpPKCQwWQZhZlbufJ3r4uBHKSG9HF+JERKPv+Ppser7RG1pxaDkIe5JsusuLrJPJ04a5tjnrVSm6ebndytT/oqjqAoKCUzAWm1k1Q28yvFUvAL2H+uH2rhJTkK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489690; c=relaxed/simple;
	bh=OMFRBUDa4OgFrNeOWUnfanl7Wcvk1qt5nsJibyYxnxw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QWa9ZXuA/u1uBb8g+Lv5TmzuihI9L6LVi2lpfwXsKww0KMAYiownuTM8IoLDRW0YqtIlx34NT35GxpCHqVgaiI/aOxTYpjVm4bxF5mRHhpnNslDkmNDJD2eTfYaBnNAgozFMeMu/Ksapm+oRVJ8tCesv9OLD8OzxJGjhLHaCWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn/P0PI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn/P0PI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D691F000E9;
	Fri, 22 May 2026 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489689;
	bh=pTcHRJyCTeWoRwkx0g4t7faujzuaI6uFlOVCLCSV6sg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fn/P0PI6xQhaDE0r49lIyzKltEC+Rw/TH1Y06Q5cy+QaeGPmmajuqvBE1s690rhIE
	 irZJdYEMpQPpAsSXmUwNfa86hCG02NOPxz6wIMlgVyhM1XsPW/50DLNGe5O1moDh+N
	 NrHDEjfnJPR1jLBUFGz9mfGycz7SsdicGNcBafjdpbsvXE6gazRw/dPS7HtjmENCDh
	 Iwr9UbNvKm2JHQQBVE/m4TwBLpuYAV6kEsq/kh8XiePoOeqAgxxgq9OGWnSIE2mg/o
	 rVFogOBlUhlIUMQXcBNVvSHLQ20CZjfiC6oNDolAKy3nOYBmn+O+Co2vpDXHnIADPq
	 f2/gsZp5ERK9g==
Content-Type: multipart/mixed; boundary="===============9139462003770609073=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f674e3d18a742153bf15aed1c8987e73a0d83e9e64cb51fe1738b2d22dd1dac9@mail.kernel.org>
In-Reply-To: <20260522215337.662271-2-kpsingh@kernel.org>
References: <20260522215337.662271-2-kpsingh@kernel.org>
Subject: Re: [PATCH bpf v3 1/2] libbpf: fix off-by-one in emit_signature_match jump offset
From: bot+bpf-ci@kernel.org
To: kpsingh@kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 22 May 2026 22:41:28 +0000 (UTC)

--===============9139462003770609073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")

Daniel Borkmann reviewed v2 and pointed out that the Fixes tag
references the wrong commit. The commit fb2b0e290147 only modified
tools/lib/bpf/skel_internal.h and did not touch emit_signature_match.
He suggested using ea923080c145 ("libbpf: Embed and verify the
metadata hash in the loader") instead.

Reference: https://lore.kernel.org/bpf/a9345efb-b691-4fc1-9bad-d571bd324c25@iogearbox.net/

The search for the correct Fixes tag confirmed that fb2b0e290147 did
not introduce the emit_signature_match function or the buggy jump
offset calculation in tools/lib/bpf/gen_loader.c. The true origin
commit could not be determined in this repository's history.

Should the Fixes tag be updated to point to the commit that actually
introduced the emit_signature_match function with the buggy offset
calculation?

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cd5c2543f54d..9478b8f78f26 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -592,13 +592,12 @@ static void emit_signature_match(struct bpf_gen *gen)
>  		gen->hash_insn_offset[i] = gen->insn_cur - gen->insn_start;
>  		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
>
> -		off =  -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
> +		off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
>  		if (is_simm16(off)) {
>  			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
>  			emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
>  		} else {
>  			gen->error = -ERANGE;
> -			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
>  		}
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26314489328
--===============9139462003770609073==--

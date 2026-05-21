Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3936896D;
	Thu, 21 May 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379406; cv=none; b=NCKNI5qAd8WOiYNXxbhxyXUdK+texR95FiRoS6MAGDDAJPpTWPcaQ7X86/FR7vdH+4BIzf2ylchkPNH6xGSbm6BKhFNyuoZ38UIjNUez/PHkiJUakI3yxckImTjC3oiszmdsrSN9B5mJEep1w+94/N5+u4i0z3xWeyRJYOhLcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379406; c=relaxed/simple;
	bh=Zx/48Wbletq66jRNKsgsbxVIzD2FBDmm45dGrcls5y4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pb4MoWk1/20bbzRHuqf0y8fOu9Vg0piqRBQQLttsA5qs2vPY1dcceg0ZY3ntuPRl6KAfr8DZ/JtBIYkki8wNY0ykYaT83zM4GT+s9W0HKfvzYw4RqO1YnjWejR6QcUf1H8WjdDpa+bskZ95FFYPdq6o2wofM3L6vzmAVOOFU03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+ai3L0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+ai3L0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB0A1F000E9;
	Thu, 21 May 2026 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379404;
	bh=L09czsUCJ+2zWHrPFOXJ59b9++GMMdi30eYSufOG5ZA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D+ai3L0pYIIEoz/yfw5ujgYbMCG5rUdnveVEoQQR2NzqtxeOu2N/UAmEJd/FrMbTJ
	 3Y6Gs7+S/J7NPxLmPXHX4F8L5+uJZ0vT2UBbvENFxt++Alrkobt1FYPPGZ7NHxRMCi
	 ELJFAWWIn9i84edi/WDjucRr9L9lqcynImoRMX/aZbWelHDbxest8jjkcb8Y4sEoSx
	 SzXaNqWC1YCUlEZp2XhLX5gIZ0G3A91tAgSNyXDQ/SfPoXt9s6gvU7MxcBRYsFqrmX
	 Ko2y7bY6yYmMOauAZ5zzc6q9iLY7HVhUdBBK57TqlbEHcq+6YfkfVLAg3vm0tRPuTs
	 eAG89Amp/rG9A==
Content-Type: multipart/mixed; boundary="===============5083902027131865910=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4254fb41e84a6440bb0b97e76be6d8d156880f53314a2a06421b5f262d610a6@mail.kernel.org>
In-Reply-To: <20260521152217.2345235-2-kpsingh@kernel.org>
References: <20260521152217.2345235-2-kpsingh@kernel.org>
Subject: Re: [PATCH v2 1/2] libbpf: fix off-by-one in emit_signature_match jump offset
From: bot+bpf-ci@kernel.org
To: kpsingh@kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 16:03:24 +0000 (UTC)

--===============5083902027131865910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 4eb2c1ff205ef1d11b97cef9c13092a8b13ba5e1
> Author: KP Singh <kpsingh@kernel.org>
>
>     libbpf: fix off-by-one in emit_signature_match jump offset
>
>     The offset for the cleanup-label jump is computed before the MOV R7
>     instruction is emitted, but the JMP lands after it. Account for the
>     extra insn in the offset calculation (-2 instead of -1). Drop the
>     redundant self-loop in the else branch; gen->error = -ERANGE already
>     marks the generation as failed.
>
>     Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
>     Signed-off-by: KP Singh <kpsingh@kernel.org>

The Fixes: tag points to commit fb2b0e290147 ("libbpf: Update light
skeleton for signing"), which does not exist in this repository. The bug was
actually introduced by commit b3beebbe6154 ("adding ci files"), which added
the gen_loader.c file containing the emit_signature_match function with the
off-by-one error in the jump offset calculation. Should the Fixes: tag be:

  Fixes: b3beebbe6154 ("adding ci files")

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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26236267798
--===============5083902027131865910==--

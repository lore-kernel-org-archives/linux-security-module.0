Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F2188CC9;
	Mon, 27 Apr 2026 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777251070; cv=none; b=WvFjWePZ6hgcLPTZ4Oic3txWe9BKmUe+EkQsf0AZ75N4KBxOyTCp42HFl2bnnEF/qgxTRLmGGh1AJSiCmGOGgPnRQgtx1lUrIh/8sxubpz9jnLlM3ywLhjiaRXbPksTgdkyrIfHDxjMgTISQ6mFKEfO2Q+S+e31/NE+KVA8oG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777251070; c=relaxed/simple;
	bh=ZxLG+mbmX8RKIrir9aegNHYnLQIsZVRr9P3nmAemwQk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=njvHGJeLPO7XJa9tw19rFDiV71tXV1+wz5RTY/OVxTIJpxqDF7ZtjEdOowNdaEmNYEpjtAUjtXlxnKxjsAXjFFnfMqhPt0NisxFh8VKw8GrHI5US3BAek6CuSkr5l4OGj/Ha90ajFu/PB0X0lK0Qr9O/XMZerp4GC2ZViKfNz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjOmwAL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjOmwAL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADAFC2BCAF;
	Mon, 27 Apr 2026 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777251069;
	bh=ZxLG+mbmX8RKIrir9aegNHYnLQIsZVRr9P3nmAemwQk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sjOmwAL+f3S1n2JP6B9WKLCFgrMj13TxetK7N0/42wqpgu1zXn0IvWdSrA3h9qEly
	 eSq/kklQYKGQM0DZHg18xiQEsJIeKkyuKgRbL3vwv2Eq/TDBxsbwk8Hl5vE8cYeVSY
	 s/s6qRBet1G97UDA51EZv6SUjWgGKg0EN51YzZfsKvuTcYbv2qPTRGN/fjL5HLZrgf
	 w2YppfUVOi2c7NXK6m2lzj7IGFLRCMOq/zwpM+o3Ncb2kLlQb9QTJOc+nVVPjmC7pr
	 dR7qqIhnth6x6B0GpX9PwdK3BOJx5/6zRyn4T2V1fHIUHYL3geccjc4Hr/4ckHngnr
	 C/0fBsoKU38NA==
Content-Type: multipart/mixed; boundary="===============6429518501533670218=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe6f68a459a41391c140d36f29388ca4a268ae8748541bc9b4173f02836dc8eb@mail.kernel.org>
In-Reply-To: <20260427001602.38353-2-dwindsor@gmail.com>
References: <20260427001602.38353-2-dwindsor@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
From: bot+bpf-ci@kernel.org
To: dwindsor@gmail.com,viro@zeniv.linux.org.uk,brauner@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,mattbobrowski@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com
Cc: dwindsor@gmail.com,song@kernel.org,jack@suse.cz,john.fastabend@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Apr 2026 00:51:09 +0000 (UTC)

--===============6429518501533670218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19272,6 +19299,33 @@ struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>  		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
>  		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
>  		*cnt = 6;
> +	} else if (env->insn_aux_data[insn_idx].init_inode_xattr_fixup) {
> +		struct bpf_kfunc_desc *impl_desc;
> +
> +		impl_desc = find_kfunc_desc(env->prog,
> +					    special_kfunc_list[KF_bpf_init_inode_xattr_impl], 0);
> +		if (!impl_desc) {
> +			verifier_bug(env, "bpf_init_inode_xattr_impl desc not found");
> +			return -EFAULT;
> +		}
> +
> +		/* Rewrite bpf_init_inode_xattr(name, value) to inject xattrs and
> +		 * xattr_count loaded from the saved inode_init_security ctx.
> +		 */

This isn't a bug, but the comment style needs adjustment. In
kernel/bpf/verifier.c, multi-line comments should have the opening /*
on its own line:

		/*
		 * Rewrite bpf_init_inode_xattr(name, value) to inject xattrs
		 * and xattr_count loaded from the saved inode_init_security
		 * ctx.
		 */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24970971112
--===============6429518501533670218==--

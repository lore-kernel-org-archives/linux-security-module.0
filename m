Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABA353A78;
	Thu,  2 Jul 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005433; cv=none; b=bfkxknweVSBc1rmZ7GSp+RdtZRL4ZnEvtJDhXXWPILL2EDaS4jY/ExMb+1pGl9jcmce/Z/MvCWhQNEjoGC9XYOSQDfMcrDoDKV15ImzFxND8SHHPqY6Q8dR2tU0bgGZcMDgH/dn0YSFyAsXVPGa8jOymfUWd37t8t15PthMUWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005433; c=relaxed/simple;
	bh=hKbiKiL9e8lHfZHRP0c5OYEhyFm4H2GpNX8hNWcBMQI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aNokjqF9UiEXEbsQHcZX5FkW0tjveeXhO3RIsN652NDepGnx6UDOW0gt9r0J5ACm/x1l/QhJSclPQWBjSYFWzYOw0pE1VjPObv0FfD0wkEwZ/zBSQTupGGXiqZ1g3HC0Uw5XqSe4qZf94Bl8hf5VHdXFsHUvJ26i3WAG6isFU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAvsxx8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAvsxx8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239671F000E9;
	Thu,  2 Jul 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005432;
	bh=3PF7E6h1Pq35N0xxTAOqIzPYLKAPO1tm3xl4UMh/84w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iAvsxx8VTtjghXjcsLLPS0OtRdh5Az6HgNxyIEJyOOeDk77CGuCS0F61hSKv7/foU
	 Ew2vxvk3muAJoQfE3Z60FStAN+tEF5ecdXWJZjG1CR6RdBoNb4RnByKly5odp16FLO
	 pVkLWgXIzsoYHa9ACPty8CFqMQxR2QBuWDMV8i3iMnQ+MxsSYzZ61UDeHE3XS+Xi41
	 Ffm3fc8h8JDZJPr0+LL7KbSGZyHqdIM3s3pN+I/wKAkh0IR3oABLz8dEnWg1QUJXR9
	 oV0Lq3nhj/LijzZgwimoYoZEj+jfTAl+pqwxmK3hYMxIAaBmjMPKNVPvj2XGTMmjZB
	 PuRnhiV1HNL3A==
Content-Type: multipart/mixed; boundary="===============6116181899817283224=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <038b4c7b60a311cb9905bc88e7f27e6846e9578413afa4b902b0684f44dfd980@mail.kernel.org>
In-Reply-To: <20260702143605.252797-6-daniel@iogearbox.net>
References: <20260702143605.252797-6-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: Verify load-time signed loader metadata
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: kpsingh@kernel.org,James.Bottomley@hansenpartnership.com,paul@paul-moore.com,bboscaccy@linux.microsoft.com,memxor@gmail.com,torvalds@linux-foundation.org,a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Jul 2026 15:17:12 +0000 (UTC)

--===============6116181899817283224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> index 5fc417e31fc6..b3ac3d9b0e31 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c

[ ... ]

> @@ -1090,20 +1173,462 @@ static void lsm_signature_verdict(void)
>  	test_signed_loader_lsm__destroy(lsm);
>  }
>
> +static void signed_module_kfunc_rejected(void)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 1, 1),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	char dir_tmpl[] = "/tmp/signed_loader_kfnXXXXXX", *dir;
> +	int map_fd = -1, prog_fd, err, fds[2];
> +	struct btf *btf = NULL;

[ ... ]

> +	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
> +			  offsetofend(union bpf_attr, keyring_id));
> +	err = prog_fd < 0 ? -errno : prog_fd;
> +	if (prog_fd >= 0)
> +		close(prog_fd);
> +
> +	ASSERT_EQ(err, -EACCES, "module kfunc BTF in signed program rejected");
> +cleanup:
> +	if (btf)
> +		btf__free(btf);
> +	if (map_fd >= 0)
> +		close(map_fd);

This isn't a bug, but was map_fd meant to be dropped from this test?
It's initialized to -1 and never changed, so the cleanup branch is
unreachable. The sibling tests signed_map_by_fd_rejected and
signed_sparse_fd_array_rejected create and close a map_fd, but
signed_module_kfunc_rejected only uses BTF fds and never assigns
map_fd.

> +	run_setup("cleanup", dir);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28599478014
--===============6116181899817283224==--

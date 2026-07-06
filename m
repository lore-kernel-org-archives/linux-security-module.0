Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8D2E6CB3;
	Mon,  6 Jul 2026 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349441; cv=none; b=SlAyRUnkTd365GrrgEmW3HfcUzRQ5tCqTehwwMdZ05SsKuv+E3Dn4POKKHVLGq8phrnUelkv5kbqxN2bjXqc2BX8+MxJ916z1deKC9GxJ/9Sc3S0aS+C/VY7WLqNjnrAWHBEVTJ7WQZpkaUEQ/rszVcgkv6+aDXkwLHuhNnPODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349441; c=relaxed/simple;
	bh=ieKu7K8zDZFu8U7GJ8elgeK6IfZxq+2RjTiAQTnuSQc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rjWG9OS6qASQTcB1c1z7ko1aWllV5U9oFAQ1DQgUhT98GTDpHxv99Pu6EMxt7gme835Lew4Jv1F2YreuYmmhMwCNLqu2NFkehCexXl7BNY4FgQr9gl5UcEAKQDad3mqdJYsrbpu6oLsiZTTF80fp168XcBT2wYwncyZdh8TahYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtQ8Bxe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtQ8Bxe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B00E1F00A3A;
	Mon,  6 Jul 2026 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783349439;
	bh=nVsLK4o5D+Uu2blQLic4sRODZPIdtR/WEcoheXSoNpQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TtQ8Bxe3FUCFt6hrlZ1S6ve/gZ0Z4xmcF/9zbl3KOBgWNEPWNvBlPrxEU6GhZdirs
	 hZ+KyE9M3q4Gren9tFQ7Sf6DKlZk8tv9RJktolO/J4Ckm9KROqG6VhiAdTfvzD2wYm
	 b+1GmdmGYO2YMzcINtmKir+j2GeSw53dTtwAxQhCDojMfQQNuv0+nOMU9hBhAFDr4L
	 JBoLHXBGOjmbYaVyJ17ojqCU9yb2ATmrHP8hx1khq6uIOT1G5H4oKq23du8obW0aSE
	 2/S4RKdPOCLwCkVS7OVv3kh8ptd0eaJydCxBJ1nB63RM9+DnBoCWnmeRWhiXeMtqq/
	 BakQLEr4UkZiQ==
Content-Type: multipart/mixed; boundary="===============1877324805665347313=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8094f5297f05b30eaede9fc541afa8103f558773810814b0b791b7bc31d942a2@mail.kernel.org>
In-Reply-To: <20260706135644.326006-5-daniel@iogearbox.net>
References: <20260706135644.326006-5-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 4/9] libbpf: Drop in-loader metadata check for load-time verification
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: kpsingh@kernel.org,James.Bottomley@hansenpartnership.com,paul@paul-moore.com,bboscaccy@linux.microsoft.com,memxor@gmail.com,torvalds@linux-foundation.org,a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 14:50:39 +0000 (UTC)

--===============1877324805665347313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit eb80a2d94081929e7d91f275cdeda214433dead7
> Author: Daniel Borkmann <daniel@iogearbox.net>
> Date:   Mon Jul 6 15:56:39 2026 +0200
>
>     libbpf: Drop in-loader metadata check for load-time verification
>
>     The signed gen_loader used to police its own metadata map from within
>     BPF: emit_signature_match() read the kernel-cached map->sha[] back
>     through hardcoded struct bpf_map offsets and compared it against a hash
>     that compute_sha_update_offsets() baked into the signed instructions,
>     after a BPF_OBJ_GET_INFO_BY_FD round-trip to populate map->sha[].
>
>     The kernel now verifies the metadata at BPF_PROG_LOAD time by folding
>     the frozen contents of the loader's exclusive fd_array maps into the
>     signature, so the loader no longer checks anything itself. Generated
>     loaders thus carry no verification logic of their own anymore: Nothing
>     in the signing chain depends on emitted loader bytecode doing the right
>     thing.
>
>     On the loading side, skel_internal.h now sets fd_array_cnt for a signed
>     load so the kernel scans fd_array for the exclusive metadata map -
>     still frozen, as the kernel requires - and the BPF_OBJ_GET_INFO_BY_FD
>     round-trip to populate map->sha[] is gone. The struct bpf_map layout
>     BUILD_BUG_ON()s on the kernel side are removed as well: they only
>     pinned the ABI for the in-BPF read of map->sha[] that is no longer
>     needed. Same for the map->excl member. Note: gen_hash is retained; it
>     still marks a loader as signed so an untrusted host cannot re-dimension
>     maps or override initial values now covered by the signature.
>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

In reviewing the patch series discussion on lore, Paul Moore raised a
security concern in v3 about the companion patch that moves the
security_bpf_prog_load() LSM hook into bpf_check() in verifier.c. He
noted that the moved hook placement allows processes to allocate kernel
memory (including bpf_verifier_env via kvzalloc_obj) before SELinux can
deny the BPF program load operation, creating a potential local DoS
attack vector where even denied operations trigger sizable allocations.

Paul explicitly Nacked the change with:

    Nacked-by: Paul Moore (don't move bpf_prog_load LSM hook)
    <paul@paul-moore.com>

Reference:
https://lore.kernel.org/bpf/CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com/

Paul did not comment on v4, leaving it unclear whether his concern was
addressed or if he accepted the change. Has this security regression
concern been resolved, or does the hook movement remain in the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28797884155
--===============1877324805665347313==--

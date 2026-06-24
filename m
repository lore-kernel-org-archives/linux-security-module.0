Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4CB3BBFB6;
	Wed, 24 Jun 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314252; cv=none; b=VwRs5eI5fsTTCyjJNQ9L/Tx7IRf7gm6z7uvC7DKbwRPTx65VgL/rIWIgRk8rJ/l5CuWD9mh1zeFUzNO0w069l3a3YhXSpBzRoMDBGnbnrbmQ4M95S2N2R3ytRXv0IXfInllQG9HTr8NIZTMsbnfqupkqYKWnxqs+6ErR+HnE7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314252; c=relaxed/simple;
	bh=NQ7p/2KBrMZHQV9hvZGojlaHuR/e8uRYHpx7Dc92AZo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cUMk628TsXURRNuoq/ldgZhKrWnoM85t+odl4zeqy2jwgX3QQEzAg2Xl00finGUDklAdTGL2UVIo1xyqbT10G4BuIob/9ubYuzR9BqfC+96ugnj2ds7m8T7wQnLNBJ8AQiSqJxoUKPswKq4fRtcIZtf2PbxVX4fSfA3T8nMXgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHo7ZBib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHo7ZBib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616241F000E9;
	Wed, 24 Jun 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782314251;
	bh=aUrUSAcqjD46pV+IIa+ic9Zvd7VQZZPBqXURzkWYmvM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lHo7ZBib1MgMDlJoIlzT9jBeFFI38iG8a5PH/e39iR5Hm4qUh+OPW5ZmvMvuGonR5
	 UYjSXVS5aemFsREihwqrgxpYjwSs+PnKRMtPIUhgCgzg1A2q1Q/n3WtYlLVq5qEu3n
	 RQ861X+tRI4y/zeRy0QlRdoQI4+2arh0lmeiLzhA+tfapWVmam/uaIeweB/tMieL4O
	 s/WThUhZ7he0iFZ8rjxfXglhVpeA/apTjkrxDFzIiI9TKao/EVagv9KlTAufKAYwh9
	 THk8qx6QfhBWzmyfRVjJQr6ejt4HNozvPuwLEZxc3aG9oSmxbQrFum3+tXQG13jweI
	 WkLR/SMlcXH4w==
Content-Type: multipart/mixed; boundary="===============6409023576633201260=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aa4bbc8bde15d5c7f6ab5257b97392cd905e4299335d224d8faa3fa9e173d0a2@mail.kernel.org>
In-Reply-To: <20260624140301.93421-2-daniel@iogearbox.net>
References: <20260624140301.93421-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at load time
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: kpsingh@kernel.org,James.Bottomley@hansenpartnership.com,paul@paul-moore.com,bboscaccy@linux.microsoft.com,memxor@gmail.com,torvalds@linux-foundation.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 15:17:31 +0000 (UTC)

--===============6409023576633201260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     A signed gen_loader program carries the programs, maps and relocations it
>     installs in a metadata array map. The loader instructions are covered by
>     the PKCS#7 signature, but the metadata map is not: Today the loader
>     compares the map contents from within BPF against a hash baked into its
>     (signed) instructions, using the kernel-cached map hash. The kernel itself
>     never actually attests that the metadata the loader installs is the
>     metadata that was signed.
>
>     This split is the core of the long-standing objection to the BPF signing
>     scheme from the LSM / integrity side: the integrity check of a light
>     skeleton only completes once the loader program runs, that is, after the
>     security_bpf_prog_load() hook, so at admission time an LSM observes a
>     program whose payload has not yet been verified [0]. Auditing the chain
>     link is also not a purely cryptographic operation: whoever signs or reviews
>     an lskel has to disassemble the loader's preamble to convince themselves
>     that the embedded hash check is present and correct [1][2]. Two acceptable
>     fixes were identified in those threads: Complete the integrity check
>     before the admission hook fires, or add a second hook that collects the
>     verification result after the loader ran [3]. Let's implement the former,
>     without growing the UAPI.
>
>     A signed loader binds its metadata map(s) through the existing fd_array,
>     and an exclusive map is already bound to a program digest (excl_prog_hash).
>     So when a signature is present, collect the exclusive maps from fd_array
>     and append their frozen contents to the instructions before verification:
>     the signature now covers insns || metadata_0 || metadata_1 || [...] in the
>     fd_array order, and verification completes in bpf_check(), once the
>     fd_array maps are resolved into used_maps, before the LSM admission hook
>     and the rest of verification.
>
>     A program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED, with nothing in
>     between. While folding the fd_array maps, a non-exclusive map bound to
>     a signed program is rejected, so every map folded into the signature is
>     exclusive. A signed loader that fails to cover its metadata thus does not
>     load, and BPF_SIG_VERIFIED always means the instructions and every
>     exclusive map are authentic.
>
>     The maps must be frozen so the hashed bytes cannot change before the
>     loader runs; the map <-> program digest binding is enforced by the
>     verifier for every used map. Binding maps through fd_array_cnt makes the
>     verifier resolve and excl-check them (excl_prog_sha vs prog->digest)
>     before it would otherwise compute the digest, so compute prog->digest
>     up front in bpf_check(), over the unmodified instructions the
>     signature covers, for a load that folds metadata.
>
>     Unsigned programs are not affected. Note, signed loaders generated by
>     older libbpf/bpftool versions need to be regenerated; some of the recent
>     fixes we've had on the signed loader side require the latter already to
>     close gaps.
>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This reworks the machinery added by 63a673e8a411 ("bpf: Expose signature
verdict via bpf_prog_aux"), which introduced the prog->aux->sig verdict and
ran verification before security_bpf_prog_load() so the hook would observe
only either UNSIGNED or VERIFIED.

Since this moves the verdict assignment and signature verification into
bpf_check() and folds the exclusive metadata maps into the signed payload
ahead of the admission hook, should it carry:

  Fixes: 63a673e8a411 ("bpf: Expose signature verdict via bpf_prog_aux")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28106955037
--===============6409023576633201260==--

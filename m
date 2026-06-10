Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF529B228;
	Wed, 10 Jun 2026 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135300; cv=none; b=cauF8R+HmDkEn3660cf1yCnGGwCV8DzGDBjvboTBE+yKWvPHQjgo5g3Ao70aN/8ctYLc5HLuuW0LHhgeOpIuzGJvLoAmNVp2ZPi1HBcjVSQEwQT5HeCdpKqV+3MYaG16L1TGuOzDnBVszBPacN9LjonWmAisrhuh0eVSQ9pSNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135300; c=relaxed/simple;
	bh=txrw+D81HZEGFl1Vf9TS619X42vwoHqpSYn6M6I85q8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WgHYNY4HWP9+E2pVyPpn77aGZvUt4us3Bbholr699+JiUibYqR0Czy6WEDvDqNnMazoJ63XkYVbxyerSUNvSsYLUMGn5xF+L29SsMrWuKDoQ2xwG8rZSEBTzw5zYeitII3L9xKUpjinkxZbq7FKgL2P10FCqLEdHYhUV1feDgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaMZNenr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaMZNenr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAB21F00893;
	Wed, 10 Jun 2026 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781135299;
	bh=CipF9A3gfrHphLRf0QX+lIslSp8tKH7k4N7NF3mNvV0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YaMZNenrB6P+OuXYjDINwwcyoTZdeDq+A1fgt1j3RaVV/IRjjUB9D2CKFJxpJVqg4
	 eGPCJhLnD+CxIJdMR7UnmS01XmaQwpiEq1aClPo163koLgU8NMeyVz3uNJkrlndwU/
	 wvX2/DHVUBWJljLB9DoVssiANycB2q59U0HDEg5QZp5tfW/5yzQ4m720JXFJ/rL/6t
	 cA4K/VqDq1BnJihdd2pxXoQEP9xNDNrU6AIj2nxkrRUvWpQmCzFqmA0vYcdO/gbcoF
	 XZgMxWORr7uCqFoBeU8zOr5dMYQRbmJ0jN6m40qPXxjm2uiF+sW7ODVoCGAJVeR0+3
	 uJhzF4grcHlOw==
Content-Type: multipart/mixed; boundary="===============3421189048308312154=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b632af6b40610fe3296b0b6cdd160c98596f81649817f23a3b63595ce4f1f103@mail.kernel.org>
In-Reply-To: <20260610230329.727075-4-daniel@iogearbox.net>
References: <20260610230329.727075-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 3/5] bpftool: Cover loader metadata with the program signature
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: kpsingh@kernel.org,James.Bottomley@hansenpartnership.com,paul@paul-moore.com,bboscaccy@linux.microsoft.com,memxor@gmail.com,torvalds@linux-foundation.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 23:48:19 +0000 (UTC)

--===============3421189048308312154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Cover loader metadata with the program signature
>
>     bpftool_prog_sign() signed only the loader instructions. The metadata
>     blob the loader installs was left to an in-loader hash check, which
>     the kernel now performs at load time over insns || metadata.
>
>     Sign that same concatenation: pass the metadata blob (gen_loader_opts
>     data) through to bpftool_prog_sign() and feed insns || metadata to
>     CMS_final(). The excl_prog_hash stays a digest of the instructions
>     alone; it binds the metadata map to the loader and is matched against
>     prog->digest by the verifier, independent of what the signature covers.
>
>     The signed artifact is now plain data: both bytes the signature
>     covers are embedded verbatim in the generated skeleton, so signing
>     and verifying an lskel is an ordinary CMS operation that a signer or
>     auditor can perform (or reproduce) offline, without analyzing loader
>     bytecode to establish what the signature actually attests to [0].
>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This closes a gap where the loader metadata was left outside the program
signature. The signing path in bpftool_prog_sign() was introduced by commit
40863f4d6ef2 ("bpftool: Add support for signing BPF programs"), which fed
only opts->insns to the signature and set only sopts.insns/sopts.insns_sz in
gen_trace(). Should this carry a Fixes: tag?

  Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27312517811
--===============3421189048308312154==--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFF4C8FE0;
	Wed,  8 Jul 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535440; cv=none; b=gQlBEIH9gqdksjqguw3dk74aavTAsB/H2GhVnFewAv/bEbGjUljwsGExzJ8MGSYJNjAibKgobk8e/tP30D8R0oUWNPnVix+21Ldpvv0FC0LvtxNm+nwO8wr7dlW06eQVRmaBKd5PHMD3pJxFEUBh7RDvy0FN96ToM8svneKUGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535440; c=relaxed/simple;
	bh=cZh5DVsj/dPA/UKAu+pTws34ASs3e/hIPIj+rrHjBRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KhW4IWAyjNcWNQZH996BuzEYJ0ZUIxCzkMoSnlh/E4BNkI1Ngp45OT0tcZSAeb58xCMw39jVF9ewFMfO195GcxIZokScIaVQLtd0F8DOw8v6risaD0TEwwrcJUw+XSCo/ibNg1cL/lZnr+NwrYF6HpS/dCpnJayn3vCQ9A6P/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKOeGQYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKOeGQYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5221F000E9;
	Wed,  8 Jul 2026 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783535437;
	bh=BmLAl7KP6I/cpRymj1fw5zYepPzOB3GSUa3VvQqInLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HKOeGQYAzkYBKb/f4u+9J9wFnS0rGLEXyejNw4Yvd0IInUHBF5zTmFX4jdaHDcdh8
	 cRssy4BevWUl/t1AGA+wlAKrYHBrQFXf/kIef2dfUeDWE2caE53sFf9JW25EbQd84Z
	 S2pad7Vy12MCWWUdkFI3ZCoP94RwjKPc/7GX6Am4lZZD/gy09Gni8tbRplGwguImcc
	 HgHfyBLHBnuNdRk2WUQj+til8TxJ+bxlCtl3oe9jQ3x9cG2CzWfhcuWvhK7/++8kpq
	 ShiXQ57qhXtqdmsqhcPnoQTA6gNMJIN/hEEE+ckOpDxe9g+9HcyOKRrxmTYC8OdsnB
	 jNAk8GP2nAGcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197D73938456;
	Wed,  8 Jul 2026 18:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/8] Verify BPF signed loader at load time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178353541664.3057345.9896047455904217211.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 18:30:16 +0000
References: <20260708075343.358712-1-daniel@iogearbox.net>
In-Reply-To: <20260708075343.358712-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com,
 paul@paul-moore.com, bboscaccy@linux.microsoft.com, memxor@gmail.com,
 torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  8 Jul 2026 09:53:35 +0200 you wrote:
> The BPF signing scheme signs a light skeleton's loader program and lets
> the loader vouch for everything else: bpftool bakes the SHA256 of the
> metadata map into the loader's instructions, signs the instructions, and
> the loader compares the (frozen, exclusive) map against that hash from
> within BPF once it runs. The construction is sound as a trusted hash
> chain, but the kernel itself never attests the metadata, and that split
> has been the recurring objection from the LSM / integrity side since the
> scheme was proposed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/8] bpf: Resolve and cache fd_array objects at load time
    https://git.kernel.org/bpf/bpf-next/c/d5a85392392c
  - [bpf-next,v6,2/8] bpf: Verify signed loader metadata at load time
    https://git.kernel.org/bpf/bpf-next/c/b707068e0ed9
  - [bpf-next,v6,3/8] libbpf: Drop in-loader metadata check for load-time verification
    https://git.kernel.org/bpf/bpf-next/c/a2d784869a0f
  - [bpf-next,v6,4/8] bpftool: Check EVP_Digest when computing excl_prog_hash
    https://git.kernel.org/bpf/bpf-next/c/576bcaa1f5c2
  - [bpf-next,v6,5/8] bpftool: Cover loader metadata with the program signature
    https://git.kernel.org/bpf/bpf-next/c/92c7717981bb
  - [bpf-next,v6,6/8] selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
    https://git.kernel.org/bpf/bpf-next/c/77e5f3c91453
  - [bpf-next,v6,7/8] selftests/bpf: Verify load-time signed loader metadata
    https://git.kernel.org/bpf/bpf-next/c/99b321dde704
  - [bpf-next,v6,8/8] Documentation/bpf: Add BPF signing and enforcement doc
    https://git.kernel.org/bpf/bpf-next/c/84c42f515f18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



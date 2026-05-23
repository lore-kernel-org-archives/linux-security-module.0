Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47C25B08D;
	Sat, 23 May 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548398; cv=none; b=oFVtFOJh+xj8ZfXF+7TzAjHHj1AQQq+++juCIHqNYKiJoqbPLSdJ1sKSpxP7KQOAKgKzn/BSet94Xmz3kEOXdpQjA2l/rTbrkzpDe3ZlFxZE+IUPPJYGfhADCTRhEejEjaPMLWtruKKsqh/ohwxGXHx6A9GJRptfYWIsmeDkXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548398; c=relaxed/simple;
	bh=bW6HpjKmPVffRP5J2hthCqlEksECjIhujiqRpJl5qQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+qNmwNoqiz+u4TKXqJwPvg7Wjbsmgi/jYR7VRwJwtk6JDaNtLSapcLX5twHUZtFAIAQ07Mj5JxLcOedWF7nutFBLivx9e/j6hk8lotegpU18Qyy7da1UgsYEH7d5gjrhOG+5R4E9Li1wnPftDxJ3Phmq3RCx5N4lalyMkZIMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1MzggML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1MzggML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC24C1F000E9;
	Sat, 23 May 2026 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779548397;
	bh=QgIMR2xep8Xf8/gHRTnDLTKWZ2RwobwgpRHVCC+Q3/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U1MzggMLWq4zCo8rR0309BvfECK77J7IU6v3LmOKcWzPaGWmR0BGQdeMCxz25Ov1J
	 HGonpBojXNuQN1RvVn7hRIRkx39wEvybgc0Her0gGJBv1GUJ2y2W0XrC2lJty9MxrH
	 /qW5nybb6fZ889mzEzm0r2o+Z+vzykUmvLKVLNAv8ED0WBIorNJ9Uj6TJvoJjRW3q7
	 TLKWjHAlSxYhk5UBgc1vcqNAPc/O1SeOXVpCwC0RO9+pXpM4ctDN9n75nnkgC+3++G
	 BVHVTKt4TCuvyHRY02Od4YGx/9HucTDLbf3qLO1Lvuylf5zjMXn9VleuLCk+d9eC1S
	 Qoui3wrYP+prg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B413808205;
	Sat, 23 May 2026 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] gen_loader fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177954840588.1595035.11316351305698858688.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 15:00:05 +0000
References: <20260522215337.662271-1-kpsingh@kernel.org>
In-Reply-To: <20260522215337.662271-1-kpsingh@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 May 2026 23:53:35 +0200 you wrote:
> # v2 -> v3
> 
>   defer fixing 32 bit.
> 
>   Fix off-by-one in the signed loader's cleanup jump and reject
>   non-exclusive metadata maps.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] libbpf: fix off-by-one in emit_signature_match jump offset
    https://git.kernel.org/bpf/bpf/c/7dd62566e0d1
  - [bpf,v3,2/2] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



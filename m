Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B61CDFCA;
	Wed, 20 May 2026 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247795; cv=none; b=RttbFcw6WdtAIb9H38DdppBwpjWw78QH9Mp5VyIWhQf03a7o/+hmjneYNaYzv8ghIGRKYRIiWST6zMhqymgJEk77CaGijHar1/44sGbXHSm/lvlyFOY+0RdlkrQ1GXo+RmADO/sUlbzPgeZ0qLCaXEOk9dZCv2SZI5q4SXbpbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247795; c=relaxed/simple;
	bh=1dKEWOWNgDrx2Aayec82qKnctaqlT/mMVt+kcY/FUVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u5tIVPO6ZmPMItCn14MNdwZkuZgL4JDz1gw8h5KI0MJqCGMvyEGnYgtWwCtxnXaSpXWgRRcvuQ3PMOjKIHRe/TqqJNRbO5zSv/8oEZydvFjqnB8TXu860EDHilvxv7Qhi9DchDbsZuAt0xnoCa8WjiC6ef3foCaAsKDVqHwscF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftR1GRJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftR1GRJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900781F000E9;
	Wed, 20 May 2026 03:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779247794;
	bh=ClBedztygYFy0+zbbDihS07Ab/Sg/1+RrxUh0aeyxlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ftR1GRJ/Y5mbsm1aTjcJ8TwqkbZBrCEI4pd459vWTrajSDHTs5XdSfvU5oJSD+K4P
	 YfZBuz4ajBOHnIwZ4E3+20OnDpI7c024W3GE9I7bZb8gXhuWah+WgFXpybnR9y14dm
	 aDcMgr/glXd2Ky6PsZbccQDWExn3O1y0b1BcNcVHzvChyTfu6A1Mu12wAANXFDiOuy
	 lqqfcB+gVIYRSgRak/ZxAmweuRYeuVhgJw6IFPkiNpD5Ci1cCQUVUQjHX+abI7g19a
	 v+9TK1cz74svt77oNLSBcYNuoZvOpGVCt9ZYEWLKqdRHiKxugxmqHFK/wJixjwH7ir
	 XmB5ahpolhHlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E93930186;
	Wed, 20 May 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: reject NULL data/sig in
 bpf_verify_pkcs7_signature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924780515.2971098.5196189504345300156.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 03:30:05 +0000
References: <20260520024059.313468-1-kpsingh@kernel.org>
In-Reply-To: <20260520024059.313468-1-kpsingh@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, dongxianrui1@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 20 May 2026 04:40:59 +0200 you wrote:
> __bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
> backing). bpf_verify_pkcs7_signature() forwards the pointer to
> verify_pkcs7_signature() unchecked, causing a NULL deref in
> asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.
> 
> NULL-check both pointers and reject with -EINVAL. Mirrors the guards
> already in kernel/bpf/crypto.c.
> 
> [...]

Here is the summary with links:
  - [v2] bpf: reject NULL data/sig in bpf_verify_pkcs7_signature
    https://git.kernel.org/bpf/bpf/c/49b18315be4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



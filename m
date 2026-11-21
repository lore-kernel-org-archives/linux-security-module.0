Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219806;
	b=PjRAxwf72EtATOoLScZVeiLgF+GDXA4ya7/m5j/iJkoa1Ul3eIFSg+tCnB1E2UKBNQ00
	 T0kK7TdoB9PKwWJ5P/pPQBDBBfDtuffmVl3PDdqFFPnZpJEf4l6A7E+nRbfmX0EeEfQPA
	 zkXYlDXgDZB+hioHIdRII1jnIxgac6kTRSjeSs8w0lskzHdp2IsnDYpo+V0CO4InWc3W7
	 Wez01vL7AkyB3wafr+WxVUZjQcARxPvgOqIxskS4FqxCAU5aab+uakB1rS5HHjfRMLVx+
	 TWpdXqaPe10YXrGHuw+5ctMnbhOCOHGaqMoSKZK5X8oRDwGq/f1wpE1YQZucW201kIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NF/ujq6tue7kzamg0ERWH/gu4MqvrEh8Itu4bTXyAkY=;
	b=RSeWlHwlxdTDK3D8St2W8MnJm8NRrflzxBFo++22xtVNtFdwPkV0NqK5vAb1BbgYi1RL
	 I3DNFsiZTRcBquvXQc0grpduathwy11q0u+EMX6cb5pYO7SUBVNTPQ8fcVh4yf8YRS2c7
	 rgdwswjcicr0iQELaqaEuEwS+qdV1eMU0hc7CuO7DFK4XvfVd/LsnnjMF98Idxot4Gcar
	 HwVEFFDkTWC0N8s2jm2z0m0ABGD9c9ueRDK/LqLdLUz2tEiSRFffpl3o259+cWNROhs5b
	 lQm+ydm+xncbUor3LlyRLWweBFpmi5pnMWhynCpLrIfPT1X5jzXJXy/ASExNbbKr5mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DneaQIlQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2C60A382D;
	Sat, 21 Nov 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DneaQIlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10801F000EB;
	Sat, 21 Nov 2026 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795219805;
	bh=NF/ujq6tue7kzamg0ERWH/gu4MqvrEh8Itu4bTXyAkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DneaQIlQAu7Jqdou/T81nhyKmsy5JooTrNGTtoED8JQG4QiCi6q6BuuILMWIx8FQ0
	 9RVM8A0XsMfWIQkyjrAa7N9kLsmayAXZWHh8k6qZOW8lNz9yKxCU98aK6mMLvgB9Nq
	 uox52K0mT0sKGPDiKJpzplxTOs8hpnz5DNhndEYV32TjuZdmLYqGO6sH3+dFY0sJ9r
	 jyWvCjC9qD7CTgESsPFE6beIPgKTdOyOcxc612r4+vzhdY6dhUeBF2HSQOJ/TD0VR+
	 LN5Tulfh7LQGQ5dF/I9LtAQvLmXGGpCBLZUM6/ahfkbJUCnrWC0Jjfu7+nUlBPoHrj
	 cF+sM+yvBs4hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44B5380AA4D;
	Sat, 21 Nov 2026 00:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6,
 calipso: fix data-race in calipso_cache_add() bucketsize check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179521980453.848072.7525939572542056184.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 00:10:04 +0000
References: <20261115144508.71543-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261115144508.71543-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, paul@paul-moore.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 huw@codeweavers.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Nov 2026 22:45:07 +0800 you wrote:
> Issue found by sashiko when reviewing my data-races patch [1]. This is
> not a plain READ_ONCE() annotation like the rest of that series but a
> real fix, so it is sent separately.
> 
> calipso_cache_add() reads calipso_cache_bucketsize twice: the "<= 0"
> guard on entry, then the "size < bucketsize" test after taking the
> bucket lock. A writer can flip it to 0 in between:
> 
> [...]

Here is the summary with links:
  - [net] ipv6, calipso: fix data-race in calipso_cache_add() bucketsize check
    https://git.kernel.org/netdev/net/c/18a7abf1a0b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



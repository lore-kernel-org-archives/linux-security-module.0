Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E331B983F;
	Mon, 25 May 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736202; cv=none; b=s1MZxIUsmofVgMI0/la8SPvdan1JVpckmc4z0KFP7hq3lCS7giLmqgg7+cnLe/+3cx40yaTAExXXW80tqo98RV1MxGHdN3eNFLby6L4vF8uXdqJ9j0iTgW/MgWPPYP5etJ8x/h0hODH1OouCE0DQ29wMFV6MDZZZ08zuqHibObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736202; c=relaxed/simple;
	bh=kLClk9jOyPJwAjYwCFFDZ+IKIDzxVT10tQMiOv/Wa+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZf/gBw3OU3d7jOO9qFAnMgbFUX38h6rMtFVRpAJN53KENxDciziCLYo1qHzfDoNayNHgUDnWXQ0xwJshDmHdgO7E9c4YE9VbDHfr5q28h1JbY0x6l1PUNXdZuzPHkbQ6cZfSKRvUjUrJ2BpfqQrRMIpRKFZNs3RW7wpFUzr8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5pj84wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5pj84wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF411F000E9;
	Mon, 25 May 2026 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779736201;
	bh=4ULgwzLXwdYGW/4zQ41enqixQQ8SWakHPHXPcvAA/hY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q5pj84wuN7Jci2sTWHZF0+wYJmKSKP4tQq7wVizB49KZUsnVxIenwhbX6Willr4Tk
	 m4rG5UiNuCSc8fgiwQ89ee1iDWUt0m2R5BfSG4NwYpsqyYsgr8s3uzXL3sf4x18ApC
	 q+rssQDk2l7VAtjGEIYRzC6qx93yCt0Gl4jJkHAgj78ZXhh0BwfkiGsN8Cfc9CBSrA
	 WydoTMHjcdq8GuB7ClSY/t3l6JAJGL+6ZFjdctE8EGILJ6bFv3f369aijNj23OzAjD
	 tGd8nbCoKR7UHDEitUgsA7YKVHxSxpuOd0vRv8CDySjrJJ5OTnRXRQS88YcE77Z3XU
	 FlTewmuM1js1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D3A380AA75;
	Mon, 25 May 2026 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] netlabel: fix IPv6 unlabeled address add error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973620765.3087812.15689833351605470719.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 19:10:07 +0000
References: <20260522022910.398416-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260522022910.398416-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 10:29:10 +0800 you wrote:
> netlbl_unlhsh_add_addr6() always returned zero after
> netlbl_af6list_add(), masking failures such as duplicate
> IPv6 static label entries.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/netlabel/netlabel_unlabeled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] netlabel: fix IPv6 unlabeled address add error handling
    https://git.kernel.org/netdev/net-next/c/56872b930fee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



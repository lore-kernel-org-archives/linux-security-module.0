Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005408;
	b=QtbZbxNT0riG2G0/RAS5diUiMrS8TpxXCbGH9I1tfMWYbk1ZTNdOO8b17sPlFAh78YrR
	 lzH9g8VnmpgEr5whnw/UGnu+tfGWZ+nqWJO1gz9K+G5XYRdig7jDA3RLECkzj777g0h0K
	 Avch6bhXAPHcVV6KLSOUDo8BIae9ECPRSFRVPiUweMOaDdABMnEFkpD8VFcYmRlYZGjpk
	 AQHc7N8W7HWB1ETxqwWfm3/CuLm+dvlPgY12Y5QfQNe8a/+JAtvk2cRSWkX46lJEcWlcS
	 gWRYykRfIXj7ilZS1B8LbppvZ7sQbdgB1t/ZdMJut1BJ/8/rGgbvn9S0OcTX9ZXcbPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=41b/RqwayCRykZurZ84SwiHLVAszUbcj55IVHzlXOKw=;
	b=cZMXLpz8OsWuxW3jd8IhWJygXPrvpkbsACkjGcbbe8+lEx8oIVISl9dYQkklzYJ5bAy+
	 uv1FhBTSCXzfEB7Mq0vwe03OiwgwttUQRzdAUz22wI8CRl1gXWQ8VXKNPMZ9Q5I5bgkKY
	 T0MJLGvDG7+yH7PppE+yDc+oJFLx98PgoO8Lp+v1e+yWQEPgkd3g7ZIkDRez5QWgk/TNi
	 PzDGR10lwRo9qE0+fjcBL5zVILr9uXHivS1ZSZLf8qU1EYCitq/CPdza6vLQJrmbsaK7+
	 eax1HsVAv60/QTVH1s1RCML3WNLPE9WVMeBl8l6jNikrxApWftqROAjw3+DmNATv8ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwnPZSkv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B834606A330;
	Fri,  6 Nov 2026 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwnPZSkv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294931F008A4;
	Fri,  6 Nov 2026 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794005408;
	bh=41b/RqwayCRykZurZ84SwiHLVAszUbcj55IVHzlXOKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EwnPZSkvLTaphEMgGicxf4cB4vnZMnWgkaum52/c7mVfWlIZSlci9Xfpi5dTDPyUD
	 JrkXGYJgF65U737c7oSPg0bootGukJSwlMasuRkhdMQKdDRFli8bWU8I0sKdNm/t0Z
	 xWTMOLOAN2gVPlyWR71yh6XtuIwyxPleMLnoJ9rfAT61/UFYTWKcUfY+ATJwl1aoiS
	 ltJG6QaRWjVCiob5h5RogPX+UuKTEDxsiRKqrFzQIK0LXGYRDY6SLYEExSdO3xSmGT
	 SJrflY0v/tZw+2pBQgudDchSDdWfealcPfzzTh0i12dHisCZD8kWqVEGl5qY0PNgRs
	 Yj6OlNh6X7QRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 211A23A55EC2;
	Fri,  6 Nov 2026 22:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net] calipso: do not charge request socket options to the
 listener
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400540667.914342.11846522579501205439.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:50:06 +0000
References: <20261104150318.1156620-1-edumazet@kernel.org>
In-Reply-To: <20261104150318.1156620-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, sashiko-bot@kernel.org, kuniyu@google.com,
 paul@paul-moore.com, linux-security-module@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 16:03:18 +0100 you wrote:
> calipso_req_setattr() and calipso_req_delattr() allocate ireq->ipv6_opt
> with ipv6_renew_options(), which charges the listener sk_omem_alloc
> through sock_kmalloc().
> 
> tcp_v6_reqsk_destructor() frees ireq->ipv6_opt without uncharging it,
> so each request socket leaks its options size from the listener
> budget. Once sysctl_optmem_max is reached, sock_kmalloc() fails,
> calipso_req_setattr() returns -ENOBUFS, and tcp_v6_route_req() drops
> all subsequent SYN packets. __sk_destruct() also reports an optmem
> leakage when the listener is destroyed.
> 
> [...]

Here is the summary with links:
  - [net] calipso: do not charge request socket options to the listener
    https://git.kernel.org/netdev/net/c/b4a2cc6d748d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



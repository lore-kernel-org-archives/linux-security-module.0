Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007C416860;
	Fri, 16 Oct 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792193407; cv=none; b=GsoyJ/swKnlYdbgpUk+qG+eZnCv7DPAny9OLLYMVp1Wq7Dt/085Zji2Vjyt5Yy2JqSbJeq3EziYfjVWDQ6R7oI6uAXkFhTuVdQVZYXj7bZXngzPQQchbpw4uB7lhqJzTX920LANv9/sb52SVXo3NwyMpsNN3bzDYH8cUYpLZLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792193407; c=relaxed/simple;
	bh=qfX0gFCtvMGWZyUqyCp4lNGvKbaMkYo24aif/B7zlfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYx/gIOR0Ajww6okAhlr2DJtxqBarBTHYMASGC8e4l/Qj3eorsVdOzgbu5OjUvbnalkBrVmEjEebT8gjUj1T9gev0LedI110MNQBV9b3VC6YDEjOO4L91N5qTnqqOlNH7iPU8mamRhs2U7pjgOiSI9TaP+pB05ceMTe7U0a0DiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frDnzJdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frDnzJdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EC91F000C4;
	Fri, 16 Oct 2026 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792193406;
	bh=j1n8z0ONvPUgvfWn0I/qw18tnvb5dO0IA0KouUl3Y7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=frDnzJdj4dJeReQuTKAGAee1e6QBmoSx4mmKjdaAeEyv2l385Xk2Johrl2JuZimos
	 i15GbkvEWF1eap3r4z8QanaXoMeX9h0WjpixgMvoZ2chdHWxJDCvRhc6PDpNquns5c
	 iMplX0fzw2yVzWYIu4vKaGqFYnMXQWQhJhI/zc+sB5aYRp9BcINGTZKWgRDQbSzZO5
	 3Nmhk9AvwLepCYXi9davUXqSaOZ2/FoQh5U+dokyTbQ/KTGK4jLHtbaXsSkox0Igtz
	 Y4Wm9C2TXmD4KslcV8IqYYXSRP1PlQJ239Yf6pmAh5uGZrJWJVhEBPs5F8J6D5KU23
	 TTIroAISi0DSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1558380CECD;
	Fri, 16 Oct 2026 23:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179219340478.1009070.12393619315617500002.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 23:30:04 +0000
References: <179147329205.58079.5847298721173675285@gmail.com>
In-Reply-To: <179147329205.58079.5847298721173675285@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: paul@paul-moore.com, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, alice.kernel@fastmail.im

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Oct 2026 12:28:12 -0300 you wrote:
> calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
> extension header, or the whole extension header if CALIPSO is its only
> option, and pulls the skb by the removed length.  It never updates
> ipv6hdr->payload_len, so after a successful removal the header still
> claims the original length.
> 
> calipso_skbuff_setattr() already adjusts payload_len by the length it
> adds; the delete path was missed.
> 
> [...]

Here is the summary with links:
  - [net,v2] calipso: update payload_len when removing the CALIPSO option
    https://git.kernel.org/netdev/net/c/00accbd9d502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



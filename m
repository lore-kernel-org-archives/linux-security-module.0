Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B0207DF7;
	Sat,  6 Jun 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711806; cv=none; b=rjL52/kcS0ls4yn44BJzg23wCueLPDpUrZPP1/573Gy8aXBZBzCfNthqEkQ9srnoQM1Rlpc/1W/KSeVA2fUP532lmUdoVDc0tx/HNq0DpZezw4rpZ3/kcHESqbJmKq/kUPXIOZ3Sepc1P7rdeLyk3m1lW4eHVtElLq4sykjxz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711806; c=relaxed/simple;
	bh=8+awQu+gU/dWPe2rEKgbqkiq84iAuJZmX7+ZXLtoBJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QRhK4eP8bcjVW6zaCPlA5BDZQahbuy2VGyySq/b9oLQ25pwUE/CY0Wrx5vceARfrI3CD5CDhf0vY5GrRiKozWZ94faCjIzJ9nUoy89r9HBkvpxQoExWD9NlSnLCLLf0PINMPr1vykIGzKu60F42EN2l4aKs4wHemmssgjuPqFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtKK4I4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtKK4I4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399D51F00893;
	Sat,  6 Jun 2026 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711805;
	bh=JAwCsZe283PogVPv5y6mEIRmaXIwT/d1+uaeWG9Fg20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EtKK4I4XJQq+mwUltwoTg0b6nVK0N6rkTuRwPkKZ0+OdLqmzWmKGJsNG73wHzybYb
	 TyO7UbuwMf37w0B2OeBpaJb1Q8L0A1gQWGqQgri1cN0cOVADOtB0jwIBvjtmHI59tV
	 uxmQrlcOrxqyRZ2Sw6i9xjdLWEvHfwKnoQqwDAfgqB4uQyNb6Jn8HXw6kSCPV8HrA2
	 QfotFwkwP4h3WlsuQiOXpPEB9bGMkQbhhK7MbYP71gPjV72LHZOsfjOtRe8Gu3NEUL
	 CdARkNUAilg4UmdZ57zfTk9+C3nRntd2r3GXSIuEOCc+nqqKnenx2fWu4EeTrPbbik
	 AaDU+xl4grPow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6E3930A9C;
	Sat,  6 Jun 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v3] netlabel: validate unlabeled address and mask attribute
 lengths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178071180540.3993660.17762281633996565316.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 02:10:05 +0000
References: <20260603011353.101776-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260603011353.101776-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 09:13:53 +0800 you wrote:
> netlbl_unlabel_addrinfo_get() used the address attribute length to
> determine whether the attribute data could be read as an IPv4 or IPv6
> address, but did not independently validate the corresponding mask
> attribute length.  A crafted Generic Netlink request could therefore
> provide a valid IPv4/IPv6 address attribute with a shorter mask
> attribute, which would later be read as a full struct in_addr or
> struct in6_addr.
> 
> [...]

Here is the summary with links:
  - [net,v3] netlabel: validate unlabeled address and mask attribute lengths
    https://git.kernel.org/netdev/net/c/9772589b57e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



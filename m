Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE360485507;
	Thu, 15 Oct 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062008; cv=none; b=tSJ2lZ5fNl6R3zhpvikIEytDUurh9CPJmZAXmIMi9jHS/C7i6j75cUtkVceoswXLT4GVJHNyqPX8DooeRmflWB2SIBQQM2cJFS+/iwaxXO+cWuKInhfl/f8heoz3gVePJlxYi1ok+DeOvoG2M0mIutbAzLSaMWXowMNQXte0e4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062008; c=relaxed/simple;
	bh=2VBUzFaIjiQ79ynMkqMZwdzFhM6CrC1xuBJMsplJ/08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=doxhVGr30P+buDHlgJ/MVc1/cq9s+Eok4A15exi9poms7ri5yYXBYbbpvcOElZD/904ZQrduSRMydB/fvEVhw3JKyve3tCTa0p2X/28XS3Pqh9kK/uFnrcxlZH4s/glKm4XcpLkY8Yc2gCUrdnc/Yfa1tz9jvK/vdug6tKXE3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5nEGfmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5nEGfmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8373A1F000C4;
	Thu, 15 Oct 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062006;
	bh=9m62fB7DwTpC3m+3ll+77O6kf0vhJdslbPryZFtNBVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O5nEGfmflJ28FUTspVLQwRSVetX0egqn0b3+bGZJI3riYGty/TNgBS9Jj3gIXecbP
	 KvY6RD+BdOEfMKhj0cF/7zzrHAWUIh/vzYZ3x1I/3grf1fEgjX79seQT9Pzsr3vb9C
	 drbF/H/Zzf4CCUh99f2Jij5kj7wFamT2PdN7EAoLF0HrNZuNKhmxf6pRDv4JgU52Nk
	 xnZJWsflK9MmKgEQnTMHpCGR6tC34uFxtl5h6EXVBixKpAS7ERj2XQPUOvtUBgwmQV
	 v393HZ218iNvOYfqyM4587Yef6RkN2B5DNHLCNfGk8Dklo2+OzZCxdNknGHkafc3gs
	 uZsMxv0oTpzug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77430392EA65;
	Thu, 15 Oct 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] calipso: keep BIG TCP payload_len in
 calipso_skbuff_setattr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206200502.3357824.14370454799792033360.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 11:00:05 +0000
References: <179156155963.36253.400481753322266658@gmail.com>
In-Reply-To: <179156155963.36253.400481753322266658@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: paul@paul-moore.com, edumazet@kernel.org, wang.zhan@smartx.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 alice.kernel@fastmail.im

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 09 Oct 2026 12:59:19 -0300 you wrote:
> calipso_skbuff_setattr() adjusts payload_len by the length of the
> option it inserts or resizes:
> 
> 	payload = ntohs(ip6_hdr->payload_len);
> 	ip6_hdr->payload_len = htons(payload + len_delta);
> 
> GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
> payload_len == 0 for them; ipv6_payload_len() then falls back to
> skb->len.  For such a packet forwarded to a destination mapped to
> CALIPSO, the code above writes len_delta (or 65536 + len_delta when
> shrinking) into payload_len, and ipv6_payload_len() no longer falls
> back to skb->len.  nf_tables, conntrack and sch_cake rely on it.
> 
> [...]

Here is the summary with links:
  - [net,v2] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
    https://git.kernel.org/netdev/net/c/8070ed578b6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



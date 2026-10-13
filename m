Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE763A83B1;
	Tue, 13 Oct 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886207; cv=none; b=Nkni5FyGel6ZDcNNtkbmq0ZBd32Ds4AyV2KE4Mh+h7rCWH89ZVhQL1ViIveUnjN9pV1D7/iDgTFY4/z3xefAHPcPh7zvsPMsqcxvHUD7AHsl+HrdeNlGtcla4R8z2BACXutmWT48WsBohLLVdbO86jA1FDISTOjXZ3+bl/J+Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886207; c=relaxed/simple;
	bh=xp+PgL5DDnyHx+ebR4oX4SVhOdKUA4bH8GqZTXmBCC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QTdB7tTqmYZF0lNhTzE14GK3mJbjiP2W41NZurKK8Z/4/D7XZ4ux44dkZHIHTDnTil6bxAmJUaJlTwwyNm7BGJ8nUai19UcswG7XPcfOokUMTB77BsCvqmNN2TFpKJ/tP9V2iBA9UY332i7IMEGihQT5Sa7oFduL+eCPgTZxNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYpD2m2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYpD2m2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEE61F000FF;
	Tue, 13 Oct 2026 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791886205;
	bh=5sgeYGqUn15szmOLtnTRbionXGUFCUv4tj8tz96K9lY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PYpD2m2WaUC1FEEA+nXsFJxmuYvR2LW/+4YkJQQTrUXOTqeoqaM2L08NRRbNn+d81
	 ChJg54xkk9aK0DoVvgUGIpzuuV21l225kbZyfQIqFXxEhW/Y74NvQxSrw4UxfFPNFO
	 1b6EZ33Q/VJp6+AhfhRMyqc55tLTOMKBNeytSYUA0BUj2gj+Dezhj1aNgm/iWnIXOF
	 AytS35OwtSx2TInq/udRC9yHoYC/nlhoy2Ul1u5DF48quorVj12zAhJWA+GuZEb97Y
	 ZRuZ2une0lk1nvujSGKY3rOLGRlA57hC7SC2CbUysBCvt0GPnHFBoKdUqw9A1oKDpW
	 KnYDFcl4u1bbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44383926662;
	Tue, 13 Oct 2026 10:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] calipso: hash the cache key,
 not the option start,
 in calipso_cache_add()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188620452.191181.12068195457732970673.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 10:10:04 +0000
References: <179138670045.80227.16155454353416856947@gmail.com>
In-Reply-To: <179138670045.80227.16155454353416856947@gmail.com>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 07 Oct 2026 12:25:00 -0300 you wrote:
> calipso_cache_add() stores calipso_ptr + 2 as the cache key, but
> computes entry->hash over calipso_ptr, i.e. starting two bytes earlier
> at the option type and length.  calipso_opt_getattr() looks entries up
> with calipso_cache_check(calipso + 2, calipso[1], ...), which hashes the
> key itself.
> 
> The two hashes only match on a jhash collision, so the CALIPSO label
> cache never hits and every labelled packet takes the full DOI lookup and
> category conversion path.  The memcmp() on the key keeps lookups
> correct, so this is a performance bug only.
> 
> [...]

Here is the summary with links:
  - [net-next] calipso: hash the cache key, not the option start, in calipso_cache_add()
    https://git.kernel.org/netdev/net-next/c/d538cc3ec0bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



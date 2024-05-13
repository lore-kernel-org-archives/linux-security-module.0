Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBD2C1A9;
	Mon, 13 May 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638229; cv=none; b=dnXqN8b8IXKCnUFDUvQmT6H/YkIYBh6mZBQzFJC9UPXYuxGXRnWpaP+bAE9wNB+lz8fAmSFjmiugmhCxy5FnOsc16yZPMGL/lvXlbuh7NJH1SBVlOMk5xQsskMzueeR5yPh7Nrlgda+mOb58urYD7aI+LenHomUbpX+MKrUIJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638229; c=relaxed/simple;
	bh=ilqhFV/9QB8Her4jndF/ANYQVZtjiFTovuemUPh5TuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fl8Gf21pqI5bM/a0WF2eGsvvDM3+/9GTAYVNkWolQTP2QsftRk/MzfH9NcDC346zRlrTSphoBZThpqMAQ+GMkmGTXhFeSrL2mVjxw1+4SnthJ81eDiTK9kwF+HC2r5Goswa3/IXP1Cg2ZxrKhycWUBXFpNgjBksH7XHNA5tp2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W42F62Wf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W42F62Wf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CE4BC32781;
	Mon, 13 May 2024 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715638228;
	bh=ilqhFV/9QB8Her4jndF/ANYQVZtjiFTovuemUPh5TuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W42F62Wf8k8k7yzM9T3LoQIzfCs7vpbPUTsBjThvaaRi5Z0twQji6CmB+UGA7XM4a
	 il/yKxtZ0Sx/mHq695FKPyUeiL2E4c4y+pKsilktQJ8iTlVb8AfMwkNyqrxLNkhjmG
	 iiVlVJqHfpIKDVS1Rh1dTImtPBWIge9HE/Pd0BJbfIMdv7QImsc10BTVyZygg9+I9J
	 rYi4zUBLQwNChOse2Pb+E/0H+yTlwLyBQZjLpe+xBs47x64vExpEm8lkURO0F3r5sD
	 rYau1l52mNmYBqrR+43iTr3oT1zVhCSWZuRrdceuzH29WV1alB5flUcPQyPU5lZDV3
	 SfriHlkfaY5Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68511C43443;
	Mon, 13 May 2024 22:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] netlabel: fix RCU annotation for IPv4 options on
 socket creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563822842.3982.11882395457554772824.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 22:10:28 +0000
References: <f4260d000a3a55b9e8b6a3b4e3fffc7da9f82d41.1715359817.git.dcaratti@redhat.com>
In-Reply-To: <f4260d000a3a55b9e8b6a3b4e3fffc7da9f82d41.1715359817.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: paul@paul-moore.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, casey@schaufler-ca.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 xmu@redhat.com, omosnace@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 19:19:12 +0200 you wrote:
> Xiumei reports the following splat when netlabel and TCP socket are used:
> 
>  =============================
>  WARNING: suspicious RCU usage
>  6.9.0-rc2+ #637 Not tainted
>  -----------------------------
>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
> 
> [...]

Here is the summary with links:
  - [net,v5] netlabel: fix RCU annotation for IPv4 options on socket creation
    https://git.kernel.org/netdev/net/c/8ec9897ec2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



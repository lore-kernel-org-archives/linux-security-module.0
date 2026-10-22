Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702224;
	b=TP/qZoBhY/vyA0VupzSd17+5D3CHQzUDr19wqr1iPQjE+jGL5BiZ7fKQjb2ZLHB6M8kP
	 rA+TYlREcfAagKTHC16IYhEpt6XNts2zNaj7CpOfSs05OUGOsbMpM1JTEDVyy3Fm4cIkN
	 F5ch6QoJgobaGQBqXrJRpZD06OXjo83doV98a8YpP4NcXjEW9IKSYHkm4EcGsdfvnRvZo
	 RGGsZN3gh62RHYzhUzY9ewQfqDcwhcsQLk2p3te7ViWR3Mi5eN+hk8BelHCadHtvToR2Q
	 Yb5ZUP5yrKN84Hui+w+hIShLYkqPI55qM/cDW+o9Y354YL2/8Dr/5LU/IxLuW11cyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702224;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=7uiT6VulkfRcxAQWPp392Rc7H+VZnZrAHxidrz5We+4=;
	b=qXapJd0TzDe3EsWAGYGw3fr1t3vDV6agyoaG8phNlzClvmJXhKKhNXCrz8wWPn6gPs7D
	 x5FJA7SoGBC0xg9rAuaTMOMfwt+CFiq7OFYDhJ8YYusd0FYFcBIRL3LVeDoLAGg8DJkxV
	 8WzU8+z5Q0Vz3rdA665KWP2MoM9e2YJNIjx3q9XxtsBnIo85r75FaJ4VihGmrlamwLs9u
	 sb/G1hHJLb6hF1Nj/8hOE6tHxamewGgQS2B5lzBqt8FXrl94Z/2hSQzxmHe0RdhY6/vnX
	 8RPUho4mIC4TzDmCgs5ZjvZINDIl+mYAw7NzMC212bU9oUjowqZStkq/AFPpKR7s/Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Do0NiTwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE260A2608;
	Thu, 22 Oct 2026 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Do0NiTwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26E1F01828;
	Thu, 22 Oct 2026 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702223;
	bh=7uiT6VulkfRcxAQWPp392Rc7H+VZnZrAHxidrz5We+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Do0NiTwRB77mZoClAJQGvzIuJ+8b99Wm+4lniXhkb/BjLbVbjuTbcBOsi09aqYofa
	 nsbwvRv1ojxXRrcaaSh/1JwkDAwH+a6Y+pC0PVD/C9AiS+fneyeiqLfjxmFipe7Lks
	 un2paUNn6IIqzQ3Vi1bIgwsj2NfCrfTNOm5qOrQZNjl0AaMReR9ivwtYaSMqrWVPqi
	 cqTeb+0XfORrlz/votMP4Sil4qKOuSrApuGMd1+GxXgMfAEDDax878yg5w1oxNlfge
	 64m/bOUcn5mxv4dZDUu8sUm/VbBZy579Lk3lLD22irW0h16UnDruey/94RO3M8ZxJi
	 FF44u2TY37nbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4447E3808222;
	Thu, 22 Oct 2026 20:50:23 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkFZqpVB5+Bvj0OQhVkkRWfQQ2Rh1F_fnDxZfxeMrKo=bg@mail.gmail.com>
References: <CAKtyLkFZqpVB5+Bvj0OQhVkkRWfQQ2Rh1F_fnDxZfxeMrKo=bg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkFZqpVB5+Bvj0OQhVkkRWfQQ2Rh1F_fnDxZfxeMrKo=bg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20261019
X-PR-Tracked-Commit-Id: e2f08fadb48509c239e47cdaf81438c162395932
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbc48daecac6c69ccbce4005aa2a681298e2fc7d
Message-Id: <179270222210.170280.7353148606987698606.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 20:50:22 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 19:22:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20261019

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbc48daecac6c69ccbce4005aa2a681298e2fc7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

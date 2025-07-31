Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07492A29;
	Thu, 31 Jul 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988829; cv=none; b=SdhfRROeWbYNmvdoKYhgEiecqOvN0Cnry7w9ScJvSxBeJAlBkD4soSeE6mA2yBjjwEg1N8ukUQn4hR5iZkW5Sa+iwLEXoRwHZXW19U5H3A/Gctxxi6Yj3P/IUyvRNl/qENiAFHX0hJ66bw2cyvL4aJLYr0lYiGsgFu8FDKW7OjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988829; c=relaxed/simple;
	bh=GdR/u3IKBHYIIXgTbc5ECney4cw/+8g7QSXFnYxn47A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UCjtNvRstONI39SawOl3eEeaugaIfynutAjq0vOvwQu7llGHFVglEQpYNMUDi70WZh0v6onT0pAjt9yfICmvlGhj24mzDAfNuZLzPYMsL+2Plg4BomFuWv3kgRxtE2BjKkAh5fbkOABISURKx1+83CpvbY8jixfb/pad2la8MXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Eyjga0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Eyjga0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BDEC4CEEF;
	Thu, 31 Jul 2025 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988828;
	bh=GdR/u3IKBHYIIXgTbc5ECney4cw/+8g7QSXFnYxn47A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g8Eyjga0bpgaDOhGN2pEbQMh7N5o92C5xveBRNLxsbRkjoQRAsXpwp0PAZzPpgewa
	 lnVa4wBiQ+nMkj1TmWkbVDF42nIYVymRQMKYpRw3XEzoayvw55Zc9Ks/FjpowqCxDE
	 2L1fphWyI1Ekk9k8AmXxZfi3CQ4D1EQkF7WTl4xQy4v9BYHLas6CVkno6sYROJ7N30
	 VAuWWYaGO3Y/kueok4Vbn1Is6XSo2hiup4orTZToQUe7yEiQf1KHWOP0k0uIkn5m7X
	 3BL9g7qO8A/0K9V3dAw+EwU/8InbmcEBPV0T/wY98tQxiW8hhO6aXLMDz8TngQUkOI
	 oGlOFar9PluVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE025383BF51;
	Thu, 31 Jul 2025 19:07:25 +0000 (UTC)
Subject: Re: [GIT PULL] capabilities update for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIkfm1AGBoINgSRF@mail.hallyn.com>
References: <aIkfm1AGBoINgSRF@mail.hallyn.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIkfm1AGBoINgSRF@mail.hallyn.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20250729
X-PR-Tracked-Commit-Id: cdd73b1666079a73d061396f361df55d59fe96e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12ed593ee88170145fff25c7b3325b227731c2a1
Message-Id: <175398884417.3259326.15289261586310596227.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 19:07:24 +0000
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>, "Andrew G. Morgan" <morgan@kernel.org>, Paul Moore <paul@paul-moore.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Max Kellermann <max.kellermann@ionos.com>, Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 14:23:07 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20250729

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12ed593ee88170145fff25c7b3325b227731c2a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A0DF42;
	Sun,  1 Dec 2024 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020892; cv=none; b=FAY9zkw59MU+R5uPW9doqUNon9hSA4rmF2gGnjxsB9+pk7EHnIauq9HGB6OueiHsjhcPMZnMTFvVHiX/Rw3/i5CZCN3dlYacJrihOGebcgre9pyxxYTS6RrdcIZW64y65cvueX960Y6zpfZkoZ1K/PxwMasK90cEdvB8c92D6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020892; c=relaxed/simple;
	bh=oIy+fpkV87SScpCJs0xRIVPnkZgqozHMqFllGvGc+60=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D1BBHa7lJWNWaVm8MgpUgDhH41+WKKxgV57UW0F3ko5IZ5b/xqBt0Dqx9Mu7a5YO2EtwDn0dfbMnHqxCX39ZRC0la3GWMm7JdI4iIvgMYHgFW9/4zln2d/dChGXtTLqupjdXegewIq8nTR2PIeeWtexy+De4Dan9n/V5HpuPuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdriaCgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdriaCgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3E8C4CECC;
	Sun,  1 Dec 2024 02:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733020892;
	bh=oIy+fpkV87SScpCJs0xRIVPnkZgqozHMqFllGvGc+60=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RdriaCggj3u9mgh0Ws/EJDZpopa99/UyBORjhPnwXTx4jKJMTr1Mld5F+aRjPIm6M
	 WpZteVHbg2joNUSWoB0AGbKkS29aB90bozwh60G+GBmzAsVKW4i1HulffaFEOgW29U
	 5XTlqUuiQd6/SbEkNrdmD/KEf+T32MTVghX7S5L27/xS8kTD1SL52kOnHjyrTt1+6L
	 9eA4SuFfJKmgiHMcxGvN5e0babjDKrouPf8GZF0Qf5yYgDiGAAXlHv9MviPZMk0HDx
	 23K34si022xd2+1umWw4IDYupyxfEk6FEQ3VOPbZOmC3gSnvxwjEre4IYfoeXM3XvS
	 0EnOlj0masJhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EFA380A944;
	Sun,  1 Dec 2024 02:41:47 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20241129
From: pr-tracker-bot@kernel.org
In-Reply-To: <86752346e28a77c830cb8249610f0f00@paul-moore.com>
References: <86752346e28a77c830cb8249610f0f00@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <86752346e28a77c830cb8249610f0f00@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20241129
X-PR-Tracked-Commit-Id: a65d9d1d893b124917141bd8cdf0e0e47ff96438
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a6a03ad5b04a29f07fb79d2990d93c82394f730
Message-Id: <173302090606.2541785.9230764380623435630.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 02:41:46 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 21:27:33 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20241129

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a6a03ad5b04a29f07fb79d2990d93c82394f730

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAD28C2CE;
	Wed, 28 May 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446843; cv=none; b=LLlsCkCKrdX1+p6+wStv7sB9Ka2KGBY1WrIiy33kUT7XYN4klWbQtQgBLv4mF+N8ssHADytDe9x27kRPQpO6SNfK2yDOM4igWNW2ezU8wHX1zDhBWewqp1FWAwXzDt++LtTzx+b01cMO/C/49gnSv2AHRr9d005B5yrrAbPNC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446843; c=relaxed/simple;
	bh=id7cLHXlKvI6Bxx1Ngc+Mlov47TqTRZUpUGFtZtWGps=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eoeHmZIPhy432wwOigwybteAoQyUv6BbY0HsVeBfLXxzYkg8fpqi48IqBjkj88glv+CVN38OoWtBeDaOaWiScPyXaddRtvH6MRsKaSXyY64d8jNJzBONb+7VYkJEDOBM6Pos8NBae2lH5u3YcY8bVzrGtGSQP02PVkukvTYnbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx/0Hbe3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx/0Hbe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79788C4CEE3;
	Wed, 28 May 2025 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446842;
	bh=id7cLHXlKvI6Bxx1Ngc+Mlov47TqTRZUpUGFtZtWGps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mx/0Hbe3WqpAx49YL7GbWdE5vMwbCryqjC4TJa0Dlw6aJQD62s9gO2QycvvAVzH0C
	 IFSEwkYzFill2AZzF//88IIwZpVstTRieln6ATt+QBxIV0IXERCF7BfDWhSFtbVJ47
	 muvoZ1JX1xED2VPPxB6Q1WozSnVUkrminaFT/oHrx4tQaLmNFplupEi5pS/Whrqblq
	 KzJjTHW2nhdLGpBumfXMFlRwQivzJe3fXbO+Ph+MjfUubo7EPGKpoKGtIEfyQ9WHPi
	 oX35dA08WSwIAjUvJxNgCePo0NV8fAWympViqMV6PdaUdl0aiT5wUf64kiSSZXH/es
	 XmEqM1L7UoN9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE19B3822D1A;
	Wed, 28 May 2025 15:41:17 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20250527
From: pr-tracker-bot@kernel.org
In-Reply-To: <c033219926c0701369d6477cedda170b@paul-moore.com>
References: <c033219926c0701369d6477cedda170b@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <c033219926c0701369d6477cedda170b@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250527
X-PR-Tracked-Commit-Id: 74e5b13a1b0f10c5a5c6168f6915620a1d369fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bc8c83af962a7f0e52c1ee254acbcb1d9204a5e
Message-Id: <174844687686.2439471.285203290127435818.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 15:41:16 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 18:57:36 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250527

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bc8c83af962a7f0e52c1ee254acbcb1d9204a5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160A39D6F8;
	Mon, 13 Apr 2026 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120508; cv=none; b=brXxlqZ7m7ULE9COeVbnaX4hFsajRQY00e5AuVD8+XuM8ollJSUWhMyGmj/QuHYkRRHsZlmdmyXMcKr0KZKjMrzFQ72DD7+tza3RZAcM7L20oppdHvyZP2fobIXcE+51vW2Sre1oOPMoZkJSN07V0SScIWJb7o7aP7eQ68in+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120508; c=relaxed/simple;
	bh=T1e0YZXOhcyGv5NlCNptL2zZ5sUmo7EdfazAQHNq+ZU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NuZOQ5BkqgIfcK5Q8dbpF+46LL+C9UK5uBGUr+9ImMEkoT/fFRi6Flk/ysgIc46BGqam2CV1YGuu17XPME/HJnePI+VKHGf2addyqcU37xDHV94x5HL+Cp1KKr3HumdbLNJTQgSFpClhXh/KNtc9bzO3/W7Tjb4bo5ts/wKYdDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX/0DQI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX/0DQI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F54C2BCAF;
	Mon, 13 Apr 2026 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120508;
	bh=T1e0YZXOhcyGv5NlCNptL2zZ5sUmo7EdfazAQHNq+ZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jX/0DQI9d0JLpyDhDfaUFOx9+z2OTVFS1/Ca3NGtzfT+rIC5klrYlqVP1ktyrohA7
	 x5ZnXpQBo2QkZbtIdmpKTsnrwURotzLrD2IbTCDSepplxToSZWrnvUiQnXthptroTr
	 W3Ba5RUTHB7koJC41UMFacib3R65HLl0U6Mdz6+IIBw0IJO4NMXGqvBkfs2OfpApaN
	 WHALiH6p6pNRh/P6yXFkq6zgCd0/4F0nj6hV5vLFU3KgyORK4sBNGnQOJCdm5hYAJ2
	 V0+ityUGgQ3h2NLQLM13iWoV1QCJ4zHiHKu4Pshq1AxVSrqsSVqPLZbKunyGYAKQ3w
	 0ylkBX/mnim2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E263809A0B;
	Mon, 13 Apr 2026 22:48:00 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20260410
From: pr-tracker-bot@kernel.org
In-Reply-To: <9a2a59bd8d9548fb5dab128f4859fa3d@paul-moore.com>
References: <9a2a59bd8d9548fb5dab128f4859fa3d@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a2a59bd8d9548fb5dab128f4859fa3d@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260410
X-PR-Tracked-Commit-Id: 82544d36b1729153c8aeb179e84750f0c085d3b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ba310f2a3ca70f0497aab5c2e8aa85a12e19406
Message-Id: <177612047919.584243.13730146545160643913.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:47:59 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 19:26:05 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260410

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ba310f2a3ca70f0497aab5c2e8aa85a12e19406

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

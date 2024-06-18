Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E21553BB;
	Tue, 18 Jun 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722207; cv=none; b=Rj6g8Y07j5NLXjbb3/v3a0V2OaQHx8tBTvOkTe0Dua4SK3J9QA9oMjOYWfBIQHn3SQGFSjPGW26pd5q5Wp1BBReOkrEui3LIXrcvRfkRDXtpOU8hch23CWK/HS6WWqNjbgWsshaXwt9W+I8gdm0JfQmvJ0073DXi2lh2ZAu1jxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722207; c=relaxed/simple;
	bh=fY633jyQ5BVypOhSXWHCxi7JzWD09Tr8VLpPLszpwJQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iQAlnU4rvh3vIBA08m0rKV1MGqqLYUiZ6cUD6+4SXiUvj9SRXQWd9FBMn0XdIAZZDuhF+OoFXaAP4Mn6jiDPIWph4Q6XajvKo8ovCXZRDdK/oJwZI/auhk+ymhKY4cj8DhdFr8VIgMX5rUIb3lIzyejbBx+JoOYUsYu0l5ZW5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/yOdriu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/yOdriu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 001C7C3277B;
	Tue, 18 Jun 2024 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718722207;
	bh=fY633jyQ5BVypOhSXWHCxi7JzWD09Tr8VLpPLszpwJQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D/yOdriuk8q1kf5/ykqRKY9Bst1tdw1UphI9Pa+C6H05WDolNGlBKh8mC3JmqtJ5E
	 oWDvWlSwEXvB/9OhpRN+//SQ0I+wnsUkdwdGGMMr5g5LCNxWF8dc0CJVvl4s3WLjwm
	 PGFvYA+jK/B8gmnYHsugiVkjfb4eVlhPOaZ1UQ0tYllD4mmrCAi5ZrjqvnbdRBFEzf
	 RKE4sAVSR0vukCKMr0bT5e76TknyfNtRB1tba9ruEORUbjVnrwlS9bSBwMYKxN2N7b
	 Xps0epMZz3edgrEKyHaY1FghWSTilTIDRU/nzXESCnV4Wc/tt9J1SKo36mUSsZeyEa
	 XiBCCR8h9GoHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1A50D2D0F8;
	Tue, 18 Jun 2024 14:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240617
From: pr-tracker-bot@kernel.org
In-Reply-To: <278d13277e281ab2e358499fce8a849a@paul-moore.com>
References: <278d13277e281ab2e358499fce8a849a@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <278d13277e281ab2e358499fce8a849a@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240617
X-PR-Tracked-Commit-Id: 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d54351c64e8f9794e8838196036a2de3d752fce
Message-Id: <171872220665.2478.14917639723232943459.pr-tracker-bot@kernel.org>
Date: Tue, 18 Jun 2024 14:50:06 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Jun 2024 16:47:53 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240617

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d54351c64e8f9794e8838196036a2de3d752fce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

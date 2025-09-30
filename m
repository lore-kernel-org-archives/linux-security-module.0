Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4330749E;
	Tue, 30 Sep 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253762; cv=none; b=k0bNejwzj8273vf4Ec2Rim7v9Xqsvb5AYKEilf+l8RIAKISjCZaf5ntzWOZokB0qqd+8jqRZdLT6lMXNhKJKmfgaFFX6D0fTn6k7ToU/TxVuQo60yjvDhfcJueGZADwC/TtGqdpK2+QKSVGnghU0wwj666NpE4MQn9NABlQho3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253762; c=relaxed/simple;
	bh=9x/YIeKwRd/OmK9yadAvrqJnbGozumOvkf2foUJj/EM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W9L5e5Oq+aUyhSS87ZxeWTIkEk9A6up8y9yIHNGUoAczmkq5tGZntIAWNuVvtiPzpP9GNK1uU7hXk7L/bGmGnYpKp0mKexAB+Rw5g/q1vB0BVuagRtN6f2dhyXTF4lkiGOd9eQ5OgezyEsYUZkVW9BELeJHmZcEnphSsDPTTcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKY2+0ho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKY2+0ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AFBC4CEF0;
	Tue, 30 Sep 2025 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253762;
	bh=9x/YIeKwRd/OmK9yadAvrqJnbGozumOvkf2foUJj/EM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kKY2+0hoERPaUY6Iy/A3VqB8CV2trjHCWjajeS8Ru/WRa83tEWqpyxyAMePWzWJLJ
	 TaqwKdoIrOKH7ET9OStLHPPP0OtxzZcUdk5o5OfIad+Iw43qARuEMUNkAO7iGs986N
	 5jFzLDiYEzGA9tIttRlWlBGZMeqBfujNk2QjsiPwlI7zmXk1+oSXnEiyfnbh3Giqbp
	 5La49/67cibDLjq5HCJm3t2DdfQHC9KHezzNAtMu2t5tGPMem8YFyeHlno/RvjF3oh
	 i0rDJK3Ct6HFli0qaOfEwFkU+Jt7iw3HYs+8eFfjnHw93gLn1ZQiW0iUajrUZRvla1
	 1hU/q7qDfarGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5439D0C1A;
	Tue, 30 Sep 2025 17:35:56 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20250926
From: pr-tracker-bot@kernel.org
In-Reply-To: <1c4f33b7d1e986bb09ce18410200f91e@paul-moore.com>
References: <1c4f33b7d1e986bb09ce18410200f91e@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1c4f33b7d1e986bb09ce18410200f91e@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250926
X-PR-Tracked-Commit-Id: 54d94c422fed9575b74167333c1757847a4e6899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76f01a4f22c465bdb63ee19aaf5b682c5893ba96
Message-Id: <175925375513.2087146.15925648100593093561.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 17:35:55 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 23:07:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250926

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76f01a4f22c465bdb63ee19aaf5b682c5893ba96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

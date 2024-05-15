Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1068800;
	Wed, 15 May 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790910; cv=none; b=GKVzKODwFaCN10WRGCCbMMb1fFKvS8WVeQ61Zy4zGY89pLOxrf1bMv4B7I1axeCvOaZS4KqNkUR0K3SAOGX9jGdtehVj37shoOaNF/bPz+WpqvFnL8M1/RyVtH0df/sBBRx1r5SrBSMmRVOJzOs9obdVyZ442ExgpSZQqXP/iCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790910; c=relaxed/simple;
	bh=4NBKgO2nFP2kOn6mDUc+hOhOTVmSGCSV4LJv6X+02JE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EzJq15OlkeURo8btd7+71k5JfAyOSRGaRzVgu50i378bc7A5VFcdY9ZfIlepPmPippRlUtKszT9UIdhPsFV/LiHzfqRWfIW7f4AXegNnS+0X2LRT0Xuelb9lcAXAkEqgrn82u7s4PmdZVl7STYhz45pZJZ54gzkaoocTcddHNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCO4W6rB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCO4W6rB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B161AC2BD11;
	Wed, 15 May 2024 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790910;
	bh=4NBKgO2nFP2kOn6mDUc+hOhOTVmSGCSV4LJv6X+02JE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SCO4W6rBuubbkdczP55VwTPpdcnJwR39Q0vDB1MP7nx/jmM75syoRCYDg/uvO2Zcb
	 gkF0LyFG7LgqNpdLm6I4gLDXQWoysTtj5e9yJZ3cD7cthdw7GS82xfzKGn61nSLYTl
	 teiJVNY0EgJK1tdU312/xCJnLVatehBs6xAEB1/Hg/u56aE69ew97BREMnpkqu3VvS
	 kO2Pz3HUhNFzhywPzDjSSbrrUu0pRIZa/7VVo3LJPajzv5psVP7T+zgZ3uU0CLOPZW
	 59+jdAps+UrY61CA/H4hVlqlJNxSb5N6RrCT7wtKFnywVubqy4WnwF6bMwa8Zjay7+
	 Ddvj7bDqB80Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA0F0C433A2;
	Wed, 15 May 2024 16:35:10 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240513
From: pr-tracker-bot@kernel.org
In-Reply-To: <eb9e94532b792619e4161de6c0a397db@paul-moore.com>
References: <eb9e94532b792619e4161de6c0a397db@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <eb9e94532b792619e4161de6c0a397db@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240513
X-PR-Tracked-Commit-Id: dd80c7465029dd0671e6f9fc2678ae0fbdf785ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cd4e4b88100a33d96ec4f83bdb0e4e754e24c97
Message-Id: <171579091069.28973.11955824806721421850.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 16:35:10 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 15:47:12 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240513

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cd4e4b88100a33d96ec4f83bdb0e4e754e24c97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

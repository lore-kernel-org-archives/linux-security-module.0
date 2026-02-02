Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB54274B35;
	Mon,  2 Feb 2026 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065279; cv=none; b=Yt5LYuTMqqhlNhtyPQC04BfxBkMhO6PZrlXqhSP4bEYq/nMGq50P8FSfvIj2wHg6xRKyoX3G7dhKg3tckZNnj0HhaOZ7YJjorV1yhFgSeQqkCU4napGGvWqSLP6SsNq48ju57XaLdGE6bwtt8fT2fiteciadLHiUnPfE4oDlt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065279; c=relaxed/simple;
	bh=LiK/bkOXAJsd6g5x9DXzkN5eQPipgwgbVBb2oEEJpHs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DFhJ+UiEFrYXVIoUvzz/p+X3Bbiy0gDJMStx52korz/liLS0WFd8ZMnVjXCPu6l7dPEI1UN2FIHPnr4MkE1u9QJ07SdrVKFSAemvCU27KgTRBfMTydbHD2RHqmh0HJlkvbKPs/h+O+Yg0KQQd6vkZcHSFUyc/+Qgi1Ve54j0hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sie31vNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sie31vNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D36C116C6;
	Mon,  2 Feb 2026 20:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065279;
	bh=LiK/bkOXAJsd6g5x9DXzkN5eQPipgwgbVBb2oEEJpHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Sie31vNstj2Cu4CjhJMwTFLNYd87lPTGcX0eQtrV4/aaLJVZhq4t6mbUpvmLK7+y1
	 usQuV7QvFSty9PXa29mTbEP1BHb0gWnzBxSxeJGTQ2BxI2Ygp7Dypjo3jdrCLd6CpN
	 +kHAroSgil8p9WRhfpCV9kl5OJ+jZdsqZKbxohEMSjXR2bZI0yKvBTizhNth29zy+L
	 zJmr9KeTp2sc0bPgzjhYj6MIM+FBQ78KT7T8F03Vwkuyr4ePOGOpXOR9eiMad7Qmyy
	 KTiLjGhwZ/NgYe/85Kuv95JAtB8WDzMwTyw9xHOJAHpCgjYjMBrrHwbfoPiV+n73pD
	 v68A3kbs+G8zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 542B13808200;
	Mon,  2 Feb 2026 20:47:57 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20260202
From: pr-tracker-bot@kernel.org
In-Reply-To: <1840fe300392f962e0bd444941c24969@paul-moore.com>
References: <1840fe300392f962e0bd444941c24969@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <1840fe300392f962e0bd444941c24969@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260202
X-PR-Tracked-Commit-Id: bdde21d3e77da55121885fd2ef42bc6a15ac2f0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dee65f79364c18033cabdf0728c7e7025405cf40
Message-Id: <177006527594.1185825.11940018596223733420.pr-tracker-bot@kernel.org>
Date: Mon, 02 Feb 2026 20:47:55 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 02 Feb 2026 12:37:02 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260202

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dee65f79364c18033cabdf0728c7e7025405cf40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1681C7274
	for <linux-security-module@vger.kernel.org>; Wed, 20 Nov 2024 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143359; cv=none; b=TO1F/BUXYFIrnWx3wjkQ8rhlHP2JbVGLab9Z74llVooLwHU311PM5MCMU4uemZ6ZfdOW/RiJ7PEX3X84Xjp7jCkTLO/BQtTst9e2JbMkVu+O8XMTia9aMyuZ4KZOzrAnATJ6+QI9h+nEcIu3zg/0bpeTgc/7okI/JIxCT4B7uuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143359; c=relaxed/simple;
	bh=3V+RGmgvheXXx87CscugIPVFxgDhdS18+wX2CtaARYY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OxqM2BzOskFcXgOCQHttcw7EZIld6TUhKUmCAKnsfY+a7n6FW3UTHxrqOM7NKF6V2VpSEvh1xsK94lIXa0QdsJNkRo1iyr/srwCN6DiTosocZXhcHXq7F9TgsJNGJMoaheD+9PVMEYSFmj0uAA/eHctPn3FkvN0WNeXkdf+2nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVx/6vd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVx/6vd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3717EC4AF09;
	Wed, 20 Nov 2024 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143359;
	bh=3V+RGmgvheXXx87CscugIPVFxgDhdS18+wX2CtaARYY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rVx/6vd2wn7RPBOhPasPJQug02lArvV5LtDtNpkeXV2QugU7QBmMCCzyCFmZ2Y7fY
	 8Mv5JqZBZgtb0xeopdgr6z2KWEyO1TCdEngddqjH9UkNOcZ6wCg7+d3qEDvqEONOL1
	 cPwPrDd2qRAhSqZ6K76OAdgQRhNlltwGjOX6f8w5sXrjFWKzAU6inEnlkNGgGBRG+R
	 SqmJ1bhErvhysWqWWS1bep8ak14xdLCuVrPHlzU4v2vr1Q2pOVX5use8a4/0M7JYXv
	 PnbFfMYYq7xTIENM2wFfCWG109U2IyIU8r6DQOv4KVyd3nLhWHWkXk1jpobjPl4L1X
	 wl0QKgRsIyq/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340283809A80;
	Wed, 20 Nov 2024 22:56:12 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkEwKogdje+Wo_ZH2W+sUA2+E6H1J0gMQ0TEyAfxWigLmA@mail.gmail.com>
References: <CAKtyLkEwKogdje+Wo_ZH2W+sUA2+E6H1J0gMQ0TEyAfxWigLmA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkEwKogdje+Wo_ZH2W+sUA2+E6H1J0gMQ0TEyAfxWigLmA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20241119
X-PR-Tracked-Commit-Id: 9080d11a6c5c1fbf27127afdef84d8dcd65b91ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e7f65647e5216b667d7d98a74446a80a9adcfc0
Message-Id: <173214337067.1377324.13903627732825534462.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 22:56:10 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 14:22:04 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20241119

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e7f65647e5216b667d7d98a74446a80a9adcfc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

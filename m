Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCE146A6C;
	Tue, 19 Nov 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983046; cv=none; b=PDzPfwWXN3sFCDCi+4zoOfcoai9BNpUuqtpmR+J1HKsbRVWjrew9uYaNYP8i+9S15QUalev6XbhVyFquTV3uPKTu7MB85SWmb7ykhs+4C8FGlup0S+O715jHI12qJ7205utFM3HUdGqyouSfUpi8lfp12tKpr905y51oi91CAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983046; c=relaxed/simple;
	bh=mYrnEMJ2fbC/HMlCdgTx4m+VRevH748VosKLCe9RkIU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LtNbBm1/ihDv+Fi/mprnJANvTCQUHwELcBtkFn8RxjT+NAfCKFSLfBxyp9JJK2bgCygJe4LLFH+cIslbdAlqQv88ZmAzPATNoo1qkI9pXoie4Rp45H+Tmmf47utWgJ/XYbEuisj76c734InJ0iRFxuKh+hy4pL/gNLTiULO/c28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy0YmNQ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy0YmNQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3517FC4CECC;
	Tue, 19 Nov 2024 02:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983046;
	bh=mYrnEMJ2fbC/HMlCdgTx4m+VRevH748VosKLCe9RkIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xy0YmNQ9t5yG5l+tO/hBGR/OncygkdUspoy9kkKI0d/Za1a5HFztp9+5DVhaGjxp2
	 dxuLuRQ8lc65T4aM26DvqMUO8I6FDS+RKs34l8Kvk8QJGdpvBVbqkc3gAVeCmGGfmB
	 RZKjYnyZJ6TB78VKfgX5uauW85crSQrSEe+oxP4kFCPGLnNJKX7kbkaihmh6M2QXiZ
	 UcmZgYe3Ie2NblEFoZ3CuU5WjbpnJx2w9VqH6McK3+zg4jIbd4LflyZAWTP+Iqi+d+
	 6numrIeRGHiExUnR5pTq5SBOHwRXCo7oY9lMxDmG2MczVbGT+5ZjdgltFB3nvO0m7o
	 l4f4Q5wZQaKuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DA2503809A80;
	Tue, 19 Nov 2024 02:24:18 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20241112
From: pr-tracker-bot@kernel.org
In-Reply-To: <90954b9699f3d9f2a185f0b97ec2119a@paul-moore.com>
References: <90954b9699f3d9f2a185f0b97ec2119a@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <90954b9699f3d9f2a185f0b97ec2119a@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20241112
X-PR-Tracked-Commit-Id: 8afd8c8faa24249e48f5007aee46209299377588
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5591fd5e034819a89ac93c0ccc6be2a930042f71
Message-Id: <173198305743.73657.12943491414155530937.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:24:17 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Nov 2024 18:02:14 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20241112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5591fd5e034819a89ac93c0ccc6be2a930042f71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FE25C6FC;
	Thu, 15 May 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332875; cv=none; b=nBV+ufmSyVE8XcE+gOdTEGbNdL2ziK6fJnVuVR4FFa7b8GgMGv0OQI2S46bLOHArCMuu6JM9svyFDeeL6Hda4is/eN3Z5fQg6t+am+J5UGevo2pbxfVcDd3MOVQfh1/3a4djsgavOTiocCdc1JpItleT9Cp+ETvr6F2vpeO8w80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332875; c=relaxed/simple;
	bh=4tBnniYi+YQkP1AOF85HwrvW0U1jTKjeKxBUh3u94cA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iFQSetw3+nJ7lmDYY5T2NlQ/F8IAtXOzGbXePAkYX6TLkUWAXzpMgA1I1wTNfjPNvxoDFnogFu0nwZGCJ5NLppHRb0I0k8PW/4HXBFS03SEEnwrL79GHABUGLF5BK1bzcuKqIOfSYkLLr56ii7f/kUUed36NL+OgeEvxc6qiPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzU1eOlm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzU1eOlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCF7C4AF0B;
	Thu, 15 May 2025 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332875;
	bh=4tBnniYi+YQkP1AOF85HwrvW0U1jTKjeKxBUh3u94cA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZzU1eOlme6KNK0zhlikIStPppHUHrvV9GJbFveTjdk06SEO7gcN9EXeYmdTjDX20K
	 92cGZXk8Ppj+a8++oTd4/vMKL9E4B5Bgp2kY5tTj1WrPUZ7l0m9wl3mAahDiXyyWtr
	 q4kToTB0ozpqg9CIxUtZKncqHUTKqieeSrdTTM6nabKGTAPRQgpytUjm5I3KHdzqXV
	 GcdiWlkbl3m+og391bfuL/G6GHu+ykudqgS/0pkpjlxmVnil4ta3nl2vux+5Q13w5j
	 nJQHTPKNCqIsojmpeScQY4FbjsEWaDDy2BRuD66AKaUL3N6tRYizGxwpyX4JLSozzI
	 lvhm99FioftbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D213806659;
	Thu, 15 May 2025 18:15:13 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250515175203.2434864-1-mic@digikod.net>
References: <20250515175203.2434864-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250515175203.2434864-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc7
X-PR-Tracked-Commit-Id: 3039ed432745f8fdf5cbb43fdc60b2e1aad624c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1f2797f8a2478b6b2f731b4f70a87d313f9b41a
Message-Id: <174733291210.3202874.5564790663282781849.pr-tracker-bot@kernel.org>
Date: Thu, 15 May 2025 18:15:12 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 May 2025 19:52:03 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1f2797f8a2478b6b2f731b4f70a87d313f9b41a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

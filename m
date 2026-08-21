Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FE39E6CD;
	Fri, 21 Aug 2026 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344017; cv=none; b=RZ90pd/jczQqgL6Vf7XS4ZRXfHbxRL1DFjojRlbaJlP4qHU2Tfbi3XNscyO1xwPly6Ig3zoI2kFCo4dGkpAhpD7rzbg0DpA27spzooyXuVfV4rZatKhXvYnOfsdtdcB4UoDOTMa795ieXTPS9ohuovik1pbifJoBdWFAnGASlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344017; c=relaxed/simple;
	bh=30+e+NFuNdSJwLhD+pyIkRL2va303dF6p363HgKCrYo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sVF3lMkr0G9+5YTnnEjtbZ6nYruxNmikWjr1YvVAG8vsuVNRIJgp7QyjeTsM12GgCijWdQKh3BSe1q87T6zQECkUwvGBbBbBpsT0Px8yCF1TQSrcaotMY1Xr3cfOuLVE89+ocP63chgipW1CD968xBzglj3P2U1F0stSzmfPybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo17OG2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo17OG2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A141F000E9;
	Fri, 21 Aug 2026 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787344016;
	bh=N7wnG6ztQFVwS1/jn3ANMalOpxOYzeg3Wz4X8ZTdLmo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Qo17OG2yv1aiT17tv9Dnv4HSvsvCFttHIIfFZpS6l3PSEgukIbj/6HIUpzzzyAiPm
	 2mW3X0usQiYO3Gzeb8eeLdvy+4exm54z+xYQRQdCUoFwiGGrgxY7lvfNJ3EuI7NoH2
	 t+a8GWg/mNUVBo/WFYJg/ERYODjrALMY6pXTV1/1+5zs9IuAucAPqly81X5zgvTHob
	 /UAcypK4HPubU61mXAVvVqinHKhD3s7MqSWxavI2foz4OYG+0dS7FiqQFePpIEOBhi
	 gOnTJzoD0QJDDRwDgpACv8qtDEGDcvl5fHyslJ6RNsnEvnL5MR3dMV0YDRGflDiO/G
	 2Z2iHqHOk09Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E88380CEC4;
	Fri, 21 Aug 2026 20:26:06 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260820091208.1001980-1-mic@digikod.net>
References: <20260820091208.1001980-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260820091208.1001980-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc1
X-PR-Tracked-Commit-Id: 172b6a6d8463562b0cbebfd66f770b078f81966b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7199989f3f3194d653b024ce8e79cea6b15e38b9
Message-Id: <178734396532.1471056.13524153107589840344.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 20:26:05 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, Doehyun Baek <doehyunbaek@gmail.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>, Wang Yan <wangyan01@kylinos.cn>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Aug 2026 11:12:08 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7199989f3f3194d653b024ce8e79cea6b15e38b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

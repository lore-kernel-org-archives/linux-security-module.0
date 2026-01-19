Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320112D978A;
	Mon, 19 Jan 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831059; cv=none; b=ko0VNIAqqsIbhcfQwjrdITTlyG6R8Qe8T+QAwFboUIxEq/yIVjuKCSg6whU31FwvoNVE6rp5Ry+7B7jyHUH7NEHOKNUxLB/XjwP8IFycLgA5RBakTEaJFunTIZrPMH/QRgsTxbPnBEJLpO5hwTCZwrYW1FBiicuzNmaNWb15e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831059; c=relaxed/simple;
	bh=Ga83wyV0hc+3BYkJNVXuWT0SAJmY/kzZyogXvV0PxTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mOU8yQHJUY2BXHWrz59I7RfbRWU0VNpwshmvmLUz2Hgs6m+kZgAFZnp06mOgfdDvrEvPmaYe+G0w4F5aEilEeP6t7W8QqxfBgoKwaTtYJgPEK6cH8uV5xUNiefKKgtw1J3103uo36IJitIGhiTpf5qs9r4zh3IrShmX2pKnsiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsv/rAo2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsv/rAo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC515C116C6;
	Mon, 19 Jan 2026 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831058;
	bh=Ga83wyV0hc+3BYkJNVXuWT0SAJmY/kzZyogXvV0PxTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Dsv/rAo2wozBV+YsZIy2GhbsAXGzO/leJOxFf8fQXkjvAddO3PZBlTD9WF3doSL5B
	 hWIYZ1SEbL/3VPjCAJcMch+LAZh4iw+DMLhMg/V5AhWzoSZoGlKT3o38jAfEtwqtoK
	 ONXXW34tKbr8mnioC1iJSrlDpsrv1X8aQ5TD/Qzp33lGX9s5HWOxj2XNdEbGfCrDZW
	 Qjux704ZgERQCTmMoCdp+oIdgDFKbXJZboAZy2H73ytSKpvdfpLvRgEMhDMkt2TYOX
	 dqQxoCX9GkcYY7gGI58GZNPDDJUHXB473pQZvM979MR6mA2hQU348pY29ECOKC43LM
	 pQUGOCFsKYJ4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5C1D3A54A38;
	Mon, 19 Jan 2026 13:54:09 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260115214740.803611-1-mic@digikod.net>
References: <20260115214740.803611-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260115214740.803611-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.19-rc6
X-PR-Tracked-Commit-Id: 6abbb8703aeeb645a681ab6ad155e0b450413787
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90a855e75a99f2932b19f4d04bac1edef158d95e
Message-Id: <176883084830.1423140.7222389833751462855.pr-tracker-bot@kernel.org>
Date: Mon, 19 Jan 2026 13:54:08 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Jan 2026 22:47:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90a855e75a99f2932b19f4d04bac1edef158d95e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

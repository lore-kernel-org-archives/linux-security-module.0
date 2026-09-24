Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB63D967F;
	Thu, 24 Sep 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272839; cv=none; b=PA6Fxpw5L1Qq9yPdhq+Sl/itbVciZte/2tvIIcP0M93SZmYd8psO5QtDzd6klMACVLDvy9QIcJ+jAwdeyJ6uXIUs1KaM1CZfwbQAtgFn/dSoe67WZeG9hUD8e9rBw0EEpmqhxfZOR4CR5mwXNFwcfjZVcAz98tpIq4yPlYz0GZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272839; c=relaxed/simple;
	bh=+EI+E1Jl6p8/QUuACLoOZOWPw5xeV2Q6eqKka0y7pTY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bKHtf8NxwBAowqFiVxhjvR4sQorIz3znA09gU8hOKy2VBFkzD4J2w9V2nC11vnJWWKk0g1z8K4a1UU/nnuHvGJ2S1o/wnK7dallgzytecFrRc3I7BXOfsqmfP8LMFrUfpMOdaCOTh5E4MnrpOH+cHHZ8uFgeISdR06g6sDBCWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlc9eeA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlc9eeA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BED1F000FF;
	Thu, 24 Sep 2026 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272838;
	bh=aIU+HVYRKLmnYi2cgV8qoBqk5RD0i+23KmORQ4HeAZs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Qlc9eeA2/IWywJoFBameeaItI5t7Dt3JgLTNBA+xePClz4XFYFSPJ3tKu27MmErOm
	 2WjLVI35GndZahhi/sZ2DCCSkbakI9ndx67PbuIqVwFSxK+XRVw/am65UVRDUcqRtz
	 k4UBMDCVyRoyIplISbXVuaOWzmH9j+W7WJ6TIqc/yeAYkvvCvTf1iL82yozFScz2jp
	 iLDIDc384GP3eqjzM5lKKn6q9npDu0qT5pBdKm5nuulc8DPWMfVIAZLHqpKrwHiTtZ
	 Se2GKJbs0TM6jbkLzpKRpLZ+t6lpFjPa5J1FBASVKlOChG9jAv+SxXXAInFv/1aztf
	 6UhgaKBKSMe2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BEF3A566DD;
	Thu, 24 Sep 2026 17:59:28 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260924161952.1104402-1-mic@digikod.net>
References: <20260924161952.1104402-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-trace-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260924161952.1104402-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc5
X-PR-Tracked-Commit-Id: e7e0a54300a896e731dffd3e2e8dae5631d6243d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 415f2044228cc8b948dc04e079aaa86a4d1aa1d3
Message-Id: <179027276696.1684924.16367946820439152098.pr-tracker-bot@kernel.org>
Date: Thu, 24 Sep 2026 17:59:26 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Sep 2026 18:19:52 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/415f2044228cc8b948dc04e079aaa86a4d1aa1d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

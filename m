Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14D33F5B8;
	Fri, 19 Jun 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897137; cv=none; b=mWs8X+Puta0a4Je3vxtDE+kOFNsA7L4xXXdo33++DGJYy/dqn4gheDhba+NwzNJUT+CoajbKgjFbLeBYRJOb0b0MeXPrK+HxEZWWqAp6tZJAJ+Jytg9ObWP8Ob8AAuojy3c1Awdnjt0i8m1m8gvzNkEo5qkvRgjakRNQRSujci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897137; c=relaxed/simple;
	bh=s88iTYrCeysaRAi11RQ9BAr1x7dZ5RDz12iV1w2ZDwg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B2Eg9d3abFzBIiinUcbE3xQKr5DhUHx9ufldrAw0xm+X6FnLxcId1GO05t3IF6YjUfZzi/O7Byt5b4wX/XickUlJ2JmQ2YYJQADauVvFBYVyQ0DqnPvy4cBmBDQ21sDYwtbFNv5ZsV4BDWT7wVb2Hsg9i/nik2yF7xWeuPqX2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDAJm5SL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDAJm5SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F531F000E9;
	Fri, 19 Jun 2026 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897136;
	bh=MFi5JsppPFepVZavzIdUWh2Z58kSH7+/Om5iVflS85k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HDAJm5SLe9ySb4/hnvR/GLCgTc4uymVpQYQ9HFUUTS3zM+hrnv6zXFAGjqDTHyu1z
	 JEp2slypV/QPJ3qSZdLV1PcWaiHwHVDX0D2WiYMnDGKajKFbYzeONJL6AUh53/akgH
	 FxJIX5s5a6+av0f7Y4QmMea1LTXaofodtcenv0RgFzaJq5gtS0oKQA2dMbhQP/d4TC
	 qdyHe6pCEAtGC2aZUMuv9VnYB8qcHO6yV7vPkMD3T+qVXf+hb39vUPEvkes04sPd3x
	 3WBF3FKUZWVH67/WrQ0r4SVftXW2S22s54Y6lOaD7VqQqr/UUOeU4rp2QqmBF+kKGL
	 FwcLcDk47md9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B453AAA0F6;
	Fri, 19 Jun 2026 19:25:30 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260619083504.1779997-1-mic@digikod.net>
References: <20260619083504.1779997-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260619083504.1779997-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.2-rc1
X-PR-Tracked-Commit-Id: 1c236e7fe740a009ad8dd40a5ee0602ec402fffe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e2e14749c3d969e263a879db104db6e9f0eb484
Message-Id: <178189712925.4037507.3496686316473575263.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 19:25:29 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Justin Suess <utilityemal77@gmail.com>, Matthieu Buffet <matthieu@buffet.re>, Maximilian Heyne <mheyne@amazon.de>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jun 2026 10:35:04 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e2e14749c3d969e263a879db104db6e9f0eb484

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

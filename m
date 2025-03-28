Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C31E3785;
	Fri, 28 Mar 2025 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194457; cv=none; b=PDMH8HawzLgcVNi1C4GcFFVbiVVP5qFevV8/GeJPOCfo/E+HH48juaXBqwsjgtgKspwWIGb8PxzkpStUy3iEpKyGWL+YBu8xDs4a4/vm7ULghuELSrSJgDfuj6g1MW6SkVzvoaPibpRiHEF/fz7LppNcIldrTsBhnW0hZVsdPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194457; c=relaxed/simple;
	bh=BWzX16lVY0aV2ueFOvKCsgdq/ygVT5xIzyPQTLYg+AE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0/bWAxfz0E/6L6T0iLhWw4BE1VZ8REpA4Ka0e0F/RCgTgDu1BtCUo8FC1foFyR6xEErAla2Iy4aEaQmD+xIYFEh7N4fXPWUNIbnrH0kZricqruFqsNpqiNkDmmcaiIQl35XswDQr+GjubxwyAdCsjPdWygy6OyFaHRyi66uaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGu42F6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGu42F6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A215C4CEE4;
	Fri, 28 Mar 2025 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743194457;
	bh=BWzX16lVY0aV2ueFOvKCsgdq/ygVT5xIzyPQTLYg+AE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jGu42F6mxfHSrm7090Imzq14hUs9dREOO2CwTZrFcLyCcY6X5NIMCiA/gw0wA7J3Q
	 77uq2g5t8GkrNFs1xvIzOrkj2j0u9La8yt/OrGvmSp/gLtcy4xxGiPqK4+tkElOD3m
	 y1BIeLjqDYYTddgskwj3gLhhQ/6Gl23yxkqel/eiv16jpMuYq6mY+rjOFjrseHj6Z4
	 H9tEvFP7eceQUpxInlQ7HGpwUO2nU/sABpPeLR/2TuxrTZkkSpcJhRTyoyaJ0hYxto
	 VQzQLkj/bWlSHGWhD66+EjijCYhIX/ZQmmcly1TXdgjPWAUWZt6oo3dIl/U0bGndHA
	 99mdfzbMoLhjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD6A3805D89;
	Fri, 28 Mar 2025 20:41:34 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328162610.621810-1-mic@digikod.net>
References: <20250328162610.621810-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328162610.621810-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc1
X-PR-Tracked-Commit-Id: 8e2dd47b10e77452733eae23cc83078fa29c1e9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72885116069abdd05c245707c3989fc605632970
Message-Id: <174319449347.2953471.14603509781359770846.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 20:41:33 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Charles Zaffery <czaffery@roblox.com>, Christian Brauner <brauner@kernel.org>, Daniel Burgener <dburgener@linux.microsoft.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Tahera Fahimi <fahimitahera@gmail.com>, Tingmao Wang <m@maowtm.org>, Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 17:26:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72885116069abdd05c245707c3989fc605632970

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

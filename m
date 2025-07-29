Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763B202976;
	Tue, 29 Jul 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755859; cv=none; b=gEn2+J05Zgrx2X8EsxykNrKnsnzM/aWud+GP38vNvUcQ+RS5+beuQ8X9p6+UJdchqXGCJFfF4vqCr1ZZP827a+kD7WW4i0XgpNGjrWDJZf6LpQ8rBvUkmsIhPWCjwiWzT/JddUcFpCjp1IijdmMi9bZEufsWkvhBmHqYc3/+1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755859; c=relaxed/simple;
	bh=uhPFXjGwvJq7GuaHtjcvPT+EQlr6V+fAI8IS0F59pgs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qmxXcyPeJ/EBpXV5609y09eb6muC89uqoPXErWke39F/FiqNYfDKwk6jfQqzbasx/kHxN4/wYmo9nm+FNocEeK4NW7A5mJwAPrfdWJlCQicX2IohcKobwZzWI1ZDeKvznfhk+iMz/chx8M6Y6yzC2nJxbka4Xgx0UMio6LRz+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQJVFX+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQJVFX+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3599DC4CEE7;
	Tue, 29 Jul 2025 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753755859;
	bh=uhPFXjGwvJq7GuaHtjcvPT+EQlr6V+fAI8IS0F59pgs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cQJVFX+5kK9R5xVNtU3SsP/f489a2xYM9Amm3d91Sk7joE+/h2hiGHWQ9aR6FrUV0
	 tdgpsLepZcpFNGdzOc89nh5MfA3qScR3UaLthIcBZTcrw+Mv9eFa/TGWdc50G3ST4c
	 DJI0V0ODbDV0/gpf8l1pksT3ZCq3oQMZKjs5ISPKvmOvE8ChBeC28NgRlZ0jfe/ytn
	 vaFjl+7jPMkdd5pfh6KwlEaRKDZQ28aas0YOpbwf8FWyg3I0TQz3l+m/B9MphqDyBC
	 JQe6y9kfXL+GXO6O2GMJjdyPWC6fSP65JHN/X5jiLjoCVEx11P/OifG1GwwrHxyRvw
	 iVogxOMYTlDPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF21383BF5F;
	Tue, 29 Jul 2025 02:24:36 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725095511.446960-1-mic@digikod.net>
References: <20250725095511.446960-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725095511.446960-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.17-rc1
X-PR-Tracked-Commit-Id: 6803b6ebb8164c1d306600f8836a39b6fceffeec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae388edd4a8f0226f3ef7b102c34f78220756c3d
Message-Id: <175375587555.935612.7876394236170920954.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 02:24:35 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Brahmajit Das <listout@listout.xyz>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Song Liu <song@kernel.org>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 11:55:11 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae388edd4a8f0226f3ef7b102c34f78220756c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

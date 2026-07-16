Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E33128B6;
	Thu, 16 Jul 2026 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784233578; cv=none; b=a53G1TRzvDuauGZd0IrjHLp293JbcomTzcDzr5lBzJli/te6ALIh7P5Ywev8TQsZIhNDjRjxZ/xHAEzeGGBLeFKSM6ui7K+WmQVv0TXByE9Hg58A0yxTDI8qwyNgZy2vgEAwOjOkg5DG7LTpYDTK+cIXVaeph0iY3RMwqUvjs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784233578; c=relaxed/simple;
	bh=azfgF8fpj3r3bvm5iDq6sRJeEKoL/aKpKtrNRBVMbWk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=akTQ1dCoi9XkIrSOp/HPPbs0FPBEe0oa9UNZOTgiuu5wWib8LwDh6d13b3QYE+HSjIRCEvZs0YH9b2uYY4DGYe+VALueXJPXylQd12xps+T3HJ/UJhldw/pQxzLjSP/Iz8RliZtESUnFYvuzneyBMZ/QFq0fd3rpk3/AbM/I7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8j3u+Wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8j3u+Wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5DE1F000E9;
	Thu, 16 Jul 2026 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784233577;
	bh=+dS5ZgjXojWEtB0LSMyOf34OO8JYlZj3J+C8HgCfhh0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=a8j3u+WdwSYueKB53mUQWN82XvAwK6TEnYj+3m+4elNv/PnEhstCQqk8Pj3Bm1sZ0
	 SK6N508Lc6NlZa+evr1fmm+xO86ucRRt7mF9m1yaBysIufcCqv2l/Q+5EsQDilgx6a
	 m6FWKUGijSXjL3oD6nltvjIdPrjtfNJKcSCjmr7D4+WAEmFWCi5ywAYP0qggid35hM
	 8x3j4u+MmG3uldXV2gW3lGdX9v7Jq0KPIT9VJ6P+f43q+b3V62Ep//fErd4FsvB4wJ
	 CIiLPJuy4JG6lsKRyAOCXacA43PdMC0DcmEysou+qNtQFqfghwHSMTJS98nv5AqQ1x
	 xNKZ8KVhPKcOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56D95380A95A;
	Thu, 16 Jul 2026 20:25:51 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260716195752.2326332-1-mic@digikod.net>
References: <20260716195752.2326332-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260716195752.2326332-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.2-rc4
X-PR-Tracked-Commit-Id: 5ab1dc6d110db6bee167a32fd94c53ea0e7ad6d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 481ed5dd3ed7136f627b8ec372ba39f5b2e7d27f
Message-Id: <178423354994.1409666.16491314888156899314.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jul 2026 20:25:49 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthieu Buffet <matthieu@buffet.re>, Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jul 2026 21:57:52 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/481ed5dd3ed7136f627b8ec372ba39f5b2e7d27f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

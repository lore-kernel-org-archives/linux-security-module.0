Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793424091;
	b=ak7HpP3Ic24Tu3tLGiZf5h364p3UoKHkspXAom4UOHTeGthieFHtmhCKf2kPLvGG1BiT
	 7Fswj8sijSdeX1IoUF18cLLv3hZY1GGwYCgWDe+yDXWrq8OUsbjGnxUZUKtsTARjc9iYK
	 ytxyfx5pVc9UwT9n0xvb20KHUNk4LVqSmDo8uwX76bFN6xp5SkAMTq69/MaLrZQQYQpGF
	 Wjru3Q+lwOKiFt24SSAV9TU2w7yyKisQ5O0M5k8LO6pQCBc8yHJebyxNsfAGt+786ZjbO
	 sRNPKpRFpPQM2ozC0RtptprqSMTBcdka/zp8uBZXcr+Nn+3TLKXug931uEpw/rdpP7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424091;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=P+8vvVVt/SrEKdOymHQWCVEHjlCKQV+GBgTPtVcUZoY=;
	b=yzeJahYULEzN8/iO9HdglorpixQ8vJiWf8axha0DBs0K5fhxjKshcPB71P/1p6eciSQH
	 ZUDv8rnpI6Fo+tWr7KFsgNgYd2whBBClq0Deav3VBoiCVYwiIZGz9ULroUhPuqb5SOGjh
	 Z31ck650RHm4R7J5Jd+byd7kOcE/jAr0ahYsyVZlV+EThq3beBOaOKiiNz1d1+UP0SGMw
	 GlI7zeCBWTFdvYBRBBUH3stxOQdM4K+ZVnaCwWTuL/v0VkXz8JLquZPrNMpHeGw8jGn1Q
	 /Y4MYi10VJMmzCMMEJfD2wJRT7cTcW2F1mNX4oTuhnnleIjVKbJcO6gF5Vg/CIrQwbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmVvhcjx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4E606A31D;
	Sat, 31 Oct 2026 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmVvhcjx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3DD1F00A02;
	Sat, 31 Oct 2026 05:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793424090;
	bh=P+8vvVVt/SrEKdOymHQWCVEHjlCKQV+GBgTPtVcUZoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZmVvhcjxXfoVUL5WynqefI7AgQW7NVbSeP1qMht1nbgxI8tpxsUO3ZuZeuIBkqW4T
	 VTG5u0vx1xGkDOvwpETm7biCZ5VISEr1UN4L1kVtRR3Q55S86X+g7cgcJcyS5hOA37
	 YlPJr5mF84PGDg2AesCNQYDFjFkjNxRK/WRh7UZG9a0BvqrBCFgkq8zGmJ7NkSqQ4V
	 jelV7+DXmYPm+ftF4oW016uayOOH0BxnMbe4Jn7WqLkZWKFI3rLOo6EoOKQD5olvE7
	 nSX9m3HHXevvOd4AQmosv02a4at7aMlsrvJIoXDChkkXDM0sMcMFHRqOSYPXQjAgq4
	 P5N9K4A8GJi4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF805380047D;
	Sat, 31 Oct 2026 05:21:30 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor bugfixes for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ca16996b-2917-4869-8e22-e6731804e4e6@canonical.com>
References: <ca16996b-2917-4869-8e22-e6731804e4e6@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <ca16996b-2917-4869-8e22-e6731804e4e6@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-10-29
X-PR-Tracked-Commit-Id: ed35bbe7d06e6505401eff3f3c7a36bd1f167a17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60aba79a50127e92d8c4a663d35b855e52a9da01
Message-Id: <179342408918.1961943.8874862562044379333.pr-tracker-bot@kernel.org>
Date: Sat, 31 Oct 2026 05:21:29 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 09:46:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60aba79a50127e92d8c4a663d35b855e52a9da01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

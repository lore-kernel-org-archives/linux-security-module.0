Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171215FA72;
	Mon, 16 Sep 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509444; cv=none; b=ohEc3Z9AZDyRSz50EAsd62FZq3esUovY6Mja2x23P0VeIimc/ywM5Jx2LQ0A3f40eKaD5N6FpDCM2XSa9SsYN8nozcvzVlPV86lTCf2sN5AXMSXJCvl5LGZZnN1z1SoyFnM1rObOxWUjc6uBbY2n595kNGwNXytUUj/e1RnIbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509444; c=relaxed/simple;
	bh=jYON1/Uh1dpund13lEKuBwplR8H3orb9C6v8NDM/FTw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X9oQ3jcbX8YNdb0MEvSncHHk1E0/jtGtmvuv3S3+s89XLBGJM8+GRlguHOMnjL/NwgPdTTXnT3kDftQtNg9wIqQYCWv775W9P8HQdFEfqcUEslAV7HpBEA48zNSnahD4MClPeAWFLf2yElaW/Z/yl+mJbpEgSfNJWytPDlLnUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRA8QIgk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRA8QIgk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35DEC4CEC4;
	Mon, 16 Sep 2024 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726509443;
	bh=jYON1/Uh1dpund13lEKuBwplR8H3orb9C6v8NDM/FTw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uRA8QIgkGcVMHiGidybehuFxTgLfz33DffO1EVgLZoelxubzdaYXYfHt4govEwlI5
	 oneNaY7J2nEsd6AacWGLnA+luHKvftEyNeRy3/5GGW1FcGW62Xh5YdQBSk8mB1vMei
	 FCMu4WRjC56KAXAlS55keWeCDe+qBvQU67iHNhyuU2koTq8vKgJqJKg4so7nCHr03w
	 av+py/DJOYCYgOhuhpUdhW4t/nk+jS6lSLQvhto5g+Oo6nP88Lg63XqmRRF3ZwyXSO
	 DisbLa/hb96KfC9YxwEiAyQQfl8EZk58vsKgr/BGCOP6Lmn5TJHUqVTnLRGjzBn/BC
	 hztSnGf5hNrrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7120A3806644;
	Mon, 16 Sep 2024 17:57:26 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
From: pr-tracker-bot@kernel.org
In-Reply-To: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240911
X-PR-Tracked-Commit-Id: 19c9d55d72a9040cf9dc8de62633e6217381106b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a430d95c5efa2b545d26a094eb5f624e36732af0
Message-Id: <172650944503.3778821.5013640579473720817.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 17:57:25 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 21:29:54 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240911

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a430d95c5efa2b545d26a094eb5f624e36732af0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

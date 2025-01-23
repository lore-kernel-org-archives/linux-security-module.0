Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206E1A8F99;
	Thu, 23 Jan 2025 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737607744; cv=none; b=OfXOtcnKOtbgIJHtYjYvzoum/IrVafXSlWqG8pN1pXARY8DgqQr5v58N26yQphP3U3obpLlVjQslrS/IE+TnpMDaekCjftuNFcHtL7QpU5pnJY+nTkmiKdhyy+kqj7Ozi2/oqJsRQirftdqRKPdY9x8fO4sYsTlyq+dGV1hAZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737607744; c=relaxed/simple;
	bh=zHfmt1P8lLw0/mar5H/w1IE3A0DqP+pRPK5FTqXxom8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t+RZYmAfO1QaLOa7Jw0hbObfeanSNxZpWa2fx4tzuNgyLe3pL+er+rRxfL4jlVHuzIZ5Mwc+lPvjWePPAmKJQQcaOMlRWV4V8U2XzFoIluIct3t1kirgAfiQZCq4hoeEQsN4KGq1VM+hfIR8H26EYb2u1rP/0tRriACIGr3Ye2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrAY5VSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrAY5VSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56B2C4CED3;
	Thu, 23 Jan 2025 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737607743;
	bh=zHfmt1P8lLw0/mar5H/w1IE3A0DqP+pRPK5FTqXxom8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hrAY5VSSnZSr109ZIdDrGuiSUbHW3CFRwwhi0uhsmu9iv7NMHfm53gvtNsBrUYX5j
	 n1mTe8QqOgjUNXgK9oBs35D3UpN4djj4RNiOdcFIq08GZ4Sjvsd6tbEcspFRTUgp7O
	 cDcDS2LegT0wuyGFM+uOTdspKdIyiATdRD7L+wyS69jf/7e5rM9HKwRNJNPGhqz2yF
	 BhHRpUkmee+BtTpySm+D2naxq6LHZHn0+YmedyJf1D9/Q4wPnZJGaBJVjWqtNp2gaY
	 aIopwlaFm6RTX1IEeCtS2V3tlIecUBKPHYp2WjGW/QbIJ7vRngzYBNoyVr7V3ECDh/
	 WYYYXakvSwkyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC59380AA70;
	Thu, 23 Jan 2025 04:49:29 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250122165626.331786-1-mic@digikod.net>
References: <20250122165626.331786-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250122165626.331786-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.14-rc1
X-PR-Tracked-Commit-Id: 2a794ee613617b5d8fd978b7ef08d64aa07ff2e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de5817bbfb569f22406970f81360ac3f694ba6e8
Message-Id: <173760776842.924577.7460232107172862732.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 04:49:28 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ba Jing <bajing@cmss.chinamobile.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Shervin Oloumi <enlightened@chromium.org>, Zichen Xie <zichenxie0106@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Jan 2025 17:56:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de5817bbfb569f22406970f81360ac3f694ba6e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

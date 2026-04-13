Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5A2AE8D;
	Mon, 13 Apr 2026 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120506; cv=none; b=feiz8V192R0UsCJ1TpY0+InO426E/FIzQQi4ZSuWqflSI89J0uqGrwmgPOFJkN+uXQvO8gf0UbjcOswoq17vvXhaHLXAkXw1mOvNmlFUo01xwXbcgtNLUI3tPlqa4q3RpgluLU5euM2g7SS3q+NmTlDw7v6QONJWGu0TXryaSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120506; c=relaxed/simple;
	bh=DcBGNC9/Nvai5gniNfESxiXdC2fi2tdCBENAr4VWCVo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kh6bmZPCOtvts5juv3FplXL0e9TpdXieaPCM+yA5Fz1xWxEy7ogTX3ov3Y/7r5K3uB4UI6VH2oTOX7YdWTGMeAO2Am0BdyonBa34QWOi80dLdE74JaaL4G1R50ChT7oO2icqTAV5ABxeDRvfuhVp9dBmlL4V/OYp2BDFMdbExeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2tjCRRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2tjCRRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9284CC2BCAF;
	Mon, 13 Apr 2026 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776120506;
	bh=DcBGNC9/Nvai5gniNfESxiXdC2fi2tdCBENAr4VWCVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J2tjCRRbzf7qnt4mo1DBpYwTsIdOxBi/w8+u0YDeNXtplwiaLSlhSSG2ybvYVgIkO
	 fDGOVhtFdKdtkVyi2pYfMVMp4jr9jxk9hDHXLONApddxiGBu98UzxZx1beb6wcMel7
	 pwd6dFCmzeUl7Oo6vzohbkF/WSzlGvx9nVyOiT2EcKq7VOErsmV9Ak3z0Vk2FNjWnm
	 xXmhW9V3fehKqZpN2lDl0vRPbnuqwGq74NrtO8Z8ZMrEvtraLGqTaPXZrsmFEZcjz1
	 t6jy3mu1DkhWKsZ/hv9M02enCrH4tceN4h9dhCq0r6dzluNqtT4cuT9K3PbtayCRHq
	 OKQOdVSl2I9mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EAB3809A0B;
	Mon, 13 Apr 2026 22:47:59 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260409173124.2478023-1-mic@digikod.net>
References: <20260409173124.2478023-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260409173124.2478023-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.1-rc1
X-PR-Tracked-Commit-Id: 3457a5ccacd34fdd5ebd3a4745e721b5a1239690
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8f82cb0d84d00c04cdbdce42f67df71b8507e8b
Message-Id: <177612047761.584243.10645191496627488663.pr-tracker-bot@kernel.org>
Date: Mon, 13 Apr 2026 22:47:57 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Georgia Garcia <georgia.garcia@canonical.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jann Horn <jannh@google.com>, Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Apr 2026 19:31:24 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8f82cb0d84d00c04cdbdce42f67df71b8507e8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

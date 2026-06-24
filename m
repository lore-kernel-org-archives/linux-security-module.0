Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3AD29E0E5;
	Wed, 24 Jun 2026 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339477; cv=none; b=ZpJDmK6afYtmzeKzIwOd5x54zrJWkhBXTB7sk69MlIl4xT3ckpLuFaTKZC7C6nH+4xflFzbuzB74OzmaIUubbIFsJmV+DDTtd+/Q0TWntK92YyW0XJRQXbQq4WCMAS2RdPZnczm5uXj44SEF5gPAsjHVCBBrFwERyd/auY31oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339477; c=relaxed/simple;
	bh=pGfuyrOqOCsPUWP9qTSF+DBxW4qTMeV6pFZDRCDdb0U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JyGfp2MXGMyn8lIkioUMHRr3EBw5iy+zstplqREHMS0JRFQNq/ouS5roilbcPnm35LEZ3yGVEMsc1zqh3Lqki7Z4s4/ny8y7R+uombXYBG/MMB7C4c6XMxZlpMTEFSSbwludcPK9CEQflYTuuSR6/UbYBEAHsc4Eg5nb+G5BHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaOvY/Ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaOvY/Ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC47E1F000E9;
	Wed, 24 Jun 2026 22:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339475;
	bh=VSnq+eVRxBGF8ZCaTZntOpDEPveO8D1NQ/X8C/UhVSQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RaOvY/JiS8jphWfFiHfK9e8PSglOvFyhJfIt8OJXs9KM75WR9iF9YYU97SzTOA934
	 DilqE9r00zwrBRieogF7jMf5kRBn6zkRhON6gis8ZVLg/Kzd9xLmuROPuUV+6jfFWi
	 nVeC9Dd4n53IYCsaTESHH5JQc1idNpU+ZqQAoB5gZereCjXbFdOGYYB0oPWbrhHMEN
	 XLW130rTAV0FQEX3YWqZeA39u65VSWZh4R1xBpodL2gqIa1M4up1LNXeihplMfi2t5
	 kzR8U+aThjn2DRHTE0iquSwZKVotTPZTpCy707O+0nKn23/ao3ZKseLw90i/eIerYh
	 GJ0XmI6h5fWZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569103AA6A7A;
	Wed, 24 Jun 2026 22:17:45 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <bdb6dcf3-a0c0-45ee-be64-d135c973ec90@canonical.com>
References: <bdb6dcf3-a0c0-45ee-be64-d135c973ec90@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bdb6dcf3-a0c0-45ee-be64-d135c973ec90@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-06-22
X-PR-Tracked-Commit-Id: 2f6701a5ce6257ae7a64ddc6d89d0a08d2a034f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6535a84bfdc4ab56fc901cbd9bd0d1a22315aa93
Message-Id: <178233946397.3002918.1827393258923618213.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jun 2026 22:17:43 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, Georgia Garcia <georgia.garcia@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jun 2026 00:52:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-06-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6535a84bfdc4ab56fc901cbd9bd0d1a22315aa93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

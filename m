Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B362882DE;
	Wed, 28 May 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446841; cv=none; b=kNjNHHkd2jFC/VdClXwkZ2M/jR3gG/53jR0kKVcwA0uhcvHT6oQD7A5IS4TwAmbOeyIO95/CZAcv27IYqosxBxi3wZ17rAtc6wVfey0z2wdNKRCcbpa9dxOTxKiMugPLVcJyVtXQ11RgnyQARzwnJtbTZegdPh/zQ0AN1bZT2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446841; c=relaxed/simple;
	bh=vlBt1KD9NwWETsMzSvz1zvfNTgKES4Z0JT9UcZtH9Q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MN9EMDWyXdEwnBdNN7QLda8Wzxl9KBT+4kL3M/aotS0N7N2qnUOuMEDCBOyudKI7tkGVNvSShJsJC2lrGLqe2BlwYXBN95otrxbaoL+NeiPcJIIj1Amf41WW52tD01ccwHLhf3pN1uyj6tiK1SfwTL0DYF6+mf/zPYAPvm2uJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6d+xQi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6d+xQi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5256DC4CEE3;
	Wed, 28 May 2025 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446841;
	bh=vlBt1KD9NwWETsMzSvz1zvfNTgKES4Z0JT9UcZtH9Q8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q6d+xQi82nfmTENTD0pQwccw2RuemXrZI05j66sowEjhVyjxuFH+sGVREMsNRHg6x
	 OljfDQyFIlOgtVrB5Bcg3egvr+rt2vE50IqiC0bRWFvzsvEZo7fPaI9W5At0OgXfFX
	 Bc0Ps0naF8904aUin+AsvT9K/2/Iqp+yRsVBLifhsV2mUuH+THXnxVc2bhKJfc0YIY
	 K2DIoy+adhCPCkfbNcb/uruHQyrr3lBm/a7FAvsJNYTT8AhG7D60XD9pHee2R+0W7Y
	 OAV6uVyiZViTypMvzVtplbLT8EOdk2OrG6e/5UHgaysNQdRfutXAoXKTzqvpSkryIP
	 +F1qVVAlFAqEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 749013822D1A;
	Wed, 28 May 2025 15:41:16 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <c342db55-57ec-484c-b030-ef3dab89bd3a@schaufler-ca.com>
References: <c342db55-57ec-484c-b030-ef3dab89bd3a.ref@schaufler-ca.com> <c342db55-57ec-484c-b030-ef3dab89bd3a@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <c342db55-57ec-484c-b030-ef3dab89bd3a@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.16
X-PR-Tracked-Commit-Id: 4b59f4fd0a36c31876344d7e0cfdcb0202d09cf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbaed2f58c55c13f96250359478bd8fff3ac4c6e
Message-Id: <174844687548.2439471.18068467317063772808.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 15:41:15 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 14:11:38 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbaed2f58c55c13f96250359478bd8fff3ac4c6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

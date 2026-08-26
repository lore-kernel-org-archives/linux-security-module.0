Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDE3A9DB1;
	Wed, 26 Aug 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769680; cv=none; b=oL5HdkhK/4Za3vMBQJVdCxxEhpDH+y7sd/KeXf7iplp4Nb/wQaYKsFHgeirnZt0jQnq6hW6OtfBwrJgqDaLiGdgSK74UBAj6s/ybm5XFXGTu6+e6i8IIDqmglaWhbDHH5fjL1U+rH1OIlZZBhHLM7CETe6RMpvghenahd0oNkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769680; c=relaxed/simple;
	bh=fnFkZmOUXZmvA/avzB1ARefs3H3EJinlqVvD4QkuUms=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KoX7Y4PLFIjZaWijepxbQEulweAdSzsgkb5ifb5wa6utau2U7X6vsQTVoi4YjpVy0vaBCqelTl8waNc65jwvPf6c5dXmGhh7RhBjDwcDD1/uPSicSwCvplZfwk99RMlxZoaR5UhoBev04kjGogyF5G2x4zVrkWNWFYJU73xqSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkXQhMdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkXQhMdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1951F000E9;
	Wed, 26 Aug 2026 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769661;
	bh=DmJT6UP9PdLA4FeMbkz9njkQ/iXWIl5r+OwFPNjta5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DkXQhMdX5YdXQPiXQSKm9wfdque2zl9T4V7Z4csPKjohaKWCPik+qbAU+wjx66/56
	 jzdwLz9plxXCrtE509fbvNboYl0pEqB2ThtQn8PH2qClixaZd5xCIqs91EGLr9FXfe
	 med6kRfpTRBIj/XR2YrrxE5t1C+dKUQHOfs3ZRhHHGI8XCrzdqDDIcZ7XWe5DwxsV7
	 6+w8u1MPQayw4cx9UctGE2ItHgzsyx+e9fv70Ldkm9hnXzIl21fyzFA9jwixWNJIe0
	 VCl0Teo2FidZ5O4IthWtkeAEPGY0tT9B07WFNorao2krpRCYHHDaiTWfbY8AqyJhmK
	 KFA57yUf/9tEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A49380820D;
	Wed, 26 Aug 2026 18:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <997f83d3-18ef-4ca6-a1d6-39491b7a4c95@canonical.com>
References: <997f83d3-18ef-4ca6-a1d6-39491b7a4c95@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <997f83d3-18ef-4ca6-a1d6-39491b7a4c95@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-08-26
X-PR-Tracked-Commit-Id: 3daad923a8685adb66087e0d819559b7eb6ba975
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fefe68784ae1606e11a5c65c04167c3b95051a0
Message-Id: <178776960692.801398.17068737687399820232.pr-tracker-bot@kernel.org>
Date: Wed, 26 Aug 2026 18:40:06 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Aug 2026 08:58:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-08-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fefe68784ae1606e11a5c65c04167c3b95051a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

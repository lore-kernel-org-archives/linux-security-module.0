Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAA15350D;
	Sat,  1 Jun 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717259901; cv=none; b=oa5B0tqf4MIiHZWCZrQtuXCF1PxrcFNRL8Su0ednKKGDAJTQIHMclPXvNj05/EE7vQUL41AOPQHypPZK6ut1DPgEcG1V71ncn4enSV1L7ek8wXsuQ5ZAuHWLxHFFvu0GcMgpoe0JH1HQr8DrHtjugXOKdwIXOrzMgXOq6ejr0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717259901; c=relaxed/simple;
	bh=s5F/qzsB9xNCCkBoBXgxcrFvtSBQbMzH0gcW9HaNWcU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YB94JXDQnDjJ5ziE0g3rgtMQZu1l/Yg9KEGkKwbv8nG4Z6JmS9gj/IEy3cHpu7qPwAnCL3A3Kq+ELHNwF+FDXieXP92pDcXQG+Nhhk4XKQP2dlhnS//+uL4WQsuq8Zxe9Xj9nHOV1rIcHv/wtlpFhVM404myvyQoZGKU8R+qyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCJaWV7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCJaWV7K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFB0AC116B1;
	Sat,  1 Jun 2024 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717259901;
	bh=s5F/qzsB9xNCCkBoBXgxcrFvtSBQbMzH0gcW9HaNWcU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pCJaWV7KCcZr+uTh9aknvru12ZusunYT0S7eYO/6U5VaQyTEViHIch3p9MMhL/cXK
	 RKubJ0r7mvuK6tw28FHEbHWnwGqoNJ8VIBGw91xaOE49flLPx812KsbAK1+e82e0Jz
	 FMIWoV8mv7T0B6d2l08d5sBBzyRK+wxMIKoEzAq16cuZxnsMYpGkmNQm+Zc32Nq8qc
	 2GiEu/LP7Oy+Mw4YKliV7jJ14rzuo0Mz3YFL+jR/aXS3bLLVSthw4gj9JkZoLyIorn
	 aX8mY718ph9auklMHUwy4tTHYEx7Mv1Q05c+BysIhSurB0paVYatl08a60dSQMLRVm
	 kg11ew/cQnbsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5D04C4361B;
	Sat,  1 Jun 2024 16:38:20 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240531154034.198316-1-mic@digikod.net>
References: <20240531154034.198316-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240531154034.198316-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc2
X-PR-Tracked-Commit-Id: 0055f53aac80fd938bf7cdfad7ad414ca6c0e198
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9aab0b1c9b2838b2c91431a5d4ac4129553797d
Message-Id: <171725990093.19745.13168967010564819859.pr-tracker-bot@kernel.org>
Date: Sat, 01 Jun 2024 16:38:20 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 17:40:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9aab0b1c9b2838b2c91431a5d4ac4129553797d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA7302779;
	Sat,  6 Dec 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048019; cv=none; b=Gc5bPnb96WEaGPTzhUY8HcKHyIPIqvdJ8tAjqlec/a3+SKXTfCyvKCiQ+C3nbIwnZLQKvQywnn1dFNrI7jA7yCH2b0IF9v/7lGeDgnkO1Zo0ZEwGfXYN0wZRIktvTxMrX2oSlluTPvBTGeA+ysMsEIZnJXY8Y8H0EHmQ1s49u58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048019; c=relaxed/simple;
	bh=XYtDRDRG3hL3W1nSkZ3T2tyXmow03Do666YMb6f1ocI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TZsNswDlM39umJBZhD2Uibf1mkMLZG1rMVRd0SyvxmWWI0DF0Q8icfmSQGi8zVtkWOg0/nluCczDOQ4YGtEyJAbS3zh4OM6wL7+xw3WqZXYyqMDWPQOwga7cKE1ClTruT7l77sJd006geu0kmhCsNwyyewNsbDoO5Rd4Wr08rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr7OP7BX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr7OP7BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B32C4CEF5;
	Sat,  6 Dec 2025 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765048018;
	bh=XYtDRDRG3hL3W1nSkZ3T2tyXmow03Do666YMb6f1ocI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dr7OP7BXuHZpmpkuhVGr67fZHcxIsCKXPz4cTC4y/jYQ4ZVd67g/O9IaKj0CZ9Gb7
	 y7fVaPVFxVnUWceqnVJPQpJmlDFtb61sBIGh3w30TaTg9gTPxXwzP1r21sgRTpYaS0
	 xarB151duwr9dgVE+o1GcAog4lMKEuq9SgcT0Mo1skdtaJRfCR9ivtLoNkEaXHGPSF
	 iF0l74Z+MjUABhZnqn/mVEfDszdsh2JErOs9fkKb9hlPLJF0Un1GihLal7gsgRoat7
	 zbdCO+oJaTNDI1BKeBr6smlUDq54CKO4LKyUtWw0sQbq4htyNda4udIattvTiCSlN2
	 5Iz2hTxLUipIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78BC03808200;
	Sat,  6 Dec 2025 19:03:56 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251205183825.737361-1-mic@digikod.net>
References: <20251205183825.737361-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251205183825.737361-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.19-rc1
X-PR-Tracked-Commit-Id: 54f9baf537b0a091adad860ec92e3e18e0a0754c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eee654ca9a55fd1e8632afb119975cba6af7d4ad
Message-Id: <176504783504.2170003.12647604554843400379.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 19:03:55 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, Song Liu <song@kernel.org>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Dec 2025 19:38:25 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eee654ca9a55fd1e8632afb119975cba6af7d4ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176421A4AD;
	Tue, 12 Nov 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447508; cv=none; b=dzwyuc4cTiURUpdlWn0CCOUORITiaB42AxKjSr4JKuaJpPvzvt8FtTVpNoqYTgdIBv1A9odOdvd+2kc2OoGV83uD2zOEm4+a7SPD/ihVNIuGd3pUdbw++mn5nuYi7JVXzD93D2S0btjRhxcyiDS7qvNOPG5vurtbcvqDHnX6R50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447508; c=relaxed/simple;
	bh=gEN8uXETejN0E4QO3cZhAuE7L6ECcR/9dXB6mbXEnzU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hYdGR8GbgWQ6mUYG/C8Dtv6dUaFslN9k0Y9qI5B0YUf+RTVV0m7ccnrDpTJQ/B0QRT0waJj/JDY4u8FmkCvqDDf5gHiNQ3Q+0FncKP1V9pnvEzFLK09BkaWq+OTx2BWLOGIQ/FipJ1cWvKgNBkzY7xD5lYJ9ZCSJORh0s1Bpc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgWIf6nu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgWIf6nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D0FC4CECD;
	Tue, 12 Nov 2024 21:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731447507;
	bh=gEN8uXETejN0E4QO3cZhAuE7L6ECcR/9dXB6mbXEnzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UgWIf6nuv8LYbGT5QxugQAtyvXcjPGcD02dtwO+emTcU1sQpuv5kf8bf4vY9Uj+xn
	 MKfVy6eGD8zKa0it1NXlziv5CjIvsN3uksncddBEaE3BdrZWzDKVTAe/dYlJ/UrkVH
	 omqTY/+G6Uh68tpKkdn0MsAOZO0bCW/t+kWStIsU8wNaDsqAwqIEduzJanoAbcl9As
	 dwWphg6PSr3iJE3BF4kY5zryVBLGY1r/GcGq9JSn/3g4Hc3VcC9AZmBFXZ5+lFZPDt
	 I0OW5FdvWlfxsH53dIcpDkcE4EDYNFH8fY7S8bUYIrmcHQUI1oFmzwrpI29W73qjkJ
	 Dzb9M0IH3Q+QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34BE73809A80;
	Tue, 12 Nov 2024 21:38:39 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241109194158.422529-1-mic@digikod.net>
References: <20241109194158.422529-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241109194158.422529-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc7
X-PR-Tracked-Commit-Id: 03197e40a22c2641a1f9d1744418cd29f4954b83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92dda329e337b7ab9cb63f4563dd7a21d001e47c
Message-Id: <173144751773.678506.5852131497022270582.pr-tracker-bot@kernel.org>
Date: Tue, 12 Nov 2024 21:38:37 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Daniel Burgener <dburgener@linux.microsoft.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  9 Nov 2024 20:41:58 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92dda329e337b7ab9cb63f4563dd7a21d001e47c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

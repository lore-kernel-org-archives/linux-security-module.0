Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175D3B1BD;
	Thu, 12 Feb 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854656; cv=none; b=Qw8AzMoOPa5UQqHAGA1CrPf/g0tly1jLXdne2heTxIJclcCv7PoycWpUWIMox7lzUO3OInddyUdnCOJz8URhNc9JEaHRyxqANzEReQD81GJQRfA4Dp0GiYLZ0IeokekdoXwYI8vhH6CzTVVXu+op6Xs+wmto3rc8+SGKlV9u++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854656; c=relaxed/simple;
	bh=1jVwTLxdHjMAO1QsujSV5LpmcaYSAG8mE/iTGxCk8Zg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jbheRjKRw0HYdrXcGOnl9L+JBUHUQpXI364roL0TiaxFs5jmHGoOKutdhr/uxn+ZmltAQZ8HjuZ9EHntd/usxg2S8TStdR7YIMiQyBi1N1k7cM4aMUs7T4bRAqsUi4IbqbwORtwZPCr1TFgPWs9T52u0c6vGzpdmohggjpMy26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM3B2Rlo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM3B2Rlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9489AC4CEF7;
	Thu, 12 Feb 2026 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770854656;
	bh=1jVwTLxdHjMAO1QsujSV5LpmcaYSAG8mE/iTGxCk8Zg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZM3B2Rlo/o42keReUGD2U1jWbR9yxBavuushAMsTYhHBJ/j/ObPer2GFpHdDP1GTt
	 hAFQP3ei4BYGTHFwaMC+p8mVMXtEahnyglpSH9ML66hByIPr3ur0ZxuyJ606nLPZZj
	 Cn5jVMLjTHHdMjCvEkuomO0K1b07GTXCM0rJNMdKx+k3GrmlI8lNIKJJIBtHOUBPSx
	 PnoeDE8GalsTCmdtfB+ezM/xPD3udV1cgts+RZQ7K2gYsLMzhVcHt3OPnVSMyQ/6+V
	 CFShphTbUUkwjmitlgN+j6hRY3V8opSW4rWwp6jKqEvY0WMP8zijpzQeUXUeuYVShl
	 loJsDVZGih3fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851F939EF966;
	Thu, 12 Feb 2026 00:04:12 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260211141302.1134092-1-mic@digikod.net>
References: <20260211141302.1134092-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260211141302.1134092-1-mic@digikod.net>
X-PR-Tracked-Remote: https://lore.kernel.org/keys/20260206.waiCh9iex3ai@digikod.net/ --
X-PR-Tracked-Commit-Id: e265b330b93e3a3f9ff5256451d4f09b5f89b239
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c22e26bd0906e9c8325462993f01adb16b8ea2c0
Message-Id: <177085465109.803048.849328612799501271.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 00:04:11 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Feb 2026 15:13:02 +0100:

> https://lore.kernel.org/keys/20260206.waiCh9iex3ai@digikod.net/ --

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c22e26bd0906e9c8325462993f01adb16b8ea2c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

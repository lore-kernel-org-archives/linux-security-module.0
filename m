Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471A25D553;
	Wed, 26 Feb 2025 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606365; cv=none; b=ATLTmjMGRKbL4FORlB5k+/+lqxq0SjaLVgKROo74i8G72SBXj98DaJgy1Q+LBwE9BkIq2U2ApvwAUm3hzT1dVz6sMGXSEBJEb+QG3Kw0Fce+6TTHwwnE7bISdkt9orM/8vav4l/Vp8GAa61TzYDRpCAS2xTH8VMXMVRSe+ROMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606365; c=relaxed/simple;
	bh=naHtOxXS0sxq6E8gn1ssjXoZc+N27WDfOmZ7hW2hcb4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m3eJmEaLnCfE3IuRS0GmEHm6wWnR8nplF3+xeZMPzI6FT35cf4wgp6SLKGe5vvo0bqpxj6Urmv2rTkJetBibcotC2u1Wuu6aXbX34b65QRB//ezCuEolSusqOfRBN1UXusdaCWwK3NTS/Ev2M5cMXfiLnPq/soum7jh1PWpaMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPeK78Nl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPeK78Nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1EBC4CED6;
	Wed, 26 Feb 2025 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606365;
	bh=naHtOxXS0sxq6E8gn1ssjXoZc+N27WDfOmZ7hW2hcb4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LPeK78NlxOWpCUZnnq3abOfPfNTx13T0laBeo9TBdQQfJd1TqOj0RKJLZsNK5U4Cg
	 K04k9dfYERAoayvFs4OABfQyF7WZgt5CaTCpNiOfkc7K9lPosvBg2oEEFkrK37Sg2p
	 elpUrKfzjg63o/mk665/3DIXNtIS0JkRK62GM8RxTLO2pex6Sa+QaN165ThPlIG1iC
	 FchIY8AWyg99/GvpUJF7DGUSnFWrCD196a98LXMI6GuEAl/avUC3Eyy9/0dElJJabg
	 20ch6JNsTXQ6lq7aFetqbY0jqB8wkyMOhj6ISmDRNykj/XAG8sebsBE2m+blFN2VYB
	 gKnf5kQOB5Lvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE68380CFE5;
	Wed, 26 Feb 2025 21:46:38 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250226163229.2132331-1-mic@digikod.net>
References: <20250226163229.2132331-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250226163229.2132331-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.14-rc5
X-PR-Tracked-Commit-Id: 78332fdb956f18accfbca5993b10c5ed69f00a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0d35086a21b8d5536da5029fd76b9aeecf3217d
Message-Id: <174060639725.856033.1249940573306900482.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 21:46:37 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Bharadwaj Raju <bharadwaj.raju777@gmail.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Feb 2025 17:32:29 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0d35086a21b8d5536da5029fd76b9aeecf3217d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

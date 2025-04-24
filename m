Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24B1F1506;
	Thu, 24 Apr 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525308; cv=none; b=EAYwEtCsgOc1DfTDC9U0MWHBfvMYI7E7fqdxD+X9Pp86KgJvAVqHhcEcORQ9guzK7S9Ir3vUBreWruvG42tYTEsX3SvbQBQKtX6DwX8WNO/bpgIEKw6wCPKPQGM6alzYazjCBSHCi2Wzs/peLpe2tVTC3x9uFRMZPkSWArwwKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525308; c=relaxed/simple;
	bh=4K3kIsscvUs1FBK2+HXIZ6woR/C8WkogIkCy257rIZ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aBF2iU7nzKlbdz5v1bdQjzVoeqLqj6gXKqnKOwKZQ5znsW8Ag9jfpNcq4dOs6umcxOjd8K49rzATxnYQsMhAtQ5p09haq0SfILoxhdk3r+x5hP84qBrvsbXRs/WcuMIS+ikFdRhNrxbLSVOnUDhM2hkt0+Ml7FKIRKy4oy9K6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nofd5bdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nofd5bdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C360C4CEE3;
	Thu, 24 Apr 2025 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745525308;
	bh=4K3kIsscvUs1FBK2+HXIZ6woR/C8WkogIkCy257rIZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nofd5bdgU2uXANF5ZqaXRqzoP0mYBtoBYKwrZu1qRNKv/4PmsbGI1jqA+FmdCAfkP
	 vtMGsys1d+ofXzahzkBTpho+fgrSTOe0MH/Jvl/K7AzwnDRkffXSPUjnB9btEyFPxv
	 EsOviwKNYOWbWYQ1Apau3km6hurM+KTDYGa43wHeF5RagEUmENtTzgkZ2XlAMzk8XH
	 jbKfVJ1hK0o0bs6d36b67m97nhF1yX9SYMuUI7HgLF9/sd0FEIkvrpSOEBtFJO1Kh7
	 cSdFz9jngWb42KIp2jRY9wu9oWLi5wPd5XyBaP/rMI41ELl0nwgLiYquODI9sDR57F
	 G/5rdNwdKzEZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA1380CFD9;
	Thu, 24 Apr 2025 20:09:07 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250424190604.1007961-1-mic@digikod.net>
References: <20250424190604.1007961-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250424190604.1007961-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc4
X-PR-Tracked-Commit-Id: 47ce2af848b7301d8571f0e01a0d7c7162d51e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30e268185e59c3d5a1233416a2135cfda5630644
Message-Id: <174552534659.3476198.5187636448615049069.pr-tracker-bot@kernel.org>
Date: Thu, 24 Apr 2025 20:09:06 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Charles Zaffery <czaffery@roblox.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, Paul Moore <paul@paul-moore.com>, Robert Salvet <robert.salvet@roblox.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Apr 2025 21:06:04 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30e268185e59c3d5a1233416a2135cfda5630644

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4A3A4F31;
	Wed,  9 Sep 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979152; cv=none; b=ZJUqJMwrvChAf5ckBXas2idPaXaIHT8NsdoMToSkPaGb+mIFLVTasNarJ4uHlc4CqFUBSGsajaaQNJudG0CcqsF8Mm/2Q1S7/rEh0+uYNZ0YyULX17DZOYzN5MSZe5iY+Bq3DutyKkkhM4bw2gRt+OKZaUosfEBVpP32L23YiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979152; c=relaxed/simple;
	bh=T7uvfTf2PW3zy9Ca+j0YKt/gf+FP4miXI6gJg9+djgs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eK0XIBZOWsvOyiCTmBOpgSWC54gBpsPJ1IIfGOn7Z1S7+vGjVJfvDnz079fge6y7YneMWML4oW5rkeSPC8gK+oAOjC5aQth2S9f53nEanCMRF45Xm4np1Fs5sG9q8UPs6RjgVE23zk4ZjIHjVcoQjMC1eR4Td6f29ZyniZYplww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/E0AOxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/E0AOxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612831F0089A;
	Wed,  9 Sep 2026 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979149;
	bh=RVhUsOPNi2wR8lM4C2OCQAm83jf98XMT7z4Coh/BP4c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=b/E0AOxxaIbZlJcSrORCoshj5nVxzHy4Osf3AaUtxomJ87Ow/lXEJNb2Dlf8YNY57
	 Ss1UsIe38FuXnrtmo+UbBfO9S2YsO4VnN2ipE9OCVBRKvBCtJgCpHyexZk2ktb7Mtq
	 Wo3/rlWu+N8En0nRWysA/6cefM1bD91DzJbQ7WZMUk2wJRNGi8bt2hfE0HvwuOyK6D
	 6JndGtUH5kihGU8QUVDzdLQy2hFEfAUgimoAfJpJplKBVkRCWIMPaCRfNE4Rd1NHQ7
	 lgeFEr6nr+ahexvQG5IXkbAnAOJB8o4tjc138mQ5xTu1xWwL4oBNFP6Eb4VmUkKjsk
	 OaDpiRMcdOblw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A98380AA52;
	Wed,  9 Sep 2026 18:38:08 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260909153118.361748-1-mic@digikod.net>
References: <20260909153118.361748-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260909153118.361748-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc3
X-PR-Tracked-Commit-Id: d41d0021a6ea3e9fcd14126a00fead47f981c46e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50d05c7c76c96b90462f24debacca971d2e86713
Message-Id: <178897908717.999556.4614265468808314875.pr-tracker-bot@kernel.org>
Date: Wed, 09 Sep 2026 18:38:07 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Norbert Szetei <norbert@doyensec.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  9 Sep 2026 17:31:18 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50d05c7c76c96b90462f24debacca971d2e86713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

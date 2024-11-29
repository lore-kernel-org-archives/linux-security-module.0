Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFF19D891;
	Fri, 29 Nov 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908004; cv=none; b=qKRx+x9DX8CTdS3kEqe2YAE84BlRIpyr6sMQ3pqsLTNk8KsxGo92+Oo2V2nEVdgRqEVRzUQUKRMX458JmsfAjRTmxuKP43GbQz+fzCanLu2g2RP2KCcTtCGfI1Mk3unLcKyb2zjYbIbA8kARs7Xq4wwq+SJu2saIgxrMnRXq55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908004; c=relaxed/simple;
	bh=Yd9Iuerp5ur9yc2AVKjsIfVLYSR2/jVRnuTc80dUZ/g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oEzV4wUheG4+D3NQaEOka7aLrJ75VZZHHbVHZxIDk/Xtsn+iePNfPfBQEGrVzzIfd+dzKqsxPKWUZxJENAFbrvRh6JP0jsNHQQ6RegQ/iIO9nmloIyglTKhXaoToqStwOiMZ+mRiK4wWrnrTCNvXEdEZT94cHb/7v/VBq4AXECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W157H5HI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W157H5HI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B341AC4CECF;
	Fri, 29 Nov 2024 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732908004;
	bh=Yd9Iuerp5ur9yc2AVKjsIfVLYSR2/jVRnuTc80dUZ/g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W157H5HI4utihM8hs1nA35LHTnKIK/Iz3n1ngw77pUFhDFQy6fkMFYecvivTB0vjc
	 bOjPXKsrRqDfc7//DJVKU0FmccMWC6XRktE22lS5aIYWEm25TzT4fmb2Uxuhlr+Vm4
	 E1eytjUfZyUNFOmkANJkTYOO1AAMP5G7Y/JclREbjL88RQHH/tzSocZEBd3eXXzIQQ
	 IYj4GILVbancHC3rXgzv7njUEpu6N0gCc2QSzLwgIto4GLDyimtiNeH1ghx57Xq/aA
	 ndJ20bpKIYmCRQHQpye4Je+NVYTnSQ3Z0LmufY0CF1BH/Rmeyntb9oeyfHYsAQnDbS
	 5tUFx2MzneiXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 720ED380A944;
	Fri, 29 Nov 2024 19:20:19 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <f8ecfc95-61d4-4637-b6ce-aa43b038ea37@canonical.com>
References: <f8ecfc95-61d4-4637-b6ce-aa43b038ea37@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f8ecfc95-61d4-4637-b6ce-aa43b038ea37@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-11-27
X-PR-Tracked-Commit-Id: 04b5f0a5bfee5a5886dc19296c90d9a6964275e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29caf07e9dc6d585f784e094c766a3cfceea3822
Message-Id: <173290801796.2154084.3167962623265866922.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 19:20:17 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 12:59:49 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2024-11-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29caf07e9dc6d585f784e094c766a3cfceea3822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

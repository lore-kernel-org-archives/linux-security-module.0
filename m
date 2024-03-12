Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12008145640;
	Tue, 12 Mar 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282251; cv=none; b=WzjoXMDWbHBhO9stjuqi9PIaWdGpDauIVw15IPn/DkACcWWlEKv6ADprjyQSMnFrmR0uQYdfffjyXewMLEUI5tvql7xLD1udnCq1MG1O8PCj4JnOvcDe/Qz3QwplpXjOjVTCa057NoxchYiCuDqRqdskNSjIxhVejp1E3IKhHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282251; c=relaxed/simple;
	bh=E75ilwNyLGs+r2wlyk0MuwQmqnnnjaKiCLqhxQHtjzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qrl+2yLHsFyWZSxLEtLJF/R/PjA8wEfIem7UwaZsyqy0H/4YA3epv4drwplwi58usWZ4we6edSMTZpJFiLBXnhGtjDgLrXl8BrKi9kj+D4lGeqtKJfP3YayW1wbkp9xpwEx3pjp3IdVFYbp+PFrOCpwuotgaQBzegU0okpuL2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saNU53oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saNU53oq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB086C43394;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282250;
	bh=E75ilwNyLGs+r2wlyk0MuwQmqnnnjaKiCLqhxQHtjzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=saNU53oq//X0FIn/OaibsQtHuXy8DD2+TYHMx/2Q1axGXtoN71rzfoX/ulsPVHdFd
	 hHfgt+BbbEzWA9ntFXklUIXbYhopdtXVMl9hbY/WYtyntd1EZW216gpj6itfHXRyni
	 hOPxs5diyzZmlDQ9KDP4QZA342azL7qGycHRI/Mpj8oKOTtiqGb1MRVeKIc7lv9y77
	 SmQeMME8VvMZq36GucIkTzULMqWgScIdn2O+HaLXOFE5S4oPmMoiF57CeVzaXzkOaP
	 l9tyL0qfE+5gV7+OtHKI3J8ij06OHZD35PBiFTT0u5tpgWGkFKd/U92QoeXZv0BVSf
	 cvRTpRwLQDj+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8AD2D95057;
	Tue, 12 Mar 2024 22:24:10 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <5f321246-e0ba-4882-a42d-fe174d593aaf@schaufler-ca.com>
References: <5f321246-e0ba-4882-a42d-fe174d593aaf.ref@schaufler-ca.com> <5f321246-e0ba-4882-a42d-fe174d593aaf@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <5f321246-e0ba-4882-a42d-fe174d593aaf@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.9
X-PR-Tracked-Commit-Id: 69b6d71052b54fb10feba68564ccb41c0f0ce1e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 681ba318a635787031537b3a7df5c12980835cb1
Message-Id: <171028225081.16151.11795532763523191273.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:10 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 13:47:16 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/681ba318a635787031537b3a7df5c12980835cb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860951AD41F;
	Tue, 25 Mar 2025 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944615; cv=none; b=a/OFeIf4bNcbO8ni096Xhuh8KHoTI+vY8gugWH1b7ftqmYHSTNEyA36qDuvFCqj6vwSMqkgaLX3gZka0Il/rUfXHJHCkUOUqcEdjRti7DTCQiLpPbFAEso+Kf3mGp7yhzEMN751ieOiwE/T4FLxO0uKhaw9MfB/3bOluY4PAnFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944615; c=relaxed/simple;
	bh=TcTgA4Rnh9fbKzRlw1ZFTpnDRHyDwaDSbbTA3s+wMt8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=amHMFul6vwx09USE2KgsPbyKsSe0y2YDjkg2bZNYahKoCs0ietdQUnb4tlYcZ0MzaiBYS2jgyD2GfssXd1vODjvUuX+xQp+oWHtpYq56/CKvanKbiCtgMbGWzcDF4d+D+frHCUQZVV62sDozTLEaERsHw621FXYGUydb6HsJTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhebkMZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhebkMZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE55FC4CEE4;
	Tue, 25 Mar 2025 23:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742944615;
	bh=TcTgA4Rnh9fbKzRlw1ZFTpnDRHyDwaDSbbTA3s+wMt8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RhebkMZt+jg6byXZ5GOyc0kZ1IigJiKTjP2lyBc2KsMMCeG9RuXnMBYir9a7sQOIw
	 rlMCDbgX2T0ucFluRsdalkmiMVQ2qa6etr8jRxePyR69jqBIFt7EIEIAsCfQY6FAVg
	 8o/3EMx4jIgiT7ncjn/Pz44hpoUjsF+wSjUph7USFnOYVlz+PmgYb80PkaH/2K5M9Z
	 z3N0KYyG41MoCct4SRxKwlJpQvTnW861DNMr/nnmPGDrC23Q6KopPv/T4qNKqTXmgt
	 GPUs/2yrpil8iO7y+1L+P/lI6PxuHWgvDGrmVrjGGttnm3KdWnY2NbMVKqAVBGEjED
	 51e33RuWZd/Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4D380DBFC;
	Tue, 25 Mar 2025 23:17:32 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <8040a0e7-2121-4389-88e5-c6f209bfca0a@schaufler-ca.com>
References: <8040a0e7-2121-4389-88e5-c6f209bfca0a.ref@schaufler-ca.com> <8040a0e7-2121-4389-88e5-c6f209bfca0a@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8040a0e7-2121-4389-88e5-c6f209bfca0a@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.15
X-PR-Tracked-Commit-Id: a158a937d864d0034fea14913c1f09c6d5f574b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61af143fbea4f1013e064e7580acb7332e531bd6
Message-Id: <174294465091.770882.16042293881296026047.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 23:17:30 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, konstantin Andreev <andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 09:41:19 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61af143fbea4f1013e064e7580acb7332e531bd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

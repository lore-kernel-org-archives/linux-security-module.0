Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6626D4EF;
	Tue, 10 Feb 2026 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684616; cv=none; b=tg5XNLPdTS/7GmCp0erDXv1ey98A+tSglzC6Ii9ag+wgTiW+bOPDTb0KvYVO1u+ZAyNH5ZloBYXvqjl+5u6w0LTeVTSZ/RRQISOQbhDajYDdEKhQ9G8jwaQJk8PFegUW5l0/RlqHcnneIH5FNdzoFUIKGFgy/l8PD0DSedyDrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684616; c=relaxed/simple;
	bh=nEy698zWflBlHRH9QC9uQtAwMbFS4KDqCAEa15Vjl5c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UZ0gCjom1l7jrzvlM9T77mCI57V+MxEbBU8yO5d0uU06kLo0fjFrTqADG109oWqW1YT/0N6Kp+RknYomSmOy1oBzkrM/xRvc49UycO2j9GJkhfGUsDGx85DmgkOcX0R6q9sDOvfOEQYPFdWpuIt44QLe5qLbTbxoGR0WXsgL8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuyov9wY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuyov9wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50611C2BC86;
	Tue, 10 Feb 2026 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684616;
	bh=nEy698zWflBlHRH9QC9uQtAwMbFS4KDqCAEa15Vjl5c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nuyov9wY7MpUyZ+M/Rl2X1M1KfPqFYnI3ELBsOkmJ9CocZsra20dxSu2n2PLutzW+
	 9BI7qE1FwJqM8tlKFKF+VgnLQCJWairuccp96gsWjfmGfYVEwXtnHhaxCmWwHkgwKW
	 7cxI9Tytim00eEcln/aiAjahNXVz71z+kYAdcVHDx5qSOeUdNeL56r3AuBmRGGL6ni
	 yMKolsZoBC9oABpeONxoYrfJREgHu0PyHriROy5JCgsN6APd/6ZUzE8xe1f8p+N9i1
	 N+no+S0Qt6/76ovjc5OCv7JTCcms+NHFF+zgjd+/yCRoa4wc8gJ6kyAjahV87hCaAU
	 vgUZiI2nKW1hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4542A380AA49;
	Tue, 10 Feb 2026 00:50:13 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20260203
From: pr-tracker-bot@kernel.org
In-Reply-To: <d6f1f788f25b30ddc05703b97146f6ad@paul-moore.com>
References: <d6f1f788f25b30ddc05703b97146f6ad@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6f1f788f25b30ddc05703b97146f6ad@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260203
X-PR-Tracked-Commit-Id: 472711068fa950642b9b471aaebcc82e9930eb8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcc8fd3e1573c502edc0cb61abea0e113a761799
Message-Id: <177068461219.3270491.7594051186489963067.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:12 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 03 Feb 2026 23:10:44 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260203

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcc8fd3e1573c502edc0cb61abea0e113a761799

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67A3164A4;
	Wed,  3 Dec 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790533; cv=none; b=EBDm4hVSjR5eBHJVEBo0uM6rs2/972awDbVXHrx8OGsn8HlxcowVgXWgzYfxJsWXoWle9qid7wYucfg12ktRxwE73UMkIQxlYrAqr/dJHSbcHeePITuhkJI/Jsa7SZk2k+noY07CwIy8o2/0BLhoJ0Fvvb3QSKrsbb0GaxaDr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790533; c=relaxed/simple;
	bh=LWItJrXyZlnNvF6IGEcPQHo0PBjIq7gQXTd014oToqA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FYwOKfVy4tAfXIsVwoSco9SL85gKU3zE0whOdZ2mNG751wjAsymEOH2bHu2lcP/8JH+uU0hyE7t2weVq9007Wfsfw5S/OnpIjDBxaA+yexPCA6+8EE3vv+FrsBuacQUxYPm0hXs9jDdJUIzQuWvIC7Me9QbG/oxUQgpK4QYriqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO/LJ2rW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO/LJ2rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0173C4CEF5;
	Wed,  3 Dec 2025 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790532;
	bh=LWItJrXyZlnNvF6IGEcPQHo0PBjIq7gQXTd014oToqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QO/LJ2rWbvY3aB7mCbuHpHilPLHGOxnOR/NGRPpGHQh97noxg+I5QDi3qZZdCy5sv
	 sdl9lFtFxUvVsB1DLSTBHhbPG/FFwgaGpeFq+1zPad4rEPb4xxR2D62XT6/NMmhGsc
	 GzDhwrK6GEVEa7GoL1GDOz5E4E2Am3K3dE3sSZahnXbGXyjVRLa5DKX6QuE3F0Giyb
	 SWOg4uvV6/+lFv8LhBAJv3iiTEbUowYEJjCpYaeL9s/GWY4o4mhpg3eT/n9O082fIV
	 SI3oqMRqINjZS3FUU1A7oIG2v0l3Gd0Zny35YLWKLnrc1bXBkbzvI0jwKCB3/L8ml/
	 rqTlNjrsT6Jkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B587B3AA943C;
	Wed,  3 Dec 2025 19:32:32 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <80229bac-c3d9-4c99-9cca-dade23ef7421@schaufler-ca.com>
References: <80229bac-c3d9-4c99-9cca-dade23ef7421.ref@schaufler-ca.com> <80229bac-c3d9-4c99-9cca-dade23ef7421@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <80229bac-c3d9-4c99-9cca-dade23ef7421@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.19
X-PR-Tracked-Commit-Id: 29c701f90b9341f1f9c1854a9c22b71c2318457d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 204a920f284e7264aa6dcd5876cbb1e03a7e4ebc
Message-Id: <176479035117.47894.17985112267331119007.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:31 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Konstantin Andreev <andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Nov 2025 12:24:38 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/204a920f284e7264aa6dcd5876cbb1e03a7e4ebc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

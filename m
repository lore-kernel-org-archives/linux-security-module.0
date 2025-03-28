Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370641E1DF2;
	Fri, 28 Mar 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194443; cv=none; b=I5jLSsh+Pnzq4izXp7anRiG70MGCQW2zO6XVl7PyFSAYrr0FtaxrIFsP/z6H/hB2e2mDxYK6mtzOh4y8erwYKZhVILJgI+jKiqxAgiffLho+OxLe4yAmNXdxPTbzcqoV3btdRGy48GemL0AfksOzrUt8FA669bybDenZKeyGVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194443; c=relaxed/simple;
	bh=ncihD0lhW2KBFEoypj5EzB9ByWM7hHBhWcf8IrSwVqc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JMD76Ak0cmbeDvw6nuLYMx2Mih+lYsa3J7n49Gp27te2wQfsxYsVtJW8wp5sM3ZzEX1sNPqKgaJepwfWNRCmMkq8OvjxWPobP/cvo/MsUuoY5S271a6JSE/m7YxhhNwxHACbpI+kc1PtqC8rejE0upLRut0aH0/Gr0mbObTCvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9/BMxYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9/BMxYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1068AC4CEE9;
	Fri, 28 Mar 2025 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743194443;
	bh=ncihD0lhW2KBFEoypj5EzB9ByWM7hHBhWcf8IrSwVqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j9/BMxYbZ46LjCUPeLe4Y6eCTkEN110MUHm9aPyJ0gFG7slURM9Eq4SzNhcc5a6tD
	 Xog4OffH5NLs3c7dFPr8iHdWDMSE052Z/4bO8/5T4uNK7rVVyPvQwy/G9HXVlXs3dF
	 pEFt603xiASX31YhB29XIjMuJF8Nyu0u0GWrj9IWlCBCPPrpC50yu8qdL+a2MyfLrT
	 fI7YAG+RpdewsRnVb0EDThXymLFnPDdtJGNksTbqrhic8naPD47cBn7IRIhvpJVGpT
	 sDuqOzOQgHvlZWVsLPnYk8X4ZbpqOZWTCfMemY49iwYuXAlqIsygcE1UgVl9XGlqOd
	 QkZHD8vzvhqHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC410380AA79;
	Fri, 28 Mar 2025 20:41:20 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkFq-4vHbinAjsTyxU=BTNR-yFfy-i0nvLSF_xWQ-awrMQ@mail.gmail.com>
References: <CAKtyLkFq-4vHbinAjsTyxU=BTNR-yFfy-i0nvLSF_xWQ-awrMQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkFq-4vHbinAjsTyxU=BTNR-yFfy-i0nvLSF_xWQ-awrMQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20250324
X-PR-Tracked-Commit-Id: 6df401a2ee4a91f4fd1095507d6f461f1082d814
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f174ac5ba2d0c77b406b3f73bdcde819d6ed6704
Message-Id: <174319447952.2953471.1534786961974387875.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 20:41:19 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 13:50:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20250324

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f174ac5ba2d0c77b406b3f73bdcde819d6ed6704

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C251A3BCE;
	Thu, 19 Sep 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758615; cv=none; b=gk7wxMI0n55WvIrT+HqAdZ9OpcDbKBTk7kgYqXtgqXejGvGhyusFzFp/4wYaRhc1yVlgXLIXH3y77ig22UQ3khe7oT75pW67DAJpekPt/l+8LV28fZuTSKJWKWduZYms9jm8Nr6vW/kbghEcNeaDUQD/lAeVfCquaqY5mhrx/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758615; c=relaxed/simple;
	bh=fqC28D/WFTkWkUXkRi3RSK8bJ+CtdTMZcYqv0EghQj8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mrqPnNvaAJp69+IvBAxxMbBcYyhhiw3RE0oWkf9ud3SbV72HHt3bkcqh2wkJyo4wLvk/Eb9pDdFxXNSkXE63cljskJhLGDr58xGIgnkEc/ig/SbZ6KGln5uekQyH/qw/EhUjR+FeJM7syp6wuUh0Qdr7GM4j2OWrIrMkZ9r44KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d77NqEOD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d77NqEOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899BAC4CECF;
	Thu, 19 Sep 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726758615;
	bh=fqC28D/WFTkWkUXkRi3RSK8bJ+CtdTMZcYqv0EghQj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d77NqEOD8XPCRiePIZSRCa8bu1YVo6Cj4TO+mnSW2k3VzziYAWUywFMPF5JZYTqXa
	 3CknS2tAJ1wOD/yrnbKPlov/7GI+Nn0hp2T3St/aRTQcAkvvGLHAcLlF43aIT7n0XP
	 wcp9lxHcAYLJY11HPbIyOhHo8gkuw8Tudr9XEDxwk7AucW6K5OLnnU1a1ZBCLC8nc6
	 rnafTBMvQ1Qa2Z0dyNcslTa0wixtAs/5V6VI2P7dNDPLXjlx3SGDnR5heuw/WnIsnV
	 4Ze61/2Dd5uPwW3gLGLacc5DoeLLo3jbnUVF/hjzEpNqSN/5OzXBUJ5yY7nwESHEJ+
	 Z4FoG3ZX5f8Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A190E3809A81;
	Thu, 19 Sep 2024 15:10:18 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <b14d039a-7b06-4552-ae61-fbfb4e912b4d@schaufler-ca.com>
References: <b14d039a-7b06-4552-ae61-fbfb4e912b4d.ref@schaufler-ca.com> <b14d039a-7b06-4552-ae61-fbfb4e912b4d@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b14d039a-7b06-4552-ae61-fbfb4e912b4d@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.12
X-PR-Tracked-Commit-Id: 2749749afa071f8a0e405605de9da615e771a7ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 509d2cd12a10d057fdf72f565b930f9a81140d59
Message-Id: <172675861754.1588903.16015187619761400872.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 15:10:17 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, GiSeong Ji <jiggyjiggy0323@gmail.com>, Jiawei Ye <jiawei.ye@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 17:16:09 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/509d2cd12a10d057fdf72f565b930f9a81140d59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

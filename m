Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E773F23B2;
	Fri, 24 Apr 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055588; cv=none; b=OcD9MvVZClQQ8c2UgG0HPpY0th7SxLgZVFqe3ZF6bIo+wZl54+ckj5u5roJejN3NtjPg5N17Fu1SkaS6R1PUzNVnkdlKOZ3L1wRGgiiWQeqb4r4q83I4VmRLYh7/AaCVUR9g7gBme40tgvBdK6dTNFd87gd8AvgTPBMjLwR7z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055588; c=relaxed/simple;
	bh=yvxf3jTuN0Yt3rnpfj7PfLnMPpZyXikUqjGXJa9S/mc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZFtN3qN8VCEWAU1FE1NttLOAayxG2nSGyC7zPLjYWI2Hquag1cpJgjtZfWOnchj0QPVQJ09ckPGT9x7PxQqsOxeSUV/yofUMbQustnz4nusjI8gVI1LhYKlpccmtbbWonjlV9e2Cb61rkslrY2wQfq04QIcdi+1xFgxXKD5w2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYP4ldXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYP4ldXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD267C19425;
	Fri, 24 Apr 2026 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777055587;
	bh=yvxf3jTuN0Yt3rnpfj7PfLnMPpZyXikUqjGXJa9S/mc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tYP4ldXq1kt4a+KrIWDS/NwdHIx47lwLRp9cKsaCtHQuonMKOt10ifrJa3Cze+4fl
	 WTES5d5f22S5RSKf1FuQlabQ+FSngStxqaaGL1or/ucn0TQmcI6a+LjHDmzIawhBXy
	 wk7+O+ivRggUfkgABI3Tr+RZJosgnxHI0vK2fahGe09DifbTo0d11xPSv8DmuIDK+G
	 oOlJco3GdM5yJfLHcbx2Ex0y4/5tjOdZFNMPzcMDCMeUGaD+6StQwX/AprD1sstFvh
	 KYg8DKSYvoyiJWjmPVftFm0cBtwem0kFFWYOAY71jnokzmo2qeGWeaERCjQ/FA8NCZ
	 ShiOXaAGlEksQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0BF38119C3;
	Fri, 24 Apr 2026 18:32:29 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1d7db151-f119-4270-aee7-b3fb568c47b2@canonical.com>
References: <1d7db151-f119-4270-aee7-b3fb568c47b2@canonical.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <1d7db151-f119-4270-aee7-b3fb568c47b2@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-04-23
X-PR-Tracked-Commit-Id: 11b7df0952663f20ce72c9a22a3cf9278cf84db7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eefe0b9dee5db64ec87707c8e44f31851f257389
Message-Id: <177705554803.1656274.11082697223165128747.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 18:32:28 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, LKLM <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Apr 2026 16:53:00 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2026-04-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eefe0b9dee5db64ec87707c8e44f31851f257389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

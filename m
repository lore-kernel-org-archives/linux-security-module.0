Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0614831C;
	Fri, 30 Aug 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043052; cv=none; b=l5Wb57hZ0cCZuEsOfeHlrT12ur5IDuZdb3IXV1FOxvnZ+ORDHrV3rPHxdCcN44VhFy38e1BRUuSi1FLpMnhjLcyVi4AYLB3aZUSIXnCkC0G39Nr0Gq1i9tUrUjRL+FOXZF1983MTsVWrcCwexRhY5lnEiX/klDHW9G/lTBuNE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043052; c=relaxed/simple;
	bh=LNvysX5WxpHMCVV/0Eww5ywOJx7IzB+ICLPFd6e7rFs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fTqOTQ+VIcEWWpC7XPfLTZxtjLT2JuRYUEvaiCZXhAi9QIpO5bQfw7zUHvM5TzxTSt5z2DwrY8N3GfzcMzM6HTk17YzeXsaphGzi6CEFBqMveOjWK8T94A1IfIJuQO2FSuFrCGEeS1iJXvPu5njt7v2OW8xk+QZE25yA+RdtUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmTY9RFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmTY9RFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C09C4CEC2;
	Fri, 30 Aug 2024 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043051;
	bh=LNvysX5WxpHMCVV/0Eww5ywOJx7IzB+ICLPFd6e7rFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EmTY9RFMeKssSpS07tDtLT3mXqMwK2uPNfNSF68QEbzXKTfqDdvs+bmCguKvUEoG8
	 pwoUwdz2XgZ7+25ML0RmlzaOHevtoQtQj9d8A4k7BEyvYeeI/0w64MIAUZ3CTRjc4v
	 j+ErNe0F6SacXpbstimr3LVkBG5LLDUDEk9eOTlYjGHkI/x6/F5HCJhSKn/5H8UtE+
	 znUwbs1wMMdpnXwjfT3Gz4sEMejDJ/8962M/CM2ulXPNe8C9zGN6OxNyhqUnmRhv8H
	 uLQP/6zP+qmiJLkk8m7d61VQhICJxgFsOpmTCO28MP3421kSNdl0rkku2NH8P7S/Lc
	 AXHJ5HZPnjlzQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79DB83809A80;
	Fri, 30 Aug 2024 18:37:33 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240830
From: pr-tracker-bot@kernel.org
In-Reply-To: <44172f0b7c57b1423cccfbbdf7b6518c@paul-moore.com>
References: <44172f0b7c57b1423cccfbbdf7b6518c@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <44172f0b7c57b1423cccfbbdf7b6518c@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240830
X-PR-Tracked-Commit-Id: 76a0e79bc84f466999fa501fce5bf7a07641b8a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb24560f31f9dff2c97707cfed6029bfebebaf1c
Message-Id: <172504305349.2681732.17210439463173240744.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 18:37:33 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 11:22:26 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240830

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb24560f31f9dff2c97707cfed6029bfebebaf1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

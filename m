Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A271EB5CC;
	Fri, 28 Mar 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194452; cv=none; b=rOFx6boqBomJwZGR8+GCjNdcQvT725JP81lQPhHPg8qvWVoBS0pmRvYvRo8xhz6qi+c+XYpr4ExhXhSG+aNMSToTRKLfTwgVRWa4LjHY8y+Gtkdo6vc0PTqGzTsMaKH30Hzw0kUvmLlnCypIEUjENge9VWQo9w3kWeOxMS55zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194452; c=relaxed/simple;
	bh=fvB4ZDaCr4JUn2R87z4nGq75oVjZiNL3gVDNMsTp9TY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SQW7akYrroefhOFkAWbRbWpuwLJ6SCFKFWXa+/E887VePRoE+2A1o+5gboWz003B+H5crT/H++rEtyI9DDAeoXl9LY18wgQi9S0TdmSCz+dqfLxGblDVqrTGxGfWtnEBXCpzQdiH7fCsUfiUepVRqqucjNW9PxxgmYjXJM7zbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsgiIN+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsgiIN+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AA8C4CEE4;
	Fri, 28 Mar 2025 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743194452;
	bh=fvB4ZDaCr4JUn2R87z4nGq75oVjZiNL3gVDNMsTp9TY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BsgiIN+ig+dz417TTzvTeXmyicMZBVsK+0FlTbwiuhgPGgs+CJC7EGAeAhYz9QC6E
	 AdnP9IT5WQ1NZAmV9JJATHZeX51ChG4nz4j4e5R4nOm14yGqTMOnfdfP4LADnt1OhM
	 QI7eyave2Ze9SRaSj8OqtZtAoExp9j7mcYQsc0p5gXbJfDcE2ZNcUgE+u783tHNaHU
	 fHwcp4MjDRETqaDYAHeJFY4imaA28JGbVTRHIU+9qbQktf5SrcJA8SW+JdyJTjW9g3
	 7mSVb3HbABOgm35/SqkNAgX+2pgnEEgJ0vnFaB+vnq7g+3W1Q7gNS3hYGXMSzGHwPb
	 57vaWeky027Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0493805D89;
	Fri, 28 Mar 2025 20:41:29 +0000 (UTC)
Subject: Re: [GIT PULL] capabilities update for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328040726.GA423659@mail.hallyn.com>
References: <20250328040726.GA423659@mail.hallyn.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328040726.GA423659@mail.hallyn.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20250327
X-PR-Tracked-Commit-Id: 4ae89b1fe7c2e37a8f2ea39765e4c40c9d42a101
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78fb88eca684ed6f09f01a232c925b6da75d8131
Message-Id: <174319448825.2953471.83879462561571097.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 20:41:28 +0000
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>, Paul Moore <paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 23:07:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20250327

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78fb88eca684ed6f09f01a232c925b6da75d8131

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

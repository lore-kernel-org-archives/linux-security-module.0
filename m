Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57498337B93;
	Wed,  3 Dec 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790540; cv=none; b=qNXzHVl/bHpVFwGbJOlOu3uPYu0XH1FoTzhGolWiSJU1Fqi6ncuAlfChGXRMz2CofkWeeqdNRM5GlxRKBvJRoE+bni/cyWyjBoJ6HwDYloth015Y5CbyU6NCqGVGUqJHszTKMGcjgihsOK6bJf4TJW4ICxXhrqctPgxEhccHLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790540; c=relaxed/simple;
	bh=aRtNjffDSW8m12eprWF8LOugHy8bmHg+PPk7V49EUJU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kgkf5XnNvER6xGRFjmJ6eN2TBLQhbL0QNKmdt1MAclBvIE/iWLQf1iS+vMr7gc3GDWat1lqUZDo316w7pRNm43L57wVQiff/4jXN70DsMGs9jRXfvySpLzGuIaQ9s2HhS9pg+D0maG2SwxQ02jEENeImcPf/USb45I4JxeB+1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkh87mPp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkh87mPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DC5C4CEF5;
	Wed,  3 Dec 2025 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790540;
	bh=aRtNjffDSW8m12eprWF8LOugHy8bmHg+PPk7V49EUJU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bkh87mPpZdxIQ3ONuTEF7ELsmI0VLtJGcHzNI2dCKBcrMcyclMHLa+oGZ+fa2JaEN
	 11GQkDWlaR1e8IIgGTlzc0lii2bLZVuNBd/pawqHIoJdvigql/VNoCMpuzynxMdnYZ
	 bWN6qWP++HCpXrw6JZjx7tamrmcU+E0rc3+mUOGHKSbhqvUL8CFbCmpgl7qKJaJdoU
	 5SdsWOmcgM4R7CqzFhEbclNmxkKAcHfOEqoUBVrUUUyQ6c1nG56BSDDzn/pnqbzWyO
	 qX4mPjbgs6k75sgx+ArdgWQU36eGXMUaYSt3gASVUVctuViVRQQ0Gbw17HhTCZ60us
	 vz84DHjftt6mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8833AA943C;
	Wed,  3 Dec 2025 19:32:40 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20251201
From: pr-tracker-bot@kernel.org
In-Reply-To: <b60d63f8bd01d8432b9986d8a4797f4b@paul-moore.com>
References: <b60d63f8bd01d8432b9986d8a4797f4b@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b60d63f8bd01d8432b9986d8a4797f4b@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20251201
X-PR-Tracked-Commit-Id: 9a948eefad594c42717f29824dd40d6dc0b7aa13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 121cc35cfb55ab0bcf04c8ba6b364a0990eb2449
Message-Id: <176479035873.47894.14520934671788907849.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:38 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Dec 2025 21:00:34 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20251201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/121cc35cfb55ab0bcf04c8ba6b364a0990eb2449

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

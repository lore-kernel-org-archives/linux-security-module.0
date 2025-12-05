Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D1246BD5;
	Fri,  5 Dec 2025 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764908328; cv=none; b=ebGqwxRz/4+0Y7UZXzzoh6EF0hg38vTqVkPHVs0Fql5jx02ajO3594P5OMqQiSux1qYMc0za1AXhrpV3HIpt0tLdTwYaicGK1spmf+vazt4Vrx+/hb8gSZqsdl2UOv7hleSfTW1Ea/JJsu43P+N81xSRrMwP2Bvbr4VnQAKCj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764908328; c=relaxed/simple;
	bh=0doMz4Tysxq4QUtdRYpvE707IAYP0kb4LfiCMjrVDuY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZSGRLqvSiZ6PZiLWE9OGBtdXZbwQi16Dhlgu/3ArhpCHksbS2DUAhWSCccWZwVtfS+PJX8QitrrdmzpxA28xlzie1c6mj1gsSQaaGxMHCuMuyIqy9GuO0HhWuT08Sh5fcsBHkulXFtp9dm5gvIAdFrVtOPSuavpY0boxTsQuFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ56Qgng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ56Qgng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C17C4CEF1;
	Fri,  5 Dec 2025 04:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764908326;
	bh=0doMz4Tysxq4QUtdRYpvE707IAYP0kb4LfiCMjrVDuY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SZ56QgngX1nLDr1GmokTPoxvLKaxzn8sH7hUV+pA6nobqV2vyfmmzn43h82hc2hCn
	 UpAVeGIRRaQlmdJX33BXoJ2TdHLiYqcFWf2XCv+dcKJO/qZyvZjll6TPA1zrt0izxO
	 VCW+SjZTb+oBde055SgLAt3RAkEgtAGHHMHS2dgjbc0oO0vOfriCUPi5cp6BtVTS8C
	 v1iDXhEN0jBi7j8EoCTAHlJwa6WKh8IIYq8SxptAf3kEB52zmL9Uu4+NuHPzcHJYfI
	 a8L19GkQYyDEc/gy3BTh/JIeyikPJexQ30lz+BkjEXbZ0Y4+tS0u3/485sbWWucF0d
	 dKGgfXHLsVlYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5DEA3AA9A89;
	Fri,  5 Dec 2025 04:15:45 +0000 (UTC)
Subject: Re: [GIT PULL] capabilities update for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <aTIm6grHZUhRncFH@mail.hallyn.com>
References: <aTIm6grHZUhRncFH@mail.hallyn.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <aTIm6grHZUhRncFH@mail.hallyn.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20251204
X-PR-Tracked-Commit-Id: 9891d2f79a9fe9b77ad290f950eb8fa3e375330e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2061f18ad76ecaddf8ed17df81b8611ea88dbddd
Message-Id: <176490814434.1100656.2701490038880043306.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 04:15:44 +0000
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Dec 2025 18:27:22 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20251204

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2061f18ad76ecaddf8ed17df81b8611ea88dbddd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

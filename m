Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AD509F09;
	Fri, 25 Sep 2026 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377628; cv=none; b=t/iXX/BBHK7b8FN4WZDk/st/OTK++FnOHMWE5sDtqcWWZhYs6wp8i11NI0QMOd7NgpwVF4feL3424ozj4sXe79pTEASvj4NlMbjo0ffmVC8jpjhPncKmanV4MhyQDDLzIXG0G6KRvyMTIpdnO4TBuA8BYtYtDcHBUn/WklHBXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377628; c=relaxed/simple;
	bh=cU+J4n3+epQ4nHU2vHvTEi1VfVUVV2iuTPy2p4qto+E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aY7hcju4CmzkLw9Z+mzB18EgWpK3REiVYr/2Skv2JfNRPj+YjHD5apj99sCXwmKP1e+3ZBK77pc/z+azfnhB0LysYjZcQ+tQhI8Ka8vdcITQSevGcTKxzW7zLt1u/3DR1WB4mG0FOiO3wcpbhJ3Y272paMR//j1okbCZyqSfm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDVUJn4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDVUJn4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A651F000FF;
	Fri, 25 Sep 2026 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377627;
	bh=u7+1WhFyMA3G2/oKbAYuGhrl7PBPqd1M2eQYcXcsS7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TDVUJn4ycXwPJV+8T570wjYi2kv+heOsn9pKYyj0Zmg83zuhTarqa9c8/6ncezWDD
	 u7XwnLrkBqyWEfa1MZG2ty2BYZpOyUfBflN7B1EazvFi7DMCRth/mDLPIG/7EN69aZ
	 qo3c9K3yP8+Qb1sAbiF1RMipFqRx+5gKOKPXLuXTGpnQ2s31CE9F+n0Jd3czZW0jfS
	 eifxtHHwAGO5tH3nBrG6qmbZCR6aEGNqv6WLqcFm3n0AMb4F/ZWixUTySuj29sxnzy
	 JhIH7JATatys7qH0f6Ozpw4mg7obwOHmMjGZrBeVfJKFaJBys6y4nc1FuadHaP1CG8
	 l0bHWYOz2BQRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CFC380820D;
	Fri, 25 Sep 2026 23:05:56 +0000 (UTC)
Subject: Re: [GIT PULL] IPE fixes for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkFPVY0zBLBZx_9A4f_t2ud3JPR7N=DtJtFuC5AsgvpRnw@mail.gmail.com>
References: <CAKtyLkFPVY0zBLBZx_9A4f_t2ud3JPR7N=DtJtFuC5AsgvpRnw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkFPVY0zBLBZx_9A4f_t2ud3JPR7N=DtJtFuC5AsgvpRnw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20260925
X-PR-Tracked-Commit-Id: 2776e9c28513a1c855a94792b292cbcc533418c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75467f60a3d14f08f86f2b353298d2826382ff23
Message-Id: <179037755515.3195274.6877756220047279207.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 23:05:55 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Sep 2026 14:54:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20260925

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75467f60a3d14f08f86f2b353298d2826382ff23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

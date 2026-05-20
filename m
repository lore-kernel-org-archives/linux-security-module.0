Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE023EFFC2;
	Wed, 20 May 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290660; cv=none; b=BQQuKVRwAH2gfMLQxzMHDt8wXoQteP5+so2YHtGbecjwJHhWVMS3/edx0YQsSJmBlF+XhD47sqgX2/VguXpVXDTEYujm1lYpVND9h6Y0NAVIUaSSnLqqNp1sORReKhIsF8usmndAbOzh4Ds3X+9V9GkwBtCg8PQIoDLzb9tAwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290660; c=relaxed/simple;
	bh=TE41fRp1+v9+PaV93YseeL+zeD5mEzu5n0soTNuxcRc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FDCkwBI/M+MyU3HMYsmg7ADLlw1FaV2QXwjVuyngb3Gf7Az4QnjzcwHVW8+vV+Ii0+o7MsPuv1Y662j2TUVtDdw2xOomeLhN+VX0vIAxJ6WPw0xG0GLnUFUwF3vdg0xb2rdm1N0u/poN/31d04K6C7D759vbfQuDpYpkkL1T+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMmwtsnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMmwtsnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277361F00894;
	Wed, 20 May 2026 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290659;
	bh=ZkvdHK13BXzFDzhGUBMaGrVggKFM0dctAJVhthcXJ+g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SMmwtsnXDI+hDpu4a1gz2aATysNFRtIa9/2ju/DVP9yDvAkx1rb+s3imfF+Gmve1g
	 jJnviY3xwH457coUzkKesJ1urGoS3Ie0ReRVWkFGo20Wppvvng+DYd++ep01SbCA/R
	 1c7XK5lvo2w7AfYBMIkjcuYcgXD2s42u8yGkGNkIyxtitECARt0dF7Qc/9lWewG+/h
	 umlhBlOHG8Z3QoWUxz+maYcsm8sOrdg0/6yGeV5QcUByg5230awxaFPxkCCt9MAHR4
	 2To2crNSGFbCzcEKRaqHhNHS8bvbsrqgnDjzenj23nA6+/gB7kzW/HSePimG+kHOyJ
	 TLkYcoyUmRfyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CC53930B36;
	Wed, 20 May 2026 15:24:30 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20260519
From: pr-tracker-bot@kernel.org
In-Reply-To: <96f3b6072567c23ebabe1804a0622af5@paul-moore.com>
References: <96f3b6072567c23ebabe1804a0622af5@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <96f3b6072567c23ebabe1804a0622af5@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260519
X-PR-Tracked-Commit-Id: 4a9b16541ad3faf8bccb398532bf3f8b6bbf1188
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e312f536f647156ac55e2f12d021cf887af274aa
Message-Id: <177929066947.3632670.6449932407924846529.pr-tracker-bot@kernel.org>
Date: Wed, 20 May 2026 15:24:29 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 May 2026 16:05:25 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260519

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e312f536f647156ac55e2f12d021cf887af274aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

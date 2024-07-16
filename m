Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E913AA41;
	Tue, 16 Jul 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167162; cv=none; b=IM3/dCnqH9JMYdjB1zczMdF3z4wPbr1yPdt7XSbn63Cpmfc3sKxHvLsEDla2sZLP/IMr04aPY8nRN3nHFKmGi18WmDyDowAveTQazmwNEOFXuDiLY6GX7EbURknejlHw6wcs2rb49OaCm0tHPvK5JyDtC//ZEcEDKHK0oMUDi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167162; c=relaxed/simple;
	bh=LrSQ4iilkVKAmglZfjQEH2ZVco7OPWRjpoSltuDAnnI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RLAxtCgLZ9FPPVJSgePgOS8vopUVZmYRzcwvOrU9ilEf3B6TzYlzmYfvmzDjvHpGPj00bsecOc4h/seU2daeWWqNV/rf2u1NyW1hGnnaDabungtTI3nMrXWY4n4CpivrKN50Pl6/QFQMYaXcvFR2Nw3dPtOCgEA4+vkCocOgGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahk9Hh9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahk9Hh9b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2EC9C4AF0D;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721167162;
	bh=LrSQ4iilkVKAmglZfjQEH2ZVco7OPWRjpoSltuDAnnI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ahk9Hh9b2Yw8Jol1j6Y65Xm7F4uYWnXng6CCUCm8o3zmHtGhgF5pGJG9ROrugQgrW
	 GxfKJvCLgtXzSF7C2O6vfv+fqeDOBL/SdstW3Fa1h83NpFxB8481a10a0ZQjfniFQR
	 +w7ciFwgt8pii8ZscErydWEnVOqNEp0ZMiuky50MldTUWz5WlPI3z3qAuj+sdPlmji
	 a/zwEWcwLIK2SY5MqwrPD7bvSW60Pp84yXX1tT50C6nalFI4iRCy6mBNPMdO4uLTKF
	 lfX6tlEFRz1sSJM/uaiX02oS3kaR5mxCy3pINJ1Yq6sjtPmeRBZn7r9ZPgpY14lIBC
	 e9cFcC/WyWd4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E902DC43445;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <c9842562-3564-4977-880f-9042ebe43e62@schaufler-ca.com>
References: <c9842562-3564-4977-880f-9042ebe43e62.ref@schaufler-ca.com> <c9842562-3564-4977-880f-9042ebe43e62@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <c9842562-3564-4977-880f-9042ebe43e62@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.10
X-PR-Tracked-Commit-Id: e86cac0acdb1a74f608bacefe702f2034133a047
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42b5a01596f1f9471b58a2f59e1fceeb8db79ffc
Message-Id: <172116716195.1258.16982481654978018987.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:59:21 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Konstantin Andreev <andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 16:30:34 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42b5a01596f1f9471b58a2f59e1fceeb8db79ffc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

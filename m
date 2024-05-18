Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142B4778E;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716055621; cv=none; b=ilBg4upEJBi8bIFUtLGeWMD1TxBPhwaXqEyDYbTm23Ta2NYVG6/ajFoN0IalL1oXIk+4qTJu8Wbr2OTHp9DQr43+xAAFqFJUuMmtZNJNxgkb54R5U3rD0jrt9GMkeHWu2wD4jq8VdTZMDH+WUqLKbIDnFIRvT+Do/mELbnrU6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716055621; c=relaxed/simple;
	bh=pgO2J4u7Y1M2DtNPa0+OyCf+qyXOJ/w2BJb+vok+cro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MZY4Zrw9oguCyDzDqRPnXIXmU/hRhH05zrY+bGWv6ZMHO/RkjisuvbaAwo/J8mcFFWzZ+5TTVTXQeK3txnKUlfUtJpTy69U4WNlBpStRVPdrTy5ar4tvMFinUlaxOCvZ7txfVhjR+qG31Es4O0DDqLtZkEdyODTWd5VTGwyxoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a77L//wv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a77L//wv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51CD8C113CC;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716055621;
	bh=pgO2J4u7Y1M2DtNPa0+OyCf+qyXOJ/w2BJb+vok+cro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a77L//wv61ewTWvZ1jBHHREzL9y2KXYCfA3pVFqiu50ftNn095QKfo1TDFURWJDSL
	 wfMHB/oucTzsSF1YBQyJJu7dFKnJMZD73i9hbZ+ySEeFMQkk2ql5N49VpEhc3YgWn/
	 xA+ORhxQ9aRiXFfuDrwLpkMtBWaTGSq6LvNm/T7mfju20fDonLOejWCVDM6UCk/CWj
	 C/LwLLu6Mo+vNHI2ol3DCwHCK/pzsJKge9smrIrnNhdDxTvpwCxZ5Y+bK4ynhaX/j8
	 FZTFPOtLZ+bYkP+dWzMxSDqkxmOd3Ydqat9Cu1cXQSVlb+z82nxAd6s2O7eYYVyuxC
	 Ukv0Lr7LKiz2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41CAFC43336;
	Sat, 18 May 2024 18:07:01 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516132624.1536065-1-mic@digikod.net>
References: <20240516132624.1536065-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516132624.1536065-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc1
X-PR-Tracked-Commit-Id: 5bf9e57e634bd72a97b4b12c87186fc052a6a116
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fc0e7892c10734c1b7c613ef04836d57d4676d5
Message-Id: <171605562124.7011.7388227978468847976.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 18:07:01 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 15:26:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fc0e7892c10734c1b7c613ef04836d57d4676d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

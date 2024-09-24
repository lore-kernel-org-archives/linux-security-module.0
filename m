Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519611CA0;
	Tue, 24 Sep 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201042; cv=none; b=BB+KeXpjsZc6mSqTY1UE3Avs58TjhJDIfSpC1fiHjZkaXoe7j10GvjxvCa9sQ0Bya3gngG0T2U5sB+WBv3KQQvHnO9EhKhF4WCjrd2Dp5Qfcx+PfXGaIFozxeANxBt7XnTiIwX4R1I6qFP3LLVsVaRenDDCJfSkNjmBkNeWTwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201042; c=relaxed/simple;
	bh=5/nPlREvHUzYpTTa+3ZNMKPDSmSPZC7ZrLrtKQSYS3Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jN4xoZDEGdXCiz9Xpq9roJEkY6h6082fKTwVJ5a2yYAJ3Bk4cszlUqScl8Te3iAUklgJuCnfP0m9msDWWMoJoQuAOu20KNlEOpvGegir8ltfjzJHKdwPskWvQcA10jy0D0iiCxzO8OsNk+aX65CA+7KDmqdF9siOAskink86wSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDurPcXB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDurPcXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A56AC4CEC4;
	Tue, 24 Sep 2024 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201042;
	bh=5/nPlREvHUzYpTTa+3ZNMKPDSmSPZC7ZrLrtKQSYS3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EDurPcXBa8PoFxTLBCDQUkLBKNxwKTq+UV2/CMeG7uv2ZIDjGIeO6sa9NmX7Aoq7r
	 S+4uWAy2OGPK3pRb+FVbbqPvTc6QRjqmulO5pssctwuMcbkGJFFiUEjvL4vfqr6I9/
	 yKFlO9MAbz1K2A6VvO12JcWtUscx9DSHE8BsGkMRFRTPnRtoYaEBfOn1+PfhGtWV0s
	 aCZqGrRdwNN4lzJzmwWQXPxx57I7fWocP/CbGoMEDGN5QFMsHkKnct1jr67LUFiTJA
	 raM49YFVHAwav0WPt/nGAiDhJmtEIzRWL4Q0Kl1VcTp8+l2ZxEPLfXhqyo15Y6rKZ7
	 +0ytBaGE3ncEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE453806656;
	Tue, 24 Sep 2024 18:04:05 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240920
From: pr-tracker-bot@kernel.org
In-Reply-To: <f8a48215c742da6510f5c1898b4c8335@paul-moore.com>
References: <f8a48215c742da6510f5c1898b4c8335@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f8a48215c742da6510f5c1898b4c8335@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240920
X-PR-Tracked-Commit-Id: 8a23c9e1ba4642b60420e8caa75859883a509c24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f89722faa31466ff41aed21bdeb9cf34c2312858
Message-Id: <172720104434.4145686.8743447177162942095.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:04:04 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Sep 2024 05:11:53 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240920

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f89722faa31466ff41aed21bdeb9cf34c2312858

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

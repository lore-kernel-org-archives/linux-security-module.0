Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702227;
	b=WbKbJbA7DRDIznRZxraPMqqxgaaA/9i0Ygj0DVFpOe7NAziGcXW6EmLxlUm9htmJzerg
	 23eNOeJ6i46yFBVcJxCH2jXGLFG9WbrsVXuNDDr+vdTjBxzIec6gYqL/Y93w9RWmqoQ5F
	 hHwLg4t4IvM9iXJmMdCNmGLN2ndNqrXnS1nJlctXZA/6lXuawxS9xp0K8cteEmtkFePxg
	 DB0ah3z/DOBzgzeKRoAt+OJNFfgdbL2jaMSVPzpaInYFochk4V2AOnKBZac5WsqtCJIep
	 YxQa2/hk+IJAZWAnvysiNf6fW9wZswafW88GUCAjBygDRoQiImOcHLaaQ7dPuKE3YIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702227;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=xR9QF8epVyz48DXbG4uTkmMbyZauj/K/QDKvndkMpvU=;
	b=wGRrJyd88pb5ekw1ytZM8upxhZnb98jz8QjlL8VfFNx/tfheusrBAdegXCSDKfipgzXt
	 OP8qCiZ/6WMDsYqwB91/YzsjH0Nw56iZG8oWKx14EKJ1viX5LwFKjQSroyvMSliN3UiW0
	 iPy0N3uf7KUlN5NyGZQ6UYe042Vhu4L1O73e8mne1EiaokmT8fTRilTGxhn28aOQ13SeT
	 gBgK0gjb7/SRwseraKr237LO+xFF5oi+hceLqXgETxdth5ea01Apyek7xErFlnHReh6Td
	 AEWDPyZ3QsftoH2HUykBh//BeUWK8E6ijL25pbIMcI3t7/f/mYZDddK/WAGvJtnltow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT9HlCVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688C60A3809;
	Thu, 22 Oct 2026 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT9HlCVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB701F031E5;
	Thu, 22 Oct 2026 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702226;
	bh=xR9QF8epVyz48DXbG4uTkmMbyZauj/K/QDKvndkMpvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MT9HlCVnF2qPzODykuiSKH7twLQZ42cugb/AN3uYX0ckGk4+qJKMQCH4hV9YPMF32
	 iiEjT1queL7BOigscmz6RJbXC3+utvKXn99Yn/YTMMh62CYGsya104bHbzcLBzbJS5
	 vcpHM4vWwLPeBM8ibOvDKoB4JhsdP2LSzUkg63Y+sThGIALOMBc90qW7Ngi4Smn3Ky
	 LxE3XvDQNZYYYkDU7Ucy+l23jWo+iBIg3/GB25B4sRTXcvODYrjQLIApBCnsN3CDSF
	 XHCqObTJ48uT9FqINNb9PxncntTD1g6grWcKcq7p60y3RNFjViWPTaYgkete1dWLM8
	 sOvCCTxYCV06g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444CA3808222;
	Thu, 22 Oct 2026 20:50:26 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock update for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021162538.1852602-1-mic@digikod.net>
References: <20261021162538.1852602-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261021162538.1852602-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.4-rc1
X-PR-Tracked-Commit-Id: 3e271a27c46fd591d1011c7de5a644a41e2010f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3815f7d55ae18564f4eac57557479f8b3548af95
Message-Id: <179270222499.170280.1564019188097037574.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 20:50:24 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Haofeng Li <lihaofeng@kylinos.cn>, Paul Moore <paul@paul-moore.com>, Tingmao Wang <m@maowtm.org>, Wang Yan <wangyan01@kylinos.cn>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, llvm@lists.linux.dev
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 18:25:38 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3815f7d55ae18564f4eac57557479f8b3548af95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

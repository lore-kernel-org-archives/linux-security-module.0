Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564127;
	b=Rjxb/pMCPv+dQ3XnOU2D5H02L/1VmYagaQjuKnyATDIT9cjJF/6/tvNQ0uLeU7PYSYAk
	 tjMsMYOi3VhD9nyk86RihcbcV/bsllommLK9LGYptKtYLzqEpH16W8y8UEP27WFxGOI32
	 EFcmShDcDh7mhKqMZb5bEfnXNAXbOLK3S1ZcSqDVsE+I3CpDN1NlFN9cnOxgcgCwl9wdQ
	 YslNqU+MIi59+Tn3SqNRseiynWqoYcczY9dSvpD/yy3DgHMN+7KQmG9rOIMllCyMefFSE
	 31LHe4FZBe0dq39Djus6pBeIzhguSWmgXsvmW6GmDn4MjXp0NYhyySLUYi+kbaAFjCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564127;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=zhcl44F2q+YC1jBusk8ASA+ZZJZmxgJh6uKA4yPjWdQ=;
	b=qwmziCuqH0EVqDU2OMfyG2ckOpYrMs8xSq7PP4n/12/PaU6yb9PhL9lnIh6EETH3IwSe
	 6VVxbuOgljnKveT2pNAublZ/XRBtBQ4WcrYui6ER6WYf9T1B0uhxc5Cx9Bo89MRJOn7ar
	 DG4PNmGU9PI6b2EXt/rrKu3ieC43l2VP+x3ymOCpGNrhpNe/4/ApdThZJvUKUPHAePOcu
	 N1T4OJnN0R4jZdaXMAVNwYnMbhtAf5PxDmLrnAYUA4AW2TlcITQ2TvZNpdQcN043/8IiM
	 P71Xsvt9glq6GzmsWLbN8IEa329Hdiq4f//J5TbUi4vwhsWmF8D9i3vCJVk0geBZ+fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpc7Jzsn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77920606A33B;
	Wed, 21 Oct 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpc7Jzsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D6D1F000CA;
	Wed, 21 Oct 2026 06:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792564127;
	bh=zhcl44F2q+YC1jBusk8ASA+ZZJZmxgJh6uKA4yPjWdQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gpc7Jzsnm+m9xZrYEhDzrLsS8SDLr2c7BzvPV1iyLcXWolt4Kue3vPQCNk2dMLIdZ
	 CPqm3mhlj8605ue6ebaFiI5U7qlzIep/H7B5DWH7LeADKMuT8OHd1+nAclb8W28pQY
	 V97EUTJp+nnfNS9pgSMlh3uyXGzWR8q+AU5RXDN/8aZyPAXfkddsgzkTxIDsRGpSd1
	 p23oJKy21q3parPweQRD04YVJzwCt1EceSoVjRRJ3CrLFKKNebzwq8f1/ApFWlW9Wk
	 INYIy/IKCIndvAuGHdjJZpXIv5bHSzdN960t4lmbHKg/aiGVDBPZzCj78ksLkW8MuX
	 JVXRiX/+H9Aag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F137D3809A24;
	Wed, 21 Oct 2026 06:28:46 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20261016
From: pr-tracker-bot@kernel.org
In-Reply-To: <bf59b601a40b9955ee8922c5593eeaf0@paul-moore.com>
References: <bf59b601a40b9955ee8922c5593eeaf0@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <bf59b601a40b9955ee8922c5593eeaf0@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20261016
X-PR-Tracked-Commit-Id: 881f19c2ffbc73f351b257e09c71e6059939b770
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 436485132d2367a50aa22dcc8a89faeee24a4cc9
Message-Id: <179256412556.425997.5570800738250093520.pr-tracker-bot@kernel.org>
Date: Wed, 21 Oct 2026 06:28:45 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 16 Oct 2026 23:00:10 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20261016

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/436485132d2367a50aa22dcc8a89faeee24a4cc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

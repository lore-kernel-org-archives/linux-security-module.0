Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4B2AF1D;
	Thu, 20 Aug 2026 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187380; cv=none; b=Cbvv0aEwfv5j3BkBCsfrYqU0qK1gI8YzC5Fa9tA6eapvXPKpvkufuP/SdBv2acC0ms5QuxetGxAsK2B+Hg+ITyDzgjTJ1abq4rszHt24VhuFNXn2xAgka0n/nlwEdQHhEG5Ye3myuQj6u0KQY4BK+Zx5NxpYTIYqw0qt/yjtM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187380; c=relaxed/simple;
	bh=Zb0U9wvjlTFLm/a0d85UTZGSl4pP4HapLMTux1vlKAY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r0hYqzjSock0vXHqW+cuXAj+Dc9xPpnz0uxiQBo2HY1o0GqkQvviQg/3EfT+403KltpBlCOYMDgZHMeL8XRNJaw6ZDxlY+9GMoNeoVeDI4hCgVIwR2IOCOq6F5BIpEIAZ3a6853wtRE81DUfTTXtBmwvgEI0YQDtZ6NyDnCdcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpOrmB+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpOrmB+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02BB1F000E9;
	Thu, 20 Aug 2026 00:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187379;
	bh=0j1cJGKHycAuKbRB2aaxjYW+r3MxyuYipd+w2bCCZvQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BpOrmB+4tEoQAFHEhqbH1Qlg+L5brydAFpB2rEanN/xIDnGV+vQgIesxrSpPvGmwh
	 xy1SU+kUsH92qwaC9Azpt6XhCq9a8IpjbPxCDqF6kpiqKOwUiZwtXdK8BJ9PLEy/G/
	 7J+riP1ugRRiSAscpsMjDwcif+tHpnfYGn9eqwsv/luji+J2++TVXL2l0uf5XmDCIS
	 GhQYczDsQSZm50uxqSTebuda3/GI/2qi42+2h+UXRkcwflrGJBXzp6jdHBWzuQzAvW
	 UkNIE960SAfm0qDEPlX8I+ErVMweq9VoX8J0KywP3Fow0PFdLAYvSlx8SbJWiTbUay
	 olrcJIc5m4fzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4C3811A50;
	Thu, 20 Aug 2026 00:55:31 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <d74aa9aa-ce21-47a6-8a5f-2d74ae74f768@schaufler-ca.com>
References: <d74aa9aa-ce21-47a6-8a5f-2d74ae74f768.ref@schaufler-ca.com> <d74aa9aa-ce21-47a6-8a5f-2d74ae74f768@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d74aa9aa-ce21-47a6-8a5f-2d74ae74f768@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-7.3
X-PR-Tracked-Commit-Id: fedc88e38ce979a720cd2de042578cb5df3dc8de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbad8981fa3b1fc726e6e5652e92fd76c01e543c
Message-Id: <178718733002.3758847.1597117887483702244.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 00:55:30 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Konstantin Andreev <andreev@swemel.ru>, Qingshuang Fu <fuqingshuang@kylinos.cn>, dmantipov@yandex.ru, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Aug 2026 13:33:22 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbad8981fa3b1fc726e6e5652e92fd76c01e543c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

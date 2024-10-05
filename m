Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472215B122;
	Sat,  5 Oct 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151664; cv=none; b=o4uXmS96FLgqfYOCQLmr7FuN7NKFnqE+X/zLZ2V6cehHh8qXSsJPUBcGpBEFGCImJ1zxlTa3QZ7u2fmZx29LcDXDqgLTykaKh8wtdoq1GHZB/TiaulnKBjEn44gssBs/XLInauGJ4UT6pC4QaQPVQbaERweUDji9r6xfOf3V7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151664; c=relaxed/simple;
	bh=cgvrRiIyXRWn3y2X9ogNli8tHIlNO81Q8D53LwFcQ1A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bpbJHKNvsJKqH6WbK2UsqR5tf72SXMyyOITO0HiBcu9vFbxqnrBMjJXP3j/Jrd1DfTw8Hv0RvN3L4uZ0AymYizDRK3LyieRZkKhQYkRSY26hrwcCPpHE2D/Hlb8WFjrWEfyDg+QplEBzaqtp4fY0390m3nKVgdvNBdpH2hOy5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4SBtKKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4SBtKKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA56DC4CEC7;
	Sat,  5 Oct 2024 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151664;
	bh=cgvrRiIyXRWn3y2X9ogNli8tHIlNO81Q8D53LwFcQ1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g4SBtKKr0lgpzlicY+CkX9T4ufRRaamBbb+quMqrMP1CFJv174v6poH6qz92mSFAL
	 3axplMuq1SwgF9JfT9e0iqP+SGOtopc8rCG/xkT644JysT5je7gnxiTtSx2mdrStB7
	 5R8liHthvfTe5Kdqv5MiMd02ljK+NwCXnO8etEY7RgNBciBWRgdU7oQ3jHU5/nDn53
	 Zrm0S/CdNxzRPYJL+pyPh7o8SM5R50V4quJylleeXPAZdSbVIqP+UGenNRzEHyZfRg
	 26VQerKwpbEGbheD9MWTt3WQeqDYxSliXxDXOKW8WbOxsO5YIoeSHmy9UCtL1QZIz0
	 bWuwGboUzXIOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF003806656;
	Sat,  5 Oct 2024 18:07:48 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20241004
From: pr-tracker-bot@kernel.org
In-Reply-To: <a68d32deab61b1c4b1be66e5346ef547@paul-moore.com>
References: <a68d32deab61b1c4b1be66e5346ef547@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <a68d32deab61b1c4b1be66e5346ef547@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20241004
X-PR-Tracked-Commit-Id: c5e3cdbf2afedef77b64229fd0aed693abf0a0c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb9b76749adb28d4cee88b296a9b21d834484541
Message-Id: <172815166749.3145223.4875122821035494198.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 18:07:47 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 04 Oct 2024 13:04:21 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20241004

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb9b76749adb28d4cee88b296a9b21d834484541

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

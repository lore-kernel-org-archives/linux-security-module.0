Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1E3C1F31;
	Sat, 22 Aug 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787415561; cv=none; b=UlY6X3LTH4wuWE3mFtwREJ7qPDYODNfox4jKEx4J+DIfAlxMLJ/FZcDMwF6OMFtRpo+REqCQvlEwwVzvlkCwV62FHvfgtZkFZw75B3QXxqP/NgtCdFkrTR/Jt7PCW8Y+3dZVk2Ng2W86WZzHz7bY47P7nqz9202lfTpSD7trFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787415561; c=relaxed/simple;
	bh=AzQxlzq3vE6O/G5Rc1kbC6o+QLrJBbd3dXo+e27h96Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mu1C4jvLUv+86smo6zhwP1QgLMVD+Zpe4cxXVYeHzN+Upk0nzihkIqWg4QchI/7vUovgb4k3YiKbR+M289asPnHKO6Op/A+PRLAQRMFBCxLtI2WswwXobjyKKis+mnYiwxCNXG7gukR9WYXF66ycVg+gHH9d3xJ7XPH4BFvhrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouySf+/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouySf+/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0DD1F000E9;
	Sat, 22 Aug 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787415559;
	bh=dJ9Wh15fGenfqNwbEAAB1J8KAA/VgPLla2Jgn5T4y6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ouySf+/f3m6KB0G7qMLKJeZOYq2HneQn3kAAmrvnGHt0GFJy0nWxxCi5+HRABPPI+
	 /BE50ieWMhOLieevlJxYFO206RGoF4r0sJV5aX/cjxN1IHc3vIgSTGw88cqRnm6oJT
	 4gmv0aWBQt7PNb9cfWfXx0VjMS9urX3ER3+tKpxlCNMXWloDIyOdfxBgiJ1RvLkFXc
	 uvKa6doD+dAc4nbPpd2oUltPmwj9r/zO36cBrPobjqbt5XkT9CFRgXY+XQ5y/jiw67
	 cSAuEJT45Rvpx/u+5K9xOg+EcZihCUlzgeNmSQHmEXkSTn1fw4Wpdgd7hkh7GeWskg
	 8z7fN+G9Y1kiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D6380CEF8;
	Sat, 22 Aug 2026 16:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] capabilities update for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
References: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20260820
X-PR-Tracked-Commit-Id: 9b0ee13b80798feb0e6a83a6d69e915f23fcb6bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66fb95a521110da673090294561844c9f76ebe64
Message-Id: <178741550760.1761060.7467957102486851677.pr-tracker-bot@kernel.org>
Date: Sat, 22 Aug 2026 16:18:27 +0000
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Aug 2026 09:50:03 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20260820

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66fb95a521110da673090294561844c9f76ebe64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA803187554;
	Wed, 22 Jan 2025 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737519323; cv=none; b=mqrxQ2ST0r2Pqut3VBnqLTuXAYAFP7ephZcfydrdgXpayCgkKropBuauWyXU2gFuD0WmLxWS0qpAZ4Q9rIin4i+nnlItcGqxN0cMn1ohj0amzAYSb1T43ZkGsMnXyk+/9momprUBb/6ZTc/2JQ2DLeLr+YELJVZNb3lTvs7I3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737519323; c=relaxed/simple;
	bh=z76ur0yJlo9O0/HLfdJ7UuIyJhgZlH/ogmYw6H9CRSw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NKScL4Inhxbn6+AjKp/oI/De6+SO/XVcUc5p/uuSrrlnwQK5jQtyQ9fMOgAqf/CUFdHLw3TVGPWRX2YN8TG7f8CzeAf0lgl/Mc8YeBmKgokbAkxZkn5/oAeoVBwmqovL1T60P+PoqMZvE5f3i1kk+SzvD2OiOA2EHqWf0gmN1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp8f9fIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp8f9fIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8C2C4CED6;
	Wed, 22 Jan 2025 04:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737519323;
	bh=z76ur0yJlo9O0/HLfdJ7UuIyJhgZlH/ogmYw6H9CRSw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rp8f9fIepsAOLcy+7uRdiOTwoHdQs+LlRY92RKbb8qrz8FeokSC2ZdkiguiOSi/El
	 JHYJsWncSQEaaz5UjmP1ezn3JAI6g3DE7jRnhq1yKH3Y5/FQd3QSdjIEbkgSUMdAuj
	 sBUvFrEpsDvUtz/AaN9x0KHu+ePiviTvkf/usesG18jRUQ9szysiykqmzDaUkCVits
	 yTTAFR381kpKuMDnFD22X2PFJdGwahEnrMwBDV0p5CRcwMe8FNlYOBlJJyJNKuGJmM
	 V2/ZpGxOh+9nPMYMYoI9eNS/03P+dZ4QXJpyBoCxNdGqmV2I8TRwyxiTRIciLOhK2O
	 /cRGtQxnRPDHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE526380AA6B;
	Wed, 22 Jan 2025 04:15:48 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20250121
From: pr-tracker-bot@kernel.org
In-Reply-To: <da749e8ed1a18e2b14d9337a78749b15@paul-moore.com>
References: <da749e8ed1a18e2b14d9337a78749b15@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <da749e8ed1a18e2b14d9337a78749b15@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250121
X-PR-Tracked-Commit-Id: 714d87c90a766e6917f7d69f618b864d350f09d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f96a974170b749e3a56844e25b31d46a7233b6f6
Message-Id: <173751934722.229101.7526819708900609037.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 04:15:47 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 18:40:10 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f96a974170b749e3a56844e25b31d46a7233b6f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

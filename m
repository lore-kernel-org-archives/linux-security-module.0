Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDC227B94;
	Wed, 17 Jun 2026 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697564; cv=none; b=ekSgyn4YwfhO7p7zi2Tm2uJInH1+LN7Rqx4bEE71Lp7fTsiWzkn/oDc/gnZHIlv5F55ziBmzPjpve5PakB+PJQxNZgTazKL5seuqcgaYX73JA7Q4jTETIKBdOXL0kl+Fc+jGm+ABGjghNWpyN3gT0zAcPxbQ0vKGKyBavNBasfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697564; c=relaxed/simple;
	bh=EPzBjPWg3FWeQPtw9ssRg2b+03R5YKi1iKD8DYBgMjk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IqQD5/HfFUUPZIE/NTlBeMS7gqzoJG1WOS6pLwU9vr1GKGFo1MLKXODzLXmINLj911s6YQrDzlPa6qI+lTlPaRzENUlZpDjA+x7rY0Chm0jiF/5vytbuU3n+Oe3a4Yo/XL7bhg0CmTVE8cupsN5dkWiBYGx/f0WB4HoQ9sq5Fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DycK3ng6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DycK3ng6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F201F00A3D;
	Wed, 17 Jun 2026 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697563;
	bh=PkrnqLhiYAGZxO5YNzApT1dwcqvECqvyIFYIqWCNZtE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DycK3ng6UHUTkeprp3AbjTKBWiR1AOwF0CZ5jOQmnFG7mIKpuCtcI97NwkjRLzX5e
	 wlOI9nUqUaxdBFz01QTDa0jDpCwDBxBCvp4pWGcVqK1FueTXQo7PQ2V5BF3VtdRe//
	 YORi8STauwYLVgBv/q0WNBKZb2vm5h4/SxGoX5pAMcOIRcE0qrEkRmQdHXR02PkUj7
	 63gerl/A2yj1F/dIbcHCBCk3fKo6CAyuOW5YQ1TSUfuMqSgL7JCLmx6YJtH/LgNO+g
	 1IQx8/66WevC4Th9MheSy5rU4LLo9kGtv2BRb5lFOQZBVnZ6dkPPg0fXPtU58TEZpd
	 KK+vfVLavBKig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C63930E10;
	Wed, 17 Jun 2026 11:59:19 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20260615
From: pr-tracker-bot@kernel.org
In-Reply-To: <9b359189953cc739f62fc94af4c24a27@paul-moore.com>
References: <9b359189953cc739f62fc94af4c24a27@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9b359189953cc739f62fc94af4c24a27@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260615
X-PR-Tracked-Commit-Id: f71ece9712b7712df98871eea9aeb60e49ca5239
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87599bd29856ea7bfdd62591c581c8be5a4719ee
Message-Id: <178169755776.1583338.16559481816471007732.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 11:59:17 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 22:55:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260615

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87599bd29856ea7bfdd62591c581c8be5a4719ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

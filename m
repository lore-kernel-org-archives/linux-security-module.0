Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C77441A;
	Tue, 16 Jul 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167162; cv=none; b=oajHaEYNfRC9RDCOAhgfCJyYoKmGCq0mEri6Ct6+Bql/ii84clRJG/BzfZCuY+r51hiRzVQrYy5qAr/tG6y/bQXE+wZNZB8/kVe/XN1bCHAqlSdFFRIa+7NEZNxiI8q85m3OJSiLWugq+CyxJml4c8d/+bNrOedEkd5rM4MWXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167162; c=relaxed/simple;
	bh=YMEHl4zngq8HmFPthhLb+fZa8ONs+/B1N0NY8iN4MIc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I54jNtV2AtZM3tP0MTHArwM7czaOfRFQSkYwMntSuJGkVFqkAy0JslzQ4nc3oamU6hoVmuX/MR3w3yUmbrkA+Bj5NchphRp1WbCoJXYQrWg/Hmc2Q8jaD7xknWVsCCrOxNgMfVhRDwIm64QmhM4vVBWKjQuiRqENCxaU6ZjGO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fbw6zYE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fbw6zYE0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D250AC4AF09;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721167161;
	bh=YMEHl4zngq8HmFPthhLb+fZa8ONs+/B1N0NY8iN4MIc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fbw6zYE0LIXwIiXNVdK5FT3pq3LpMdfTh0MNYBquY4M0KyqMAbLU0HFKgHZIWz82r
	 vxIzZHTaXekmlwwbuqL5KnwuZIe7joD16tAQ3tbD/qWY0IHP8c64B9vp5gdPabHBVi
	 VVj2mczGRUxFehjkhfovsWzl8cs3/UwjP2A6GN4Tf/+Mb2cCCel1l9eEp+BdkDB2Q5
	 vzplYiUW9VwO5hl+NyVezLtybfGhOFsuTgIYzXosb1/oVxtYPCEb0pWZWhlf3cXzYs
	 J5NyTfMyA1noW2t29PF1AKdTaaerQ+CCHMKpjyoaQdbDiAcWSEMppCXX97KAHY95Z2
	 qjmP5hVLRdGsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6084C43443;
	Tue, 16 Jul 2024 21:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240715
From: pr-tracker-bot@kernel.org
In-Reply-To: <549ba0887cc2b0d606940b7d788f0367@paul-moore.com>
References: <549ba0887cc2b0d606940b7d788f0367@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <549ba0887cc2b0d606940b7d788f0367@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240715
X-PR-Tracked-Commit-Id: dd44477e7fa15ba3b100dfc67bf7cf083f3dccf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11ab4cd5ec3f5f531ca0cb3014b7c6869c4aea5d
Message-Id: <172116716180.1258.7806330766790305441.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:59:21 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:17:38 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240715

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11ab4cd5ec3f5f531ca0cb3014b7c6869c4aea5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

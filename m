Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DE1AC435;
	Tue, 24 Sep 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201047; cv=none; b=rtXSglmsS2aoGb8NxsEJWKIlmukasWNnM2kwAtPJbeGHn1FecfsRuAIYFq1AugXJRu4WDVbHx7kctLzhRTi9C5NfKnpcsLKkCXT4XPTlhsOJLcCzGsqZRh+w6sB0cGjYSB5vUsRKWld6EYiu8iSlqnJpFQ9cpXwL/LAmkmYJGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201047; c=relaxed/simple;
	bh=tpi1YZIR+0ynPX5PqoMF7Jmp4uoRb1VicISaH7zVH/k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZfIQmuHkjUQbPwF0OMPBRSwSJwRKprnwOQsVb8xjJ6i3d5kT20FAb2Zw8NPc8PLF0XKULnvAP+jcwH5GFgwdbtYKBAEBfNgVTTGEXC4xkNY9S2ZuQTXwlqAB9GXDn8txCA4YNRdzBZ9DaRQBJVIUpSGioxK4yJK6XeFxxhjhImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By4h211G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By4h211G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4305C4CECD;
	Tue, 24 Sep 2024 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201046;
	bh=tpi1YZIR+0ynPX5PqoMF7Jmp4uoRb1VicISaH7zVH/k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=By4h211GPh95jFuNLjjBrzBF2WcjQxFZwXmnZMpuIKIpesr6DALeX6V2XTo6z6Exk
	 FqcOUkgXmkDAqFL3cXtQ8zg0YJVXT8OfllJ0CF0ueOiT/3egyMt6IfISU5Tvj+jJVF
	 tKHtr66bUO9N4Bfoowf8fMu4nRSp3Q/WBuCg4T/1mh7vH2woqxoAf6b+EYYNymPHv5
	 vB/T2eLU9mINWXzJE2Fa1AC79ks32qKAdbrioyJNNnUajLLbUh5JojrVZEXzFXfwLl
	 9c2uMeYb2A+IIoeAhcF3C+TYwi26UVeqpY/SPfA3ktuLif8SPx0eZU21uAH13OVPVk
	 aYxdxIx+QpkPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4F3806656;
	Tue, 24 Sep 2024 18:04:10 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240923
From: pr-tracker-bot@kernel.org
In-Reply-To: <d46aba81e752a28ebf49ddc49fd1aed8@paul-moore.com>
References: <d46aba81e752a28ebf49ddc49fd1aed8@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d46aba81e752a28ebf49ddc49fd1aed8@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240923
X-PR-Tracked-Commit-Id: f89722faa31466ff41aed21bdeb9cf34c2312858
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c36498d06b9b00393c2f35edbf16b28194375fa
Message-Id: <172720104913.4145686.15729300414346819607.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:04:09 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 16:06:39 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240923

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c36498d06b9b00393c2f35edbf16b28194375fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

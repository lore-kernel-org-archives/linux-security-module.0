Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC763207;
	Wed,  3 Dec 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790547; cv=none; b=D4KR+6q7/WTtzq/Ho62xo0wlE+reY84/eTUqyUKrytFTwUQeoieYTlAumbSbJ6MliHQ1NJf5kFUJCOiLE9rP0uTB5CDdsdgN7n0MKzeqX3ET2o+bTrbGbXhZZpfREmc4ViqQytIUkpRxzUXqUDk/faKwVJEpk50FZuYS7RHnEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790547; c=relaxed/simple;
	bh=hhRGaE6pzGp8oo5VCBUdfdevRA/EholH6sM5qJx7q4w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mOcpb98ip+Wz1eQIH4qN5qRWtwVkIMYogpYGqyQ2UTa4oTpPNKBz2IkR5qBpWQyRHwpwOn/kQ6ZOBM3AGsi/pvlZuqfto9+HiPyNSzb4NCZ9HH358kCHbfkp+z2b6irsuquHH8jS6EeXlRw5UkaBN9ghhmZJKP3d2SSZmj3dm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNBkebpi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNBkebpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D36C4CEF5;
	Wed,  3 Dec 2025 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790547;
	bh=hhRGaE6pzGp8oo5VCBUdfdevRA/EholH6sM5qJx7q4w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hNBkebpidhcJmf7+xdmUGvnLECpOXZkmY3vsv0nW9praOyRtzNQi2loO+PIT7XH3w
	 0jI8rDlwqMy0PKR1r0XLGJe8KelWfZJ2LgZaoP1msvBQv6A17wWRS168Hozw7D3Oo5
	 C4wsAL+I9SDCy6uKHA7P0xulIFj+c29mZP6N9GA6hRvHj5dLgU8brfLTrD8VCEBPsz
	 sU+poWpmxAIHXCFCD9UAh7qRp8TCx0MiErcRQKh/uqRrO62wr9h9zTd/+4npZvLIEQ
	 EPYXKz+aE1O7DwfuqRJUWIYwLCO2J6/ojKJYFsdtOAGiLIGQB4GNNWc6BoDqwmFIIN
	 8gDvYe1u25B8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A283AA943C;
	Wed,  3 Dec 2025 19:32:46 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkEcKAnhdmHb24A2BGGckhjBJANb6XruAmo9L0CBjUMKzA@mail.gmail.com>
References: <CAKtyLkEcKAnhdmHb24A2BGGckhjBJANb6XruAmo9L0CBjUMKzA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkEcKAnhdmHb24A2BGGckhjBJANb6XruAmo9L0CBjUMKzA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20251202
X-PR-Tracked-Commit-Id: d7ba853c0e47d57805181f5269ba250270d2adde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8321831480d80af01ce001bd6626fc130fd13b1
Message-Id: <176479036558.47894.4024212998800969482.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:45 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Dec 2025 20:01:24 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20251202

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8321831480d80af01ce001bd6626fc130fd13b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

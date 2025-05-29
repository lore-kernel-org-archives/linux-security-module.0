Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4363122DA03;
	Thu, 29 May 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536818; cv=none; b=LHSDEBq+S/jtkxhKpF5cCpNqKZjbgri99lypoxHAJ9zSk0fYYiarZJ65Q9djhLiJcsUFyB8S1JIIHTQvRycnKC8y0P3zjp3WFKans+MgpsYTIPTz4rJaWBX3Dff4byuz/GhYybQuH5Mc0dHAlgMfaNu1jjHbJx8JrQaDtBxNj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536818; c=relaxed/simple;
	bh=6chq+lX6qZWflnERPiCbUrYfcwo0htm8oqX58QWFBMc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KznVLUqGX1IXr52c5aJUbyb5zW71QyExg4yaVO2bUpWugR36W4Y9A51JfO4oxkkbpz8eegpKh8ECjrdSXDOR90ygDQnmRBAm2iMjoz86umNrAP3QFr55Xdmii++9j06wckqo7JLGmlZVP67vQ5eaCJEd6Ok+BsNQOq63/Xdp2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDLLFXNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDLLFXNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D35C4CEEE;
	Thu, 29 May 2025 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748536818;
	bh=6chq+lX6qZWflnERPiCbUrYfcwo0htm8oqX58QWFBMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dDLLFXNsn1W5ookAp+9Jgiwqk/WxqIfLBZvZQCueOfXFSDQvXFM77OXuzPqOuqZkl
	 QrAsc38OJyUm+/J47XdweRKoP6nxDcnUCAjuelFlx4hBZv/EfGoRNiLfiPm9ZchoL+
	 +ZBSxZrCgxOplFw/4vjXvtdCOmKNvinoX0YyZ0VD35jnRUPYt6bF+YKF35wTTQduqu
	 a4YE+XXSXbnUfyndH9a9hA7+4ViA8fovAb2KHEb6EVR2rr5PTQNAQA+edNexGw5S7y
	 OuBlkRbpSd/vHpjdGfyzyWY/W6rsNB20V1LfUTPIah94O04P5Vb90CIkceymo7Z0YB
	 Da5JvajUZ3sbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1CF98380AAFB;
	Thu, 29 May 2025 16:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkHcU8EGFjYp7fDV8tFqDE6VgQ_q4KQO+1Yy4SYYmveGWw@mail.gmail.com>
References: <CAKtyLkHcU8EGFjYp7fDV8tFqDE6VgQ_q4KQO+1Yy4SYYmveGWw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkHcU8EGFjYp7fDV8tFqDE6VgQ_q4KQO+1Yy4SYYmveGWw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20250527
X-PR-Tracked-Commit-Id: 1d887d6f810dbf908da9709393c95ae1a649d587
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12e9b9e5223b0e6e259b84bda216a54c8bfee200
Message-Id: <174853685183.3320073.5378167779153700945.pr-tracker-bot@kernel.org>
Date: Thu, 29 May 2025 16:40:51 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 18:41:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20250527

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12e9b9e5223b0e6e259b84bda216a54c8bfee200

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

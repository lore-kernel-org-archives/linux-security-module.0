Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78F25C818;
	Wed, 15 Apr 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292673; cv=none; b=byLoxnEi2WnsQG2Wf9ppzByWiuwFQ9ONpKEW/qZYjd1arBBg/EnAcXY7qFTd17GsSgW+MuN8z54uW4Eq0gAjKUshWJ2iveU/fGg920WxSw+VRGpNTTHvgvNllevCWwFKkY2LZyRvn7h9/NcEha5f31QK7gMZHZ25xsNMEI/EPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292673; c=relaxed/simple;
	bh=1Bk7Ickj96LZOadfAUMERC1G3WO4Gv4zHdA0l6EZmFQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TYMJNd4KQ8J0qXKTEtfuBaJ93XlRhXJNqXLMjcVjoq592tk2wLzrEwevrkULNuW+gCBk1zhLe4gcsHuViM+aSazjsMLDEMjWJZ+w6QP8RHuxe23KykJM2U/JsiXn+aLtkgfLkvT3CHdb2QjDGrP7eRjcwpYJg05EqG4eRvsSRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6MA0QM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6MA0QM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC79C19424;
	Wed, 15 Apr 2026 22:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776292673;
	bh=1Bk7Ickj96LZOadfAUMERC1G3WO4Gv4zHdA0l6EZmFQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X6MA0QM3SqLzI7XXY7QITEP3rSG3DSuCzBQ/YqDzFeGovH3epd1ls6bcqCTksbZjA
	 PJCnNNcJKIi2mNKzZO+LfJm7GRHB5IQx9I7OjHXG01lC+NCt5i6vYUq2qrHZN/cqWz
	 guIgEePd5//tDtBjw2gKTzAifjq2JFsSEvu55r/1n+FZOUKX2Muy0S35j2PjLj/C8l
	 DPMJpj+IreZaM6jfM7au4wNBFxKFeBAG0v6dsSpFCkqxDzuHvDRu2k9KimW8zrQpWO
	 9MIRtamOCud7FGt2x3i1cdV2w086Z/+hdkCe6B8ICV7Yk6sjG/LnjwiDRfb20GQw+Q
	 5Lca0puwj2O0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2BD380A963;
	Wed, 15 Apr 2026 22:37:23 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkHLk0o+fqLOjf2F9_ixkcgjW6rDpARQs0H7GPn+OJ2c4g@mail.gmail.com>
References: <CAKtyLkHLk0o+fqLOjf2F9_ixkcgjW6rDpARQs0H7GPn+OJ2c4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkHLk0o+fqLOjf2F9_ixkcgjW6rDpARQs0H7GPn+OJ2c4g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20260413
X-PR-Tracked-Commit-Id: d46515ec0b1d4ae07f8f437515c43cfb6eb61ffa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8801e23b5b0dcf7d9c2291cc0901628dc1006145
Message-Id: <177629264229.2482053.10064170195971281823.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:37:22 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 16:11:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20260413

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8801e23b5b0dcf7d9c2291cc0901628dc1006145

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

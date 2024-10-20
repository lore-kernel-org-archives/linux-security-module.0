Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B324C96;
	Sun, 20 Oct 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729385944; cv=none; b=utLtVqGdzHn8UcWsFDfI8iXXan70khJxLnVz2vHUN9xiSdIiDOllNvQPwgRYwtTTaEQ/NPksmwCjV4X61hOIYBJl0Hl90Bl5YswpdNrSsgcGOuHw5ML4sNlVjGtGueGYdiGnkqQL/0fvmW1qrBpEQrvy358IQhIvls56Lj1wDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729385944; c=relaxed/simple;
	bh=SCiRfPMPDO7z0ct7hKQrkER6PczziTfE5okVIJZYPqs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SsQFizjszUEKyovgQRrrjO12nQ1QHiQj+Xzd3mekHeP6WkYbCMsT2mBWgqvqab0WEKNqHvkTJ890xwVdFG9PH9dXkg5SgzjslZo+VOyQv0ZNJ4Cuy9WjeIBygi75AQ500IRXcB0IWPu3yk4sCrd1Idg41ukma4tsFiTg15f5RM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osAPqucS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osAPqucS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9A9C4CEC5;
	Sun, 20 Oct 2024 00:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729385944;
	bh=SCiRfPMPDO7z0ct7hKQrkER6PczziTfE5okVIJZYPqs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=osAPqucSJmqcU+h/JcjwcxU5iP+Ff21Jx2WPuM4O+3WeV8TPzQ9mOa+ArdRK938Wi
	 BnGlU6voHdYZo7mdaQS3zi7rXxNcNNgz89ZRSziJRYg1EFZ2PjA0hcRrZBkghPVIHm
	 XrXhtPw1BOQIBsYVBK3yEbBWjhVRmv0uyztB+U3YV3PbN7gpw2Bp32ThiFZ7LSFM++
	 wUUpDCIU+4m0Zo5+IY/6ICk3luGvj99PcCRnhSFAHVEb3Jxjkb/QD0fWS9slvVQPvQ
	 36G4wmumnImB6aFgti+5IsvNOqo4kmnbqBJxdD6dl53hxQoH9e7CwoEbb4oEf+zpGV
	 7ALJIZK9fIhUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFF3805CC0;
	Sun, 20 Oct 2024 00:59:11 +0000 (UTC)
Subject: Re: [GIT PULL] IPE fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cbe8cfae-e700-4c2a-849e-b7b457130608@kernel.org>
References: <cbe8cfae-e700-4c2a-849e-b7b457130608@kernel.org>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <cbe8cfae-e700-4c2a-849e-b7b457130608@kernel.org>
X-PR-Tracked-Remote: https://github.com/systemd/systemd/commit/394c61416c19bcc3231d3f717b72ef9d90b89ee7 refs/heads/master
X-PR-Tracked-Commit-Id: 917a15c37d371bc40b5ad13df366e29bd49c04a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8203ca380913af8d807f82089ec623e117955c85
Message-Id: <172938594981.3503243.4050091298704805814.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 00:59:09 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, bluca@debian.org, paul@paul-moore.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 14:26:01 -0700:

> https://github.com/systemd/systemd/commit/394c61416c19bcc3231d3f717b72ef9d90b89ee7 refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8203ca380913af8d807f82089ec623e117955c85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

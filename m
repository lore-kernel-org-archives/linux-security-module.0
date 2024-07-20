Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FDF149001;
	Sat, 20 Jul 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721504129; cv=none; b=fphYu1BCRBbPMlFKdM1o9kV45p4myQpgCbkyQkzmMmJircENpGvCZRt6mV/begpT4tGxZs5rFPk/A4mLGioXRCKXvTcKvxQrLRm7X3u6yea7dHTRIQI+gc4atAL3eKmvFWK5tBZY3WawGCxvYt+AvI9Hk+CC83de/PduTDWW01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721504129; c=relaxed/simple;
	bh=inGE0E8pI54um5RDinXbpz/QHXRakqS/tmlslqO4Jkg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aUTD5dJFdL2Fk7/KLXIzjLozkuBQmyeSXB9guqNyw2qiYEmz6pFVpY7SkS2cu0npYbEHaunhqNnEqCRsIwrjsEXPaISVRWd4Vlq5cxe+Db0zYRXA9D/3PCc7xBdtCVSvdaLkbkdBBKVaOzSP7KF78KGdu8il0FWRargbE/WKNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtRTFfry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtRTFfry"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71698C4AF09;
	Sat, 20 Jul 2024 19:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721504129;
	bh=inGE0E8pI54um5RDinXbpz/QHXRakqS/tmlslqO4Jkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UtRTFfry1CgvQx5kvD4+4A1OqXTcynoG526SdEKWKGWDL6UCGE5HvAcbFjTFDOXY9
	 17wNLIcGWisBTe8bbDEPBGMIvIBg2Yqzt9Nggtqq5NJfkjy7Q+PLR63CVCKbrDjlzF
	 Cw/Y5fI+QRu/MwuJBK5QixG4ifFYgXjTyC7e+K3m5/3RLEmJrNeIMgLfpKC+CjjJdU
	 3RoPAwiKCiW9SoILgeC8+L+tyLuAcUjcc47oX0vdY+kp74XxFZ2k/YgZJnexTjQU85
	 F3XYpfIxjU2wuzFUthK5laMvVEuGadJB68M/lugYF6Yclx4Qj5K4/fur0JMkp4UzjP
	 Q7X9TZOclr1Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67E35C4332D;
	Sat, 20 Jul 2024 19:35:29 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240720090834.267835-1-mic@digikod.net>
References: <20240720090834.267835-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240720090834.267835-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.11-rc1
X-PR-Tracked-Commit-Id: f4b89d8ce5a835afa51404977ee7e3889c2b9722
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fa23750c6e591a6e095057ec07c81dddec0d72c
Message-Id: <172150412941.5535.16534870312674116828.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jul 2024 19:35:29 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jul 2024 11:08:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fa23750c6e591a6e095057ec07c81dddec0d72c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

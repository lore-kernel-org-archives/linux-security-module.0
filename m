Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5201C5D4D
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649275; cv=none; b=KL2kHKnMtl58hJDfgwqYH6NXvpUkdGPI07m13B+F2hi5rz//5Em5gaTcRvj1RzzzZdTs/ZiKHZ3W0ZOPmCcKEVtmxqbV2O3aLJH65pcENR69iXfPwqXuxwPUQ2JRgaB4h3s/b74qXfBwOezromDZ8Y+0xUMAGrG/8OfFDqZAwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649275; c=relaxed/simple;
	bh=jXKgQuhCAVQBSdxunQtEW4XNDSoNoLxCssg4BfJz16M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qa4QKzxZFOvPdBeIYcnrfOX7ZKICJ65GzTdR9NkOq405EnA+oSGdIK00WyLVI37/6KloV8n8wLSVKhCqLxdineSG1OJ282ulKYDPmb8eIjJv4o9w/z4NpD2XTWZr3rkdnlgkNjeI/YOJOUY7ASZoEpP8Jk/Hx7BwAwg7SdraOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mafCndTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mafCndTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46541C4CED3;
	Thu, 23 Jan 2025 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737649274;
	bh=jXKgQuhCAVQBSdxunQtEW4XNDSoNoLxCssg4BfJz16M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mafCndTV5FG/zDJ18/fz+ac4RDVpKTHOQnLh9W+k/idRyXFiEt6g37evX2vU7Udo3
	 lmX9jwEW1oHSpjqTJy3MFleRb9gwGq9KoGIbqInN+lLfxqvgmEsL7VDt1MR0c/qvVP
	 rVzDClzxltcOdlEq3Q4Q7Tq46FbPGZluSCkS0nHxR2+14P+Ps6hzH8o8bRup+ats7Y
	 0RHYl2Jr2wojgQfM+XSmUZXEKlAQSfDrt1SeTVbfJHkUH1HV7NyVR6b+8f/UH/F9mQ
	 4HfTbchq5XG60TaFyJGHf5KZBYjQVFQsE+DkOMtA3XmQyN+G28VO9Rw9cLIc+r7ZkT
	 v0wvE5g6LJb+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341E2380AA79;
	Thu, 23 Jan 2025 16:21:40 +0000 (UTC)
Subject: Re: [GIT PULL] capabilities changes for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250120215944.GA16878@mail.hallyn.com>
References: <20250120215944.GA16878@mail.hallyn.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250120215944.GA16878@mail.hallyn.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-6.13-rc1
X-PR-Tracked-Commit-Id: d48da4d5ed7b4a022a4e54f210575baac71f58af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 754916d4a2b970bc1b5104d552b5d16ab54954c0
Message-Id: <173764929871.1408734.7298333533526522904.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jan 2025 16:21:38 +0000
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Jordan Rome <linux@jordanrome.com>, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 15:59:44 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/754916d4a2b970bc1b5104d552b5d16ab54954c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

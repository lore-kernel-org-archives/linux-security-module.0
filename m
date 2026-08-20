Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C25695;
	Thu, 20 Aug 2026 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187384; cv=none; b=aYXijTke2guIzZorRQm1RtLfglYul9cQ9oFLLpEdjCBD03N3rnw2HLNS+zAo/ZjaEwNnkcRNgrvqGW6ZciO/PLNeAq6L2IW181JIMbmOJK57ZCUTnqOY8s9GHGpzw6IHAv1OcGb1Z2ZeTC1nTG0ImS/sLEGJjE2+yH4vkmsN+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187384; c=relaxed/simple;
	bh=Ag6cMfXErxk2NeGLnP9edeRCQec3/EN7JtHK/LZbb/s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s85fFzW94wR0FKeXyCVHKIgAfWQ+Nm58i/ORYjKTEy65M2VZwT2TQmx4Q9LTyGQbuurdohHhVt0IiUagdE4hv1wXpgaXQDRyGwW9C0WUEPkjouX+0j11PvoeCPjIAuIHnzrzXE/Xb7hma4ATKBj6cG7Ypfw8M2Rim1gk8lBX2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFRahcix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFRahcix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643E91F000E9;
	Thu, 20 Aug 2026 00:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787187383;
	bh=9c7EDVew+ZwOB+wdRwx3Vdabdh4ZkFAKsw6aq+7KuU4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TFRahcixjRGQg9Dq/R8nHKS5AtLs9S09QeM8Bz6ufoTK5tL//2wy7Q5554g5JD9LR
	 57Y8pxiF1f0kNHxHfcymZkh5y0WmZzWscE8tQRwvVPQXxTBrn3UC1r4/kilZnR0LZo
	 ubHuxNGjNlnE/EEkmdZ5vUQrKrkMnd/VcVm3wurOH0JWVnvdQIb35eAzxWIH/ynW5P
	 WflQpLZf01Rxwm3WowXCq0bwtH+FtNobFBcS8kp4pe4XfpimK3OMnrqc3jhOEg++NS
	 BgeZqm0Ms9OTXIktgdH0/8ukfpFSewZYpdklylFKFsK9oVNdX4GSNhuyZqxj1r3kAW
	 h7Zx1ZFExry/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C03811A50;
	Thu, 20 Aug 2026 00:55:35 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20260814
From: pr-tracker-bot@kernel.org
In-Reply-To: <4f24201cc573e07319bbc8b3e96e6abf@paul-moore.com>
References: <4f24201cc573e07319bbc8b3e96e6abf@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4f24201cc573e07319bbc8b3e96e6abf@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260814
X-PR-Tracked-Commit-Id: 0cee720cfd51402cfcb14d96cb326a36c13b823a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09005a63988521f74111fae344aecb3f63306168
Message-Id: <178718733389.3758847.5684588269792631733.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 00:55:33 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 19:16:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20260814

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09005a63988521f74111fae344aecb3f63306168

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

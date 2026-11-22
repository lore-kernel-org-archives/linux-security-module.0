Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311163;
	b=fpxQ5akagR+7sYEcR2V4kKx8FDU935jvXSqklAtt5KGmOffANAdIjhtaYC7L5J6NxP6f
	 U49cNYRDT88QrojpD2cyiR0f//lCESpe6E4l/nd0NDF8011d9OCUWswjfYl+KrQoxX1K2
	 CBRy6D2H0x6dWV6KigmCmcWT5qJS6bao9qI1abLUE9Rs9hMWlUuSK9PWXGK4rr+vRV6vV
	 OlfP+KAdrOvuzv4FoHdmbg8t1NfmmQyBlTuX026CYN8rlLH0NP6L5+YdkrYgd6BK6rKDk
	 WS0PD+Tg7W0KsMHoBHE/hkEtuBv1j0S8jFnxU3F5UdBjOpDajUUUtvjreK0Wvj2acSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311163;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=IBKP7szsNNWerLhl0vC1cmnlQU3wIdrNtJLpnfTeDMs=;
	b=V09omiQ4RBztBEsyIinObhVJoH8BucCR0N5QbJHVkuqb/XYb7T02fqYuWHseJDUmE9Rj
	 2XIkia/AUJ2lhqw0Xicr5ZgDp3XyvORHf3mPSpMEaAHrNKYG0WknDM+gUDKpmVf4AAoMp
	 yyNqnkUy52HZnwWqFFn1TxUs3HnwKFmSjAfDjhn5KIsypquW48KCPHOL9AWK0MjeqLKlS
	 0qlC8LFKq4K2njPSixFWzBE+ihhDTaT7D6988Cd/VPlthQbUnbOE2XAzjbHc4QQ0Qn2Lg
	 kepKVQwFb0Inau/lyFMt/wwcoMuVEbj7/+Wf+y3Zpaj4Ph+ggxEPg7JEY06dRpP5R6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctBMOAJD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBE606A320;
	Sun, 22 Nov 2026 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctBMOAJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428C1F000C4;
	Sun, 22 Nov 2026 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311163;
	bh=IBKP7szsNNWerLhl0vC1cmnlQU3wIdrNtJLpnfTeDMs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ctBMOAJD3EDAtwIJndZXk6m1P9CU5Oa5UMGWeZY2hSZtAUW1jwgTqXsvLW4IQpnTP
	 g52SmhnZ3lt5boqeeqR9fzKiw+ZXQFvkZM3iAy3h0GKCMLxKbawl2CO1REwiFjO4it
	 AmF0OTTFguvr1p4/T8aNXMpl5jPZ5iz3CelAKrqNlx3G3HZtk8isd3Sadk1X2REit+
	 djmDT6TMwYKm2CEpljZBD9fkF/ie1yoXDEUQi3syngGHIh/1k6z9WQzJh2+IR/TSfg
	 z84PwHMIDMCMYYhuaj5boFTCq72C8oNU4CzZTqkGReuBYM2UvUEAJv+Kdnl4kJaOVA
	 mOi/IAC7J+/Rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77580391B098;
	Sun, 22 Nov 2026 01:32:43 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fixes for v7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261121195404.2775730-1-mic@digikod.net>
References: <20261121195404.2775730-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261121195404.2775730-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.4-rc4
X-PR-Tracked-Commit-Id: 4feb6879b9ab42cacb905f27a44160b7f1f49d85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eef2bc5a82c25d25c3082f5d86d97a300caeb678
Message-Id: <179531116218.1248683.2656532663991692155.pr-tracker-bot@kernel.org>
Date: Sun, 22 Nov 2026 01:32:42 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Bart Van Assche <bvanassche@acm.org>, Dwi Siswanto <me@dw1.io>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Serge Hallyn <sergeh@kernel.org>, Tingmao Wang <m@maowtm.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 21 Nov 2026 20:54:04 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eef2bc5a82c25d25c3082f5d86d97a300caeb678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

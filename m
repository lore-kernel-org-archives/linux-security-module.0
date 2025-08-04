Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073B2CCC8;
	Mon,  4 Aug 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323510; cv=none; b=Lmp2BJEvwW7zAXJnxvnjTBEdiyjoYP9FAsIzjAlrTWkqFHQNmIiADaPRIlgzNjpV5tkHxMYLn44Ze36rzXbeqny+lXTPW+zue7i80qGRpYdlMjDq6yf4kq15L+Bu47scosiQFqe4nrCaVyGkYbqkMG0xsIadZ5z5dUosRzn8Ns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323510; c=relaxed/simple;
	bh=5yenjae057iORSAkj/Y8Z2B4vMqNiVeW33ZYsEDcPX8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tz1veWXeR1bFyCziitG8IIyTvDDhkYRKOOBV6wS5YVANYnXHuAz8Ud79Y21RsLVLaJxxaYNHIGGPxWEs9QIf/QJoKrSYH5s9Enpx8N5ZrETCkhHPeVlvnWbE6IuJJvOu2utAwmhKpmhMuYolFg84IlevnICNSadr8rDLZmxqUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuD2Kn8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuD2Kn8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A52C4CEF0;
	Mon,  4 Aug 2025 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754323510;
	bh=5yenjae057iORSAkj/Y8Z2B4vMqNiVeW33ZYsEDcPX8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IuD2Kn8rl3uvUf+1DUQLp3ytoUrLqi3ftr3Rw9ZcgIVuDDwkcwGsFxCSRQecA3hEQ
	 78COFO1oIbvLcMR+1ErBR08WIbIihUQrqP+XsSxWBI1tgfGspL7G4UCXXQOW5FyZU/
	 QQz6ofoLAuwQU15k0s4KjVNzObnyNYa4UNSAM+CqUk4UYu6clJlR5AlmmrpXjl2cDh
	 KcllKU3ZDMAZCuiEm2NoRFw5Y0BAclwRSdKKuRHRNAlWz4jMnd93WzK3kOs+WVnD0x
	 FIxe0r4BlQoTLhRU3uPFmszP/c+Olmlm+44LuQmx4EAmLsP4exX+vsTmJBMbUhYUmm
	 ILSA79goJyCcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34549383BF56;
	Mon,  4 Aug 2025 16:05:26 +0000 (UTC)
Subject: Re: [GIT PULL] AppArmor updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <8d0c22fd-330e-4c13-b9e3-32a927697667@canonical.com>
References: <8d0c22fd-330e-4c13-b9e3-32a927697667@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d0c22fd-330e-4c13-b9e3-32a927697667@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2025-08-04
X-PR-Tracked-Commit-Id: 5f49c2d1f422c660c726ac5e0499c66c901633c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b45c6c90af6702b2ad716e148b8bcd5231a8070
Message-Id: <175432352476.1247654.10196735182492006560.pr-tracker-bot@kernel.org>
Date: Mon, 04 Aug 2025 16:05:24 +0000
To: John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKLM <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 4 Aug 2025 05:11:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2025-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b45c6c90af6702b2ad716e148b8bcd5231a8070

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

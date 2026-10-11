Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8723EAAF;
	Sun, 11 Oct 2026 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744952; cv=none; b=XLSH93pnFGYKQKOAXxY8s+mAMHThBCfBFPmcXOfoLjoWgWzNCmepXbBphEpLLBD6B9rD8VAmssoQNLW7Xq+vjkZ+te76HOudGMHtRJWuwRm4npBQ99Z/biT+XH+y0TfIkCAtkqVcHe1qyvIkCLe6AN9X7++WyAXUJIkuuOPju6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744952; c=relaxed/simple;
	bh=MeNz6+JDbAELaclLPMD6m81PIVT1ibR1soSUJazcll8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HJBebIViutz3lWBLvGc8TP9yTWs2Z0yb+RoYxkRqMlYq47MBg7EKyuI9Zfy0iEkRi2kCQ1z+W00XLDcX6+tgPJ2sNaXetGXNzwK25db4FO18Bua6FEnkzkVKlI9GmkieUsnI4Qu4LqPt6UqC1vDeUM48RtpJwN+S00nbDdptmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl19GyM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl19GyM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A211F0089B;
	Sun, 11 Oct 2026 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791744950;
	bh=cze08nDY1Zme74NA0RyKNr5Uk1h502wJmXo708vIO9E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Pl19GyM5ClKuhiyDveUybfx0eaM64FaKXtbHYWQQrAzpzUStBFwLA3Qs9Zmt0B53m
	 ++PfkMEVEdYMQ6ihx4DHC+9y2l3yLr9u16lQdxDbpoS7A801lirqMyhvhJ4Sr8NVkv
	 3rPWSnIwFrTM+0eItiIbdKQCw2F/yVxUEVSdlDD40iY7BuDA4nmC7URoR6zIOzoWE8
	 2nA8jyDTSLIYlmE/eIyZklvB4jnlWhecKAiDM/blvsS8SNb10XPTw2OVtoYhIa0f8m
	 WTJvq5Lp9cZXadVq8gSxk7xBPtzsmQhHvcK2cXuARYhAEygBBHEpNtkDS6gf41HQhA
	 DCk3VlvcIcwFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A50038119DB;
	Sun, 11 Oct 2026 18:55:50 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261011160819.1376118-1-mic@digikod.net>
References: <20261011160819.1376118-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261011160819.1376118-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc7
X-PR-Tracked-Commit-Id: 3d8cc52db2f86b624308321c58513019f6b21eec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6d3455d8751854e0d1820f14184682e23ac4475
Message-Id: <179174494873.2141808.3385832411180590547.pr-tracker-bot@kernel.org>
Date: Sun, 11 Oct 2026 18:55:48 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Abel Vesa <abel.vesa@oss.qualcomm.com>, Alejandro Colomar <alx@kernel.org>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, Kees Cook <kees@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Mike Bommarito <michael.bommarito@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, Tingmao Wang <m@maowtm.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Oct 2026 18:08:19 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6d3455d8751854e0d1820f14184682e23ac4475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

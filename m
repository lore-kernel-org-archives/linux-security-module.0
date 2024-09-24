Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1C1ACDF9;
	Tue, 24 Sep 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201045; cv=none; b=rSpwYAszDCyMRjf2M0WSYOnatGdXBrd7bISqv9fRTjXUDvN56ac170Ve5yxlTlqzQ4xJU1vLyQALcEQGcx3zl1G5eA25/Umhs+ogOt6whmEyiOI8iSTXORx/X5gIq/wA0wuh8hnoO9dB7ZvDZCdUWQW1fcHG+EaBo9dc+sE+jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201045; c=relaxed/simple;
	bh=ZOKd2yre5cHdGfWT0XikzvYC1uwt4noY89tFw/b9l7I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BHXBqMmRGI0wUhjD1aP0LvKLl06F2UHU6T2IlMZ6wIniZuLDQC0v8/HT6mAm7Jb3k3Ix7VNyM239tmPmnBIDkz6s+wViAIuGasXMrJUHJwJ6jjt+Ff426p351ofMdqexlRND61p+//mjdQ1Nc48mI5y872c4pBS2G98Q9GpV5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amx49iyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amx49iyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5247DC4CED6;
	Tue, 24 Sep 2024 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201045;
	bh=ZOKd2yre5cHdGfWT0XikzvYC1uwt4noY89tFw/b9l7I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Amx49iyPX/Hs15U402DclMNVk5CqL/dFOD+sC0m/izmmEOaNDbZT7btMp2XMRxw7a
	 5kUOv084P2msuezTSzf59o+6TGNuEXQ10YrnwpJ5Pe0KXOOraBbkJhU3xZ/OPp4pv9
	 HjqAlXZ0VHLNFH+nUCuN3/mh2naz10bg0l3EEu+Jt1nB4makDTY84o44RfNhUvk8aa
	 L06RS3tGoR3lUVl5OyQCftNaEKpWhRKv5Y4hUbEDY8AvT32fWopgK1Pw29hTIsIA/T
	 XyfreIcTBJAO8/0tWPDDG8M/7HBsJIh5lsIcR36+vhaN0g2ieqEmCFO2W97yY2fpQa
	 YGhVmEgoUExoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2903806656;
	Tue, 24 Sep 2024 18:04:08 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923184251.153123-1-mic@digikod.net>
References: <20240923184251.153123-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240923184251.153123-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc1
X-PR-Tracked-Commit-Id: 1ca980815e1f284dddcb5e678c91bbd3e3f3a6a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1b061b444fb01c237838f0d8238653afe6a8094
Message-Id: <172720104756.4145686.7649698495456697922.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 18:04:07 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>, Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, outreachy@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 20:42:51 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1b061b444fb01c237838f0d8238653afe6a8094

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

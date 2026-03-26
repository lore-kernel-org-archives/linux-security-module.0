Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C53347BD4;
	Thu, 26 Mar 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554520; cv=none; b=YDtgoGWhjBPw/lOnqGYw3nYnrGd/u8xL504J9MY7ZOsn05m77BnkoBrrHfFaBl6hV1mXdrA52g/ba8qg1VO7WsMRGTyF4DB5LH9g+CYqu2lj9VCR0D8kln76acSredFPGmgC1sBJ696ALZtD8ovlRJPRZxicUGh6SBFv+WK/2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554520; c=relaxed/simple;
	bh=PA1rgUM9sWjksMzQSTbUm440CHQpMBc450Q20oBYMgo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dJfhCpmnzTImVZ84d1YhKSqfoP4lFInAlpvdE+Pk1geWMRJocFr7gdls+8KMoIjrJ9tEp/qMkEkMVQiNgnZiYtmfQdxi2yw4NrmCfh6IV2wXglF9Dcqn8C9kGmuWbZIvs9wpBZcPW4CNiGrXwGZljTvNLbztfksQ7PUcbpsWaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rERoNl2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rERoNl2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A5C116C6;
	Thu, 26 Mar 2026 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554520;
	bh=PA1rgUM9sWjksMzQSTbUm440CHQpMBc450Q20oBYMgo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rERoNl2Cj+sCXeOPTdZ0xSQOzx8NR500o+Urm8xro/uk79aCGEwCI45x7RkKoUGoZ
	 ftbe0PHpdTpJ8iLOeINBCWUxXudVIIsDS7t6h2ur2BZT6nUMkdkCUElXVqNpp8gL6O
	 UDwyUQ0N47OrAnufz7tRWCDU+0LolQR6qxcG3eT5/mLA1/SCzp3FDgMqYuy2+u1iS4
	 IYW/92ON99VFJCGeq/Q4uYfoWwLep8VI7Mae6u6NhNQ6cw8LHSIbo8G8i08cTNcPCj
	 3XcejMXEc9Tjq/UC1qhGX/ma48YuV0Y/WcKBQ83/XUNFpvgDuFFPsDnrFYxoooA8mK
	 FjPxGktH9pE6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA19B39F2038;
	Thu, 26 Mar 2026 19:48:27 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fix for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260326172727.119094-1-mic@digikod.net>
References: <20260326172727.119094-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260326172727.119094-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.0-rc6
X-PR-Tracked-Commit-Id: a23811061a553c70c42de0e811b2ec15b2d54157
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25b69ebe28c8e3f883b071e924b87d358db56047
Message-Id: <177455450635.3152977.8033712459408999510.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 19:48:26 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Dan Cojocaru <dan@dcdev.ro>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Panagiotis Ivory Vasilopoulos <git@n0toose.net>, Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Mar 2026 18:27:27 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25b69ebe28c8e3f883b071e924b87d358db56047

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

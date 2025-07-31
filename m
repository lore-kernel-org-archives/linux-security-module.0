Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F513D51E;
	Thu, 31 Jul 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984522; cv=none; b=cn3h/lh/Ka9GJUFsHh5kh5TP5WaAcWVwjEsQPh30enBsI9InvHFYSGTD93oTgpZfdrcx3S3gj2osNWcT8D9vV4QpJH/QQifaKrOyZvfr51gBEDcwveCxEyhcuX9kjF/ZMqJh6Sa7/6U+cr37zHpVm1Sn4WZsG7KFbOO7S0VERAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984522; c=relaxed/simple;
	bh=Y9KMDsKB6zsue2Y7W0t093kXzDHAWWfEQJt4SLq8lgU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=etIPCp+OMht6xg6ngEMDV/dunPsQ+KBAJDb/pAq2gZLnLSQuklmsesRh/dhnYugW4EFeZGDKNlE4CKF+xxU2gkuR0DxOJU9MgSByEVe3pfzwHT9bGdyZze6dZCD1g2F0prjcaGwhFKmQhxIkWlG5RC9x2eHQNAyndq00LeLp2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzLEqs3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzLEqs3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A1C4CEEF;
	Thu, 31 Jul 2025 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984521;
	bh=Y9KMDsKB6zsue2Y7W0t093kXzDHAWWfEQJt4SLq8lgU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fzLEqs3tIOB+i+r+GnOTvTvOsqBSMjHLWRD8wH5Fq+bMwR69mCXe5vuh3z9sxlF98
	 hjYZxBhufnUDBGztRTPWljAcyvV8+2W0mbOKz/nMeavWMvBsCWzMWQzZu5LcAEfvus
	 MBSUmKQZHRDYUqrAqVU00Ri+OWH/7g9YoG7EsCWNvSyGJhYEbOZ6+9mFZ7PV9A92KJ
	 TFGWLEe3Cx5WdQmeHcOrlCIE5/tn9m4oU2Kbg3cgtXZtgfplD0A7uiHe08X8bcM/Tk
	 RRe97bGt39z1XWDy06vIgNURUzlSx8c6UP8T9qp71Vf5uQsDW/7qJRnOElx08gtcI6
	 5bx/UEiP2hsKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2A383BF51;
	Thu, 31 Jul 2025 17:55:38 +0000 (UTC)
Subject: Re: [GIT PULL] IPE update for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKtyLkFWt6+5iKWy8BKJH2L51OpfPsEFkpjjn-EQGfHaSRnqAA@mail.gmail.com>
References: <CAKtyLkFWt6+5iKWy8BKJH2L51OpfPsEFkpjjn-EQGfHaSRnqAA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKtyLkFWt6+5iKWy8BKJH2L51OpfPsEFkpjjn-EQGfHaSRnqAA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20250728
X-PR-Tracked-Commit-Id: b90bb6dbf1d60d70969f8f8f2f30033f49711594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4efd62564e96d1edb99eb00dd0ff620dbd1afab
Message-Id: <175398453732.3232013.11176475462193839358.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 17:55:37 +0000
To: Fan Wu <wufan@kernel.org>
Cc: torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 19:15:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/wufan/ipe.git tags/ipe-pr-20250728

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4efd62564e96d1edb99eb00dd0ff620dbd1afab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

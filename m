Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ABD3E48C;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUEQCd0t"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC6FC43390;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704836413;
	bh=IHNMBTJLnOLcsaSRJo9rf5h/JMgIxGVpKVnn4+LbQN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gUEQCd0t0hh0Z2bGsoa1MH7cggyazbeXk3U6OpKEnmRe8QXeI2VeC0N1zp5ne6WjJ
	 5bOQOWvj4fJU6dUPYwxwRhruqWchg8xFVQVWps06BLXWRau3ylPOdJFTcN7s4SLct8
	 Y8egEZNkJcdEvpXCv4t5bYBOWm6hCC+BLPzNXQWzKHOENJt8OoiDYFbLywsFbwha1Y
	 gsCckUG5jsR5NCXqV+UtZcY3lWYBXiifwIk/5X5YA27wtu27mr6+cUn18BPHhfNzPJ
	 WpL9I17shkYl0MAogX3+ATaMWH1GC/Jqr0PId7SA3Nmz47NwWwqsxt+WSCCsrOHyeu
	 tH4WXUD2POo0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67AEBD8C970;
	Tue,  9 Jan 2024 21:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
From: pr-tracker-bot@kernel.org
In-Reply-To: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240105
X-PR-Tracked-Commit-Id: f1bb47a31dff6d4b34fb14e99850860ee74bb003
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 063a7ce32ddc2c4f2404b0dfd29e60e3dbcdffac
Message-Id: <170483641341.1854.5084742980147562281.pr-tracker-bot@kernel.org>
Date: Tue, 09 Jan 2024 21:40:13 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 05 Jan 2024 18:21:18 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20240105

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/063a7ce32ddc2c4f2404b0dfd29e60e3dbcdffac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

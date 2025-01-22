Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF5146A66;
	Wed, 22 Jan 2025 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737519322; cv=none; b=hvT5W2qb8rZYe+9909Ew4EOfVAFr5qXFpEAdKZnCuAs5KcaH/WSTX1w8ZCw+lIKrVEbeIhDZ2rMgV/XPsGUJnOXt5rE4eSLOA8qOyZcFgQkoGAcuRpV6RNmtAxp8vEUCLhPXvURXZbcBVPxffLQwH50Q2drK0t3CIp9cIGXWtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737519322; c=relaxed/simple;
	bh=5LY13j+z3bUPJfCkWAjOQFx2BoQ95jIU/jpXHFSTsKs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fnb3xRZAdRwxQlFUJFnBJh+yeTXr1j7UcjI7SGUa/lx+IZVaU2waDUvjVvD5EuSO+yKLR3NLvo7VYuyfkuNYARPWOD0PD6doYYtVxgwMZlkQyVJOLYUcPKcLPyFc+uOUHqSJ8mEb/d8raMar9lNUDtmQdObbSB9MrbmWd4T6Icg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js8RyBeH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js8RyBeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB4CC4CED6;
	Wed, 22 Jan 2025 04:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737519321;
	bh=5LY13j+z3bUPJfCkWAjOQFx2BoQ95jIU/jpXHFSTsKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=js8RyBeHjsJEKNv4ue3Kle/vconXxvUVqAEJz5uFR3zLF03atTb0j9dpauoRYNg/p
	 4nncV5oiNYGIDv5EjZ7tXJyZctqKzfEMYL7N4EvJWdlCOnSMw1AD6bk6npeXqwpSoW
	 fgpuN4zA3L7YbVtE4ndMuv9D7/Tz62eFpTpZqk3Ch/9E7dV8TcBjwSZHbYINeCn+V+
	 OPQJFhtMKyy8wVszAVZPHG9eYzbWRb1O6n/VKgBeW9ZhpRGKrZce3yg29QwCyLawlt
	 EcBKQb/y7eg4a3WxCkGLxgXJFCA47xM/cnmDJEn10pHOcMSJQgCZthv3i4/s/nwbrj
	 RD0Epw0pDOgQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE11380AA6B;
	Wed, 22 Jan 2025 04:15:46 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <e79d21e2-1491-491f-b46d-9bd814290771@schaufler-ca.com>
References: <e79d21e2-1491-491f-b46d-9bd814290771.ref@schaufler-ca.com> <e79d21e2-1491-491f-b46d-9bd814290771@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <e79d21e2-1491-491f-b46d-9bd814290771@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.14
X-PR-Tracked-Commit-Id: 6f71ad02aae83f7032255863e374acadaa852bea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 678ca9f78e40ec8ebbd054b0c22bd3b5ecc6c7e4
Message-Id: <173751934558.229101.8984079366136310583.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 04:15:45 +0000
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LSM List <linux-security-module@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Konstantin Andreev <andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 14:23:11 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/678ca9f78e40ec8ebbd054b0c22bd3b5ecc6c7e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

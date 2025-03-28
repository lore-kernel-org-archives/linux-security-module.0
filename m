Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7913DBA0;
	Fri, 28 Mar 2025 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743135202; cv=none; b=ILJ4jGjdKehPIhysPbHBXHl8TktekGD8kqKEw3Bpq5y3GYkEoM5Ey3l2TEx65lQiTKq4Yt4eTEWNDXgVLrtnsJyNUgpm36Z5fwdWtxH1WrwEEu3sySyimBG/yx7Cs/5RvFh38Ytxyuarm0INqfTjBlgN7i0RxCmMWpzJoeb5ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743135202; c=relaxed/simple;
	bh=8A5Q+rFYUfFh648zPnskEaGlBBRmaERMSC6OmS+ijio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MuNPF7Gi3DZM0WcKdbz76+lbBzCrRq6TlYcjQdpYkFc6naa/tPJZtGbwq7rucI80sVoTMGb4caZeywu8dMBaAMQJZZJqDRY0kBzi2Yycn/9gu/PP4kjYE7HOvW5dYDPTE3BUFpyhVgHz3A/7cKteaqXLSwFGinp+kg4yfiLL0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 18DAA780; Thu, 27 Mar 2025 23:07:26 -0500 (CDT)
Date: Thu, 27 Mar 2025 23:07:26 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: torvalds@linux-foundation.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Paul Moore <paul@paul-moore.com>
Subject: [GIT PULL] capabilities update for 6.15
Message-ID: <20250328040726.GA423659@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

this PR just contains one patch to drop an unused helper.  Please merge.

thanks,
-serge

--

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20250327

for you to fetch changes up to 4ae89b1fe7c2e37a8f2ea39765e4c40c9d42a101:

  capability: Remove unused has_capability (2025-03-07 22:03:09 -0600)

----------------------------------------------------------------
Capabilities update for 6.15

This branch contains one patch:

    capability: Remove unused has_capability

This removes a helper function whose last user (smack) stopped using
it in 2018.

This has been in linux-next for most of the the last cycle with no
apparent issues.  It is available at:

git@git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git #caps-20250327

on top of commit 2014c95afecee3e76ca4a56956a936e23283f05b (tag: v6.14-rc1)

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      capability: Remove unused has_capability

 include/linux/capability.h |  5 -----
 kernel/capability.c        | 16 ----------------
 security/commoncap.c       |  9 +++++----
 3 files changed, 5 insertions(+), 25 deletions(-)

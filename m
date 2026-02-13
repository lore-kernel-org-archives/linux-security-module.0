Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31E315D58;
	Fri, 13 Feb 2026 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771023812; cv=none; b=IvifPZlxEb8HD2HMvGbcjq7jVwJe5FtZTjYZo5L4rO51i+gF63BSfv1xQQ65R1OUTNADd2440kXCkALdTRL3QCoaV4b2EKav303O7j1fpIk/OgGhBG7YV0vD/GcP9z72xvxVvoLthdWSl6/HFgGZn5mQ6nMWfU/Lutem4d35O9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771023812; c=relaxed/simple;
	bh=RhzsjiGtw4rpR8IKtwCd0irxo7T+eo+5U/KZ5aSRGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UoeWySDqrOJ2iPx1wuti47hcc8PNahy2TTTM92IWGd8taHYTE+6MNM+vTenVP6qlqHEBMzGlBjl1AHBvZ1veCt5NTDd5x4TwiMxU39CmwETv15trKBGtJ8BsIR9b9bbSQkihjofw/xkVVH3dU2p1jSDhKDz828dtPBGp4d+Zmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=nh1dvPye; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="nh1dvPye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1771023418; bh=RhzsjiGtw4rpR8IKtwCd0irxo7T+eo+5U/KZ5aSRGuw=;
	h=Date:From:To:Cc:Subject:From;
	b=nh1dvPyeN+3t8TBWbOepnJIAJpxFOfYUvby14tPOvOwWHug3UNUR/rk3xm4inEHWX
	 uXGo2d/10+oxeb6L4PmRtb/PiuvzRT0nwZuKJtMWgQshNaZDRx2ZNwwy5ouu9Fpo3W
	 Y/lz7iVIojUKdatS+qWdwys8Z15gQl2ip8foLTh5ocoqT4rIAjGOFuxcnqBoOUFDY1
	 61WI0J3flFuktgEkEZbdayEOFAgs4xYkiAXe5MNOIF/li7DBQ4huoytOVHcaf7cjVW
	 BjquL5BLp9Zia0xNYDnsqaHF+n1lgKxFumE/w3hXD1Sxh8m+cKcdCpZPi6UOILK0JQ
	 QUmt12Wq5qJ5g==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id BF1F4885; Fri, 13 Feb 2026 16:56:58 -0600 (CST)
Date: Fri, 13 Feb 2026 16:56:58 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [GIT PULL] capabilities update for v7.0
Message-ID: <aY+sOhXciC+Xerwo@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-pr-20260213

for you to fetch changes up to 071588136007482d70fd2667b827036bc60b1f8f:

  ipc: don't audit capability check in ipc_permissions() (2026-01-27 21:30:42 -0600)

----------------------------------------------------------------
Capabilities update for 7.0

This branch contains two patches which have been in linux-next for a
few weeks.  The first,

  security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns

adds some tests of core capabilities helpers.  The second

  ipc: don't audit capability check in ipc_permissions()

avoids emitting audit messages when there's not actually a permission
being denied.

----------------------------------------------------------------
Ondrej Mosnacek (1):
      ipc: don't audit capability check in ipc_permissions()

Ryan Foster (1):
      security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns

 MAINTAINERS                |   1 +
 include/linux/capability.h |   6 +
 ipc/ipc_sysctl.c           |   2 +-
 security/Kconfig           |  17 +++
 security/commoncap.c       |   4 +
 security/commoncap_test.c  | 288 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 317 insertions(+), 1 deletion(-)
 create mode 100644 security/commoncap_test.c

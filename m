Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25D30DD13
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513687; cv=none; b=WVHWwdknNKb20mBQ57Eiu785byOodYSNH4WrzUf9xbPz8y9UjdcT2ShfMdrDe1LsJMrBFW+DGX8ivAIByLeig3M7kh5O0dy5rKIgnIdbEHZBBzGbZ2RPq7Wy7D1PDSy1pODuLu2C+fJz2VibvOrz+UV9k+EpB9C/awfHEETHw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513687; c=relaxed/simple;
	bh=SkdulzaYXcCc9+Kt+UWYz4xwZCubNgk1PVRp6jb5SXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXgegNIzKTXCQIw+gXckIYZTZ+wTHQ/adWoPSpkO1aBFccZXz+Lgs1de1peW3AHVQltK8ZbNYb47+sXGhEUNVwVR3uMAw00zclDcWi8nyOe0rM2cdRgyWvJHloQxQP5BT9W/JRk1D9rz8BHFNPcD+sY0zDWj++BwHMpYixMfzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VmIxe4nE; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VmIxe4nE"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dsc6N3sYvzxfZ;
	Thu, 15 Jan 2026 22:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768513676;
	bh=wAwu12Nqk8R4VH5Etf+SGCI8ScdSk5EbO7pCo/nrEZs=;
	h=From:To:Cc:Subject:Date:From;
	b=VmIxe4nE74ZBXLt3nfxNPeJHX3rJgCeVHgKzNOKtJg3T9bpBCp1fEGKrR5igOqgXC
	 KsbWMYLelU8+uRNxsTvw3D5RuE3BSjwSM9tg1ZcYmby0Y9RwJzcOMdtyG2j5Nicdnl
	 q6eh6JcRaRBGrnR1neJCcwn38S7Ew0eITFT2+9dI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dsc6M6jtYzl1G;
	Thu, 15 Jan 2026 22:47:55 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.19-rc6
Date: Thu, 15 Jan 2026 22:47:40 +0100
Message-ID: <20260115214740.803611-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This PR fixes TCP handling, tests, documentation, non-audit elided code,
and minor cosmetic changes.

Please pull these changes for v6.19-rc6 .  These commits merge cleanly
with your master branch.  The kernel changes have been tested in the
latest linux-next releases for some weeks.

Test coverage for security/landlock is 91.9% of 1933 lines according to
LLVM 21, and it was 92.1% of 1927 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.19-rc6

for you to fetch changes up to 6abbb8703aeeb645a681ab6ad155e0b450413787:

  landlock: Clarify documentation for the IOCTL access right (2026-01-12 17:07:21 +0100)

----------------------------------------------------------------
Landlock fix for v6.19-rc6

----------------------------------------------------------------
Günther Noack (2):
      selftests/landlock: Properly close a file descriptor
      landlock: Clarify documentation for the IOCTL access right

Matthieu Buffet (5):
      landlock: Fix TCP handling of short AF_UNSPEC addresses
      selftests/landlock: Fix TCP bind(AF_UNSPEC) test case
      selftests/landlock: Add missing connect(minimal AF_UNSPEC) test
      selftests/landlock: Remove invalid unix socket bind()
      selftests/landlock: NULL-terminate unix pathname addresses

Mickaël Salaün (6):
      landlock: Fix formatting
      landlock: Remove useless include
      landlock: Improve erratum documentation
      landlock: Clean up hook_ptrace_access_check()
      landlock: Fix spelling
      landlock: Optimize stack usage when !CONFIG_AUDIT

Tingmao Wang (5):
      landlock: Fix wrong type usage
      selftests/landlock: Fix typo in fs_test
      selftests/landlock: Fix missing semicolon
      selftests/landlock: Use scoped_base_variants.h for ptrace_test
      landlock: Improve the comment for domain_is_scoped

 include/uapi/linux/landlock.h                      |  37 +++--
 security/landlock/audit.c                          |   2 +-
 security/landlock/domain.h                         |   2 +-
 security/landlock/errata/abi-6.h                   |   2 +-
 security/landlock/fs.c                             |  14 +-
 security/landlock/net.c                            | 118 +++++++++-------
 security/landlock/ruleset.c                        |   1 -
 security/landlock/task.c                           |  12 +-
 tools/testing/selftests/landlock/common.h          |   1 +
 tools/testing/selftests/landlock/fs_test.c         |  34 ++---
 tools/testing/selftests/landlock/net_test.c        |  30 +++-
 tools/testing/selftests/landlock/ptrace_test.c     | 154 +--------------------
 .../selftests/landlock/scoped_abstract_unix_test.c |  23 ++-
 .../selftests/landlock/scoped_base_variants.h      |   9 +-
 14 files changed, 170 insertions(+), 269 deletions(-)

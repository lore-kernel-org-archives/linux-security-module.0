Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD49214A89
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jan 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565368; cv=none; b=D6YX5aprmU8YvgxEojYXLoKvkbnLs3ofW2r/5+/rdTlvbZaeOdhM62c31qfVeIPtu3O+E42ypKfAuU8I2m58rYPM/rCq/rf5cOGXivr5NpJ23KREhbq+t0J/0N021mexlBQ8G/AMLgp2IL/EwZ/KwNenLgqfmoVchIl7IafUTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565368; c=relaxed/simple;
	bh=zp8T6rnhYazNcUzJcuyegZ24tuj0V9tpCc6JWapkCzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mf6hRBXi3CWO01OFIzjbpugR2yF/ItZ7t2pAerJQJWOB3kORVuRAMQ/1ufPlkPQWbDQQYQ6ygZoInjL8g231RYfUOQ2s4RobIO15iiL9zBy7z7L4Xsqw0H/w9eWakZRntlyL/kQSpkPsM0byK+7HdZQLLIp0lcAYUwbbXGtlw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DdfpPngQ; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DdfpPngQ"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YdVbL5mPJz2FL;
	Wed, 22 Jan 2025 17:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737564990;
	bh=eZOD+4GCYEaXJUZjlOO0w095KodsP1EntiU+78IjSoA=;
	h=From:To:Cc:Subject:Date:From;
	b=DdfpPngQLb0JBGxt2XAJjpfvnEGQKw+iljF3x0ztWR0lysFTT/K5PZXisALn6BtPx
	 58uweGX/wzGZY8S85aDQXU/J2T7U5CmLoGAMCmkRGNUJEh3kymFdKErnkSFA3eZb6m
	 Cvd/O1A/f1K+4QGf8Lo8x4maWdcw9yrcSEVxnNTY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YdVbK4bQZzvvB;
	Wed, 22 Jan 2025 17:56:29 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ba Jing <bajing@cmss.chinamobile.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	Zichen Xie <zichenxie0106@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.14
Date: Wed, 22 Jan 2025 17:56:26 +0100
Message-ID: <20250122165626.331786-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR mostly factors out some Landlock code and prepares for upcoming audit
support.  Because weird files might be visible after filesystem corruption,
Landlock now properly handles weird files too.  A few sample and test issues
are also fixed.

Please pull these changes for v6.14-rc1 .  These commits merge cleanly with
your master branch.  The kernel code has been tested in the latest linux-next
releases for a few weeks and rebased to update commit messages.

Test coverage for security/landlock is 93.4% of 1124 lines according to
gcc/gcov-14, and it was 92.7% of 1118 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.14-rc1

for you to fetch changes up to 2a794ee613617b5d8fd978b7ef08d64aa07ff2e6:

  selftests/landlock: Add layout1.umount_sandboxer tests (2025-01-17 19:05:38 +0100)

----------------------------------------------------------------
Landlock updates for v6.14-rc1

----------------------------------------------------------------
Ba Jing (1):
      selftests/landlock: Remove unused macros in ptrace_test.c

Mickaël Salaün (14):
      landlock: Handle weird files
      landlock: Constify get_mode_access()
      landlock: Use scoped guards for ruleset
      landlock: Use scoped guards for ruleset in landlock_add_rule()
      selftests/landlock: Fix build with non-default pthread linking
      landlock: Factor out check_access_path()
      landlock: Move access types
      landlock: Simplify initially denied access rights
      landlock: Align partial refer access checks with final ones
      selftests/landlock: Add test to check partial access in a mount tree
      landlock: Optimize file path walks and prepare for audit support
      selftests/landlock: Fix error message
      selftests/landlock: Add wrappers.h
      selftests/landlock: Add layout1.umount_sandboxer tests

Zichen Xie (1):
      samples/landlock: Fix possible NULL dereference in parse_path()

 samples/landlock/sandboxer.c                       |   7 +
 security/landlock/access.h                         |  77 +++++++++++
 security/landlock/fs.c                             | 114 ++++++++--------
 security/landlock/fs.h                             |   1 +
 security/landlock/ruleset.c                        |  26 ++--
 security/landlock/ruleset.h                        |  52 +------
 security/landlock/syscalls.c                       |  39 ++----
 tools/testing/selftests/landlock/Makefile          |   6 +-
 tools/testing/selftests/landlock/common.h          |  38 +-----
 tools/testing/selftests/landlock/fs_test.c         | 151 +++++++++++++++++++--
 tools/testing/selftests/landlock/ptrace_test.c     |   2 -
 .../selftests/landlock/sandbox-and-launch.c        |  82 +++++++++++
 tools/testing/selftests/landlock/wait-pipe.c       |  42 ++++++
 tools/testing/selftests/landlock/wrappers.h        |  47 +++++++
 14 files changed, 489 insertions(+), 195 deletions(-)
 create mode 100644 security/landlock/access.h
 create mode 100644 tools/testing/selftests/landlock/sandbox-and-launch.c
 create mode 100644 tools/testing/selftests/landlock/wait-pipe.c
 create mode 100644 tools/testing/selftests/landlock/wrappers.h

Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7733E1D1B
	for <linux-security-module@vger.kernel.org>; Thu,  9 Apr 2026 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755956; cv=none; b=b/FwjleT3CXiRrZ6EOGC1x+OKAIV9coLSdIV01WdS9bsAKNPqw1bQfsQX/qmxSBGiw3Jdh4TOyzwuiA8f2+iJ0V1NqZscpAejQGqHJBbTDp+JumUTBEOiPYkMRXC0bHpmQ3FBDSqNLHyvCcBCrm++okeY9QVEyhO7zdzWbbJVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755956; c=relaxed/simple;
	bh=xV8e5n02Bn7KN1ginF6cqLkxNL4PXHtOuVdoVxtz9+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LO3KLfAP8M5tebV61K1r4S/uT4DM4qu69EFjTflAN9rKpl/n1YzSPv0h9WoQXw6TTi21ZHW3l9YxyaDO8Rswpo0RspLxVnG9eJ10GTNHMsFEvz0qSxMMB4nT6v+GFmOeqJrDB26j7Kmplj6uvgnQWcDAIYWar9SnhnUoo6zegZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=k5trflAr; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="k5trflAr"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fs6Sc2Q7YzFv5;
	Thu,  9 Apr 2026 19:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775755936;
	bh=oJq+E+QOQ2a/favhQZo+IL5adV3UJw1decmMMbbq0ZY=;
	h=From:To:Cc:Subject:Date:From;
	b=k5trflAr9Zvibzk+CEZVdSimXoZ2D9lHlZS755VyBXaDiyrQDrBSWTg7d2X1clI99
	 QgY8u7juQyLH4STvbcDvrMEMP7leenA7tz6WxJlMn0Eya4UDARMkNacHMLy+qIqcfG
	 hZKQOahRwfRkr585SPr6CU3MOJEnah5RZEXxu0ao=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fs6Sb3fH5zFX9;
	Thu,  9 Apr 2026 19:32:15 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jann Horn <jannh@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v7.1-rc1
Date: Thu,  9 Apr 2026 19:31:24 +0200
Message-ID: <20260409173124.2478023-1-mic@digikod.net>
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

This PR adds a new Landlock access right for pathname UNIX domain
sockets thanks to a new LSM hook, and a few fixes.

Please pull these changes for v7.1-rc1 .  These commits merge cleanly
with your master branch.  Kernel changes have been tested in the latest
linux-next releases for some weeks, and since this week for the
LOG_SUBDOMAINS_OFF fixes.

Test coverage for security/landlock is 91.1% of 2152 lines according to
LLVM 21, and it was 91.0% of 2105 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.1-rc1

for you to fetch changes up to 3457a5ccacd34fdd5ebd3a4745e721b5a1239690:

  landlock: Document fallocate(2) as another truncation corner case (2026-04-07 18:51:11 +0200)

----------------------------------------------------------------
Landlock update for v7.1-rc1

----------------------------------------------------------------
Günther Noack (11):
      landlock: Use mem_is_zero() in is_layer_masks_allowed()
      landlock: Control pathname UNIX domain socket resolution by path
      landlock: Clarify BUILD_BUG_ON check in scoping logic
      samples/landlock: Add support for named UNIX domain socket restrictions
      selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
      selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
      selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
      selftests/landlock: Check that coredump sockets stay unrestricted
      selftests/landlock: Simplify ruleset creation and enforcement in fs_test
      landlock: Document FS access right for pathname UNIX sockets
      landlock: Document fallocate(2) as another truncation corner case

Justin Suess (1):
      lsm: Add LSM hook security_unix_find

Mickaël Salaün (11):
      landlock: Fix LOG_SUBDOMAINS_OFF inheritance across fork()
      landlock: Allow TSYNC with LOG_SUBDOMAINS_OFF and fd=-1
      selftests/landlock: Fix snprintf truncation checks in audit helpers
      selftests/landlock: Fix socket file descriptor leaks in audit helpers
      selftests/landlock: Drain stale audit records on init
      selftests/landlock: Skip stale records in audit_match_record()
      selftests/landlock: Fix format warning for __u64 in net_test
      landlock: Add missing kernel-doc "Return:" sections
      landlock: Improve kernel-doc "Return:" section consistency
      landlock: Fix formatting in tsync.c
      landlock: Fix kernel-doc warning for pointer-to-array parameters

 Documentation/security/landlock.rst                |   42 +-
 Documentation/userspace-api/landlock.rst           |   22 +-
 include/linux/lsm_hook_defs.h                      |    5 +
 include/linux/security.h                           |   11 +
 include/uapi/linux/landlock.h                      |   25 +-
 net/unix/af_unix.c                                 |   10 +-
 samples/landlock/sandboxer.c                       |   12 +-
 security/landlock/access.h                         |    4 +-
 security/landlock/audit.c                          |    1 +
 security/landlock/cred.c                           |    6 +-
 security/landlock/cred.h                           |    2 +-
 security/landlock/domain.c                         |    6 +-
 security/landlock/fs.c                             |  163 ++-
 security/landlock/id.c                             |    2 +-
 security/landlock/limits.h                         |    2 +-
 security/landlock/ruleset.c                        |   14 +-
 security/landlock/ruleset.h                        |    2 +-
 security/landlock/syscalls.c                       |   33 +-
 security/landlock/task.c                           |   22 +-
 security/landlock/tsync.c                          |  124 +-
 security/security.c                                |   20 +
 tools/testing/selftests/landlock/audit.h           |  133 +-
 tools/testing/selftests/landlock/audit_test.c      |  357 +++++-
 tools/testing/selftests/landlock/base_test.c       |    2 +-
 tools/testing/selftests/landlock/fs_test.c         | 1343 +++++++++++---------
 tools/testing/selftests/landlock/net_test.c        |    2 +-
 tools/testing/selftests/landlock/ptrace_test.c     |    1 -
 .../selftests/landlock/scoped_abstract_unix_test.c |    1 -
 tools/testing/selftests/landlock/tsync_test.c      |   77 ++
 29 files changed, 1650 insertions(+), 794 deletions(-)

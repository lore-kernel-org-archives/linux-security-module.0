Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AE363C77
	for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223630; cv=none; b=hcm1c5BAjSyz6DExuyE74i1SJj4jV2/2hm/wZnyCOHm1vpQHkVpBeATORC1pEGbkFMT/5YWEdCT4Bp5GIdVI111UbztJIWSFFlF85OqknGYLvI2YOePshS8GcH9tbX5RkvpcSJHDQFgbHOvHX1Y4FtqWrJ/n11aW0uw/nMKNeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223630; c=relaxed/simple;
	bh=PVxWLL64wwHNluB2agmy9maMXtDCYbyd7VaMVxKY0ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQOEjHcO9YV++xca7yZ2SnP9xJZmt0CiVinJHy5/lxA/w0VG2GFokho1X9yclPRbGkMv9P6SgWyQd29duxXIVvIkdmQ2fi2bwgoWOqYUvGk90ORs3X2mUqpV6O+Y06qQJkOJM6b0XGoeYu/sZDVWZpieG37Y1+DnpuxslQKcYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EQdi9dwU; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EQdi9dwU"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hQd4Q2YkzzjZL;
	Thu, 20 Aug 2026 11:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1787217142;
	bh=SgowKIIgI9hb6pgmXOZ0WShYcEV0s5fj2mhTwe5nlk0=;
	h=From:To:Cc:Subject:Date:From;
	b=EQdi9dwUfdDEZFA3BQFS7RP2Qt5UsQ9KhPBsnUURgVEB0k3oM/LhcRuV6u+Ukd36Z
	 wsFw/nlr2Vf0esRZ6abvk9GofX1bFRdn8wVu4Mx5A4LKpsmzPxuG4oP1wxV69B37sF
	 T0HUpkfMHBo8+f0zrpEs1QgFRu8/+1dXluZ+FLKw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hQd4P01wmzBF2;
	Thu, 20 Aug 2026 11:12:20 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Doehyun Baek <doehyunbaek@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Wang Yan <wangyan01@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v7.3-rc1
Date: Thu, 20 Aug 2026 11:12:08 +0200
Message-ID: <20260820091208.1001980-1-mic@digikod.net>
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

This PR improves observability with Landlock tracepoints support, which
required some refactoring for dedicated domain types and common helpers shared
with audit code.  A LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag is also added to
improve process-wide domain enforcement consistency.  Whiteout files are now
correctly handled and tested, and a few other fixes complete this PR.

Please pull these changes for v7.3-rc1 .  These commits merge cleanly
with your master branch.  Most kernel changes have been tested in the
latest linux-next releases for some weeks, and I recently updated commit
messages to reflect latest reviews.

Test coverage for security/landlock is 91.6% of 2571 lines according to
LLVM 22, and it was 91.8% of 2357 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc1

for you to fetch changes up to 172b6a6d8463562b0cbebfd66f770b078f81966b:

  landlock: Document tracepoints (2026-08-17 10:17:19 +0200)

----------------------------------------------------------------
Landlock update for v7.3-rc1

----------------------------------------------------------------
Doehyun Baek (1):
      landlock: Document fs.resolve_unix audit blocker

Günther Noack (7):
      landlock: Documentation wording cleanups
      selftests/landlock: Use an actual chardev for MAKE_CHAR audit test
      landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
      selftests/landlock: Add tests for whiteout object creation
      selftests/landlock: Add audit test for whiteout object creation
      selftests/landlock: Test whiteout object behaviour in OverlayFS renames
      landlock: Link the erratum documentation for whiteout objects

Justin Suess (5):
      landlock: Check landlock_restrict_self(2)'s flags before privileges
      landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
      selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
      landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
      samples/landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to sampler

Mickaël Salaün (20):
      landlock: Harden sock_is_scoped() against file-less sockets
      landlock: Prepare ruleset and domain type split
      landlock: Move domain query functions to domain.c
      landlock: Split struct landlock_domain from struct landlock_ruleset
      landlock: Split denial logging from audit into common framework
      landlock: Decouple the per-denial logging decision from CONFIG_AUDIT
      landlock: Consolidate access-right and scope names in a shared header
      landlock: Add create_ruleset and free_ruleset tracepoints
      landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints
      landlock: Add create_domain and free_domain tracepoints
      landlock: Add landlock_enforce_domain tracepoint
      landlock: Add tracepoints for rule checking
      landlock: Add landlock_deny_access_fs and landlock_deny_access_net
      landlock: Add tracepoints for ptrace and scope denials
      selftests/landlock: Add trace event test infrastructure and tests
      selftests/landlock: Add filesystem tracepoint tests
      selftests/landlock: Add network tracepoint tests
      selftests/landlock: Add scope and ptrace tracepoint tests
      selftests/landlock: Add landlock_enforce_domain trace tests
      landlock: Document tracepoints

Wang Yan (1):
      selftests/landlock: Fix spelling error in fs_test comment

 Documentation/admin-guide/LSM/landlock.rst         |  106 +-
 Documentation/security/landlock.rst                |   38 +-
 Documentation/trace/events-landlock.rst            |  326 ++++
 Documentation/trace/index.rst                      |    1 +
 Documentation/userspace-api/landlock.rst           |   62 +-
 MAINTAINERS                                        |    3 +
 include/linux/landlock.h                           |   56 +
 include/trace/events/landlock.h                    |  965 ++++++++++++
 include/uapi/linux/landlock.h                      |   22 +-
 samples/landlock/sandboxer.c                       |   16 +-
 security/landlock/Kconfig                          |    5 +
 security/landlock/Makefile                         |   12 +-
 security/landlock/access.h                         |    6 +-
 security/landlock/audit.c                          |  641 +-------
 security/landlock/audit.h                          |   57 +-
 security/landlock/cred.c                           |   14 +-
 security/landlock/cred.h                           |   29 +-
 security/landlock/domain.c                         |  472 +++++-
 security/landlock/domain.h                         |  163 +-
 security/landlock/errata/abi-1.h                   |   23 +
 security/landlock/fs.c                             |  259 +++-
 security/landlock/fs.h                             |   40 +-
 security/landlock/id.h                             |    6 +-
 security/landlock/limits.h                         |    2 +-
 security/landlock/log.c                            |  587 +++++++
 security/landlock/log.h                            |   86 ++
 security/landlock/net.c                            |   38 +-
 security/landlock/ruleset.c                        |  546 +------
 security/landlock/ruleset.h                        |  250 +--
 security/landlock/syscalls.c                       |  125 +-
 security/landlock/task.c                           |   87 +-
 security/landlock/trace.c                          |  185 +++
 security/landlock/trace.h                          |   44 +
 security/landlock/tsync.c                          |   24 +-
 security/landlock/tsync.h                          |    4 +-
 tools/testing/selftests/landlock/audit.h           |   35 -
 tools/testing/selftests/landlock/base_test.c       |  104 +-
 tools/testing/selftests/landlock/common.h          |   47 +
 tools/testing/selftests/landlock/config            |    2 +
 tools/testing/selftests/landlock/fs_test.c         |  738 ++++++++-
 tools/testing/selftests/landlock/net_test.c        |  590 ++++++-
 tools/testing/selftests/landlock/ptrace_test.c     |  402 +++++
 .../selftests/landlock/scoped_abstract_unix_test.c |  264 ++++
 .../selftests/landlock/scoped_signal_test.c        |  404 +++++
 tools/testing/selftests/landlock/trace.h           |  639 ++++++++
 tools/testing/selftests/landlock/trace_fs_test.c   |  496 ++++++
 tools/testing/selftests/landlock/trace_test.c      | 1620 ++++++++++++++++++++
 tools/testing/selftests/landlock/true.c            |   10 +
 tools/testing/selftests/landlock/tsync_test.c      |   96 +-
 49 files changed, 9244 insertions(+), 1503 deletions(-)
 create mode 100644 Documentation/trace/events-landlock.rst
 create mode 100644 include/linux/landlock.h
 create mode 100644 include/trace/events/landlock.h
 create mode 100644 security/landlock/log.c
 create mode 100644 security/landlock/log.h
 create mode 100644 security/landlock/trace.c
 create mode 100644 security/landlock/trace.h
 create mode 100644 tools/testing/selftests/landlock/trace.h
 create mode 100644 tools/testing/selftests/landlock/trace_fs_test.c
 create mode 100644 tools/testing/selftests/landlock/trace_test.c

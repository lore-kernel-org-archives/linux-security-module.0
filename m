Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E12AEED
	for <linux-security-module@vger.kernel.org>; Fri, 28 Mar 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179724; cv=none; b=ldaKd56YR/+nB2OiMMcGwiMXpXxw/tIhK88QhfLd7g2TZXPEBkoz0YO3O/bFZXcPA3pd5Ncw/fKy5onIeHQf/KLYOPZerOR+Qi5MrPzDp2uy/w2MHGaWRCjEEB5wTFZLh5033VlLQZJ7cp5NSo+oKDgknhMxTAXlHCK42GZFFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179724; c=relaxed/simple;
	bh=LrpiumgRdPeVgBHNini5NzHlvZIBU/PqzD4xZ8EA9cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sp2lpKim6TPcilhOpXWFZAG9EqVnwcER5PSvhcm01rHOyAb8zv5Sq0iBg0qkQk0RnjOYCapeoYezHSVZBQ5yk9aUPmjadyE3brJul6fwcpWz72KGSy69zeEQ3U4V/tFQXqcXlY23LqGF0uWhIGyzYL3dKxsU1bD7QAuH/hoW+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1cWQagqo; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1cWQagqo"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZPQrX0JKDzQJJ;
	Fri, 28 Mar 2025 17:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1743179179;
	bh=x70xaAnPvbRQ79Zp27BbQFS5aKWtHXbO5ZYCLXGtkwI=;
	h=From:To:Cc:Subject:Date:From;
	b=1cWQagqokvElMxnUDfBv7ecCtaf5erEKgQVjg1Cnoqnhr6bhXsswPYw5RGIVRXzdf
	 VBpz+3u0Ie0jl9W3Z0fgvwX/33k6YkFrxUAhdnsRC35VI083BUy4jBl/6fmRkGs7Zl
	 e+7gV+lTKAHoVAZ3Ey29LPj7gcv9TveKYr7fvQ6w=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZPQrV6nHZzq5f;
	Fri, 28 Mar 2025 17:26:18 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Charles Zaffery <czaffery@roblox.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v6.15-rc1
Date: Fri, 28 Mar 2025 17:26:10 +0100
Message-ID: <20250328162610.621810-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Linus,

This PR brings two main changes to Landlock:
* A signal scoping fix with a new interface for user space to know if it
  is compatible with the running kernel.
* Audit support to give visibility on why access requests are denied,
  including the origin of the security policy, missing access rights,
  and description of object(s).  This was designed to limit log spam as
  much as possible while still alerting about unexpected blocked access.

With these changes come new and improved documentation, and a lot of new
tests.

Please pull these changes for v6.15-rc1 .  These commits merge cleanly
with your master branch.  Most kernel code has been tested in the latest
linux-next releases for a few weeks and recently rebased to apply fixes.

syzkaller has been running for a few months on a private instance with
these changes.  The upstream project can now also test them:
https://github.com/google/syzkaller/pull/5851

Test coverage with Kselftest for master:security/landlock is 93.6% of
1525 lines according to gcc/gcov-14, and it was 92.6% of 1115 lines
before this PR.

Regards,
 Mickaël

--
The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc1

for you to fetch changes up to 8e2dd47b10e77452733eae23cc83078fa29c1e9a:

  landlock: Add audit documentation (2025-03-26 13:59:49 +0100)

----------------------------------------------------------------
Landlock update for v6.15-rc1

----------------------------------------------------------------
Günther Noack (1):
      landlock: Clarify IPC scoping documentation

Mickaël Salaün (35):
      landlock: Move code to ease future backports
      landlock: Add the errata interface
      landlock: Add erratum for TCP fix
      landlock: Prepare to add second errata
      landlock: Always allow signals between threads of the same process
      selftests/landlock: Split signal_scoping_threads tests
      selftests/landlock: Add a new test for setuid()
      lsm: Add audit_log_lsm_data() helper
      landlock: Add unique ID generator
      landlock: Move domain hierarchy management
      landlock: Prepare to use credential instead of domain for filesystem
      landlock: Prepare to use credential instead of domain for network
      landlock: Prepare to use credential instead of domain for scope
      landlock: Prepare to use credential instead of domain for fowner
      landlock: Identify domain execution crossing
      landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials
      landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status
      landlock: Log mount-related denials
      landlock: Log file-related denials
      landlock: Factor out IOCTL hooks
      landlock: Log truncate and IOCTL denials
      landlock: Log TCP bind and connect denials
      landlock: Log scoped denials
      landlock: Add LANDLOCK_RESTRICT_SELF_LOG_*_EXEC_* flags
      landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
      samples/landlock: Enable users to log sandbox denials
      selftests/landlock: Add test for invalid ruleset file descriptor
      selftests/landlock: Extend tests for landlock_restrict_self(2)'s flags
      selftests/landlock: Add tests for audit flags and domain IDs
      selftests/landlock: Test audit with restrict flags
      selftests/landlock: Add audit tests for ptrace
      selftests/landlock: Add audit tests for abstract UNIX socket scoping
      selftests/landlock: Add audit tests for filesystem
      selftests/landlock: Add audit tests for network
      landlock: Add audit documentation

 Documentation/admin-guide/LSM/index.rst            |   1 +
 Documentation/admin-guide/LSM/landlock.rst         | 158 ++++++
 Documentation/security/landlock.rst                |  13 +-
 Documentation/userspace-api/landlock.rst           |  72 ++-
 MAINTAINERS                                        |   1 +
 include/linux/lsm_audit.h                          |   8 +
 include/uapi/linux/audit.h                         |   4 +-
 include/uapi/linux/landlock.h                      |  35 ++
 samples/landlock/sandboxer.c                       |  37 +-
 security/landlock/.kunitconfig                     |   2 +
 security/landlock/Makefile                         |   5 +
 security/landlock/access.h                         |  25 +-
 security/landlock/audit.c                          | 522 ++++++++++++++++++
 security/landlock/audit.h                          |  76 +++
 security/landlock/cred.c                           |  28 +-
 security/landlock/cred.h                           |  92 +++-
 security/landlock/domain.c                         | 264 +++++++++
 security/landlock/domain.h                         | 174 ++++++
 security/landlock/errata.h                         |  99 ++++
 security/landlock/errata/abi-4.h                   |  15 +
 security/landlock/errata/abi-6.h                   |  19 +
 security/landlock/fs.c                             | 321 ++++++++---
 security/landlock/fs.h                             |  40 +-
 security/landlock/id.c                             | 251 +++++++++
 security/landlock/id.h                             |  25 +
 security/landlock/limits.h                         |   7 +-
 security/landlock/net.c                            |  78 ++-
 security/landlock/ruleset.c                        |  30 +-
 security/landlock/ruleset.h                        |  48 +-
 security/landlock/setup.c                          |  40 +-
 security/landlock/setup.h                          |   3 +
 security/landlock/syscalls.c                       |  99 +++-
 security/landlock/task.c                           | 257 ++++++---
 security/lsm_audit.c                               |  27 +-
 tools/testing/kunit/configs/all_tests.config       |   2 +
 tools/testing/selftests/landlock/.gitignore        |   1 +
 tools/testing/selftests/landlock/Makefile          |   6 +-
 tools/testing/selftests/landlock/audit.h           | 472 ++++++++++++++++
 tools/testing/selftests/landlock/audit_test.c      | 551 +++++++++++++++++++
 tools/testing/selftests/landlock/base_test.c       | 130 ++++-
 tools/testing/selftests/landlock/common.h          |  20 +
 tools/testing/selftests/landlock/config            |   1 +
 tools/testing/selftests/landlock/fs_test.c         | 594 +++++++++++++++++++++
 tools/testing/selftests/landlock/net_test.c        | 132 +++++
 tools/testing/selftests/landlock/ptrace_test.c     | 140 +++++
 .../selftests/landlock/scoped_abstract_unix_test.c | 111 ++++
 .../selftests/landlock/scoped_signal_test.c        | 108 +++-
 .../testing/selftests/landlock/wait-pipe-sandbox.c | 131 +++++
 48 files changed, 4960 insertions(+), 315 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/landlock.rst
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c
 create mode 100644 security/landlock/domain.h
 create mode 100644 security/landlock/errata.h
 create mode 100644 security/landlock/errata/abi-4.h
 create mode 100644 security/landlock/errata/abi-6.h
 create mode 100644 security/landlock/id.c
 create mode 100644 security/landlock/id.h
 create mode 100644 tools/testing/selftests/landlock/audit.h
 create mode 100644 tools/testing/selftests/landlock/audit_test.c
 create mode 100644 tools/testing/selftests/landlock/wait-pipe-sandbox.c

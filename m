Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1471953A1
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497656; cv=none; b=heHF6v4Av9eFhiy2NYYhLp9/NbIqSf3oKljFmnirMK3BVjZThDLLiRSdxJNkGULjdhx3MAGk0ZbUCAhBuhX/SugB7LKilwR6CjseNoMjjvRoZWIzLeyz2nOmEAIAGi2yFcy/AhYq2EKjos79O6svYgOx38DLVrOvp/TSt4WrJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497656; c=relaxed/simple;
	bh=rMHUMHua2A9bGKmJCg698wcuFg6v/Q8cRiOUssdd7JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mjeW0ED2nnIU1AodqrjwOfaAhjFz6UNWeIG1wXMlymHc2LjOBWZ6eq5i1RPohC5R+WWJYZNfH6zgw3OGWo8alOv2JzgHHmTOlLgBp8ltvN/Nlku9jZfNVRm4SwkJ5yo9HXDMDmkLENk9IA9AXF36gkBbrUab+D49NWa+Bo9M6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qO9CzJw5; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qO9CzJw5"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZp42DZTzK4n;
	Thu, 20 Mar 2025 20:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497644;
	bh=JbWUiTwrW2cLQ+5RJ0O6hjQPCipmh6twonJvlRboMd8=;
	h=From:To:Cc:Subject:Date:From;
	b=qO9CzJw5x+Npblk4fGC5oRbeBd+fKctI82xRpS9zCedGRpNeCYEcZ5I6mjd8hiX50
	 mvbCt3tGkmUjyNXMYqTbae6kyOHx4JSVU4wFVf3BWusOIpwvQ8CUvXPDs2bQ0PkGPm
	 Iiceci2qC8fqA8RZStoNYtGqbYNl2vYB99HJ0QkY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZp15wYgz52j;
	Thu, 20 Mar 2025 20:07:21 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 00/28] Landlock audit support
Date: Thu, 20 Mar 2025 20:06:49 +0100
Message-ID: <20250320190717.2287696-1-mic@digikod.net>
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

This patch series adds audit support to Landlock.

Logging denied requests is useful for different use cases:
- sysadmins: to look for users' issues,
- security experts: to detect attack attempts,
- power users: to understand denials,
- developers: to ease sandboxing support and get feedback from users.

Because of its unprivileged nature, Landlock can compose standalone
security policies (i.e. domains).  To make logs useful, they need to
contain the most relevant Landlock domain that denied an action, and the
reason of such denial.  This translates to the latest nested domain and
the related blockers: missing access rights or other kind of
restrictions.

# Main changes from previous version

A lot of new tests for domain layers, filesystem, and netwoking.  the
previous test race condition is fixed.  Test coverage is now 94%!

Some issues fixed thanks to the new tests, code simplification, a few
cosmetic changes, and an improved documentation.

This series is rebased on top of these fixes:
https://lore.kernel.org/r/20250318161443.279194-1-mic@digikod.net

# Design

Log records are created for any denied actions caused by a Landlock
policy, which means that a well-sandboxed applications should not log
anything except for unattended access requests that might be the result
of attacks or bugs.

However, sandbox tools creating restricted environments could lead to
abundant log entries because the sandboxed processes may not be aware of
the related restrictions.  To avoid log spam, the
landlock_restrict_self(2) syscall gets new flags to not log denials
related to this specific domain.  Except for well-understood exceptions,
these flags should not be set.  Indeed, applications sandboxing
themselves should only try to bypass their own sandbox if they are
compromised, which should ring a bell thanks to log events.

When an action is denied, the related Landlock domain ID is specified.
If this domain was not previously described in a log record, one is
created.  This record contains the domain ID, its creation time, and
informations about the process that enforced the restriction (at the
time of the call to landlock_restrict_self): PID, UID, executable path,
and name (comm).

This new approach also brings building blocks for an upcoming
unprivileged introspection interface.  The unique Landlock IDs will be
useful to tie audit log entries to running processes, and to get
properties of the related Landlock domains.  This will replace the
previously logged ruleset properties.

# Samples

Here are two examples of log events (see serial numbers):

$ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1

  type=LANDLOCK_ACCESS msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
  type=LANDLOCK_DOMAIN msg=audit(1729738800.268:30): domain=1a6fdc66f status=allocated mode=enforcing pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
  type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
  type=LANDLOCK_DOMAIN msg=audit(1729738800.324:31): domain=1a6fdc66f status=deallocated denials=1

$ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"

  type=LANDLOCK_ACCESS msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
  type=LANDLOCK_DOMAIN msg=audit(1729738800.221:33): domain=1a6fdc679 status=allocated mode=enforcing pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
  type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
  type=LANDLOCK_ACCESS msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
  type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
  type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
  type=LANDLOCK_DOMAIN msg=audit(1729738800.261:35): domain=1a6fdc679 status=deallocated denials=2

# Previous versions

v6: https://lore.kernel.org/r/20250308184422.2159360-1-mic@digikod.net
v5: https://lore.kernel.org/r/20250131163059.1139617-1-mic@digikod.net
v4: https://lore.kernel.org/r/20250108154338.1129069-1-mic@digikod.net
v3: https://lore.kernel.org/r/20241122143353.59367-1-mic@digikod.net
v2: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net

Regards,

Mickaël Salaün (28):
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

 Documentation/admin-guide/LSM/index.rst       |   1 +
 Documentation/admin-guide/LSM/landlock.rst    | 158 +++++
 Documentation/security/landlock.rst           |  13 +-
 Documentation/userspace-api/landlock.rst      |  17 +
 MAINTAINERS                                   |   1 +
 include/linux/lsm_audit.h                     |   8 +
 include/uapi/linux/audit.h                    |   4 +-
 include/uapi/linux/landlock.h                 |  33 +
 samples/landlock/sandboxer.c                  |  37 +-
 security/landlock/.kunitconfig                |   2 +
 security/landlock/Makefile                    |   5 +
 security/landlock/access.h                    |  23 +
 security/landlock/audit.c                     | 523 +++++++++++++++
 security/landlock/audit.h                     |  76 +++
 security/landlock/cred.c                      |  26 +-
 security/landlock/cred.h                      |  92 ++-
 security/landlock/domain.c                    | 264 ++++++++
 security/landlock/domain.h                    | 174 +++++
 security/landlock/fs.c                        | 288 +++++++--
 security/landlock/fs.h                        |  37 +-
 security/landlock/id.c                        | 251 ++++++++
 security/landlock/id.h                        |  25 +
 security/landlock/limits.h                    |   7 +-
 security/landlock/net.c                       |  74 ++-
 security/landlock/ruleset.c                   |  30 +-
 security/landlock/ruleset.h                   |  48 +-
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  |  77 ++-
 security/landlock/task.c                      | 243 +++++--
 security/lsm_audit.c                          |  27 +-
 tools/testing/kunit/configs/all_tests.config  |   2 +
 tools/testing/selftests/landlock/.gitignore   |   1 +
 tools/testing/selftests/landlock/Makefile     |   6 +-
 tools/testing/selftests/landlock/audit.h      | 472 ++++++++++++++
 tools/testing/selftests/landlock/audit_test.c | 551 ++++++++++++++++
 tools/testing/selftests/landlock/base_test.c  |  84 ++-
 tools/testing/selftests/landlock/common.h     |  19 +
 tools/testing/selftests/landlock/config       |   1 +
 tools/testing/selftests/landlock/fs_test.c    | 594 ++++++++++++++++++
 tools/testing/selftests/landlock/net_test.c   | 132 ++++
 .../testing/selftests/landlock/ptrace_test.c  | 140 +++++
 .../landlock/scoped_abstract_unix_test.c      | 111 ++++
 .../selftests/landlock/wait-pipe-sandbox.c    | 131 ++++
 43 files changed, 4554 insertions(+), 256 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/landlock.rst
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c
 create mode 100644 security/landlock/domain.h
 create mode 100644 security/landlock/id.c
 create mode 100644 security/landlock/id.h
 create mode 100644 tools/testing/selftests/landlock/audit.h
 create mode 100644 tools/testing/selftests/landlock/audit_test.c
 create mode 100644 tools/testing/selftests/landlock/wait-pipe-sandbox.c


base-commit: 4f06e22607e6e138be661494964d7f2614ec7ae6
-- 
2.49.0


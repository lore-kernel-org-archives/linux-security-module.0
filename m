Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26B1FDE2A
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351038; cv=none; b=SstYKj46ZfB2xDlQPZ8O1+XG+40g1SZ90dEMhQLYiIQAPglgjA6G3u1fvNtq/IZDk13AKcq+417Q9luUdog4AlLHDCo//iEaBLRlwJEOm2BfZwDfGd3GW1Y0qY2syouca96xHZ83yzSVNshdnK//zoa1DvWfo1pKTUVd7vtnuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351038; c=relaxed/simple;
	bh=3Fo5zphv3fR0VMr0IZdF5iCVUkiUh7FK4w0e3jVvYeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0dWsqRfIGkAowayIVF33MxYCzHsXuU6OmqkBCs2uDjfnr4+WxtV+MfCueHMeZsGqGOMq8rxwIbo/sWmd8eyEikl4DZZjCbFhHK0Qk2YFS0POH/gIjtMrY4sV8GYADWYhgxmhpg8lL6RuLrixAS+PzFcGSrPSPeXO6/MqAeJpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SdbdR3yJ; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SdbdR3yJ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsdt14PSz7RL;
	Wed,  8 Jan 2025 16:43:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351026;
	bh=cN0QSpezL8v4tsRKsjoQHFf42FQ1y+KLHfexmgD9sDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SdbdR3yJ8M4bUViGTt3GEknzLhYa8trPUElyYAAZjSWkj1maPxEc9opYbrILD3G+c
	 6AxnxZ7/gCfHcQCFDUhubHKiqUqF/bNmAQUj4o40RCi5JNzTut6J2h2F+pM5zRE/sr
	 yrFlr27BoyDNInril6gYzR74RJm+YnWv8kqYCwug=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsdq6SZFzsJ9;
	Wed,  8 Jan 2025 16:43:43 +0100 (CET)
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
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 00/30] Landlock audit support
Date: Wed,  8 Jan 2025 16:43:08 +0100
Message-ID: <20250108154338.1129069-1-mic@digikod.net>
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

# Changes from previous version

This fourth patch series mainly adds a new AUDIT_EXE_LANDLOCK_DENY rule
type to filter Landlock denials according to the executable that loaded
the policy responsible for this restriction.  New tests are added on top
of that.

Domain's metadata are now stored in a dedicated struct landlock_details
that contains the resolved exe's path, because we cannot keep a
reference to the related struct path.  This fixes umount of the
mount point containing a binary that restricted itself (if the domain is
still alive).  Add a dedicated test to check this issue.

Formatting of blockers are slightly improved.

Audit timestamps are no longer exported but dedicated Landlock
timestamps are use instead for domain creation.

The new landlock_restrict_self()'s flag is renamed to
LANDLOCK_RESTRICT_SELF_QUIET.

# Design

Log records are created for any denied actions caused by a Landlock
policy, which means that a well-sandboxed applications should not log
anything except for unattended access requests that might be the result
of attacks or bugs.

However, sandbox tools creating restricted environments could lead to
abundant log entries because the sandboxed processes may not be aware of
the related restrictions.  To avoid log spam, the
landlock_restrict_self(2) syscall gets a new
LANDLOCK_RESTRICT_SELF_QUIET flag to not log denials related to this
specific domain.  Except for well-understood exceptions, this flag
should not be set.  Indeed, applications sandboxing themselves should
only try to bypass their own sandbox if they are compromised, which
should ring a bell thanks to log events.

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

  type=LANDLOCK_DENY msg=audit(1729738800.268:30): domain=1a6fdc66f blockers=scope.signal opid=1 ocomm="systemd"
  type=LANDLOCK_DOM_INFO msg=audit(1729738800.268:30): domain=1a6fdc66f creation=1729738800.264 pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"UID="root"
  type=SYSCALL msg=audit(1729738800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
  type=PROCTITLE msg=audit(1729738800.268:30): proctitle=6B696C6C0031
  type=LANDLOCK_DOM_DROP msg=audit(1729738800.324:31): domain=1a6fdc66f denials=1

$ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"

  type=LANDLOCK_DENY msg=audit(1729738800.221:33): domain=1a6fdc679 blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=9
  type=LANDLOCK_DOM_INFO msg=audit(1729738800.221:33): domain=1a6fdc679 creation=1729738800.217 pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"UID="root"
  type=SYSCALL msg=audit(1729738800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
  type=PROCTITLE msg=audit(1729738800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
  type=LANDLOCK_DENY msg=audit(1729738800.221:34): domain=1a6fdc679 blockers=fs.write_file path="/etc/passwd" dev="vda2" ino=143821
  type=SYSCALL msg=audit(1729738800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
  type=PROCTITLE msg=audit(1729738800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
  type=LANDLOCK_DOM_DROP msg=audit(1729738800.261:35): domain=1a6fdc679 denials=2

# Future changes

I'll add more tests to check each kind of denied access.

We might want to add new audit rule types to filter according to other
domain properties (e.g. UID, AUID, session ID), but
AUDIT_EXE_LANDLOCK_DENY should be enough to mute buggy programs before
fixing them.

# Previous versions

v3: https://lore.kernel.org/r/20241122143353.59367-1-mic@digikod.net
v2: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net

Regards,

Mickaël Salaün (30):
  lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are
    set
  lsm: Add audit_log_lsm_data() helper
  landlock: Factor out check_access_path()
  landlock: Add unique ID generator
  landlock: Move access types
  landlock: Simplify initially denied access rights
  landlock: Move domain hierarchy management and export helpers
  landlock: Add AUDIT_LANDLOCK_DENY and log ptrace denials
  landlock: Add AUDIT_LANDLOCK_DOM_{INFO,DROP} and log domain properties
  landlock: Log mount-related denials
  landlock: Align partial refer access checks with final ones
  selftests/landlock: Add test to check partial access in a mount tree
  landlock: Optimize file path walks and prepare for audit support
  landlock: Log file-related denials
  landlock: Log truncate and IOCTL denials
  landlock: Log TCP bind and connect denials
  landlock: Log scoped denials
  landlock: Control log events with LANDLOCK_RESTRICT_SELF_QUIET
  samples/landlock: Do not log denials from the sandboxer by default
  selftests/landlock: Fix error message
  selftests/landlock: Add wrappers.h
  selftests/landlock: Add layout1.umount_sandboxer tests
  selftests/landlock: Extend tests for landlock_restrict_self()'s flags
  selftests/landlock: Add tests for audit and
    LANDLOCK_RESTRICT_SELF_QUIET
  selftests/landlock: Add audit tests for ptrace
  landlock: Export and rename landlock_get_inode_object()
  fs: Add iput() cleanup helper
  audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY rule type
  selftests/landlock: Test audit rule with AUDIT_EXE_LANDLOCK_DOM
  selftests/landlock: Test compatibility with audit rule lists

 Documentation/userspace-api/landlock.rst      |   2 +-
 MAINTAINERS                                   |   1 +
 include/linux/audit.h                         |  11 +
 include/linux/fs.h                            |   6 +-
 include/linux/landlock.h                      |  41 ++
 include/linux/lsm_audit.h                     |  22 +
 include/uapi/linux/audit.h                    |   6 +-
 include/uapi/linux/landlock.h                 |  14 +
 kernel/audit.c                                |   4 +-
 kernel/audit.h                                |   5 +-
 kernel/auditfilter.c                          |  30 +-
 kernel/auditsc.c                              |  31 ++
 samples/landlock/sandboxer.c                  |  35 +-
 security/Kconfig                              |   5 +
 security/Makefile                             |   2 +-
 security/landlock/.kunitconfig                |   2 +
 security/landlock/Makefile                    |  15 +-
 security/landlock/access.h                    | 100 ++++
 security/landlock/audit.c                     | 510 ++++++++++++++++++
 security/landlock/audit.h                     |  76 +++
 security/landlock/domain.c                    | 339 ++++++++++++
 security/landlock/domain.h                    | 145 +++++
 security/landlock/fs.c                        | 305 ++++++++---
 security/landlock/fs.h                        |  12 +
 security/landlock/id.c                        | 249 +++++++++
 security/landlock/id.h                        |  25 +
 security/landlock/net.c                       |  51 +-
 security/landlock/object.h                    |   4 +-
 security/landlock/ruleset.c                   |  38 +-
 security/landlock/ruleset.h                   |  95 ++--
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  |  28 +-
 security/landlock/task.c                      | 152 +++++-
 security/lsm_audit.c                          |  27 +-
 tools/testing/kunit/configs/all_tests.config  |   2 +
 tools/testing/selftests/landlock/Makefile     |   2 +-
 tools/testing/selftests/landlock/audit.h      | 371 +++++++++++++
 tools/testing/selftests/landlock/audit_test.c | 389 +++++++++++++
 tools/testing/selftests/landlock/base_test.c  |  19 +-
 tools/testing/selftests/landlock/common.h     |  40 +-
 tools/testing/selftests/landlock/config       |   1 +
 tools/testing/selftests/landlock/fs_test.c    | 151 +++++-
 .../testing/selftests/landlock/ptrace_test.c  |  67 ++-
 .../selftests/landlock/sandbox-and-launch.c   |  82 +++
 tools/testing/selftests/landlock/wait-pipe.c  |  70 +++
 tools/testing/selftests/landlock/wrappers.h   |  47 ++
 46 files changed, 3360 insertions(+), 271 deletions(-)
 create mode 100644 include/linux/landlock.h
 create mode 100644 security/landlock/access.h
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c
 create mode 100644 security/landlock/domain.h
 create mode 100644 security/landlock/id.c
 create mode 100644 security/landlock/id.h
 create mode 100644 tools/testing/selftests/landlock/audit.h
 create mode 100644 tools/testing/selftests/landlock/audit_test.c
 create mode 100644 tools/testing/selftests/landlock/sandbox-and-launch.c
 create mode 100644 tools/testing/selftests/landlock/wait-pipe.c
 create mode 100644 tools/testing/selftests/landlock/wrappers.h


base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
-- 
2.47.1


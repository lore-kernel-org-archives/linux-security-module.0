Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8770808
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286056; cv=none; b=PaGfTrpPzx0fIXZWPI6TAxJNWuTMn5qC4hJ1R4ijZ6bA9vLV5hwT3q100TopgqxyKpJN+hi6aUpT3/QVRsYf/Ec+M7cDd0VBvpySjP2RUyEYjO5WGCtHsYuMugqFMB56NHocmJgQ1iQEQ2t7WjTfv9UyNzH9ZZRv+WFmVd6MRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286056; c=relaxed/simple;
	bh=0r4hABUh0acoMcyTkOf9Kg93ny5ffSH3S+RWZLxYoc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VrSW7w6HLeVQxZFeMS2CuCRxefDUI95r8ufzZ2SRIHjROX+my1XLSHmsRjO/1FPrAkPFwd1pEypdjnM+IQXFq4Xi/cZzVs/0X8TuL2ty/R2cFgDBnTH7Kwr6ZEx3LGHfo5pqHbzs7WOwQOZ0iQu2k6L4+PXz8YuqNrKz+ILcG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DeNK0OEs; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DeNK0OEs"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyK73Svgzcvg;
	Fri, 22 Nov 2024 15:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286043;
	bh=KfB8e4QyAyEvoTpGyqB4pJ7DknRbUlvg54KRTK/YOew=;
	h=From:To:Cc:Subject:Date:From;
	b=DeNK0OEsrwwGnCtpdjh4Q5FPTDApccObAsIP/Fd3CL2s3dxPCd2BJMd7JDvJ4W9eG
	 Oqpm8a3RLrW/X6UyV9zP9Jx4w+r5RcNPlK8iknr0lyhv9b9K8LCUka3Jjo+hbmWbLt
	 oZ2X/CDpPQwG51+NGtTuKcp3r8eYh5/i1UF3nlJw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyK54Sxczk4V;
	Fri, 22 Nov 2024 15:34:01 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
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
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 00/23] Landlock audit support
Date: Fri, 22 Nov 2024 15:33:30 +0100
Message-ID: <20241122143353.59367-1-mic@digikod.net>
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
- sysadmins: to look for users' issues
- security experts: to detect attack attempts
- power users: to understand denials
- app developers: to ease and speed up sandboxing support

To make logs useful, they need to contain the most relevant Landlock
domain that denied an action, and the reason of such denial.  This
translates to the latest nested domain and the related blockers: missing
access rights or other kind of constraints (e.g. scoped domain).

# Changes from previous version

This third patch series reduces the amount of domain information
records: instead of creating a record for a domain hierarchy, only the
domain that denied the request is logged, which is enough.

The log format for domain information don't include the parent anymore
but the creation time instead, which is useful to know how old a domain
is relative to a first denial.  We also now use hexadecimal numbers for
domain IDs.

Another major addition of this patch series are the new tests.  The new
syscall flag is tested, and all the ptrace tests are extended to check
the source of the denials (e.g. Landlock or Yama).  This greatly improve
test consistency and I plan to extend all Landlock tests with these
audit checks.

The sandboxer sample is also updated to not generate logs by default.

# Design

Log records are created for any denied actions caused by a Landlock
policy, which means that a well-sandboxed applications should not log
anything except for unattended access requests that might be the result
of attacks or bugs.

However, sandbox tools creating restricted environments could lead to
abundant log entries because the sandboxed processes may not be aware of
the related restrictions.  To avoid log spam, the
landlock_restrict_self(2) syscall gets a new
LANDLOCK_RESTRICT_SELF_LOGLESS flag to not log denials related to this
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

Here are two examples of log events:

$ LL_FS_RO=/ LL_FS_RW=/ LL_SCOPED=s LL_FORCE_LOG=1 ./sandboxer kill 1

  type=UNKNOWN[1423] msg=audit(1732186800.268:30): domain=1a6fdc66f blockers=scope_signal opid=1 ocomm="systemd"
  type=UNKNOWN[1424] msg=audit(1732186800.268:30): domain=1a6fdc66f creation=1732186800.264 pid=286 uid=0 exe="/root/sandboxer" comm="sandboxer"UID="root"
  type=SYSCALL msg=audit(1732186800.268:30): arch=c000003e syscall=62 success=no exit=-1 [..] ppid=272 pid=286 auid=0 uid=0 gid=0 [...] comm="kill" [...]
  type=PROCTITLE msg=audit(1732186800.268:30): proctitle=6B696C6C0031
  type=UNKNOWN[1425] msg=audit(1732186800.324:31): domain=1a6fdc66f

$ LL_FS_RO=/ LL_FS_RW=/tmp LL_FORCE_LOG=1 ./sandboxer sh -c "echo > /etc/passwd"

  type=UNKNOWN[1423] msg=audit(1732186800.221:33): domain=1a6fdc679 blockers=fs_write_file path="/dev/tty" dev="devtmpfs" ino=9
  type=UNKNOWN[1424] msg=audit(1732186800.221:33): domain=1a6fdc679 creation=1732186800.221 pid=289 uid=0 exe="/root/sandboxer" comm="sandboxer"UID="root"
  type=SYSCALL msg=audit(1732186800.221:33): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
  type=PROCTITLE msg=audit(1732186800.221:33): proctitle=7368002D63006563686F203E202F6574632F706173737764
  type=UNKNOWN[1423] msg=audit(1732186800.221:34): domain=1a6fdc679 blockers=fs_write_file path="/etc/passwd" dev="vda2" ino=143821
  type=SYSCALL msg=audit(1732186800.221:34): arch=c000003e syscall=257 success=no exit=-13 [...] ppid=272 pid=289 auid=0 uid=0 gid=0 [...] comm="sh" [...]
  type=PROCTITLE msg=audit(1732186800.221:34): proctitle=7368002D63006563686F203E202F6574632F706173737764
  type=UNKNOWN[1425] msg=audit(1732186800.261:35): domain=1a6fdc679

# Future changes

It would be interesting to enhance audit with the ability to filter on
the executable path that created a sandbox, or to filter on a Landlock
domain ID.


Previous versions:
v1: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net

Regards,

Mickaël Salaün (23):
  lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are
    set
  lsm: Add audit_log_lsm_data() helper
  landlock: Factor out check_access_path()
  landlock: Add unique ID generator
  landlock: Move access types
  landlock: Simplify initially denied access rights
  landlock: Move domain hierarchy management
  landlock: Log ptrace denials
  audit: Add a new audit_get_ctime() helper
  landlock: Log domain properties and release
  landlock: Log mount-related denials
  landlock: Align partial refer access checks with final ones
  selftests/landlock: Add test to check partial access in a mount tree
  landlock: Optimize file path walks and prepare for audit support
  landlock: Log file-related denials
  landlock: Log truncate and ioctl denials
  landlock: Log TCP bind and connect denials
  landlock: Log scoped denials
  landlock: Control log events with LANDLOCK_RESTRICT_SELF_LOGLESS
  samples/landlock: Do not log denials from the sandboxer by default
  selftests/landlock: Extend tests for landlock_restrict_self()'s flags
  selftests/landlock: Add tests for audit
  selftests/landlock: Add audit tests for ptrace

 Documentation/userspace-api/landlock.rst      |   2 +-
 include/linux/audit.h                         |   8 +
 include/linux/lsm_audit.h                     |  22 +
 include/uapi/linux/audit.h                    |   5 +-
 include/uapi/linux/landlock.h                 |  14 +
 kernel/auditsc.c                              |  21 +-
 samples/landlock/sandboxer.c                  |  35 +-
 security/Kconfig                              |   5 +
 security/Makefile                             |   2 +-
 security/landlock/.kunitconfig                |   2 +
 security/landlock/Makefile                    |   2 +
 security/landlock/access.h                    | 100 ++++
 security/landlock/audit.c                     | 495 ++++++++++++++++++
 security/landlock/audit.h                     |  76 +++
 security/landlock/domain.c                    | 195 +++++++
 security/landlock/domain.h                    | 117 +++++
 security/landlock/fs.c                        | 279 +++++++---
 security/landlock/fs.h                        |  10 +
 security/landlock/id.c                        | 242 +++++++++
 security/landlock/id.h                        |  25 +
 security/landlock/net.c                       |  51 +-
 security/landlock/ruleset.c                   |  35 +-
 security/landlock/ruleset.h                   |  96 ++--
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  |  26 +-
 security/landlock/task.c                      | 150 +++++-
 security/lsm_audit.c                          |  27 +-
 tools/testing/kunit/configs/all_tests.config  |   2 +
 tools/testing/selftests/landlock/audit.h      | 308 +++++++++++
 tools/testing/selftests/landlock/audit_test.c | 168 ++++++
 tools/testing/selftests/landlock/base_test.c  |  18 +-
 tools/testing/selftests/landlock/common.h     |   2 +
 tools/testing/selftests/landlock/config       |   1 +
 tools/testing/selftests/landlock/fs_test.c    |  54 +-
 .../testing/selftests/landlock/ptrace_test.c  |  62 ++-
 35 files changed, 2454 insertions(+), 205 deletions(-)
 create mode 100644 security/landlock/access.h
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c
 create mode 100644 security/landlock/domain.h
 create mode 100644 security/landlock/id.c
 create mode 100644 security/landlock/id.h
 create mode 100644 tools/testing/selftests/landlock/audit.h
 create mode 100644 tools/testing/selftests/landlock/audit_test.c


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


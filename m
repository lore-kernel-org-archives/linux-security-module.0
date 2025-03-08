Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F61DE4E7
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459484; cv=none; b=Ke7W7bszu51aXSag/JHjRQWKXgE3XCzVzVYKaysMlbkDz5umQz3wuE7kyELuVagJEJp2KbFxuhDDuVgyPShLS8pU1ffmsGRU0+RfpH2moRetm9qYxUiQHqHgAru9/CT03eoRS7lhnLPiG9gWG/x26qv+0ZCftFxvZyEAIBmBYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459484; c=relaxed/simple;
	bh=XQRFwxmgfRwMhCfd4XHml0+Vhv2G7q0dSz5XCxpAZrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IpJ6ptBlL+cr4QZRgK0NF85VOgRJtYr1dLzLKg8gdmIXSKuAhHTT9EJCP14kW5T4VFiGzMlannNjUfcRcpSI9/4J9+uhNsB/eAkmThaACCrkoOikltMm7Bb9Eub8n75yNS5Yh3XzX+bk4/7LAsJKuh0PEd8OuRq1dwhqmcKSrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BsUvalJf; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BsUvalJf"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsF4mqvzPl1;
	Sat,  8 Mar 2025 19:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459473;
	bh=w4fcp7RxZrlDVZrfYcTugj+wIPVn1nBTu6gy1bbd7hY=;
	h=From:To:Cc:Subject:Date:From;
	b=BsUvalJfR+M0AdGEnj4WCa3ivKCKap1oe1ho9fxsYOBYRBv5HZCSs5Eon/FDvQOw+
	 HytHooTA/N/qyalWj5B4DlC5O3IQQGawbd62ZQFUi+rCwIEFjY5widRaZg7Vz3zZIs
	 LEUHxquAixU22TXxVh+qyCbaf/is1nOJzGIP0ORI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsD5Nqgzpkl;
	Sat,  8 Mar 2025 19:44:32 +0100 (CET)
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 00/26] Landlock audit support
Date: Sat,  8 Mar 2025 19:43:56 +0100
Message-ID: <20250308184422.2159360-1-mic@digikod.net>
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

Renamed the landlock_restrict_self(2) flags to improve clarity and
consistency, and slightly change the semantic of the first one:
- LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF: do not log denied access
  caused by a task with the same executable (i.e. before any new
  execve(2));
- LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC_ON: log denied access for
  processes resulting from an execve(2), which is not the case by
  default.
- LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF: do not log denied access
  from future nested domains.

These new LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC_ON are not incompatible anymore.

Make it possible to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
without ruleset/domain.  This bit is now stored directly in the Landlock
credentials, not a potential related domain.

Moved audit data declarations to not impact allowed requests.

Added new tests and improved previous ones.  I'm still working on new
tests but the kernel code should not change much with the next versions.
I'd still like to align as much as possible with other LSM logs
regarding the logged objects: e.g. in a link action, should we log the
dir's path or the file's dentry?

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

v5: https://lore.kernel.org/r/20250131163059.1139617-1-mic@digikod.net
v4: https://lore.kernel.org/r/20250108154338.1129069-1-mic@digikod.net
v3: https://lore.kernel.org/r/20241122143353.59367-1-mic@digikod.net
v2: https://lore.kernel.org/r/20241022161009.982584-1-mic@digikod.net
v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net

Regards,

Mickaël Salaün (26):
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
  selftests/landlock: Add audit tests for abstract unix socket scoping
  selftests/landlock: Add audit tests for filesystem
  landlock: Add audit documentation

 Documentation/admin-guide/LSM/index.rst       |   1 +
 Documentation/admin-guide/LSM/landlock.rst    | 158 ++++++
 Documentation/security/landlock.rst           |  13 +-
 Documentation/userspace-api/landlock.rst      |   9 +-
 MAINTAINERS                                   |   1 +
 include/linux/lsm_audit.h                     |   8 +
 include/uapi/linux/audit.h                    |   4 +-
 include/uapi/linux/landlock.h                 |  33 ++
 samples/landlock/sandboxer.c                  |  37 +-
 security/landlock/.kunitconfig                |   2 +
 security/landlock/Makefile                    |   5 +
 security/landlock/access.h                    |  23 +
 security/landlock/audit.c                     | 519 ++++++++++++++++++
 security/landlock/audit.h                     |  77 +++
 security/landlock/cred.c                      |  26 +-
 security/landlock/cred.h                      |  89 ++-
 security/landlock/domain.c                    | 264 +++++++++
 security/landlock/domain.h                    | 157 ++++++
 security/landlock/fs.c                        | 275 ++++++++--
 security/landlock/fs.h                        |  35 +-
 security/landlock/id.c                        | 251 +++++++++
 security/landlock/id.h                        |  25 +
 security/landlock/limits.h                    |   4 +
 security/landlock/net.c                       |  74 ++-
 security/landlock/ruleset.c                   |  33 +-
 security/landlock/ruleset.h                   |  47 +-
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  |  72 ++-
 security/landlock/task.c                      | 239 +++++---
 security/lsm_audit.c                          |  27 +-
 tools/testing/kunit/configs/all_tests.config  |   2 +
 tools/testing/selftests/landlock/Makefile     |   6 +-
 tools/testing/selftests/landlock/audit.h      | 425 ++++++++++++++
 tools/testing/selftests/landlock/audit_test.c | 460 ++++++++++++++++
 tools/testing/selftests/landlock/base_test.c  |  84 ++-
 tools/testing/selftests/landlock/common.h     |  19 +
 tools/testing/selftests/landlock/config       |   1 +
 tools/testing/selftests/landlock/fs_test.c    | 455 +++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  | 140 +++++
 .../landlock/scoped_abstract_unix_test.c      | 121 ++++
 .../selftests/landlock/wait-pipe-sandbox.c    | 131 +++++
 41 files changed, 4123 insertions(+), 231 deletions(-)
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


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.48.1


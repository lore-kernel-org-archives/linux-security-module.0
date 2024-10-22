Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A21A3BC3
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613430; cv=none; b=Zm31djyH5dJFIfBeW1PeexjYAupt9UdV6l4abDqYtQt8kzh9jYkBVzT/avGFusOP62GWiVT2mZFqAGczs8IgByYEzrutZTLBRdAuPH5J7tb0c4MJblm8fIB08hS+dhBmIDQfMpn5w0ry+ivtNe82OFIEQ+3BJI8zKc1thipnQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613430; c=relaxed/simple;
	bh=Gx7K93tco/f3kUEP0ibSTYE77XWjCbxn2u/mlhcRwrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdtHo4akxyT+A1GcF8JqhhMHNdP3oCqW8+7kYD9ZXgcJy7QKcv0hTOzOJOOBTXQcQhhTodxI/AoUWlORnXE5jd665HIIh9ihH6Nu1EGISggxXRVZakDJ903wIkOhJRfUhsBp0Rz+HOsVieMkgP594L2EnWTcj0QD2mIqnn5of0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lZk9GlnX; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lZk9GlnX"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwW0cWFz1BQt;
	Tue, 22 Oct 2024 18:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613418;
	bh=KFY8u2bH0C3z8fJsPFTlTGAhXjq/mWXiCLU1yqG/DXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lZk9GlnXcrQTfu6oO+pUkNPuJsQkMjLko+m7sw8TnfKG8jGkD8aMbSwQM3Hrzr2eI
	 eJ10BeZ8XLV6lLV7pDah8f/r0rrTTYXbcZSLrCo3PQ9OMJBUf/OFn/AbfKN/vA04Ms
	 meVxvWd+1jMapEGAlknLeh4vkFHW6kC1+fNpLhPY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwT5Lt1zx4q;
	Tue, 22 Oct 2024 18:10:17 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 00/14] Landlock audit support
Date: Tue, 22 Oct 2024 18:09:55 +0200
Message-ID: <20241022161009.982584-1-mic@digikod.net>
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
* app developers: to ease and speed up sandboxing support
* power users: to understand denials
* sysadmins: to look for users' issues
* security experts: to detect attack attempts

To make logs useful, they need to contain the most relevant Landlock
domain that denied an action, and the reason of such denial.  This
translates to the latest nested domain and the related blockers: missing
access rights or other kind of constraints (e.g. scoped domain).

# Changes from previous version

This second patch series brings a full implementation with a novel
design fitted to an unprivileged access control system.

The previous approach created log records for any Landlock syscall and
denials.  We now only create log records related to denied actions.

This series does not include documentation nor user space tests yet, but
KUnit tests are provided.

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
created.  This record contains the domain ID, the domain ID of its parent
domain (or 0 if none), and informations about the process that enforced
the restriction (at the time of the call to landlock_restrict_self):
PID, UID, executable path, and name (comm).

This new approach also brings building blocks for an upcoming
unprivileged introspection interface.  The unique Landlock IDs will be
useful to tie audit log entries to running processes, and to get
properties of the related Landlock domains.  This will replace the
previously logged ruleset properties.

# Samples

Here are two examples of log events:

$ LL_FS_RO=/ LL_FS_RW=/ ./sandboxer sh -c "LL_FS_RO=/ LL_FS_RW=/tmp LL_SCOPED=s ./sandboxer kill 1"

  type=UNKNOWN[1423] msg=audit(1.102:31): domain=5264859566 blockers=scope_signal opid=1 ocomm="systemd"
  type=UNKNOWN[1424] msg=audit(1.102:31): domain=5264859566 parent=5264859553 pid=290 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=UNKNOWN[1424] msg=audit(1.102:31): domain=5264859553 parent=0 pid=290 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(1.102:31): arch=c000003e syscall=62 success=no exit=-1 ...
  type=PROCTITLE msg=audit(1.102:31): proctitle=...
  type=UNKNOWN[1425] msg=audit(1.158:32): domain=5264859566
  type=UNKNOWN[1425] msg=audit(1.182:33): domain=5264859553

$ LL_FS_RO=/ LL_FS_RW=/tmp ./sandboxer sh -c "echo > /etc/passwd"

  type=UNKNOWN[1423] msg=audit(2.832:37): domain=5264859570 blockers=fs_write_file path="/etc/passwd" dev="vda2" ino=143821
  type=UNKNOWN[1424] msg=audit(2.832:37): domain=5264859570 parent=0 pid=296 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(2.832:37): arch=c000003e syscall=257 success=no exit=-13 ...
  type=PROCTITLE msg=audit(2.832:37): proctitle=...
  type=UNKNOWN[1425] msg=audit(2.892:38): domain=5264859570

# Future changes

It would be interesting to enhance audit with the ability to filter on
the executable path that created a sandbox, or to filter on a Landlock
domain ID.


This series is based on my "next" branch, which includes these patches:
https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net

Previous version:
v1: https://lore.kernel.org/r/20230921061641.273654-1-mic@digikod.net

Regards,

Mickaël Salaün (14):
  lsm: Only build lsm_audit.c if CONFIG_AUDIT is set
  lsm: Add audit_log_lsm_data() helper
  landlock: Factor out check_access_path()
  landlock: Add unique ID generator
  landlock: Move access types
  landlock: Move domain hierarchy management
  landlock: Log ptrace denials
  landlock: Log domain properties and release
  landlock: Log mount-related denials
  landlock: Log file-related denials
  landlock: Log truncate and ioctl denials
  landlock: Log TCP bind and connect denials
  landlock: Log scoped denials
  landlock: Control log events with LANDLOCK_RESTRICT_SELF_LOGLESS

 include/linux/lsm_audit.h                    |  22 +
 include/uapi/linux/audit.h                   |   5 +-
 include/uapi/linux/landlock.h                |  14 +
 security/Makefile                            |   2 +-
 security/landlock/.kunitconfig               |   2 +
 security/landlock/Makefile                   |   2 +
 security/landlock/access.h                   |  70 +++
 security/landlock/audit.c                    | 493 +++++++++++++++++++
 security/landlock/audit.h                    |  76 +++
 security/landlock/domain.c                   | 184 +++++++
 security/landlock/domain.h                   | 111 +++++
 security/landlock/fs.c                       | 210 ++++++--
 security/landlock/fs.h                       |  10 +
 security/landlock/id.c                       | 242 +++++++++
 security/landlock/id.h                       |  25 +
 security/landlock/net.c                      |  52 +-
 security/landlock/ruleset.c                  |  31 +-
 security/landlock/ruleset.h                  |  80 ++-
 security/landlock/setup.c                    |   2 +
 security/landlock/syscalls.c                 |  26 +-
 security/landlock/task.c                     | 150 +++++-
 security/lsm_audit.c                         |  27 +-
 tools/testing/kunit/configs/all_tests.config |   2 +
 23 files changed, 1692 insertions(+), 146 deletions(-)
 create mode 100644 security/landlock/access.h
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c
 create mode 100644 security/landlock/domain.h
 create mode 100644 security/landlock/id.c
 create mode 100644 security/landlock/id.h


base-commit: 2798d07e6d416164119e83c2cd1bb50160297ec8
-- 
2.47.0


Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580F23B62B
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486256; cv=none; b=FM2MeqZP21Vwekh/nYE4f1DaJ2IcHmfCsYHx/psCrnMJcaGi8DlX54xnPvgtoUxq2GxuOZ/kFLNOFklS/51qVfV/gGDy1/N0kXBBLni6ea6SepTbK1tbm3Ly+M/JZKPpsTPnPQUND5EO2gSkoXppzYNpvkFG2SW6+BdjEYaaMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486256; c=relaxed/simple;
	bh=/sUpxD3SiKizTTxPG90VwXj7lny4q31xrklPIUVxL+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkFvt9V4w8Ii1xL3z7Js1zUhGEy0mZ9A09K8dLAmtG8JaUL+eVp82TpiPFRYCn5CQ8IQbXPKkIh6xiHNDZfTM98SMdZaJk4l0TnnYqvnNRQ50/giBTvv+csLc6smeyh7GFaSXTEjxGKsBmnjkIACRnwA9sRlEpz8CnsvZC44gfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wYMTUKUn; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wYMTUKUn"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkF2BG3zxfS;
	Mon,  6 Apr 2026 16:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486245;
	bh=8X9vutfaraZKG57N5TmXyIzR74CkcQyp3ceZUBKuCqw=;
	h=From:To:Cc:Subject:Date:From;
	b=wYMTUKUnEusj5znbx7wtGQFJ0LCMMgpAssmGixhFYFLN7XWB82oLxffOTIjdrnozg
	 m62pTj9B8KPBqZhtO+LA4epAZlDUjy8s4T/5JFZiw/eNrNovtQPTG4cpxnQiwICIDL
	 ZxaGO2EPDAZwBhI0BXnLyNQgpo5RQHxsuU/40CuA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkD0KnYzgwq;
	Mon,  6 Apr 2026 16:37:23 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] Landlock tracepoints
Date: Mon,  6 Apr 2026 16:36:58 +0200
Message-ID: <20260406143717.1815792-1-mic@digikod.net>
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

This series adds 13 tracepoints that cover the full Landlock lifecycle,
from ruleset creation to domain destruction.  They can be used directly
via /sys/kernel/tracing/events/landlock/* or attached by eBPF programs
for richer introspection.

Patches 1-4 refactor Landlock internals: they split struct
landlock_domain from struct landlock_ruleset and move denial logging
into a common framework shared by audit and tracing.  Patch 5 adds
__print_untrusted_str() to the tracing core.  Patches 6-9 add
lifecycle tracepoints: ruleset creation and destruction, rule addition
for filesystem and network, domain enforcement and destruction, and
per-rule access checks.  Patch 10 sets audit_net.sk for socket access
checks.  Patches 11-12 add denial tracepoints for filesystem, network,
and scope operations.  Patches 13-16 add selftests and patch 17 adds
documentation.

Each rule type has a dedicated tracepoint with strongly-typed fields
(dev/ino for filesystem, port for network), following the same approach
as the audit logs.

This feature is useful to troubleshoot policy issues and should limit
the need for custom debugging kernel code when developing new Landlock
features.

Landlock already has audit support for logging denied access requests,
which is useful to identify security issues or sandbox misconfiguration.
However, audit might not be enough to debug Landlock policies.  The
main difference with audit events is that traces are disabled by
default, can be very verbose, and can be filtered according to process
and Landlock properties (e.g. domain ID).

As for audit, tracing may expose sensitive information about all
sandboxed processes on the system, and must only be accessible to the
system administrator.  For unprivileged monitoring scoped to a single
sandbox (e.g., interactive permission prompts), Tingmao Wang's
"Landlock supervise" RFC [1] proposes a dedicated userspace API.  The
infrastructure changes in this series (the domain type split, the
denial framework, and the tracepoint consistency guarantees) benefit
that approach.

I will release a companion tool that leverages these tracepoints to
monitor Landlock events in real time.

This series applies on top of my next branch [2].

Changes since RFC v1:
https://lore.kernel.org/r/20250523165741.693976-1-mic@digikod.net
- New patches 1-4: split struct landlock_domain from struct
  landlock_ruleset; split denial logging from audit into common
  framework with CONFIG_SECURITY_LANDLOCK_LOG.
- Patch 5 (was v1 3/5): removed WARN_ON() (pointed out by Steven
  Rostedt).
- New patch 6: added create_ruleset and free_ruleset tracepoints
  (split from the v1 add_rule_fs tracepoint patch).
- Patch 7 (was v1 4/5): added add_rule_net tracepoint, used
  ruleset Landlock ID instead of kernel pointer, added version
  field to struct landlock_ruleset, differentiated d_absolute_path()
  error cases (suggested by Tingmao Wang), moved
  DEFINE_FREE(__putname) to include/linux/fs.h (noticed by Tingmao
  Wang).
- New patch 8: added restrict_self and free_domain tracepoints.
- Patch 9 (was v1 5/5): merged find-rule consolidation, added
  check_rule_net tracepoint.
- New patch 10: split audit_net.sk fix with Fixes: tag.
- New patches 11-12: added denial tracepoints for filesystem,
  network, ptrace, and scope operations.
- New patches 13-17: split selftests into per-feature commits with
  documentation.

Regards,

Mickaël Salaün (17):
  landlock: Prepare ruleset and domain type split
  landlock: Move domain query functions to domain.c
  landlock: Split struct landlock_domain from struct landlock_ruleset
  landlock: Split denial logging from audit into common framework
  tracing: Add __print_untrusted_str()
  landlock: Add create_ruleset and free_ruleset tracepoints
  landlock: Add landlock_add_rule_fs and landlock_add_rule_net
    tracepoints
  landlock: Add restrict_self and free_domain tracepoints
  landlock: Add tracepoints for rule checking
  landlock: Set audit_net.sk for socket access checks
  landlock: Add landlock_deny_access_fs and landlock_deny_access_net
  landlock: Add tracepoints for ptrace and scope denials
  selftests/landlock: Add trace event test infrastructure and tests
  selftests/landlock: Add filesystem tracepoint tests
  selftests/landlock: Add network tracepoint tests
  selftests/landlock: Add scope and ptrace tracepoint tests
  landlock: Document tracepoints

 Documentation/admin-guide/LSM/landlock.rst    |  210 ++-
 Documentation/security/landlock.rst           |   35 +-
 Documentation/trace/events-landlock.rst       |  160 +++
 Documentation/trace/index.rst                 |    1 +
 Documentation/userspace-api/landlock.rst      |   11 +-
 MAINTAINERS                                   |    1 +
 include/linux/fs.h                            |    1 +
 include/linux/trace_events.h                  |    2 +
 include/trace/events/landlock.h               |  574 ++++++++
 include/trace/stages/stage3_trace_output.h    |    4 +
 include/trace/stages/stage7_class_define.h    |    1 +
 kernel/trace/trace_output.c                   |   41 +
 security/landlock/Kconfig                     |    5 +
 security/landlock/Makefile                    |   10 +-
 security/landlock/access.h                    |    4 +-
 security/landlock/cred.c                      |    6 +-
 security/landlock/cred.h                      |   29 +-
 security/landlock/domain.c                    |  445 ++++++-
 security/landlock/domain.h                    |  148 ++-
 security/landlock/fs.c                        |  201 ++-
 security/landlock/fs.h                        |   30 +
 security/landlock/id.h                        |    6 +-
 security/landlock/{audit.c => log.c}          |  261 +++-
 security/landlock/{audit.h => log.h}          |   25 +-
 security/landlock/net.c                       |   40 +-
 security/landlock/ruleset.c                   |  528 ++------
 security/landlock/ruleset.h                   |  237 ++--
 security/landlock/syscalls.c                  |   36 +-
 security/landlock/task.c                      |   22 +-
 tools/testing/selftests/landlock/audit.h      |   35 +-
 tools/testing/selftests/landlock/audit_test.c |  187 +++
 tools/testing/selftests/landlock/common.h     |   47 +
 tools/testing/selftests/landlock/config       |    2 +
 tools/testing/selftests/landlock/fs_test.c    |  218 +++
 tools/testing/selftests/landlock/net_test.c   |  547 +++++++-
 .../testing/selftests/landlock/ptrace_test.c  |  164 +++
 .../landlock/scoped_abstract_unix_test.c      |  195 +++
 .../selftests/landlock/scoped_signal_test.c   |  150 +++
 tools/testing/selftests/landlock/trace.h      |  640 +++++++++
 .../selftests/landlock/trace_fs_test.c        |  390 ++++++
 tools/testing/selftests/landlock/trace_test.c | 1168 +++++++++++++++++
 tools/testing/selftests/landlock/true.c       |   10 +
 42 files changed, 5991 insertions(+), 836 deletions(-)
 create mode 100644 Documentation/trace/events-landlock.rst
 create mode 100644 include/trace/events/landlock.h
 rename security/landlock/{audit.c => log.c} (73%)
 rename security/landlock/{audit.h => log.h} (74%)
 create mode 100644 tools/testing/selftests/landlock/trace.h
 create mode 100644 tools/testing/selftests/landlock/trace_fs_test.c
 create mode 100644 tools/testing/selftests/landlock/trace_test.c


base-commit: 8c6a27e02bc55ab110d1828610048b19f903aaec
-- 
2.53.0


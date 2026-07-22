Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C443CE5A
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740342; cv=none; b=QEt+h1LcgaZLdv4BXH+67ELWDx6mIv2b7i4EK+VyWzMaLmSGJb/DeUfKoSPK6SX6EJvFJGKOD9d69VjRE+E5xs3AvO+VpRINaKg+6k1PqZmgE6idC5QJc8qvYWmzWnpzaESEzIott643TCoevgk20Fq21PsGiOBUV+RoYb1c0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740342; c=relaxed/simple;
	bh=HjBosKNZCo5DO3wegVXtX45mRCkQaYhibZ7wCNObZ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ajwV6O2Cyl2vDDr5ulxK0hxFaiD1bT89XpLG3J6ankDmFu4qjToV9Y2ja81n3N2HyeaqMgPiYO7/I8sNcp7vKw/sRk5cn0DwcFTgmRWJCBLnJwcpWpypASPwEw5+xUC5qTR+tAvCaST8uh0pTjDvWlImOELmw4eGm2fKf8/g5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=I0BNexxd; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="I0BNexxd"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515R2mFKzrVl;
	Wed, 22 Jul 2026 19:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740331;
	bh=ec4CCnnkz182d/xxQlkHRmArN2FkXKONF7aZhqA2OLE=;
	h=From:To:Cc:Subject:Date:From;
	b=I0BNexxdch7H/fEbuW5qnV6ktzg7sKZWtvf+gIQ5zP5JlQbd3DhGU9RqClzAO7HG/
	 2M+2Y4Dl6Qgdoh7/FGW29iHBGwhGY4VZBd9m+qdXJI3gwhnIzUjvH0PlZSLdBhPVUs
	 K/8Y5hkbFLiCdPx3xqQIZUtgxu0qZaXFl4SSfW90=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515P3QzszBV3;
	Wed, 22 Jul 2026 19:12:09 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
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
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 00/20] Landlock tracepoints
Date: Wed, 22 Jul 2026 19:11:32 +0200
Message-ID: <20260722171159.2776765-1-mic@digikod.net>
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

This series adds 14 tracepoints that cover the full Landlock lifecycle,
from ruleset creation to domain destruction.  They can be used directly
via /sys/kernel/tracing/events/landlock/* or attached by eBPF programs
for richer introspection.

Christian, please take a look at patch 9, which adds
DEFINE_FREE(__putname) to include/linux/fs.h .

Steven, Masami, Mathieu, please take a look at patch 7, which adds
__print_untrusted_str() for trace events, and patches 8-14 which add
the new tracepoints.

This series now looks good to be merged in my "next" tree, provided VFS
and tracing maintainers are ok with it.

Patches 1-6 refactor Landlock internals: they split struct
landlock_domain from struct landlock_ruleset, move denial logging into a
common framework shared by audit and tracing, decouple the per-denial
logging decision from audit, and consolidate the access-right and scope
names into a shared header.  Patch 7 adds __print_untrusted_str() to the
tracing core.  Patches 8-12 add lifecycle tracepoints: ruleset creation
and destruction, rule addition for filesystem and network, domain
creation, enforcement, and destruction, and per-rule access checks.
Patches 13-14 add denial tracepoints for filesystem, network, ptrace,
and scope operations.  Patches 15-19 add selftests and patch 20 adds
documentation.

Each rule type has a dedicated tracepoint with strongly-typed fields
(dev/ino for filesystem, port for network), following the same approach
as the audit logs.

The scope and ptrace denial events also record the other party's
Landlock domain ID, so a consumer that tracked domain creation can
reproduce the two-domain verdict behind a relational denial.

This feature is useful to troubleshoot policy issues and should limit
the need for custom debugging kernel code when developing new Landlock
features.

Landlock already has audit support for logging denied access requests,
which is useful to identify security issues or sandbox misconfiguration.
However, audit might not be enough to debug Landlock policies.  The main
difference with audit events is that traces are disabled by default, can
be very verbose, and can be filtered according to process and Landlock
properties (e.g. domain ID).

As for audit, tracing may expose sensitive information about all
sandboxed processes on the system, and must only be accessible to the
system administrator.  For unprivileged monitoring scoped to a single
sandbox (e.g., interactive permission prompts), Tingmao Wang's "Landlock
supervise" RFC [1] proposes a dedicated userspace API.  The
infrastructure changes in this series (the domain type split, the denial
framework, and the tracepoint consistency guarantees) benefit that
approach.

I will release a companion tool that leverages these tracepoints to
monitor Landlock events in real time.

This series applies on top of v7.2-rc4.

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-1-mic@digikod.net
- Renamed the landlock_restrict_self tracepoint to
  landlock_create_domain and reordered its arguments to
  (domain, ruleset) for domain-first consistency with the other
  domain-lifecycle events.
- Ordered the add_rule_net and check_rule tracepoint arguments with the
  common part first: access_rights before port (add_rule_net), and
  domain, rule before access_request and the object (check_rule).
- Recorded the other party's Landlock domain as a scalar ID on scope
  and ptrace denials: target_domain=, peer_domain=, tracee_domain=
  (0 when unsandboxed).
- Replaced the deny events' log_same_exec and log_new_exec fields with a
  single kernel-computed logged field; logged and the quiet suppression
  are gated on CONFIG_SECURITY_LANDLOCK_LOG, so the value is identical
  in a tracepoints-only build (CONFIG_AUDIT=n).
- Fixed a NULL dereference in landlock_deny_access_fs on a denied
  ftruncate() or ioctl() by selecting the path from the request's
  audit-data type.
- Moved landlock_restrict_self's creation event under the ruleset lock,
  before the thread-sync; a thread-sync abort still emits the matching
  free_domain, keeping the create/free pair balanced.
- Split the denial-logging framework three ways (common log.c, audit.c,
  and a tracepoint-only trace.c), each behind its own CONFIG, so the
  tracepoints work without CONFIG_AUDIT and every commit stays
  bisectable.
- Rendered trace access masks as symbolic names (check_rule grants=,
  denial blockers=) instead of raw hex, and renamed the check_rule
  request= and denial comm= labels to access_request= and
  tracee_comm=/target_comm=.
- Reworked the trace documentation: consolidated the shared eBPF and
  trace-event guarantees into a DOC block, de-duplicated the admin
  guide and the trace event reference, and documented the logged field
  and the grants= format.
- Extended the trace selftests: asserted the relational domain-ID
  fields across the signal, abstract-unix-socket, and ptrace hooks,
  added a check_rule_net field test, and added landlock_enforce_domain
  coverage of the single-threaded, TSYNC, multi-threaded, non-leader,
  flags-only, and thread-sync-abort cases.
- New patch: added the landlock_enforce_domain tracepoint, the
  per-thread enforcement outcome, emitted once per thread the domain is
  applied to after its commit_creds().  It carries complete (the single
  event concluding the operation) and process_wide (the enforcement
  covers every eligible thread, via LANDLOCK_RESTRICT_SELF_TSYNC or a
  single-threaded process); complete && process_wide is the
  whole-process-enforced guarantee.
- New patch 5 factors the per-denial logging decision into a shared,
  config-independent logged verdict used by audit and tracing.
- New patch 6 consolidates the access-right and scope names in a shared
  header (enabling the symbolic rendering above).
- Dropped v2 patch 10 ("landlock: Set audit_net.sk for socket access
  checks") and its follow-up AF_UNSPEC UDP-send fix, both merged
  upstream; subsequent patches renumbered.

Changes since RFC v1:
https://patch.msgid.link/20250523165741.693976-1-mic@digikod.net
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

Closes: https://github.com/landlock-lsm/linux/issues/47
[1] https://lore.kernel.org/r/cover.1741047969.git.m@maowtm.org

Regards,

Mickaël Salaün (20):
  landlock: Prepare ruleset and domain type split
  landlock: Move domain query functions to domain.c
  landlock: Split struct landlock_domain from struct landlock_ruleset
  landlock: Split denial logging from audit into common framework
  landlock: Decouple the per-denial logging decision from CONFIG_AUDIT
  landlock: Consolidate access-right and scope names in a shared header
  tracing: Add __print_untrusted_str()
  landlock: Add create_ruleset and free_ruleset tracepoints
  landlock: Add landlock_add_rule_fs and landlock_add_rule_net
    tracepoints
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

 Documentation/admin-guide/LSM/landlock.rst    |  105 +-
 Documentation/security/landlock.rst           |   38 +-
 Documentation/trace/events-landlock.rst       |  313 ++++
 Documentation/trace/index.rst                 |    1 +
 Documentation/userspace-api/landlock.rst      |   14 +-
 MAINTAINERS                                   |    3 +
 include/linux/fs.h                            |    1 +
 include/linux/landlock.h                      |   56 +
 include/linux/trace_events.h                  |    2 +
 include/trace/events/landlock.h               |  908 +++++++++
 include/trace/stages/stage3_trace_output.h    |    4 +
 include/trace/stages/stage7_class_define.h    |    1 +
 kernel/trace/trace_output.c                   |   44 +
 security/landlock/Kconfig                     |    5 +
 security/landlock/Makefile                    |   12 +-
 security/landlock/access.h                    |    6 +-
 security/landlock/audit.c                     |  641 +------
 security/landlock/audit.h                     |   57 +-
 security/landlock/cred.c                      |   14 +-
 security/landlock/cred.h                      |   29 +-
 security/landlock/domain.c                    |  475 ++++-
 security/landlock/domain.h                    |  162 +-
 security/landlock/fs.c                        |  218 ++-
 security/landlock/fs.h                        |   38 +-
 security/landlock/id.h                        |    6 +-
 security/landlock/log.c                       |  586 ++++++
 security/landlock/log.h                       |   86 +
 security/landlock/net.c                       |   38 +-
 security/landlock/ruleset.c                   |  546 +-----
 security/landlock/ruleset.h                   |  250 +--
 security/landlock/syscalls.c                  |   89 +-
 security/landlock/task.c                      |   76 +-
 security/landlock/trace.c                     |  185 ++
 security/landlock/trace.h                     |   44 +
 security/landlock/tsync.c                     |   15 +
 tools/testing/selftests/landlock/audit.h      |   35 -
 tools/testing/selftests/landlock/common.h     |   47 +
 tools/testing/selftests/landlock/config       |    2 +
 tools/testing/selftests/landlock/fs_test.c    |  483 +++++
 tools/testing/selftests/landlock/net_test.c   |  747 +++++++-
 .../testing/selftests/landlock/ptrace_test.c  |  402 ++++
 .../landlock/scoped_abstract_unix_test.c      |  463 +++++
 .../selftests/landlock/scoped_signal_test.c   |  404 ++++
 tools/testing/selftests/landlock/trace.h      |  646 +++++++
 .../selftests/landlock/trace_fs_test.c        |  496 +++++
 tools/testing/selftests/landlock/trace_test.c | 1623 +++++++++++++++++
 tools/testing/selftests/landlock/true.c       |   10 +
 47 files changed, 8981 insertions(+), 1445 deletions(-)
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

-- 
2.54.0


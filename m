Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E655421236
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441434; cv=none; b=qAu7O795J+aVND65fqfDmvJgrEVtVZqVbiyyowtiamWKCNkqnhCPJuyI0baprF9fJUItNOyWAQe2KJ2HIxiou9J/u9oC0WZIcGguFVzzqMSKKiKjrFfNt6Cvz9RI8xXptGpRYznTkvJIISelILn+OVOVPfh9o1qVTW0ggcyhlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441434; c=relaxed/simple;
	bh=jtM0Ra8e88cVKa97St5vr4lB/vCKVIuY1xQzIgaH2qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXcziv/vWO6qjlVhTHa/PEfwqp1mpEGI+t8pJSrJRf2Gsmcy6uQZ4//Zb67pRtLrdpyGKrLP0SvsucXl2SW9oEfey859xcJkp24jJZh0UNZnKYp7se06Xla7PDQi8QR/XvTpg0c9x6Z43N6bWhkWSHi0hIHIdSMQeIM7FPiX/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lPPyJ3Z6; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lPPyJ3Z6"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK6Br0TSszCCk;
	Tue, 11 Aug 2026 11:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786441427;
	bh=KW+i5yys70vnVcQFN7BhajIkSYqFFFogDyPX1fbQoGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lPPyJ3Z6f4cUUtO+g+cOFq81cZ14rjVOYcmauqX4lhFXsc/Aeve62qhf65zDBTxDT
	 qHRtjs5HaNRz9coLO3sJc0dCtE+mJhU/xInEqfJU5J2xSb8lXz9/np45hWTi/Urn3s
	 8vkyv4UZft27kJ1J8OPO5IeHeafc2M7VBi5oAnwA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK6Bp2rLpzYlP;
	Tue, 11 Aug 2026 11:43:46 +0200 (CEST)
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
Subject: [PATCH v4 00/19] Landlock tracepoints
Date: Tue, 11 Aug 2026 11:43:14 +0200
Message-ID: <20260811094338.288094-1-mic@digikod.net>
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

This series is self-contained and intended to be merged through the
Landlock tree.

Earlier versions touched code owned by other subsystems: a
__print_untrusted_str() TP_printk helper in the tracing core
(kernel/trace/trace_output.c and include/trace/stages/) and a
DEFINE_FREE(__putname) cleanup guard in include/linux/fs.h.  To avoid
blocking the series on cross-tree review, both are now Landlock-private:
the untrusted-string escaping is a Landlock helper used only by the
Landlock trace events, and the __putname scope-guard is defined locally
in the Landlock filesystem code.

Steven, Masami, Mathieu, Christian: both helpers are generic and could
be useful beyond Landlock.  I kept them private only to avoid blocking
the series on cross-tree review, and I would be happy to move them
(back) into the tracing core and include/linux/fs.h as shared
helpers/functions/macros if you prefer, as a follow-up.

Patches 1-6 refactor Landlock internals: they split struct
landlock_domain from struct landlock_ruleset, move denial logging into a
common framework shared by audit and tracing, decouple the per-denial
logging decision from audit, and consolidate the access-right and scope
names into a shared header.  Patches 7-11 add lifecycle tracepoints:
ruleset creation and destruction, rule addition for filesystem and
network, domain creation, enforcement, and destruction, and per-rule
access checks.  Patches 12-13 add denial tracepoints for filesystem,
network, ptrace, and scope operations.  Patches 14-18 add selftests and
patch 19 adds documentation.

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

This series applies on top of the Landlock next branch.

Changes since v3:
https://patch.msgid.link/20260722171159.2776765-1-mic@digikod.net
- Renamed the exported rule-storage helper landlock_rule_insert() to
  landlock_store_rule(), restoring the verb-first naming convention
  (Justin Suess).
- Rebased onto landlock-next (was v7.2-rc4), merging the enforce_domain
  tracepoint with the new LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS handling
  in landlock_restrict_self(), and adding a no_new_privs field to
  enforce_domain that records the enforcing thread's no_new_privs state
  (so consumers see whether a domain is backed by no_new_privs or
  CAP_SYS_ADMIN).
- Made the tracepoint helpers Landlock-private so the series can be
  merged through the Landlock tree, dropping all include/trace/,
  kernel/trace/, and include/linux/fs.h changes: the untrusted-string
  escaping (formerly the core __print_untrusted_str() TP_printk helper)
  is now a static inline __trace_print_untrusted_str() folded into the
  add_rule tracepoint patch (Tingmao Wang's Reviewed-by of the standalone
  helper is credited there), and DEFINE_FREE(__putname) moved into the
  Landlock filesystem code.
- Gave __trace_print_untrusted_str() an explicit length so an abstract
  unix socket name with embedded NUL bytes is escaped in full instead of
  being truncated at the first NUL, with a regression test.
- Hardened the enforcement tests: enforce_abort uses 200 sibling threads
  so the thread-sync abort race is exercised on multi-core hosts, and
  the non-leader test asserts the reachable process_wide=0 (its former
  get_nr_threads()==1 precondition is unreachable through a zombie
  leader).
- Collapsed near-duplicate tracepoint selftests into FIXTURE_VARIANT
  tables with the same cases, assertions, and per-line coverage.

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-1-mic@digikod.net
- Renamed the landlock_restrict_self tracepoint to
  landlock_create_domain.
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
- New patch 5 factors the per-denial logging decision into a shared,
  config-independent logged verdict used by audit and tracing.
- New patch 6 consolidates the access-right and scope names in a shared
  header (enabling the symbolic rendering above).
- New patch 11 adds the landlock_enforce_domain tracepoint to complete
  landlock_create_domain.
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

Mickaël Salaün (19):
  landlock: Prepare ruleset and domain type split
  landlock: Move domain query functions to domain.c
  landlock: Split struct landlock_domain from struct landlock_ruleset
  landlock: Split denial logging from audit into common framework
  landlock: Decouple the per-denial logging decision from CONFIG_AUDIT
  landlock: Consolidate access-right and scope names in a shared header
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
 Documentation/trace/events-landlock.rst       |  326 ++++
 Documentation/trace/index.rst                 |    1 +
 Documentation/userspace-api/landlock.rst      |   12 +-
 MAINTAINERS                                   |    3 +
 include/linux/landlock.h                      |   56 +
 include/trace/events/landlock.h               |  965 ++++++++++
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
 security/landlock/fs.h                        |   40 +-
 security/landlock/id.h                        |    6 +-
 security/landlock/log.c                       |  586 ++++++
 security/landlock/log.h                       |   86 +
 security/landlock/net.c                       |   38 +-
 security/landlock/ruleset.c                   |  546 +-----
 security/landlock/ruleset.h                   |  250 +--
 security/landlock/syscalls.c                  |   90 +-
 security/landlock/task.c                      |   76 +-
 security/landlock/trace.c                     |  185 ++
 security/landlock/trace.h                     |   44 +
 security/landlock/tsync.c                     |   16 +
 tools/testing/selftests/landlock/audit.h      |   35 -
 tools/testing/selftests/landlock/common.h     |   47 +
 tools/testing/selftests/landlock/config       |    2 +
 tools/testing/selftests/landlock/fs_test.c    |  483 +++++
 tools/testing/selftests/landlock/net_test.c   |  590 +++++-
 .../testing/selftests/landlock/ptrace_test.c  |  402 ++++
 .../landlock/scoped_abstract_unix_test.c      |  264 +++
 .../selftests/landlock/scoped_signal_test.c   |  404 ++++
 tools/testing/selftests/landlock/trace.h      |  639 +++++++
 .../selftests/landlock/trace_fs_test.c        |  496 +++++
 tools/testing/selftests/landlock/trace_test.c | 1620 +++++++++++++++++
 tools/testing/selftests/landlock/true.c       |   10 +
 42 files changed, 8636 insertions(+), 1444 deletions(-)
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


Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12332384255
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486272; cv=none; b=Jg15dlDLnGsok7H0usFRohCqXQIoqoEB8JnezVH5Gw0u/CEVHLc1QQygoe1DkjMM5c4uDF8Zs92ZgJu5br+zMPnm5z04Bk2lKxheIMic7qKS2JOATZwvaV2QYBnPguCJD92fw+5NgSZLWzxDWRJTo0qkqPAcUkH1kngvS64CP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486272; c=relaxed/simple;
	bh=QnFTK7Qtifh4W60p4+Emj3zfNt0SCIuXHADWwidHeAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvGzvkF8vFTvTjUCgSqQ/mgwNqpA4mqha6cK4ePkEvlk85i9zStz9/fcrp5ikPZepETuN+3El6fQlPrmi9R4WnYpHBx5bhSYgJMdq+Xg20HdnMxtpX2daPnyCLKyr/ffBGKMTJwKI0RqtR2l3LCBEVEQcYezr20KS1RHKkodfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XTJwCZrR; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XTJwCZrR"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkg4h2bzX7k;
	Mon,  6 Apr 2026 16:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486267;
	bh=lbLHDMBM225gobd/q+iEadH2hKLDH83Cvi1YDuRbVmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTJwCZrRt/AUoo5RcLUAnZZRu2crIljRUUAA21e1R+zHKbjNYd4Nvhk+7HG+5TH6U
	 OntDHJTQ2nSJwD7X1KsjMKm4+FW/sTqXDTwibetg8rNTcyCrod7fXMWYZYOkziH+PF
	 xs0+raD1MnDqridldzK61Q7Jvl3rqzVKaX6b3Xa4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkf6jfyzZl6;
	Mon,  6 Apr 2026 16:37:46 +0200 (CEST)
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
Subject: [PATCH v2 17/17] landlock: Document tracepoints
Date: Mon,  6 Apr 2026 16:37:15 +0200
Message-ID: <20260406143717.1815792-18-mic@digikod.net>
In-Reply-To: <20260406143717.1815792-1-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tracepoint documentation to the kernel security documentation.
Describe the complete lifecycle of trace events (create, deny, free),
the enriched denial fields (same_exec, log_same_exec, log_new_exec), and
the design for both stateful (eBPF) and stateless (ftrace) consumers.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 Documentation/admin-guide/LSM/landlock.rst | 210 ++++++++++++++++++++-
 Documentation/security/landlock.rst        |  35 +++-
 Documentation/trace/events-landlock.rst    | 160 ++++++++++++++++
 Documentation/trace/index.rst              |   1 +
 Documentation/userspace-api/landlock.rst   |  11 +-
 5 files changed, 412 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/trace/events-landlock.rst

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9923874e2156..cad5845b6ec7 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -1,12 +1,13 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright © 2025 Microsoft Corporation
+.. Copyright © 2026 Cloudflare
 
 ================================
 Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: January 2026
+:Date: April 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -176,11 +177,218 @@ filters to limit noise with two complementary ways:
   programs,
 - or with audit rules (see :manpage:`auditctl(8)`).
 
+Tracepoints
+===========
+
+Landlock also provides tracepoints as an alternative to audit for
+debugging and observability.  Tracepoints fire unconditionally,
+independent of audit configuration, ``audit_enabled``, and domain log
+flags.  This makes them suitable for always-on monitoring with eBPF or
+for ad-hoc debugging with ``trace-pipe``.  See
+:doc:`/trace/events-landlock` for the complete event reference.
+
+Enabling tracepoints
+--------------------
+
+Enable individual Landlock tracepoints via tracefs::
+
+  # Enable filesystem denial tracing:
+  echo 1 > /sys/kernel/tracing/events/landlock/landlock_deny_access_fs/enable
+
+  # Enable all Landlock events:
+  echo 1 > /sys/kernel/tracing/events/landlock/enable
+
+  # Read the trace output:
+  cat /sys/kernel/tracing/trace_pipe
+
+Available events
+----------------
+
+**Policy setup events:**
+
+- ``landlock_create_ruleset`` -- emitted when a ruleset is created.
+  Fields: ``ruleset`` (ID and version), ``handled_fs``, ``handled_net``,
+  ``scoped``.
+
+- ``landlock_add_rule_fs``, ``landlock_add_rule_net`` -- emitted when a
+  rule is added.  Fields: ``ruleset`` (ID and version),
+  ``access_rights`` (access mask),
+  target identifier (``dev:ino`` and ``path`` for FS, ``port`` for net).
+
+- ``landlock_restrict_self`` -- emitted when a task restricts itself.
+  Fields: ``ruleset`` (ID and version), ``domain`` (new domain ID),
+  ``parent`` (parent domain ID or 0).
+
+**Access check events (hot path):**
+
+- ``landlock_check_rule_fs``, ``landlock_check_rule_net`` -- emitted
+  when a rule matches during an access check.  Fires for every matching
+  rule in the pathwalk, regardless of the final outcome (allowed or
+  denied).
+
+**Denial events:**
+
+- ``landlock_deny_access_fs``, ``landlock_deny_access_net`` -- emitted
+  when a filesystem or network access is denied.
+- ``landlock_deny_ptrace``, ``landlock_deny_scope_signal``,
+  ``landlock_deny_scope_abstract_unix_socket`` -- emitted when a scope
+  check denies access.
+
+  Common fields include:
+
+  - ``domain`` -- the denying domain's ID
+  - ``blockers`` -- the denied access rights (bitmask,
+    ``deny_access_fs`` and ``deny_access_net`` only)
+  - ``same_exec`` -- whether the task is the same executable that
+    called ``landlock_restrict_self()`` for the denying domain
+  - ``log_same_exec``, ``log_new_exec`` -- the domain's configured log
+    flags (useful for filtering expected denials)
+  - Type-specific fields: ``path`` (FS), ``sport``/``dport`` (net),
+    ``tracee_pid``/``comm`` (ptrace), ``target_pid``/``comm`` (signal),
+    ``peer_pid``/``sun_path`` (abstract unix socket)
+
+**Lifecycle events:**
+
+- ``landlock_free_domain`` -- emitted when a domain is deallocated.
+  Fields: ``domain`` (ID), ``denials`` (total denial count).
+- ``landlock_free_ruleset`` -- emitted when a ruleset is freed.
+  Fields: ``ruleset`` (ID and version).
+
+Event samples
+-------------
+
+A sandboxed program tries to read ``/etc/passwd`` with only ``/tmp``
+writable::
+
+  $ echo 1 > /sys/kernel/tracing/events/landlock/enable
+  $ LL_FS_RO=/ LL_FS_RW=/tmp ./sandboxer cat /etc/passwd &
+  $ cat /sys/kernel/tracing/trace_pipe
+  sandboxer-286  landlock_create_ruleset: ruleset=10b556c58.0 handled_fs=0xdfff handled_net=0x0 scoped=0x0
+  sandboxer-286  landlock_restrict_self: ruleset=10b556c58.3 domain=10b556c61 parent=0
+  cat-287        landlock_deny_access_fs: domain=10b556c61 same_exec=0 log_same_exec=1 log_new_exec=0 blockers=0x4 dev=254:2 ino=143821 path=/etc/passwd
+  kworker/0:1-12 landlock_free_domain: domain=10b556c61 denials=1
+
+Unlike audit, tracepoints fire for all denials regardless of the
+domain's log flags.  This means ``deny_access_*`` events appear even
+when ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF`` would suppress the
+corresponding audit record.
+
+Filtering with ftrace
+---------------------
+
+Use ftrace filter expressions to select specific events::
+
+  # Only show denials that audit would also log:
+  echo 'same_exec == 1 && log_same_exec == 1 || same_exec == 0 && log_new_exec == 1' > \
+    /sys/kernel/tracing/events/landlock/landlock_deny_access_fs/filter
+
+Using eBPF
+----------
+
+eBPF programs can attach to Landlock tracepoints to build custom
+monitoring.  A stateful eBPF program observes the full event stream and
+maintains per-domain state in BPF maps:
+
+1. On ``landlock_restrict_self``: record the domain ID, parent, flags.
+2. On ``landlock_deny_access_*``: look up the domain, decide whether
+   to count, alert, or ignore the denial based on custom policy.
+3. On ``landlock_free_domain``: clean up the per-domain state, log
+   final statistics.
+
+This approach requires no kernel modification and no Landlock-specific
+BPF helpers.  The Landlock IDs serve as correlation keys across events.
+
+.. _landlock_observability:
+
+When to use tracing vs audit
+-----------------------------
+
+Audit and tracing both help diagnose Landlock policy issues:
+
+**Audit** records denied accesses with the blockers, domain, and object
+identification (path, port).  Audit is the standard Linux mechanism for
+security events, with a stable record format that is well established
+and already supported by log management systems, SIEM platforms, and EDR
+solutions.  Audit is always active (when ``CONFIG_AUDIT`` is set),
+filtered by log flags to reduce noise in production, and designed for
+long-term security monitoring and compliance.
+
+**Tracing** provides deeper introspection for policy debugging.  In
+addition to denied accesses, trace events cover the complete lifecycle
+of Landlock objects (rulesets, domains) and intermediate rule matching
+during access checks.  Trace events are disabled by default (zero
+overhead) and fire unconditionally, regardless of log flags.  eBPF
+programs attached to trace events can access the full kernel context
+(ruleset rules, domain hierarchy, process credentials) via BTF, enabling
+richer analysis than the flat fields in audit records.  For example, an
+eBPF-based live monitoring tool can correlate creation, rule-addition,
+and denial events to build a real-time view of all active Landlock
+domains and their policies.  However, BTF-based access depends on
+internal kernel struct layouts which have no stability guarantee.  CO-RE
+(Compile Once, Run Everywhere) provides best-effort field relocation.
+The ftrace printk format is also not a stable ABI, but is
+self-describing via the per-event ``format`` file, allowing tools to
+adapt dynamically.
+
+Observability guarantees and limitations
+-----------------------------------------
+
+Both audit records and trace events are emitted for every denied access,
+with these exceptions:
+
+- **Log flags** (audit only): ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
+  ``LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON``, and
+  ``LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF`` control which denials
+  generate audit records.  Trace events fire regardless of these flags.
+
+- **NOAUDIT hooks**: Some LSM hooks suppress logging for speculative
+  permission probes (e.g., reading ``/proc/<pid>/status`` uses
+  ``PTRACE_MODE_NOAUDIT``).  When NOAUDIT is set, neither audit records
+  nor trace events are emitted, and the denial is not counted in
+  ``denials``.  The denial is still enforced.  This avoids performance
+  overhead and noise from speculative probes that test permissions
+  without performing an actual access.
+
+- **Audit rate limiting**: The audit subsystem may silently drop records
+  when the audit queue is full.  Trace events are not rate-limited.
+
+- **Tracepoint disabled**: When a trace event is disabled (the default
+  state), the tracepoint is a no-op with zero overhead.
+
+When both audit and tracing are active, every logged denial produces both
+an audit record (subject to log flags) and a trace event.  The
+``denials`` count in ``free_domain`` events reflects the total number of
+logged denials, which may be lower than the actual number of enforced
+denials due to NOAUDIT hooks.
+
+.. _landlock_observability_security:
+
+Observability security considerations
+---------------------------------------
+
+Both audit records and trace events expose information about all
+Landlock-sandboxed processes on the system, including filesystem paths
+being accessed, network ports, and process identities.  System
+administrators must ensure that access to audit logs (controlled by the
+audit subsystem configuration) and to trace events (requiring
+``CAP_SYS_ADMIN`` or ``CAP_BPF`` + ``CAP_PERFMON``) is restricted to
+trusted users.
+
+eBPF programs attached to Landlock trace events have access to the full
+kernel context of each event (ruleset rules, domain hierarchy, process
+credentials) via BTF.  This level of access is comparable to
+``CAP_SYS_ADMIN`` and must be treated accordingly.
+
+Audit logs and kernel trace events require elevated privileges and are
+system-wide; they are not designed for per-sandbox unprivileged
+monitoring.
+
 Additional documentation
 ========================
 
 * `Linux Audit Documentation`_
 * Documentation/userspace-api/landlock.rst
+* Documentation/trace/events-landlock.rst
 * Documentation/security/landlock.rst
 * https://landlock.io
 
diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index c5186526e76f..5ef0164fbafb 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -1,13 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
 .. Copyright © 2019-2020 ANSSI
+.. Copyright © 2026 Cloudflare
 
 ==================================
 Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: March 2026
+:Date: April 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -177,11 +178,43 @@ makes the reasoning much easier and helps avoid pitfalls.
 .. kernel-doc:: security/landlock/domain.h
     :identifiers:
 
+Denial logging
+==============
+
+Access denials are logged through two independent channels: audit
+records and tracepoints.  Both are managed by the common denial
+framework in ``log.c``, compiled under ``CONFIG_SECURITY_LANDLOCK_LOG``
+(automatically selected by ``CONFIG_AUDIT`` or ``CONFIG_TRACEPOINTS``).
+
+Audit records respect audit configuration, domain log flags, and
+``LANDLOCK_LOG_DISABLED``.  Tracepoints fire unconditionally,
+independent of audit configuration and domain log flags.  The denial
+counter (``num_denials``) is always incremented regardless of logging
+configuration.
+
+See Documentation/admin-guide/LSM/landlock.rst for audit record format,
+tracepoint usage, and filtering examples.
+
+.. kernel-doc:: security/landlock/log.h
+    :identifiers:
+
+Trace events
+------------
+
+See :doc:`/trace/events-landlock` for trace event usage and format details.
+
+.. kernel-doc:: include/trace/events/landlock.h
+    :doc: Landlock trace events
+
+.. kernel-doc:: include/trace/events/landlock.h
+    :internal:
+
 Additional documentation
 ========================
 
 * Documentation/userspace-api/landlock.rst
 * Documentation/admin-guide/LSM/landlock.rst
+* Documentation/trace/events-landlock.rst
 * https://landlock.io
 
 .. Links
diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
new file mode 100644
index 000000000000..802df09259ce
--- /dev/null
+++ b/Documentation/trace/events-landlock.rst
@@ -0,0 +1,160 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright © 2026 Cloudflare
+
+=====================
+Landlock Trace Events
+=====================
+
+:Date: April 2026
+
+Landlock emits trace events for sandbox lifecycle operations and access
+denials.  These events can be consumed by ftrace (for human-readable
+trace output and filtering) and by eBPF programs (for programmatic
+introspection via BTF).
+
+See Documentation/security/landlock.rst for Landlock kernel internals and
+Documentation/admin-guide/LSM/landlock.rst for system administration.
+
+.. warning::
+
+   Landlock trace events, like audit records, expose sensitive
+   information about all sandboxed processes on the system.  See
+   :ref:`landlock_observability_security` for security considerations
+   and privilege requirements.
+
+See Documentation/userspace-api/landlock.rst for the userspace API.
+
+Event overview
+==============
+
+Landlock trace events are organized in four categories:
+
+**Syscall events** are emitted during Landlock system calls:
+
+- ``landlock_create_ruleset``: a new ruleset is created
+- ``landlock_add_rule_fs``: a filesystem rule is added to a ruleset
+- ``landlock_add_rule_net``: a network port rule is added to a ruleset
+- ``landlock_restrict_self``: a new domain is created from a ruleset
+
+**Denial events** are emitted when an access is denied:
+
+- ``landlock_deny_access_fs``: filesystem access denied
+- ``landlock_deny_access_net``: network access denied
+- ``landlock_deny_ptrace``: ptrace access denied
+- ``landlock_deny_scope_signal``: signal delivery denied
+- ``landlock_deny_scope_abstract_unix_socket``: abstract unix socket
+  access denied
+
+**Rule evaluation events** are emitted during rule matching:
+
+- ``landlock_check_rule_fs``: a filesystem rule is evaluated
+- ``landlock_check_rule_net``: a network port rule is evaluated
+
+**Lifecycle events**:
+
+- ``landlock_free_domain``: a domain is freed
+- ``landlock_free_ruleset``: a ruleset is freed
+
+Enabling events
+===============
+
+Enable all Landlock events::
+
+    echo 1 > /sys/kernel/tracing/events/landlock/enable
+
+Enable a specific event::
+
+    echo 1 > /sys/kernel/tracing/events/landlock/landlock_deny_access_fs/enable
+
+Read the trace output::
+
+    cat /sys/kernel/tracing/trace_pipe
+
+Differences from audit records
+==============================
+
+Tracepoints and audit records both log Landlock denials, but differ
+in some field formats:
+
+- **Paths**: Tracepoints use ``d_absolute_path()`` (namespace-independent
+  absolute paths).  Audit uses ``d_path()`` (relative to the process's
+  chroot).  Tracepoint paths are deterministic regardless of the tracer's
+  mount namespace.
+
+- **Device names**: Tracepoints use numeric ``dev=<major>:<minor>``.
+  Audit uses string ``dev="<s_id>"``.  Numeric format is more precise
+  for machine parsing.
+
+- **Denied access field**: The ``deny_access_fs`` and ``deny_access_net``
+  tracepoints use the ``blockers=`` field name (same as audit).
+  Audit uses human-readable access right names (e.g.,
+  ``blockers=fs.read_file``), while tracepoints use a hex bitmask
+  (e.g., ``blockers=0x4``).  Scope and ptrace tracepoints omit
+  ``blockers`` because the event name identifies the denial type.
+
+- **Scope target names**: Tracepoints use role-specific field names
+  (``tracee_pid``, ``target_pid``, ``peer_pid``) that reflect the
+  semantic of each event.  Audit uses generic names (``opid``, ``ocomm``)
+  because the audit log format is not event-type-specific.
+
+- **Process name**: Scope tracepoints include ``comm=`` in the printk
+  output for stateless consumers.  eBPF consumers can read ``comm``
+  directly from the task_struct via BTF.  The ``comm`` value is treated
+  as untrusted input (escaped via ``__print_untrusted_str``).
+
+Ruleset versioning
+==================
+
+Syscall events include a ruleset version (``ruleset=<hex_id>.<version>``)
+that tracks the number of rules added to the ruleset.  The version is
+incremented on each ``landlock_add_rule()`` call and frozen at
+``landlock_restrict_self()`` time.  This enables trace consumers to
+correlate a domain with the exact set of rules it was created from.
+
+eBPF access
+===========
+
+eBPF programs attached via ``BPF_RAW_TRACEPOINT`` can access the
+tracepoint arguments directly through BTF.  The arguments include both
+standard kernel objects and Landlock-internal objects:
+
+- Standard kernel objects (``struct task_struct``, ``struct sock``,
+  ``struct path``, ``struct dentry``) can be used with existing BPF
+  helpers.
+- Landlock-internal objects (``struct landlock_domain``,
+  ``struct landlock_ruleset``, ``struct landlock_rule``,
+  ``struct landlock_hierarchy``) can be read via ``BPF_CORE_READ``.
+  Internal struct layouts may change between kernel versions; use CO-RE
+  for field relocation.
+
+All pointer arguments in the tracepoint prototypes are guaranteed
+non-NULL.
+
+Audit filtering equivalence
+============================
+
+Denial events include ``same_exec``, ``log_same_exec``, and
+``log_new_exec`` fields.  These allow both stateless (ftrace filter)
+and stateful (eBPF) consumers to replicate the audit subsystem's
+filtering logic::
+
+    # Show only denials that audit would also log:
+    echo 'same_exec==1 && log_same_exec==1 || same_exec==0 && log_new_exec==1' > \
+        /sys/kernel/tracing/events/landlock/landlock_deny_access_fs/filter
+
+Event reference
+===============
+
+.. kernel-doc:: include/trace/events/landlock.h
+    :doc: Landlock trace events
+
+.. kernel-doc:: include/trace/events/landlock.h
+    :internal:
+
+Additional documentation
+========================
+
+* Documentation/userspace-api/landlock.rst
+* Documentation/admin-guide/LSM/landlock.rst
+* Documentation/security/landlock.rst
+* https://landlock.io
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 338bc4d7cfab..d60e010e042b 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -54,6 +54,7 @@ applications.
    events-power
    events-nmi
    events-msr
+   events-landlock
    events-pci
    boottime-trace
    histogram
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..e65370212aa1 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2026
+:Date: April 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -698,8 +698,12 @@ Starting with the Landlock ABI version 7, it is possible to control logging of
 Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 ``LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON``, and
 ``LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF`` flags passed to
-sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
-for more details on audit.
+sys_landlock_restrict_self().  These flags control audit record generation.
+Landlock tracepoints are not affected by these flags and always fire when
+enabled, providing an alternative observability channel for debugging and
+monitoring.  See :doc:`/admin-guide/LSM/landlock` for more details
+on audit and tracepoints, and :doc:`/trace/events-landlock` for the
+complete trace event reference.
 
 Thread synchronization (ABI < 8)
 --------------------------------
@@ -814,6 +818,7 @@ Additional documentation
 ========================
 
 * Documentation/admin-guide/LSM/landlock.rst
+* Documentation/trace/events-landlock.rst
 * Documentation/security/landlock.rst
 * https://landlock.io
 
-- 
2.53.0


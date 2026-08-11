Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441232877C3
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441451; cv=none; b=R+K3Sn8Zm5Bzr5ebiSDdKIOttQMqBPkqirUyPxgiWEXHbtpkAPzhzFKSDKTv1J627uVbra9JHbUoegbzw2ra1WcO9WG+aJEhb5zw/LO+MhI6IX2z/Sta5RJ+rycmGXz8cI3Gbjh83KMfp9J7WsvxzW4EOyH9cV0Zjr2JZ1/6NEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441451; c=relaxed/simple;
	bh=poqJ0G0ovgmf08DhEkCYLP/aq8FhL58EgEAugPWozAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IItKpEqR1PSnR9mEjQQbuMkl3hlCyYOp6pbK8wAu8gS1Tqrkmm6H6MxgdU9xQfD9/sHwIUVmzl1JZiblvsBq36Uj5kaQTJ3ZJI0NtQHoltXTJgp8x/7DDfTk4IEV73Lq6KSfXjC1aaXJEnOxnBJcYIzuifFqGLV/4O1xmbHWqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qLu71PEJ; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qLu71PEJ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK6C34BgyzMqh;
	Tue, 11 Aug 2026 11:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786441439;
	bh=7IR5/lA7Ns+bZnjEnN4FkoU4CGvXaelN81H2yZyc8LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLu71PEJUgR5qTqjtT9MeSt5DJ67AihYgXPlt7VFayFke4L7vGjiMh5HCEvfR8d8Q
	 JPCsf+kqq0bJ+NvUnT7TJ284ulWggufSMG467zMrVXfUYIiX8xQ5w1Yqz8+sa/Xx8W
	 3nhzSJMr750U17puOhj/e6uToemfQhL5Pp+UHwq0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK6C23wlMzMMZ;
	Tue, 11 Aug 2026 11:43:58 +0200 (CEST)
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
Subject: [PATCH v4 07/19] landlock: Add create_ruleset and free_ruleset tracepoints
Date: Tue, 11 Aug 2026 11:43:21 +0200
Message-ID: <20260811094338.288094-8-mic@digikod.net>
In-Reply-To: <20260811094338.288094-1-mic@digikod.net>
References: <20260811094338.288094-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add the first Landlock tracepoints, for ruleset lifecycle:
landlock_create_ruleset fires from the landlock_create_ruleset() syscall
handler, and landlock_free_ruleset fires in free_ruleset() before the
ruleset is freed.

These tracepoints, and the ones added by the following commits, share a
common design.  Rather than one polymorphic event distinguished by a
status field (as audit uses a shared record type with a "status="
field), each lifecycle transition and denial type gets its own event
with a type-safe TP_PROTO, giving precise ftrace filtering by event name
and type-safe eBPF access.  TP_PROTO passes the object pointer and the
fields are read from it in TP_fast_assign, so an eBPF program reads the
full object state (rules, access masks, hierarchy) via BTF from a single
pointer rather than from the flattened TP_STRUCT__entry fields.  The
whole cost is paid only when a tracer is attached; the static branch is
not taken otherwise.  Trace fields carry the bare access-right and scope
names (read_file), reusing the audit name tables; audit prepends the
category (fs.read_file), which the trace event name already conveys.
The trace header's DOC comment documents the consistency and locking
guarantees these events share.

create_ruleset needs no lock because the ruleset is not yet shared (its
file descriptor is not yet installed).  The deallocation events use the
"free_" prefix, not "drop_", because they fire when the object is
actually freed.

Add trace.c, built for CONFIG_TRACEPOINTS, which defines
CREATE_TRACE_POINTS, and extend CONFIG_SECURITY_LANDLOCK_LOG to also be
selected by CONFIG_TRACEPOINTS so the common log framework is available
to a tracepoints-only build.

Add an id field to struct landlock_ruleset, gated on CONFIG_TRACEPOINTS
and assigned from landlock_get_id_range() at creation.  Only the
tracepoints consume it (audit identifies domains, not rulesets), so it
does not exist in an audit-only build.  The Landlock ID is a stable u64
that names the ruleset across the trace stream and uses the same scheme
as audit, so a ruleset can be correlated between trace and audit
records.

Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260722171159.2776765-9-mic@digikod.net
- Add clang-format off/on markers around the TRACE_EVENT() macros.

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-7-mic@digikod.net
- Reformatted TP_STRUCT__entry and TP_fast_assign to kernel tracing
  convention (requested by Steven Rostedt).
- Render the handled access masks as symbolic names with
  __print_flags(), shared with the audit blocker names.
- Move the id.h declaration guard widening (landlock_init_id,
  landlock_get_id_range) to the earlier commit that builds id.o under
  CONFIG_SECURITY_LANDLOCK_LOG, so intermediate patches build without
  CONFIG_AUDIT.
- Refine the trace-event consistency-guarantee DOC comment (observable
  from user space, balanced creation and deallocation events) and
  document why create_ruleset emits before the file descriptor is
  installed.
- Define CREATE_TRACE_POINTS in a dedicated trace.c built for
  CONFIG_TRACEPOINTS, and extend CONFIG_SECURITY_LANDLOCK_LOG to be
  selected by CONFIG_TRACEPOINTS here (the first tracepoint consumer),
  rather than placing CREATE_TRACE_POINTS in the audit and log
  translation unit.
- Gate the struct landlock_ruleset id field on CONFIG_TRACEPOINTS (only
  tracing uses it) instead of CONFIG_SECURITY_LANDLOCK_LOG.
- Drop Tingmao Wang's Reviewed-by; the patch was reworked.

Changes since v1:
- New patch (split from the v1 add_rule_fs tracepoint patch).
---
 MAINTAINERS                     |   1 +
 include/linux/landlock.h        |   1 +
 include/trace/events/landlock.h | 143 ++++++++++++++++++++++++++++++++
 security/landlock/Kconfig       |   2 +-
 security/landlock/Makefile      |   2 +
 security/landlock/ruleset.c     |   8 ++
 security/landlock/ruleset.h     |   9 ++
 security/landlock/syscalls.c    |  11 +++
 security/landlock/trace.c       |  17 ++++
 9 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/landlock.h
 create mode 100644 security/landlock/trace.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 61677067199b..95c90073e0bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14600,6 +14600,7 @@ F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
 F:	fs/ioctl.c
 F:	include/linux/landlock.h
+F:	include/trace/events/landlock.h
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
diff --git a/include/linux/landlock.h b/include/linux/landlock.h
index cabe6c784833..004cbd0b9298 100644
--- a/include/linux/landlock.h
+++ b/include/linux/landlock.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_LANDLOCK_H
 #define _LINUX_LANDLOCK_H
 
+#include <linux/types.h>
 #include <uapi/linux/landlock.h>
 
 /*
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
new file mode 100644
index 000000000000..02434f770455
--- /dev/null
+++ b/include/trace/events/landlock.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright © 2025 Microsoft Corporation
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM landlock
+
+#if !defined(_TRACE_LANDLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LANDLOCK_H
+
+#include <linux/landlock.h>
+#include <linux/tracepoint.h>
+
+struct landlock_ruleset;
+
+/* clang-format off */
+
+/* Maps a shared _LANDLOCK_*_NAMES entry to a __print_flags() pair. */
+#define _LANDLOCK_NAME_ENTRY(mask, name) { mask, name }
+
+/**
+ * DOC: Landlock trace events
+ *
+ * These guarantees and constraints hold for every Landlock tracepoint.
+ * A new tracepoint must uphold them, and an eBPF consumer can rely on
+ * them.
+ *
+ * Lifecycle consistency
+ * ~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * Lifecycle events are balanced: a creation event always has a matching
+ * deallocation event and vice versa, so an eBPF program can model object
+ * lifetimes from the trace stream without reconciliation logic.  A creation
+ * event fires while the object is still private to the calling thread
+ * (landlock_create_ruleset fires before the ruleset's file descriptor is
+ * installed, so it cannot race a concurrent :manpage:`close(2)`); if fd
+ * installation later fails and the ruleset is freed, free_ruleset still
+ * fires, keeping the pair balanced.  The domain pair (create_domain and
+ * free_domain) is balanced the same way: create_domain fires when the
+ * domain is created (under the ruleset lock, before thread-sync), and
+ * free_domain fires when it is freed.  A rare thread-sync failure aborts
+ * the just-created domain, which then emits both events (its creation, then
+ * an immediate free).  Denial events fire only for denials that actually
+ * happen.
+ *
+ * Pointer access
+ * ~~~~~~~~~~~~~~
+ *
+ * All pointer arguments in TP_PROTO are guaranteed non-NULL by the
+ * caller, but pointers reached through them may still be NULL (e.g.,
+ * hierarchy->parent at a root domain) and must be checked.  eBPF programs
+ * read these pointers via BTF for richer introspection than the
+ * TP_STRUCT__entry fields, which serve TP_printk display only.
+ *
+ * Mutable object pointers are passed while the caller holds the object's
+ * lock, so TP_fast_assign and a BTF reader see the exact object the event
+ * reports, a snapshot no concurrent writer can change: add_rule holds the
+ * modified ruleset's lock, and create_domain holds the ruleset lock across
+ * the emission (before the thread-sync wait) so the inspected ruleset is
+ * the one merged into the domain.  Objects immutable at the emission site
+ * (a domain after creation, a hierarchy at its last reference) need no
+ * lock.  A few values that no held lock protects are a best-effort
+ * lockless snapshot instead: a task's comm, and the deny_access_net struct
+ * sock (whose network hook holds no socket lock), matching how the sched
+ * and signal trace events sample comm.
+ */
+
+/**
+ * landlock_create_ruleset - New ruleset created
+ *
+ * @ruleset: Newly created ruleset (never NULL); not yet shared via an fd,
+ *           so no lock is needed.
+ *
+ * Emitted by sys_landlock_create_ruleset() while the new ruleset is still
+ * private to the calling thread, before its file descriptor is installed,
+ * so it cannot race a concurrent :manpage:`close(2)`.  Balanced by a
+ * matching landlock_free_ruleset event.
+ */
+TRACE_EVENT(landlock_create_ruleset,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset),
+
+	TP_ARGS(ruleset),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		ruleset_id	)
+		__field(	access_mask_t,	handled_fs	)
+		__field(	access_mask_t,	handled_net	)
+		__field(	access_mask_t,	scoped		)
+	),
+
+	TP_fast_assign(
+		__entry->ruleset_id	= ruleset->id;
+		__entry->handled_fs	= ruleset->handled_masks.fs;
+		__entry->handled_net	= ruleset->handled_masks.net;
+		__entry->scoped		= ruleset->handled_masks.scope;
+	),
+
+	TP_printk("ruleset=%llx handled_fs=%s handled_net=%s scoped=%s",
+		__entry->ruleset_id,
+		__print_flags(__entry->handled_fs, "|", _LANDLOCK_ACCESS_FS_NAMES),
+		__print_flags(__entry->handled_net, "|", _LANDLOCK_ACCESS_NET_NAMES),
+		__print_flags(__entry->scoped, "|", _LANDLOCK_SCOPE_NAMES))
+);
+
+/**
+ * landlock_free_ruleset - Ruleset freed
+ *
+ * @ruleset: Ruleset being freed (never NULL); at its last reference, so no
+ *           lock is needed.
+ *
+ * Emitted when a ruleset's last reference is dropped (typically when
+ * the creating process closes the ruleset file descriptor).  Fires even
+ * when file-descriptor installation failed after creation, keeping the
+ * create/free pair balanced.
+ */
+TRACE_EVENT(landlock_free_ruleset,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset),
+
+	TP_ARGS(ruleset),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		ruleset_id	)
+	),
+
+	TP_fast_assign(
+		__entry->ruleset_id	= ruleset->id;
+	),
+
+	TP_printk("ruleset=%llx", __entry->ruleset_id)
+);
+
+#undef _LANDLOCK_NAME_ENTRY
+
+#endif /* _TRACE_LANDLOCK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
+
+/* clang-format on */
diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index b4e7f0e9ba9b..7aeac29160e8 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -24,7 +24,7 @@ config SECURITY_LANDLOCK
 config SECURITY_LANDLOCK_LOG
 	bool
 	depends on SECURITY_LANDLOCK
-	default y if AUDIT
+	default y if AUDIT || TRACEPOINTS
 
 config SECURITY_LANDLOCK_KUNIT_TEST
 	bool "KUnit tests for Landlock" if !KUNIT_ALL_TESTS
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 2462e6c5921e..2711f4876939 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -18,3 +18,5 @@ landlock-$(CONFIG_SECURITY_LANDLOCK_LOG) += \
 	log.o
 
 landlock-$(CONFIG_AUDIT) += audit.o
+
+landlock-$(CONFIG_TRACEPOINTS) += trace.o
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 2b74542ac3d1..30f3897a56d4 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -23,10 +23,13 @@
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
+#include "id.h"
 #include "limits.h"
 #include "object.h"
 #include "ruleset.h"
 
+#include <trace/events/landlock.h>
+
 struct landlock_ruleset *
 landlock_create_ruleset(const access_mask_t fs_access_mask,
 			const access_mask_t net_access_mask,
@@ -50,6 +53,10 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 	new_ruleset->rules.root_net_port = RB_ROOT;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
+#ifdef CONFIG_TRACEPOINTS
+	new_ruleset->id = landlock_get_id_range(1);
+#endif /* CONFIG_TRACEPOINTS */
+
 	/* Should already be checked in landlock_create_ruleset(). */
 	if (fs_access_mask) {
 		const access_mask_t mask = fs_access_mask &
@@ -325,6 +332,7 @@ void landlock_free_rules(struct landlock_rules *const rules)
 static void free_ruleset(struct landlock_ruleset *const ruleset)
 {
 	might_sleep();
+	trace_landlock_free_ruleset(ruleset);
 	landlock_free_rules(&ruleset->rules);
 	kfree(ruleset);
 }
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 3a9fc39e947c..dcc363740b85 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2026 Cloudflare, Inc.
  */
 
 #ifndef _SECURITY_LANDLOCK_RULESET_H
@@ -164,6 +165,14 @@ struct landlock_ruleset {
 	 * @usage: Number of file descriptors referencing this ruleset.
 	 */
 	refcount_t usage;
+
+#ifdef CONFIG_TRACEPOINTS
+	/**
+	 * @id: Unique identifier for this ruleset, used for tracing.
+	 */
+	u64 id;
+#endif /* CONFIG_TRACEPOINTS */
+
 	/**
 	 * @quiet_masks: Stores the quiet flags for an unmerged ruleset.  For a
 	 * merged domain, this is stored in each layer's struct
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 37cadb63db9f..7f168802b584 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -38,6 +38,8 @@
 #include "setup.h"
 #include "tsync.h"
 
+#include <trace/events/landlock.h>
+
 static bool is_initialized(void)
 {
 	if (likely(landlock_initialized))
@@ -281,6 +283,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	ruleset->quiet_masks.net = ruleset_attr.quiet_access_net;
 	ruleset->quiet_masks.scope = ruleset_attr.quiet_scoped;
 
+	/*
+	 * Emits before anon_inode_getfd() installs the file descriptor, while
+	 * the ruleset is still private to this thread: no lock is needed, and
+	 * the event cannot race a concurrent close() freeing the ruleset under
+	 * the tracepoint's BTF read.  This is the last point at which the
+	 * ruleset is guaranteed alive and unshared.
+	 */
+	trace_landlock_create_ruleset(ruleset);
+
 	/* Creates anonymous FD referring to the ruleset. */
 	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 				      ruleset, O_RDWR | O_CLOEXEC);
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
new file mode 100644
index 000000000000..aeb6eeebe42a
--- /dev/null
+++ b/security/landlock/trace.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Tracepoint helpers
+ *
+ * Copyright © 2025 Microsoft Corporation
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#include "ruleset.h"
+
+/*
+ * Generates the tracepoint definitions in this translation unit.  The trace
+ * event header dereferences the traced objects in TP_fast_assign, so the full
+ * struct definitions (e.g. ruleset.h) must be included before it.
+ */
+#define CREATE_TRACE_POINTS
+#include <trace/events/landlock.h>
-- 
2.54.0


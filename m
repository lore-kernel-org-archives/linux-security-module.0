Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415D385515
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486984; cv=none; b=XCYMmk0jP36VKDN6J3w1xWbjUkML9Jl9UAsVpqZbhS9VcxWUokFi+DpGR7dgxaqm3TcvHpNv0FuUcm8wCUoZvyJR5iUDfpye5z6dNIOVweq5LnXru5aj46Ewq/ikptOFg+gCXic7503iS+gCuSofSMeZ94h9cE7iKj9Hle/gJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486984; c=relaxed/simple;
	bh=JMPfhoCHU35Syhu1NXTKVPBrgK+EbzG56394FwE2704=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3/AIOvOYubT4tHO/s9jjFa6UW9uDGXWzN7K5HhCGDPS8r3nWCWI2n5AC1E+3OY3t2bJd6iNFrWHlOHCQhbTwHHqSj/b6C85a8Q42Ig8qrAKn8wB4Z+jZeqvlOGedKe5JQWBJPR2hq4oqSjIQp2tEAxOgP1QXLbZe9IV1K8WgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vG0t83rO; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vG0t83rO"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkZ0q1gzWVg;
	Mon,  6 Apr 2026 16:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486262;
	bh=KWeXR2ewP5pRXcGzGP0ipoSsTjmwsJW3hYcFY7P3mb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vG0t83rOT5+cLxesSre0IBImZdLOUxAxDAXi8iVlRjVrCWFbuoB+g/laGR/LibDu8
	 AKcv23S6ShZ2cxXnzbdf6PrGyQOhK80f/tpOVFuuCcK9FETUDc6BzM1boFfmCxfcZv
	 rLrq3fRPA+y4fnmi4PietrUdgc2rNhuOrMK+O4eg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkY2j9gzFF0;
	Mon,  6 Apr 2026 16:37:41 +0200 (CEST)
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
Subject: [PATCH v2 13/17] selftests/landlock: Add trace event test infrastructure and tests
Date: Mon,  6 Apr 2026 16:37:11 +0200
Message-ID: <20260406143717.1815792-14-mic@digikod.net>
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

Add tracefs test infrastructure in trace.h: helpers for mounting
tracefs, enabling/disabling events, reading the trace buffer, counting
regex matches, and extracting field values.  Add per-event regex
patterns for matching trace lines.

The TRACE_PREFIX macro matches the ftrace trace-file line format with
either the expected task name (truncated to TASK_COMM_LEN - 1) or
"<...>" (for evicted comm cache entries).  All regex patterns are
anchored with ^ and $, verify every TP_printk field, and use no
unescaped dot characters.

Extend the existing true helper to open its working directory before
exiting, which triggers a read_dir denial when executed inside a
sandbox.  The exec-based tests use this to verify same_exec=0 and log
flag behavior after exec.

Add trace_test.c with the trace fixture (setup enables all available
events with a PID filter, teardown disables and clears) and lifecycle
and API tests: no_trace_when_disabled, create_ruleset, ruleset_version,
restrict_self, restrict_self_nested, restrict_self_invalid,
add_rule_invalid_fd, add_rule_net_fields, free_domain,
free_ruleset_on_close.

Add denial field and log flag tests: deny_access_fs_fields,
same_exec_before_exec, same_exec_after_exec, log_flags_same_exec_off,
log_flags_new_exec_on, log_flags_subdomains_off,
non_audit_visible_denial_counting.

Move regex_escape() from audit.h to common.h for shared use by both
audit and trace tests.

Enable CONFIG_FTRACE_SYSCALLS alongside CONFIG_FTRACE in the selftest
config because CONFIG_FTRACE alone only enables the tracer menu without
activating any tracer.  CONFIG_FTRACE_SYSCALLS is the lightest tracer
option that selects GENERIC_TRACER, TRACING, and TRACEPOINTS, which are
required for tracefs and Landlock trace events.  Both UML and x86_64
provide the required HAVE_SYSCALL_TRACEPOINTS.  When CONFIG_FTRACE is
disabled, CONFIG_FTRACE_SYSCALLS is gated by the FTRACE menu and cannot
be set, so TRACEPOINTS is correctly disabled.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/audit.h      |   35 +-
 tools/testing/selftests/landlock/common.h     |   47 +
 tools/testing/selftests/landlock/config       |    2 +
 tools/testing/selftests/landlock/trace.h      |  640 +++++++++
 tools/testing/selftests/landlock/trace_test.c | 1168 +++++++++++++++++
 tools/testing/selftests/landlock/true.c       |   10 +
 6 files changed, 1868 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/trace.h
 create mode 100644 tools/testing/selftests/landlock/trace_test.c

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 834005b2b0f0..84bb8f34bc83 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -206,40 +206,7 @@ static int audit_set_status(int fd, __u32 key, __u32 val)
 	return audit_request(fd, &msg, NULL);
 }
 
-/* Returns a pointer to the last filled character of @dst, which is `\0`.  */
-static __maybe_unused char *regex_escape(const char *const src, char *dst,
-					 size_t dst_size)
-{
-	char *d = dst;
-
-	for (const char *s = src; *s; s++) {
-		switch (*s) {
-		case '$':
-		case '*':
-		case '.':
-		case '[':
-		case '\\':
-		case ']':
-		case '^':
-			if (d >= dst + dst_size - 2)
-				return (char *)-ENOMEM;
-
-			*d++ = '\\';
-			*d++ = *s;
-			break;
-		default:
-			if (d >= dst + dst_size - 1)
-				return (char *)-ENOMEM;
-
-			*d++ = *s;
-		}
-	}
-	if (d >= dst + dst_size - 1)
-		return (char *)-ENOMEM;
-
-	*d = '\0';
-	return d;
-}
+/* regex_escape() is defined in common.h */
 
 /*
  * @domain_id: The domain ID extracted from the audit message (if the first part
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 90551650299c..dfc0df543e56 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -251,3 +251,50 @@ static void __maybe_unused set_unix_address(struct service_fixture *const srv,
 	srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
 	srv->unix_addr.sun_path[0] = '\0';
 }
+
+/**
+ * regex_escape - Escape BRE metacharacters in a string
+ *
+ * @src: Source string to escape.
+ * @dst: Destination buffer for the escaped string.
+ * @dst_size: Size of the destination buffer.
+ *
+ * Escapes characters that have special meaning in POSIX Basic Regular
+ * Expressions: $ * . [ \ ] ^
+ *
+ * Returns a pointer to the NUL terminator in @dst (cursor-style API for
+ * chaining), or (char *)-ENOMEM if the buffer is too small.
+ */
+static __maybe_unused char *regex_escape(const char *const src, char *dst,
+					 size_t dst_size)
+{
+	char *d = dst;
+
+	for (const char *s = src; *s; s++) {
+		switch (*s) {
+		case '$':
+		case '*':
+		case '.':
+		case '[':
+		case '\\':
+		case ']':
+		case '^':
+			if (d >= dst + dst_size - 2)
+				return (char *)-ENOMEM;
+
+			*d++ = '\\';
+			*d++ = *s;
+			break;
+		default:
+			if (d >= dst + dst_size - 1)
+				return (char *)-ENOMEM;
+
+			*d++ = *s;
+		}
+	}
+	if (d >= dst + dst_size - 1)
+		return (char *)-ENOMEM;
+
+	*d = '\0';
+	return d;
+}
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 8fe9b461b1fd..acfa31670c44 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -2,6 +2,8 @@ CONFIG_AF_UNIX_OOB=y
 CONFIG_AUDIT=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_FTRACE=y
+CONFIG_FTRACE_SYSCALLS=y
 CONFIG_INET=y
 CONFIG_IPV6=y
 CONFIG_KEYS=y
diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
new file mode 100644
index 000000000000..d8a4eb0906f0
--- /dev/null
+++ b/tools/testing/selftests/landlock/trace.h
@@ -0,0 +1,640 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock trace test helpers
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <regex.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+#define TRACEFS_ROOT "/sys/kernel/tracing"
+#define TRACEFS_LANDLOCK_DIR TRACEFS_ROOT "/events/landlock"
+#define TRACEFS_CREATE_RULESET_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_create_ruleset/enable"
+#define TRACEFS_RESTRICT_SELF_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_restrict_self/enable"
+#define TRACEFS_ADD_RULE_FS_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_fs/enable"
+#define TRACEFS_ADD_RULE_NET_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_net/enable"
+#define TRACEFS_CHECK_RULE_FS_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_fs/enable"
+#define TRACEFS_CHECK_RULE_NET_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_net/enable"
+#define TRACEFS_DENY_ACCESS_FS_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_deny_access_fs/enable"
+#define TRACEFS_DENY_ACCESS_NET_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_deny_access_net/enable"
+#define TRACEFS_DENY_PTRACE_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_deny_ptrace/enable"
+#define TRACEFS_DENY_SCOPE_SIGNAL_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_deny_scope_signal/enable"
+#define TRACEFS_DENY_SCOPE_ABSTRACT_UNIX_SOCKET_ENABLE \
+	TRACEFS_LANDLOCK_DIR                           \
+	"/landlock_deny_scope_abstract_unix_socket/enable"
+#define TRACEFS_FREE_DOMAIN_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_free_domain/enable"
+#define TRACEFS_FREE_RULESET_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_free_ruleset/enable"
+#define TRACEFS_TRACE TRACEFS_ROOT "/trace"
+#define TRACEFS_SET_EVENT_PID TRACEFS_ROOT "/set_event_pid"
+#define TRACEFS_OPTIONS_EVENT_FORK TRACEFS_ROOT "/options/event-fork"
+
+#define TRACE_BUFFER_SIZE (64 * 1024)
+
+/*
+ * Trace line prefix: matches the ftrace "trace" file format.  Format: "
+ * <task>-<pid> [<cpu>] <flags> <timestamp>: "
+ *
+ * The task parameter must be a string literal truncated to 15 chars
+ * (TASK_COMM_LEN - 1), matching what the kernel stores in task->comm.  The
+ * pattern accepts either the expected task name or "<...>" because the ftrace
+ * comm cache may evict short-lived processes (e.g., forked children that exit
+ * before the trace buffer is read).
+ *
+ * No unescaped '.' in any REGEX macro; literal dots use '\\.'.
+ */
+/* clang-format off */
+#define TRACE_PREFIX(task)                                                     \
+	"^ *\\(<\\.\\.\\.>"                                                    \
+	"\\|" task "\\)"                                                       \
+	"-[0-9]\\+ *\\[[0-9]\\+\\] [^ ]\\+ \\+[0-9]\\+\\.[0-9]\\+: "
+
+/*
+ * Task name for events emitted by kworker threads (e.g., free_domain fires from
+ * a work queue, not from the test process).
+ */
+#define KWORKER_TASK "kworker/[0-9]\\+:[0-9]\\+"
+
+#define REGEX_ADD_RULE_FS(task)            \
+	TRACE_PREFIX(task)                 \
+	"landlock_add_rule_fs: "           \
+	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
+	"access_rights=0x[0-9a-f]\\+ "    \
+	"dev=[0-9]\\+:[0-9]\\+ "          \
+	"ino=[0-9]\\+ "                   \
+	"path=[^ ]\\+$"
+
+#define REGEX_ADD_RULE_NET(task)            \
+	TRACE_PREFIX(task)                  \
+	"landlock_add_rule_net: "           \
+	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
+	"access_rights=0x[0-9a-f]\\+ "    \
+	"port=[0-9]\\+$"
+
+#define REGEX_CREATE_RULESET(task)          \
+	TRACE_PREFIX(task)                  \
+	"landlock_create_ruleset: "         \
+	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
+	"handled_fs=0x[0-9a-f]\\+ "       \
+	"handled_net=0x[0-9a-f]\\+ "      \
+	"scoped=0x[0-9a-f]\\+$"
+
+#define REGEX_RESTRICT_SELF(task)           \
+	TRACE_PREFIX(task)                  \
+	"landlock_restrict_self: "          \
+	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
+	"domain=[0-9a-f]\\+ "             \
+	"parent=[0-9a-f]\\+$"
+
+#define REGEX_CHECK_RULE_FS(task)    \
+	TRACE_PREFIX(task)           \
+	"landlock_check_rule_fs: "   \
+	"domain=[0-9a-f]\\+ "       \
+	"request=0x[0-9a-f]\\+ "    \
+	"dev=[0-9]\\+:[0-9]\\+ "    \
+	"ino=[0-9]\\+ "             \
+	"allowed={[0-9a-fx, ]*}$"
+
+#define REGEX_CHECK_RULE_NET(task)    \
+	TRACE_PREFIX(task)            \
+	"landlock_check_rule_net: "   \
+	"domain=[0-9a-f]\\+ "        \
+	"request=0x[0-9a-f]\\+ "     \
+	"port=[0-9]\\+ "             \
+	"allowed={[0-9a-fx, ]*}$"
+
+#define REGEX_DENY_ACCESS_FS(task)    \
+	TRACE_PREFIX(task)              \
+	"landlock_deny_access_fs: "    \
+	"domain=[0-9a-f]\\+ "          \
+	"same_exec=[01] "              \
+	"log_same_exec=[01] "          \
+	"log_new_exec=[01] "           \
+	"blockers=0x[0-9a-f]\\+ "      \
+	"dev=[0-9]\\+:[0-9]\\+ "       \
+	"ino=[0-9]\\+ "                \
+	"path=[^ ]*$"
+
+#define REGEX_DENY_ACCESS_NET(task)    \
+	TRACE_PREFIX(task)              \
+	"landlock_deny_access_net: "   \
+	"domain=[0-9a-f]\\+ "          \
+	"same_exec=[01] "              \
+	"log_same_exec=[01] "          \
+	"log_new_exec=[01] "           \
+	"blockers=0x[0-9a-f]\\+ "      \
+	"sport=[0-9]\\+ "              \
+	"dport=[0-9]\\+$"
+
+#define REGEX_DENY_PTRACE(task)    \
+	TRACE_PREFIX(task)           \
+	"landlock_deny_ptrace: "    \
+	"domain=[0-9a-f]\\+ "       \
+	"same_exec=[01] "           \
+	"log_same_exec=[01] "       \
+	"log_new_exec=[01] "        \
+	"tracee_pid=[0-9]\\+ "      \
+	"comm=[^ ]*$"
+
+#define REGEX_DENY_SCOPE_SIGNAL(task)        \
+	TRACE_PREFIX(task)                    \
+	"landlock_deny_scope_signal: "       \
+	"domain=[0-9a-f]\\+ "                \
+	"same_exec=[01] "                    \
+	"log_same_exec=[01] "                \
+	"log_new_exec=[01] "                 \
+	"target_pid=[0-9]\\+ "               \
+	"comm=[^ ]*$"
+
+#define REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(task) \
+	TRACE_PREFIX(task)                           \
+	"landlock_deny_scope_abstract_unix_socket: " \
+	"domain=[0-9a-f]\\+ "                       \
+	"same_exec=[01] "                           \
+	"log_same_exec=[01] "                       \
+	"log_new_exec=[01] "                        \
+	"peer_pid=[0-9]\\+ "                        \
+	"sun_path=[^ ]*$"
+
+#define REGEX_FREE_DOMAIN(task)    \
+	TRACE_PREFIX(task)         \
+	"landlock_free_domain: "   \
+	"domain=[0-9a-f]\\+ "     \
+	"denials=[0-9]\\+$"
+
+#define REGEX_FREE_RULESET(task)    \
+	TRACE_PREFIX(task)          \
+	"landlock_free_ruleset: "   \
+	"ruleset=[0-9a-f]\\+\\.[0-9]\\+$"
+/* clang-format on */
+
+static int __maybe_unused tracefs_write(const char *path, const char *value)
+{
+	int fd;
+	ssize_t ret;
+	size_t len = strlen(value);
+
+	fd = open(path, O_WRONLY | O_TRUNC | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	ret = write(fd, value, len);
+	close(fd);
+	if (ret < 0)
+		return -errno;
+	if ((size_t)ret != len)
+		return -EIO;
+
+	return 0;
+}
+
+static int __maybe_unused tracefs_write_int(const char *path, int value)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "%d", value);
+	return tracefs_write(path, buf);
+}
+
+static int __maybe_unused tracefs_setup(void)
+{
+	struct stat st;
+
+	/* Mount tracefs if not already mounted. */
+	if (stat(TRACEFS_ROOT, &st) != 0) {
+		int ret = mount("tracefs", TRACEFS_ROOT, "tracefs", 0, NULL);
+
+		if (ret)
+			return -errno;
+	}
+
+	/* Verify landlock events are available. */
+	if (stat(TRACEFS_LANDLOCK_DIR, &st) != 0)
+		return -ENOENT;
+
+	return 0;
+}
+
+/*
+ * Set up PID-based event filtering so only events from the current process and
+ * its children are recorded.  This is analogous to audit's AUDIT_EXE filter: it
+ * prevents events from unrelated processes from polluting the trace buffer.
+ */
+static int __maybe_unused tracefs_set_pid_filter(pid_t pid)
+{
+	int ret;
+
+	/* Enable event-fork so children inherit the PID filter. */
+	ret = tracefs_write(TRACEFS_OPTIONS_EVENT_FORK, "1");
+	if (ret)
+		return ret;
+
+	return tracefs_write_int(TRACEFS_SET_EVENT_PID, pid);
+}
+
+/* Clear the PID filter to stop filtering by PID. */
+static int __maybe_unused tracefs_clear_pid_filter(void)
+{
+	return tracefs_write(TRACEFS_SET_EVENT_PID, "");
+}
+
+static int __maybe_unused tracefs_enable_event(const char *enable_path,
+					       bool enable)
+{
+	return tracefs_write(enable_path, enable ? "1" : "0");
+}
+
+static int __maybe_unused tracefs_clear(void)
+{
+	return tracefs_write(TRACEFS_TRACE, "");
+}
+
+/*
+ * Reads the trace buffer content into a newly allocated buffer.  The caller is
+ * responsible for freeing the returned buffer.  Returns NULL on error.
+ */
+static char __maybe_unused *tracefs_read_trace(void)
+{
+	char *buf;
+	int fd;
+	ssize_t total = 0, ret;
+
+	buf = malloc(TRACE_BUFFER_SIZE);
+	if (!buf)
+		return NULL;
+
+	fd = open(TRACEFS_TRACE, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		free(buf);
+		return NULL;
+	}
+
+	while (total < TRACE_BUFFER_SIZE - 1) {
+		ret = read(fd, buf + total, TRACE_BUFFER_SIZE - 1 - total);
+		if (ret <= 0)
+			break;
+		total += ret;
+	}
+	close(fd);
+	buf[total] = '\0';
+	return buf;
+}
+
+/* Counts the number of lines in @buf matching the basic regex @pattern. */
+static int __maybe_unused tracefs_count_matches(const char *buf,
+						const char *pattern)
+{
+	regex_t regex;
+	int count = 0;
+	const char *line, *end;
+
+	if (regcomp(&regex, pattern, 0) != 0)
+		return -EINVAL;
+
+	line = buf;
+	while (*line) {
+		end = strchr(line, '\n');
+		if (!end)
+			end = line + strlen(line);
+
+		/* Create a temporary null-terminated line. */
+		size_t len = end - line;
+		char *tmp = malloc(len + 1);
+
+		if (tmp) {
+			memcpy(tmp, line, len);
+			tmp[len] = '\0';
+			if (regexec(&regex, tmp, 0, NULL, 0) == 0)
+				count++;
+			free(tmp);
+		}
+
+		if (*end == '\n')
+			line = end + 1;
+		else
+			break;
+	}
+
+	regfree(&regex);
+	return count;
+}
+
+/*
+ * Extracts the value of a named field from a trace line in @buf.  Searches for
+ * the first line matching @line_pattern, then extracts the value after
+ * "@field_name=" into @out.  Stops at space or newline.
+ *
+ * Returns 0 on success, -ENOENT if no match.
+ */
+static int __maybe_unused tracefs_extract_field(const char *buf,
+						const char *line_pattern,
+						const char *field_name,
+						char *out, size_t out_size)
+{
+	regex_t regex;
+	const char *line, *end;
+
+	if (regcomp(&regex, line_pattern, 0) != 0)
+		return -EINVAL;
+
+	line = buf;
+	while (*line) {
+		end = strchr(line, '\n');
+		if (!end)
+			end = line + strlen(line);
+
+		size_t len = end - line;
+		char *tmp = malloc(len + 1);
+
+		if (tmp) {
+			const char *field, *val_start;
+			size_t field_len, val_len;
+
+			memcpy(tmp, line, len);
+			tmp[len] = '\0';
+
+			if (regexec(&regex, tmp, 0, NULL, 0) != 0) {
+				free(tmp);
+				goto next;
+			}
+
+			/*
+			 * Find "field_name=" in the line, ensuring a word
+			 * boundary before the field name to avoid substring
+			 * matches (e.g., "port" in "sport").
+			 */
+			field_len = strlen(field_name);
+			field = tmp;
+			while ((field = strstr(field, field_name))) {
+				if (field[field_len] == '=' &&
+				    (field == tmp || field[-1] == ' '))
+					break;
+				field++;
+			}
+			if (!field) {
+				free(tmp);
+				regfree(&regex);
+				return -ENOENT;
+			}
+
+			val_start = field + field_len + 1;
+			val_len = 0;
+			while (val_start[val_len] &&
+			       val_start[val_len] != ' ' &&
+			       val_start[val_len] != '\n')
+				val_len++;
+
+			if (val_len >= out_size)
+				val_len = out_size - 1;
+			memcpy(out, val_start, val_len);
+			out[val_len] = '\0';
+
+			free(tmp);
+			regfree(&regex);
+			return 0;
+		}
+next:
+		if (*end == '\n')
+			line = end + 1;
+		else
+			break;
+	}
+
+	regfree(&regex);
+	return -ENOENT;
+}
+
+/*
+ * Common fixture setup for trace tests.  Mounts tracefs if needed and
+ * sets a PID filter.  The caller must create a mount namespace first
+ * (unshare(CLONE_NEWNS) + mount(MS_REC | MS_PRIVATE)) to isolate
+ * tracefs state.
+ *
+ * Returns 0 on success, -errno on failure (caller should SKIP).
+ */
+static int __maybe_unused tracefs_fixture_setup(void)
+{
+	int ret;
+
+	ret = tracefs_setup();
+	if (ret)
+		return ret;
+
+	return tracefs_set_pid_filter(getpid());
+}
+
+static void __maybe_unused tracefs_fixture_teardown(void)
+{
+	tracefs_clear_pid_filter();
+}
+
+/*
+ * Temporarily raises CAP_SYS_ADMIN effective capability, calls @func, then
+ * drops the capability.  Returns the value from @func, or -EPERM if the
+ * capability manipulation fails.
+ */
+static int __maybe_unused tracefs_priv_call(int (*func)(void))
+{
+	const cap_value_t admin = CAP_SYS_ADMIN;
+	cap_t cap_p;
+	int ret;
+
+	cap_p = cap_get_proc();
+	if (!cap_p)
+		return -EPERM;
+
+	if (cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &admin, CAP_SET) ||
+	    cap_set_proc(cap_p)) {
+		cap_free(cap_p);
+		return -EPERM;
+	}
+
+	ret = func();
+
+	cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &admin, CAP_CLEAR);
+	cap_set_proc(cap_p);
+	cap_free(cap_p);
+	return ret;
+}
+
+/* Read the trace buffer with elevated privileges.  Returns NULL on failure. */
+static char __maybe_unused *tracefs_read_buf(void)
+{
+	/* Cannot use tracefs_priv_call() because the return type is char *. */
+	cap_t cap_p;
+	char *buf;
+	const cap_value_t admin = CAP_SYS_ADMIN;
+
+	cap_p = cap_get_proc();
+	if (!cap_p)
+		return NULL;
+
+	if (cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &admin, CAP_SET) ||
+	    cap_set_proc(cap_p)) {
+		cap_free(cap_p);
+		return NULL;
+	}
+
+	buf = tracefs_read_trace();
+
+	cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &admin, CAP_CLEAR);
+	cap_set_proc(cap_p);
+	cap_free(cap_p);
+	return buf;
+}
+
+/* Clear the trace buffer with elevated privileges.  Returns 0 on success. */
+static int __maybe_unused tracefs_clear_buf(void)
+{
+	return tracefs_priv_call(tracefs_clear);
+}
+
+/*
+ * Forks a child that creates a Landlock sandbox and performs an FS access.  The
+ * parent waits for the child, then reads the trace buffer.
+ *
+ * Requires common.h and wrappers.h to be included before trace.h.
+ */
+static void __maybe_unused sandbox_child_fs_access(
+	struct __test_metadata *const _metadata, const char *rule_path,
+	__u64 handled_access, __u64 allowed_access, const char *access_path)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = handled_access,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = allowed_access,
+		};
+		int ruleset_fd, fd;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open(rule_path, O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				      &path_beneath, 0)) {
+			close(path_beneath.parent_fd);
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(path_beneath.parent_fd);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(ruleset_fd);
+
+		fd = open(access_path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd >= 0)
+			close(fd);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+/*
+ * Forks a child that creates a Landlock sandbox allowing execute+read_dir for
+ * /usr and execute-only for ".", then execs ./true.  The true binary opens "."
+ * on startup, triggering a read_dir denial with same_exec=0.  The parent waits
+ * for the child to exit.
+ */
+static void __maybe_unused sandbox_child_exec_true(
+	struct __test_metadata *const _metadata, __u32 restrict_flags)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR |
+					     LANDLOCK_ACCESS_FS_EXECUTE,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = LANDLOCK_ACCESS_FS_EXECUTE |
+					  LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd;
+
+		ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd >= 0) {
+			landlock_add_rule(ruleset_fd,
+					  LANDLOCK_RULE_PATH_BENEATH,
+					  &path_beneath, 0);
+			close(path_beneath.parent_fd);
+		}
+
+		path_beneath.allowed_access = LANDLOCK_ACCESS_FS_EXECUTE;
+		path_beneath.parent_fd =
+			open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd >= 0) {
+			landlock_add_rule(ruleset_fd,
+					  LANDLOCK_RULE_PATH_BENEATH,
+					  &path_beneath, 0);
+			close(path_beneath.parent_fd);
+		}
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, restrict_flags))
+			_exit(1);
+		close(ruleset_fd);
+
+		execl("./true", "./true", NULL);
+		_exit(1);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
new file mode 100644
index 000000000000..0256383489fe
--- /dev/null
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -0,0 +1,1168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Tracepoints
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "trace.h"
+
+#define TRACE_TASK "trace_test"
+
+/* clang-format off */
+FIXTURE(trace) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace)
+{
+	int ret;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
+
+	ret = tracefs_fixture_setup();
+	if (ret) {
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+		self->tracefs_ok = 0;
+		SKIP(return, "tracefs not available");
+	}
+	self->tracefs_ok = 1;
+
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_RESTRICT_SELF_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, true));
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_FREE_DOMAIN_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_FREE_RULESET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	/* Disables landlock events and clears PID filter. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, false);
+	tracefs_enable_event(TRACEFS_RESTRICT_SELF_ENABLE, false);
+	tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false);
+	tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, false);
+	tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false);
+	tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, false);
+	tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, false);
+	tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, false);
+	tracefs_enable_event(TRACEFS_FREE_DOMAIN_ENABLE, false);
+	tracefs_enable_event(TRACEFS_FREE_RULESET_ENABLE, false);
+	tracefs_clear_pid_filter();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/*
+	 * The mount namespace is cleaned up automatically when the test process
+	 * (harness child) exits.
+	 */
+}
+
+/*
+ * Verifies that no trace events are emitted when the tracepoints are disabled.
+ */
+TEST_F(trace, no_trace_when_disabled)
+{
+	char *buf;
+
+	/* Disable all landlock events. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_RESTRICT_SELF_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false));
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, false));
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, false));
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_PTRACE_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_SCOPE_SIGNAL_ENABLE,
+					  false));
+	ASSERT_EQ(0, tracefs_enable_event(
+			     TRACEFS_DENY_SCOPE_ABSTRACT_UNIX_SOCKET_ENABLE,
+			     false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_FREE_DOMAIN_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_FREE_RULESET_ENABLE, false));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/*
+	 * Trigger both allowed and denied accesses to verify neither check_rule
+	 * nor check_access events fire when disabled.
+	 */
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, "/tmp");
+
+	/* Read trace buffer and verify no landlock events at all. */
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(0, tracefs_count_matches(buf, "landlock_"))
+	{
+		TH_LOG("Expected 0 landlock events when disabled\n%s", buf);
+	}
+
+	free(buf);
+}
+
+/*
+ * Verifies that landlock_create_ruleset emits a trace event with the correct
+ * handled access masks.
+ */
+TEST_F(trace, create_ruleset)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	int ruleset_fd;
+	char *buf, *dot;
+	char field[64];
+	char expected[32];
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CREATE_RULESET(TRACE_TASK)))
+	{
+		TH_LOG("Expected 1 create_ruleset event\n%s", buf);
+	}
+
+	/* Verify handled_fs matches what we requested. */
+	snprintf(expected, sizeof(expected), "0x%x",
+		 (unsigned int)LANDLOCK_ACCESS_FS_READ_FILE);
+	EXPECT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
+					"handled_fs", field, sizeof(field)));
+	EXPECT_STREQ(expected, field);
+
+	/* Verify handled_net matches. */
+	snprintf(expected, sizeof(expected), "0x%x",
+		 (unsigned int)LANDLOCK_ACCESS_NET_BIND_TCP);
+	EXPECT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
+					"handled_net", field, sizeof(field)));
+	EXPECT_STREQ(expected, field);
+
+	/* Verify version is 0 at creation (no rules added yet). */
+	EXPECT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
+					"ruleset", field, sizeof(field)));
+	/* Format is <hex>.<dec>; version is after the dot. */
+	dot = strchr(field, '.');
+	ASSERT_NE(0, !!dot);
+	EXPECT_STREQ("0", dot + 1);
+
+	free(buf);
+}
+
+/*
+ * Verifies that the ruleset version increments with each add_rule call and that
+ * restrict_self records the correct version.
+ */
+TEST_F(trace, ruleset_version)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	const char *dot;
+	char field[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		/* First rule: version becomes 1. */
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+		landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				  &path_beneath, 0);
+		close(path_beneath.parent_fd);
+
+		/* Second rule: version becomes 2. */
+		path_beneath.parent_fd =
+			open("/tmp", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+		landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				  &path_beneath, 0);
+		close(path_beneath.parent_fd);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(1);
+		close(ruleset_fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/* Verify create_ruleset has version=0. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
+					"ruleset", field, sizeof(field)));
+	dot = strchr(field, '.');
+	ASSERT_NE(0, !!dot);
+	EXPECT_STREQ("0", dot + 1);
+
+	/* Verify 2 add_rule_fs events were emitted. */
+	EXPECT_EQ(2, tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK)))
+	{
+		TH_LOG("Expected 2 add_rule_fs events\n%s", buf);
+	}
+
+	/*
+	 * Verify restrict_self records version=2 (after 2 add_rule calls).  The
+	 * ruleset field format is <hex_id>.<dec_version>.
+	 */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_RESTRICT_SELF(TRACE_TASK),
+					   "ruleset", field, sizeof(field)));
+	dot = strchr(field, '.');
+	ASSERT_NE(0, !!dot);
+	EXPECT_STREQ("2", dot + 1);
+
+	free(buf);
+}
+
+/*
+ * Verifies that landlock_restrict_self emits a trace event linking the ruleset
+ * ID to the new domain ID.
+ */
+TEST_F(trace, restrict_self)
+{
+	pid_t pid;
+	int status, check_count;
+	char *buf;
+	char ruleset_id[64], domain_id[64], check_domain[64];
+
+	/* Clear before the sandboxed child. */
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd, fd;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+
+		landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				  &path_beneath, 0);
+		close(path_beneath.parent_fd);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(1);
+		close(ruleset_fd);
+
+		/* Trigger a check_rule to verify domain_id correlation. */
+		fd = open("/usr", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd >= 0)
+			close(fd);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/* Verify restrict_self event exists. */
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_RESTRICT_SELF(TRACE_TASK)))
+	{
+		TH_LOG("Expected 1 restrict_self event\n%s", buf);
+	}
+
+	/* Extract the domain ID from restrict_self. */
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_RESTRICT_SELF(TRACE_TASK),
+					   "domain", domain_id,
+					   sizeof(domain_id)));
+
+	/* Extract the ruleset ID from restrict_self. */
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_RESTRICT_SELF(TRACE_TASK),
+					   "ruleset", ruleset_id,
+					   sizeof(ruleset_id)));
+
+	/* Verify domain ID is non-zero. */
+	EXPECT_NE(0, strcmp(domain_id, "0"));
+
+	/* Verify parent=0 (first restriction, no prior domain). */
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_RESTRICT_SELF(TRACE_TASK),
+					   "parent", ruleset_id,
+					   sizeof(ruleset_id)));
+	EXPECT_STREQ("0", ruleset_id);
+
+	/*
+	 * Verify the same domain ID appears in the check_rule event, confirming
+	 * end-to-end correlation.
+	 */
+	check_count =
+		tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
+	ASSERT_LE(1, check_count)
+	{
+		TH_LOG("Expected check_rule_fs events\n%s", buf);
+	}
+
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "domain", check_domain,
+					   sizeof(check_domain)));
+	EXPECT_STREQ(domain_id, check_domain);
+
+	free(buf);
+}
+
+/*
+ * Verifies that nested landlock_restrict_self calls produce trace events with
+ * correct parent domain IDs: the second restrict_self's parent should be the
+ * first domain's ID.
+ */
+TEST_F(trace, restrict_self_nested)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	const char *after_first;
+	char first_domain[64], first_parent[64], second_parent[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd;
+
+		/* First restriction. */
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+		landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				  &path_beneath, 0);
+		close(path_beneath.parent_fd);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(1);
+		close(ruleset_fd);
+
+		/* Second restriction (nested). */
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+		landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				  &path_beneath, 0);
+		close(path_beneath.parent_fd);
+
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(1);
+		close(ruleset_fd);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/* Should have 2 restrict_self events. */
+	EXPECT_EQ(2,
+		  tracefs_count_matches(buf, REGEX_RESTRICT_SELF(TRACE_TASK)))
+	{
+		TH_LOG("Expected 2 restrict_self events\n%s", buf);
+	}
+
+	/*
+	 * Extract domain and parent from each restrict_self event.  The first
+	 * event (parent=0) is the outer domain; the second (parent!=0) is the
+	 * nested domain whose parent should match the first domain's ID.
+	 */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_RESTRICT_SELF(TRACE_TASK),
+					   "domain", first_domain,
+					   sizeof(first_domain)));
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_RESTRICT_SELF(TRACE_TASK),
+					   "parent", first_parent,
+					   sizeof(first_parent)));
+	EXPECT_STREQ("0", first_parent);
+
+	/*
+	 * Find the second restrict_self by scanning past the first.
+	 * tracefs_extract_field returns the first match, so search in the
+	 * buffer after the first event.
+	 *
+	 * Skip past the first restrict_self line. tracefs_extract_field
+	 * matches the first line that matches the regex, so passing the
+	 * buffer after the first matching line gives us the second
+	 * event.
+	 */
+	after_first = strstr(buf, "landlock_restrict_self:");
+	ASSERT_NE(NULL, after_first);
+	after_first = strchr(after_first, '\n');
+	ASSERT_NE(NULL, after_first);
+
+	ASSERT_EQ(0, tracefs_extract_field(
+			     after_first + 1, REGEX_RESTRICT_SELF(TRACE_TASK),
+			     "parent", second_parent, sizeof(second_parent)));
+
+	/* The second domain's parent should be the first domain's ID. */
+	EXPECT_STREQ(first_domain, second_parent);
+
+	free(buf);
+}
+
+/*
+ * Verifies that landlock_add_rule does not emit a trace event when the syscall
+ * fails (e.g., invalid ruleset fd).
+ */
+TEST_F(trace, add_rule_invalid_fd)
+{
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	char *buf;
+
+	path_beneath.parent_fd = open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	/* Invalid ruleset fd (-1). */
+	ASSERT_EQ(-1, landlock_add_rule(-1, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath, 0));
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(0, tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK)))
+	{
+		TH_LOG("No add_rule_fs event expected on invalid fd\n%s", buf);
+	}
+
+	free(buf);
+}
+
+/*
+ * Verifies that landlock_restrict_self does not emit a trace event when the
+ * syscall fails (e.g., invalid ruleset fd or unknown flags).
+ */
+TEST_F(trace, restrict_self_invalid)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd;
+	char *buf;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Clear the trace buffer after create_ruleset event. */
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* Invalid fd. */
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
+
+	/* Unknown flags. */
+	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, -1));
+
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(0,
+		  tracefs_count_matches(buf, REGEX_RESTRICT_SELF(TRACE_TASK)))
+	{
+		TH_LOG("No restrict_self event expected on error\n%s", buf);
+	}
+
+	free(buf);
+}
+
+/*
+ * Verifies that trace_landlock_free_domain fires when a domain is deallocated,
+ * with the correct denials count.
+ */
+TEST_F(trace, free_domain)
+{
+	char *buf;
+	int count;
+	char denials_field[32];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/*
+	 * The domain is freed via a work queue (kworker), so the free_domain
+	 * trace event is emitted from a different PID.  Clear the PID filter
+	 * BEFORE the child exits, so the kworker event passes the filter when
+	 * it fires.
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_clear_pid_filter();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, "/tmp");
+
+	/*
+	 * Wait for the deferred deallocation work to run.  The domain is freed
+	 * asynchronously from a kworker; poll until the event appears or a
+	 * timeout is reached.
+	 */
+	for (int retry = 0; retry < 10; retry++) {
+		/* TODO: Improve */
+		usleep(100000);
+
+		set_cap(_metadata, CAP_SYS_ADMIN);
+		buf = tracefs_read_trace();
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+		ASSERT_NE(NULL, buf);
+
+		count = tracefs_count_matches(buf,
+					      REGEX_FREE_DOMAIN(KWORKER_TASK));
+		if (count >= 1)
+			break;
+		free(buf);
+		buf = NULL;
+	}
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, tracefs_set_pid_filter(getpid()));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ASSERT_NE(NULL, buf);
+	EXPECT_LE(1, count)
+	{
+		TH_LOG("Expected free_domain event, got %d\n%s", count, buf);
+	}
+
+	/* Verify denials count matches the single denial we triggered. */
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
+					   "denials", denials_field,
+					   sizeof(denials_field)));
+	EXPECT_STREQ("1", denials_field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that deny_access_fs includes the enriched fields: same_exec,
+ * log_same_exec, log_new_exec.
+ */
+TEST_F(trace, deny_access_fs_fields)
+{
+	char *buf;
+	char field_buf[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* Trigger a denial: rule for /usr, access /tmp. */
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, "/tmp");
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/* Verify the enriched fields are present and have valid values. */
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_DENY_ACCESS_FS(TRACE_TASK), "same_exec",
+			     field_buf, sizeof(field_buf)));
+	/* Child is the same exec that restricted itself. */
+	EXPECT_STREQ("1", field_buf);
+
+	/* Default: log_same_exec=1 (not disabled). */
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+			     "log_same_exec", field_buf, sizeof(field_buf)));
+	EXPECT_STREQ("1", field_buf);
+
+	/* Default: log_new_exec=0 (not enabled). */
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+			     "log_new_exec", field_buf, sizeof(field_buf)));
+	EXPECT_STREQ("0", field_buf);
+
+	free(buf);
+}
+
+/*
+ * Verifies that same_exec is 1 (true) for denials from the same executable that
+ * called landlock_restrict_self().
+ */
+TEST_F(trace, same_exec_before_exec)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	char field[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd, dir_fd;
+
+		ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		/* No rules: all read_dir access is denied. */
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(1);
+		close(ruleset_fd);
+
+		/* Trigger denial without exec (same executable). */
+		dir_fd = open(".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (dir_fd >= 0)
+			close(dir_fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/* Should have at least one deny_access_fs denial. */
+	EXPECT_LE(1,
+		  tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK)));
+
+	/* Verify same_exec=1 (same executable, no exec). */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"same_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	/* Verify default log flags. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"log_same_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"log_new_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that same_exec is 0 (false) for denials from a process that has
+ * exec'd a new binary after landlock_restrict_self().  The sandboxed child
+ * exec's true which opens "." and triggers a read_dir denial.  Also verifies
+ * the default log flags (log_same_exec=1, log_new_exec=0) and covers the
+ * "trace-only" visibility condition: same_exec=0 AND log_new_exec=0 means audit
+ * suppresses the denial, but trace still fires.
+ */
+TEST_F(trace, same_exec_after_exec)
+{
+	char *buf;
+	char field[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	sandbox_child_exec_true(_metadata, 0);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_LE(1, tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS("true")));
+
+	/* Verify same_exec=0 (different executable after exec). */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS("true"),
+					   "same_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	/* Default log flags should still be the same. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS("true"),
+					"log_same_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS("true"),
+					"log_new_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF disables log_same_exec
+ * in the trace event.
+ */
+TEST_F(trace, log_flags_same_exec_off)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	char field[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd, dir_fd;
+
+		ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(
+			    ruleset_fd,
+			    LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF))
+			_exit(1);
+		close(ruleset_fd);
+
+		dir_fd = open(".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (dir_fd >= 0)
+			close(dir_fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_LE(1,
+		  tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK)));
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"log_same_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"log_new_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON enables log_new_exec in
+ * the trace event.  The child exec's true so that the denial comes from a new
+ * executable (same_exec=0).
+ */
+TEST_F(trace, log_flags_new_exec_on)
+{
+	char *buf;
+	char field[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	sandbox_child_exec_true(_metadata,
+				LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_LE(1, tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS("true")));
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS("true"),
+					   "same_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS("true"),
+					"log_same_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS("true"),
+					"log_new_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that denials suppressed by audit log flags are still counted in
+ * num_denials.  The child restricts itself with default flags (log_same_exec=1,
+ * log_new_exec=0), then execs true which attempts to read a denied directory.
+ * After exec, same_exec=0 and log_new_exec=0, so audit suppresses the denial.
+ * But the trace event fires unconditionally and free_domain must report the
+ * correct denials count.
+ */
+TEST_F(trace, non_audit_visible_denial_counting)
+{
+	char *buf = NULL;
+	char denials_field[32];
+	int count;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, tracefs_clear());
+	tracefs_clear_pid_filter();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	sandbox_child_exec_true(_metadata, 0);
+
+	/* Wait for free_domain event with retry. */
+	for (int retry = 0; retry < 10; retry++) {
+		usleep(100000);
+
+		set_cap(_metadata, CAP_SYS_ADMIN);
+		buf = tracefs_read_trace();
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+		if (!buf)
+			break;
+
+		count = tracefs_count_matches(buf,
+					      REGEX_FREE_DOMAIN(KWORKER_TASK));
+		if (count >= 1)
+			break;
+		free(buf);
+		buf = NULL;
+	}
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, tracefs_set_pid_filter(getpid()));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/*
+	 * The denial happened after exec (same_exec=0), so audit would suppress
+	 * it.  But num_denials counts all denials regardless.
+	 */
+	ASSERT_NE(NULL, buf)
+	{
+		TH_LOG("free_domain event not found after 10 retries");
+	}
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_FREE_DOMAIN(KWORKER_TASK),
+					   "denials", denials_field,
+					   sizeof(denials_field)));
+	EXPECT_STREQ("1", denials_field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that landlock_add_rule_net emits a trace event with the correct port
+ * and allowed access mask fields.
+ */
+TEST_F(trace, add_rule_net_fields)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	struct landlock_net_port_attr net_port = {
+		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.port = 8080,
+	};
+	int ruleset_fd;
+	char *buf;
+	char field[64], expected[32];
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				       &net_port, 0));
+	close(ruleset_fd);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1, tracefs_count_matches(buf, REGEX_ADD_RULE_NET(TRACE_TASK)))
+	{
+		TH_LOG("Expected 1 add_rule_net event\n%s", buf);
+	}
+
+	/*
+	 * Verify the port is in host endianness, matching the UAPI
+	 * convention (landlock_net_port_attr.port).  On little-endian,
+	 * htons(8080) is 36895, so this comparison catches byte-order
+	 * bugs.
+	 */
+	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_NET(TRACE_TASK),
+					   "port", field, sizeof(field)));
+	EXPECT_STREQ("8080", field);
+	/*
+	 * The allowed mask is the absolute value after transformation:
+	 * the user-requested BIND_TCP plus all unhandled access rights
+	 * (CONNECT_TCP is unhandled because the ruleset only handles
+	 * BIND_TCP).
+	 */
+	snprintf(expected, sizeof(expected), "0x%x",
+		 (unsigned int)(LANDLOCK_ACCESS_NET_BIND_TCP |
+				LANDLOCK_ACCESS_NET_CONNECT_TCP));
+	EXPECT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_ADD_RULE_NET(TRACE_TASK),
+					"access_rights", field, sizeof(field)));
+	EXPECT_STREQ(expected, field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF disables audit
+ * logging for child domains but trace events still fire.  The parent creates a
+ * domain with LOG_SUBDOMAINS_OFF, then the child creates a sub-domain and
+ * triggers a denial.  The trace event should fire (tracing is unconditional)
+ * with log_same_exec=1 and log_new_exec=0 (the child's default flags).
+ */
+TEST_F(trace, log_flags_subdomains_off)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	char field[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int parent_fd, child_fd, dir_fd;
+
+		/* Parent domain with LOG_SUBDOMAINS_OFF. */
+		parent_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+		if (parent_fd < 0)
+			_exit(1);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(
+			    parent_fd,
+			    LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF))
+			_exit(1);
+		close(parent_fd);
+
+		/* Child sub-domain with default flags. */
+		child_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+		if (child_fd < 0)
+			_exit(1);
+
+		if (landlock_restrict_self(child_fd, 0))
+			_exit(1);
+		close(child_fd);
+
+		/* Trigger a denial from the child domain. */
+		dir_fd = open(".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (dir_fd >= 0)
+			close(dir_fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/*
+	 * Trace fires unconditionally even though audit is disabled for the
+	 * child domain (parent had LOG_SUBDOMAINS_OFF).
+	 */
+	EXPECT_LE(1,
+		  tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK)))
+	{
+		TH_LOG("Expected deny_access_fs event despite "
+		       "LOG_SUBDOMAINS_OFF\n%s",
+		       buf);
+	}
+
+	/* The child domain's own flags: log_same_exec=1 (default). */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"log_same_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+					"log_new_exec", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	free(buf);
+}
+
+/* Verifies that landlock_free_ruleset fires when a ruleset FD is closed. */
+TEST_F(trace, free_ruleset_on_close)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd;
+	char *buf;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* Closing the FD should trigger free_ruleset. */
+	close(ruleset_fd);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1, tracefs_count_matches(buf, REGEX_FREE_RULESET(TRACE_TASK)))
+	{
+		TH_LOG("Expected 1 free_ruleset event\n%s", buf);
+	}
+
+	free(buf);
+}
+
+/*
+ * The following tests are intentionally elided because the underlying kernel
+ * mechanisms are already validated by audit tests:
+ *
+ * - Domain ID monotonicity: validated by audit_test.c:layers.  The same
+ *   landlock_get_id_range() function serves both audit and trace.
+ *
+ * - Domain deallocation order (LIFO): validated by audit_test.c:layers.  Trace
+ *   events fire from the same free_domain_work() code path.
+ *
+ * - Max-layer stacking (16 domains): validated by audit_test.c:layers.
+ *
+ * - IPv6 network tests: IPv6 hook dispatch uses the same
+ *   current_check_access_socket() as IPv4, validated by net_test.c:audit tests.
+ *
+ * - Per-access-right full matrix (all 16 FS rights): hook dispatch is validated
+ *   by fs_test.c:audit tests.  Trace tests verify representative samples to
+ *   ensure bitmask encoding is correct.
+ *
+ * - Combined log flag variants (e.g., LOG_SUBDOMAINS_OFF + LOG_NEW_EXEC_ON):
+ *   individual flag tests above cover each flag's effect on trace fields.  Flag
+ *   combination logic is validated by audit_test.c:audit_flags tests.
+ *
+ * - fs.refer multi-record denials and fs.change_topology (mount):
+ *   trace_denial() uses the same code path for all FS request types.  The
+ *   DENTRY union member fix (C1) is validated by the deny_access_fs_fields
+ *   test.  Audit tests in fs_test.c cover refer and mount denial specifics.
+ *
+ * - Ptrace TRACEME direction: the tracepoint fires from the same
+ *   hook_ptrace_access_check() for both ATTACH and TRACEME.  Audit tests in
+ *   ptrace_test.c cover both directions.
+ *
+ * - check_rule_net field verification: the tracepoint uses the same
+ *   landlock_unmask_layers() as check_rule_fs, just with a different key type.
+ *   The FS path is validated by trace_fs_test.c tests.
+ */
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/true.c b/tools/testing/selftests/landlock/true.c
index 3f9ccbf52783..1e39b664512d 100644
--- a/tools/testing/selftests/landlock/true.c
+++ b/tools/testing/selftests/landlock/true.c
@@ -1,5 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Minimal helper for Landlock selftests.  Opens its own working directory
+ * before exiting, which may trigger access denials depending on the sandbox
+ * configuration.
+ */
+
+#include <fcntl.h>
+#include <unistd.h>
+
 int main(void)
 {
+	close(open(".", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	return 0;
 }
-- 
2.53.0


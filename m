Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366E42123C
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740374; cv=none; b=IMziz5EqVK4pd/hsOWkaunieaXVFjsx0WfHGdU0/00sXPtcGVmoakfHXD5q4CwWC6LHzp+SyQN4aGnt/iX3JToSEvMhHqjykKoG8rD7Krnx7LDg9t6n/FmngNf9Q9DdpSgL5t9pIFMeKyf0KBeNyq+JjysSrUNQxXQSvN9VIlZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740374; c=relaxed/simple;
	bh=FLMnL+/7oOma7hgyGW0XBLtsaGGK2Wq5CrzpprTDPnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o44cmIChGyIAoiR6znseELTqa56ni8GFKa6uOwbkkZst66VllLZ+G2ZcTEDFhbzu/5f08JNJGfxpAzGo/nLNz6p/HQBbuDnYtXZNNnXViAWub6yDawVSWut1mC8cqoF1B5tcMYbiB5QDBh00Zb5kNcopkBclAHfJWETYrN8PGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p63/4jTH; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p63/4jTH"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h51600CyVz10pl;
	Wed, 22 Jul 2026 19:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740359;
	bh=XEhLIj2qzZJnUgLjQ3ijmLXjpapAGH8gHgEvi5xGsMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p63/4jTH+ReqwXW/UkX+sT1ropppZ/P5vu6621+Hh5cf7+7uJZYfd4qHmQGslFfoO
	 bqXDmWQtBzpICucNpu5dmyn0GGkEKO+Q8ux/6SRiz5A3E2+LtXgUFYxIhPNQ4hJKZa
	 4FZQAgYMCYEIGJ9j3avlx/CDjwkK2vELIhqCrLJw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515y6W2fzjF3;
	Wed, 22 Jul 2026 19:12:38 +0200 (CEST)
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
Subject: [PATCH v3 18/20] selftests/landlock: Add scope and ptrace tracepoint tests
Date: Wed, 22 Jul 2026 19:11:50 +0200
Message-ID: <20260722171159.2776765-19-mic@digikod.net>
In-Reply-To: <20260722171159.2776765-1-mic@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add trace tests for the landlock_deny_ptrace,
landlock_deny_scope_signal, and landlock_deny_scope_abstract_unix_socket
tracepoints, each placed alongside the functional tests for its
subsystem, mirroring the audit test layout.

Each tracepoint is exercised by a fixture with three variants that pin
both branches of the other-party domain field: denied against an
unsandboxed other party (other-party domain ID 0), denied against a
sandboxed other party (non-zero ID), and an allowed baseline that
records no event.  A second fixture per type exercises an alternate LSM
hook that reaches the same tracepoint with the same other-party domain
ID, since each denial type can be reached through more than one hook.

The datagram abstract-unix variant does not assert peer_pid, which is 0
for a datagram peer (no SO_PEERCRED); sun_path is the reliable peer
identifier.  The ptrace fixtures install a plain domain-creating ruleset
rather than a dedicated flag, since ptrace denial relies on domain
ancestry, not on a specific scoped flag.  The fixtures unshare the mount
namespace and remount / as MS_PRIVATE before mounting tracefs so the
helper instance is visible only to the test process.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-17-mic@digikod.net
- Tighten the denied-variant event-count assertion from EXPECT_LE to
  EXPECT_EQ (a single denied operation against a single-layer domain
  emits exactly one event), for the signal, abstract-unix-socket, and
  ptrace fixtures.
- Follow the deny_ptrace printk label rename comm= to the role-prefixed
  tracee_comm= (the label now matches its sibling tracee_pid= field) in
  the parsed field name of the ptrace comm assertion (ptrace_test.c).
- Assert the other party's domain ID in the scope and ptrace trace tests
  (add the per-layer tracee_domain=/target_domain=/peer_domain= fields
  to REGEX_DENY_PTRACE, REGEX_DENY_SCOPE_SIGNAL, and
  REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET, then check them) with three
  variants per fixture: denied against an unsandboxed other party
  (domain ID 0),
  denied against a sandboxed other party (non-zero ID), and an allowed
  baseline that records no event.
- Cover the alternate LSM hook that reaches each denial tracepoint and
  sets the same other-party domain ID: hook_file_send_sigiotask via
  fcntl(F_SETOWN)+SIGIO (trace_fown), hook_unix_may_send via a datagram
  sendto (trace_unix_dgram), and a denied hook_ptrace_traceme
  (trace_ptrace_traceme).

Changes since v1:
- New patch.
---
 .../testing/selftests/landlock/ptrace_test.c  | 402 +++++++++++++++
 .../landlock/scoped_abstract_unix_test.c      | 463 ++++++++++++++++++
 .../selftests/landlock/scoped_signal_test.c   | 404 +++++++++++++++
 tools/testing/selftests/landlock/trace.h      |  17 +-
 4 files changed, 1279 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4f64c90583cd..2644445a9d02 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -11,7 +11,9 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
+#include <sched.h>
 #include <signal.h>
+#include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/ptrace.h>
 #include <sys/types.h>
@@ -20,6 +22,7 @@
 
 #include "audit.h"
 #include "common.h"
+#include "trace.h"
 
 /* Copied from security/yama/yama_lsm.c */
 #define YAMA_SCOPE_DISABLED 0
@@ -430,4 +433,403 @@ TEST_F(audit, trace)
 	EXPECT_EQ(0, records.domain);
 }
 
+/* Trace tests */
+
+/* clang-format off */
+FIXTURE(trace_ptrace) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_ptrace)
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
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_PTRACE_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_ptrace)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_PTRACE_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_ptrace)
+{
+	/* clang-format on */
+	bool sandbox;
+	bool sandbox_target;
+	int expect_denied;
+};
+
+/* Denied: sandboxed child ptraces unsandboxed parent (tracee_domain=0). */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+};
+
+/*
+ * Denied: sandboxed child ptraces a sandboxed parent, so the tracee is in a
+ * domain and tracee_domain= is non-zero.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace, denied_scoped_target) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child uses PTRACE_TRACEME. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace, allowed) {
+	/* clang-format on */
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_ptrace, deny_ptrace)
+{
+	char *buf, field[64], expected_pid[16];
+	int count, status;
+	pid_t child, parent;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	parent = getpid();
+
+	/*
+	 * Set a known comm so the denied variant can verify both the trace line
+	 * task name and the tracee_comm= field.
+	 */
+	prctl(PR_SET_NAME, "ll_trace_test");
+
+	/*
+	 * For the non-zero tracee_domain case, sandbox the parent (the tracee)
+	 * before forking.  The child inherits that domain and adds its own
+	 * layer, so the child (tracer) is not an ancestor of the tracee and the
+	 * ptrace is still denied, with tracee_domain= naming the parent's
+	 * domain.
+	 */
+	if (variant->sandbox_target)
+		create_domain(_metadata);
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		if (variant->sandbox) {
+			struct landlock_ruleset_attr ruleset_attr = {
+				.scoped = LANDLOCK_SCOPE_SIGNAL,
+			};
+			int ruleset_fd;
+
+			/*
+			 * Any scope creates a domain.  Ptrace denial checks
+			 * domain ancestry, not specific flags.
+			 */
+			ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			if (ruleset_fd < 0)
+				_exit(1);
+
+			prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+			if (landlock_restrict_self(ruleset_fd, 0)) {
+				close(ruleset_fd);
+				_exit(1);
+			}
+			close(ruleset_fd);
+
+			/* PTRACE_ATTACH on unsandboxed parent: denied. */
+			if (ptrace(PTRACE_ATTACH, parent, NULL, NULL) == 0) {
+				ptrace(PTRACE_DETACH, parent, NULL, NULL);
+				_exit(2);
+			}
+			if (errno != EPERM)
+				_exit(3);
+		} else {
+			/* No sandbox: ptrace should succeed. */
+			if (ptrace(PTRACE_TRACEME) != 0)
+				_exit(1);
+		}
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_PTRACE("ll_trace_test"));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_ptrace event, got %d\n%s", count,
+			       buf);
+		}
+
+		/* Verify tracee_pid is the parent's TGID. */
+		snprintf(expected_pid, sizeof(expected_pid), "%d", parent);
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_PTRACE("ll_trace_test"),
+				     "tracee_pid", field, sizeof(field)));
+		EXPECT_STREQ(expected_pid, field);
+
+		/* Verify tracee_comm matches prctl(PR_SET_NAME). */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_PTRACE("ll_trace_test"),
+				     "tracee_comm", field, sizeof(field)));
+		EXPECT_STREQ("ll_trace_test", field);
+
+		/*
+		 * Verify tracee_domain: 0 when the tracee is unsandboxed,
+		 * non-zero when the tracee is in a domain.
+		 */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_PTRACE("ll_trace_test"),
+				     "tracee_domain", field, sizeof(field)));
+		EXPECT_EQ(variant->sandbox_target, strcmp("0", field) != 0)
+		{
+			TH_LOG("Unexpected tracee_domain=%s", field);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_ptrace events, got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
+/* clang-format off */
+FIXTURE(trace_ptrace_traceme) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_ptrace_traceme)
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
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_PTRACE_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_ptrace_traceme)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_PTRACE_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_ptrace_traceme)
+{
+	/* clang-format on */
+	bool sandbox_tracer;
+	bool sandbox_tracee;
+	int expect_denied;
+};
+
+/*
+ * Denied: a sandboxed tracer cannot trace the unsandboxed child that asked to
+ * be traced with PTRACE_TRACEME (tracee_domain=0).
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace_traceme, denied) {
+	/* clang-format on */
+	.sandbox_tracer = true,
+	.sandbox_tracee = false,
+	.expect_denied = 1,
+};
+
+/*
+ * Denied: a sandboxed child in its own domain asks to be traced by a tracer in
+ * an unrelated domain, so the tracee is in a domain and tracee_domain= is
+ * non-zero.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace_traceme, denied_scoped_tracee) {
+	/* clang-format on */
+	.sandbox_tracer = true,
+	.sandbox_tracee = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child uses PTRACE_TRACEME with an unsandboxed tracer. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace_traceme, allowed) {
+	/* clang-format on */
+	.sandbox_tracer = false,
+	.sandbox_tracee = false,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_ptrace_traceme, deny_ptrace)
+{
+	char *buf, field[64], expected_pid[16];
+	int count, status, sync_pipe[2];
+	pid_t child;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	/*
+	 * Set a known comm so the denied variant can verify both the trace line
+	 * task name and the tracee_comm= field.  The tracee is the current
+	 * (child) task for PTRACE_TRACEME, so the child inherits this name.
+	 */
+	prctl(PR_SET_NAME, "ll_trace_test");
+
+	ASSERT_EQ(0, pipe2(sync_pipe, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		char c;
+
+		close(sync_pipe[1]);
+
+		/*
+		 * The tracee is the current task; for the non-zero
+		 * tracee_domain case it sandboxes itself in its own domain,
+		 * unrelated to the tracer's domain, so PTRACE_TRACEME is still
+		 * denied and tracee_domain= names the child's own domain.
+		 */
+		if (variant->sandbox_tracee)
+			create_domain(_metadata);
+
+		/* Waits for the tracer (parent) to enter its domain, if any. */
+		if (read(sync_pipe[0], &c, 1) != 1)
+			_exit(1);
+		close(sync_pipe[0]);
+
+		if (variant->expect_denied) {
+			if (ptrace(PTRACE_TRACEME) == 0)
+				_exit(2);
+			if (errno != EPERM)
+				_exit(3);
+		} else {
+			if (ptrace(PTRACE_TRACEME) != 0)
+				_exit(4);
+			/* Lets the tracer reap the trace-stop and detach. */
+			raise(SIGSTOP);
+		}
+
+		_exit(0);
+	}
+
+	close(sync_pipe[0]);
+
+	/*
+	 * For a denial, the proposed tracer must be in a domain that is not an
+	 * ancestor of the tracee's domain.  Sandboxing the parent after the
+	 * fork gives it a domain unrelated to the child.
+	 */
+	if (variant->sandbox_tracer)
+		create_domain(_metadata);
+
+	/* Signals the child that the tracer is in its domain, if any. */
+	ASSERT_EQ(1, write(sync_pipe[1], ".", 1));
+	close(sync_pipe[1]);
+
+	if (!variant->expect_denied) {
+		/* PTRACE_TRACEME succeeded: reap the SIGSTOP and detach. */
+		ASSERT_EQ(child, waitpid(child, &status, WUNTRACED));
+		ASSERT_TRUE(WIFSTOPPED(status));
+		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_PTRACE("ll_trace_test"));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_ptrace event, got %d\n%s", count,
+			       buf);
+		}
+
+		/* Verify tracee_pid is the child's TGID (the traced task). */
+		snprintf(expected_pid, sizeof(expected_pid), "%d", child);
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_PTRACE("ll_trace_test"),
+				     "tracee_pid", field, sizeof(field)));
+		EXPECT_STREQ(expected_pid, field);
+
+		/*
+		 * Verify tracee_domain: 0 when the tracee is unsandboxed,
+		 * non-zero when the tracee is in a domain.
+		 */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_PTRACE("ll_trace_test"),
+				     "tracee_domain", field, sizeof(field)));
+		EXPECT_EQ(variant->sandbox_tracee, strcmp("0", field) != 0)
+		{
+			TH_LOG("Unexpected tracee_domain=%s", field);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_ptrace events, got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 40fc82fbf01d..6c945d319d32 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -12,6 +12,7 @@
 #include <sched.h>
 #include <signal.h>
 #include <stddef.h>
+#include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
@@ -23,6 +24,9 @@
 #include "audit.h"
 #include "common.h"
 #include "scoped_common.h"
+#include "trace.h"
+
+#define TRACE_TASK "scoped_abstract"
 
 /* Number of pending connections queue to be hold. */
 const short backlog = 10;
@@ -1205,4 +1209,463 @@ TEST(self_connect)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+/* Trace tests */
+
+/* clang-format off */
+FIXTURE(trace_unix) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_unix)
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
+	ASSERT_EQ(0, tracefs_enable_event(
+			     TRACEFS_DENY_SCOPE_ABSTRACT_UNIX_SOCKET_ENABLE,
+			     true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_unix)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_SCOPE_ABSTRACT_UNIX_SOCKET_ENABLE,
+			     false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_unix)
+{
+	/* clang-format on */
+	bool sandbox;
+	bool sandbox_target;
+	int expect_denied;
+};
+
+/* Denied: sandboxed child connects to unsandboxed peer (peer_domain=0). */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+};
+
+/*
+ * Denied: sandboxed child connects to a peer socket owned by a sandboxed
+ * process, so the peer is in a domain and peer_domain= is non-zero.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix, denied_scoped_peer) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child connects. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix, allowed) {
+	/* clang-format on */
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_unix, deny_scope_unix)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	char *buf, field[128], expected_path[64], expected_pid[16];
+	int server_fd, client_fd, count, status;
+	pid_t child;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	/*
+	 * For the non-zero peer_domain case, sandbox the parent before it
+	 * creates the server socket.  The peer domain is read from the server
+	 * socket file's credentials, so the socket carries the parent's domain
+	 * and peer_domain= is non-zero.
+	 */
+	if (variant->sandbox_target)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+
+	/* Create an abstract unix socket server in the parent. */
+	server_fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_LE(0, server_fd);
+
+	addr.sun_path[0] = '\0';
+	snprintf(addr.sun_path + 1, sizeof(addr.sun_path) - 1,
+		 "landlock_trace_test_%d", getpid());
+
+	ASSERT_EQ(0, bind(server_fd, (struct sockaddr *)&addr,
+			  offsetof(struct sockaddr_un, sun_path) + 1 +
+				  strlen(addr.sun_path + 1)));
+	ASSERT_EQ(0, listen(server_fd, 1));
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		if (variant->sandbox) {
+			struct landlock_ruleset_attr ruleset_attr = {
+				.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+			};
+			int ruleset_fd;
+
+			ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			if (ruleset_fd < 0)
+				_exit(1);
+
+			prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+			if (landlock_restrict_self(ruleset_fd, 0)) {
+				close(ruleset_fd);
+				_exit(1);
+			}
+			close(ruleset_fd);
+		}
+
+		client_fd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (client_fd < 0)
+			_exit(1);
+
+		if (variant->sandbox) {
+			/* Connect should be denied. */
+			if (connect(client_fd, (struct sockaddr *)&addr,
+				    offsetof(struct sockaddr_un, sun_path) + 1 +
+					    strlen(addr.sun_path + 1)) == 0) {
+				close(client_fd);
+				_exit(2);
+			}
+			if (errno != EPERM) {
+				close(client_fd);
+				_exit(3);
+			}
+		} else {
+			/* No sandbox: connect should succeed. */
+			if (connect(client_fd, (struct sockaddr *)&addr,
+				    offsetof(struct sockaddr_un, sun_path) + 1 +
+					    strlen(addr.sun_path + 1)) != 0) {
+				close(client_fd);
+				_exit(2);
+			}
+		}
+		close(client_fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+	close(server_fd);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(
+		buf, REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(TRACE_TASK));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_scope_abstract_unix_socket "
+			       "event, got %d\n%s",
+			       count, buf);
+		}
+
+		/* Verify sun_path (trace skips the leading NUL). */
+		snprintf(expected_path, sizeof(expected_path),
+			 "landlock_trace_test_%d", getpid());
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf,
+				     REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(
+					     TRACE_TASK),
+				     "sun_path", field, sizeof(field)));
+		EXPECT_STREQ(expected_path, field);
+
+		/* Verify peer_pid is the parent's PID. */
+		snprintf(expected_pid, sizeof(expected_pid), "%d", getpid());
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf,
+				     REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(
+					     TRACE_TASK),
+				     "peer_pid", field, sizeof(field)));
+		EXPECT_STREQ(expected_pid, field);
+
+		/*
+		 * Verify peer_domain: 0 when the peer is unsandboxed, non-zero
+		 * when the peer socket is owned by a domain.
+		 */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf,
+				     REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(
+					     TRACE_TASK),
+				     "peer_domain", field, sizeof(field)));
+		EXPECT_EQ(variant->sandbox_target, strcmp("0", field) != 0)
+		{
+			TH_LOG("Unexpected peer_domain=%s", field);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_scope events, got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
+/*
+ * Trace test for the datagram send path (hook_unix_may_send), which reaches the
+ * same landlock_deny_scope_abstract_unix_socket tracepoint as a stream
+ * connect(2) but through sendto(2) on an unconnected datagram socket.
+ */
+
+/* clang-format off */
+FIXTURE(trace_unix_dgram) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_unix_dgram)
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
+	ASSERT_EQ(0, tracefs_enable_event(
+			     TRACEFS_DENY_SCOPE_ABSTRACT_UNIX_SOCKET_ENABLE,
+			     true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_unix_dgram)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_SCOPE_ABSTRACT_UNIX_SOCKET_ENABLE,
+			     false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_unix_dgram)
+{
+	/* clang-format on */
+	bool sandbox;
+	bool sandbox_target;
+	int expect_denied;
+};
+
+/*
+ * Denied: sandboxed child sends a datagram to an unsandboxed peer
+ * (peer_domain=0).
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix_dgram, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+};
+
+/*
+ * Denied: sandboxed child sends a datagram to a peer socket owned by a
+ * sandboxed process, so the peer is in a domain and peer_domain= is non-zero.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix_dgram, denied_scoped_peer) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child sends a datagram. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix_dgram, allowed) {
+	/* clang-format on */
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_unix_dgram, deny_scope_unix)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	socklen_t addr_len;
+	char *buf, field[128], expected_path[64];
+	int server_fd, client_fd, count, status;
+	pid_t child;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	/*
+	 * For the non-zero peer_domain case, sandbox the parent before it
+	 * creates the server socket.  The peer domain is read from the server
+	 * socket file's credentials, so the socket carries the parent's domain
+	 * and peer_domain= is non-zero.
+	 */
+	if (variant->sandbox_target)
+		create_scoped_domain(_metadata,
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+
+	/* Create an abstract unix datagram server in the parent. */
+	server_fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	ASSERT_LE(0, server_fd);
+
+	addr.sun_path[0] = '\0';
+	snprintf(addr.sun_path + 1, sizeof(addr.sun_path) - 1,
+		 "landlock_trace_test_%d", getpid());
+	addr_len = offsetof(struct sockaddr_un, sun_path) + 1 +
+		   strlen(addr.sun_path + 1);
+
+	ASSERT_EQ(0, bind(server_fd, (struct sockaddr *)&addr, addr_len));
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		if (variant->sandbox) {
+			struct landlock_ruleset_attr ruleset_attr = {
+				.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+			};
+			int ruleset_fd;
+
+			ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			if (ruleset_fd < 0)
+				_exit(1);
+
+			prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+			if (landlock_restrict_self(ruleset_fd, 0)) {
+				close(ruleset_fd);
+				_exit(1);
+			}
+			close(ruleset_fd);
+		}
+
+		client_fd = socket(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+		if (client_fd < 0)
+			_exit(1);
+
+		if (variant->sandbox) {
+			/* Sending to the abstract peer should be denied. */
+			if (sendto(client_fd, ".", 1, 0,
+				   (struct sockaddr *)&addr, addr_len) == 0) {
+				close(client_fd);
+				_exit(2);
+			}
+			if (errno != EPERM) {
+				close(client_fd);
+				_exit(3);
+			}
+		} else {
+			/* No sandbox: sending should succeed. */
+			if (sendto(client_fd, ".", 1, 0,
+				   (struct sockaddr *)&addr, addr_len) != 1) {
+				close(client_fd);
+				_exit(2);
+			}
+		}
+		close(client_fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+	close(server_fd);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(
+		buf, REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(TRACE_TASK));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_scope_abstract_unix_socket "
+			       "event, got %d\n%s",
+			       count, buf);
+		}
+
+		/* Verify sun_path (trace skips the leading NUL). */
+		snprintf(expected_path, sizeof(expected_path),
+			 "landlock_trace_test_%d", getpid());
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf,
+				     REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(
+					     TRACE_TASK),
+				     "sun_path", field, sizeof(field)));
+		EXPECT_STREQ(expected_path, field);
+
+		/*
+		 * peer_pid is 0 for a datagram peer (no SO_PEERCRED), so it is
+		 * not asserted here; sun_path is the reliable peer identifier.
+		 *
+		 * Verify peer_domain: 0 when the peer is unsandboxed, non-zero
+		 * when the peer socket is owned by a domain.
+		 */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf,
+				     REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(
+					     TRACE_TASK),
+				     "peer_domain", field, sizeof(field)));
+		EXPECT_EQ(variant->sandbox_target, strcmp("0", field) != 0)
+		{
+			TH_LOG("Unexpected peer_domain=%s", field);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_scope events, got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 2d37d0c06c06..259cdcc8aa5c 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -10,7 +10,9 @@
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <pthread.h>
+#include <sched.h>
 #include <signal.h>
+#include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -18,6 +20,9 @@
 
 #include "common.h"
 #include "scoped_common.h"
+#include "trace.h"
+
+#define TRACE_TASK "scoped_signal_t"
 
 /* This variable is used for handling several signals. */
 static volatile sig_atomic_t is_signaled;
@@ -762,4 +767,403 @@ TEST(sigio_to_pgid_self)
 	EXPECT_EQ(0, close(trigger[1]));
 }
 
+/* Trace tests */
+
+/* clang-format off */
+FIXTURE(trace_signal) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_signal)
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
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_DENY_SCOPE_SIGNAL_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_signal)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_SCOPE_SIGNAL_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_signal)
+{
+	/* clang-format on */
+	bool sandbox;
+	bool sandbox_target;
+	int expect_denied;
+};
+
+/* Denied: sandboxed child signals unsandboxed parent (target_domain=0). */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_signal, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+};
+
+/*
+ * Denied: sandboxed child signals a sandboxed parent, so the target is in a
+ * domain and target_domain= is non-zero.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_signal, denied_scoped_target) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child signals unsandboxed parent. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_signal, allowed) {
+	/* clang-format on */
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_signal, deny_scope_signal)
+{
+	char *buf, field[64], expected_pid[16];
+	int count, status;
+	pid_t child;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	/*
+	 * For the non-zero target_domain case, sandbox the parent (the signal
+	 * target) before forking.  The child inherits that domain and adds its
+	 * own scoped layer, so the signal is still denied and target_domain=
+	 * names the parent's domain.
+	 */
+	if (variant->sandbox_target)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		if (variant->sandbox) {
+			struct landlock_ruleset_attr ruleset_attr = {
+				.scoped = LANDLOCK_SCOPE_SIGNAL,
+			};
+			int ruleset_fd;
+
+			ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			if (ruleset_fd < 0)
+				_exit(1);
+
+			prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+			if (landlock_restrict_self(ruleset_fd, 0)) {
+				close(ruleset_fd);
+				_exit(1);
+			}
+			close(ruleset_fd);
+		}
+
+		if (variant->sandbox) {
+			/* Signal to unsandboxed parent should be denied. */
+			if (kill(getppid(), 0) == 0)
+				_exit(2);
+			if (errno != EPERM)
+				_exit(3);
+		} else {
+			/* No sandbox: kill should succeed. */
+			if (kill(getppid(), 0) != 0)
+				_exit(1);
+		}
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_SCOPE_SIGNAL(TRACE_TASK));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_scope_signal event, got %d\n%s",
+			       count, buf);
+		}
+
+		/* Verify target_pid is the parent's PID. */
+		snprintf(expected_pid, sizeof(expected_pid), "%d", getpid());
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_SCOPE_SIGNAL(TRACE_TASK),
+				     "target_pid", field, sizeof(field)));
+		EXPECT_STREQ(expected_pid, field);
+
+		/*
+		 * Verify target_domain: 0 when the target is unsandboxed,
+		 * non-zero when the target is in a domain.
+		 */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_SCOPE_SIGNAL(TRACE_TASK),
+				     "target_domain", field, sizeof(field)));
+		EXPECT_EQ(variant->sandbox_target, strcmp("0", field) != 0)
+		{
+			TH_LOG("Unexpected target_domain=%s", field);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_scope_signal events, "
+			       "got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
+/*
+ * Trace test for the asynchronous SIGIO/SIGURG delivery path
+ * (hook_file_send_sigiotask), which reaches the same landlock_deny_scope_signal
+ * tracepoint as a synchronous kill(2) but through fcntl(F_SETOWN).
+ */
+
+/* clang-format off */
+FIXTURE(trace_fown) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_fown)
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
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_DENY_SCOPE_SIGNAL_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_fown)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_SCOPE_SIGNAL_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_fown)
+{
+	/* clang-format on */
+	bool sandbox;
+	bool sandbox_target;
+	int expect_denied;
+};
+
+/*
+ * Denied: a sandboxed file owner's SIGURG is delivered to an unsandboxed target
+ * process (target_domain=0).
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_fown, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+};
+
+/*
+ * Denied: the SIGURG target sandboxes itself in its own domain, so the target
+ * is in a domain and target_domain= is non-zero.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_fown, denied_scoped_target) {
+	/* clang-format on */
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: an unsandboxed file owner delivers SIGURG. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_fown, allowed) {
+	/* clang-format on */
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_fown, deny_scope_fown)
+{
+	int server_socket, recv_socket;
+	struct service_fixture server_address;
+	char buffer_parent, field[64], *buf;
+	int status, count;
+	int pipe_parent[2], pipe_child[2];
+	pid_t child;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	memset(&server_address, 0, sizeof(server_address));
+	set_unix_address(&server_address, 0);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int client_socket;
+		char buffer_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		ASSERT_EQ(0, setup_signal_handler(SIGURG));
+		client_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, client_socket);
+
+		/*
+		 * The SIGURG target is this child; for the non-zero
+		 * target_domain case it sandboxes itself in its own domain,
+		 * unrelated to the file owner's domain.
+		 */
+		if (variant->sandbox_target)
+			create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+		/* Waits for the parent to listen. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buffer_child, 1));
+		ASSERT_EQ(0, connect(client_socket, &server_address.unix_addr,
+				     server_address.unix_addr_len));
+
+		/*
+		 * Waits for the parent to accept the connection, sandbox
+		 * itself, and call fcntl(F_SETOWN).
+		 */
+		ASSERT_EQ(1, read(pipe_parent[0], &buffer_child, 1));
+		/* Triggers the asynchronous SIGURG to this file owner. */
+		ASSERT_EQ(1, send(client_socket, ".", 1, MSG_OOB));
+		EXPECT_EQ(0, close(client_socket));
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		EXPECT_EQ(0, close(pipe_child[1]));
+
+		_exit(0);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+
+	server_socket = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, server_socket);
+	ASSERT_EQ(0, bind(server_socket, &server_address.unix_addr,
+			  server_address.unix_addr_len));
+	ASSERT_EQ(0, listen(server_socket, backlog));
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	recv_socket = accept(server_socket, NULL, NULL);
+	ASSERT_LE(0, recv_socket);
+
+	/*
+	 * The file owner is the denying subject; its domain is captured at
+	 * fcntl(F_SETOWN) time, so sandbox it before setting the owner.
+	 */
+	if (variant->sandbox)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+
+	/*
+	 * Sets the child to receive SIGURG for MSG_OOB.  This uncommon use is a
+	 * valid attack scenario which also simplifies this test.
+	 */
+	ASSERT_EQ(0, fcntl(recv_socket, F_SETOWN, child));
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	/* Waits for the child to send MSG_OOB. */
+	ASSERT_EQ(1, read(pipe_child[0], &buffer_parent, 1));
+	EXPECT_EQ(0, close(pipe_child[0]));
+	ASSERT_EQ(1, recv(recv_socket, &buffer_parent, 1, MSG_OOB));
+	EXPECT_EQ(0, close(recv_socket));
+	EXPECT_EQ(0, close(server_socket));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_SCOPE_SIGNAL(TRACE_TASK));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_scope_signal event, got %d\n%s",
+			       count, buf);
+		}
+
+		/*
+		 * Verify target_domain: 0 when the target is unsandboxed,
+		 * non-zero when the target is in a domain.
+		 */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_SCOPE_SIGNAL(TRACE_TASK),
+				     "target_domain", field, sizeof(field)));
+		EXPECT_EQ(variant->sandbox_target, strcmp("0", field) != 0)
+		{
+			TH_LOG("Unexpected target_domain=%s", field);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_scope_signal events, "
+			       "got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
index 31f17b43e9f4..e03c689ef398 100644
--- a/tools/testing/selftests/landlock/trace.h
+++ b/tools/testing/selftests/landlock/trace.h
@@ -146,13 +146,14 @@
 	"sport=[0-9]\\+ "            \
 	"dport=[0-9]\\+$"
 
-#define REGEX_DENY_PTRACE(task)  \
-	TRACE_PREFIX(task)       \
-	"landlock_deny_ptrace: " \
-	"domain=[0-9a-f]\\+ "    \
-	"same_exec=[01] "        \
-	"logged=[01] "           \
-	"tracee_pid=[0-9]\\+ "   \
+#define REGEX_DENY_PTRACE(task)      \
+	TRACE_PREFIX(task)           \
+	"landlock_deny_ptrace: "     \
+	"domain=[0-9a-f]\\+ "        \
+	"same_exec=[01] "            \
+	"logged=[01] "               \
+	"tracee_domain=[0-9a-f]\\+ " \
+	"tracee_pid=[0-9]\\+ "       \
 	"tracee_comm=[^ ]*$"
 
 #define REGEX_DENY_SCOPE_SIGNAL(task)  \
@@ -161,6 +162,7 @@
 	"domain=[0-9a-f]\\+ "          \
 	"same_exec=[01] "              \
 	"logged=[01] "                 \
+	"target_domain=[0-9a-f]\\+ "   \
 	"target_pid=[0-9]\\+ "         \
 	"target_comm=[^ ]*$"
 
@@ -170,6 +172,7 @@
 	"domain=[0-9a-f]\\+ "                        \
 	"same_exec=[01] "                            \
 	"logged=[01] "                               \
+	"peer_domain=[0-9a-f]\\+ "                   \
 	"peer_pid=[0-9]\\+ "                         \
 	"sun_path=[^ ]*$"
 
-- 
2.54.0


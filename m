Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17135383C82
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486275; cv=none; b=RHKaz2jUIYnirkeRXgwgIVmM00/1VIXdbLIYJ77LxApJV/Ob2i5amxDs2XWpwO2orP8TJUhYrk7f3gnTokCLJDOWxfrAxjzel1PeYehGMSfFY+SVtz42rSENStVjbXgGiq+j3GMwi1Nx3mC8UKozjLAURS/YEM5GRV7XpN5bbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486275; c=relaxed/simple;
	bh=ngo00kaTm6GyTLd/biWZ+NHmP8Ub8S+CRsHC5/kfzqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF6kckb1A1NdqrqyMBLrHkqRzVY33ghxt+Xw172C7iZRjIIIw30brISqKNtYoHnLo4wu1paHDexS0D9uFJK6b6QpUJdW5VhoCHP3nknpAPCo8v7gSj0KKhBha0dAdzoNs5rnnMaoW+AR2dhqQ+ZFIQUp33DJKzf2q0KlfQugrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bpt1LwL0; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bpt1LwL0"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkf1NqtzTZ;
	Mon,  6 Apr 2026 16:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486266;
	bh=kBcFEFeNEIOBXPCARNSv4BBHr76IarBg0xymviddQXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpt1LwL0LdfIAbipBLhwX04HjGAQxYikGJs+2Rv/tPNyM9MGu2KFx3LS3ZdDwV2OI
	 vgXkts9+whnpZTpR+KJusZOqi0fqu+IbhdxU9J5nvQpFCoKhZurReTDpoEBlJGBH87
	 CNCn0jgdD5iC0Dt9dcn9pNYmLzlPZvLRvbErbswE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkd4XRHzgRw;
	Mon,  6 Apr 2026 16:37:45 +0200 (CEST)
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
Subject: [PATCH v2 16/17] selftests/landlock: Add scope and ptrace tracepoint tests
Date: Mon,  6 Apr 2026 16:37:14 +0200
Message-ID: <20260406143717.1815792-17-mic@digikod.net>
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

Add trace tests for the landlock_deny_ptrace,
landlock_deny_scope_signal, and landlock_deny_scope_abstract_unix_socket
tracepoints, following the audit test pattern of placing tests alongside
the functional tests for each subsystem.

The ptrace trace test verifies that the landlock_deny_ptrace event fires
when a sandboxed child attempts to ptrace an unsandboxed parent.  The
signal and unix socket tests verify the corresponding scope tracepoints
fire on denied operations.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 .../testing/selftests/landlock/ptrace_test.c  | 164 +++++++++++++++
 .../landlock/scoped_abstract_unix_test.c      | 195 ++++++++++++++++++
 .../selftests/landlock/scoped_signal_test.c   | 150 ++++++++++++++
 3 files changed, 509 insertions(+)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 1b6c8b53bf33..a72035d1c27b 100644
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
@@ -429,4 +432,165 @@ TEST_F(audit, trace)
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
+	int expect_denied;
+};
+
+/* Denied: sandboxed child ptraces unsandboxed parent. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child uses PTRACE_TRACEME. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_ptrace, allowed) {
+	/* clang-format on */
+	.sandbox = false,
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
+	 * Set a known comm so the denied variant can verify both the trace
+	 * line task name and the comm= field.
+	 */
+	prctl(PR_SET_NAME, "ll_trace_test");
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
+			 * Any scope creates a domain.  Ptrace denial
+			 * checks domain ancestry, not specific flags.
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
+		EXPECT_LE(variant->expect_denied, count)
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
+		/* Verify comm matches prctl(PR_SET_NAME). */
+		ASSERT_EQ(0, tracefs_extract_field(
+				     buf, REGEX_DENY_PTRACE("ll_trace_test"),
+				     "comm", field, sizeof(field)));
+		EXPECT_STREQ("ll_trace_test", field);
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
index c47491d2d1c1..444df8ead1bf 100644
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
@@ -1145,4 +1149,195 @@ TEST(self_connect)
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
+	int expect_denied;
+};
+
+/* Denied: sandboxed child connects to unsandboxed parent's socket. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child connects. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_unix, allowed) {
+	/* clang-format on */
+	.sandbox = false,
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
+		EXPECT_LE(variant->expect_denied, count)
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
index d8bf33417619..811dc4b9358d 100644
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
@@ -559,4 +564,149 @@ TEST_F(fown, sigurg_socket)
 		_metadata->exit_code = KSFT_FAIL;
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
+	int expect_denied;
+};
+
+/* Denied: sandboxed child signals unsandboxed parent. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_signal, denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.expect_denied = 1,
+};
+
+/* Allowed: unsandboxed child signals unsandboxed parent. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_signal, allowed) {
+	/* clang-format on */
+	.sandbox = false,
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
+		EXPECT_LE(variant->expect_denied, count)
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
-- 
2.53.0


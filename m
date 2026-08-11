Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205942D770
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441467; cv=none; b=r2FyZqh6vBoyKI3IYT8cWneIfjgNCLJr1kCsEPW2kppxpRK8PXJEkpmwDJnZtR1t0iiopspcSF8yXRXCmOrclBaPe99/ER1q6N4PJHfrHDf1VoxR+Mo8XR9rJC7Wt4w8zwDd/sovL9SOGLEWBqZHDFmI6IIy2QoJUrB/7T69sPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441467; c=relaxed/simple;
	bh=BBv6UN28fUdijMcsJYXQq19WCZHXD/knKZf5W2mL6Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMFwTH26OzDdIiUU00Xy6MQPaN4kCsHSSJYWoxW/2KXCPlERqEMScuxNhcdqyn/J20Htr++s3Lw0er4PVgeLKzUeX7Xv+3vzHclQYB9qW+YF1kqKyf9btVuKDDBnr2KqIwBVAF+oIqCDKVcFj9EWPICp0v5znOLgC91BXZZoV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xQcHvvUd; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xQcHvvUd"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK6CM4HLHzCNb;
	Tue, 11 Aug 2026 11:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786441455;
	bh=yLvnwTzY+v7f+XlQ8oDEixSiRUAPiB+rpIfksO4deXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xQcHvvUdEsxJdRSI+tACAaEDHZ8DeAmUKK8oT7rHMvxkHiZnEsd/yT00FQu6VbBz6
	 Ee9knJZCxamBnFjDxDAGLdiXS68iQrSGNcJu3mD6BeVAO4CDT0CFTFT1yxp+TGVimL
	 car+Y3j7KeSPe2mGhUo7Cb7Akl98yhQcTe+lD8qU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK6CL30dVzS7p;
	Tue, 11 Aug 2026 11:44:14 +0200 (CEST)
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
Subject: [PATCH v4 16/19] selftests/landlock: Add network tracepoint tests
Date: Tue, 11 Aug 2026 11:43:30 +0200
Message-ID: <20260811094338.288094-17-mic@digikod.net>
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

Add network-specific trace tests, co-located with the existing audit
fixture so each subsystem's functional, audit, and trace tests live
together.

Parameterized fixtures verify the landlock_deny_access_net event: a bind
or connect denied outside the ruleset emits exactly one event with the
expected sport/dport, an allowed bind or connect emits none, and the
unsandboxed baseline emits none.  A separate fixture verifies the
landlock_check_rule_net event on an allowed bind, anchoring its domain,
access_request, port, and grants to exact values; only check_rule_fs had
a dedicated field test before.

Port fields are read in host endianness, matching the
landlock_net_port_attr.port UAPI convention, so the decimal comparisons
also catch byte-order regressions in the tracepoint plumbing.  IPv6
trace tests are intentionally elided: IPv6 hook dispatch shares the
current_check_access_socket() path with IPv4 (covered by the audit
tests), and the trace fields do not depend on address family.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260722171159.2776765-18-mic@digikod.net
- Collapse the three trace_net_connect deny_access_net field tests
  (connect_denied, bind_fields, connect_after_bind) into one
  parametrized deny_access_net test with a FIXTURE_VARIANT selecting
  the handled access, an optional allowed-port bind, and the denied
  operation (connect vs bind); same three cases and sport/dport
  assertions.  check_rule_net_fields stays separate.

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-16-mic@digikod.net
- Anchor the shared denial fields (non-zero domain, same_exec, logged,
  non-empty blockers) in the deny_access_net field tests via a common
  helper, so they prove the whole event stays populated rather than
  only checking sport/dport.
- Add setup_loopback() to the trace_net and trace_net_connect fixtures
  (network-namespace isolation matching the rest of net_test.c) so a
  bound loopback port cannot collide with a concurrent test.
- Tighten the denied-event count assertions from EXPECT_LE to EXPECT_EQ
  (a single denied operation on a single-layer domain emits exactly one
  event), matching the scope and ptrace trace tests.
- Add a check_rule_net field test (check_rule_net_fields): an allowed
  bind matching a net-port rule emits one landlock_check_rule_net event
  with domain, access_request, port, and grants pinned to exact values;
  only check_rule_fs had a dedicated field test before.

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/net_test.c | 590 +++++++++++++++++++-
 1 file changed, 589 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index be2eb88092fb..a18761e0fd82 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -10,11 +10,12 @@
 #include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <linux/landlock.h>
 #include <linux/in.h>
+#include <linux/landlock.h>
 #include <sched.h>
 #include <stdint.h>
 #include <string.h>
+#include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/syscall.h>
@@ -22,6 +23,9 @@
 
 #include "audit.h"
 #include "common.h"
+#include "trace.h"
+
+#define TRACE_TASK "net_test"
 
 const short sock_port_start = (1 << 10);
 
@@ -3285,4 +3289,588 @@ TEST_F(audit, sendmsg)
 	EXPECT_EQ(0, close(sock_fd));
 }
 
+/* Trace tests */
+
+/* clang-format off */
+FIXTURE(trace_net) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_net)
+{
+	int ret;
+
+	/* Isolate the network namespace so the bound port cannot collide. */
+	setup_loopback(_metadata);
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
+		  tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_net)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/*
+ * Baseline: verifies that without Landlock, the bind succeeds and no
+ * deny_access_net trace event fires.
+ */
+/* clang-format off */
+FIXTURE_VARIANT(trace_net)
+{
+	/* clang-format on */
+	bool sandbox;
+	int bind_port_offset; /* 0 = allowed port, 1 = denied port */
+	int expect_denied;
+};
+
+/* Unsandboxed: no Landlock, bind should succeed with no events. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_net, unsandboxed) {
+	/* clang-format on */
+	.sandbox = false,
+	.bind_port_offset = 0,
+	.expect_denied = 0,
+};
+
+/* Denied: sandboxed, bind to port not in ruleset. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_net, bind_denied) {
+	/* clang-format on */
+	.sandbox = true,
+	.bind_port_offset = 1,
+	.expect_denied = 1,
+};
+
+/* Allowed: sandboxed, bind to port in ruleset. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_net, bind_allowed) {
+	/* clang-format on */
+	.sandbox = true,
+	.bind_port_offset = 0,
+	.expect_denied = 0,
+};
+
+TEST_F(trace_net, deny_access_net_bind)
+{
+	char *buf;
+	int count, status;
+	pid_t child;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		struct sockaddr_in addr = {
+			.sin_family = AF_INET,
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		int sock_fd;
+
+		if (variant->sandbox) {
+			struct landlock_ruleset_attr ruleset_attr = {
+				.handled_access_net =
+					LANDLOCK_ACCESS_NET_BIND_TCP,
+			};
+			struct landlock_net_port_attr port_attr = {
+				.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+				.port = sock_port_start,
+			};
+			int ruleset_fd;
+
+			ruleset_fd = landlock_create_ruleset(
+				&ruleset_attr, sizeof(ruleset_attr), 0);
+			if (ruleset_fd < 0)
+				_exit(1);
+
+			if (landlock_add_rule(ruleset_fd,
+					      LANDLOCK_RULE_NET_PORT,
+					      &port_attr, 0)) {
+				close(ruleset_fd);
+				_exit(1);
+			}
+
+			prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+			if (landlock_restrict_self(ruleset_fd, 0)) {
+				close(ruleset_fd);
+				_exit(1);
+			}
+			close(ruleset_fd);
+		}
+
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (sock_fd < 0)
+			_exit(1);
+
+		addr.sin_port =
+			htons(sock_port_start + variant->bind_port_offset);
+		if (variant->expect_denied) {
+			/* Bind should be denied. */
+			if (bind(sock_fd, (struct sockaddr *)&addr,
+				 sizeof(addr)) == 0) {
+				close(sock_fd);
+				_exit(2);
+			}
+			if (errno != EACCES) {
+				close(sock_fd);
+				_exit(3);
+			}
+		} else {
+			/* Bind should succeed. */
+			if (bind(sock_fd, (struct sockaddr *)&addr,
+				 sizeof(addr))) {
+				close(sock_fd);
+				_exit(2);
+			}
+		}
+		close(sock_fd);
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
+	count = tracefs_count_matches(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK));
+	if (variant->expect_denied) {
+		EXPECT_EQ(variant->expect_denied, count)
+		{
+			TH_LOG("Expected deny_access_net event, got %d\n%s",
+			       count, buf);
+		}
+	} else {
+		EXPECT_EQ(0, count)
+		{
+			TH_LOG("Expected 0 deny_access_net events, "
+			       "got %d\n%s",
+			       count, buf);
+		}
+	}
+
+	free(buf);
+}
+
+/*
+ * Anchors the denial fields shared by every deny_access_net event so a field
+ * test proves more than sport/dport: the denying domain, the same-exec bit, the
+ * audit-logging verdict, and the blocked access all stay populated.
+ */
+static void
+expect_net_deny_common_fields(struct __test_metadata *const _metadata,
+			      const char *const buf)
+{
+	char field[64];
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"domain", field, sizeof(field)));
+	EXPECT_STRNE("0", field);
+
+	/* Same exec that restricted itself, no exec in between. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"same_exec", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	/* Default flags, same exec: audit would log this denial. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"logged", field, sizeof(field)));
+	EXPECT_STREQ("1", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"blockers", field, sizeof(field)));
+	EXPECT_STRNE("", field);
+}
+
+/* Connect and field-check tests use a separate fixture without variants. */
+
+/* clang-format off */
+FIXTURE(trace_net_connect) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_net_connect)
+{
+	int ret;
+
+	/* Isolate the network namespace so the bound port cannot collide. */
+	setup_loopback(_metadata);
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
+		  tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_net_connect)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_DENY_ACCESS_NET_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE_VARIANT(trace_net_connect) {
+	/* clang-format on */
+	/* handled_access_net, also the access allowed on the base port. */
+	__u64 handled;
+	/* Bind the allowed base port before the denied operation. */
+	bool bind_base_first;
+	/* Denied operation on the next port: connect (true) or bind (false). */
+	bool deny_connect;
+};
+
+/* clang-format off */
+
+/* Denied connect(): sport=0, dport=<denied port>. */
+FIXTURE_VARIANT_ADD(trace_net_connect, connect_denied) {
+	.handled = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	.bind_base_first = false,
+	.deny_connect = true,
+};
+
+/* Denied bind(): sport=<denied port>, dport=0. */
+FIXTURE_VARIANT_ADD(trace_net_connect, bind_fields) {
+	.handled = LANDLOCK_ACCESS_NET_BIND_TCP,
+	.bind_base_first = false,
+	.deny_connect = false,
+};
+
+/* Denied connect() after an allowed bind(): the connect fields (sport=0). */
+FIXTURE_VARIANT_ADD(trace_net_connect, connect_after_bind) {
+	.handled = LANDLOCK_ACCESS_NET_BIND_TCP | LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	.bind_base_first = true,
+	.deny_connect = true,
+};
+
+/* clang-format on */
+
+/*
+ * A denied TCP bind(2) or connect(2) emits one deny_access_net event.  The port
+ * is reported in the field matching the denied operation, in host endianness
+ * (the UAPI landlock_net_port_attr.port convention): a connect denial reports
+ * sport=0 dport=<port>, a bind denial reports sport=<port> dport=0, so a
+ * byte-order or field-swap bug is caught.  A prior allowed bind
+ * (connect_after_bind) does not change the connect denial's fields.
+ */
+TEST_F(trace_net_connect, deny_access_net)
+{
+	pid_t child;
+	int status;
+	char *buf;
+	char field[64], expected[16];
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = variant->handled,
+		};
+		struct landlock_net_port_attr port_attr = {
+			.allowed_access = variant->handled,
+			.port = sock_port_start,
+		};
+		struct sockaddr_in addr = {
+			.sin_family = AF_INET,
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		int ruleset_fd, sock_fd, optval = 1, ret;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				      &port_attr, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(ruleset_fd);
+
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (sock_fd < 0)
+			_exit(1);
+
+		/* Bind the allowed base port first (succeeds, no event). */
+		if (variant->bind_base_first) {
+			setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &optval,
+				   sizeof(optval));
+			addr.sin_port = htons(sock_port_start);
+			if (bind(sock_fd, (struct sockaddr *)&addr,
+				 sizeof(addr))) {
+				close(sock_fd);
+				_exit(1);
+			}
+		}
+
+		/* Denied operation on the next port. */
+		addr.sin_port = htons(sock_port_start + 1);
+		if (variant->deny_connect)
+			ret = connect(sock_fd, (struct sockaddr *)&addr,
+				      sizeof(addr));
+		else
+			ret = bind(sock_fd, (struct sockaddr *)&addr,
+				   sizeof(addr));
+		if (ret == 0) {
+			close(sock_fd);
+			_exit(2);
+		}
+		if (errno != EACCES) {
+			close(sock_fd);
+			_exit(3);
+		}
+		close(sock_fd);
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
+	EXPECT_EQ(1, tracefs_count_matches(buf,
+					   REGEX_DENY_ACCESS_NET(TRACE_TASK)));
+
+	expect_net_deny_common_fields(_metadata, buf);
+
+	/*
+	 * The denied operation's port field carries the port; the other is 0.
+	 */
+	snprintf(expected, sizeof(expected), "%llu",
+		 (unsigned long long)(sock_port_start + 1));
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"sport", field, sizeof(field)));
+	EXPECT_STREQ(variant->deny_connect ? "0" : expected, field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"dport", field, sizeof(field)));
+	EXPECT_STREQ(variant->deny_connect ? expected : "0", field);
+
+	free(buf);
+}
+
+/* Field verification for the check_rule_net event on an allowed access. */
+
+/* clang-format off */
+FIXTURE(trace_net_check_rule) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_net_check_rule)
+{
+	int ret;
+
+	/* Isolate the network namespace so the bound port cannot collide. */
+	setup_loopback(_metadata);
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
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_net_check_rule)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/*
+ * Verifies that an allowed bind matching a net-port rule emits exactly one
+ * landlock_check_rule_net event with the enforcing domain, the requested
+ * access, the checked port (host endianness), and the per-layer grants.  The
+ * whole event is anchored to exact values so a revert of the check_rule_net
+ * emit (or a byte-order or field-plumbing regression) fails the test.
+ */
+TEST_F(trace_net_check_rule, check_rule_net_fields)
+{
+	pid_t child;
+	int status;
+	char *buf;
+	char field[64], expected[16];
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	child = fork();
+	ASSERT_LE(0, child);
+
+	if (child == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+		};
+		struct landlock_net_port_attr port_attr = {
+			.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+			.port = sock_port_start,
+		};
+		struct sockaddr_in addr = {
+			.sin_family = AF_INET,
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		int ruleset_fd, sock_fd;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				      &port_attr, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(ruleset_fd);
+
+		/* Bind to the allowed port: succeeds and matches the rule. */
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (sock_fd < 0)
+			_exit(1);
+
+		addr.sin_port = htons(sock_port_start);
+		if (bind(sock_fd, (struct sockaddr *)&addr, sizeof(addr))) {
+			close(sock_fd);
+			_exit(2);
+		}
+		close(sock_fd);
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
+	/* A single-layer domain matching one port rule emits one event. */
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CHECK_RULE_NET(TRACE_TASK)))
+	{
+		TH_LOG("Expected 1 check_rule_net event\n%s", buf);
+	}
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CHECK_RULE_NET(TRACE_TASK),
+					"domain", field, sizeof(field)));
+	EXPECT_STRNE("0", field);
+
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_CHECK_RULE_NET(TRACE_TASK),
+			     "access_request", field, sizeof(field)));
+	EXPECT_STREQ("bind_tcp", field);
+
+	/*
+	 * The port is reported in host endianness (UAPI convention), so on
+	 * little-endian htons(sock_port_start) would print a different value:
+	 * the exact match also catches byte-order regressions.
+	 */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CHECK_RULE_NET(TRACE_TASK),
+					"port", field, sizeof(field)));
+	snprintf(expected, sizeof(expected), "%llu",
+		 (unsigned long long)sock_port_start);
+	EXPECT_STREQ(expected, field);
+
+	/* One layer that fully grants the request: grants={bind_tcp}. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_CHECK_RULE_NET(TRACE_TASK),
+					"grants", field, sizeof(field)));
+	EXPECT_STREQ("{bind_tcp}", field);
+
+	free(buf);
+}
+
+/*
+ * IPv6 network trace tests are intentionally elided.  IPv6 hook dispatch uses
+ * the same current_check_access_socket() code path as IPv4, validated by the
+ * audit tests in this file.  The trace events use the same blockers/sport/dport
+ * fields regardless of address family.
+ */
+
 TEST_HARNESS_MAIN
-- 
2.54.0


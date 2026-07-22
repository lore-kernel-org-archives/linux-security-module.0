Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE943CE68
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740374; cv=none; b=d8FO+Sp1Y2l+bhSRmYodBAiPmrDxtgdn2OiM3a1zmZ42i3bMBXwQsyoh55NUi/O76pfKMrRdg7ClKxbmYCKnbLBsBmSjwYoOC4hVm7pGn0ILUvxJwaSLQb1ZwOp+6qt0Jorqd3tTjOItp2tBHzrl9EEmz/4l/+YvDLsmm3oKWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740374; c=relaxed/simple;
	bh=stKuuMpuAAPHOTXtsACfC9VmxMbAEF3s3noMrgUIvsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGhTGGqxMrqjcjPmjv9k0mAsIJX1SP0rsPM0tjv2NKFXjQ+QNidFrd/FoHXgfYcT1czvDgrmi8wzyq0/KFCbsy4AMk1Vb2S3oQUCrP5MIIfgSHtz/CQp3EnpFEZvMlB71K770KyPnDMn56ABst69pvUuFaoh7LlvpMpgUPpL4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CcbYa3Hv; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CcbYa3Hv"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515y3NHJzrPM;
	Wed, 22 Jul 2026 19:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740358;
	bh=dToD7+sYVqAxPaK6I2iQ8iUDgEQC3LVemGChTUy0RKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcbYa3HvlpoKbUKefXudPZicAe/KwRdBPwqj5QBUlbbEb2za9Qo0AZVFW+rYxVNQs
	 KisZ5PWQyhR6bjq8V0Ix1VukwvPuUCeQgzDZm1DR/M2ILrrPkJodY9SMMOHDuZKBuf
	 1NcJ91CpjleTK7U0Lpo7pv3afd+jg7QW+vsVpiF8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515x2lXszc09;
	Wed, 22 Jul 2026 19:12:37 +0200 (CEST)
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
Subject: [PATCH v3 17/20] selftests/landlock: Add network tracepoint tests
Date: Wed, 22 Jul 2026 19:11:49 +0200
Message-ID: <20260722171159.2776765-18-mic@digikod.net>
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
 tools/testing/selftests/landlock/net_test.c | 747 +++++++++++++++++++-
 1 file changed, 746 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index be2eb88092fb..578bb0a64f11 100644
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
 
@@ -3285,4 +3289,745 @@ TEST_F(audit, sendmsg)
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
+/*
+ * Verifies that a denied connect emits a deny_access_net trace event with
+ * sport=0 and dport=<denied_port>.
+ */
+TEST_F(trace_net_connect, deny_access_net_connect_denied)
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
+			.handled_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		};
+		struct landlock_net_port_attr port_attr = {
+			.allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
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
+		/* Connect to denied port. */
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (sock_fd < 0)
+			_exit(1);
+
+		addr.sin_port = htons(sock_port_start + 1);
+		if (connect(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) ==
+		    0) {
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
+	 * Verify dport is the denied port and sport is 0.  The port value must
+	 * be in host endianness, matching the UAPI convention
+	 * (landlock_net_port_attr.port).  On little-endian,
+	 * htons(sock_port_start + 1) would produce a different decimal value,
+	 * so this comparison also catches byte-order bugs.
+	 */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"sport", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"dport", field, sizeof(field)));
+	snprintf(expected, sizeof(expected), "%llu",
+		 (unsigned long long)(sock_port_start + 1));
+	EXPECT_STREQ(expected, field);
+
+	free(buf);
+}
+
+/* Verifies that a denied bind emits sport=<port> dport=0. */
+TEST_F(trace_net_connect, deny_access_net_bind_fields)
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
+		/* Bind to denied port. */
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (sock_fd < 0)
+			_exit(1);
+
+		addr.sin_port = htons(sock_port_start + 1);
+		if (bind(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) ==
+		    0) {
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
+	/* Verify sport is the denied port and dport is 0. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"dport", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"sport", field, sizeof(field)));
+	snprintf(expected, sizeof(expected), "%llu",
+		 (unsigned long long)(sock_port_start + 1));
+	EXPECT_STREQ(expected, field);
+
+	free(buf);
+}
+
+/*
+ * Verifies that a denied connect after a successful bind shows sport=0 and
+ * dport=<denied_port>.  The bind succeeds (allowed port), then the connect is
+ * denied.  sport=0 because the denied operation is connect, not bind.
+ */
+TEST_F(trace_net_connect, deny_access_net_connect_after_bind)
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
+			.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+					      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		};
+		struct landlock_net_port_attr port_attr;
+		struct sockaddr_in bind_addr = {
+			.sin_family = AF_INET,
+			.sin_port = htons(sock_port_start),
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		struct sockaddr_in conn_addr = {
+			.sin_family = AF_INET,
+			.sin_port = htons(sock_port_start + 1),
+			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		};
+		int ruleset_fd, sock_fd, optval = 1;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		/* Allow bind and connect on sock_port_start only. */
+		port_attr.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP |
+					   LANDLOCK_ACCESS_NET_CONNECT_TCP;
+		port_attr.port = sock_port_start;
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
+		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (sock_fd < 0)
+			_exit(1);
+		setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &optval,
+			   sizeof(optval));
+
+		/* Bind to allowed port (succeeds, no trace event). */
+		if (bind(sock_fd, (struct sockaddr *)&bind_addr,
+			 sizeof(bind_addr))) {
+			close(sock_fd);
+			_exit(1);
+		}
+
+		/* Connect to denied port (fails, emits trace event). */
+		if (connect(sock_fd, (struct sockaddr *)&conn_addr,
+			    sizeof(conn_addr)) == 0) {
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
+	 * The denied operation is connect, so sport=0 and dport=<denied_port>,
+	 * regardless of the prior bind.
+	 */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"sport", field, sizeof(field)));
+	EXPECT_STREQ("0", field);
+
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
+					"dport", field, sizeof(field)));
+	snprintf(expected, sizeof(expected), "%llu",
+		 (unsigned long long)(sock_port_start + 1));
+	EXPECT_STREQ(expected, field);
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


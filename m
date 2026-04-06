Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281212F3C0A
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486269; cv=none; b=hUheuZJfdXKgT08pHudWUXM3DvdSHmg1prtW4ZNHcG1ieOPUVeVqunj8DgEYCVRYt6MNH1xGDjeI1sYeG+qAtvj9u3+6ugo0N0B7HNJaTj0mxjQDPO/7rxE45JvImYGzAdQT3Mw23KwTfcO4wNw4I19ok3eeg4F5F1nqbg9Nc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486269; c=relaxed/simple;
	bh=Qjfiu4xug+ziDtKNBIaA3LiQ/8d4jPkq8lOVBivAFrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZW3F7+ySp4JMNxy57DXEoNQolT7alyxZnIJdELbPVEDsnmqADI700yPppUBzZTDva3G8JBIjloTYIcCLPJ1AGkKJ/EnrQ7P/X24NGFAR7OtlQ79iOdEx8LCwDLTlyVxm/t4RcHTSTEJnQfuBa0vqzgVjfX9kVY3lwHTJyJF4XVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kvgKXvj7; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kvgKXvj7"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkc5ZDTzwVP;
	Mon,  6 Apr 2026 16:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486264;
	bh=XiZtDyMONqiSyL1jZa5X9VY/acj/RESGOk7UIZhwFao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvgKXvj7MIjVs5IEy/Olu60GirNPM6IKr0E3Nv0zwp9vv3sth0kSBmTyXB6iX5FV4
	 B4UcEa3DE9WqPjx3EzUXw6qIbBeGQmtR3AXLkL3mPUBTH4Nb0aUKx7WFRFKxASkngX
	 HdUnVUdXTcru/ulQZV1xx0dYBYwt83txLkVqlDCE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkc17s6zZ5V;
	Mon,  6 Apr 2026 16:37:44 +0200 (CEST)
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
Subject: [PATCH v2 15/17] selftests/landlock: Add network tracepoint tests
Date: Mon,  6 Apr 2026 16:37:13 +0200
Message-ID: <20260406143717.1815792-16-mic@digikod.net>
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

Add trace tests for the landlock_deny_access_net tracepoint: denied
bind, allowed bind (no event), denied connect, bind field verification,
connect-after-bind field verification, and an unsandboxed baseline.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/net_test.c | 547 +++++++++++++++++++-
 1 file changed, 546 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4c528154ea92..4fe41425995c 100644
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
 
@@ -2026,4 +2030,545 @@ TEST_F(audit, connect)
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
+		EXPECT_LE(variant->expect_denied, count)
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
+	EXPECT_LE(1, tracefs_count_matches(buf,
+					   REGEX_DENY_ACCESS_NET(TRACE_TASK)));
+
+	/*
+	 * Verify dport is the denied port and sport is 0.  The port
+	 * value must be in host endianness, matching the UAPI convention
+	 * (landlock_net_port_attr.port).  On little-endian,
+	 * htons(sock_port_start + 1) would produce a different decimal
+	 * value, so this comparison also catches byte-order bugs.
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
+	EXPECT_LE(1, tracefs_count_matches(buf,
+					   REGEX_DENY_ACCESS_NET(TRACE_TASK)));
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
+	EXPECT_LE(1, tracefs_count_matches(buf,
+					   REGEX_DENY_ACCESS_NET(TRACE_TASK)));
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
+/*
+ * IPv6 network trace tests are intentionally elided.  IPv6 hook dispatch uses
+ * the same current_check_access_socket() code path as IPv4, validated by the
+ * audit tests in this file.  The trace events use the same blockers/sport/dport
+ * fields regardless of address family.
+ */
+
 TEST_HARNESS_MAIN
-- 
2.53.0


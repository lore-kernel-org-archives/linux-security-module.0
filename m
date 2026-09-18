Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835048167B
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757466; cv=none; b=thLiJ4f3XQko0zuwvUmayrdkNo2X5GCdXyJVB1NLgDE6WiqiWJLHLW4VIY/z1Jnz18NDDXUkZxzt82iR9x1xHledtcU/R/9gZqBkeadXYFD7GBITxgkaVlFJesV59pPS0vRn0V88XrwMb0CcAnHqz7BhNtj1JaiPH0xEuByNygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757466; c=relaxed/simple;
	bh=2DIIxexDfonjjkML/+22yHFiBMB66tGi5leth3GhqIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFgP2PBUrWUv97dqGwCjgleeYfMqvZx5lpRsEEE4nXsoGPRRAPO8QBoQ8W4byyFq4zvX+as9x/G0dhyrQisKeVMQiml1zlGng7sZxEFva7L0e90vnrZBOnWCB+aqOAmVMwBk7J4elJI0h1k70ibC0ui6H5mI/LG1abnHgrRzHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iA7g2Uml; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iA7g2Uml"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXZ5yflzpYB;
	Fri, 18 Sep 2026 20:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757454;
	bh=oJ3lPbuGzWdNShVj3rUfvwtkjOP9+yUHaduneHika5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iA7g2Uml3CvB3ze1Fqnva8deIfyaRXotG6T23gRYbcvxhbStoz1Gt6fonPZeqN+c4
	 d7UyjTt4VvoA/2VfEnfHL/KWYvzWwqR5C53tUdTjSlIsGXT08FCOOZw8JuAnItNT3G
	 EkPDAdWEwgP0ZnMMUmGGnYlvdCGeVZg1OK7insD4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXZ0frqzlSR;
	Fri, 18 Sep 2026 20:50:54 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1 8/9] selftests/landlock: Test network denial context
Date: Fri, 18 Sep 2026 20:50:31 +0200
Message-ID: <20260918185036.608651-9-mic@digikod.net>
In-Reply-To: <20260918185036.608651-1-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Network denial events now report the port from their one authoritative
validated address through one signed field.  Verify this value directly
without inferring a source or destination role.

Exercise a nonzero IPv4 TCP bind, an explicit-zero IPv4 UDP bind, a
synthetic-zero IPv6 UDP autobind, and a family-only AF_UNSPEC UDP send.
Require exactly one event with the exact policy blocker for each shape.
The value -1 distinguishes a family-only address with no validated port
from the two valid port-zero cases.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/net_test.c | 259 +++++++++++---------
 1 file changed, 147 insertions(+), 112 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 28942438e154..16afbfdf06bb 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3481,13 +3481,14 @@ TEST_F(trace_net, deny_access_net_bind)
 }
 
 /*
- * Anchors the denial fields shared by every deny_access_net event so a field
- * test proves more than the checked endpoint: the denying domain, the same-exec
- * bit, the audit-logging verdict, and the blocked access all stay populated.
+ * Anchors the denial fields shared by every deny_access_net event so a port
+ * test also proves the denying domain, execution status, logging verdict, and
+ * exact blocked access.
  */
 static void
 expect_net_deny_common_fields(struct __test_metadata *const _metadata,
-			      const char *const buf)
+			      const char *const buf,
+			      const char *const expected_blockers)
 {
 	char field[64];
 
@@ -3511,18 +3512,21 @@ expect_net_deny_common_fields(struct __test_metadata *const _metadata,
 	ASSERT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
 					"blockers", field, sizeof(field)));
-	EXPECT_STRNE("", field);
+	EXPECT_STREQ(expected_blockers, field);
 }
 
-/* Connect and field-check tests use a separate fixture without variants. */
+enum trace_net_operation {
+	TRACE_NET_BIND,
+	TRACE_NET_SEND,
+};
 
 /* clang-format off */
-FIXTURE(trace_net_connect) {
+FIXTURE(trace_net_address) {
 	/* clang-format on */
 	int tracefs_ok;
 };
 
-FIXTURE_SETUP(trace_net_connect)
+FIXTURE_SETUP(trace_net_address)
 {
 	int ret;
 
@@ -3547,7 +3551,7 @@ FIXTURE_SETUP(trace_net_connect)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
-FIXTURE_TEARDOWN(trace_net_connect)
+FIXTURE_TEARDOWN(trace_net_address)
 {
 	if (!self->tracefs_ok)
 		return;
@@ -3559,146 +3563,177 @@ FIXTURE_TEARDOWN(trace_net_connect)
 }
 
 /* clang-format off */
-FIXTURE_VARIANT(trace_net_connect) {
+FIXTURE_VARIANT(trace_net_address) {
 	/* clang-format on */
-	/* handled_access_net, also the access allowed on the base port. */
-	__u64 handled;
-	/* Bind the allowed base port before the denied operation. */
-	bool bind_base_first;
-	/* Denied operation on the next port: connect (true) or bind (false). */
-	bool deny_connect;
+	int socket_family;
+	int socket_type;
+	enum trace_net_operation operation;
+	int address_family;
+	socklen_t addrlen;
+	__u64 handled_access;
+	const char *expected_blockers;
+	bool address_port_zero;
+	bool expected_address_port;
+	int expected_port;
 };
 
-/* Denied connect() to the next IPv4 port. */
 /* clang-format off */
-FIXTURE_VARIANT_ADD(trace_net_connect, connect_denied) {
+FIXTURE_VARIANT_ADD(trace_net_address, ipv4_tcp_bind) {
 	/* clang-format on */
-	.handled = LANDLOCK_ACCESS_NET_CONNECT_TCP,
-	.bind_base_first = false,
-	.deny_connect = true,
+	.socket_family = AF_INET,
+	.socket_type = SOCK_STREAM,
+	.operation = TRACE_NET_BIND,
+	.address_family = AF_INET,
+	.addrlen = sizeof(struct sockaddr_in),
+	.handled_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+	.expected_blockers = "bind_tcp",
+	.expected_address_port = true,
 };
 
-/* Denied bind() to the next IPv4 port. */
+/* Explicit bind(0) has a checked zero port. */
 /* clang-format off */
-FIXTURE_VARIANT_ADD(trace_net_connect, bind_fields) {
+FIXTURE_VARIANT_ADD(trace_net_address, ipv4_udp_bind_zero) {
 	/* clang-format on */
-	.handled = LANDLOCK_ACCESS_NET_BIND_TCP,
-	.bind_base_first = false,
-	.deny_connect = false,
+	.socket_family = AF_INET,
+	.socket_type = SOCK_DGRAM,
+	.operation = TRACE_NET_BIND,
+	.address_family = AF_INET,
+	.addrlen = sizeof(struct sockaddr_in),
+	.handled_access = LANDLOCK_ACCESS_NET_BIND_UDP,
+	.expected_blockers = "bind_udp",
+	.address_port_zero = true,
+	.expected_port = 0,
 };
 
-/* Denied connect() after an allowed bind() uses the checked destination. */
+/* A UDP send can deny its synthetic unspecified bind endpoint. */
 /* clang-format off */
-FIXTURE_VARIANT_ADD(trace_net_connect, connect_after_bind) {
+FIXTURE_VARIANT_ADD(trace_net_address, ipv6_udp_autobind) {
 	/* clang-format on */
-	.handled = LANDLOCK_ACCESS_NET_BIND_TCP |
-		   LANDLOCK_ACCESS_NET_CONNECT_TCP,
-	.bind_base_first = true,
-	.deny_connect = true,
+	.socket_family = AF_INET6,
+	.socket_type = SOCK_DGRAM,
+	.operation = TRACE_NET_SEND,
+	.address_family = AF_INET6,
+	.addrlen = sizeof(struct sockaddr_in6),
+	.handled_access = LANDLOCK_ACCESS_NET_BIND_UDP,
+	.expected_blockers = "bind_udp",
+	.expected_port = 0,
 };
 
-/*
- * A denied TCP bind(2) or connect(2) emits one deny_access_net event with the
- * checked IPv4 port in host endianness (the UAPI landlock_net_port_attr.port
- * convention).  A prior allowed bind does not change a connect denial's port.
- */
-TEST_F(trace_net_connect, deny_access_net)
+/* A family-only address has no checked port. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(trace_net_address, ipv6_unspec_udp_send_min) {
+	/* clang-format on */
+	.socket_family = AF_INET6,
+	.socket_type = SOCK_DGRAM,
+	.operation = TRACE_NET_SEND,
+	.address_family = AF_UNSPEC,
+	.addrlen = sizeof(sa_family_t),
+	.handled_access = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+	.expected_blockers = "connect_send_udp",
+	.expected_port = -1,
+};
+
+static void set_trace_net_address(struct sockaddr_storage *const storage,
+				  const int socket_family,
+				  const int address_family,
+				  const unsigned short port)
 {
-	pid_t child;
-	int status;
-	char *buf;
+	memset(storage, 0, sizeof(*storage));
+
+	if (socket_family == AF_INET) {
+		struct sockaddr_in *const addr4 = (struct sockaddr_in *)storage;
+
+		addr4->sin_family = address_family;
+		addr4->sin_port = htons(port);
+		addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	} else {
+		struct sockaddr_in6 *const addr6 =
+			(struct sockaddr_in6 *)storage;
+
+		addr6->sin6_family = address_family;
+		addr6->sin6_port = htons(port);
+		addr6->sin6_addr = in6addr_loopback;
+	}
+}
+
+/* Verifies the actionable signed port for representative checked shapes. */
+TEST_F(trace_net_address, deny_access_net)
+{
+	const char *const event_regex = REGEX_DENY_ACCESS_NET(TRACE_TASK);
+	const unsigned short address_port =
+		variant->address_port_zero ? 0 : sock_port_start + 1;
+	const int expected_port = variant->expected_address_port ?
+					  address_port :
+					  variant->expected_port;
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = variant->handled_access,
+	};
+	struct sockaddr_storage address;
 	char field[64], expected[16];
+	char *buf;
+	int count, ret, ruleset_fd, socket_fd, status;
+	pid_t child;
 
 	if (!self->tracefs_ok)
 		SKIP(return, "tracefs not available");
 
+	set_trace_net_address(&address, variant->socket_family,
+			      variant->address_family, address_port);
+	socket_fd = socket(variant->socket_family,
+			   variant->socket_type | SOCK_CLOEXEC, 0);
+	ASSERT_LE(0, socket_fd);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, tracefs_clear_buf());
+
 	child = fork();
 	ASSERT_LE(0, child);
-
 	if (child == 0) {
-		struct landlock_ruleset_attr ruleset_attr = {
-			.handled_access_net = variant->handled,
-		};
-		struct landlock_net_port_attr port_attr = {
-			.allowed_access = variant->handled,
-			.port = sock_port_start,
-		};
-		struct sockaddr_in addr = {
-			.sin_family = AF_INET,
-			.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
-		};
-		int ruleset_fd, sock_fd, optval = 1, ret;
-
-		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
-						     sizeof(ruleset_attr), 0);
-		if (ruleset_fd < 0)
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
 			_exit(1);
-		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-				      &port_attr, 0)) {
-			close(ruleset_fd);
-			_exit(1);
-		}
-		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-		if (landlock_restrict_self(ruleset_fd, 0)) {
-			close(ruleset_fd);
-			_exit(1);
-		}
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(2);
 		close(ruleset_fd);
 
-		sock_fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
-		if (sock_fd < 0)
-			_exit(1);
-
-		/* Bind the allowed base port first (succeeds, no event). */
-		if (variant->bind_base_first) {
-			setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &optval,
-				   sizeof(optval));
-			addr.sin_port = htons(sock_port_start);
-			if (bind(sock_fd, (struct sockaddr *)&addr,
-				 sizeof(addr))) {
-				close(sock_fd);
-				_exit(1);
-			}
-		}
-
-		/* Denied operation on the next port. */
-		addr.sin_port = htons(sock_port_start + 1);
-		if (variant->deny_connect)
-			ret = connect(sock_fd, (struct sockaddr *)&addr,
-				      sizeof(addr));
-		else
-			ret = bind(sock_fd, (struct sockaddr *)&addr,
-				   sizeof(addr));
-		if (ret == 0) {
-			close(sock_fd);
-			_exit(2);
-		}
-		if (errno != EACCES) {
-			close(sock_fd);
+		switch (variant->operation) {
+		case TRACE_NET_BIND:
+			ret = bind(socket_fd, (const struct sockaddr *)&address,
+				   variant->addrlen);
+			break;
+		case TRACE_NET_SEND:
+			ret = sendto(socket_fd, "A", 1, MSG_NOSIGNAL,
+				     (const struct sockaddr *)&address,
+				     variant->addrlen);
+			break;
+		default:
 			_exit(3);
 		}
-		close(sock_fd);
+		if (ret >= 0 || errno != EACCES)
+			_exit(4);
+		close(socket_fd);
+
 		_exit(0);
 	}
+	close(ruleset_fd);
+	close(socket_fd);
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_TRUE(WIFEXITED(status));
-	EXPECT_EQ(0, WEXITSTATUS(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
-
-	EXPECT_EQ(1, tracefs_count_matches(buf,
-					   REGEX_DENY_ACCESS_NET(TRACE_TASK)));
-
-	expect_net_deny_common_fields(_metadata, buf);
-
-	snprintf(expected, sizeof(expected), "%llu",
-		 (unsigned long long)(sock_port_start + 1));
-
-	ASSERT_EQ(0,
-		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
-					"port", field, sizeof(field)));
+	count = tracefs_count_matches(buf, event_regex);
+	if (count != 1)
+		TH_LOG("Expected 1 denial event, got %d\n%s", count, buf);
+	ASSERT_EQ(1, count);
+	expect_net_deny_common_fields(_metadata, buf,
+				      variant->expected_blockers);
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, event_regex, "port", field,
+					   sizeof(field)));
+	snprintf(expected, sizeof(expected), "%d", expected_port);
 	EXPECT_STREQ(expected, field);
 
 	free(buf);
-- 
2.55.0


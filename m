Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3E352FA5
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787947227; cv=none; b=DdTbU/kpXbb4oxPHNNHI96Dd2JYjF6efCqIdkTeA8B91rlwAUFlmSDEcFoL0o7wpbVAVnkbF16+VK4XFOawbbO1UfiNLsKxwJOwVmT/sfZxxzyJdJpE5NelMejVB1Cz+ATcl5ZUVFke+AizJGdQ2NP9iJVpHqXrqz1JK9uToTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787947227; c=relaxed/simple;
	bh=tMF5FLIpKc0Clk+cIEzT0utofv6Uen6J0DfSyLtPi+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDcrQ5Gf/FOPRAFmj7llaBjS5KGEtGhqSbXK8VJ3UDfBCeNqOZWR2zkSiEb3Flz3ehwfZNKVcWUqA/+l4SaCPiYrmQWrE9FrMWFItmd0IhQMGgCwCSNC7hSkKcnH/20xgQZumz64bKMlOQJrbpqB8X8kZ/0K9o0sxcJtQcahTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pj9OyNkt; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pj9OyNkt"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWnrw1RRmz4VX;
	Fri, 28 Aug 2026 21:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1787943920;
	bh=ZZh1bvewf3LlGjRs5z64cNaxqjhCmUyxeAg6MT4utNM=;
	h=From:To:Cc:Subject:Date:From;
	b=pj9OyNktdbv2itYqfqgMoMSEgw5Xn5mNXr95wVRbAGb6v8feIVzmnTJF/vGqF7LLF
	 +SvH4IrEHdQxR+yKLXlA+5VXMz0rWvy10ZY9doEtgoasC2vVxmwhzAAknR9Pvopq50
	 fEvxtxfFTrunHavDTX+Wp8dOlWhdVlgQW6Puqjh8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hWnrv4P7bzJRB;
	Fri, 28 Aug 2026 21:05:19 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Charles <dmcjisalive@gmail.com>
Subject: [PATCH v1] selftests/landlock: Test abstract socket trace name limits
Date: Fri, 28 Aug 2026 21:00:36 +0200
Message-ID: <20260828190038.71831-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The landlock_deny_scope_abstract_unix_socket event captures binary
socket names with __string_len(), whose dynamic field reserves an extra
byte for the NUL terminator.  The printer subtracts this byte before
escaping the content.

Exercise the minimum accepted address length, which has no name content,
and the maximum sockaddr_un length, which has 107 content bytes.  Check
the exact trace output at both boundaries.  The existing stream and
datagram variants share this event, so the boundary variants only need
the stream path.

The lower-bound test confirms that the subtraction recovers zero instead
of underflowing.

Cc: Günther Noack <gnoack@google.com>
Link: https://patch.msgid.link/CAL4aGcVcT0VWVFmGi_vLqxxZ9KdOHfGXYZtKjBdvoUyFjbu5=A@mail.gmail.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 .../landlock/scoped_abstract_unix_test.c      | 76 +++++++++++++------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 6dbe863ea571..e62f1a2154c6 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -1252,6 +1252,11 @@ FIXTURE_TEARDOWN(trace_unix)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
+static const char
+	trace_unix_max_name[sizeof(((struct sockaddr_un *)0)->sun_path)] = {
+		[0 ... sizeof(trace_unix_max_name) - 2] = 'x',
+	};
+
 /* clang-format off */
 FIXTURE_VARIANT(trace_unix) {
 	/* clang-format on */
@@ -1259,6 +1264,8 @@ FIXTURE_VARIANT(trace_unix) {
 	bool sandbox;
 	bool sandbox_target; /* Peer owned by a domain: peer_domain != 0. */
 	int expect_denied;
+	const char *name; /* NULL generates a PID-based binary name. */
+	size_t name_len;
 };
 
 /* clang-format off */
@@ -1281,6 +1288,26 @@ FIXTURE_VARIANT_ADD(trace_unix, stream_allowed) {
 	.sandbox_target = false, .expect_denied = 0,
 };
 
+/* Stream: lower abstract-name length boundary. */
+FIXTURE_VARIANT_ADD(trace_unix, stream_denied_empty_name) {
+	.sock_type = SOCK_STREAM,
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+	.name = "",
+	.name_len = 0,
+};
+
+/* Stream: upper abstract-name length boundary. */
+FIXTURE_VARIANT_ADD(trace_unix, stream_denied_max_name) {
+	.sock_type = SOCK_STREAM,
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
+	.name = trace_unix_max_name,
+	.name_len = sizeof(trace_unix_max_name) - 1,
+};
+
 /* Datagram: sandboxed client sendto() an unsandboxed peer (peer_domain=0). */
 FIXTURE_VARIANT_ADD(trace_unix, dgram_denied) {
 	.sock_type = SOCK_DGRAM, .sandbox = true,
@@ -1304,12 +1331,11 @@ FIXTURE_VARIANT_ADD(trace_unix, dgram_allowed) {
 /*
  * A sandboxed thread reaching an abstract unix socket peer through connect(2)
  * (stream) or sendto(2) (datagram) is denied and emits
- * landlock_deny_scope_abstract_unix_socket.  The abstract name is crafted with
- * a space and an embedded NUL followed by an "END" marker to check the
- * tracepoint escaping and its length handling (a raw space would break the
- * sun_path field regex; strlen() would truncate at the NUL and drop "END").
- * peer_pid is only meaningful for a stream peer (a datagram peer has no
- * SO_PEERCRED), so it is asserted only there.
+ * landlock_deny_scope_abstract_unix_socket.  The default abstract name has a
+ * space and an embedded NUL followed by an "END" marker to check escaping and
+ * binary length handling.  Additional stream variants cover the minimum and
+ * maximum abstract-name lengths.  peer_pid is only meaningful for a stream peer
+ * (a datagram peer has no SO_PEERCRED), so it is asserted only there.
  */
 TEST_F(trace_unix, deny_scope_unix)
 {
@@ -1317,7 +1343,7 @@ TEST_F(trace_unix, deny_scope_unix)
 		.sun_family = AF_UNIX,
 	};
 	char *buf, field[128], expected_pid[16];
-	int server_fd, count, status, name_len, addr_len;
+	int server_fd, count, status, name_len, addr_len = 0;
 	pid_t child;
 
 	if (!self->tracefs_ok)
@@ -1336,12 +1362,19 @@ TEST_F(trace_unix, deny_scope_unix)
 	ASSERT_LE(0, server_fd);
 
 	addr.sun_path[0] = '\0';
-	name_len = snprintf(addr.sun_path + 1, sizeof(addr.sun_path) - 1,
-			    "landlock_trace_test_%d ", getpid());
-	addr.sun_path[1 + name_len] = '\0';
-	memcpy(addr.sun_path + 1 + name_len + 1, "END", 3);
-	addr_len =
-		offsetof(struct sockaddr_un, sun_path) + 1 + name_len + 1 + 3;
+	if (variant->name) {
+		ASSERT_LE(variant->name_len, sizeof(addr.sun_path) - 1);
+		memcpy(addr.sun_path + 1, variant->name, variant->name_len);
+		name_len = variant->name_len;
+	} else {
+		name_len = snprintf(addr.sun_path + 1,
+				    sizeof(addr.sun_path) - 1,
+				    "landlock_trace_test_%d ", getpid());
+		addr.sun_path[1 + name_len] = '\0';
+		memcpy(addr.sun_path + 1 + name_len + 1, "END", 3);
+		name_len += 1 + 3;
+	}
+	addr_len = offsetof(struct sockaddr_un, sun_path) + 1 + name_len;
 
 	ASSERT_EQ(0, bind(server_fd, (struct sockaddr *)&addr, addr_len));
 	if (variant->sock_type == SOCK_STREAM)
@@ -1430,19 +1463,18 @@ TEST_F(trace_unix, deny_scope_unix)
 		       count, buf);
 	}
 
-	/*
-	 * sun_path is escaped: a raw space would break this field's [^ ]*$
-	 * regex, so a successful extract proves the space was escaped, and its
-	 * full length is honored: the "END" marker after the embedded NUL must
-	 * survive (strlen() would truncate it at the NUL).
-	 */
 	ASSERT_EQ(0, tracefs_extract_field(
 			     buf,
 			     REGEX_DENY_SCOPE_ABSTRACT_UNIX_SOCKET(TRACE_TASK),
 			     "sun_path", field, sizeof(field)));
-	EXPECT_NE(NULL, strstr(field, "END"))
-	{
-		TH_LOG("sun_path truncated or unescaped: %s", field);
+	if (variant->name) {
+		EXPECT_STREQ(variant->name, field);
+	} else {
+		/* An embedded NUL must not truncate the following marker. */
+		EXPECT_NE(NULL, strstr(field, "END"))
+		{
+			TH_LOG("sun_path truncated or unescaped: %s", field);
+		}
 	}
 
 	/* peer_pid is the parent's PID for a stream peer (0 for datagram). */
-- 
2.55.0


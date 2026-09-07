Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B97441619
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777316; cv=none; b=Antke10vCZImY3Hmavs4I/A/NPdTouy6D9Yrf8v0cVeR0Qa1LO3DNeFqlH92fOH0mzE/0GOLRoz1myDt4Ie+0oPvJl1qNnPUO3ewWtKRX0wn36E7rvqFDgVuPqoQ9T7Y6yctRpH9s7kA7Ea9OphN1k6pMtGDFVESTG9xSTYgVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777316; c=relaxed/simple;
	bh=PeBHAHOvYTDlRHr3giQzOislzmXN3Hzgeve+KG4OTrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LVMunQja2pSwIAcWsq976jf9rttLwSttmgqkZoTR+3lF8DHGulsvOgleJm+x7tiXKOeGXA7HLizfBG7b34Iq9WAxG0ode5T7vNpXn9SCyheqijSYLAuEI4KsVF8SBjchMpFrrdkSsUfy4KvV9Y/vX0N942U+6rOGYHDPvENiGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lV7HWDbR; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lV7HWDbR"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdk3f2KLhz9QT;
	Mon,  7 Sep 2026 12:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788777310;
	bh=tqCCD1UMeaZw94WGqWY3JWLDYXvt/JW6jDE93zFKcg8=;
	h=From:To:Cc:Subject:Date:From;
	b=lV7HWDbRNlpvFNx+fdpzXv9RcM7vFkW0sM88Mo5jxkYOXeWQ9Kl3rRBr7PqPVImUe
	 8BojSV8B5MaV24PADTEMBMYkHobZH745MYXFfEdeHALpMtT/O4CymLUkAfi0lpQG0r
	 bCI3i0ih8f6/ZXoeaM7I/+UYZLuYj+Kz2Mc8wO38=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdk3d49jxztvj;
	Mon,  7 Sep 2026 12:35:09 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Charles <dmcjisalive@gmail.com>
Subject: [PATCH v2] selftests/landlock: Test abstract socket trace name limits
Date: Mon,  7 Sep 2026 12:35:01 +0200
Message-ID: <20260907103503.109461-1-mic@digikod.net>
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

Because these boundary names are fixed, run the fixture in a private
network namespace.  Abstract UNIX socket names are scoped by network
namespace, preventing concurrent bind() calls from colliding.

The lower-bound test confirms that the subtraction recovers zero instead
of underflowing.

Cc: Günther Noack <gnoack@google.com>
Link: https://patch.msgid.link/CAL4aGcVcT0VWVFmGi_vLqxxZ9KdOHfGXYZtKjBdvoUyFjbu5=A@mail.gmail.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://patch.msgid.link/20260828190038.71831-1-mic@digikod.net
- Isolate fixed abstract socket names in a private network namespace to
  prevent bind collisions (suggested by Sashiko).
---
 .../landlock/scoped_abstract_unix_test.c      | 76 +++++++++++++------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 6dbe863ea571..5dc0debacb2a 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -1222,7 +1222,7 @@ FIXTURE_SETUP(trace_unix)
 	int ret;
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, unshare(CLONE_NEWNS | CLONE_NEWNET));
 	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
 
 	ret = tracefs_fixture_setup();
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


Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F43751121A
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797244; cv=none; b=cOm4a90t1o8K9Y6/Oi0IrsgXm8DU/NilBQNz4VF+vcV0GgCToRYb1ZtHQwmCmKISkow8nZcq22Hl0TRu3Ov8kAux4z/9WTS0bVLoo4Q/qXGWeXDCJQajUOhH9FoOhIoz3hu01UC2l3wfH91dljU9AFiG0jggKf5V6aMRmXTXIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797244; c=relaxed/simple;
	bh=5E1LljRwIzWZR9i+QAKf1+bZiwyJRjLjxQzuOst++MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lL0ac9c0XLlDT+1edPnl/t6Hb6yBB5EvCE+kq3UeziozGkAJvhzVV8k0lXne41bPovUC/ZYHYxKbyVv6mEKMgT3+5CQ8svILwCbaOFBVfy7Lqh/nT8YCTjv4buU78ZRpTVC7K3b0Aj05ECYLxY5wy0GZKSsMA2PUB/H5JtAZLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RlcdUVjY; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RlcdUVjY"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdsQq5HjGzl2Z;
	Mon,  7 Sep 2026 18:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788797235;
	bh=iR6Q6ys10vIU2JHc4r8BYgB0M00FN/D1JDgncWnq0Zw=;
	h=From:To:Cc:Subject:Date:From;
	b=RlcdUVjYUXQX+ZFT+xytkFxwmQpAyWeK+IE9Kot96IAc2IrptwVp3OWNLosJpaAum
	 4nWJ74g5I6HHzmeTEDqZTz43cLnCl0SvB0BD0mBC6AcoGxa1rtG25JG5BCTBkYRSdX
	 GW31o4bH2IPj8yUqKcj7GBfWnJavFIgXRFSm8/rQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdsQq1hd5zcLC;
	Mon,  7 Sep 2026 18:07:15 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/2] selftests/landlock: Fix trace variant formatting
Date: Mon,  7 Sep 2026 18:07:06 +0200
Message-ID: <20260907160710.126525-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Group-wide clang-format exclusions also cover comments and unrelated
initializers, hiding which construct needs protection and leaving some
variant fields bin-packed.

Use per-variant guards and format designated fields one per line.  End
each guard after the macro header when clang-format preserves the
initializer.  Keep the initializer guarded only where re-enabling
clang-format would bin-pack its fields.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/net_test.c   | 13 ++--
 .../landlock/scoped_abstract_unix_test.c      | 56 ++++++++++++-----
 tools/testing/selftests/landlock/trace_test.c | 62 ++++++++++++++-----
 3 files changed, 95 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index a18761e0fd82..0d13556c50f2 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3569,31 +3569,34 @@ FIXTURE_VARIANT(trace_net_connect) {
 	bool deny_connect;
 };
 
-/* clang-format off */
-
 /* Denied connect(): sport=0, dport=<denied port>. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_net_connect, connect_denied) {
+	/* clang-format on */
 	.handled = LANDLOCK_ACCESS_NET_CONNECT_TCP,
 	.bind_base_first = false,
 	.deny_connect = true,
 };
 
 /* Denied bind(): sport=<denied port>, dport=0. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_net_connect, bind_fields) {
+	/* clang-format on */
 	.handled = LANDLOCK_ACCESS_NET_BIND_TCP,
 	.bind_base_first = false,
 	.deny_connect = false,
 };
 
 /* Denied connect() after an allowed bind(): the connect fields (sport=0). */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_net_connect, connect_after_bind) {
-	.handled = LANDLOCK_ACCESS_NET_BIND_TCP | LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_NET_BIND_TCP |
+		   LANDLOCK_ACCESS_NET_CONNECT_TCP,
 	.bind_base_first = true,
 	.deny_connect = true,
 };
 
-/* clang-format on */
-
 /*
  * A denied TCP bind(2) or connect(2) emits one deny_access_net event.  The port
  * is reported in the field matching the denied operation, in host endianness
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index eed684d4c364..54bc4081cd56 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -1268,27 +1268,38 @@ FIXTURE_VARIANT(trace_unix) {
 	size_t name_len;
 };
 
-/* clang-format off */
-
 /* Stream: sandboxed client connect() to an unsandboxed peer (peer_domain=0). */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, stream_denied) {
-	.sock_type = SOCK_STREAM, .sandbox = true,
-	.sandbox_target = false, .expect_denied = 1,
+	/* clang-format on */
+	.sock_type = SOCK_STREAM,
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
 };
 
 /* Stream: peer socket owned by a domain, so peer_domain != 0. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, stream_denied_scoped_peer) {
-	.sock_type = SOCK_STREAM, .sandbox = true,
-	.sandbox_target = true, .expect_denied = 1,
+	/* clang-format on */
+	.sock_type = SOCK_STREAM,
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
 };
 
 /* Stream: unsandboxed client, connect() succeeds, no event. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, stream_allowed) {
-	.sock_type = SOCK_STREAM, .sandbox = false,
-	.sandbox_target = false, .expect_denied = 0,
+	/* clang-format on */
+	.sock_type = SOCK_STREAM,
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
 };
 
 /* Stream: lower abstract-name length boundary. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, stream_denied_empty_name) {
 	.sock_type = SOCK_STREAM,
 	.sandbox = true,
@@ -1297,9 +1308,12 @@ FIXTURE_VARIANT_ADD(trace_unix, stream_denied_empty_name) {
 	.name = "",
 	.name_len = 0,
 };
+/* clang-format on */
 
 /* Stream: upper abstract-name length boundary. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, stream_denied_max_name) {
+	/* clang-format on */
 	.sock_type = SOCK_STREAM,
 	.sandbox = true,
 	.sandbox_target = false,
@@ -1309,25 +1323,35 @@ FIXTURE_VARIANT_ADD(trace_unix, stream_denied_max_name) {
 };
 
 /* Datagram: sandboxed client sendto() an unsandboxed peer (peer_domain=0). */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, dgram_denied) {
-	.sock_type = SOCK_DGRAM, .sandbox = true,
-	.sandbox_target = false, .expect_denied = 1,
+	/* clang-format on */
+	.sock_type = SOCK_DGRAM,
+	.sandbox = true,
+	.sandbox_target = false,
+	.expect_denied = 1,
 };
 
 /* Datagram: peer socket owned by a domain, so peer_domain != 0. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, dgram_denied_scoped_peer) {
-	.sock_type = SOCK_DGRAM, .sandbox = true,
-	.sandbox_target = true, .expect_denied = 1,
+	/* clang-format on */
+	.sock_type = SOCK_DGRAM,
+	.sandbox = true,
+	.sandbox_target = true,
+	.expect_denied = 1,
 };
 
 /* Datagram: unsandboxed client, sendto() succeeds, no event. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_unix, dgram_allowed) {
-	.sock_type = SOCK_DGRAM, .sandbox = false,
-	.sandbox_target = false, .expect_denied = 0,
+	/* clang-format on */
+	.sock_type = SOCK_DGRAM,
+	.sandbox = false,
+	.sandbox_target = false,
+	.expect_denied = 0,
 };
 
-/* clang-format on */
-
 /*
  * A sandboxed thread reaching an abstract unix socket peer through connect(2)
  * (stream) or sendto(2) (datagram) is denied and emits
diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index afdaf8511b3a..a28a2ac55687 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -1243,45 +1243,77 @@ FIXTURE_VARIANT(trace_enforce) {
 	int no_new_privs;
 };
 
-/* clang-format off */
-
 /* Single thread, no flags: prctl-backed no_new_privs. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_enforce, single) {
-	.nthreads = 0, .flags = 0,
-	.total = 1, .complete = 1, .process_wide = 1, .no_new_privs = 1,
+	.nthreads = 0,
+	.flags = 0,
+	.total = 1,
+	.complete = 1,
+	.process_wide = 1,
+	.no_new_privs = 1,
 };
+/* clang-format on */
 
 /* Single thread: the NO_NEW_PRIVS flag sets no_new_privs (no prctl). */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_enforce, no_new_privs) {
-	.nthreads = 0, .flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
-	.total = 1, .complete = 1, .process_wide = 1, .no_new_privs = 1,
+	.nthreads = 0,
+	.flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
+	.total = 1,
+	.complete = 1,
+	.process_wide = 1,
+	.no_new_privs = 1,
 };
+/* clang-format on */
 
 /* TSYNC on a lone thread still concludes, process-wide. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_enforce, tsync_single) {
-	.nthreads = 0, .flags = LANDLOCK_RESTRICT_SELF_TSYNC,
-	.total = 1, .complete = 1, .process_wide = 1, .no_new_privs = 1,
+	.nthreads = 0,
+	.flags = LANDLOCK_RESTRICT_SELF_TSYNC,
+	.total = 1,
+	.complete = 1,
+	.process_wide = 1,
+	.no_new_privs = 1,
 };
+/* clang-format on */
 
 /* TSYNC sweeps N siblings; the caller's prctl-backed nnp propagates to all. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_enforce, tsync_multithread) {
-	.nthreads = 3, .flags = LANDLOCK_RESTRICT_SELF_TSYNC,
-	.total = 4, .complete = 1, .process_wide = 4, .no_new_privs = 4,
+	.nthreads = 3,
+	.flags = LANDLOCK_RESTRICT_SELF_TSYNC,
+	.total = 4,
+	.complete = 1,
+	.process_wide = 4,
+	.no_new_privs = 4,
 };
+/* clang-format on */
 
 /* TSYNC + NO_NEW_PRIVS flag sets nnp on the caller and every swept sibling. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_enforce, tsync_no_new_privs) {
+	/* clang-format on */
 	.nthreads = 3,
-	.flags = LANDLOCK_RESTRICT_SELF_TSYNC | LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
-	.total = 4, .complete = 1, .process_wide = 4, .no_new_privs = 4,
+	.flags = LANDLOCK_RESTRICT_SELF_TSYNC |
+		 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS,
+	.total = 4,
+	.complete = 1,
+	.process_wide = 4,
+	.no_new_privs = 4,
 };
 
 /* Non-TSYNC on a multi-threaded process enforces only the caller. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_enforce, multithread_non_tsync) {
-	.nthreads = 3, .flags = 0,
-	.total = 1, .complete = 1, .process_wide = 0, .no_new_privs = 1,
+	.nthreads = 3,
+	.flags = 0,
+	.total = 1,
+	.complete = 1,
+	.process_wide = 0,
+	.no_new_privs = 1,
 };
-
 /* clang-format on */
 
 /*
-- 
2.55.0


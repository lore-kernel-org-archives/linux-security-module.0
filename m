Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06351DDE3
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757473; cv=none; b=HKnH2v+KCYXELEChBWrwhilFSc0mFs+jsHutc1isvACSN+VW8U82cPIdruYdKMdePRVdKK9tPK7yqNPg522yW12U6u3Pmmd+9m9rHtCEP++BrtLdO0gOYebJ8dUe4RSKLkNWa6EJnXbOWPHJoOXnRJTIb9DGmGpZjFERvNsIIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757473; c=relaxed/simple;
	bh=XmDaDJlShePYPMqCmhyqNBKwhCJfntXYv+pQ06Me/Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5UVXlT6KXxLh0ZPhZIWdP8B9uK/+w79nLXDEWODmRYtgnfbuWXm7f66nb+k/hGFv2MhRn6TuS2wD4ls3ZoKr0lfy6qulr/jrF4PbOlZVt9GH7f+n2BdzdnKzeonoGgZL9ETSkecRazeDBderONW3ACXOD0pOACiF7Tnt3RG9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EJzzCO5S; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EJzzCO5S"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXT3t2Szlwd;
	Fri, 18 Sep 2026 20:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757449;
	bh=L6gjfcLPux2h5AmwazFNXuE1tXgNc/lxln1WmyhL4KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJzzCO5SvWRRGVmfyBsE4q3q22c1lRATgYaFAxDAk0v1cCmmcPHOxcwyLzI9CsYhu
	 qkfrT7bSF6GkhBVoqo1SJ9wxQn1T2bYmoLguiwwiI6pUOG+vFu9oE/vaD2kgwEaDoG
	 i9Wp66KdggYIcPgrbpzD1pRnz2pFI3uWFssb7EMc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXS62lczJqN;
	Fri, 18 Sep 2026 20:50:48 +0200 (CEST)
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
Subject: [PATCH v1 4/9] landlock: Fix network denial trace context
Date: Fri, 18 Sep 2026 20:50:27 +0200
Message-ID: <20260918185036.608651-5-mic@digikod.net>
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

Network denial events report source and destination ports reconstructed
from audit data. Their zero values are ambiguous, and neither identifies
the complete endpoint that Landlock checked.

Carry the checked sockaddr and its signed length in a private trace-only
context. For an enabled event, validate the length and copy only the
initialized prefix into zeroed local storage. This prevents a typed BPF
program from reading uninitialized bytes while exposing the socket
family, socket, address, and length.

Replace the source and destination trace-record fields with one signed
port derived from the checked address. A value of -1 means that no port
was checked, zero is a valid port, and positive values use host
endianness. Bind blockers select the bind address; connect and send
blockers select the destination.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 01ce260f5ccf ("landlock: Add landlock_deny_access_fs and landlock_deny_access_net")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h             | 73 +++++++++++++--------
 security/landlock/log.h                     | 32 +++++++--
 security/landlock/net.c                     | 37 ++++++++---
 security/landlock/trace.c                   | 20 +++++-
 tools/testing/selftests/landlock/net_test.c | 49 +++++---------
 tools/testing/selftests/landlock/trace.h    |  3 +-
 6 files changed, 135 insertions(+), 79 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index b7e6a6638822..a982a7cfa881 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -10,7 +10,10 @@
 #if !defined(_TRACE_LANDLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_LANDLOCK_H
 
+#include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/landlock.h>
+#include <linux/socket.h>
 #include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/tracepoint.h>
@@ -790,6 +793,11 @@ TRACE_EVENT(landlock_deny_access_fs,
 					    __get_dynamic_array_len(pathname) - 1))
 );
 
+static_assert(offsetof(struct sockaddr_in, sin_port) ==
+	      offsetof(struct sockaddr_in6, sin6_port));
+static_assert(sizeof_field(struct sockaddr_in, sin_port) ==
+	      sizeof_field(struct sockaddr_in6, sin6_port));
+
 /**
  * landlock_deny_access_net - Network access denied
  *
@@ -798,30 +806,31 @@ TRACE_EVENT(landlock_deny_access_fs,
  * @same_exec: Whether the current task entered the denying domain itself.
  * @logged: The domain's audit-logging decision for this denial.
  * @blockers: Request type and final missing access subset (never NULL).
- * @sk: Socket object (never NULL), read without a socket lock, so its
- *      fields are a best-effort snapshot.  The denied endpoint is not
- *      available: the hook runs before :manpage:`bind(2)` /
- *      :manpage:`connect(2)` sets the socket addresses.
- * @sport: Source port in host endianness, set for bind denials (zero for
- *         an autobind/ephemeral port); zero for connect and send denials.
- * @dport: Destination port in host endianness, set for connect and send
- *         denials; zero for bind denials, and also zero for a UDP send to
- *         an AF_UNSPEC address on an IPv6 socket (indistinguishable from a
- *         real destination port 0).  The bind-vs-connect direction is
- *         given by @blockers, not by which port is set.
- *
- * Emitted when a Landlock domain denies a network operation.
+ * @sk: Socket object (never NULL), read without a socket lock, so its fields
+ *      are a best-effort snapshot.
+ * @socket_family: Socket-family snapshot used by the verdict.
+ * @address: Authoritative address checked by the verdict (never NULL).
+ *           The producer copies @addrlen bytes from the checked address and
+ *           zeroes the remaining storage before emission.  The
+ *           &sockaddr_in.sin_port or &sockaddr_in6.sin6_port member, when
+ *           present, remains in network endianness.
+ * @addrlen: Validated signed length of @address.
  *
- * The port fields are converted from the socket's network byte order to
- * host endianness before emitting.
+ * Emitted when a Landlock domain denies a network operation.  The blocker
+ * identifies whether the address is a bind or connect/send policy object.
+ * The flattened port field is converted from the checked address to host
+ * endianness, or is -1 when no port was checked.  Zero is a valid checked
+ * port.
  */
 TRACE_EVENT(landlock_deny_access_net,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
 		 bool logged, const struct landlock_blockers *blockers,
-		 const struct sock *sk, u64 sport, u64 dport),
+		 const struct sock *sk, u16 socket_family,
+		 const struct sockaddr_storage *address, int addrlen),
 
-	TP_ARGS(hierarchy, same_exec, logged, blockers, sk, sport, dport),
+	TP_ARGS(hierarchy, same_exec, logged, blockers, sk, socket_family,
+		address, addrlen),
 
 	TP_STRUCT__entry(
 		__field(	u64,		domain_id	)
@@ -829,26 +838,36 @@ TRACE_EVENT(landlock_deny_access_net,
 		__field(	bool,		logged		)
 		__field(	enum landlock_request_type, blockers_type	)
 		__field(	access_mask_t,	blockers_access	)
-		__field(	u64,		sport		)
-		__field(	u64,		dport		)
+		__field(	s64,		port		)
 	),
 
 	TP_fast_assign(
+		const struct sockaddr *const addr =
+			(const struct sockaddr *)address;
+		const bool has_port =
+			addrlen >= (int)offsetofend(struct sockaddr_in, sin_port) &&
+			(addr->sa_family == AF_INET ||
+			 addr->sa_family == AF_INET6 ||
+			 (addr->sa_family == AF_UNSPEC &&
+			  socket_family == AF_INET));
+
 		__entry->domain_id	= hierarchy->id;
 		__entry->same_exec	= same_exec;
 		__entry->logged		= logged;
 		__entry->blockers_type	= blockers->type;
 		__entry->blockers_access = blockers->access;
-		__entry->sport		= sport;
-		__entry->dport		= dport;
+		__entry->port		=
+			has_port ?
+				ntohs(((const struct sockaddr_in *)addr)->sin_port) :
+				-1;
 	),
 
-	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s sport=%llu dport=%llu",
-		__entry->domain_id, __entry->same_exec, __entry->logged,
-		__entry->blockers_type == LANDLOCK_REQUEST_NET_ACCESS ?
-			__print_flags(__entry->blockers_access, "|", _LANDLOCK_ACCESS_NET_NAMES) :
-			"unknown",
-		__entry->sport, __entry->dport)
+	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s port=%lld",
+		  __entry->domain_id, __entry->same_exec, __entry->logged,
+		  __entry->blockers_type == LANDLOCK_REQUEST_NET_ACCESS ?
+			  __print_flags(__entry->blockers_access, "|", _LANDLOCK_ACCESS_NET_NAMES) :
+			  "unknown",
+		  __entry->port)
 );
 
 /**
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 04f3e241e765..4587c2b1566d 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -15,6 +15,7 @@
 
 struct landlock_cred_security;
 struct landlock_hierarchy;
+struct sockaddr;
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
@@ -30,6 +31,16 @@ struct landlock_blockers {
 	enum landlock_request_type type;
 };
 
+#ifdef CONFIG_TRACEPOINTS
+
+struct landlock_net_trace {
+	const struct sockaddr *address;
+	int addrlen;
+	u16 socket_family;
+};
+
+#endif /* CONFIG_TRACEPOINTS */
+
 /*
  * We should be careful to only use a variable of this type for
  * landlock_log_denial().  This way, the compiler can remove it entirely if
@@ -57,13 +68,20 @@ struct landlock_request {
 	deny_masks_t deny_masks;
 	optional_access_t quiet_optional_accesses;
 
-	/*
-	 * Other-party domain ID for a relational (scope/ptrace) denial, or 0 if
-	 * that party is unsandboxed.  An ID, not a pointer: the other task can
-	 * replace its credential and free the domain it referenced.  Trace path
-	 * only; audit ignores it.
-	 */
-	u64 other_domain_id;
+	union {
+		/*
+		 * Other-party domain ID for a relational (scope/ptrace) denial,
+		 * or 0 if that party is unsandboxed.  Store an ID, not a
+		 * pointer: the other task can replace its credential and free
+		 * the domain it referenced.  Trace-only; audit ignores it.
+		 */
+		u64 other_domain_id;
+
+#ifdef CONFIG_TRACEPOINTS
+		/* Synchronous context for a network denial. */
+		const struct landlock_net_trace *trace_net;
+#endif /* CONFIG_TRACEPOINTS */
+	};
 };
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 5552c60388f8..6fe0dbde3b78 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -93,7 +93,7 @@ static int current_check_access_socket(struct socket *const sock,
 		return 0;
 
 	/* Checks for minimal header length to safely read sa_family. */
-	if (addrlen < offsetofend(typeof(*address), sa_family))
+	if (addrlen < (int)offsetofend(typeof(*address), sa_family))
 		return -EINVAL;
 
 	/*
@@ -145,6 +145,17 @@ static int current_check_access_socket(struct socket *const sock,
 						.audit.u.net = &audit_net,
 						.access = access_request,
 						.layer_masks = &layer_masks,
+#ifdef CONFIG_TRACEPOINTS
+						.trace_net =
+							&(struct landlock_net_trace){
+								.address =
+									address,
+								.addrlen =
+									addrlen,
+								.socket_family =
+									sock_family,
+							},
+#endif /* CONFIG_TRACEPOINTS */
 					});
 				return -EACCES;
 			}
@@ -276,14 +287,22 @@ static int current_check_access_socket(struct socket *const sock,
 
 	audit_net.family = address->sa_family;
 	audit_net.sk = sock->sk;
-	landlock_log_denial(subject,
-			    &(struct landlock_request){
-				    .type = LANDLOCK_REQUEST_NET_ACCESS,
-				    .audit.type = LSM_AUDIT_DATA_NET,
-				    .audit.u.net = &audit_net,
-				    .access = access_request,
-				    .layer_masks = &layer_masks,
-			    });
+	landlock_log_denial(
+		subject, &(struct landlock_request){
+				 .type = LANDLOCK_REQUEST_NET_ACCESS,
+				 .audit.type = LSM_AUDIT_DATA_NET,
+				 .audit.u.net = &audit_net,
+				 .access = access_request,
+				 .layer_masks = &layer_masks,
+#ifdef CONFIG_TRACEPOINTS
+				 .trace_net =
+					 &(struct landlock_net_trace){
+						 .address = address,
+						 .addrlen = addrlen,
+						 .socket_family = sock_family,
+					 },
+#endif /* CONFIG_TRACEPOINTS */
+			 });
 	return -EACCES;
 }
 
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 58276cc32d3f..9be86638f905 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/lsm_audit.h>
+#include <linux/socket.h>
 #include <net/sock.h>
 
 #include "access.h"
@@ -157,16 +158,31 @@ void landlock_trace_denial(
 		break;
 	case LANDLOCK_REQUEST_NET_ACCESS:
 		if (trace_landlock_deny_access_net_enabled()) {
+			const struct landlock_net_trace *const trace_net =
+				request->trace_net;
 			const struct landlock_blockers blockers = {
 				.access = missing,
 				.type = request->type,
 			};
+			struct sockaddr_storage address = {};
 
+			if (WARN_ON_ONCE(!trace_net || !trace_net->address))
+				return;
+
+			if (WARN_ON_ONCE(
+				    trace_net->addrlen <
+					    (int)offsetofend(struct sockaddr,
+							     sa_family) ||
+				    trace_net->addrlen > (int)sizeof(address)))
+				return;
+
+			memcpy(&address, trace_net->address,
+			       trace_net->addrlen);
 			trace_landlock_deny_access_net(
 				youngest_denied, same_exec, logged, &blockers,
 				request->audit.u.net->sk,
-				ntohs(request->audit.u.net->sport),
-				ntohs(request->audit.u.net->dport));
+				trace_net->socket_family, &address,
+				trace_net->addrlen);
 		}
 		break;
 	case LANDLOCK_REQUEST_PTRACE:
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4fb705e1596d..28942438e154 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3482,8 +3482,8 @@ TEST_F(trace_net, deny_access_net_bind)
 
 /*
  * Anchors the denial fields shared by every deny_access_net event so a field
- * test proves more than sport/dport: the denying domain, the same-exec bit, the
- * audit-logging verdict, and the blocked access all stay populated.
+ * test proves more than the checked endpoint: the denying domain, the same-exec
+ * bit, the audit-logging verdict, and the blocked access all stay populated.
  */
 static void
 expect_net_deny_common_fields(struct __test_metadata *const _metadata,
@@ -3569,38 +3569,38 @@ FIXTURE_VARIANT(trace_net_connect) {
 	bool deny_connect;
 };
 
+/* Denied connect() to the next IPv4 port. */
 /* clang-format off */
-
-/* Denied connect(): sport=0, dport=<denied port>. */
 FIXTURE_VARIANT_ADD(trace_net_connect, connect_denied) {
+	/* clang-format on */
 	.handled = LANDLOCK_ACCESS_NET_CONNECT_TCP,
 	.bind_base_first = false,
 	.deny_connect = true,
 };
 
-/* Denied bind(): sport=<denied port>, dport=0. */
+/* Denied bind() to the next IPv4 port. */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(trace_net_connect, bind_fields) {
+	/* clang-format on */
 	.handled = LANDLOCK_ACCESS_NET_BIND_TCP,
 	.bind_base_first = false,
 	.deny_connect = false,
 };
 
-/* Denied connect() after an allowed bind(): the connect fields (sport=0). */
+/* Denied connect() after an allowed bind() uses the checked destination. */
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
- * A denied TCP bind(2) or connect(2) emits one deny_access_net event.  The port
- * is reported in the field matching the denied operation, in host endianness
- * (the UAPI landlock_net_port_attr.port convention): a connect denial reports
- * sport=0 dport=<port>, a bind denial reports sport=<port> dport=0, so a
- * byte-order or field-swap bug is caught.  A prior allowed bind
- * (connect_after_bind) does not change the connect denial's fields.
+ * A denied TCP bind(2) or connect(2) emits one deny_access_net event with the
+ * checked IPv4 port in host endianness (the UAPI landlock_net_port_attr.port
+ * convention).  A prior allowed bind does not change a connect denial's port.
  */
 TEST_F(trace_net_connect, deny_access_net)
 {
@@ -3693,21 +3693,13 @@ TEST_F(trace_net_connect, deny_access_net)
 
 	expect_net_deny_common_fields(_metadata, buf);
 
-	/*
-	 * The denied operation's port field carries the port; the other is 0.
-	 */
 	snprintf(expected, sizeof(expected), "%llu",
 		 (unsigned long long)(sock_port_start + 1));
 
 	ASSERT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
-					"sport", field, sizeof(field)));
-	EXPECT_STREQ(variant->deny_connect ? "0" : expected, field);
-
-	ASSERT_EQ(0,
-		  tracefs_extract_field(buf, REGEX_DENY_ACCESS_NET(TRACE_TASK),
-					"dport", field, sizeof(field)));
-	EXPECT_STREQ(variant->deny_connect ? expected : "0", field);
+					"port", field, sizeof(field)));
+	EXPECT_STREQ(expected, field);
 
 	free(buf);
 }
@@ -3867,11 +3859,4 @@ TEST_F(trace_net_check_rule, check_rule_net_fields)
 	free(buf);
 }
 
-/*
- * IPv6 network trace tests are intentionally elided.  IPv6 hook dispatch uses
- * the same current_check_access_socket() code path as IPv4, validated by the
- * audit tests in this file.  The trace events use the same blockers/sport/dport
- * fields regardless of address family.
- */
-
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
index e6873853376c..2ec863362173 100644
--- a/tools/testing/selftests/landlock/trace.h
+++ b/tools/testing/selftests/landlock/trace.h
@@ -145,8 +145,7 @@
 	"same_exec=[01] "            \
 	"logged=[01] "               \
 	"blockers=[a-z_|]* "         \
-	"sport=[0-9]\\+ "            \
-	"dport=[0-9]\\+$"
+	"port=-\\?[0-9]\\+$"
 
 #define REGEX_DENY_PTRACE(task)      \
 	TRACE_PREFIX(task)           \
-- 
2.55.0


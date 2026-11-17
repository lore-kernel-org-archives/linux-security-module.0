Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910883;
	b=BLqCaLy+R4/xMZBiANCFdAwr7AsHfyduStwAT4dqzDAMErJfebgq+aVi0TUDNLbEDmEQ
	 oUPMQhSuPDLo9FKHQOht0JGketvnQphBQN2cvcp8N27pOkldV/c5RLdBV0655O2Ri0Hc8
	 LlvEOP7Do6OswGCTB46X8ik72evsjNG9OuCMYjKCQOj2huUFtOF05muj/7dp+zCjmPv3V
	 76fHrsFXhtSPcadhHmF1wIwmiKgD/OwNT/EBCGATt1WdlfWR3x7Bfh+wzHJIsQDmKhyff
	 aLCum676GsK9II4pgrttltVbg+yeRfSe0rulMcInSYEfcD/LHoZkn23ad23Qn7s5IYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910883;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=tg8FlYB50zB5hXH7HwYS1/iWqoRpxATYxZpYu9D+G7M=;
	b=5gEPEJRmOrcR1g7kKiXR4jEHR2xfkNW1OfXSVeM7f0sRgsWPYOs+LGfBydPYZFE29oT9
	 7ZEtPjYHvGYJ+BD54Y97bOdjmLTam9Y8oj0o2i90Hspvuq7STcGo9HWWtQ7G03Q+KlKMJ
	 bipI4IH77O2BZew7cICXOEah49WqcRlaOfQuccM7KKlCbM1Bh9wJj7BDCMBUqBc2p1+Cr
	 lxK3BlgyWnZv5fO9BeRl/kLEWywOlVJBQzt6unhE3CPOTnpWSSxCzIp1iQ0qibUvqPyNY
	 27IW4+82bugd/CyWTdSQ81ndAQ2kAJaBdWRVA6LBcMBloa/2+aesR2DwoVJhUOF2iug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EPNo++yF;
	arc=none smtp.remote-ip=84.16.66.171
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAB606A33F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBAB606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EPNo++yF
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLNx1txKzW0V;
	Tue, 17 Nov 2026 11:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910881;
	bh=tg8FlYB50zB5hXH7HwYS1/iWqoRpxATYxZpYu9D+G7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPNo++yFjHpieX1q1GHnRwRD3OB+G43yEQxDEyeoObkKtzGFLtNwtIZisB1FGShKy
	 Br2JSzbmHBluj7s6Z+J3nmhhSmYg+yo1jJCPWof+1XKDHyIIggz3xN+MaWPNYAQWiJ
	 9isVGQPBIc2RfnJERovaNV10jJA4osRxzIdn020g=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLNv0xwzzNy2;
	Tue, 17 Nov 2026 11:21:19 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Paris <eparis@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] landlock: Distinguish namespace creation and entry denials
Date: Tue, 17 Nov 2026 11:21:04 +0100
Message-ID: <20261117102110.2524197-2-mic@digikod.net>
In-Reply-To: <20261117102110.2524197-1-mic@digikod.net>
References: <20261117102110.2524197-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Landlock reports denied namespace creation and entry with the same
internal request type.  Before commit 08471914d6bb ("ns: allocate the
namespace id before the namespace_init hook"), denied creation carried
ID zero and could be distinguished from entry by ID alone.  That commit
moved ID allocation before namespace_init(), so creation now carries the
ID of an unreachable new namespace while entry carries the existing
target ID.  Namespace IDs are object context, not operation
discriminators.

Split the request type into creation and entry.  Keep the two namespace
values together before capability; this renumbers the unreleased
capability request in raw and typed trace context.  Report
namespace_op=create or namespace_op=enter immediately after blockers in
namespace audit records and trace event text.  Placing the operation
before namespace_type and namespace_id lets consumers establish the
semantics before interpreting the following namespace context,
especially whether namespace_id is the creation-time value or identifies
an existing entry target.

Keep namespace.use as the policy blocker: the new value only describes
the semantic hook context and does not add a policy control.

The creation value covers namespace_init(), including clone(2),
clone3(2), unshare(2), open_tree(2), and fsmount(2) paths.  The entry
value covers namespace_install(), currently reached through setns(2).

Cc: Günther Noack <gnoack@google.com>
Fixes: 15dd86021b57 ("landlock: Enforce namespace use restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h            | 25 ++++++++++++++--------
 security/landlock/audit.c                  | 10 +++++++--
 security/landlock/log.c                    |  6 ++++--
 security/landlock/log.h                    |  3 ++-
 security/landlock/ns.c                     | 10 +++++----
 security/landlock/trace.c                  |  3 ++-
 tools/testing/selftests/landlock/ns_test.c | 18 +++++++++++-----
 tools/testing/selftests/landlock/trace.h   |  1 +
 8 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index b6fdc6e2eef8..9b3e24a613d8 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -36,7 +36,8 @@ static_assert(sizeof(access_mask_t) <= sizeof(u64));
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
-TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_CREATE);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_ENTER);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_CAPABILITY);
 
 #ifdef CREATE_TRACE_POINTS
@@ -990,7 +991,8 @@ TRACE_EVENT(landlock_deny_access_net,
  * @namespace_id: Namespace ID, not directly visible from user space when
  *                creation was denied.
  *
- * Emitted when a Landlock domain denies namespace use.
+ * Emitted when a Landlock domain denies namespace creation or entry.  The
+ * namespace_op field distinguishes these operations.
  */
 TRACE_EVENT(landlock_deny_permission_namespace,
 
@@ -1021,13 +1023,18 @@ TRACE_EVENT(landlock_deny_permission_namespace,
 		__entry->namespace_id	= namespace_id;
 	),
 
-	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s namespace_type=0x%x namespace_id=%llu",
-		__entry->domain_id, __entry->same_exec, __entry->logged,
-		__entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE ?
-			__print_flags(__entry->blockers_access, "|",
-				      _LANDLOCK_PERMISSION_BLOCKER_NAMES) :
-			"unknown",
-		__entry->namespace_type, __entry->namespace_id)
+	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s namespace_op=%s namespace_type=0x%x namespace_id=%llu",
+		  __entry->domain_id, __entry->same_exec, __entry->logged,
+		  (__entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_CREATE ||
+		   __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ENTER) ?
+			  __print_flags(__entry->blockers_access, "|",
+					_LANDLOCK_PERMISSION_BLOCKER_NAMES) :
+			  "unknown",
+		  __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_CREATE ?
+			  "create" :
+		  __entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE_ENTER ?
+			  "enter" : "unknown",
+		  __entry->namespace_type, __entry->namespace_id)
 );
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index be49ef47b4ea..6d9e54f5deed 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -80,7 +80,8 @@ get_blocker(const enum landlock_request_type type,
 		WARN_ON_ONCE(access_bit != -1);
 		return scope_strings[BIT_INDEX(LANDLOCK_SCOPE_SIGNAL)];
 
-	case LANDLOCK_REQUEST_NAMESPACE:
+	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
+	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
 	case LANDLOCK_REQUEST_CAPABILITY:
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(permission_strings)))
 			return "unknown";
@@ -115,7 +116,8 @@ blocker_prefix(const enum landlock_request_type type)
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		return "scope.";
 
-	case LANDLOCK_REQUEST_NAMESPACE:
+	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
+	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
 		return _LANDLOCK_PERMISSION_NAMESPACE_NAME ".";
 
 	case LANDLOCK_REQUEST_CAPABILITY:
@@ -212,6 +214,10 @@ void landlock_audit_denial(const struct landlock_request *const request,
 
 	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
 	log_blockers(ab, request->type, missing);
+	if (request->type == LANDLOCK_REQUEST_NAMESPACE_CREATE)
+		audit_log_format(ab, " namespace_op=create");
+	else if (request->type == LANDLOCK_REQUEST_NAMESPACE_ENTER)
+		audit_log_format(ab, " namespace_op=enter");
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
 
diff --git a/security/landlock/log.c b/security/landlock/log.c
index 43efbb95725c..c132b343f0ee 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -388,7 +388,8 @@ static bool is_valid_request(const struct landlock_request *const request)
 		return false;
 
 	switch (request->type) {
-	case LANDLOCK_REQUEST_NAMESPACE:
+	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
+	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
 		if (WARN_ON_ONCE(request->permission !=
 				 LANDLOCK_PERMISSION_NAMESPACE_USE) ||
 		    WARN_ON_ONCE(request->audit.type != LSM_AUDIT_DATA_NS))
@@ -485,7 +486,8 @@ is_denial_quieted(const struct landlock_request *const request,
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 		return !!(youngest_denied->quiet_access.scope &
 			  LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
-	case LANDLOCK_REQUEST_NAMESPACE:
+	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
+	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
 		return !!(youngest_denied->quiet_permission.ns_types &
 			  landlock_ns_type_to_bit(request->audit.u.ns.ns_type));
 	case LANDLOCK_REQUEST_CAPABILITY:
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 596feeeb7aa6..641a2c3c78ed 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -25,7 +25,8 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
-	LANDLOCK_REQUEST_NAMESPACE,
+	LANDLOCK_REQUEST_NAMESPACE_CREATE,
+	LANDLOCK_REQUEST_NAMESPACE_ENTER,
 	LANDLOCK_REQUEST_CAPABILITY,
 };
 
diff --git a/security/landlock/ns.c b/security/landlock/ns.c
index 06d9784746fe..3d443599b16f 100644
--- a/security/landlock/ns.c
+++ b/security/landlock/ns.c
@@ -90,6 +90,7 @@ static const struct access_masks ns_permission = {
  * check_ns_type - Check namespace use permission
  *
  * @ns: The namespace being allocated or installed.
+ * @request_type: Namespace operation reported on denial.
  *
  * Shared check for namespace_init (creation via clone(2), unshare(2),
  * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2)): denies
@@ -99,7 +100,8 @@ static const struct access_masks ns_permission = {
  *
  * Return: 0 if allowed, -EPERM if denied.
  */
-static int check_ns_type(struct ns_common *const ns)
+static int check_ns_type(struct ns_common *const ns,
+			 const enum landlock_request_type request_type)
 {
 	const struct landlock_cred_security *subject;
 	size_t denied_layer;
@@ -117,7 +119,7 @@ static int check_ns_type(struct ns_common *const ns)
 
 	landlock_log_denial(subject,
 			    &(struct landlock_request){
-				    .type = LANDLOCK_REQUEST_NAMESPACE,
+				    .type = request_type,
 				    .audit.type = LSM_AUDIT_DATA_NS,
 				    .permission =
 					    LANDLOCK_PERMISSION_NAMESPACE_USE,
@@ -130,13 +132,13 @@ static int check_ns_type(struct ns_common *const ns)
 
 static int hook_namespace_init(struct ns_common *const ns)
 {
-	return check_ns_type(ns);
+	return check_ns_type(ns, LANDLOCK_REQUEST_NAMESPACE_CREATE);
 }
 
 static int hook_namespace_install(const struct nsset *const nsset,
 				  struct ns_common *const ns)
 {
-	return check_ns_type(ns);
+	return check_ns_type(ns, LANDLOCK_REQUEST_NAMESPACE_ENTER);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 995c6b948e16..00cb497eaffb 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -81,7 +81,8 @@ void landlock_trace_denial(
 	const access_mask_t missing, const bool same_exec, const bool logged)
 {
 	switch (request->type) {
-	case LANDLOCK_REQUEST_NAMESPACE:
+	case LANDLOCK_REQUEST_NAMESPACE_CREATE:
+	case LANDLOCK_REQUEST_NAMESPACE_ENTER:
 		if (trace_landlock_deny_permission_namespace_enabled()) {
 			const struct landlock_blockers blockers = {
 				.access = missing,
diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index 8f387fc47e21..d4a85cbebeae 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -1897,11 +1897,14 @@ TEST(setns_inherited_fd)
 
 /* Audit tests */
 
+#define REGEX_LANDLOCK_NS_CREATE \
+	REGEX_LANDLOCK_PREFIX " blockers=namespace\\.use namespace_op=create"
+
 static int matches_log_ns_create(int audit_fd, __u64 ns_type)
 {
 	/* A denied creation logs the ID allocated for the new namespace. */
-	static const char log_template[] = REGEX_LANDLOCK_PREFIX
-		" blockers=namespace\\.use namespace_type=0x%x namespace_id=[1-9][0-9]*$";
+	static const char log_template[] = REGEX_LANDLOCK_NS_CREATE
+		" namespace_type=0x%x namespace_id=[1-9][0-9]*$";
 	char log_match[sizeof(log_template) + 10];
 	int log_match_len;
 
@@ -1917,12 +1920,12 @@ static int matches_log_ns_create(int audit_fd, __u64 ns_type)
 static int matches_log_ns_setns(int audit_fd, __u64 ns_type, __u64 ns_id)
 {
 	static const char log_template[] = REGEX_LANDLOCK_PREFIX
-		" blockers=namespace\\.use namespace_type=0x%x namespace_id=%llu$";
+		" blockers=namespace\\.use namespace_op=%s namespace_type=0x%x namespace_id=%llu$";
 	char log_match[sizeof(log_template) + 32];
 	int log_match_len;
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
-				 (unsigned int)ns_type,
+				 "enter", (unsigned int)ns_type,
 				 (unsigned long long)ns_id);
 	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
@@ -1958,7 +1961,7 @@ FIXTURE_TEARDOWN(ns_audit)
 
 /*
  * Verifies that a denied namespace creation produces the expected audit record
- * with the namespace.use blocker string and namespace_type.
+ * with the namespace.use blocker string, namespace type, and create operation.
  */
 TEST_F(ns_audit, create_denied)
 {
@@ -2542,6 +2545,11 @@ static void test_ns_trace_denial(struct __test_metadata *const _metadata,
 	EXPECT_STRNE("0", field);
 	if (use_setns)
 		EXPECT_EQ(expected_ns_id, strtoull(field, NULL, 10));
+	ret = tracefs_extract_field(buf,
+				    REGEX_DENY_PERMISSION_NAMESPACE(TRACE_TASK),
+				    "namespace_op", field, sizeof(field));
+	ASSERT_EQ(0, ret);
+	EXPECT_STREQ(use_setns ? "enter" : "create", field);
 
 	free(buf);
 }
diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
index 36e8f16171b0..e67f239a8507 100644
--- a/tools/testing/selftests/landlock/trace.h
+++ b/tools/testing/selftests/landlock/trace.h
@@ -185,6 +185,7 @@
 	"same_exec=[01] "                      \
 	"logged=[01] "                         \
 	"blockers=[a-z_|]* "                   \
+	"namespace_op=\\(create\\|enter\\) "   \
 	"namespace_type=0x[0-9a-f]\\+ "        \
 	"namespace_id=[0-9]\\+$"
 
-- 
2.56.0


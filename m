Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57A31E859
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486982; cv=none; b=L/KhNTv1/JitnfjkK/Jxgd3TnTXS0gLkEVQ7zREO7x7TVFfjIlc5f/82L6Vecg7/IZ0vFYaRW1V4wZTSuN9h2b9Kyu9pd2/dwnUA8nhGewndF6U4k9Ny+iysn94CzG1geeOSmxm0oejg1fPsosf8pZxxbMGcCw+MjrsZSxB9hhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486982; c=relaxed/simple;
	bh=0BHTdU5ODZCyv7FBenPpMXAoX9s5NnRbNht2OszFZzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5fyoQT91aFB2wsJulagbeFHgSDG47VS6mK921MysME6o5A7ZQB7tKT/9HtbpFjy0dF0SiYRxEa85aKHfcEBjE0J5FipSPtQvDEmINtNMz/eG+8aZpSlKMaEyySCAEEgvIE8OEPiBmyqB66O6N9DUgdeymIFBrjRD/OTmp206pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ccS8qb5Q; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ccS8qb5Q"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkW3tc7zVk6;
	Mon,  6 Apr 2026 16:37:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486259;
	bh=HjP4hfJRZsXvNfkJhlRzWsb0xfYnntkXkRpnJr2sG/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccS8qb5QgxDOUHlja6gJAIWfeCzM5k+4AuM0Os0b76jWYbzW+A4Pm/nenyAq4UtbG
	 de+7oLdJR8IlJ/OQNw5yU6HlTSrLzDHfBQvGFqvQ2aPnrs3tHSz6B4whrJQqpbshIq
	 q0raXd8JxIhcbQ5vpDnXQYATJTibEzITz4/4HLmM=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkV6fZQzDqy;
	Mon,  6 Apr 2026 16:37:38 +0200 (CEST)
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
Subject: [PATCH v2 11/17] landlock: Add landlock_deny_access_fs and landlock_deny_access_net
Date: Mon,  6 Apr 2026 16:37:09 +0200
Message-ID: <20260406143717.1815792-12-mic@digikod.net>
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

Add per-type tracepoints emitted from landlock_log_denial() when an
access is denied: landlock_deny_access_fs for filesystem denials and
landlock_deny_access_net for network denials.

The events use the "deny_" prefix (rather than "check_") to make clear
that they fire only on denial, not on every access check.

These complement the check_rule tracepoints by showing the final denial
verdict, including the denial-by-absence case (when no rule matches
along the pathwalk, no check_rule events fire, but the deny_access event
makes the denial explicit).

Trace events fire unconditionally, independent of audit configuration
and user-specified log flags (LANDLOCK_LOG_DISABLED).  The user's
"disable logging" intent applies to audit records, not to kernel
tracing.  The LANDLOCK_LOG_DISABLED check is moved into the
audit-specific path; num_denials and trace emission execute regardless.

The deny_access events pass the denying hierarchy node (const struct
landlock_hierarchy *hierarchy) in TP_PROTO, not the task's current
domain.  The domain_id entry field shows the ID of the specific
hierarchy node that blocked the access, matching audit record semantics.
This differs from check_rule events which pass the task's current domain
(needed for the dynamic per-layer array sizing).

The same_exec field is passed in TP_PROTO because it is computed from
the credential bitmask, not derivable from the hierarchy pointer alone.
The events include same_exec, log_same_exec, and log_new_exec fields for
stateless ftrace filtering that replicates audit's suppression logic.

The denial field is named "blockers" (matching the audit record field)
rather than "blocked", to enable consistent field-name correlation
between audit and trace output.

Network denial sport and dport fields use __u64 host-endian, matching
the landlock_net_port_attr.port UAPI convention.  The caller converts
from the lsm_network_audit __be16 fields via ntohs() before emitting
the event.

The filesystem path is resolved via d_absolute_path() (the same helper
used by landlock_add_rule_fs), producing namespace-independent absolute
paths.  Audit uses d_path() which resolves relative to the process's
chroot; the difference is documented but acceptable for tracepoints
which are designed for deterministic output regardless of the tracer's
namespace state.  Device numbers use numeric major:minor format (unlike
audit's string s_id) for machine parseability.

For FS_CHANGE_TOPOLOGY hooks that provide only a dentry, the path is
resolved via dentry_path_raw() instead of d_absolute_path().

The denial tracepoint allocates PATH_MAX bytes from the heap via
__getname() for path resolution.  This cost is only paid when a tracer
is attached.

Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 include/trace/events/landlock.h | 100 +++++++++++++++++++++
 security/landlock/log.c         | 149 ++++++++++++++++++++++++++------
 security/landlock/log.h         |   9 +-
 3 files changed, 227 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index e7bb8fa802bf..1afab091efba 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -18,6 +18,7 @@ struct landlock_hierarchy;
 struct landlock_rule;
 struct landlock_ruleset;
 struct path;
+struct sock;
 
 /**
  * DOC: Landlock trace events
@@ -50,6 +51,15 @@ struct path;
  * Network port fields use __u64 in host endianness, matching the
  * landlock_net_port_attr.port UAPI convention.  Callers convert from
  * network byte order before emitting the event.
+ *
+ * Field ordering convention for denial events: domain ID, same_exec,
+ * log_same_exec, log_new_exec, then blockers (deny_access events only),
+ * then type-specific object identification fields, then variable-length
+ * fields.
+ *
+ * The deny_access denial events include same_exec and log_same_exec /
+ * log_new_exec fields so that both stateless (ftrace filter) and stateful
+ * (eBPF) consumers can replicate the audit subsystem's filtering logic.
  */
 
 /**
@@ -333,6 +343,96 @@ TRACE_EVENT(landlock_check_rule_net,
 		      __entry->port,
 		      __print_dynamic_array(layers, sizeof(access_mask_t))));
 
+/**
+ * landlock_deny_access_fs - filesystem access denied
+ * @hierarchy: Hierarchy node that blocked the access (never NULL).
+ *             Identifies the specific domain in the hierarchy whose
+ *             rules caused the denial.  eBPF can read hierarchy->id,
+ *             hierarchy->log_same_exec, hierarchy->log_new_exec, and
+ *             walk hierarchy->parent for the domain chain.
+ * @same_exec: Whether the current task is the same executable that
+ *             called landlock_restrict_self() for the denying hierarchy
+ *             node.  Computed from the credential bitmask, not derivable
+ *             from the hierarchy alone.
+ * @blockers: Access mask that was blocked
+ * @path: Filesystem path that was denied (never NULL)
+ * @pathname: Resolved absolute path string (never NULL)
+ */
+TRACE_EVENT(
+	landlock_deny_access_fs,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 access_mask_t blockers, const struct path *path,
+		 const char *pathname),
+
+	TP_ARGS(hierarchy, same_exec, blockers, path, pathname),
+
+	TP_STRUCT__entry(
+		__field(__u64, domain_id) __field(bool, same_exec)
+			__field(u32, log_same_exec) __field(u32, log_new_exec)
+				__field(access_mask_t, blockers)
+					__field(dev_t, dev) __field(ino_t, ino)
+						__string(pathname, pathname)),
+
+	TP_fast_assign(__entry->domain_id = hierarchy->id;
+		       __entry->same_exec = same_exec;
+		       __entry->log_same_exec = hierarchy->log_same_exec;
+		       __entry->log_new_exec = hierarchy->log_new_exec;
+		       __entry->blockers = blockers;
+		       __entry->dev = path->dentry->d_sb->s_dev;
+		       __entry->ino = d_backing_inode(path->dentry)->i_ino;
+		       __assign_str(pathname);),
+
+	TP_printk(
+		"domain=%llx same_exec=%d log_same_exec=%u log_new_exec=%u blockers=0x%x dev=%u:%u ino=%lu path=%s",
+		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
+		__entry->log_new_exec, __entry->blockers, MAJOR(__entry->dev),
+		MINOR(__entry->dev), __entry->ino,
+		__print_untrusted_str(pathname)));
+
+/**
+ * landlock_deny_access_net - network access denied
+ * @hierarchy: Hierarchy node that blocked the access (never NULL)
+ * @same_exec: Whether the current task is the same executable that
+ *             called landlock_restrict_self() for the denying hierarchy
+ *             node
+ * @blockers: Access mask that was blocked
+ * @sk: Socket object (never NULL); eBPF can read socket family, state,
+ *      local/remote addresses, and options via BTF
+ * @sport: Source port in host endianness (non-zero for bind denials,
+ *         zero for connect denials)
+ * @dport: Destination port in host endianness (non-zero for connect
+ *         denials, zero for bind denials)
+ */
+TRACE_EVENT(
+	landlock_deny_access_net,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 access_mask_t blockers, const struct sock *sk, __u64 sport,
+		 __u64 dport),
+
+	TP_ARGS(hierarchy, same_exec, blockers, sk, sport, dport),
+
+	TP_STRUCT__entry(
+		__field(__u64, domain_id) __field(bool, same_exec)
+			__field(u32, log_same_exec) __field(u32, log_new_exec)
+				__field(access_mask_t, blockers)
+					__field(__u64, sport)
+						__field(__u64, dport)),
+
+	TP_fast_assign(__entry->domain_id = hierarchy->id;
+		       __entry->same_exec = same_exec;
+		       __entry->log_same_exec = hierarchy->log_same_exec;
+		       __entry->log_new_exec = hierarchy->log_new_exec;
+		       __entry->blockers = blockers; __entry->sport = sport;
+		       __entry->dport = dport;),
+
+	TP_printk(
+		"domain=%llx same_exec=%d log_same_exec=%u log_new_exec=%u blockers=0x%x sport=%llu dport=%llu",
+		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
+		__entry->log_new_exec, __entry->blockers, __entry->sport,
+		__entry->dport));
+
 #endif /* _TRACE_LANDLOCK_H */
 
 /* This part must be outside protection */
diff --git a/security/landlock/log.c b/security/landlock/log.c
index ab4f982f8184..c81cb7c1c448 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -3,6 +3,7 @@
  * Landlock - Log helpers
  *
  * Copyright © 2023-2025 Microsoft Corporation
+ * Copyright © 2026 Cloudflare
  */
 
 #include <kunit/test.h>
@@ -143,6 +144,9 @@ static void audit_denial(const struct landlock_cred_security *const subject,
 {
 	struct audit_buffer *ab;
 
+	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
+		return;
+
 	if (!audit_enabled)
 		return;
 
@@ -172,6 +176,16 @@ static void audit_denial(const struct landlock_cred_security *const subject,
 	log_domain(youngest_denied);
 }
 
+#else /* CONFIG_AUDIT */
+
+static inline void
+audit_denial(const struct landlock_cred_security *const subject,
+	     const struct landlock_request *const request,
+	     struct landlock_hierarchy *const youngest_denied,
+	     const size_t youngest_layer, const access_mask_t missing)
+{
+}
+
 #endif /* CONFIG_AUDIT */
 
 #include <trace/events/landlock.h>
@@ -180,6 +194,86 @@ static void audit_denial(const struct landlock_cred_security *const subject,
 #define CREATE_TRACE_POINTS
 #include <trace/events/landlock.h>
 #undef CREATE_TRACE_POINTS
+
+#include "fs.h"
+
+static void trace_denial(const struct landlock_cred_security *const subject,
+			 const struct landlock_request *const request,
+			 const struct landlock_hierarchy *const youngest_denied,
+			 const size_t youngest_layer,
+			 const access_mask_t missing)
+{
+	const bool same_exec = !!(subject->domain_exec & BIT(youngest_layer));
+
+	switch (request->type) {
+	case LANDLOCK_REQUEST_FS_ACCESS:
+	case LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY:
+		if (trace_landlock_deny_access_fs_enabled()) {
+			char *buf __free(__putname) = __getname();
+			const char *pathname;
+			const struct path *path;
+
+			/*
+			 * FS_CHANGE_TOPOLOGY uses either LSM_AUDIT_DATA_PATH or
+			 * LSM_AUDIT_DATA_DENTRY depending on the hook.  For the
+			 * dentry case, build a path on the stack with the real
+			 * dentry so TP_fast_assign can extract dev and ino.
+			 * The mnt field is unused by TP_fast_assign.
+			 */
+			if (request->audit.type == LSM_AUDIT_DATA_DENTRY) {
+				struct path dentry_path = {
+					.dentry = request->audit.u.dentry,
+				};
+
+				path = &dentry_path;
+				pathname =
+					buf ? dentry_path_raw(
+						      request->audit.u.dentry,
+						      buf, PATH_MAX) :
+					      "<no_mem>";
+				if (IS_ERR(pathname))
+					pathname = "<unreachable>";
+
+				trace_landlock_deny_access_fs(youngest_denied,
+							      same_exec,
+							      missing, path,
+							      pathname);
+			} else {
+				path = &request->audit.u.path;
+				pathname = buf ? resolve_path_for_trace(path,
+									buf) :
+						 "<no_mem>";
+
+				trace_landlock_deny_access_fs(youngest_denied,
+							      same_exec,
+							      missing, path,
+							      pathname);
+			}
+		}
+		break;
+	case LANDLOCK_REQUEST_NET_ACCESS:
+		if (trace_landlock_deny_access_net_enabled())
+			trace_landlock_deny_access_net(
+				youngest_denied, same_exec, missing,
+				request->audit.u.net->sk,
+				ntohs(request->audit.u.net->sport),
+				ntohs(request->audit.u.net->dport));
+		break;
+	default:
+		break;
+	}
+}
+
+#else /* CONFIG_TRACEPOINTS */
+
+static inline void
+trace_denial(const struct landlock_cred_security *const subject,
+	     const struct landlock_request *const request,
+	     const struct landlock_hierarchy *const youngest_denied,
+	     const size_t youngest_layer, const access_mask_t missing)
+{
+}
+
 #endif /* CONFIG_TRACEPOINTS */
 
 static struct landlock_hierarchy *
@@ -439,9 +533,6 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			get_hierarchy(subject->domain, youngest_layer);
 	}
 
-	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
-		return;
-
 	/*
 	 * Consistently keeps track of the number of denied access requests
 	 * even if audit is currently disabled, or if audit rules currently
@@ -450,45 +541,25 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	 */
 	atomic64_inc(&youngest_denied->num_denials);
 
-#ifdef CONFIG_AUDIT
+	trace_denial(subject, request, youngest_denied, youngest_layer,
+		     missing);
 	audit_denial(subject, request, youngest_denied, youngest_layer,
 		     missing);
-#endif /* CONFIG_AUDIT */
 }
 
 #ifdef CONFIG_AUDIT
 
-/**
- * landlock_log_free_domain - Create an audit record on domain deallocation
- *
- * @hierarchy: The domain's hierarchy being deallocated.
- *
- * Only domains which previously appeared in the audit logs are logged again.
- * This is useful to know when a domain will never show again in the audit log.
- *
- * Called in a work queue scheduled by landlock_put_domain_deferred() called by
- * hook_cred_free().
- */
-void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
+static void audit_drop_domain(const struct landlock_hierarchy *const hierarchy)
 {
 	struct audit_buffer *ab;
 
-	if (WARN_ON_ONCE(!hierarchy))
-		return;
-
-	trace_landlock_free_domain(hierarchy);
-
 	if (!audit_enabled)
 		return;
 
-	/* Ignores domains that were not logged.  */
+	/* Ignores domains that were not logged. */
 	if (READ_ONCE(hierarchy->log_status) != LANDLOCK_LOG_RECORDED)
 		return;
 
-	/*
-	 * If logging of domain allocation succeeded, warns about failure to log
-	 * domain deallocation to highlight unbalanced domain lifetime logs.
-	 */
 	ab = audit_log_start(audit_context(), GFP_KERNEL,
 			     AUDIT_LANDLOCK_DOMAIN);
 	if (!ab)
@@ -499,8 +570,32 @@ void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
 	audit_log_end(ab);
 }
 
+#else /* CONFIG_AUDIT */
+
+static inline void
+audit_drop_domain(const struct landlock_hierarchy *const hierarchy)
+{
+}
+
 #endif /* CONFIG_AUDIT */
 
+/**
+ * landlock_log_free_domain - Log domain deallocation
+ *
+ * @hierarchy: The domain's hierarchy being deallocated.
+ *
+ * Called from landlock_put_domain_deferred() (via a work queue scheduled by
+ * hook_cred_free()) or directly from landlock_put_domain().
+ */
+void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
+{
+	if (WARN_ON_ONCE(!hierarchy))
+		return;
+
+	trace_landlock_free_domain(hierarchy);
+	audit_drop_domain(hierarchy);
+}
+
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
 static struct kunit_case test_cases[] = {
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 4370fff86e45..5615a776c29a 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -3,6 +3,7 @@
  * Landlock - Log helpers
  *
  * Copyright © 2023-2025 Microsoft Corporation
+ * Copyright © 2026 Cloudflare
  */
 
 #ifndef _SECURITY_LANDLOCK_LOG_H
@@ -28,7 +29,7 @@ enum landlock_request_type {
 /*
  * We should be careful to only use a variable of this type for
  * landlock_log_denial().  This way, the compiler can remove it entirely if
- * CONFIG_AUDIT is not set.
+ * CONFIG_SECURITY_LANDLOCK_LOG is not set.
  */
 struct landlock_request {
 	/* Mandatory fields. */
@@ -52,14 +53,14 @@ struct landlock_request {
 	deny_masks_t deny_masks;
 };
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy);
 
 void landlock_log_denial(const struct landlock_cred_security *const subject,
 			 const struct landlock_request *const request);
 
-#else /* CONFIG_AUDIT */
+#else /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline void
 landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
@@ -72,6 +73,6 @@ landlock_log_denial(const struct landlock_cred_security *const subject,
 {
 }
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 #endif /* _SECURITY_LANDLOCK_LOG_H */
-- 
2.53.0


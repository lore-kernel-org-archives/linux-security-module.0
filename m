Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910891;
	b=wNdAAkqVTtRlmIc1rRTIj2CfiBaeCwisaKWwF5Q0TAXgwGMo3kBmj+zQJENLW48wqKV+
	 JMkvvYeT6kaWiuuWCHHiZ5nU/Pn6f0IdewQuXuungtaJe7hPRtKGB/OSmCXFXvnrRwDds
	 VpukEXGvjAahnL1kr9E0ngPQCy2vczKGFMcpBr0KunrlEPNDwOiTW++Km9+L71kHf/c3P
	 DWTUE14Q7j1af/qJR4iVhodzVNqgye9h53h2vo1YmbKcvgUlouCmIe/LaFDvg+XtsOVHn
	 wQjhK+yXZbyT0kulCgA7G/c6CPXy5ptUQZBc9kTL6tFb8CnHEoA1F/gqJg82oCdeJ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910891;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=JL2V1SxgjLTmfDXFR1jDnFruDSQqm6wMJEsnCZKyRDU=;
	b=eJsfnPA+xaOTLo17f/K8D3bv+wE3hcwRuEBs4mMs/cd39yxBOlcHFuQCwsDkUYq39jiV
	 IpVuGFovmPYGGr/8PHnX3phErroqKNPUzJhw0TIU1gjbdMYy5OMJZ2MZ4t9OSqS3Ea7Ag
	 AcxXXGSnP3mUgXxk2PC3mdwMQ7sUlYMaLNYzOb8eUh48GiotMuPs7glxnycQ+MAtu1wGT
	 VmtxTLUuO7h6E73Yd6Bl7GSEHOdVYWgY4/d3pJ7X7rxtIsLUTYq2rMOuoEbBua3osOsC3
	 fNtKf0zDWUrVxx0n0FMcCSOvhQDsrg2CYl8RTsTIR7TbbKC2b0z/u+qRWGR+UQhA+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=YUE5UEj+;
	arc=none smtp.remote-ip=84.16.66.170
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DD606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=YUE5UEj+
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLNz44njz5PX;
	Tue, 17 Nov 2026 11:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910883;
	bh=JL2V1SxgjLTmfDXFR1jDnFruDSQqm6wMJEsnCZKyRDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUE5UEj+6J3oM55X1FZDYR2ApAu8VBUf+TEH4o2iie4Z9u30dBWrchUDxFqv+2OzL
	 1/f+f4uxrKS7G3P8QmH5wOeVHca2EFHLUKVGvYArcvVFD8pInc08TfKFy5ZnneDOcB
	 rrYhZic2123crbjgJXA8PBWpQHTqW9rx3+uy3A2g=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLNx44wwzXZK;
	Tue, 17 Nov 2026 11:21:21 +0100 (CET)
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
Subject: [PATCH 2/4] landlock: Add capability objects to denial tracing
Date: Tue, 17 Nov 2026 11:21:05 +0100
Message-ID: <20261117102110.2524197-3-mic@digikod.net>
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

The capability denial tracepoint identifies the capability number but
not the credentials or user namespace against which it was checked.
Typed BPF consumers therefore cannot reconstruct the authoritative hook
context, especially when a check targets a user namespace other than the
caller's current namespace.

Carry the exact cred and user_ns arguments from capable() through the
synchronous Landlock logging request and add them to the tracepoint's
BTF prototype.  Keep them out of TP_STRUCT__entry and TP_printk so the
raw ring-buffer layout and textual format remain unchanged.  They
provide context only and do not participate in Landlock's verdict.

Do not carry the capability options.  CAP_OPT_NOAUDIT already suppresses
the complete denial record, and the remaining option bits do not explain
the checked security relationship.

Cc: Günther Noack <gnoack@google.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 10 ++++++++--
 security/landlock/cap.c         | 11 +++++++++--
 security/landlock/log.h         |  9 +++++++++
 security/landlock/trace.c       |  9 ++++++++-
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 9b3e24a613d8..1e115c80b741 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -21,6 +21,7 @@
 #include <net/af_unix.h>
 
 enum landlock_request_type;
+struct cred;
 struct dentry;
 struct landlock_blockers;
 struct landlock_domain;
@@ -30,6 +31,7 @@ struct landlock_ruleset;
 struct path;
 struct sock;
 struct task_struct;
+struct user_namespace;
 
 static_assert(sizeof(access_mask_t) <= sizeof(u64));
 
@@ -1046,6 +1048,8 @@ TRACE_EVENT(landlock_deny_permission_namespace,
  * @logged: Whether this denial was selected for audit logging.
  * @blockers: Request type and final missing permission subset (never NULL).
  * @capability: CAP_* number that was denied.
+ * @cred: Credentials checked by the capability hook (never NULL).
+ * @user_ns: Target user namespace checked by the capability hook (never NULL).
  *
  * Emitted when a Landlock domain denies capability use, except for checks
  * made with CAP_OPT_NOAUDIT, which are denied without emitting this event.
@@ -1054,9 +1058,11 @@ TRACE_EVENT(landlock_deny_permission_capability,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
 		 bool logged, const struct landlock_blockers *blockers,
-		 int capability),
+		 int capability, const struct cred *cred,
+		 const struct user_namespace *user_ns),
 
-	TP_ARGS(hierarchy, same_exec, logged, blockers, capability),
+	TP_ARGS(hierarchy, same_exec, logged, blockers, capability, cred,
+		user_ns),
 
 	TP_STRUCT__entry(
 		__field(	u64,		domain_id	)
diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index b4f491b09baa..8e1a9c458783 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -27,8 +27,8 @@ static const struct access_masks cap_permission = {
  * hook_capable - Deny capability use for Landlock-sandboxed processes
  *
  * @cred: Credentials being checked.
- * @ns: Target user namespace (intentionally ignored; policy depends on the
- *      acting credentials and @cap, not namespace ownership).
+ * @ns: Target user namespace, forwarded unchanged to typed trace context but
+ *      not used for the verdict (policy depends on @cred and @cap).
  * @cap: Capability number (CAP_*).
  * @opts: Capability check options.  CAP_OPT_NOAUDIT skips the denial record:
  *        no audit record, no trace event, and no denial count.
@@ -67,6 +67,13 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
 				.permission =
 					LANDLOCK_PERMISSION_CAPABILITY_USE,
 				.layer_plus_one = denied_layer,
+#ifdef CONFIG_TRACEPOINTS
+				.trace_cap =
+					&(struct landlock_cap_trace){
+						.cred = cred,
+						.user_ns = ns,
+					},
+#endif /* CONFIG_TRACEPOINTS */
 			});
 
 	return -EPERM;
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 641a2c3c78ed..5ca87870c7b7 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -13,10 +13,12 @@
 
 #include "access.h"
 
+struct cred;
 struct landlock_cred_security;
 struct landlock_hierarchy;
 struct sockaddr;
 struct task_struct;
+struct user_namespace;
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
@@ -54,6 +56,11 @@ struct landlock_signal_trace {
 	int signal;
 };
 
+struct landlock_cap_trace {
+	const struct cred *cred;
+	const struct user_namespace *user_ns;
+};
+
 #endif /* CONFIG_TRACEPOINTS */
 
 /*
@@ -104,6 +111,8 @@ struct landlock_request {
 		const struct landlock_ptrace_trace *trace_ptrace;
 		/* Synchronous context for a signal denial. */
 		const struct landlock_signal_trace *trace_signal;
+		/* Synchronous context for a capability denial. */
+		const struct landlock_cap_trace *trace_cap;
 	};
 #endif /* CONFIG_TRACEPOINTS */
 };
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 00cb497eaffb..a47fb10dec45 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -97,14 +97,21 @@ void landlock_trace_denial(
 		break;
 	case LANDLOCK_REQUEST_CAPABILITY:
 		if (trace_landlock_deny_permission_capability_enabled()) {
+			const struct landlock_cap_trace *const trace_cap =
+				request->trace_cap;
 			const struct landlock_blockers blockers = {
 				.access = missing,
 				.type = request->type,
 			};
 
+			if (WARN_ON_ONCE(!trace_cap || !trace_cap->cred ||
+					 !trace_cap->user_ns))
+				return;
+
 			trace_landlock_deny_permission_capability(
 				youngest_denied, same_exec, logged, &blockers,
-				request->audit.u.cap);
+				request->audit.u.cap, trace_cap->cred,
+				trace_cap->user_ns);
 		}
 		break;
 	case LANDLOCK_REQUEST_FS_ACCESS:
-- 
2.56.0


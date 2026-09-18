Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B885208AB
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757479; cv=none; b=E+mqEKqRUPghjUC1OAY1EKBd4/7PqsPazoGdF8o+TbtLejl6OyljstpvN4hqhm1oh6BzIEowYUaxLVOwujsEPPIvPI4KNgbTwFJg4MfAgIwsjt8ELgdb4xgc6akBpRi687uHXviSlsBepdeGLnT8iGObvs+0ZRsnVieZBNuXDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757479; c=relaxed/simple;
	bh=VjmWHlC0ffdKx09j45v0vfDXWCfLz81yA/4oXV1nN2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQ7cXDAgSRDEL3+kHi857w2cPmAuSgTAosjbPChmFRT//JzMpGRXC2+XwAy2fwVZRm4MRSW+7ysmSPfr5sAy9G0P09vOY9NWsbi/iANf7wWgS5/r25TLzxXsQwdKhxLLu78X70wVcKDgra7+lIYiS58Gc2SUFh7t1cvY9HYDhZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cES0Zz+H; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cES0Zz+H"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXQ6Jzgzp9J;
	Fri, 18 Sep 2026 20:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757446;
	bh=WCpE+cJcOQk1sK6AbXN0S73Ze2Bn8U4v4NHfgNJm0hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cES0Zz+HrNjoNlgAsqDNCKd7cEBf53jMz7UpmYqXMmKIw0Gv9ccXOqmCqvg57g30a
	 GKu483o1atAlfp0qj+FmSce3s+oBoXaB5EEZJU3LxbkyIAMFAyE0B/8aBF6d00qnVt
	 YYtrk2/qYw7SFcQF8zTYBN3EvWLLkjcD46xpXXvM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXQ0gDLz86s;
	Fri, 18 Sep 2026 20:50:46 +0200 (CEST)
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
Subject: [PATCH v1 2/9] landlock: Fix filesystem denial blocker reporting
Date: Fri, 18 Sep 2026 20:50:25 +0200
Message-ID: <20260918185036.608651-3-mic@digikod.net>
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

Filesystem topology denials are rendered with an empty blockers value
because their blocker is identified by the request type instead of an
access mask.

Introduce the private struct landlock_blockers to carry the request type
and final missing access mask to filesystem and network denial
tracepoints. Copy both members into named trace-record fields, then use
the type to print change_topology for topology denials while preserving
symbolic access masks for ordinary denials.

The request type lets typed BPF consumers distinguish topology denials
from access denials. Keeping the native access mask in a pointer-reached
field also lets CO-RE adjust existing programs' load width if
access_mask_t grows.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 01ce260f5ccf ("landlock: Add landlock_deny_access_fs and landlock_deny_access_net")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 51 ++++++++++++++++++++++++---------
 security/landlock/log.h         |  5 ++++
 security/landlock/trace.c       | 19 +++++++++---
 3 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 4984f80923ed..4e304cab1dab 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -17,7 +17,9 @@
 #include <linux/trace_seq.h>
 #include <net/af_unix.h>
 
+enum landlock_request_type;
 struct dentry;
+struct landlock_blockers;
 struct landlock_domain;
 struct landlock_hierarchy;
 struct landlock_rule;
@@ -26,6 +28,10 @@ struct path;
 struct sock;
 struct task_struct;
 
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
+
 #ifdef CREATE_TRACE_POINTS
 
 /* About 6 KiB, leaving about 2 KiB for sibling helpers and fixed fields. */
@@ -182,6 +188,9 @@ static inline const char *__trace_landlock_print_layers(
 /* Maps a shared _LANDLOCK_*_NAMES entry to a __print_flags() pair. */
 #define _LANDLOCK_NAME_ENTRY(mask, name) { mask, name }
 
+#define _LANDLOCK_FS_BLOCKER_TYPE_NAMES \
+	{ LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY, "change_topology" }
+
 /**
  * DOC: Landlock trace events
  *
@@ -281,6 +290,13 @@ static inline const char *__trace_landlock_print_layers(
  * the two parties without kernel-internal state.  The ID is a scalar
  * snapshot, not a live domain pointer that could dangle: an optional
  * relational referent is a scalar (0 sentinel), not a nullable pointer.
+ *
+ * Blocker fields
+ * ~~~~~~~~~~~~~~
+ *
+ * The filesystem and network blocker arguments identify the request type
+ * and carry its final missing access subset when applicable.  The type
+ * determines how to interpret the access value.
  */
 
 /*
@@ -712,8 +728,7 @@ TRACE_EVENT(landlock_check_rule_net,
  *             domain field.
  * @same_exec: Whether the current task entered the denying domain itself.
  * @logged: The domain's audit-logging decision for this denial.
- * @blockers: Access mask that was blocked (zero for a mount-topology
- *            change, whose only blocker is the operation itself).
+ * @blockers: Request type and final missing access subset (never NULL).
  * @path: Filesystem path that was denied (never NULL).
  * @pathname: Resolved path string (never NULL; an error placeholder on
  *            resolution failure).
@@ -723,8 +738,8 @@ TRACE_EVENT(landlock_check_rule_net,
 TRACE_EVENT(landlock_deny_access_fs,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
-		 bool logged, access_mask_t blockers, const struct path *path,
-		 const char *pathname),
+		 bool logged, const struct landlock_blockers *blockers,
+		 const struct path *path, const char *pathname),
 
 	TP_ARGS(hierarchy, same_exec, logged, blockers, path, pathname),
 
@@ -732,7 +747,8 @@ TRACE_EVENT(landlock_deny_access_fs,
 		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
-		__field(	access_mask_t,	blockers	)
+		__field(	enum landlock_request_type, blockers_type	)
+		__field(	access_mask_t,	blockers_access	)
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
 		__string(	pathname,	pathname	)
@@ -744,7 +760,8 @@ TRACE_EVENT(landlock_deny_access_fs,
 		__entry->domain_id	= hierarchy->id;
 		__entry->same_exec	= same_exec;
 		__entry->logged		= logged;
-		__entry->blockers	= blockers;
+		__entry->blockers_type	= blockers->type;
+		__entry->blockers_access = blockers->access;
 		__entry->dev		= path->dentry->d_sb->s_dev;
 		/*
 		 * A negative dentry has no backing inode, so mirror the
@@ -756,7 +773,10 @@ TRACE_EVENT(landlock_deny_access_fs,
 
 	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s dev=%u:%u ino=%lu path=%s",
 		__entry->domain_id, __entry->same_exec, __entry->logged,
-		__print_flags(__entry->blockers, "|", _LANDLOCK_ACCESS_FS_NAMES),
+		__entry->blockers_type == LANDLOCK_REQUEST_FS_ACCESS ?
+			__print_flags(__entry->blockers_access, "|", _LANDLOCK_ACCESS_FS_NAMES) :
+			__print_symbolic(__entry->blockers_type,
+					 _LANDLOCK_FS_BLOCKER_TYPE_NAMES),
 		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
 		__trace_print_untrusted_str(p, __get_str(pathname),
 					    __get_dynamic_array_len(pathname) - 1))
@@ -769,7 +789,7 @@ TRACE_EVENT(landlock_deny_access_fs,
  *             domain field.
  * @same_exec: Whether the current task entered the denying domain itself.
  * @logged: The domain's audit-logging decision for this denial.
- * @blockers: Access mask that was blocked.
+ * @blockers: Request type and final missing access subset (never NULL).
  * @sk: Socket object (never NULL), read without a socket lock, so its
  *      fields are a best-effort snapshot.  The denied endpoint is not
  *      available: the hook runs before :manpage:`bind(2)` /
@@ -790,8 +810,8 @@ TRACE_EVENT(landlock_deny_access_fs,
 TRACE_EVENT(landlock_deny_access_net,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
-		 bool logged, access_mask_t blockers, const struct sock *sk,
-		 u64 sport, u64 dport),
+		 bool logged, const struct landlock_blockers *blockers,
+		 const struct sock *sk, u64 sport, u64 dport),
 
 	TP_ARGS(hierarchy, same_exec, logged, blockers, sk, sport, dport),
 
@@ -799,7 +819,8 @@ TRACE_EVENT(landlock_deny_access_net,
 		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
-		__field(	access_mask_t,	blockers	)
+		__field(	enum landlock_request_type, blockers_type	)
+		__field(	access_mask_t,	blockers_access	)
 		__field(	u64,		sport		)
 		__field(	u64,		dport		)
 	),
@@ -808,14 +829,17 @@ TRACE_EVENT(landlock_deny_access_net,
 		__entry->domain_id	= hierarchy->id;
 		__entry->same_exec	= same_exec;
 		__entry->logged		= logged;
-		__entry->blockers	= blockers;
+		__entry->blockers_type	= blockers->type;
+		__entry->blockers_access = blockers->access;
 		__entry->sport		= sport;
 		__entry->dport		= dport;
 	),
 
 	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s sport=%llu dport=%llu",
 		__entry->domain_id, __entry->same_exec, __entry->logged,
-		__print_flags(__entry->blockers, "|", _LANDLOCK_ACCESS_NET_NAMES),
+		__entry->blockers_type == LANDLOCK_REQUEST_NET_ACCESS ?
+			__print_flags(__entry->blockers_access, "|", _LANDLOCK_ACCESS_NET_NAMES) :
+			"unknown",
 		__entry->sport, __entry->dport)
 );
 
@@ -991,6 +1015,7 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 					    __get_dynamic_array_len(sun_path) - 1))
 );
 
+#undef _LANDLOCK_FS_BLOCKER_TYPE_NAMES
 #undef _LANDLOCK_NAME_ENTRY
 
 #endif /* _TRACE_LANDLOCK_H */
diff --git a/security/landlock/log.h b/security/landlock/log.h
index e0a6e44f3ddd..04f3e241e765 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -25,6 +25,11 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 };
 
+struct landlock_blockers {
+	access_mask_t access;
+	enum landlock_request_type type;
+};
+
 /*
  * We should be careful to only use a variable of this type for
  * landlock_log_denial().  This way, the compiler can remove it entirely if
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 8c21e5de6f0d..58276cc32d3f 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -61,7 +61,7 @@ void landlock_trace_free_domain(const struct landlock_hierarchy *const hierarchy
  *
  * @request: Detail of the user space request.
  * @youngest_denied: The youngest hierarchy node that denied the access.
- * @missing: The set of denied access rights.
+ * @missing: The final missing access subset, when applicable.
  * @same_exec: Whether the current task is the same executable that called
  *             landlock_restrict_self() for the denying domain, as computed
  *             by landlock_log_denial().
@@ -83,6 +83,10 @@ void landlock_trace_denial(
 	case LANDLOCK_REQUEST_FS_ACCESS:
 	case LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY:
 		if (trace_landlock_deny_access_fs_enabled()) {
+			const struct landlock_blockers blockers = {
+				.access = missing,
+				.type = request->type,
+			};
 			char *buf __free(__putname) = __getname();
 			struct path dentry_path;
 			const char *pathname;
@@ -147,16 +151,23 @@ void landlock_trace_denial(
 
 			trace_landlock_deny_access_fs(youngest_denied,
 						      same_exec, logged,
-						      missing, path, pathname);
+						      &blockers, path,
+						      pathname);
 		}
 		break;
 	case LANDLOCK_REQUEST_NET_ACCESS:
-		if (trace_landlock_deny_access_net_enabled())
+		if (trace_landlock_deny_access_net_enabled()) {
+			const struct landlock_blockers blockers = {
+				.access = missing,
+				.type = request->type,
+			};
+
 			trace_landlock_deny_access_net(
-				youngest_denied, same_exec, logged, missing,
+				youngest_denied, same_exec, logged, &blockers,
 				request->audit.u.net->sk,
 				ntohs(request->audit.u.net->sport),
 				ntohs(request->audit.u.net->dport));
+		}
 		break;
 	case LANDLOCK_REQUEST_PTRACE:
 		if (trace_landlock_deny_ptrace_enabled())
-- 
2.55.0


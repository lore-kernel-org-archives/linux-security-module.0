Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019598;
	b=WnqIG+SHDudSd25TrqT2J0PW4C0WLJdPj1thqXRH0c1cqe7NtiYFW8W7JpzlQW8uxEke
	 XP6LaqPx22XLfooZCGN1Xwg3dA0/IRDc4U8uWztN4Y7mLNHsdk7um5IzuEJDWbNLxXRoL
	 6fGUoN+L/JmzzFVPtiROoOXkTCuFbXkKK9+isBSBIbjZPedu0p1BUrLneBoLiP2s1FJWq
	 +m8NzRxtl7POryqMFMQ3QrLk2MxTgsckmuL+UxYQR7CB3l38bhbcjtyDwOygh4u5CoMBg
	 Br52A2AKUU6vHjJzsQWku0xnUySWB3h4KeVjMot7VVErHl+JOZs86jPwxYIbiUbg1mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019598;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=ntwRtha26cu9+6nMcPdfX0yLKMxHwh5Vp3GAIdX+Bhs=;
	b=IfLMYnfPP+gU3Z/lL2kFQ5lwFb8iRso0yCvpnRgPV73xxjiAgL6x0f+Rx2gyPFWH220y
	 bsozfdd6u9kSEWdbfXKf6BiMkvLwSWEKm0IsqYDLQRX2dz7WEr0RwZTfmkHClwl/UYuPQ
	 wXA4qSQNOxwYsQPQ22QyI4xJhHfxTymUusImQFzbwesA5nuFTfR4Unp50UaBQC2jWPOgx
	 qPpGMJsMwN7YDuqT9cm8XfFPoakf9yVf5kAYIbCynUvaf8agq9yUic7cbBcNp9BnPuGNS
	 UlB+EB0UdX9srwIuIuO9HgtHGO1Y4F6I3OQ55ecnD5pHzF90R9jL4guRb2Wnt7ddSww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=02jqntJq;
	arc=none smtp.remote-ip=185.125.25.12
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1389606A7C8
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 16:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1389606A7C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=02jqntJq
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV6bR6fvGzXmx;
	Wed, 18 Nov 2026 17:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795019587;
	bh=ntwRtha26cu9+6nMcPdfX0yLKMxHwh5Vp3GAIdX+Bhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=02jqntJqgfacC2Kq/A6IhDNSFxUEmfWsB1ErvG2FLsJHTFx+FZpNDlbXwbFoP9TMk
	 VaKoIfh5Gb3VO+THe2l21WtJrC42+2s+U8XQX8RUTnYYvi1nlRxYZL9U6OxaZHyQHj
	 jpBWToMznhS6/3BCkkQac7cE9iZdCNm2KITj/mbE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV6bQ3tfnzktj;
	Wed, 18 Nov 2026 17:33:06 +0100 (CET)
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
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] landlock: Add capability objects to denial tracing
Date: Wed, 18 Nov 2026 17:32:50 +0100
Message-ID: <20261118163254.2554413-3-mic@digikod.net>
In-Reply-To: <20261118163254.2554413-1-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
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

Carry the exact cred and user_ns used by each commoncap check through
check_cap() to the tracepoint's BTF prototype.  The capable hook
forwards its arguments.  Other callers mirror old->user_ns for
CAP_SETPCAP, and init_user_ns for CAP_SYS_RAWIO and CAP_SYS_ADMIN.  The
latter checks protect global hardening and the global admin memory
reserve, so nested user-namespace capabilities must not authorize them.

Keep these pointers out of TP_STRUCT__entry and TP_printk so the raw
ring-buffer layout and textual format remain unchanged.  They provide
context only and do not participate in Landlock's verdict.

Do not carry the capability options.  CAP_OPT_NOAUDIT already suppresses
the complete denial record, and the remaining option bits do not explain
the checked security relationship.

Cc: Günther Noack <gnoack@google.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>

---

Changes since v1:
https://patch.msgid.link/20261117102110.2524197-3-mic@digikod.net
- Adapt check_cap() callers on landlock-next to forward the exact target
  user namespace used by commoncap.
- Document why global checks target init_user_ns and identify the new
  standard BTF objects as commoncap check context.
---
 Documentation/trace/events-landlock.rst |  6 ++--
 include/trace/events/landlock.h         | 11 ++++--
 security/landlock/cap.c                 | 45 ++++++++++++++++++-------
 security/landlock/log.h                 |  9 +++++
 security/landlock/trace.c               |  9 ++++-
 5 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index dc5f05a17c2c..1ddc123df59e 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -303,9 +303,9 @@ event prototypes in `Event reference`_ document their argument layouts.
 The arguments include both standard kernel objects and Landlock-internal
 objects:
 
-- Standard kernel objects (``struct task_struct``, ``struct sock``,
-  ``struct path``, ``struct dentry``) can be used with existing BPF
-  helpers.
+- Standard kernel objects (for example ``struct task_struct``, ``struct cred``,
+  ``struct user_namespace``, ``struct sock``, ``struct path``, and
+  ``struct dentry``) can be used with existing BPF helpers.
 - Landlock-internal objects (``struct landlock_domain``,
   ``struct landlock_ruleset``, ``struct landlock_rule``,
   ``struct landlock_hierarchy``) can be read via ``BPF_CORE_READ``.
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 9b3e24a613d8..09e90e4a9cd7 100644
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
 
@@ -1046,6 +1048,9 @@ TRACE_EVENT(landlock_deny_permission_namespace,
  * @logged: Whether this denial was selected for audit logging.
  * @blockers: Request type and final missing permission subset (never NULL).
  * @capability: CAP_* number that was denied.
+ * @cred: Credentials used by commoncap's capability check (never NULL).
+ * @user_ns: Target user namespace used by commoncap's capability check (never
+ *           NULL).
  *
  * Emitted when a Landlock domain denies capability use, except for checks
  * made with CAP_OPT_NOAUDIT, which are denied without emitting this event.
@@ -1054,9 +1059,11 @@ TRACE_EVENT(landlock_deny_permission_capability,
 
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
index caf514be3df0..ae3acd13a367 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -28,6 +28,10 @@ static const struct access_masks cap_permission = {
  * check_cap - Check a capability use against the domain of @cred
  *
  * @cred: Credentials being checked.
+ * @ns: Target user namespace used by commoncap's capability check, which is
+ *      not necessarily @cred->user_ns.  It is forwarded unchanged to typed
+ *      trace context but is not used for the verdict (policy depends on @cred
+ *      and @cap).
  * @cap: Capability number (CAP_*).
  * @opts: Capability check options.  CAP_OPT_NOAUDIT skips the denial record:
  *        no audit record, no trace event, and no denial count.
@@ -38,7 +42,8 @@ static const struct access_masks cap_permission = {
  *
  * Return: 0 if allowed, -EPERM if capability use is denied.
  */
-static int check_cap(const struct cred *const cred, const int cap,
+static int check_cap(const struct cred *const cred,
+		     struct user_namespace *const ns, const int cap,
 		     const unsigned int opts)
 {
 	const struct landlock_cred_security *subject;
@@ -64,6 +69,13 @@ static int check_cap(const struct cred *const cred, const int cap,
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
@@ -73,8 +85,7 @@ static int check_cap(const struct cred *const cred, const int cap,
  * hook_capable - Deny capability use for Landlock-sandboxed processes
  *
  * @cred: Credentials being checked.
- * @ns: Target user namespace (intentionally ignored; policy depends on the
- *      acting credentials and @cap, not namespace ownership).
+ * @ns: Target user namespace, used only as typed trace context.
  * @cap: Capability number (CAP_*).
  * @opts: Capability check options, see check_cap().
  *
@@ -88,7 +99,7 @@ static int check_cap(const struct cred *const cred, const int cap,
 static int hook_capable(const struct cred *cred, struct user_namespace *ns,
 			int cap, unsigned int opts)
 {
-	return check_cap(cred, cap, opts);
+	return check_cap(cred, ns, cap, opts);
 }
 
 /**
@@ -118,7 +129,7 @@ static int hook_capset(struct cred *new, const struct cred *old,
 			 cap_combine(old->cap_inheritable, old->cap_permitted)))
 		return 0;
 
-	return check_cap(old, CAP_SETPCAP, CAP_OPT_NONE);
+	return check_cap(old, old->user_ns, CAP_SETPCAP, CAP_OPT_NONE);
 }
 
 /**
@@ -127,8 +138,11 @@ static int hook_capset(struct cred *new, const struct cred *old,
  * @addr: Address of the new mapping.
  *
  * cap_mmap_addr() requires CAP_SYS_RAWIO to map below dac_mmap_min_addr, but
- * calls cap_capable() directly, which skips hook_capable().  Check the same
- * condition against the domain.  commoncap runs first, so this only sees
+ * calls cap_capable() directly, which skips hook_capable().  It checks the
+ * acting task's credentials against init_user_ns because this global limit must
+ * not be bypassed with a capability only held in a nested user namespace.
+ * Mirror the condition, using the same credential for the domain check and both
+ * objects for typed trace context.  commoncap runs first, so this only sees
  * mappings that commoncap allowed.
  *
  * Return: 0 if allowed, -EPERM if CAP_SYS_RAWIO use is denied.
@@ -138,7 +152,8 @@ static int hook_mmap_addr(unsigned long addr)
 	if (addr >= dac_mmap_min_addr)
 		return 0;
 
-	return check_cap(current_cred(), CAP_SYS_RAWIO, CAP_OPT_NONE);
+	return check_cap(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
+			 CAP_OPT_NONE);
 }
 
 /**
@@ -148,10 +163,13 @@ static int hook_mmap_addr(unsigned long addr)
  * @pages: Number of pages being charged (unused).
  *
  * cap_vm_enough_memory() lets CAP_SYS_ADMIN use the vm.admin_reserve_kbytes
- * reserve, but calls cap_capable() directly, which skips hook_capable().  Check
- * the same capability against the domain.  commoncap runs first, so this only
- * sees tasks that commoncap let use the reserve.  Like commoncap, do not log
- * denials: this only selects a memory limit.
+ * reserve, but calls cap_capable() directly, which skips hook_capable().  It
+ * checks the acting task's credentials against init_user_ns because a
+ * capability only held in a nested user namespace must not grant access to the
+ * global reserve.  Mirror the check, using the same credential for the domain
+ * check and both objects for typed trace context.  commoncap runs first, so
+ * this only sees tasks that commoncap let use the reserve.  Like commoncap, do
+ * not log denials: this only selects a memory limit.
  *
  * Return: 0 if the domain does not withhold the reserve, -EPERM if
  * CAP_SYS_ADMIN use is denied.  An error does not fail the allocation by
@@ -159,7 +177,8 @@ static int hook_mmap_addr(unsigned long addr)
  */
 static int hook_vm_enough_memory(struct mm_struct *mm, long pages)
 {
-	return check_cap(current_cred(), CAP_SYS_ADMIN, CAP_OPT_NOAUDIT);
+	return check_cap(current_cred(), &init_user_ns, CAP_SYS_ADMIN,
+			 CAP_OPT_NOAUDIT);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
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


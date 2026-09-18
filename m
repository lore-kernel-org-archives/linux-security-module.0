Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A4521891
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757474; cv=none; b=NXDQVXIulOKzRo65m1/jJOUXJLf8mRnDtF8LQOwoGIYDerbB8IS/cCkyRS3p/0ldms+1psrfY51j9O/ys16o8B9o378oGK2mnt6s5hgpyMJ3rhOUjTOuQDQH5Ewpldi+Hu5H2ZsAzXNAAEV4369TRBwMnqu3rhTg4kiJRtZGZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757474; c=relaxed/simple;
	bh=xzfAiiTmzW0j2DmC51MEGF2N2jNBLSczjuZGmGssuhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ7CDsCTpsmbUT/NlpqvM7ysiN4gP4k2SHG7tPvXu8MsidXUNtN6Rewd77aGfVNMbPvB31+a0qVtOIFhIxR2mu6ACesKUNiwJcQMXpx1p71bZ+XnozQZ6Xq3GgrCixR4dIMCQQrSbMaxGBxFnPEe5g5PK2gBE2NkwSpbMAUDLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rD/wrt++; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rD/wrt++"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXV5hLWznLZ;
	Fri, 18 Sep 2026 20:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757450;
	bh=3ajq33u+nJxuWeqr+A9ufnYytIZ7oqp3sOhyPaZcoFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rD/wrt++BCGxEZgeOyaJ/8nK1ImiPGtO/2uyH9S2w3uOHq71A88bCcteJY3FUvg4O
	 8Cas7YgLBjWOTtG5hPSjlY4Z/3zyPlOisnBHmdfbVcAII4D4CIJdLBrwYVcvtj6Dod
	 R8VmFC8JaWIJFbZjwUlDsbVUZGKWmUdTdh4X2+GU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXV0fcbzk0L;
	Fri, 18 Sep 2026 20:50:50 +0200 (CEST)
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
Subject: [PATCH v1 5/9] landlock: Report the actual ptrace tracer
Date: Fri, 18 Sep 2026 20:50:28 +0200
Message-ID: <20260918185036.608651-6-mic@digikod.net>
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

The ptrace denial callback identifies only the tracee. Current is the
tracer during hook_ptrace_access_check(), but it is the tracee during
PTRACE_TRACEME, where the parent is the actual tracer. A consumer
therefore cannot infer both parties from the existing arguments.

Append the actual tracer task to the typed-BPF callback: current for
hook_ptrace_access_check() and parent for hook_ptrace_traceme(). Carry
it with the tracee domain ID in a private ptrace context. Both hooks
keep the selected tasks alive through synchronous dispatch, so no extra
task reference is needed.

Keep the tracefs record unchanged. The new context is available only to
typed BPF, while same_exec continues to describe the tracer that owns
the denying policy.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: bb91730f16c0 ("landlock: Add tracepoints for ptrace and scope denials")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 11 ++++++++---
 security/landlock/log.h         | 16 ++++++++++++----
 security/landlock/task.c        | 28 +++++++++++++++++-----------
 security/landlock/trace.c       | 20 ++++++++++++++------
 4 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index a982a7cfa881..8c6ebf958d66 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -295,6 +295,8 @@ static inline const char *__trace_landlock_print_layers(
  * the two parties without kernel-internal state.  The ID is a scalar
  * snapshot, not a live domain pointer that could dangle: an optional
  * relational referent is a scalar (0 sentinel), not a nullable pointer.
+ * For ptrace, same_exec instead describes the tracer, even for
+ * PTRACE_TRACEME, and may differ from the current task.
  *
  * Blocker fields
  * ~~~~~~~~~~~~~~
@@ -875,12 +877,14 @@ TRACE_EVENT(landlock_deny_access_net,
  *
  * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
  *             domain field.
- * @same_exec: Whether the current task entered the denying domain itself.
+ * @same_exec: Whether the tracer entered the denying domain itself.
  * @logged: The domain's audit-logging decision for this denial.
  * @tracee_domain_id: The tracee's Landlock domain ID, or 0 if the tracee
  *                    is unsandboxed.
  * @tracee: The target task ptrace acted on (never NULL).  tracee_pid is
  *          the init-namespace TGID (like audit's opid).
+ * @tracer: The tracer or proposed tracer (never NULL); for PTRACE_TRACEME
+ *          this is the parent, not the syscall caller.
  *
  * Emitted when a Landlock domain denies a ptrace operation.
  */
@@ -888,9 +892,10 @@ TRACE_EVENT(landlock_deny_ptrace,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
 		 bool logged, u64 tracee_domain_id,
-		 const struct task_struct *tracee),
+		 const struct task_struct *tracee,
+		 const struct task_struct *tracer),
 
-	TP_ARGS(hierarchy, same_exec, logged, tracee_domain_id, tracee),
+	TP_ARGS(hierarchy, same_exec, logged, tracee_domain_id, tracee, tracer),
 
 	TP_STRUCT__entry(
 		__field(	u64,		domain_id	)
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 4587c2b1566d..821df6f711c6 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -16,6 +16,7 @@
 struct landlock_cred_security;
 struct landlock_hierarchy;
 struct sockaddr;
+struct task_struct;
 
 enum landlock_request_type {
 	LANDLOCK_REQUEST_PTRACE = 1,
@@ -39,6 +40,11 @@ struct landlock_net_trace {
 	u16 socket_family;
 };
 
+struct landlock_ptrace_trace {
+	u64 tracee_domain_id;
+	const struct task_struct *tracer;
+};
+
 #endif /* CONFIG_TRACEPOINTS */
 
 /*
@@ -70,16 +76,18 @@ struct landlock_request {
 
 	union {
 		/*
-		 * Other-party domain ID for a relational (scope/ptrace) denial,
-		 * or 0 if that party is unsandboxed.  Store an ID, not a
-		 * pointer: the other task can replace its credential and free
-		 * the domain it referenced.  Trace-only; audit ignores it.
+		 * Other-party domain ID for a scope denial, or 0 if that party
+		 * is unsandboxed.  Store an ID, not a pointer: the other task
+		 * can replace its credential and free the domain it referenced.
+		 * Audit ignores this trace-only field.
 		 */
 		u64 other_domain_id;
 
 #ifdef CONFIG_TRACEPOINTS
 		/* Synchronous context for a network denial. */
 		const struct landlock_net_trace *trace_net;
+		/* Consumed only by the synchronous trace dispatcher. */
+		const struct landlock_ptrace_trace *trace_ptrace;
 #endif /* CONFIG_TRACEPOINTS */
 	};
 };
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4491ce31ae04..445f6b921a87 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -88,7 +88,9 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
 	const struct landlock_cred_security *parent_subject;
+#ifdef CONFIG_TRACEPOINTS
 	u64 tracee_domain_id = 0;
+#endif /* CONFIG_TRACEPOINTS */
 	int err;
 
 	/* Quick return for non-landlocked tasks. */
@@ -100,10 +102,10 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 		const struct landlock_domain *const child_dom =
 			landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+#ifdef CONFIG_TRACEPOINTS
 		if (child_dom)
 			tracee_domain_id = child_dom->hierarchy->id;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+#endif /* CONFIG_TRACEPOINTS */
 	}
 
 	if (!err)
@@ -121,7 +123,12 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				.u.tsk = child,
 			},
 			.layer_plus_one = parent_subject->domain->num_layers,
-			.other_domain_id = tracee_domain_id,
+#ifdef CONFIG_TRACEPOINTS
+			.trace_ptrace = &(struct landlock_ptrace_trace) {
+				.tracee_domain_id = tracee_domain_id,
+				.tracer = current,
+			},
+#endif /* CONFIG_TRACEPOINTS */
 		});
 
 	return err;
@@ -142,7 +149,6 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 {
 	const struct landlock_cred_security *parent_subject;
 	const struct landlock_domain *child_dom;
-	u64 tracee_domain_id = 0;
 	int err;
 
 	child_dom = landlock_get_current_domain();
@@ -154,12 +160,6 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	if (!err)
 		return 0;
 
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
-	/* The tracee is the current task; its domain is stable here. */
-	if (child_dom)
-		tracee_domain_id = child_dom->hierarchy->id;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
-
 	/*
 	 * For the ptrace_traceme case, we log the domain which is the cause of
 	 * the denial, which means the parent domain instead of the current
@@ -174,7 +174,13 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 			.u.tsk = current,
 		},
 		.layer_plus_one = parent_subject->domain->num_layers,
-		.other_domain_id = tracee_domain_id,
+#ifdef CONFIG_TRACEPOINTS
+		.trace_ptrace = &(struct landlock_ptrace_trace) {
+			/* The current task's domain is stable here. */
+			.tracee_domain_id = child_dom ? child_dom->hierarchy->id : 0,
+			.tracer = parent,
+		},
+#endif /* CONFIG_TRACEPOINTS */
 	});
 	return err;
 }
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 9be86638f905..43091c052f77 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -63,7 +63,7 @@ void landlock_trace_free_domain(const struct landlock_hierarchy *const hierarchy
  * @request: Detail of the user space request.
  * @youngest_denied: The youngest hierarchy node that denied the access.
  * @missing: The final missing access subset, when applicable.
- * @same_exec: Whether the current task is the same executable that called
+ * @same_exec: Whether the policy subject is the same executable that called
  *             landlock_restrict_self() for the denying domain, as computed
  *             by landlock_log_denial().
  * @logged: Whether the domain's policy selects this denial for logging, as
@@ -186,11 +186,19 @@ void landlock_trace_denial(
 		}
 		break;
 	case LANDLOCK_REQUEST_PTRACE:
-		if (trace_landlock_deny_ptrace_enabled())
-			trace_landlock_deny_ptrace(youngest_denied, same_exec,
-						   logged,
-						   request->other_domain_id,
-						   request->audit.u.tsk);
+		if (trace_landlock_deny_ptrace_enabled()) {
+			const struct landlock_ptrace_trace *const trace_ptrace =
+				request->trace_ptrace;
+
+			if (WARN_ON_ONCE(!trace_ptrace ||
+					 !trace_ptrace->tracer))
+				return;
+
+			trace_landlock_deny_ptrace(
+				youngest_denied, same_exec, logged,
+				trace_ptrace->tracee_domain_id,
+				request->audit.u.tsk, trace_ptrace->tracer);
+		}
 		break;
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		if (trace_landlock_deny_scope_signal_enabled())
-- 
2.55.0


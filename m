Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD8521881
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757470; cv=none; b=VSvJbVYX8muIh6agxxPyazL/loVNk7Mch5GFu9lIbYcB2Ph4nefGJjDdWdKMlETPF6/tF8b0O3XAI0SOoo95wGCDc35eQoO16dl3UttUwBkkgChNYvEwP5IjTIX7xrrmR9Ax2y/qLJyKpeEbX8RfhNf/YwhBHc0AvJnTu4QnPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757470; c=relaxed/simple;
	bh=tFKbLggTlvbL5B7qGQezA7fpbfW9xyMXk+u8E73wpcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrsoJWAthPTCYhz/n/+LRAFCsNHiDnoC+LW4tE9uBCvNwnyafWViqmFOymhL8oF93CrPetvkvHSwWY6Px63X4B7QZTYFHoGVmYMu4NaCic/0PtLhJEvsZJmV6KbpJPOamDJP/qIjKJ0NQd39p1nS5BbDlMQZL183avPxSBJEM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JqNdejdK; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JqNdejdK"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXX1D5bzpY4;
	Fri, 18 Sep 2026 20:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757451;
	bh=Bl5Dg13ojEeAEGJaAzBrUo4ASsoLYLJB4EWykQ3NTzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqNdejdK2jzDsVysKPMFevycOQocQYJPVeBGYAhvbSuytMst9Z5I3mZ0/NPedhRNl
	 efczwSKWhpy5sBCGrjdVlgkcfFfpRiqLMKGznOnsBOPoU/KjfXMRJ0Avnb0eMDh1mE
	 NDF3k1O5z9tLoLtgQJUg1k/mmOrS4ecfaSl4sMUg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXW2tsgz3tj;
	Fri, 18 Sep 2026 20:50:51 +0200 (CEST)
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
Subject: [PATCH v1 6/9] landlock: Report the effective signal number
Date: Fri, 18 Sep 2026 20:50:29 +0200
Message-ID: <20260918185036.608651-7-mic@digikod.net>
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

The signal-scope denial callback identifies its target but not the
effective signal. This loses permission-probe signal zero and makes the
file-owner hook's zero sentinel ambiguous.

Append an int signal argument to the typed-BPF callback. Preserve sig,
including zero, in hook_task_kill(). In hook_file_send_sigiotask(),
translate signum zero to SIGIO at the producer, where its meaning is
known.

Carry the effective signal and target domain ID in a private,
stack-backed context consumed synchronously. This requires no allocation
or task reference in the interrupt-capable file-owner path. Gate this
context and the remaining scope-only domain IDs with CONFIG_TRACEPOINTS.

Keep the tracefs record and audit output unchanged.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: bb91730f16c0 ("landlock: Add tracepoints for ptrace and scope denials")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h |  8 +++--
 security/landlock/log.h         | 21 ++++++++----
 security/landlock/task.c        | 59 +++++++++++++++++++++++----------
 security/landlock/trace.c       | 12 +++++--
 4 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 8c6ebf958d66..5da0f12ed2c3 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -928,12 +928,14 @@ TRACE_EVENT(landlock_deny_ptrace,
  *
  * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
  *             domain field.
- * @same_exec: Whether the current task entered the denying domain itself.
+ * @same_exec: Whether the policy subject entered the denying domain itself.
  * @logged: The domain's audit-logging decision for this denial.
  * @target_domain_id: The target's Landlock domain ID, or 0 if the target
  *                    is unsandboxed.
  * @target: The task the signal was aimed at (never NULL).  target_pid is
  *          the init-namespace TGID (like audit's opid).
+ * @signal: The signal selected by the denied check.  Zero is a permission
+ *          probe, not an absent value.
  *
  * Emitted when a Landlock domain denies signal delivery to a scoped-out
  * target.
@@ -942,9 +944,9 @@ TRACE_EVENT(landlock_deny_scope_signal,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
 		 bool logged, u64 target_domain_id,
-		 const struct task_struct *target),
+		 const struct task_struct *target, int signal),
 
-	TP_ARGS(hierarchy, same_exec, logged, target_domain_id, target),
+	TP_ARGS(hierarchy, same_exec, logged, target_domain_id, target, signal),
 
 	TP_STRUCT__entry(
 		__field(	u64,		domain_id	)
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 821df6f711c6..faa30e26e42a 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -45,6 +45,11 @@ struct landlock_ptrace_trace {
 	const struct task_struct *tracer;
 };
 
+struct landlock_signal_trace {
+	u64 target_domain_id;
+	int signal;
+};
+
 #endif /* CONFIG_TRACEPOINTS */
 
 /*
@@ -74,22 +79,24 @@ struct landlock_request {
 	deny_masks_t deny_masks;
 	optional_access_t quiet_optional_accesses;
 
+#ifdef CONFIG_TRACEPOINTS
 	union {
 		/*
-		 * Other-party domain ID for a scope denial, or 0 if that party
-		 * is unsandboxed.  Store an ID, not a pointer: the other task
-		 * can replace its credential and free the domain it referenced.
-		 * Audit ignores this trace-only field.
+		 * Other-party domain ID for an abstract UNIX socket scope
+		 * denial, or 0 if that party is unsandboxed.  Store an ID, not
+		 * a pointer: the other task can replace its credential and free
+		 * the domain it referenced.
 		 */
 		u64 other_domain_id;
 
-#ifdef CONFIG_TRACEPOINTS
 		/* Synchronous context for a network denial. */
 		const struct landlock_net_trace *trace_net;
-		/* Consumed only by the synchronous trace dispatcher. */
+		/* Synchronous context for a ptrace denial. */
 		const struct landlock_ptrace_trace *trace_ptrace;
-#endif /* CONFIG_TRACEPOINTS */
+		/* Synchronous context for a signal denial. */
+		const struct landlock_signal_trace *trace_signal;
 	};
+#endif /* CONFIG_TRACEPOINTS */
 };
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 445f6b921a87..d9eae86fc552 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -256,8 +256,7 @@ static bool domain_is_scoped(const struct landlock_domain *const client,
 }
 
 static bool sock_is_scoped(struct sock *const other,
-			   const struct landlock_domain *const domain,
-			   u64 *const peer_domain_id)
+			   const struct landlock_domain *const domain)
 {
 	const struct landlock_domain *dom_other;
 
@@ -275,13 +274,23 @@ static bool sock_is_scoped(struct sock *const other,
 		return false;
 
 	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
-	*peer_domain_id = dom_other ? dom_other->hierarchy->id : 0;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	return domain_is_scoped(domain, dom_other,
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 }
 
+#ifdef CONFIG_TRACEPOINTS
+
+static u64 get_socket_domain_id(const struct sock *const other)
+{
+	const struct landlock_domain *domain;
+
+	lockdep_assert_held(&unix_sk(other)->lock);
+	domain = landlock_cred(other->sk_socket->file->f_cred)->domain;
+	return domain ? domain->hierarchy->id : 0;
+}
+
+#endif /* CONFIG_TRACEPOINTS */
+
 static bool is_abstract_socket(struct sock *const sock)
 {
 	struct unix_address *addr = unix_sk(sock)->addr;
@@ -305,7 +314,6 @@ static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const newsk)
 {
 	size_t handle_layer;
-	u64 peer_domain_id = 0;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
@@ -317,7 +325,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 	if (!is_abstract_socket(other))
 		return 0;
 
-	if (!sock_is_scoped(other, subject->domain, &peer_domain_id))
+	if (!sock_is_scoped(other, subject->domain))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
@@ -329,7 +337,9 @@ static int hook_unix_stream_connect(struct sock *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-		.other_domain_id = peer_domain_id,
+#ifdef CONFIG_TRACEPOINTS
+		.other_domain_id = get_socket_domain_id(other),
+#endif /* CONFIG_TRACEPOINTS */
 	});
 	return -EPERM;
 }
@@ -338,7 +348,6 @@ static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
 	size_t handle_layer;
-	u64 peer_domain_id = 0;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
@@ -356,7 +365,7 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (!is_abstract_socket(other->sk))
 		return 0;
 
-	if (!sock_is_scoped(other->sk, subject->domain, &peer_domain_id))
+	if (!sock_is_scoped(other->sk, subject->domain))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
@@ -368,7 +377,9 @@ static int hook_unix_may_send(struct socket *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
-		.other_domain_id = peer_domain_id,
+#ifdef CONFIG_TRACEPOINTS
+		.other_domain_id = get_socket_domain_id(other->sk),
+#endif /* CONFIG_TRACEPOINTS */
 	});
 	return -EPERM;
 }
@@ -383,7 +394,9 @@ static int hook_task_kill(struct task_struct *const p,
 {
 	bool is_scoped;
 	size_t handle_layer;
+#ifdef CONFIG_TRACEPOINTS
 	u64 target_domain_id = 0;
+#endif /* CONFIG_TRACEPOINTS */
 	const struct landlock_cred_security *subject;
 
 	if (!cred) {
@@ -415,10 +428,10 @@ static int hook_task_kill(struct task_struct *const p,
 
 		is_scoped = domain_is_scoped(subject->domain, other,
 					     signal_scope.scope);
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+#ifdef CONFIG_TRACEPOINTS
 		if (other)
 			target_domain_id = other->hierarchy->id;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+#endif /* CONFIG_TRACEPOINTS */
 	}
 
 	if (!is_scoped)
@@ -431,7 +444,12 @@ static int hook_task_kill(struct task_struct *const p,
 			.u.tsk = p,
 		},
 		.layer_plus_one = handle_layer + 1,
-		.other_domain_id = target_domain_id,
+#ifdef CONFIG_TRACEPOINTS
+		.trace_signal = &(struct landlock_signal_trace) {
+			.target_domain_id = target_domain_id,
+			.signal = sig,
+		},
+#endif /* CONFIG_TRACEPOINTS */
 	});
 	return -EPERM;
 }
@@ -441,7 +459,9 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 {
 	const struct landlock_cred_security *subject;
 	bool is_scoped = false;
+#ifdef CONFIG_TRACEPOINTS
 	u64 target_domain_id = 0;
+#endif /* CONFIG_TRACEPOINTS */
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
@@ -474,10 +494,10 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 
 		is_scoped = domain_is_scoped(subject->domain, other,
 					     signal_scope.scope);
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+#ifdef CONFIG_TRACEPOINTS
 		if (other)
 			target_domain_id = other->hierarchy->id;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+#endif /* CONFIG_TRACEPOINTS */
 	}
 
 	if (!is_scoped)
@@ -492,7 +512,12 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
-		.other_domain_id = target_domain_id,
+#ifdef CONFIG_TRACEPOINTS
+		.trace_signal = &(struct landlock_signal_trace) {
+			.target_domain_id = target_domain_id,
+			.signal = signum ? signum : SIGIO,
+		},
+#endif /* CONFIG_TRACEPOINTS */
 	});
 	return -EPERM;
 }
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 43091c052f77..225dbf37bab0 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -201,10 +201,18 @@ void landlock_trace_denial(
 		}
 		break;
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
-		if (trace_landlock_deny_scope_signal_enabled())
+		if (trace_landlock_deny_scope_signal_enabled()) {
+			const struct landlock_signal_trace *const trace_signal =
+				request->trace_signal;
+
+			if (WARN_ON_ONCE(!trace_signal))
+				return;
+
 			trace_landlock_deny_scope_signal(
 				youngest_denied, same_exec, logged,
-				request->other_domain_id, request->audit.u.tsk);
+				trace_signal->target_domain_id,
+				request->audit.u.tsk, trace_signal->signal);
+		}
 		break;
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 		if (trace_landlock_deny_scope_abstract_unix_socket_enabled())
-- 
2.55.0


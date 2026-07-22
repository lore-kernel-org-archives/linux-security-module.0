Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055C3859CB
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740367; cv=none; b=Xd+VSJbBv2AfvZtqDvMQvMnnWnFJszr6Fyci9xa0NIx65gwM9dZsLa3H3B0AI2Efd7eb5X6nnDZ0jyRFdtfUiWzZpbmILo8aHY1UM9buA0mgR3iSy5ebOFdnKlrgngV+JaR7WghYlTMbdcS9dzzNW9jeTfB/c9Nk4AZmnvAp7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740367; c=relaxed/simple;
	bh=jIRkz8uf0CJ3NJcw1a1HmqBOr1Ybj/Ji/w2l0H8rB8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeSI+hhM8QA8Mkrf7fsSDUAaZ8tQyAJV+zTiAGj6t3MXY68Ae6w6P2TwkXA/U5s9BhWGHp1QvUl8cNVIRzVlsq083Q0dr63+W419DiFKQYJWRqNP6c+5RNrfX59DAgGkQwFEK84i/d/zhEQ9WJ+u4HtxXt98jiGC7fd24L2nO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=y0WGgIia; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="y0WGgIia"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515s5G2dzqvr;
	Wed, 22 Jul 2026 19:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740353;
	bh=/g00CQICDC9AAYCTu+3daEK1ifudUTnJ6BBgwUCRVrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y0WGgIiarkVLvRN7F3Bz2H1oWT3TDWKplMrAyHaIoSpyCPrt4hKFUb6ROACZHbrvU
	 N9IX4ogzozJ1OfFIlP5H4RwI9LkoMuPofiYFxTyEqsN4hUNMIeRpdZjAaFVU5JLXpU
	 jvLQiHob8m4GOgIPEPErK05stGajvj3tFjhAWJWQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515r4QN5zm8l;
	Wed, 22 Jul 2026 19:12:32 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
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
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 14/20] landlock: Add tracepoints for ptrace and scope denials
Date: Wed, 22 Jul 2026 19:11:46 +0200
Message-ID: <20260722171159.2776765-15-mic@digikod.net>
In-Reply-To: <20260722171159.2776765-1-mic@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Scope and ptrace denials follow a different code path (a domain
hierarchy check) than access-right denials, so they need dedicated
tracepoints with type-specific TP_PROTO arguments.  Complete the denial
coverage with:
- landlock_deny_ptrace: ptrace access denied by a domain hierarchy
  mismatch.
- landlock_deny_scope_signal: signal delivery denied by
  LANDLOCK_SCOPE_SIGNAL.
- landlock_deny_scope_abstract_unix_socket: abstract unix socket access
  denied by LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET.

TP_PROTO passes the raw kernel object (struct task_struct or struct
sock) for eBPF BTF access; the comm and sun_path string fields use
__print_untrusted_str() because they hold untrusted input.  Unlike the
deny_access events, these omit the blockers field: each maps to exactly
one denial type named by the event, so the bitmask would always be zero.
Like the deny_access events they carry same_exec and logged.

Audit logs the task-targeted denials with generic field names (opid,
ocomm), but a strongly typed trace event can use role-prefixed names
(tracee_pid/tracee_comm, target_pid/target_comm) that match the mainline
task-name convention (sched_process_fork's parent_comm/child_comm) and
say whose name each field holds; a bare comm= would collide across
events.  The abstract-unix-socket event reports peer_pid instead, a
tracepoint-only field with no audit counterpart.

A scope or ptrace verdict compares the subject domain against the other
party's domain, so each event also reports that other party's Landlock
domain (tracee_domain=, target_domain=, or peer_domain=); the subject
domain= alone does not let a consumer redo domain_is_scoped() or
domain_ptrace().  It is reported as a scalar ID rather than a domain
pointer: a domain object is immutable, but the other task can replace
its credential and free the domain that credential referenced, so a
stored foreign pointer could dangle before the event is consumed.  The
scalar ID also honors the tracepoint no-nullable-pointer rule, since the
other party is frequently unsandboxed.  Passing the foreign domain
hierarchy object so an eBPF consumer could walk the other party's
ancestry live would lengthen the RCU section on the shared denial path
and needs a deferred refcount put, so it is left as a future
enhancement.  The relational domain-ID field (tracee_domain,
target_domain, or peer_domain) is trace-only and is not added to audit
records, so audit's denial format is unchanged by this series.

Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-13-mic@digikod.net
- Reformatted TRACE_EVENT bodies to the kernel tracing convention with
  one field per line and tab-aligned columns (requested by Steven
  Rostedt).
- Replaced the log_same_exec and log_new_exec fields with the single
  logged boolean, matching the deny_access events.
- Assert unix_state_lock(peer) in the abstract-unix-socket event (held
  by the caller) and document why unix_sk(peer)->addr is stable.
  Document peer_pid as a best-effort READ_ONCE read: its canonical lock
  is sk->sk_peer_lock, not unix_state_lock, but the target peer's
  peercred is not updated concurrently in these hooks, and it is 0 for a
  datagram peer.
- Renamed the deny_ptrace and deny_scope_signal printk label comm= to
  the role-prefixed tracee_comm= and target_comm=, matching each event's
  sibling *_pid field and the sched_process_fork task-name convention;
  label equals field so it works directly as an ftrace filter.
- Record the other party's Landlock domain as a verdict-time scalar ID
  (tracee_domain=/target_domain=/peer_domain=, 0 when unsandboxed) so a
  trace consumer can reproduce a relational scope or ptrace verdict; the
  ID is captured under the RCU read lock or the unix socket lock, and
  audit records are unchanged.
- Turn the request-type switch default in landlock_trace_denial() into a
  WARN_ONCE() canary reporting the offending type, now that this patch
  completes the switch with the ptrace and scope cases (the default is
  unreachable once every request type is handled).

Changes since v1:
- New patch.
---
 include/trace/events/landlock.h | 195 ++++++++++++++++++++++++++++++++
 security/landlock/log.h         |   9 ++
 security/landlock/task.c        |  52 +++++++--
 security/landlock/trace.c       |  22 ++++
 4 files changed, 271 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index e70dcc9a94b9..94de20fbe908 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -13,6 +13,7 @@
 #include <linux/landlock.h>
 #include <linux/trace_seq.h>
 #include <linux/tracepoint.h>
+#include <net/af_unix.h>
 
 struct dentry;
 struct landlock_domain;
@@ -21,6 +22,7 @@ struct landlock_rule;
 struct landlock_ruleset;
 struct path;
 struct sock;
+struct task_struct;
 
 /* Maps a shared _LANDLOCK_*_NAMES entry to a __print_flags() pair. */
 #define _LANDLOCK_NAME_ENTRY(mask, name) { mask, name }
@@ -32,6 +34,18 @@ struct sock;
  * A new tracepoint must uphold them, and an eBPF consumer can rely on
  * them.
  *
+ * Decision context
+ * ~~~~~~~~~~~~~~~~
+ *
+ * A denial event, together with the lifecycle events, exposes the full
+ * set of inputs the verdict consumed, so a consumer that tracked domain
+ * creation (landlock_create_ruleset, landlock_create_domain) can verify
+ * or reproduce the Landlock decision rather than merely observe it
+ * happened.  In who/what/why terms: who is the denying domain (the domain
+ * field, always the subject that enforced the policy, never the current
+ * task), what is the operation and its object, and why is every other
+ * input the verdict weighed.
+ *
  * Lifecycle consistency
  * ~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -100,6 +114,18 @@ struct sock;
  * log flags.  Denial events order their fields as domain, same_exec,
  * logged, then blockers (deny_access events only), then the type-specific
  * object fields, then any variable-length field.
+ *
+ * Relational referents
+ * ~~~~~~~~~~~~~~~~~~~~~
+ *
+ * A scope or ptrace verdict compares two domains, so the other party's
+ * domain is part of the decision context.  It is exposed as a scalar
+ * domain ID (0 when that party is unsandboxed): target_domain (signal),
+ * peer_domain (abstract unix socket), tracee_domain (ptrace).  With both
+ * IDs in the stream, a consumer that tracked domain creation can relate
+ * the two parties without kernel-internal state.  The ID is a scalar
+ * snapshot, not a live domain pointer that could dangle: an optional
+ * relational referent is a scalar (0 sentinel), not a nullable pointer.
  */
 
 #ifdef CREATE_TRACE_POINTS
@@ -705,6 +731,175 @@ TRACE_EVENT(landlock_deny_access_net,
 		__entry->sport, __entry->dport)
 );
 
+/**
+ * landlock_deny_ptrace - Ptrace access denied by a Landlock domain
+ *
+ * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
+ *             domain field.
+ * @same_exec: Whether the current task entered the denying domain itself.
+ * @logged: The domain's audit-logging decision for this denial.
+ * @tracee_domain_id: The tracee's Landlock domain ID, or 0 if the tracee
+ *                    is unsandboxed.
+ * @tracee: The target task ptrace acted on (never NULL).  tracee_pid is
+ *          the init-namespace TGID (like audit's opid).
+ *
+ * Emitted when a Landlock domain denies a ptrace operation.
+ */
+TRACE_EVENT(landlock_deny_ptrace,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 bool logged, u64 tracee_domain_id,
+		 const struct task_struct *tracee),
+
+	TP_ARGS(hierarchy, same_exec, logged, tracee_domain_id, tracee),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	bool,		same_exec	)
+		__field(	bool,		logged		)
+		__field(	__u64,		tracee_domain_id)
+		__field(	pid_t,		tracee_pid	)
+		__string(	tracee_comm,	tracee->comm	)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id	= hierarchy->id;
+		__entry->same_exec	= same_exec;
+		__entry->logged		= logged;
+		__entry->tracee_domain_id = tracee_domain_id;
+		__entry->tracee_pid	= task_tgid_nr((struct task_struct *)tracee);
+		__assign_str(tracee_comm);
+	),
+
+	TP_printk("domain=%llx same_exec=%d logged=%d tracee_domain=%llx tracee_pid=%d tracee_comm=%s",
+		__entry->domain_id, __entry->same_exec, __entry->logged,
+		__entry->tracee_domain_id, __entry->tracee_pid,
+		__print_untrusted_str(tracee_comm))
+);
+
+/**
+ * landlock_deny_scope_signal - Signal delivery denied by
+ *                               LANDLOCK_SCOPE_SIGNAL
+ *
+ * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
+ *             domain field.
+ * @same_exec: Whether the current task entered the denying domain itself.
+ * @logged: The domain's audit-logging decision for this denial.
+ * @target_domain_id: The target's Landlock domain ID, or 0 if the target
+ *                    is unsandboxed.
+ * @target: The task the signal was aimed at (never NULL).  target_pid is
+ *          the init-namespace TGID (like audit's opid).
+ *
+ * Emitted when a Landlock domain denies signal delivery to a scoped-out
+ * target.
+ */
+TRACE_EVENT(landlock_deny_scope_signal,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 bool logged, u64 target_domain_id,
+		 const struct task_struct *target),
+
+	TP_ARGS(hierarchy, same_exec, logged, target_domain_id, target),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	bool,		same_exec	)
+		__field(	bool,		logged		)
+		__field(	__u64,		target_domain_id)
+		__field(	pid_t,		target_pid	)
+		__string(	target_comm,	target->comm	)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id	= hierarchy->id;
+		__entry->same_exec	= same_exec;
+		__entry->logged		= logged;
+		__entry->target_domain_id = target_domain_id;
+		__entry->target_pid	= task_tgid_nr((struct task_struct *)target);
+		__assign_str(target_comm);
+	),
+
+	TP_printk("domain=%llx same_exec=%d logged=%d target_domain=%llx target_pid=%d target_comm=%s",
+		__entry->domain_id, __entry->same_exec, __entry->logged,
+		__entry->target_domain_id, __entry->target_pid,
+		__print_untrusted_str(target_comm))
+);
+
+/**
+ * landlock_deny_scope_abstract_unix_socket - Abstract unix socket access
+ *     denied by LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+ *
+ * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
+ *             domain field.
+ * @same_exec: Whether the current task entered the denying domain itself.
+ * @logged: The domain's audit-logging decision for this denial.
+ * @peer_domain_id: The peer's Landlock domain ID, or 0 if the peer is
+ *                  unsandboxed.
+ * @peer: Peer socket (never NULL).  peer_pid is best-effort: it is 0 for
+ *        a datagram peer (no SO_PEERCRED), so sun_path is the reliable
+ *        peer identifier.
+ *
+ * Emitted when a Landlock domain denies access to a scoped-out abstract
+ * unix socket.
+ */
+TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 bool logged, u64 peer_domain_id, const struct sock *peer),
+
+	TP_ARGS(hierarchy, same_exec, logged, peer_domain_id, peer),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	bool,		same_exec	)
+		__field(	bool,		logged		)
+		__field(	__u64,		peer_domain_id	)
+		__field(	pid_t,		peer_pid	)
+		/*
+		 * Abstract socket names are untrusted binary data from
+		 * user space.  Use __string_len because abstract names
+		 * are not NUL-terminated; their length is determined by
+		 * addr->len.  unix_sk(peer)->addr is stable here because
+		 * the caller (hook_unix_stream_connect or
+		 * hook_unix_may_send) holds unix_state_lock(peer).
+		 */
+		__string_len(	sun_path,
+				unix_sk(peer)->addr ?
+					unix_sk(peer)->addr->name->sun_path + 1 :
+					"",
+				unix_sk(peer)->addr ?
+					unix_sk(peer)->addr->len -
+						offsetof(struct sockaddr_un,
+							 sun_path) - 1 :
+					0)
+	),
+
+	TP_fast_assign(
+		struct pid *peer_pid;
+
+		lockdep_assert_held(&unix_sk(peer)->lock);
+		__entry->domain_id	= hierarchy->id;
+		__entry->same_exec	= same_exec;
+		__entry->logged		= logged;
+		__entry->peer_domain_id	= peer_domain_id;
+		/*
+		 * Best-effort (0 for a datagram peer).  sk_peer_pid is
+		 * canonically guarded by sk->sk_peer_lock, but the target
+		 * peer's peercred is set once and not updated concurrently in
+		 * these hooks, so this READ_ONCE() is safe; sun_path is the
+		 * reliable identifier.
+		 */
+		peer_pid		= READ_ONCE(peer->sk_peer_pid);
+		__entry->peer_pid	= peer_pid ? pid_nr(peer_pid) : 0;
+		__assign_str(sun_path);
+	),
+
+	TP_printk("domain=%llx same_exec=%d logged=%d peer_domain=%llx peer_pid=%d sun_path=%s",
+		__entry->domain_id, __entry->same_exec, __entry->logged,
+		__entry->peer_domain_id, __entry->peer_pid,
+		__print_untrusted_str(sun_path))
+);
+
 #undef _LANDLOCK_NAME_ENTRY
 
 #endif /* _TRACE_LANDLOCK_H */
diff --git a/security/landlock/log.h b/security/landlock/log.h
index 25afc17cf055..e0a6e44f3ddd 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -3,6 +3,7 @@
  * Landlock - Log helpers
  *
  * Copyright © 2023-2025 Microsoft Corporation
+ * Copyright © 2026 Cloudflare, Inc.
  */
 
 #ifndef _SECURITY_LANDLOCK_LOG_H
@@ -50,6 +51,14 @@ struct landlock_request {
 	const access_mask_t all_existing_optional_access;
 	deny_masks_t deny_masks;
 	optional_access_t quiet_optional_accesses;
+
+	/*
+	 * Other-party domain ID for a relational (scope/ptrace) denial, or 0 if
+	 * that party is unsandboxed.  An ID, not a pointer: the other task can
+	 * replace its credential and free the domain it referenced.  Trace path
+	 * only; audit ignores it.
+	 */
+	u64 other_domain_id;
 };
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
diff --git a/security/landlock/task.c b/security/landlock/task.c
index c0da22736ea0..cbc7c1ef33cb 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -88,6 +88,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
 	const struct landlock_cred_security *parent_subject;
+	u64 tracee_domain_id = 0;
 	int err;
 
 	/* Quick return for non-landlocked tasks. */
@@ -99,6 +100,10 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 		const struct landlock_domain *const child_dom =
 			landlock_get_task_domain(child);
 		err = domain_ptrace(parent_subject->domain, child_dom);
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+		if (child_dom)
+			tracee_domain_id = child_dom->hierarchy->id;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 
 	if (!err)
@@ -116,6 +121,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
 				.u.tsk = child,
 			},
 			.layer_plus_one = parent_subject->domain->num_layers,
+			.other_domain_id = tracee_domain_id,
 		});
 
 	return err;
@@ -136,6 +142,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 {
 	const struct landlock_cred_security *parent_subject;
 	const struct landlock_domain *child_dom;
+	u64 tracee_domain_id = 0;
 	int err;
 
 	child_dom = landlock_get_current_domain();
@@ -147,6 +154,12 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 	if (!err)
 		return 0;
 
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	/* The tracee is the current task; its domain is stable here. */
+	if (child_dom)
+		tracee_domain_id = child_dom->hierarchy->id;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
 	/*
 	 * For the ptrace_traceme case, we log the domain which is the cause of
 	 * the denial, which means the parent domain instead of the current
@@ -161,6 +174,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
 			.u.tsk = current,
 		},
 		.layer_plus_one = parent_subject->domain->num_layers,
+		.other_domain_id = tracee_domain_id,
 	});
 	return err;
 }
@@ -236,13 +250,17 @@ static bool domain_is_scoped(const struct landlock_domain *const client,
 }
 
 static bool sock_is_scoped(struct sock *const other,
-			   const struct landlock_domain *const domain)
+			   const struct landlock_domain *const domain,
+			   u64 *const peer_domain_id)
 {
 	const struct landlock_domain *dom_other;
 
 	/* The credentials will not change. */
 	lockdep_assert_held(&unix_sk(other)->lock);
 	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	*peer_domain_id = dom_other ? dom_other->hierarchy->id : 0;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	return domain_is_scoped(domain, dom_other,
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 }
@@ -270,6 +288,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const newsk)
 {
 	size_t handle_layer;
+	u64 peer_domain_id = 0;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
@@ -281,7 +300,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 	if (!is_abstract_socket(other))
 		return 0;
 
-	if (!sock_is_scoped(other, subject->domain))
+	if (!sock_is_scoped(other, subject->domain, &peer_domain_id))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
@@ -293,6 +312,7 @@ static int hook_unix_stream_connect(struct sock *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
+		.other_domain_id = peer_domain_id,
 	});
 	return -EPERM;
 }
@@ -301,6 +321,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
 	size_t handle_layer;
+	u64 peer_domain_id = 0;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), unix_scope,
 						&handle_layer);
@@ -318,7 +339,7 @@ static int hook_unix_may_send(struct socket *const sock,
 	if (!is_abstract_socket(other->sk))
 		return 0;
 
-	if (!sock_is_scoped(other->sk, subject->domain))
+	if (!sock_is_scoped(other->sk, subject->domain, &peer_domain_id))
 		return 0;
 
 	landlock_log_denial(subject, &(struct landlock_request) {
@@ -330,6 +351,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			},
 		},
 		.layer_plus_one = handle_layer + 1,
+		.other_domain_id = peer_domain_id,
 	});
 	return -EPERM;
 }
@@ -344,6 +366,7 @@ static int hook_task_kill(struct task_struct *const p,
 {
 	bool is_scoped;
 	size_t handle_layer;
+	u64 target_domain_id = 0;
 	const struct landlock_cred_security *subject;
 
 	if (!cred) {
@@ -370,9 +393,15 @@ static int hook_task_kill(struct task_struct *const p,
 		return 0;
 
 	scoped_guard(rcu) {
-		is_scoped = domain_is_scoped(subject->domain,
-					     landlock_get_task_domain(p),
+		const struct landlock_domain *const other =
+			landlock_get_task_domain(p);
+
+		is_scoped = domain_is_scoped(subject->domain, other,
 					     signal_scope.scope);
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+		if (other)
+			target_domain_id = other->hierarchy->id;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 
 	if (!is_scoped)
@@ -385,6 +414,7 @@ static int hook_task_kill(struct task_struct *const p,
 			.u.tsk = p,
 		},
 		.layer_plus_one = handle_layer + 1,
+		.other_domain_id = target_domain_id,
 	});
 	return -EPERM;
 }
@@ -394,6 +424,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 {
 	const struct landlock_cred_security *subject;
 	bool is_scoped = false;
+	u64 target_domain_id = 0;
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
@@ -421,9 +452,15 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 		return 0;
 
 	scoped_guard(rcu) {
-		is_scoped = domain_is_scoped(subject->domain,
-					     landlock_get_task_domain(tsk),
+		const struct landlock_domain *const other =
+			landlock_get_task_domain(tsk);
+
+		is_scoped = domain_is_scoped(subject->domain, other,
 					     signal_scope.scope);
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+		if (other)
+			target_domain_id = other->hierarchy->id;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 
 	if (!is_scoped)
@@ -438,6 +475,7 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+		.other_domain_id = target_domain_id,
 	});
 	return -EPERM;
 }
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 4c4229d4ffdf..2ea7aac8d75d 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -157,7 +157,29 @@ void landlock_trace_denial(
 				ntohs(request->audit.u.net->sport),
 				ntohs(request->audit.u.net->dport));
 		break;
+	case LANDLOCK_REQUEST_PTRACE:
+		if (trace_landlock_deny_ptrace_enabled())
+			trace_landlock_deny_ptrace(youngest_denied, same_exec,
+						   logged,
+						   request->other_domain_id,
+						   request->audit.u.tsk);
+		break;
+	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+		if (trace_landlock_deny_scope_signal_enabled())
+			trace_landlock_deny_scope_signal(
+				youngest_denied, same_exec, logged,
+				request->other_domain_id, request->audit.u.tsk);
+		break;
+	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+		if (trace_landlock_deny_scope_abstract_unix_socket_enabled())
+			trace_landlock_deny_scope_abstract_unix_socket(
+				youngest_denied, same_exec, logged,
+				request->other_domain_id,
+				request->audit.u.net->sk);
+		break;
 	default:
+		WARN_ONCE(1, "Unhandled Landlock request type %d",
+			  request->type);
 		break;
 	}
 }
-- 
2.54.0


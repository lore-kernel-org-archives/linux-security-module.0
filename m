Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF947534C
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757472; cv=none; b=SNWvNliWsr/93azAMdGPVHQUJKZnUrpUbeTM7lZlhLkpSjBL3mFE6I/H1l1bw269cFX8PUbH2qULSdNPPTNog0hOeBcnzLM+2dCbOMkY+YSmJXyb8uAQHo4VfES6m47fc2Z6aFdcn0KA3YE9saG/A2AZLb5RNRGaxIg9JLWvX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757472; c=relaxed/simple;
	bh=SJuQ119fR/MtZAzsLqllLBHRELY0hzRcYYdn0Apz25k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKc+1ES78IPy86YPAiwkBGyGVCqpdPa7c9A+ljFBvrlr1bYqOdSZpth2Ar7PKkwBunpvUtSHSqwRITTgIiHXAyvdHoCXef6VDt8JhzQlyaFH4gQBfHlDg2Qlb3BdBsKJnEOiW78pYLBIPhaMNFAMZH+T3Sch/7rYxN5QAk00RVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=GpMWYZ4G; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="GpMWYZ4G"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXc0xddzkc9;
	Fri, 18 Sep 2026 20:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757455;
	bh=5nOOBNlhWFu+FaYs+78FCVFcnHUTd9AUbPuQvZDXmPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpMWYZ4GX30T0LyFlaKh+9udyFy1Yh2uEuZAksJEEP4BzmAfKiuEZGpOkCq9fm2NB
	 hZKm80PxA0E/QEd2k7aJIpf3EiXUAnR2L9AME/hTce5xhGjqGCUXBP9i8Sd2Gv1bAc
	 bthv/LTZEUFQQQjmBoCR3PtbKa3UNRYKO+0L+J+0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXb36d1z855;
	Fri, 18 Sep 2026 20:50:55 +0200 (CEST)
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
Subject: [PATCH v1 9/9] landlock: Fix tracepoint contract documentation
Date: Fri, 18 Sep 2026 20:50:32 +0200
Message-ID: <20260918185036.608651-10-mic@digikod.net>
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

The tracepoint documentation claims that denial and lifecycle events
expose every input needed to reproduce a verdict. Instead document how
denial, ruleset, and domain events identify the denying policy, checked
operation and object, and reason for denial. Direct consumers to generic
tracepoints for additional operational context.

State the reconstruction limits: IDs are boot-local, rule checks have no
request ID, and exported records may be lost or cross-CPU reordered.

Also replace the incorrect BPF_RAW_TRACEPOINT guidance with libbpf
SEC("tp_btf/...") attachment and refer consumers to the event prototypes
for callback argument layouts.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/trace/events-landlock.rst | 30 ++++++++++++---------
 include/trace/events/landlock.h         | 36 ++++++++++++-------------
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index 9bb81a5c676e..304a8d06273e 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -141,10 +141,10 @@ in some field formats:
   treated as untrusted input and escaped in the trace text output so it
   cannot inject field separators or control characters.
 
-- **Other party's domain**: A scope or ptrace denial compares the
-  subject's denying domain (``domain=``, always the enforcing domain and
-  never the current task) with the other party's domain, so these
-  tracepoints also report the other party's domain as a scalar ID:
+- **Other party's domain**: A scope or ptrace denial compares the subject's
+  denying domain (``domain=``), which is the enforcing domain and not
+  necessarily the current task's domain, with the other party's domain.
+  These tracepoints also report the other party's domain as a scalar ID:
   ``tracee_domain=`` (ptrace), ``target_domain=`` (signal), and
   ``peer_domain=`` (abstract unix socket).  It is ``0`` when the other
   party is unsandboxed, and otherwise a domain ID that a consumer resolves
@@ -231,9 +231,10 @@ contribution, not the final decision:
   through another matching rule, or the right is denied and appears in the
   ``blockers=`` field of the corresponding ``deny_access`` event.
 
-To reconstruct the decision for an object, aggregate the ``grants=``
-groups of all ``check_rule`` events emitted for that object during the
-check.
+For an access check that a consumer can delimit, aggregate the ``grants=``
+groups of all matching ``check_rule`` events.  These events do not carry a
+request ID; use their execution context and generic tracepoints to separate
+concurrent or successive checks of the same object.
 
 .. note::
 
@@ -264,9 +265,11 @@ layers, so ``grants=`` has one group per layer::
 eBPF access
 ===========
 
-eBPF programs attached via ``BPF_RAW_TRACEPOINT`` can access the
-tracepoint arguments directly through BTF.  The arguments include both
-standard kernel objects and Landlock-internal objects:
+BTF-enabled raw tracepoint programs attached through libbpf
+``SEC("tp_btf/...")`` sections receive typed callback arguments.  The
+event prototypes in `Event reference`_ document their argument layouts.
+The arguments include both standard kernel objects and Landlock-internal
+objects:
 
 - Standard kernel objects (``struct task_struct``, ``struct sock``,
   ``struct path``, ``struct dentry``) can be used with existing BPF
@@ -277,7 +280,7 @@ standard kernel objects and Landlock-internal objects:
   Internal struct layouts may change between kernel versions; use CO-RE
   for field relocation.
 
-A stateful eBPF program observes the full event stream and maintains
+A stateful eBPF program attached before sandbox construction can maintain
 per-domain state in BPF maps:
 
 1. On ``landlock_create_domain``: record the domain ID and parent (the
@@ -293,7 +296,10 @@ per-domain state in BPF maps:
    final statistics.
 
 This approach requires no kernel modification and no Landlock-specific
-BPF helpers.  The Landlock IDs serve as correlation keys across events.
+BPF helpers.  Landlock IDs serve as correlation keys within one boot.
+Records exported through tracing or BPF buffers can be lost, and records
+from different CPUs are not globally ordered, so consumers must detect and
+reconcile incomplete state.
 
 Audit filtering equivalence
 ===========================
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 5da0f12ed2c3..523ba5ea9870 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -206,22 +206,22 @@ static inline const char *__trace_landlock_print_layers(
  * Decision context
  * ~~~~~~~~~~~~~~~~
  *
- * A denial event, together with the lifecycle events, exposes the full
- * set of inputs the verdict consumed, so a consumer that tracked domain
- * creation (landlock_create_ruleset, landlock_create_domain) can verify
- * or reproduce the Landlock decision rather than merely observe it
- * happened.  In who/what/why terms: who is the denying domain (the domain
- * field, always the subject that enforced the policy, never the current
- * task), what is the operation and its object, and why is every other
- * input the verdict weighed.
+ * A denial event identifies the domain whose policy denied the request, the
+ * Landlock operation and policy object that were checked, and the blocker or
+ * domain relationship responsible for the denial.  When tracing starts with
+ * sandbox construction, ruleset and domain events provide the policy history
+ * needed to interpret these identifiers.  The denying domain is the subject
+ * that enforced the policy, not necessarily current.  Generic tracepoints can
+ * provide additional operational context.
  *
  * Lifecycle consistency
  * ~~~~~~~~~~~~~~~~~~~~~~
  *
- * Lifecycle events are balanced: a creation event always has a matching
- * deallocation event and vice versa, so an eBPF program can model object
- * lifetimes from the trace stream without reconciliation logic.  A creation
- * event fires while the object is still private to the calling thread
+ * Lifecycle emission is balanced: a creation event always has a matching
+ * deallocation event and vice versa.  A consumer that observes an object's
+ * complete lifetime can model it from this pair; one that attaches late or
+ * loses exported records must reconcile incomplete state.  A creation event
+ * fires while the object is still private to the calling thread
  * (landlock_create_ruleset fires before the ruleset's file descriptor is
  * installed, so it cannot race a concurrent :manpage:`close(2)`); if fd
  * installation later fails and the ruleset is freed, free_ruleset still
@@ -295,7 +295,8 @@ static inline const char *__trace_landlock_print_layers(
  * the two parties without kernel-internal state.  The ID is a scalar
  * snapshot, not a live domain pointer that could dangle: an optional
  * relational referent is a scalar (0 sentinel), not a nullable pointer.
- * For ptrace, same_exec instead describes the tracer, even for
+ * Nonzero IDs are unique within one boot.  For ptrace, same_exec instead
+ * describes the tracer, even for
  * PTRACE_TRACEME, and may differ from the current task.
  *
  * Blocker fields
@@ -1031,11 +1032,10 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 		__entry->logged		= logged;
 		__entry->peer_domain_id	= peer_domain_id;
 		/*
-		 * Best-effort (0 for a datagram peer).  sk_peer_pid is
-		 * canonically guarded by sk->sk_peer_lock, but the target
-		 * peer's peercred is set once and not updated concurrently in
-		 * these hooks, so this READ_ONCE() is safe; sun_path is the
-		 * reliable identifier.
+		 * Best-effort (0 for a datagram peer).  The caller holds the
+		 * peer's AF_UNIX state lock, serializing published peercred
+		 * updates.  The peer socket keeps a reference to sk_peer_pid
+		 * through pid_nr(); sun_path is the reliable identifier.
 		 */
 		peer_pid		= READ_ONCE(peer->sk_peer_pid);
 		__entry->peer_pid	= peer_pid ? pid_nr(peer_pid) : 0;
-- 
2.55.0


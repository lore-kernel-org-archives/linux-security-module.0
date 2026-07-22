Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2042124D
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740360; cv=none; b=Gu7MqZTsklDrJiG2Zdoo5LYgaLEBgLpDnw/z7360aMpqKIU+WnaYiUWNo/2EErMEObcbb/Wald0OIKCN2hUlZ3OjVAQr+MveJVR6vf9ALI2krKBophg/9QzDOXmQo3jYhoLYeszqO6eIDXOVoF9hFMl4uSmLx28qRx934eQ13Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740360; c=relaxed/simple;
	bh=hcENSTUMN/Qzh+rOwWEcgYttZLA/eeFeO1gVhKYM1BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg8jeJOQQ9GUeWpo3GG3t2JELn6O83qtVxBHC0/W8xNr2aG+u2N0/bV7TI/dR8utgB4X43OVYXItw/LI9YiUEHRqKEeIUfdxudptdoMU4EmKOwj26LdGn9ZJKSJ880l+g7sJiO+6oXSizGoxSG5OVXdoPyRSXE5odBSKByQ/iAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RTbgstG2; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RTbgstG2"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515l4Xwtz118q;
	Wed, 22 Jul 2026 19:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740347;
	bh=L5VUdJ0xqo1isH8Yzi2QfnZNe6dWWrV6N0a+jdMv6Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTbgstG2xYCFuXqeMGCwU7KZnGmpISfx/BvktpBZxIN4MEvtWcCKMQPwGfWhqsIt0
	 dbLOS68tisiqxuil8YdSJ3k6VW5nQ4vYF66SHaS6N0pFEWygyPmlAXFmV2VCWh/sCA
	 lzf3PoTbCEDQ9PEsu+n/DIyFCmauH0wohz6SPlSU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515k3sF8zwJH;
	Wed, 22 Jul 2026 19:12:26 +0200 (CEST)
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
Subject: [PATCH v3 10/20] landlock: Add create_domain and free_domain tracepoints
Date: Wed, 22 Jul 2026 19:11:42 +0200
Message-ID: <20260722171159.2776765-11-mic@digikod.net>
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

Add a landlock_create_domain tracepoint emitted from
landlock_restrict_self() after the new domain is created, so a consumer
can correlate the source ruleset with the resulting domain.  The
flags-only path (ruleset_fd == -1) creates no domain and emits no event.

Move the ruleset lock acquisition from landlock_merge_ruleset() to the
caller so the lock is held across both the merge and the tracepoint
emission, giving an eBPF program a consistent ruleset snapshot.  Release
it before the thread-sync: holding ruleset->lock across
landlock_restrict_sibling_threads() would deadlock a sibling blocked on
the same lock.  The event therefore fires before the (rare) thread-sync
failure path; when that path aborts the just-created domain, the
matching free_domain event fires so the create/free pair stays balanced.

Add a landlock_free_domain tracepoint that fires when a domain's
hierarchy node is freed.  The hierarchy node is the lifecycle boundary
because it represents the domain's identity and outlives the domain's
access masks, which may still be active in descendant domains.

A domain freed without ever being committed to a credential was never
visible to user space, so free_domain is suppressed for it.  This is
tracked by a new landlock_log_status value, LANDLOCK_LOG_UNCOMMITTED,
which is also the zero value so a hierarchy whose initialization failed
defaults to not observable.  A hierarchy is born UNCOMMITTED and is
promoted to LANDLOCK_LOG_PENDING (or LANDLOCK_LOG_DISABLED when logging
is off) right after its create_domain event fires; a thread-sync failure
does not reset it, so an aborted domain that already emitted
create_domain still emits the matching free_domain.  Promoting right
after the event, rather than at commit_creds() time, avoids a race: on a
successful thread-sync the sibling threads commit the new domain in
lockstep before landlock_restrict_self() returns, so the shared domain
may already have moved to LANDLOCK_LOG_RECORDED through a plain store,
and a late promotion would race that store and could unbalance the
domain allocation and deallocation audit records.

Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-9-mic@digikod.net
- Renamed the landlock_restrict_self tracepoint to
  landlock_create_domain and reordered its arguments to (domain,
  ruleset) for domain-first consistency with the other
  domain-lifecycle events.
- Reformat the TRACE_EVENT body (TP_PROTO, TP_STRUCT__entry,
  TP_fast_assign, TP_printk) to the kernel tracing convention with one
  field per line and tab-aligned columns (requested by Steven Rostedt).
- Emit the create_domain creation event under the ruleset lock, just
  after the merge and before the thread-sync wait, so an observer reads
  the exact ruleset frozen into the domain and the lock is not held
  across thread-sync (where a sibling blocked in landlock_add_rule() on
  the same lock would stall it).
- Gate free_domain on a new LANDLOCK_LOG_UNCOMMITTED status so a domain
  freed before its creation event fired emits no free_domain;
  create_domain marks the domain committed right after emitting the
  event, so a later thread-sync failure still emits the matching
  free_domain and the create/free pair stays balanced.
- Emit free_domain from landlock_trace_free_domain() in a dedicated
  tracing translation unit, and move the decoupling of the log state and
  landlock_log_free_domain() from CONFIG_AUDIT to the commit that
  separates the common log framework from audit.
- Clarify in the create_domain emission comment that the event fires
  before the infallible commit_creds().
- Clarify the free_domain kdoc: the event fires when the hierarchy
  node's refcount reaches zero, after all child domains release their
  parent reference (the earlier "all descendants freed" phrasing could
  be misread).

Changes since v1:
- New patch.
---
 include/trace/events/landlock.h | 82 +++++++++++++++++++++++++++++++++
 security/landlock/domain.c      | 28 ++++++-----
 security/landlock/domain.h      | 16 ++++++-
 security/landlock/log.c         |  6 ++-
 security/landlock/syscalls.c    | 45 +++++++++++++++++-
 security/landlock/trace.c       | 31 ++++++++++++-
 security/landlock/trace.h       | 28 +++++++++++
 7 files changed, 219 insertions(+), 17 deletions(-)
 create mode 100644 security/landlock/trace.h

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 69a75cf47f65..cb0e21a2fa1f 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -13,6 +13,8 @@
 #include <linux/landlock.h>
 #include <linux/tracepoint.h>
 
+struct landlock_domain;
+struct landlock_hierarchy;
 struct landlock_ruleset;
 struct path;
 
@@ -240,6 +242,86 @@ TRACE_EVENT(landlock_add_rule_net,
 		__entry->port)
 );
 
+/**
+ * landlock_create_domain - New domain created
+ *
+ * @domain: Newly created domain (never NULL, immutable after creation).
+ *          @domain->hierarchy->id is its unique ID, shared with the
+ *          landlock_enforce_domain and landlock_free_domain events;
+ *          @domain->hierarchy->details holds the requesting process.
+ * @ruleset: Source ruleset frozen into the domain (never NULL).  The
+ *           ruleset lock is held across the emission, so a BPF program
+ *           reading it via BTF sees the exact merged ruleset;
+ *           @ruleset->id / @ruleset->version identify it.
+ *
+ * Emitted by sys_landlock_restrict_self() once, in the requesting
+ * thread's context, right after the merge and before thread-sync.  The
+ * flags-only path (ruleset_fd == -1) creates no domain and does not
+ * emit this event.  Paired with the per-thread landlock_enforce_domain
+ * (join on @domain->hierarchy->id) and balanced by a matching
+ * landlock_free_domain event.
+ */
+TRACE_EVENT(landlock_create_domain,
+
+	TP_PROTO(const struct landlock_domain *domain,
+		 const struct landlock_ruleset *ruleset),
+
+	TP_ARGS(domain, ruleset),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	__u64,		parent_id	)
+		__field(	__u64,		ruleset_id	)
+		__field(	__u32,		ruleset_version	)
+	),
+
+	TP_fast_assign(
+		lockdep_assert_held(&ruleset->lock);
+		__entry->domain_id	= domain->hierarchy->id;
+		__entry->parent_id	= domain->hierarchy->parent ?
+					  domain->hierarchy->parent->id : 0;
+		__entry->ruleset_id	= ruleset->id;
+		__entry->ruleset_version = ruleset->version;
+	),
+
+	TP_printk("domain=%llx parent=%llx ruleset=%llx.%u",
+		__entry->domain_id, __entry->parent_id,
+		__entry->ruleset_id, __entry->ruleset_version)
+);
+
+/**
+ * landlock_free_domain - Domain freed
+ *
+ * @hierarchy: Hierarchy node being freed (never NULL).
+ *
+ * Emitted when the hierarchy node's last reference is dropped: its
+ * refcount reaches zero after all child domains have released their
+ * parent reference.  A committed domain is
+ * freed from a kworker via landlock_put_domain_deferred() (the credential
+ * free path runs in RCU context, where sleeping is forbidden), so the
+ * current task is not the sandboxed task that triggered the free.  Balanced
+ * by a matching landlock_create_domain event.
+ */
+TRACE_EVENT(landlock_free_domain,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy),
+
+	TP_ARGS(hierarchy),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	__u64,		denials		)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id	= hierarchy->id;
+		__entry->denials	= atomic64_read(&hierarchy->num_denials);
+	),
+
+	TP_printk("domain=%llx denials=%llu",
+		__entry->domain_id, __entry->denials)
+);
+
 #undef _LANDLOCK_NAME_ENTRY
 
 #endif /* _TRACE_LANDLOCK_H */
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 6444cf27bda2..082c4da68536 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -309,31 +309,28 @@ static int merge_ruleset(struct landlock_domain *const dst,
 	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
 		return -EINVAL;
 
-	mutex_lock(&src->lock);
+	lockdep_assert_held(&src->lock);
 
 	/* Stacks the new layer. */
-	if (WARN_ON_ONCE(dst->num_layers < 1)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	if (WARN_ON_ONCE(dst->num_layers < 1))
+		return -EINVAL;
+
 	dst->handled_masks[dst->num_layers - 1] =
 		landlock_upgrade_handled_access_masks(src->handled_masks);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
 	if (err)
-		goto out_unlock;
+		return err;
 
 #if IS_ENABLED(CONFIG_INET)
 	/* Merges the @src network port tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_NET_PORT);
 	if (err)
-		goto out_unlock;
+		return err;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
-out_unlock:
-	mutex_unlock(&src->lock);
-	return err;
+	return 0;
 }
 
 static int inherit_tree(struct landlock_domain *const parent,
@@ -415,6 +412,8 @@ static int inherit_ruleset(struct landlock_domain *const parent,
  * The current task is requesting to be restricted.  The subjective credentials
  * must not be in an overridden state. cf. landlock_init_hierarchy_log().
  *
+ * The caller must hold @ruleset->lock.
+ *
  * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR() on
  * failure.  If @parent is NULL, the new domain duplicates @ruleset.
  */
@@ -427,6 +426,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 	int err;
 
 	might_sleep();
+	lockdep_assert_held(&ruleset->lock);
 	if (WARN_ON_ONCE(!ruleset))
 		return ERR_PTR(-EINVAL);
 
@@ -575,7 +575,13 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 
 	hierarchy->details = details;
 	hierarchy->id = landlock_get_id_range(1);
-	hierarchy->log_status = LANDLOCK_LOG_PENDING;
+	/*
+	 * The hierarchy is born unobservable: landlock_restrict_self() moves it
+	 * out of LANDLOCK_LOG_UNCOMMITTED once it has emitted the creation
+	 * event, so the matching free_domain event fires for it and not for a
+	 * hierarchy whose creation was never observed.
+	 */
+	hierarchy->log_status = LANDLOCK_LOG_UNCOMMITTED;
 	hierarchy->log_same_exec = true;
 	hierarchy->log_new_exec = false;
 	atomic64_set(&hierarchy->num_denials, 0);
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 1237e3e25240..8351e22016fe 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -25,7 +25,21 @@
 #include "ruleset.h"
 
 enum landlock_log_status {
-	LANDLOCK_LOG_PENDING = 0,
+	/*
+	 * Hierarchy whose creation event has not been emitted, so it is not yet
+	 * observable from user space.  A hierarchy is born in this state (the
+	 * zero value, so a partially initialized hierarchy defaults to "not
+	 * observable") and leaves it when landlock_restrict_self() emits its
+	 * creation event, right after the merge and before the thread-sync
+	 * wait.  No trace free_domain event (and no audit deallocation record)
+	 * fires while a hierarchy is in this state, so a hierarchy that never
+	 * became observable (e.g. its initialization failed) is freed silently.
+	 * A domain aborted by a thread-sync failure already emitted its
+	 * creation event, so it is no longer UNCOMMITTED and does fire
+	 * free_domain.
+	 */
+	LANDLOCK_LOG_UNCOMMITTED = 0,
+	LANDLOCK_LOG_PENDING,
 	LANDLOCK_LOG_RECORDED,
 	LANDLOCK_LOG_DISABLED,
 };
diff --git a/security/landlock/log.c b/security/landlock/log.c
index f42e6dc4de5c..13033808bdbd 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -17,6 +17,7 @@
 #include "limits.h"
 #include "log.h"
 #include "ruleset.h"
+#include "trace.h"
 
 static struct landlock_hierarchy *
 get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
@@ -550,14 +551,15 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
  *
  * @hierarchy: The domain's hierarchy being deallocated.
  *
- * Called in a work queue scheduled by landlock_put_domain_deferred() called by
- * hook_cred_free().
+ * Called from landlock_put_domain_deferred() (via a work queue scheduled by
+ * hook_cred_free()) or directly from landlock_put_domain().
  */
 void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
 {
 	if (WARN_ON_ONCE(!hierarchy))
 		return;
 
+	landlock_trace_free_domain(hierarchy);
 	landlock_audit_free_domain(hierarchy);
 }
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index dbc4facf00b6..7a1ec140cf14 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -536,6 +536,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
 {
 	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
+	struct landlock_domain *new_dom = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
@@ -604,18 +605,50 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		 * manipulating the current credentials because they are
 		 * dedicated per thread.
 		 */
-		struct landlock_domain *const new_dom =
-			landlock_merge_ruleset(new_llcred->domain, ruleset);
+		mutex_lock(&ruleset->lock);
+		new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
 		if (IS_ERR(new_dom)) {
+			mutex_unlock(&ruleset->lock);
 			abort_creds(new_cred);
 			return PTR_ERR(new_dom);
 		}
+		/*
+		 * Emits the domain-creation event while @ruleset->lock is still
+		 * held, right after the merge, so an eBPF program attached to
+		 * the tracepoint reads the exact ruleset that was merged into
+		 * the domain: a consistent snapshot that a concurrent
+		 * landlock_add_rule() (which holds the same lock) cannot
+		 * modify.
+		 *
+		 * This must come before the thread-sync wait below.  Holding
+		 * @ruleset->lock across landlock_restrict_sibling_threads()
+		 * would hang: a sibling thread blocked in landlock_add_rule()
+		 * on the same @ruleset->lock cannot run the task_work that
+		 * thread-sync waits for (the lock wait is uninterruptible).
+		 * Emitting here keeps the lock off the thread-sync path.
+		 *
+		 * The trade-off is that the event fires for a domain that a
+		 * later (rare) thread-sync failure aborts.  That path emits the
+		 * matching free_domain event so the create/free pair stays
+		 * balanced (see the thread-sync error path below).
+		 */
+		trace_landlock_create_domain(new_dom, ruleset);
+		mutex_unlock(&ruleset->lock);
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		new_dom->hierarchy->log_same_exec = log_same_exec;
 		new_dom->hierarchy->log_new_exec = log_new_exec;
+		/*
+		 * The creation event fired above, so move the domain out of
+		 * LANDLOCK_LOG_UNCOMMITTED: its free_domain event must fire
+		 * too, even if a thread-sync failure aborts it below.  Audit
+		 * logging may still be disabled (DISABLED); tracing observes it
+		 * anyway.
+		 */
 		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
 			new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
+		else
+			new_dom->hierarchy->log_status = LANDLOCK_LOG_PENDING;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 		/* Replaces the old (prepared) domain. */
@@ -631,6 +664,14 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		const int err = landlock_restrict_sibling_threads(
 			current_cred(), new_cred);
 		if (err) {
+			/*
+			 * Thread-sync failed (rare), so the new domain is
+			 * aborted instead of committed.  Its creation event
+			 * already fired above, so the imminent free must emit
+			 * the matching free_domain event to keep the
+			 * create/free pair balanced; no special log_status is
+			 * set here.
+			 */
 			abort_creds(new_cred);
 			return err;
 		}
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index aeb6eeebe42a..5e6df313c7d2 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -6,12 +6,41 @@
  * Copyright © 2026 Cloudflare, Inc.
  */
 
+#include "trace.h"
+#include "domain.h"
 #include "ruleset.h"
 
 /*
  * Generates the tracepoint definitions in this translation unit.  The trace
  * event header dereferences the traced objects in TP_fast_assign, so the full
- * struct definitions (e.g. ruleset.h) must be included before it.
+ * struct definitions (e.g. ruleset.h, domain.h) must be included before it.
  */
 #define CREATE_TRACE_POINTS
 #include <trace/events/landlock.h>
+
+/**
+ * landlock_trace_free_domain - Emit a tracepoint on domain deallocation
+ *
+ * @hierarchy: The domain's hierarchy being deallocated.
+ *
+ * Fires only for a hierarchy whose creation event was emitted, i.e. one that
+ * left LANDLOCK_LOG_UNCOMMITTED in landlock_restrict_self().  This keeps the
+ * create/free pair balanced: a hierarchy that never became observable is freed
+ * silently, while a domain that landlock_restrict_self() created and a
+ * thread-sync failure then aborted still fires free_domain, because its
+ * creation event already fired.
+ *
+ * Called from landlock_log_free_domain().
+ */
+void landlock_trace_free_domain(const struct landlock_hierarchy *const hierarchy)
+{
+	/*
+	 * The log_status read is a correctness guard (keep the create/free pair
+	 * balanced), not a cost guard, so this cold path needs no
+	 * trace_..._enabled() check: the tracepoint is a static-branch no-op
+	 * when disabled.  The denial path guards trace_..._enabled() instead
+	 * because it does expensive __getname()/path work before emitting.
+	 */
+	if (READ_ONCE(hierarchy->log_status) != LANDLOCK_LOG_UNCOMMITTED)
+		trace_landlock_free_domain(hierarchy);
+}
diff --git a/security/landlock/trace.h b/security/landlock/trace.h
new file mode 100644
index 000000000000..59c8ea348625
--- /dev/null
+++ b/security/landlock/trace.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Tracepoint helpers
+ *
+ * Copyright © 2025 Microsoft Corporation
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#ifndef _SECURITY_LANDLOCK_TRACE_H
+#define _SECURITY_LANDLOCK_TRACE_H
+
+struct landlock_hierarchy;
+
+#ifdef CONFIG_TRACEPOINTS
+
+void landlock_trace_free_domain(
+	const struct landlock_hierarchy *const hierarchy);
+
+#else /* CONFIG_TRACEPOINTS */
+
+static inline void
+landlock_trace_free_domain(const struct landlock_hierarchy *const hierarchy)
+{
+}
+
+#endif /* CONFIG_TRACEPOINTS */
+
+#endif /* _SECURITY_LANDLOCK_TRACE_H */
-- 
2.54.0


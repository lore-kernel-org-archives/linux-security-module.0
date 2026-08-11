Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777E41F349
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441455; cv=none; b=P5+a/p4Li42N2ZiKspfPat3qwt4Cy7rc+zw0eS/DJG4W+mJHrKPEnGkE9wbVUMFIWlJgwqa5WHs/b0pHehPXekbv+WC0ySlDHLuP7YjgNxJ90xaulU1mMlUWzAnu5+s3CjSjQ+wWZhKJ3RFv4Tt7+ot6Vd90IcW8toP9N5COuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441455; c=relaxed/simple;
	bh=kLqHSHrBqou5E0860a5PfzdR5XbbXMWKhJvQ2wZLMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsMmJ88BL9N/6jy/nz/+DSgFRTWljwbR7OtaeHW/l9RErXS1cdvb806UgxEhUCdPnNajQ+iHEBWg7DrrggfbPxx80pWKHvrC/HDHkzzyBfXHZYEAExPoWqsnYWMslk7gqhfb3Usl6GpIsvSQHU37UtE9BM/zzuy1wXmxHq5QVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TL50zToc; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TL50zToc"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK6C90bQKzCVZ;
	Tue, 11 Aug 2026 11:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786441444;
	bh=ncMwcN5p33PdM1URvZzQ3n41peLKTOh0s0DZMahOZc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TL50zToc4RQP5vqUJr+HVROaJ8ugCB5yojbkiJAjApHedsoYX3VLgC1cLLNsZHZRz
	 h5nfa1IBXB6hOsv9Q04dhuDw1AvmfMN1ZBZR/+YCjCNZuTPsEmg6wscZ/pluTpiBu7
	 wEM06UOgcsE1S9UqdtUkzmXpRTgjUeHQQcPPTt8g=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK6C73SnBzPst;
	Tue, 11 Aug 2026 11:44:03 +0200 (CEST)
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
Subject: [PATCH v4 10/19] landlock: Add landlock_enforce_domain tracepoint
Date: Tue, 11 Aug 2026 11:43:24 +0200
Message-ID: <20260811094338.288094-11-mic@digikod.net>
In-Reply-To: <20260811094338.288094-1-mic@digikod.net>
References: <20260811094338.288094-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The landlock_create_domain event records that a domain was created,
once, before thread-sync.  It cannot tell which threads end up enforcing
it: a successful landlock_restrict_self(2) with
LANDLOCK_RESTRICT_SELF_TSYNC applies the domain to the caller and every
eligible sibling.  Creation (the operation) and enforcement (the
per-thread outcome) are distinct.

Add landlock_enforce_domain(domain, complete, process_wide), emitted
once per thread the domain is applied to, strictly after that thread's
commit_creds(), so it fires only for a thread that is enforcing the
domain, never speculatively; an aborted operation emits none.  The
lifecycle now reads create -> enforce* -> free.

The two booleans name properties, not the implementation:
- complete: marks the single event that concludes the operation.  It
  names the outcome, the set is now enforced, not which thread
  finishes, which the contract leaves unspecified.
- process_wide: means every eligible thread of the process is
  covered.  It is set race-free by either establishing path,
  thread-sync or a single-threaded process, so
  complete && process_wide is the whole-process-enforced guarantee.

The requesting thread and source ruleset are not repeated here: they are
on create_domain (joined via domain->hierarchy->id) and on the immutable
domain->hierarchy->details.  Source ruleset means the ruleset_id and
ruleset_version recorded on create_domain, not the ruleset object, which
the caller may close before enforcement.

Cc: Günther Noack <gnoack@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260722171159.2776765-12-mic@digikod.net
- Rebased onto landlock-next: emit the enforce_domain tracepoint
  alongside the new LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS handling in
  landlock_restrict_self().
- Add a no_new_privs field to landlock_enforce_domain recording the
  thread's no_new_privs state (task_no_new_privs() at emission, for
  both the caller and TSYNC-swept siblings), so consumers see whether
  the domain is backed by no_new_privs or by CAP_SYS_ADMIN.  The raw
  restrict_self flags stay unexposed here (readable via the
  syscall-entry tracepoint).

Changes since v2:
- New patch.
---
 include/trace/events/landlock.h | 60 +++++++++++++++++++++++++++++++++
 security/landlock/syscalls.c    | 14 +++++++-
 security/landlock/tsync.c       | 16 +++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 9f0d0436a8bb..43bf126eb449 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -339,6 +339,66 @@ TRACE_EVENT(landlock_create_domain,
 		__entry->ruleset_id, __entry->ruleset_version)
 );
 
+/**
+ * landlock_enforce_domain - Domain enforced on a thread
+ *
+ * @domain: Domain now enforced on the current thread (never NULL,
+ *          immutable; read locklessly).  Correlate to
+ *          landlock_create_domain via @domain->hierarchy->id for the
+ *          source ruleset and requesting thread, or read
+ *          @domain->hierarchy->details for the requesting process.
+ * @complete: Set on the single event that concludes the operation, after
+ *            all its other enforcements; filter on it for one event per
+ *            operation.
+ * @process_wide: The enforcement covers every eligible (non-exiting)
+ *                thread of the process: set when the caller used
+ *                %LANDLOCK_RESTRICT_SELF_TSYNC or the process is
+ *                single-threaded.  A lone thread whose group still
+ *                holds a zombie leader is not counted single-threaded,
+ *                so process_wide == 0 never proves the opposite.
+ * @no_new_privs: The enforcing thread's no_new_privs state at
+ *                enforcement time: 1 if set (by a prior
+ *                :manpage:`prctl(2)` %PR_SET_NO_NEW_PRIVS or by
+ *                %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS), 0 if the domain
+ *                was enforced with %CAP_SYS_ADMIN instead.
+ *
+ * Emitted for each thread sys_landlock_restrict_self() enforces the
+ * domain on, in that thread's own context, right after its
+ * commit_creds(), so it fires only once the thread is irreversibly
+ * enforcing the domain (aborted operations emit none).  Not
+ * balanced; every enforcement falls between the domain's
+ * landlock_create_domain and landlock_free_domain events.
+ *
+ * @complete == 1 && @process_wide == 1 means the whole process is
+ * sandboxed by @domain, durably (Landlock domains are monotonic and
+ * inherited on :manpage:`clone(2)`).
+ */
+TRACE_EVENT(landlock_enforce_domain,
+
+	TP_PROTO(const struct landlock_domain *domain, bool complete,
+		 bool process_wide, bool no_new_privs),
+
+	TP_ARGS(domain, complete, process_wide, no_new_privs),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		domain_id	)
+		__field(	bool,		complete	)
+		__field(	bool,		process_wide	)
+		__field(	bool,		no_new_privs	)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id	= domain->hierarchy->id;
+		__entry->complete	= complete;
+		__entry->process_wide	= process_wide;
+		__entry->no_new_privs	= no_new_privs;
+	),
+
+	TP_printk("domain=%llx complete=%d process_wide=%d no_new_privs=%d",
+		__entry->domain_id, __entry->complete, __entry->process_wide,
+		__entry->no_new_privs)
+);
+
 /**
  * landlock_free_domain - Domain freed
  *
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index ba4193673c70..1d02d57f4c48 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -22,6 +22,7 @@
 #include <linux/mount.h>
 #include <linux/path.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/security.h>
 #include <linux/stddef.h>
 #include <linux/syscalls.h>
@@ -546,6 +547,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct landlock_domain *new_dom = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
+	bool process_wide;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
 		prev_log_subdomains;
 
@@ -690,5 +692,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS)
 		task_set_no_new_privs(current);
 
-	return commit_creds(new_cred);
+	/* Whole process: thread-sync swept siblings, or single-threaded. */
+	process_wide = (flags & LANDLOCK_RESTRICT_SELF_TSYNC) ||
+		       get_nr_threads(current) == 1;
+	commit_creds(new_cred);
+
+	/* The caller commits last, so its event concludes the operation. */
+	if (ruleset)
+		trace_landlock_enforce_domain(new_dom, true, process_wide,
+					      task_no_new_privs(current));
+
+	return 0;
 }
diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 0b71e158c3f5..cfa73a2a67ca 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -22,6 +22,8 @@
 #include "cred.h"
 #include "tsync.h"
 
+#include <trace/events/landlock.h>
+
 /*
  * Shared state between multiple threads which are enforcing Landlock rulesets
  * in lockstep with each other.
@@ -79,6 +81,8 @@ struct tsync_work {
  */
 static void restrict_one_thread(struct tsync_shared_context *ctx)
 {
+	const struct landlock_domain *new_dom =
+		landlock_cred(ctx->new_cred)->domain;
 	int err;
 	struct cred *cred = NULL;
 
@@ -147,6 +151,18 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
 
 	commit_creds(cred);
 
+	/*
+	 * Emitted strictly after commit_creds() and before the out: label, so
+	 * it fires only for a thread now enforcing new_dom, and every
+	 * non-concluding (complete == false) event happens-before the
+	 * operation's single concluding one.  Skipped on the flags-only path,
+	 * where old_cred and new_cred carry the same domain.  A sibling never
+	 * concludes the operation and its enforcement is always process-wide.
+	 */
+	if (new_dom != landlock_cred(ctx->old_cred)->domain)
+		trace_landlock_enforce_domain(new_dom, false, true,
+					      task_no_new_privs(current));
+
 out:
 	/* Notify the calling thread once all threads are done */
 	if (atomic_dec_return(&ctx->num_unfinished) == 0)
-- 
2.54.0


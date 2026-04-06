Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78842DB7B4
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487105; cv=none; b=W6ceVDii9tRFNYke1Wu1qDfw+MojkXQZspWwVykYH4qQJVyeab4o0Hwpos1P0JIaqzPqkxWe1/Y3DrvN1N11Rlcb1yrJJ1k0yYL8O0BaZgcUg4zvY4v2Tec5QyWbcQl/ZhqN2LS4MIIWrLVmtF3JiqXUcAQkAYrpxPTW+V1hRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487105; c=relaxed/simple;
	bh=x1MjQrlCEEPUQLmDXoiXLBqgoYFzDbMkfnfts/4GL/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTNqvHWUBbWgk5fkD3aCTHSAv1L4MtFRdSCGJ10oZNLKtiy56DZ7HhSKUF4howIDvuSicuZijLY3IDm8B0GDjAio0bufs5s5oHJqMcRQSfDIxoPsiui9+JeCViR4etvS5O7OB3P2J98mYlKXpgT30mJttLr29ofXmLym9Mkaka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H0y/snR5; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H0y/snR5"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkR5TqFzyF5;
	Mon,  6 Apr 2026 16:37:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486255;
	bh=J4ervElomuQn014NMk7rokP6iIgL7K9E9QA+pZ/9yBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0y/snR5h+4wWs0wIGWvk4buy4OWInpSq+3sZe2MnVbeyL7k01bBitwLmAvcVcvaF
	 /a/SsQ+ANACxvIYCmh6ZGyrN6ExkYqqfll3I0cnK66uj4gtE02xyzxM35tnC72YqtZ
	 Llaa29XdHSxuVqeabaGf9xxi+dXRUnm68VHbelVE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkR1H7vzjq6;
	Mon,  6 Apr 2026 16:37:35 +0200 (CEST)
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
Subject: [PATCH v2 08/17] landlock: Add restrict_self and free_domain tracepoints
Date: Mon,  6 Apr 2026 16:37:06 +0200
Message-ID: <20260406143717.1815792-9-mic@digikod.net>
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

Add a tracepoint for sandbox enforcement, emitted from the
landlock_restrict_self() syscall handler after the new domain is
created.  This logs both the source ruleset ID (with its version at the
time of the merge) and the new domain ID, enabling trace consumers to
correlate add_rule events (which use the ruleset ID) with check_rule
events (which use the domain ID).

The TP_PROTO takes only the ruleset and domain pointers.  The ruleset
version and parent domain ID are computed in TP_fast_assign from these
pointers rather than passed as scalar arguments.  This lets eBPF
programs access the full ruleset and domain state via BTF on just two
pointers.  TP_fast_assign includes lockdep_assert_held(&ruleset->lock)
to enforce that the caller holds the ruleset lock during emission,
ensuring eBPF programs see a consistent ruleset->version via BTF.

Move the ruleset lock acquisition from landlock_merge_ruleset() to the
caller so the lock is held across the merge, TSYNC, and tracepoint
emission.  The tracepoint fires only after all fallible operations
(including TSYNC) have succeeded, so every event corresponds to a domain
that is actually installed.

The flags-only restrict_self path (ruleset_fd == -1) does not create a
domain and does not emit this event.  restrict_self flags that affect
logging (log_same_exec, log_new_exec) are accessible via BTF on
domain->hierarchy.

Add a landlock_free_domain tracepoint that fires when a domain's
hierarchy node is freed.  The hierarchy node is the lifecycle boundary
because it represents the domain's identity and outlives the domain's
access masks, which may still be active in descendant domains.

Domain freeing is asynchronous: it happens in a workqueue because the
credential free path runs in RCU callback context where the teardown
chain's sleeping operations (iput, audit_log_start, put_pid) are
forbidden.

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
 include/trace/events/landlock.h | 69 +++++++++++++++++++++++++++++++++
 security/landlock/domain.c      | 20 +++++-----
 security/landlock/log.c         |  5 +++
 security/landlock/syscalls.c    | 23 ++++++++++-
 4 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index f1e96c447b97..533aea6152e1 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -12,6 +12,8 @@
 
 #include <linux/tracepoint.h>
 
+struct landlock_domain;
+struct landlock_hierarchy;
 struct landlock_ruleset;
 struct path;
 
@@ -165,6 +167,73 @@ TRACE_EVENT(landlock_add_rule_net,
 	    TP_printk("ruleset=%llx.%u access_rights=0x%x port=%llu",
 		      __entry->ruleset_id, __entry->ruleset_version,
 		      __entry->access_rights, __entry->port));
+
+/**
+ * landlock_restrict_self - new domain created from landlock_restrict_self()
+ * @ruleset: Source ruleset frozen into the domain (never NULL); caller
+ *           holds ruleset->lock for BTF consistency.  eBPF programs can
+ *           read the full ruleset state via BTF (rules, version, access
+ *           masks).
+ * @domain: Newly created domain (never NULL, immutable after creation).
+ *          eBPF programs can navigate domain->hierarchy->parent for the
+ *          parent domain chain.
+ *
+ * Emitted after the domain is successfully installed (including TSYNC
+ * if requested).  The flags-only restrict_self path (ruleset_fd == -1)
+ * does not create a domain and does not emit this event.  Restrict_self
+ * flags that affect logging (log_same_exec, log_new_exec) are accessible
+ * via BTF on domain->hierarchy.
+ */
+TRACE_EVENT(landlock_restrict_self,
+
+	    TP_PROTO(const struct landlock_ruleset *ruleset,
+		     const struct landlock_domain *domain),
+
+	    TP_ARGS(ruleset, domain),
+
+	    TP_STRUCT__entry(__field(__u64, ruleset_id)
+				     __field(__u32, ruleset_version)
+					     __field(__u64, domain_id)
+						     __field(__u64, parent_id)),
+
+	    TP_fast_assign(
+		    lockdep_assert_held(&ruleset->lock);
+		    __entry->ruleset_id = ruleset->id;
+		    __entry->ruleset_version = ruleset->version;
+		    __entry->domain_id = domain->hierarchy->id;
+		    __entry->parent_id = domain->hierarchy->parent ?
+						 domain->hierarchy->parent->id :
+						 0;),
+
+	    TP_printk("ruleset=%llx.%u domain=%llx parent=%llx",
+		      __entry->ruleset_id, __entry->ruleset_version,
+		      __entry->domain_id, __entry->parent_id));
+
+/**
+ * landlock_free_domain - domain freed
+ * @hierarchy: Hierarchy node being freed (never NULL); eBPF can read
+ *             hierarchy->details (creator identity), hierarchy->parent
+ *             (domain chain), and hierarchy->log_status via BTF
+ *
+ * Emitted when the domain's last reference is dropped, either
+ * asynchronously from a kworker (via landlock_put_domain_deferred) or
+ * synchronously from the calling task (via landlock_put_domain).
+ */
+TRACE_EVENT(landlock_free_domain,
+
+	    TP_PROTO(const struct landlock_hierarchy *hierarchy),
+
+	    TP_ARGS(hierarchy),
+
+	    TP_STRUCT__entry(__field(__u64, domain_id) __field(__u64, denials)),
+
+	    TP_fast_assign(
+		    __entry->domain_id = hierarchy->id;
+		    __entry->denials = atomic64_read(&hierarchy->num_denials);),
+
+	    TP_printk("domain=%llx denials=%llu", __entry->domain_id,
+		      __entry->denials));
+
 #endif /* _TRACE_LANDLOCK_H */
 
 /* This part must be outside protection */
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 0dfd53ae9dd7..45ee7ec87957 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -294,31 +294,28 @@ static int merge_ruleset(struct landlock_domain *const dst,
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
 	dst->layers[dst->num_layers - 1] =
 		landlock_upgrade_handled_access_masks(src->layer);
 
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
@@ -399,6 +396,8 @@ static int inherit_ruleset(struct landlock_domain *const parent,
  * The current task is requesting to be restricted.  The subjective credentials
  * must not be in an overridden state. cf. landlock_init_hierarchy_log().
  *
+ * The caller must hold @ruleset->lock.
+ *
  * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR() on
  * failure.  If @parent is NULL, the new domain duplicates @ruleset.
  */
@@ -411,6 +410,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 	int err;
 
 	might_sleep();
+	lockdep_assert_held(&ruleset->lock);
 	if (WARN_ON_ONCE(!ruleset))
 		return ERR_PTR(-EINVAL);
 
diff --git a/security/landlock/log.c b/security/landlock/log.c
index ef79e4ed0037..ab4f982f8184 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -174,9 +174,12 @@ static void audit_denial(const struct landlock_cred_security *const subject,
 
 #endif /* CONFIG_AUDIT */
 
+#include <trace/events/landlock.h>
+
 #ifdef CONFIG_TRACEPOINTS
 #define CREATE_TRACE_POINTS
 #include <trace/events/landlock.h>
+#undef CREATE_TRACE_POINTS
 #endif /* CONFIG_TRACEPOINTS */
 
 static struct landlock_hierarchy *
@@ -473,6 +476,8 @@ void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
 	if (WARN_ON_ONCE(!hierarchy))
 		return;
 
+	trace_landlock_free_domain(hierarchy);
+
 	if (!audit_enabled)
 		return;
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index b18e83e457c2..93999749d80e 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -491,6 +491,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
 {
 	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
+	struct landlock_domain *new_dom = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
@@ -558,10 +559,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		 * There is no possible race condition while copying and
 		 * manipulating the current credentials because they are
 		 * dedicated per thread.
+		 *
+		 * Holds @ruleset->lock across the merge and tracepoint
+		 * emission so that the tracepoint reads the exact
+		 * ruleset version frozen into the new domain.
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
@@ -586,10 +592,23 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		const int err = landlock_restrict_sibling_threads(
 			current_cred(), new_cred);
 		if (err) {
+			if (ruleset)
+				mutex_unlock(&ruleset->lock);
 			abort_creds(new_cred);
 			return err;
 		}
 	}
 
+	/*
+	 * Emit after all fallible operations (including TSYNC) have
+	 * succeeded, so every event corresponds to an installed domain.
+	 * The ruleset lock is still held for BTF consistency (enforced
+	 * by lockdep_assert_held in TP_fast_assign).
+	 */
+	if (new_dom)
+		trace_landlock_restrict_self(ruleset, new_dom);
+
+	if (ruleset)
+		mutex_unlock(&ruleset->lock);
 	return commit_creds(new_cred);
 }
-- 
2.53.0


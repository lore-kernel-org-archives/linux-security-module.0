Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C68421249
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740364; cv=none; b=p5oVbLB32KDiXGNsph5IkWHTkNqPz/a8S/r+GadDl2jVhqWkxU7AAE0Nu+TqCQqZzgchOx+NgwjES343NeDD+XN/UxeIzpmkAJSnWfabVkR5lZL5LswC+cEfZBjGNnoQ1xabuX0T7PLuhIdhleANxaEdf5cUoImIIOOVFj9kSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740364; c=relaxed/simple;
	bh=8yc/5SsSBS/4ACOUrVK3C5QVdRmIE5+8fPVIv87GgG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdIU5ZUG7lekSRnrtdWYQrHTPDRUmF+GS/YsC35wlGDcrkKLhIuh+zZ4leMrwgH1w1DEY8DZcJNHlqEhL7KVLslsYhIs//Mcv5GfZVgLsuUSqvnuGsUF6Jl8yN+z4gMiRWu3eL1mdVcPvgL+Jobh5NCQPVX7huqEkbIewN5w0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=I8bQ6MDw; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="I8bQ6MDw"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515b5YFBzrFy;
	Wed, 22 Jul 2026 19:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740339;
	bh=dFsgLq31B1yEwTnAe5VXn0vjAC6/oGGCigNK+SNeDYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8bQ6MDw2FPAtJwpANeeHnIeTRS+TKXOWMbo7J7Hl831kk99A9R68RiWml/jreYbo
	 iENuzX2hvYQnifm0wD8T6gHVIubrzfWrkdJWm3aPtRySPQkmbYoD5QawdSIUyyaRtl
	 qqIM9LP9NA9uJ1YforjfS6trXrvuIbcsf2z/tIAI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515Z4FQnzmqC;
	Wed, 22 Jul 2026 19:12:18 +0200 (CEST)
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
Subject: [PATCH v3 05/20] landlock: Decouple the per-denial logging decision from CONFIG_AUDIT
Date: Wed, 22 Jul 2026 19:11:37 +0200
Message-ID: <20260722171159.2776765-6-mic@digikod.net>
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

Until now, whether a denial is logged was decided inside
landlock_audit_denial(): a per-execution flag check (log_same_exec or
log_new_exec, selected by the credential's domain_exec bitmask),
preceded by a LANDLOCK_LOG_DISABLED early return in
landlock_log_denial() for domains an ancestor fully quieted.

Factor that decision into a single is_denial_logged() helper called once
by landlock_log_denial(), and pass its result to landlock_audit_denial()
as a "logged" boolean.  A following commit passes the same boolean to
the deny tracepoints, so audit and tracing share one decision that stays
correct as new log state is added, and a tracepoints-only build
(CONFIG_AUDIT=n) computes it identically.  Computing the logged verdict
once in the shared helper makes audit and tracing apply identical
filtering, so they cannot report different logged= values for the same
denial as log controls grow.

Move the LANDLOCK_LOG_DISABLED gate out of landlock_log_denial() into
the decision so num_denials counts every denial, including those a
domain quiets.  This was previously masked: the only reader of
num_denials is the audit "domain deallocated" record, emitted only for
domains that reached LANDLOCK_LOG_RECORDED; a fully quieted domain never
records, so its undercount was never observable.  A following commit
adds a free_domain tracepoint that reports num_denials, which needs the
full count.

This is not a functional change for audit: the logged decision and the
audit_enabled gate are preserved, so the emitted records are identical.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 security/landlock/audit.c | 90 ++++-----------------------------------
 security/landlock/audit.h | 14 ++----
 security/landlock/log.c   | 88 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 97 insertions(+), 95 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index dfa1e5a64aac..32260e7cbfe9 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -136,104 +136,32 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
 	WRITE_ONCE(hierarchy->log_status, LANDLOCK_LOG_RECORDED);
 }
 
-static access_mask_t
-pick_access_mask_for_request_type(const enum landlock_request_type type,
-				  const struct access_masks access_masks)
-{
-	switch (type) {
-	case LANDLOCK_REQUEST_FS_ACCESS:
-		return access_masks.fs;
-	case LANDLOCK_REQUEST_NET_ACCESS:
-		return access_masks.net;
-	default:
-		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
-			  __func__);
-		return 0;
-	}
-}
-
 /**
  * landlock_audit_denial - Create an audit record for a denied access request
  *
- * @subject: The Landlock subject's credential denying an action.
  * @request: Detail of the user space request.
  * @youngest_denied: The youngest hierarchy node that denied the access.
- * @youngest_layer: The layer index of @youngest_denied.
  * @missing: The set of denied access rights.
- * @object_quiet_flag: Whether the object denied by @youngest_denied is
- *                     covered by a quiet rule in that layer.
+ * @logged: Whether the denial is selected for logging, as computed by
+ *          landlock_log_denial() (domain policy and quiet rules).
  *
- * Called from landlock_log_denial() with the same arguments.
+ * Emits the record when audit is enabled and the denial is selected for
+ * logging.
  */
-void landlock_audit_denial(const struct landlock_cred_security *const subject,
-			   const struct landlock_request *const request,
+void landlock_audit_denial(const struct landlock_request *const request,
 			   struct landlock_hierarchy *const youngest_denied,
-			   const size_t youngest_layer,
-			   const access_mask_t missing,
-			   const bool object_quiet_flag)
+			   const access_mask_t missing, const bool logged)
 {
 	struct audit_buffer *ab;
-	bool quiet_applicable_to_access = false;
 
 	if (!audit_enabled)
 		return;
 
-	/* Checks if the current exec was restricting itself. */
-	if (subject->domain_exec & BIT(youngest_layer)) {
-		/* Ignores denials for the same execution. */
-		if (!youngest_denied->log_same_exec)
-			return;
-	} else {
-		/* Ignores denials after a new execution. */
-		if (!youngest_denied->log_new_exec)
-			return;
-	}
-
 	/*
-	 * Checks if the object is marked quiet by the layer that denied the
-	 * request.  If it's a different layer that marked it as quiet, but that
-	 * layer is not the one that denied the request, we should still audit
-	 * log the denial.
+	 * Skips denials the domain's policy or a quiet rule excludes from
+	 * logging (folded into @logged by landlock_log_denial()).
 	 */
-	if (object_quiet_flag) {
-		/*
-		 * We now check if the denied requests are all covered by the
-		 * layer's quiet access bits.
-		 */
-		const access_mask_t quiet_mask =
-			pick_access_mask_for_request_type(
-				request->type, youngest_denied->quiet_masks);
-
-		quiet_applicable_to_access = (quiet_mask & missing) == missing;
-	} else {
-		/*
-		 * Either the object is not quiet, or this is a scope request.
-		 * We check request->type to distinguish between the two cases.
-		 */
-		const access_mask_t quiet_mask =
-			youngest_denied->quiet_masks.scope;
-
-		switch (request->type) {
-		case LANDLOCK_REQUEST_SCOPE_SIGNAL:
-			quiet_applicable_to_access =
-				!!(quiet_mask & LANDLOCK_SCOPE_SIGNAL);
-			break;
-		case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
-			quiet_applicable_to_access =
-				!!(quiet_mask &
-				   LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
-			break;
-		/*
-		 * Leave LANDLOCK_REQUEST_PTRACE and
-		 * LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY unhandled for now - they
-		 * are never quiet.
-		 */
-		default:
-			break;
-		}
-	}
-
-	if (quiet_applicable_to_access)
+	if (!logged)
 		return;
 
 	/* Uses consistent allocation flags wrt common_lsm_audit(). */
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 1b36bb3c6cfd..14a514065e08 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -12,18 +12,14 @@
 
 #include "access.h"
 
-struct landlock_cred_security;
 struct landlock_hierarchy;
 struct landlock_request;
 
 #ifdef CONFIG_AUDIT
 
-void landlock_audit_denial(const struct landlock_cred_security *const subject,
-			   const struct landlock_request *const request,
+void landlock_audit_denial(const struct landlock_request *const request,
 			   struct landlock_hierarchy *const youngest_denied,
-			   const size_t youngest_layer,
-			   const access_mask_t missing,
-			   const bool object_quiet_flag);
+			   const access_mask_t missing, const bool logged);
 
 void landlock_audit_free_domain(
 	const struct landlock_hierarchy *const hierarchy);
@@ -31,11 +27,9 @@ void landlock_audit_free_domain(
 #else /* CONFIG_AUDIT */
 
 static inline void
-landlock_audit_denial(const struct landlock_cred_security *const subject,
-		      const struct landlock_request *const request,
+landlock_audit_denial(const struct landlock_request *const request,
 		      struct landlock_hierarchy *const youngest_denied,
-		      const size_t youngest_layer, const access_mask_t missing,
-		      const bool object_quiet_flag)
+		      const access_mask_t missing, const bool logged)
 {
 }
 
diff --git a/security/landlock/log.c b/security/landlock/log.c
index 6dd3373c4ba4..f42e6dc4de5c 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -405,6 +405,86 @@ static bool is_valid_request(const struct landlock_request *const request)
 	return true;
 }
 
+static access_mask_t
+pick_access_mask_for_request_type(const enum landlock_request_type type,
+				  const struct access_masks access_masks)
+{
+	switch (type) {
+	case LANDLOCK_REQUEST_FS_ACCESS:
+		return access_masks.fs;
+	case LANDLOCK_REQUEST_NET_ACCESS:
+		return access_masks.net;
+	default:
+		WARN_ONCE(1, "Invalid request type %d passed to %s", type,
+			  __func__);
+		return 0;
+	}
+}
+
+/*
+ * Whether a quiet rule silences the denial: the rule must cover the whole
+ * denied access in the layer that denied it (a quiet rule in a non-denying
+ * layer does not suppress the denial).
+ */
+static bool
+is_denial_quieted(const struct landlock_request *const request,
+		  const struct landlock_hierarchy *const youngest_denied,
+		  const access_mask_t missing, const bool object_quiet_flag)
+{
+	if (object_quiet_flag) {
+		const access_mask_t quiet_mask =
+			pick_access_mask_for_request_type(
+				request->type, youngest_denied->quiet_masks);
+
+		return (quiet_mask & missing) == missing;
+	}
+
+	/*
+	 * Either the object is not quiet, or this is a scope request.  We check
+	 * request->type to distinguish between the two cases.
+	 */
+	switch (request->type) {
+	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+		return !!(youngest_denied->quiet_masks.scope &
+			  LANDLOCK_SCOPE_SIGNAL);
+	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+		return !!(youngest_denied->quiet_masks.scope &
+			  LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	/*
+	 * Leave LANDLOCK_REQUEST_PTRACE and LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY
+	 * unhandled for now - they are never quiet.
+	 */
+	default:
+		return false;
+	}
+}
+
+/*
+ * Computes whether a denial from youngest_denied is selected for logging by the
+ * domain's policy: its logging must not be disabled (by both per-execution
+ * flags being off, or by an ancestor's
+ * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF), the per-execution flag matching
+ * same_exec must be set, and no quiet rule may cover the denied access.
+ * landlock_log_denial() computes this once and passes it to
+ * landlock_audit_denial(), which additionally requires audit_enabled.
+ */
+static bool
+is_denial_logged(const struct landlock_request *const request,
+		 const struct landlock_hierarchy *const youngest_denied,
+		 const access_mask_t missing, const bool same_exec,
+		 const bool object_quiet_flag)
+{
+	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
+		return false;
+
+	if (!(same_exec ? youngest_denied->log_same_exec :
+			  youngest_denied->log_new_exec))
+		return false;
+
+	return !is_denial_quieted(request, youngest_denied, missing,
+				  object_quiet_flag);
+}
+
 /**
  * landlock_log_denial - Log a denied access
  *
@@ -451,8 +531,9 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			get_hierarchy(subject->domain, youngest_layer);
 	}
 
-	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
-		return;
+	const bool same_exec = !!(subject->domain_exec & BIT(youngest_layer));
+	const bool logged = is_denial_logged(request, youngest_denied, missing,
+					     same_exec, object_quiet_flag);
 
 	/*
 	 * Consistently keeps track of the number of denied access requests even
@@ -461,8 +542,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	 */
 	atomic64_inc(&youngest_denied->num_denials);
 
-	landlock_audit_denial(subject, request, youngest_denied, youngest_layer,
-			      missing, object_quiet_flag);
+	landlock_audit_denial(request, youngest_denied, missing, logged);
 }
 
 /**
-- 
2.54.0


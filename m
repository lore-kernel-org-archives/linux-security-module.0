Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB3550DA3
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083593; cv=none; b=ETofAFPqAmYiv3v0GZoQqqIkZpiU2Ca8f91WgRYjfqFRv8neO9lI8+yu2RmYTzr9z3Xj+NexyzwPSpue/nO/pIkA2Z+OB1MmdUrOAuxrPp105tn0rcCI8Yvkb2SmPPMu2DgvphpjKYo69oAlmtoy1LZ+Oa/a2OoOrW+eCDTJY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083593; c=relaxed/simple;
	bh=ck6zSA5uG9AMrFx+KLYgJ+MecAgRwgmH5eqFvhc/YAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=izZ9A/MY9CRNoU+sDjswrxaTOPuljAeFZzOco3ITFL9vBjl3IGpxHiMxWTgnFlv+/PkXJOQ/X9NuKjF5jt0Me58NbZ3IsMvptHAh/Ctgd54pLkyrsg372ip6ilQmHYvX01W1ND3Zzv7al0v54UhCGiSAtD7HeK0zjBEzn9wOf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=D0tm4tY4; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="D0tm4tY4"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hq18D0MqkzQyQ;
	Tue, 22 Sep 2026 15:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1790083579;
	bh=+OtYwFFOW1lYmWFKiVpANm3VAaY1uGLqmsa3RJ/5bOg=;
	h=From:To:Cc:Subject:Date:From;
	b=D0tm4tY4uCJ9ZIlxSjhk8fY4k/rURhaU/eR9ZitzOx2rfYvd70xlumEgkqMSMJhOc
	 iO3PgZ8fb9xr75GT2Vn5PYqRV/FnMsnuO4tBvEP0HWRWIw63Ap1hw3WUfHj8IkeRXm
	 lQGxrlzv5fcAxu3QmRG4AlNqiZNqi5JEf8xOyQx4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hq18B5N7tztZb;
	Tue, 22 Sep 2026 15:26:18 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-security-module@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1] landlock: Widen ruleset versions to 64 bits
Date: Tue, 22 Sep 2026 15:26:14 +0200
Message-ID: <20260922132615.1025945-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Tracepoint consumers use a ruleset ID and version to identify the
successful landlock_add_rule(2) call prefix used to create a domain.
LANDLOCK_MAX_NUM_RULES bounds distinct stored rules, not successful
calls: re-adding already-present rights for an object or port succeeds
without increasing num_rules.  Because every successful call increments
the version, these calls can wrap the 32-bit counter and give different
prefixes the same trace identity.

Widen the counter and its trace fields to 64 bits so the counter cannot
wrap in practice, while preserving the successful-call semantics.
Saturating would alias all subsequent histories, while rejecting a call
at the limit would change otherwise valid syscall behavior solely for
trace metadata.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 63747c94774d ("landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 20 ++++++++++----------
 security/landlock/ruleset.h     |  5 +++--
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 523ba5ea9870..3a43638c9bc2 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -344,7 +344,7 @@ TRACE_EVENT(landlock_create_ruleset,
 
 	TP_STRUCT__entry(
 		__field(	u64,		ruleset_id	)
-		__field(	u32,		ruleset_version	)
+		__field(	u64,		ruleset_version	)
 		__field(	access_mask_t,	handled_fs	)
 		__field(	access_mask_t,	handled_net	)
 		__field(	access_mask_t,	scoped		)
@@ -358,7 +358,7 @@ TRACE_EVENT(landlock_create_ruleset,
 		__entry->scoped		= ruleset->handled_masks.scope;
 	),
 
-	TP_printk("ruleset=%llx.%u handled_fs=%s handled_net=%s scoped=%s",
+	TP_printk("ruleset=%llx.%llu handled_fs=%s handled_net=%s scoped=%s",
 		__entry->ruleset_id, __entry->ruleset_version,
 		__print_flags(__entry->handled_fs, "|", _LANDLOCK_ACCESS_FS_NAMES),
 		__print_flags(__entry->handled_net, "|", _LANDLOCK_ACCESS_NET_NAMES),
@@ -384,7 +384,7 @@ TRACE_EVENT(landlock_free_ruleset,
 
 	TP_STRUCT__entry(
 		__field(	u64,		ruleset_id	)
-		__field(	u32,		ruleset_version	)
+		__field(	u64,		ruleset_version	)
 	),
 
 	TP_fast_assign(
@@ -392,7 +392,7 @@ TRACE_EVENT(landlock_free_ruleset,
 		__entry->ruleset_version = ruleset->version;
 	),
 
-	TP_printk("ruleset=%llx.%u",
+	TP_printk("ruleset=%llx.%llu",
 		__entry->ruleset_id, __entry->ruleset_version)
 );
 
@@ -423,7 +423,7 @@ TRACE_EVENT(landlock_add_rule_path_beneath,
 
 	TP_STRUCT__entry(
 		__field(	u64,		ruleset_id	)
-		__field(	u32,		ruleset_version	)
+		__field(	u64,		ruleset_version	)
 		__field(	access_mask_t,	access_rights	)
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
@@ -444,7 +444,7 @@ TRACE_EVENT(landlock_add_rule_path_beneath,
 		__assign_str(pathname);
 	),
 
-	TP_printk("ruleset=%llx.%u access_rights=%s dev=%u:%u ino=%lu path=%s",
+	TP_printk("ruleset=%llx.%llu access_rights=%s dev=%u:%u ino=%lu path=%s",
 		__entry->ruleset_id, __entry->ruleset_version,
 		__print_flags(__entry->access_rights, "|", _LANDLOCK_ACCESS_FS_NAMES),
 		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
@@ -477,7 +477,7 @@ TRACE_EVENT(landlock_add_rule_net_port,
 
 	TP_STRUCT__entry(
 		__field(	u64,		ruleset_id	)
-		__field(	u32,		ruleset_version	)
+		__field(	u64,		ruleset_version	)
 		__field(	access_mask_t,	access_rights	)
 		__field(	u64,		port		)
 	),
@@ -490,7 +490,7 @@ TRACE_EVENT(landlock_add_rule_net_port,
 		__entry->port		= port;
 	),
 
-	TP_printk("ruleset=%llx.%u access_rights=%s port=%llu",
+	TP_printk("ruleset=%llx.%llu access_rights=%s port=%llu",
 		__entry->ruleset_id, __entry->ruleset_version,
 		__print_flags(__entry->access_rights, "|", _LANDLOCK_ACCESS_NET_NAMES),
 		__entry->port)
@@ -526,7 +526,7 @@ TRACE_EVENT(landlock_create_domain,
 		__field(	u64,		domain_id	)
 		__field(	u64,		parent_id	)
 		__field(	u64,		ruleset_id	)
-		__field(	u32,		ruleset_version	)
+		__field(	u64,		ruleset_version	)
 	),
 
 	TP_fast_assign(
@@ -538,7 +538,7 @@ TRACE_EVENT(landlock_create_domain,
 		__entry->ruleset_version = ruleset->version;
 	),
 
-	TP_printk("domain=%llx parent=%llx ruleset=%llx.%u",
+	TP_printk("domain=%llx parent=%llx ruleset=%llx.%llu",
 		__entry->domain_id, __entry->parent_id,
 		__entry->ruleset_id, __entry->ruleset_version)
 );
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index b536fa0425b7..cf77f1806a95 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -171,9 +171,10 @@ struct landlock_ruleset {
 	 * @version: Counter incremented on each successful
 	 * landlock_add_rule(2), including when it only extends an existing
 	 * rule's access rights.  Used by tracepoints to correlate a domain with
-	 * the exact ruleset state it was created from.  Protected by @lock.
+	 * the exact successful rule history it was created from.  Protected by
+	 * @lock.
 	 */
-	u32 version;
+	u64 version;
 	/**
 	 * @id: Unique identifier for this ruleset, used for tracing.
 	 */
-- 
2.55.0


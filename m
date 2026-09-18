Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9551D50F
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757471; cv=none; b=oilksGLkQ4h7rOwXjSYCgtJmHxJ5YZCBltnOza5CsnxCzXVlMGB87Z0QsGNGgEc0JXtFTk7H8Y/q65855vaAkHv+PqtcaGJIUoOAHex41PV6rmb2M70YHileG9L+QmcwyuHq4putkFPpSk47AQGkhSMpTiqkCg9betMwNa5Si6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757471; c=relaxed/simple;
	bh=ytXpe2dIYFCAomZKMM8kbpEsl0GbuQJkjfSkGXW6eq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYc1gGA9sVGh3EH2/S12d98DkT6Jpa6wExtq+TA0ajgEIle/3u2R97qev4VP4Rbz1+pLJgqgeL8ZgLSidz2ZsKBrHP8xcIswiYpeTXFbp3w6j4zlDXvhDJelnSwUJ50Zsr9IR+yHc8s6A7Cz0B/a76J5SS4mh3021gqwXRkNn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Jnh9MphC; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Jnh9MphC"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXP3VWvznp3;
	Fri, 18 Sep 2026 20:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757445;
	bh=+bTLH1lKbEeVBcx0NXffsHETLf3zKiegb74JzSOXv38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnh9MphCkThNmm5H0vTev2tXD8WmJtLUL9nPEBzDKisqBJ6nCxw7IvjGymhpx/H59
	 GHGPnsne0niooY+4yVLBM1lHuO1YHls2Iojp/1R9qoAEoC8wlQbEVvFRhFZkbpWCqA
	 xX1Et7DadRjSJntMbUCrOK+ynIVTh4JwqyHUpzWc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXN56ZGz63s;
	Fri, 18 Sep 2026 20:50:44 +0200 (CEST)
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
Subject: [PATCH v1 1/9] landlock: Fix tracepoint fixed-width type names
Date: Fri, 18 Sep 2026 20:50:24 +0200
Message-ID: <20260918185036.608651-2-mic@digikod.net>
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

The new Landlock tracepoints use UAPI-prefixed __u32 and __u64 names for
callback arguments and record fields, including internal IDs that are
not Landlock UAPI values. Typed BPF consumers see callback typedef names
through BTF.

Use the kernel u32 and u64 aliases before release so the tracepoint
contract does not present internal values as Landlock UAPI types. This
changes BTF-visible typedef spelling but not integer widths, calling
conventions, tracefs formats, or record layouts.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 68 ++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index d05253afaf59..4984f80923ed 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -243,8 +243,8 @@ static inline const char *__trace_landlock_print_layers(
  * Field encoding
  * ~~~~~~~~~~~~~~
  *
- * Fields that mirror the Landlock UAPI use the same C types and endianness
- * (e.g. network ports are __u64 in host endianness, like
+ * Fields that mirror the Landlock UAPI preserve their widths and endianness
+ * (e.g. network ports are u64 in host endianness, like
  * landlock_net_port_attr.port).  Per-event details, such as where a value
  * is byte-swapped, live in the field's own kdoc.
  *
@@ -319,8 +319,8 @@ TRACE_EVENT(landlock_create_ruleset,
 	TP_ARGS(ruleset),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		ruleset_id	)
-		__field(	__u32,		ruleset_version	)
+		__field(	u64,		ruleset_id	)
+		__field(	u32,		ruleset_version	)
 		__field(	access_mask_t,	handled_fs	)
 		__field(	access_mask_t,	handled_net	)
 		__field(	access_mask_t,	scoped		)
@@ -359,8 +359,8 @@ TRACE_EVENT(landlock_free_ruleset,
 	TP_ARGS(ruleset),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		ruleset_id	)
-		__field(	__u32,		ruleset_version	)
+		__field(	u64,		ruleset_id	)
+		__field(	u32,		ruleset_version	)
 	),
 
 	TP_fast_assign(
@@ -396,8 +396,8 @@ TRACE_EVENT(landlock_add_rule_fs,
 	TP_ARGS(ruleset, access_rights, path, pathname),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		ruleset_id	)
-		__field(	__u32,		ruleset_version	)
+		__field(	u64,		ruleset_id	)
+		__field(	u32,		ruleset_version	)
 		__field(	access_mask_t,	access_rights	)
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
@@ -443,15 +443,15 @@ TRACE_EVENT(landlock_add_rule_fs,
 TRACE_EVENT(landlock_add_rule_net,
 
 	TP_PROTO(const struct landlock_ruleset *ruleset,
-		 access_mask_t access_rights, __u64 port),
+		 access_mask_t access_rights, u64 port),
 
 	TP_ARGS(ruleset, access_rights, port),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		ruleset_id	)
-		__field(	__u32,		ruleset_version	)
+		__field(	u64,		ruleset_id	)
+		__field(	u32,		ruleset_version	)
 		__field(	access_mask_t,	access_rights	)
-		__field(	__u64,		port		)
+		__field(	u64,		port		)
 	),
 
 	TP_fast_assign(
@@ -495,10 +495,10 @@ TRACE_EVENT(landlock_create_domain,
 	TP_ARGS(domain, ruleset),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
-		__field(	__u64,		parent_id	)
-		__field(	__u64,		ruleset_id	)
-		__field(	__u32,		ruleset_version	)
+		__field(	u64,		domain_id	)
+		__field(	u64,		parent_id	)
+		__field(	u64,		ruleset_id	)
+		__field(	u32,		ruleset_version	)
 	),
 
 	TP_fast_assign(
@@ -557,7 +557,7 @@ TRACE_EVENT(landlock_enforce_domain,
 	TP_ARGS(domain, complete, process_wide, no_new_privs),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	bool,		complete	)
 		__field(	bool,		process_wide	)
 		__field(	bool,		no_new_privs	)
@@ -595,8 +595,8 @@ TRACE_EVENT(landlock_free_domain,
 	TP_ARGS(hierarchy),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
-		__field(	__u64,		denials		)
+		__field(	u64,		domain_id	)
+		__field(	u64,		denials		)
 	),
 
 	TP_fast_assign(
@@ -631,7 +631,7 @@ TRACE_EVENT(landlock_check_rule_fs,
 	TP_ARGS(domain, rule, access_request, dentry),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	access_mask_t,	access_request	)
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
@@ -675,14 +675,14 @@ TRACE_EVENT(landlock_check_rule_net,
 
 	TP_PROTO(const struct landlock_domain *domain,
 		 const struct landlock_rule *rule,
-		 access_mask_t access_request, __u64 port),
+		 access_mask_t access_request, u64 port),
 
 	TP_ARGS(domain, rule, access_request, port),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	access_mask_t,	access_request	)
-		__field(	__u64,		port		)
+		__field(	u64,		port		)
 		__dynamic_array(access_mask_t,	grants,
 				domain->num_layers)
 	),
@@ -729,7 +729,7 @@ TRACE_EVENT(landlock_deny_access_fs,
 	TP_ARGS(hierarchy, same_exec, logged, blockers, path, pathname),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
 		__field(	access_mask_t,	blockers	)
@@ -791,17 +791,17 @@ TRACE_EVENT(landlock_deny_access_net,
 
 	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
 		 bool logged, access_mask_t blockers, const struct sock *sk,
-		 __u64 sport, __u64 dport),
+		 u64 sport, u64 dport),
 
 	TP_ARGS(hierarchy, same_exec, logged, blockers, sk, sport, dport),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
 		__field(	access_mask_t,	blockers	)
-		__field(	__u64,		sport		)
-		__field(	__u64,		dport		)
+		__field(	u64,		sport		)
+		__field(	u64,		dport		)
 	),
 
 	TP_fast_assign(
@@ -842,10 +842,10 @@ TRACE_EVENT(landlock_deny_ptrace,
 	TP_ARGS(hierarchy, same_exec, logged, tracee_domain_id, tracee),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
-		__field(	__u64,		tracee_domain_id)
+		__field(	u64,		tracee_domain_id)
 		__field(	pid_t,		tracee_pid	)
 		__string(	tracee_comm,	tracee->comm	)
 	),
@@ -891,10 +891,10 @@ TRACE_EVENT(landlock_deny_scope_signal,
 	TP_ARGS(hierarchy, same_exec, logged, target_domain_id, target),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
-		__field(	__u64,		target_domain_id)
+		__field(	u64,		target_domain_id)
 		__field(	pid_t,		target_pid	)
 		__string(	target_comm,	target->comm	)
 	),
@@ -940,10 +940,10 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 	TP_ARGS(hierarchy, same_exec, logged, peer_domain_id, peer),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		domain_id	)
+		__field(	u64,		domain_id	)
 		__field(	bool,		same_exec	)
 		__field(	bool,		logged		)
-		__field(	__u64,		peer_domain_id	)
+		__field(	u64,		peer_domain_id	)
 		__field(	pid_t,		peer_pid	)
 		/*
 		 * Abstract socket names are untrusted binary data from
-- 
2.55.0


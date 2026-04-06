Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EC382F2A
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486272; cv=none; b=GL17o2Ka5FGu2lglSyHkJ5Oaud9HIzPGZ6fIX/fTxpKnuSv85d5KFBcFKXyGS3y4cJdBNrqOYeJf71TeAy6H8yctFR6TP/grNhRXk03Q45xM1oHO7U8p6Gx9HerFFlEN6qRXwu/XqtPfj7vtVLlmysWOo+rgww8seK97MX2ixT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486272; c=relaxed/simple;
	bh=yntYopewjKJlvCgPyMBgTX8bhYuK0ESNq7uiTdHw2+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2l1hnFwBxpPbF7A4UWX+mxb96wkFruVsHgS+FmTBaw5Ba7d4DSWYPrR8bRRvGMutPIRoAqRZXI8znjstKaFokGJafQUKvH59Uv8eDgq6uk/t2s6JOJUIOPN4gd4FvTKPsU1nlZNWHs/WCn5DMPu9USZ87YC379EqgHUO9gI/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=2DTz5fye; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="2DTz5fye"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkX54ltzSRJ;
	Mon,  6 Apr 2026 16:37:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486260;
	bh=/Hch2jVap5AfV69zq+H5w0X6oki3orky27Sk7iZOWRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2DTz5fyeSbxDamhg0i6wfzc/XIQnJGESQ3GikXnbu+mF/uJqAQ850spjMYi1Me+B6
	 9Lz/1gS6qoGoln2gmXNAF+03WdirxUZnAB+VE1ItHjhYYQzW3UashX9Pg537pwULx2
	 N2kR7ZO7xq6X8ix95fY74cGTL7dRtRDFWp8IbKKA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkX0pdSzCsW;
	Mon,  6 Apr 2026 16:37:40 +0200 (CEST)
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
Subject: [PATCH v2 12/17] landlock: Add tracepoints for ptrace and scope denials
Date: Mon,  6 Apr 2026 16:37:10 +0200
Message-ID: <20260406143717.1815792-13-mic@digikod.net>
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

Scope and ptrace denials follow a different code path (domain hierarchy
check) than access-right denials, requiring dedicated tracepoints with
type-specific TP_PROTO arguments.

Complete the tracepoint coverage for all Landlock denial types by adding
tracepoints for ptrace and scope-based denials:
- landlock_deny_ptrace: emitted when ptrace access is denied due to
  domain hierarchy mismatch.
- landlock_deny_scope_signal: emitted when signal delivery is denied by
  LANDLOCK_SCOPE_SIGNAL.
- landlock_deny_scope_abstract_unix_socket: emitted when abstract unix
  socket access is denied by LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET.

TP_PROTO passes the raw kernel object (struct task_struct or struct
sock) for eBPF BTF access.  String fields (comm, sun_path) use
__print_untrusted_str() because they contain untrusted input.

Unlike deny_access_fs and deny_access_net which include a blockers field
showing which specific access rights were denied, these events omit
blockers because each event corresponds to exactly one denial type
identified by the event name itself (e.g., landlock_deny_ptrace can only
mean a ptrace denial).  A blockers field is always zero since
scope and ptrace denials do not use access-right bitmasks.

Audit records use generic field names (opid, ocomm) for the target
process, while tracepoints use role-specific names (tracee_pid,
target_pid, peer_pid).  The tracepoint naming is more descriptive
because trace events are strongly typed and tied to the semantics of each
event, while the audit log format is generic.

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
 include/trace/events/landlock.h | 135 ++++++++++++++++++++++++++++++++
 security/landlock/log.c         |  20 +++++
 2 files changed, 155 insertions(+)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 1afab091efba..9f96c9897f44 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -11,6 +11,7 @@
 #define _TRACE_LANDLOCK_H
 
 #include <linux/tracepoint.h>
+#include <net/af_unix.h>
 
 struct dentry;
 struct landlock_domain;
@@ -19,6 +20,7 @@ struct landlock_rule;
 struct landlock_ruleset;
 struct path;
 struct sock;
+struct task_struct;
 
 /**
  * DOC: Landlock trace events
@@ -433,6 +435,139 @@ TRACE_EVENT(
 		__entry->log_new_exec, __entry->blockers, __entry->sport,
 		__entry->dport));
 
+/**
+ * landlock_deny_ptrace - ptrace access denied
+ * @hierarchy: Hierarchy node that blocked the access (never NULL)
+ * @same_exec: Whether the current task is the same executable that called
+ *             landlock_restrict_self() for the denying hierarchy node
+ * @tracee: Target task (never NULL); eBPF can read pid, comm, cred,
+ *          namespaces, and cgroup via BTF
+ */
+TRACE_EVENT(
+	landlock_deny_ptrace,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 const struct task_struct *tracee),
+
+	TP_ARGS(hierarchy, same_exec, tracee),
+
+	TP_STRUCT__entry(
+		__field(__u64, domain_id) __field(bool, same_exec)
+			__field(u32, log_same_exec) __field(u32, log_new_exec)
+				__field(pid_t, tracee_pid)
+					__string(tracee_comm, tracee->comm)),
+
+	TP_fast_assign(__entry->domain_id = hierarchy->id;
+		       __entry->same_exec = same_exec;
+		       __entry->log_same_exec = hierarchy->log_same_exec;
+		       __entry->log_new_exec = hierarchy->log_new_exec;
+		       __entry->tracee_pid =
+			       task_tgid_nr((struct task_struct *)tracee);
+		       __assign_str(tracee_comm);),
+
+	TP_printk(
+		"domain=%llx same_exec=%d log_same_exec=%u log_new_exec=%u tracee_pid=%d comm=%s",
+		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
+		__entry->log_new_exec, __entry->tracee_pid,
+		__print_untrusted_str(tracee_comm)));
+
+/**
+ * landlock_deny_scope_signal - signal delivery denied by
+ *                               LANDLOCK_SCOPE_SIGNAL
+ * @hierarchy: Hierarchy node that blocked the access (never NULL)
+ * @same_exec: Whether the current task is the same executable that called
+ *             landlock_restrict_self() for the denying hierarchy node
+ * @target: Signal target task (never NULL); eBPF can read pid, comm, cred,
+ *          namespaces, and cgroup via BTF
+ */
+TRACE_EVENT(
+	landlock_deny_scope_signal,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 const struct task_struct *target),
+
+	TP_ARGS(hierarchy, same_exec, target),
+
+	TP_STRUCT__entry(
+		__field(__u64, domain_id) __field(bool, same_exec)
+			__field(u32, log_same_exec) __field(u32, log_new_exec)
+				__field(pid_t, target_pid)
+					__string(target_comm, target->comm)),
+
+	TP_fast_assign(__entry->domain_id = hierarchy->id;
+		       __entry->same_exec = same_exec;
+		       __entry->log_same_exec = hierarchy->log_same_exec;
+		       __entry->log_new_exec = hierarchy->log_new_exec;
+		       __entry->target_pid =
+			       task_tgid_nr((struct task_struct *)target);
+		       __assign_str(target_comm);),
+
+	TP_printk(
+		"domain=%llx same_exec=%d log_same_exec=%u log_new_exec=%u target_pid=%d comm=%s",
+		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
+		__entry->log_new_exec, __entry->target_pid,
+		__print_untrusted_str(target_comm)));
+
+/**
+ * landlock_deny_scope_abstract_unix_socket - abstract unix socket access
+ *     denied by LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+ * @hierarchy: Hierarchy node that blocked the access (never NULL)
+ * @same_exec: Whether the current task is the same executable that called
+ *             landlock_restrict_self() for the denying hierarchy node
+ * @peer: Peer socket (never NULL); eBPF can read sk_peer_pid,
+ *        sk_peer_cred, socket type, and protocol via BTF
+ */
+TRACE_EVENT(
+	landlock_deny_scope_abstract_unix_socket,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 const struct sock *peer),
+
+	TP_ARGS(hierarchy, same_exec, peer),
+
+	TP_STRUCT__entry(
+		__field(__u64, domain_id) __field(bool, same_exec)
+			__field(u32, log_same_exec) __field(u32, log_new_exec)
+				__field(pid_t, peer_pid)
+		/*
+		 * Abstract socket names are untrusted binary data from
+		 * user space.  Use __string_len because abstract names
+		 * are not NUL-terminated; their length is determined by
+		 * addr->len.
+		 */
+		__string_len(sun_path,
+			     unix_sk(peer)->addr ?
+				     unix_sk(peer)->addr->name->sun_path + 1 :
+				     "",
+			     unix_sk(peer)->addr ?
+				     unix_sk(peer)->addr->len -
+					     offsetof(struct sockaddr_un,
+						      sun_path) -
+					     1 :
+				     0)),
+
+	TP_fast_assign(struct pid *peer_pid;
+
+		       __entry->domain_id = hierarchy->id;
+		       __entry->same_exec = same_exec;
+		       __entry->log_same_exec = hierarchy->log_same_exec;
+		       __entry->log_new_exec = hierarchy->log_new_exec;
+		       /*
+			* READ_ONCE prevents compiler double-read.  The value
+			* is stable because unix_state_lock(peer) is held by
+			* the caller (hook_unix_stream_connect or
+			* hook_unix_may_send).
+			*/
+		       peer_pid = READ_ONCE(peer->sk_peer_pid);
+		       __entry->peer_pid = peer_pid ? pid_nr(peer_pid) : 0;
+		       __assign_str(sun_path);),
+
+	TP_printk(
+		"domain=%llx same_exec=%d log_same_exec=%u log_new_exec=%u peer_pid=%d sun_path=%s",
+		__entry->domain_id, __entry->same_exec, __entry->log_same_exec,
+		__entry->log_new_exec, __entry->peer_pid,
+		__print_untrusted_str(sun_path)));
+
 #endif /* _TRACE_LANDLOCK_H */
 
 /* This part must be outside protection */
diff --git a/security/landlock/log.c b/security/landlock/log.c
index c81cb7c1c448..a2f61aed81ff 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -11,6 +11,9 @@
 #include <linux/bitops.h>
 #include <linux/lsm_audit.h>
 #include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <net/sock.h>
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
@@ -259,6 +262,23 @@ static void trace_denial(const struct landlock_cred_security *const subject,
 				ntohs(request->audit.u.net->sport),
 				ntohs(request->audit.u.net->dport));
 		break;
+	case LANDLOCK_REQUEST_PTRACE:
+		if (trace_landlock_deny_ptrace_enabled())
+			trace_landlock_deny_ptrace(youngest_denied, same_exec,
+						   request->audit.u.tsk);
+		break;
+	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+		if (trace_landlock_deny_scope_signal_enabled())
+			trace_landlock_deny_scope_signal(youngest_denied,
+							 same_exec,
+							 request->audit.u.tsk);
+		break;
+	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+		if (trace_landlock_deny_scope_abstract_unix_socket_enabled())
+			trace_landlock_deny_scope_abstract_unix_socket(
+				youngest_denied, same_exec,
+				request->audit.u.net->sk);
+		break;
 	default:
 		break;
 	}
-- 
2.53.0


Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDC41DE04
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441819; cv=none; b=Dton3mBBegT7s5DD9/J4udSztlGHPE2CPKrVZMnsdUMLIn7adM7pydpi/Vh/x06g+NTomLbvkD8dVdsCtXZlITOKqGrXWMK5fGEkeQ82dRwwy5yOR6Byrr3ubGMAdg9X11ihCm97eDsLGAlhdZpnNV+Bbyq+EygbX5M4MOS9nCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441819; c=relaxed/simple;
	bh=jTujUy+axj5JxEb3LJMxdoJ9szivMFSW2c4Q5MRgFKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSyGQk9cNTfyX9ouE5O/5Ms+SdB8QEzHvYpS+sijw1IeAXyBSeIgLfWf6i/QWdUf5v9NKvMtBon1iv35uYlnqAwAa9+5FwzGa2/gYoo3u77yF18yNh14To5mBKeL6Dx0sV/F5/LFPnFUhsRNn5a+fuyii2DxeCDkdJ0Y9BUimi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=M/vfn71R; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="M/vfn71R"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hK6C52YTRzKmN;
	Tue, 11 Aug 2026 11:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786441441;
	bh=WT0i6rg516uGu2mRuy+KoVmjLzDtwVbS5LfXQ3xAglk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/vfn71RJ1ymynVlIfYaHfvdXddev/jLLQAxGJiPCti3MdXOmMP/I64/Ix9LViulS
	 dJ1LXomQkLNUaqu4Tv60yUgsodWuORtl1TtnVLj4D3txAWyARS4+2BEI46hx6Bc7nw
	 buXT++w8sXLfGzHthSXEcHCn8KBd0GN4eZX3+tWc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hK6C41GK7zYgn;
	Tue, 11 Aug 2026 11:44:00 +0200 (CEST)
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
Subject: [PATCH v4 08/19] landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints
Date: Tue, 11 Aug 2026 11:43:22 +0200
Message-ID: <20260811094338.288094-9-mic@digikod.net>
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

Add tracepoints for Landlock rule addition, landlock_add_rule_fs for
filesystem rules and landlock_add_rule_net for network rules, so trace
consumers can correlate filesystem objects and network ports with their
rulesets.  Both are emitted under the ruleset lock (asserted in
TP_fast_assign) so an eBPF program reads the ruleset, including the rule
just inserted, in a consistent snapshot.

Add a version field to struct landlock_ruleset, gated on
CONFIG_TRACEPOINTS like the id field and incremented under the ruleset
lock on each successful landlock_add_rule(2), including when it only
extends an existing rule's access rights.  It fills the existing 4-byte
hole after usage, so the struct does not grow.  Pairing the ruleset ID
with the version lets a later restrict_self event record the exact
ruleset revision merged into a domain.

Resolve the filesystem rule's absolute path with d_absolute_path()
rather than the d_path() audit uses: d_absolute_path() produces
namespace-independent paths that do not depend on the tracer's chroot
state, making trace output deterministic regardless of mount namespace
configuration.  Distinguish the error cases as "<too_long>"
(-ENAMETOOLONG) and "<unreachable>" (anonymous files or detached
mounts).

Also add __trace_print_untrusted_str(), a static inline helper in the
header guarded by CREATE_TRACE_POINTS: it escapes separators, quotes,
backslashes, and non-printable bytes via string_escape_mem() so an
untrusted string (the path here, process names in later denial events)
cannot inject field separators or control characters into the ftrace
text output.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260722171159.2776765-10-mic@digikod.net
- Adapt to the landlock_rule_insert() -> landlock_store_rule()
  rename.
- Move DEFINE_FREE(__putname) from include/linux/fs.h to the Landlock
  filesystem header, so the series carries no VFS change and merges
  through the Landlock tree.
- Fold the untrusted-string escaping helper into this patch as a static
  inline __trace_print_untrusted_str() in the event header under
  CREATE_TRACE_POINTS, dropping the standalone patch (reviewed by
  Tingmao Wang):
  https://patch.msgid.link/20260722171159.2776765-8-mic@digikod.net
- Give __trace_print_untrusted_str() an explicit length argument
  (__get_dynamic_array_len() - 1) instead of strlen(), so an
  abstract socket name with embedded NUL bytes is escaped in full
  rather than truncated at the first NUL.

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-8-mic@digikod.net
- Order the add_rule_net tracepoint arguments access_rights before
  port, matching add_rule_fs.
- Reformatted TP_STRUCT__entry and TP_fast_assign to kernel tracing
  convention (requested by Steven Rostedt).
- Render access_rights as symbolic names with __print_flags(), shared
  with the audit blocker names, instead of raw hex.
- Drop the tautological version static assertion (the counter tracks
  add-rule operations, not rule count) and clarify that @version is
  incremented on access-right extensions too.
- Gate the version field and its writer on CONFIG_TRACEPOINTS (only
  tracing uses it) instead of CONFIG_SECURITY_LANDLOCK_LOG, matching the
  id field.
- Adapt rule insertion to the base's quiet flag (landlock_insert_rule()
  flags argument).

Changes since v1:
https://patch.msgid.link/20250523165741.693976-5-mic@digikod.net
- Added landlock_add_rule_net tracepoint for network rules.
- Dropped key=inode:0x%lx from add_rule_fs printk, using dev/ino
  instead.
- Used ruleset Landlock ID instead of kernel pointer in printk.
- Differentiated d_absolute_path() error cases (suggested by
  Tingmao Wang).
- Moved DEFINE_FREE(__putname) to include/linux/fs.h (noticed by
  Tingmao Wang).
- Added version field to struct landlock_ruleset.
- Added version to add_rule trace events (format:
  ruleset=<id>.<version>).
- Added d_absolute_path() vs d_path() rationale to commit message.
---
 include/trace/events/landlock.h | 163 +++++++++++++++++++++++++++++++-
 security/landlock/fs.c          |  19 ++++
 security/landlock/fs.h          |  32 +++++++
 security/landlock/net.c         |  11 +++
 security/landlock/ruleset.c     |  13 ++-
 security/landlock/ruleset.h     |   7 ++
 6 files changed, 240 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 02434f770455..b378446e26a5 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -11,9 +11,57 @@
 #define _TRACE_LANDLOCK_H
 
 #include <linux/landlock.h>
+#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
 
 struct landlock_ruleset;
+struct path;
+
+#ifdef CREATE_TRACE_POINTS
+
+/*
+ * Escapes @len bytes of an untrusted string into the trace sequence @p so it
+ * cannot inject field separators or control characters into the ftrace text
+ * output, and can be unambiguously recovered.  Called from the TP_printk() of
+ * the tracepoints that expose paths and process names.  @len is passed by the
+ * caller (rather than derived with strlen()) so a name that is not
+ * NUL-terminated or carries embedded NUL bytes (an abstract socket name) is
+ * escaped in full instead of being truncated at the first NUL.
+ *
+ * Return: a pointer into @p's buffer, or NULL if @src is NULL or the buffer is
+ * exhausted (normal when the trace buffer is full).
+ */
+static inline const char *
+__trace_print_untrusted_str(struct trace_seq *p, const char *src, size_t len)
+{
+	int escaped_size;
+	char *buf;
+	size_t buf_size = seq_buf_get_buf(&p->seq, &buf);
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	/* Buffer exhaustion is normal when the trace buffer is full. */
+	if (!src || buf_size == 0)
+		return NULL;
+
+	escaped_size =
+		string_escape_mem(src, len, buf, buf_size,
+				  ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP |
+					  ESCAPE_APPEND | ESCAPE_OCTAL,
+				  " ='\"\\");
+	if (unlikely(escaped_size >= buf_size)) {
+		/* We need some room for the final '\0'. */
+		seq_buf_set_overflow(&p->seq);
+		p->full = 1;
+		return NULL;
+	}
+	seq_buf_commit(&p->seq, escaped_size);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+#endif /* CREATE_TRACE_POINTS */
 
 /* clang-format off */
 
@@ -65,6 +113,14 @@ struct landlock_ruleset;
  * lockless snapshot instead: a task's comm, and the deny_access_net struct
  * sock (whose network hook holds no socket lock), matching how the sched
  * and signal trace events sample comm.
+ *
+ * Field encoding
+ * ~~~~~~~~~~~~~~
+ *
+ * Fields that mirror the Landlock UAPI use the same C types and endianness
+ * (e.g. network ports are __u64 in host endianness, like
+ * landlock_net_port_attr.port).  Per-event details, such as where a value
+ * is byte-swapped, live in the field's own kdoc.
  */
 
 /**
@@ -86,6 +142,7 @@ TRACE_EVENT(landlock_create_ruleset,
 
 	TP_STRUCT__entry(
 		__field(	__u64,		ruleset_id	)
+		__field(	__u32,		ruleset_version	)
 		__field(	access_mask_t,	handled_fs	)
 		__field(	access_mask_t,	handled_net	)
 		__field(	access_mask_t,	scoped		)
@@ -93,13 +150,14 @@ TRACE_EVENT(landlock_create_ruleset,
 
 	TP_fast_assign(
 		__entry->ruleset_id	= ruleset->id;
+		__entry->ruleset_version = ruleset->version;
 		__entry->handled_fs	= ruleset->handled_masks.fs;
 		__entry->handled_net	= ruleset->handled_masks.net;
 		__entry->scoped		= ruleset->handled_masks.scope;
 	),
 
-	TP_printk("ruleset=%llx handled_fs=%s handled_net=%s scoped=%s",
-		__entry->ruleset_id,
+	TP_printk("ruleset=%llx.%u handled_fs=%s handled_net=%s scoped=%s",
+		__entry->ruleset_id, __entry->ruleset_version,
 		__print_flags(__entry->handled_fs, "|", _LANDLOCK_ACCESS_FS_NAMES),
 		__print_flags(__entry->handled_net, "|", _LANDLOCK_ACCESS_NET_NAMES),
 		__print_flags(__entry->scoped, "|", _LANDLOCK_SCOPE_NAMES))
@@ -124,13 +182,112 @@ TRACE_EVENT(landlock_free_ruleset,
 
 	TP_STRUCT__entry(
 		__field(	__u64,		ruleset_id	)
+		__field(	__u32,		ruleset_version	)
+	),
+
+	TP_fast_assign(
+		__entry->ruleset_id	= ruleset->id;
+		__entry->ruleset_version = ruleset->version;
+	),
+
+	TP_printk("ruleset=%llx.%u",
+		__entry->ruleset_id, __entry->ruleset_version)
+);
+
+/**
+ * landlock_add_rule_fs - Filesystem rule added to a ruleset
+ *
+ * @ruleset: Source ruleset (never NULL).
+ * @access_rights: Effective access mask stored in the rule, not the raw
+ *                 sys_landlock_add_rule() argument (unhandled rights
+ *                 added).
+ * @path: Filesystem path for the rule (never NULL).
+ * @pathname: Resolved absolute path string (never NULL; error placeholder
+ *            on resolution failure).
+ *
+ * Emitted by sys_landlock_add_rule() under the modified ruleset's lock, so
+ * the reported ruleset is a stable snapshot that no concurrent writer can
+ * change.
+ */
+TRACE_EVENT(landlock_add_rule_fs,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset,
+		 access_mask_t access_rights, const struct path *path,
+		 const char *pathname),
+
+	TP_ARGS(ruleset, access_rights, path, pathname),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		ruleset_id	)
+		__field(	__u32,		ruleset_version	)
+		__field(	access_mask_t,	access_rights	)
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+		__string(	pathname,	pathname	)
+	),
+
+	TP_fast_assign(
+		lockdep_assert_held(&ruleset->lock);
+		__entry->ruleset_id	= ruleset->id;
+		__entry->ruleset_version = ruleset->version;
+		__entry->access_rights	= access_rights;
+		__entry->dev		= path->dentry->d_sb->s_dev;
+		/*
+		 * The inode number may not be the user-visible one,
+		 * but it will be the same used by audit.
+		 */
+		__entry->ino		= d_backing_inode(path->dentry)->i_ino;
+		__assign_str(pathname);
+	),
+
+	TP_printk("ruleset=%llx.%u access_rights=%s dev=%u:%u ino=%lu path=%s",
+		__entry->ruleset_id, __entry->ruleset_version,
+		__print_flags(__entry->access_rights, "|", _LANDLOCK_ACCESS_FS_NAMES),
+		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
+		__trace_print_untrusted_str(p, __get_str(pathname),
+					    __get_dynamic_array_len(pathname) - 1))
+);
+
+/**
+ * landlock_add_rule_net - Network port rule added to a ruleset
+ *
+ * @ruleset: Source ruleset (never NULL).
+ * @access_rights: Effective access mask stored in the rule, not the raw
+ *                 sys_landlock_add_rule() argument (unhandled rights
+ *                 added).
+ * @port: Network port, the landlock_net_port_attr.port UAPI value
+ *        forwarded directly.
+ *
+ * Emitted by sys_landlock_add_rule() under the modified ruleset's lock, so
+ * the reported ruleset is a stable snapshot that no concurrent writer can
+ * change.
+ */
+TRACE_EVENT(landlock_add_rule_net,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset,
+		 access_mask_t access_rights, __u64 port),
+
+	TP_ARGS(ruleset, access_rights, port),
+
+	TP_STRUCT__entry(
+		__field(	__u64,		ruleset_id	)
+		__field(	__u32,		ruleset_version	)
+		__field(	access_mask_t,	access_rights	)
+		__field(	__u64,		port		)
 	),
 
 	TP_fast_assign(
+		lockdep_assert_held(&ruleset->lock);
 		__entry->ruleset_id	= ruleset->id;
+		__entry->ruleset_version = ruleset->version;
+		__entry->access_rights	= access_rights;
+		__entry->port		= port;
 	),
 
-	TP_printk("ruleset=%llx", __entry->ruleset_id)
+	TP_printk("ruleset=%llx.%u access_rights=%s port=%llu",
+		__entry->ruleset_id, __entry->ruleset_version,
+		__print_flags(__entry->access_rights, "|", _LANDLOCK_ACCESS_NET_NAMES),
+		__entry->port)
 );
 
 #undef _LANDLOCK_NAME_ENTRY
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3ff5fd24378f..3a33e7393e25 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -53,6 +53,8 @@
 #include "ruleset.h"
 #include "setup.h"
 
+#include <trace/events/landlock.h>
+
 /* Underlying object management */
 
 static void release_inode(struct landlock_object *const object)
@@ -347,7 +349,24 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+
+	/*
+	 * Emit after the rule insertion succeeds, so every event corresponds to
+	 * a rule that is actually in the ruleset.  The ruleset lock is still
+	 * held for BTF consistency (enforced by lockdep_assert_held in
+	 * TP_fast_assign).
+	 */
+	if (!err && trace_landlock_add_rule_fs_enabled()) {
+		char *buffer __free(__putname) = __getname();
+		const char *pathname =
+			buffer ? resolve_path_for_trace(path, buffer) :
+				 "<no_mem>";
+
+		trace_landlock_add_rule_fs(ruleset, access_rights, path,
+					   pathname);
+	}
 	mutex_unlock(&ruleset->lock);
+
 	/*
 	 * No need to check for an error because landlock_insert_rule()
 	 * increments the refcount for the new object if needed.
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index c16f24e30bd5..50b3ddb8ac1c 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -11,6 +11,7 @@
 #define _SECURITY_LANDLOCK_FS_H
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
@@ -20,6 +21,8 @@
 #include "ruleset.h"
 #include "setup.h"
 
+DEFINE_FREE(__putname, char *, if (_T) __putname(_T))
+
 /**
  * struct landlock_inode_security - Inode security blob
  *
@@ -153,4 +156,33 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
 			    access_mask_t access_hierarchy, const u32 flags);
 
+/**
+ * resolve_path_for_trace - Resolve a path for tracepoint display
+ *
+ * @path: The path to resolve.
+ * @buf: A buffer of at least PATH_MAX bytes for the resolved path.
+ *
+ * Uses d_absolute_path() to produce a namespace-independent absolute path,
+ * unlike d_path() which resolves relative to the process's chroot.  This
+ * ensures trace output is deterministic regardless of the tracer's mount
+ * namespace.
+ *
+ * Return: A pointer into @buf with the resolved path, or an error string
+ * ("<too_long>", "<unreachable>").
+ */
+static inline const char *resolve_path_for_trace(const struct path *path,
+						 char *buf)
+{
+	const char *p;
+
+	p = d_absolute_path(path, buf, PATH_MAX);
+	if (!IS_ERR_OR_NULL(p))
+		return p;
+
+	if (PTR_ERR(p) == -ENAMETOOLONG)
+		return "<too_long>";
+
+	return "<unreachable>";
+}
+
 #endif /* _SECURITY_LANDLOCK_FS_H */
diff --git a/security/landlock/net.c b/security/landlock/net.c
index e27b3ba15664..ead97fcfdcff 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -20,6 +20,8 @@
 #include "net.h"
 #include "ruleset.h"
 
+#include <trace/events/landlock.h>
+
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			     const u16 port, access_mask_t access_rights,
 			     const u32 flags)
@@ -37,6 +39,15 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+
+	/*
+	 * Emit after the rule insertion succeeds, so every event corresponds to
+	 * a rule that is actually in the ruleset.  The ruleset lock is still
+	 * held for BTF consistency (enforced by lockdep_assert_held in
+	 * TP_fast_assign).
+	 */
+	if (!err)
+		trace_landlock_add_rule_net(ruleset, access_rights, port);
 	mutex_unlock(&ruleset->lock);
 
 	return err;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 30f3897a56d4..0d07707523cd 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2026 Cloudflare, Inc.
  */
 
 #include <linux/bits.h>
@@ -306,11 +307,19 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
 		},
 	} };
+	int err;
 
 	build_check_layer();
 	lockdep_assert_held(&ruleset->lock);
-	return landlock_store_rule(&ruleset->rules, id, &layers,
-				   ARRAY_SIZE(layers));
+	err = landlock_store_rule(&ruleset->rules, id, &layers,
+				  ARRAY_SIZE(layers));
+
+#ifdef CONFIG_TRACEPOINTS
+	if (!err)
+		ruleset->version++;
+#endif /* CONFIG_TRACEPOINTS */
+
+	return err;
 }
 
 void landlock_free_rules(struct landlock_rules *const rules)
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index dcc363740b85..b536fa0425b7 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -167,6 +167,13 @@ struct landlock_ruleset {
 	refcount_t usage;
 
 #ifdef CONFIG_TRACEPOINTS
+	/**
+	 * @version: Counter incremented on each successful
+	 * landlock_add_rule(2), including when it only extends an existing
+	 * rule's access rights.  Used by tracepoints to correlate a domain with
+	 * the exact ruleset state it was created from.  Protected by @lock.
+	 */
+	u32 version;
 	/**
 	 * @id: Unique identifier for this ruleset, used for tracing.
 	 */
-- 
2.54.0


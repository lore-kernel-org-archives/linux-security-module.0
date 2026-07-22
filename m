Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521843CE59
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740363; cv=none; b=C03QDDDsGJPsnpo7CJr2W0SudRDsyPxDhTbj/VqWYZ2nBhCQNPKSQkV6EYDzaokVAcl0+ZYK6Pk0845YP6X6/jbSpH4mWqWXQrdYaRqckcYdaiCWFg1bbbktNCuFeW6PwRpZjalYVQHCtq7D/Qf2bmHU0x9v8qde2Ys2ih3doXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740363; c=relaxed/simple;
	bh=Mep1ao1DZK9wZUk28IaL7PmZmz8Dopj9PNN2F3cUfSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpsPsvoXEmmFqZXXJDQNtM5CoGRFr21b6xc9hNg3OQZGBHWKqIoVIlAv8M8t2nHsukH2bwtkgaDlH0uYNZEIqmL7ykOa8Q0Z5y1bApvvUO8AZw1DQbfQhR+TWf3ksjurzOEhZwsKVJ+pisCrFd3qjtaAJBmCcWCWe/B6oynyubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Wn9494dI; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Wn9494dI"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515k0P5tzsxT;
	Wed, 22 Jul 2026 19:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740345;
	bh=eAnZFS8sOJ5nqRybAjinWul6Q1fZvwh/cvCBn9JRU/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wn9494dICJ0eVN4Y2jRErzkzl9JOZ9Ze7VLyR6TnHbkODTGc77r9uQi6iVRhEAvIu
	 9/izewiOgsfJ+Po3Z/Niz65UNMvGcepfSEkWH7uO/go6ZwnE+um1d5ctYfVS7THIIv
	 GzWgm/eRVyngzsFO67vWKA3EGye72032J5efZVyA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515j08WZzmyj;
	Wed, 22 Jul 2026 19:12:25 +0200 (CEST)
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
Subject: [PATCH v3 09/20] landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints
Date: Wed, 22 Jul 2026 19:11:41 +0200
Message-ID: <20260722171159.2776765-10-mic@digikod.net>
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

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

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
 include/linux/fs.h              |   1 +
 include/trace/events/landlock.h | 115 +++++++++++++++++++++++++++++++-
 security/landlock/fs.c          |  19 ++++++
 security/landlock/fs.h          |  30 +++++++++
 security/landlock/net.c         |  11 +++
 security/landlock/ruleset.c     |  13 +++-
 security/landlock/ruleset.h     |   7 ++
 7 files changed, 191 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 50ce731a2b78..925517c672f3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2587,6 +2587,7 @@ extern void __init vfs_caches_init(void);
 
 #define __getname()		kmalloc(PATH_MAX, GFP_KERNEL)
 #define __putname(name)		kfree(name)
+DEFINE_FREE(__putname, char *, if (_T) __putname(_T))
 
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 2fb717055cc8..69a75cf47f65 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -14,6 +14,7 @@
 #include <linux/tracepoint.h>
 
 struct landlock_ruleset;
+struct path;
 
 /* Maps a shared _LANDLOCK_*_NAMES entry to a __print_flags() pair. */
 #define _LANDLOCK_NAME_ENTRY(mask, name) { mask, name }
@@ -63,6 +64,14 @@ struct landlock_ruleset;
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
@@ -84,6 +93,7 @@ TRACE_EVENT(landlock_create_ruleset,
 
 	TP_STRUCT__entry(
 		__field(	__u64,		ruleset_id	)
+		__field(	__u32,		ruleset_version	)
 		__field(	access_mask_t,	handled_fs	)
 		__field(	access_mask_t,	handled_net	)
 		__field(	access_mask_t,	scoped		)
@@ -91,13 +101,14 @@ TRACE_EVENT(landlock_create_ruleset,
 
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
@@ -122,13 +133,111 @@ TRACE_EVENT(landlock_free_ruleset,
 
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
+		__print_untrusted_str(pathname))
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
index d39da6e9fa8c..48744a21d0a3 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -52,6 +52,8 @@
 #include "ruleset.h"
 #include "setup.h"
 
+#include <trace/events/landlock.h>
+
 /* Underlying object management */
 
 static void release_inode(struct landlock_object *const object)
@@ -346,7 +348,24 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
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
index c16f24e30bd5..4e3d7cbd7e1e 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -11,6 +11,7 @@
 #define _SECURITY_LANDLOCK_FS_H
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
@@ -153,4 +154,33 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
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
index 3bfee53177d8..b78714047ddf 100644
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
-	return landlock_rule_insert(&ruleset->rules, id, &layers,
-				    ARRAY_SIZE(layers));
+	err = landlock_rule_insert(&ruleset->rules, id, &layers,
+				   ARRAY_SIZE(layers));
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
index ca1fd5f4c417..799d9b3cc205 100644
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


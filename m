Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCE3845C8
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486264; cv=none; b=hKbPwfFf6auaUnytSy2s6EmYw/fndlNHaGHTEMrjVjBnyMJfCsiOn5LVD8fgkVQM6e3MzRYr00hM+NfEKctqXhXdX1m5GrtxT44vUxpEXIuIcwjzl1WCQCQGRxkxfJPE2A6A42mzTAPtXZZ1lJCNokqVNDbPLmPX5p13/XKblOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486264; c=relaxed/simple;
	bh=o3aU62PY1rJdsT14vqM2ERYH0dguIpGnEa0ik22qWio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGKkoNmf9AE7Y0lyHn4TeIeLVV1QQaFswUBcNyif79mlW0sBkusgKFufhn7PKfs1O3M3S3wSCXUDnnL7brauV16OYgSRavyxKsKJt8784c5I8BDl3L3Nk3F2e0ydIpwYRScwPrz2bXoMSgUPL8h1NOCIVrcxNfBofMGFP5VSK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FhfBWM+d; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FhfBWM+d"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkQ45Mkzwyq;
	Mon,  6 Apr 2026 16:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486254;
	bh=tA+omye7xlWXZROtfcVbta3ALYBsj9Qqwx9NRX9lTvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhfBWM+d4kILnCZL4OxWNRMqA+5rKh2fVk0wEuwC2DWB5gjBa1YAm+yGp74P2jDj9
	 f083kqMBclY2LryJOJC+ChN9iWu5b3ApbbNUArJG7b02VXXENNdNXeoWpq4cQpScpH
	 yF/sPzzM+4j5LLO4P4DdC1C5ltX4JWlGIbsXzCx4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkQ03M3zfN2;
	Mon,  6 Apr 2026 16:37:34 +0200 (CEST)
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
Subject: [PATCH v2 07/17] landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints
Date: Mon,  6 Apr 2026 16:37:05 +0200
Message-ID: <20260406143717.1815792-8-mic@digikod.net>
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

Add tracepoints for Landlock rule addition: landlock_add_rule_fs for
filesystem rules and landlock_add_rule_net for network rules.  These
enable eBPF programs and ftrace consumers to correlate filesystem
objects and network ports with their rulesets.

Both tracepoints include lockdep_assert_held(&ruleset->lock) in
TP_fast_assign to enforce that the ruleset lock is held during emission.
This guarantees that eBPF programs reading the ruleset via BTF see a
consistent version and the rule just inserted.

Add a version field to struct landlock_ruleset, incremented under the
ruleset lock on each rule insertion.  The version fills the existing
4-byte hole between usage and id (no struct size increase).  Add a
static assertion to ensure the version type can hold
LANDLOCK_MAX_NUM_RULES.

For filesystem rules, resolve the absolute path via
resolve_path_for_trace() which uses d_absolute_path().  Unlike d_path()
(used by audit), d_absolute_path() produces namespace-independent paths
that do not depend on the tracer's chroot state.  This makes trace
output deterministic regardless of mount namespace configuration.
Differentiate error cases: "<too_long>" for -ENAMETOOLONG and
"<unreachable>" for anonymous files or detached mounts.

Add DEFINE_FREE(__putname) to include/linux/fs.h alongside the
__getname()/__putname() definitions.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20250523165741.693976-5-mic@digikod.net
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
 include/linux/fs.h              |  1 +
 include/trace/events/landlock.h | 93 ++++++++++++++++++++++++++++++---
 security/landlock/fs.c          | 19 +++++++
 security/landlock/fs.h          | 30 +++++++++++
 security/landlock/net.c         | 12 +++++
 security/landlock/ruleset.c     | 21 +++++++-
 security/landlock/ruleset.h     |  6 +++
 7 files changed, 172 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..3849382fad4a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2562,6 +2562,7 @@ extern void __init vfs_caches_init(void);
 
 #define __getname()		kmalloc(PATH_MAX, GFP_KERNEL)
 #define __putname(name)		kfree(name)
+DEFINE_FREE(__putname, char *, if (_T) __putname(_T))
 
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 5e847844fbf7..f1e96c447b97 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -13,6 +13,7 @@
 #include <linux/tracepoint.h>
 
 struct landlock_ruleset;
+struct path;
 
 /**
  * DOC: Landlock trace events
@@ -41,6 +42,10 @@ struct landlock_ruleset;
  * information about all sandboxed processes on the system.  See
  * Documentation/admin-guide/LSM/landlock.rst for security considerations
  * and privilege requirements.
+ *
+ * Network port fields use __u64 in host endianness, matching the
+ * landlock_net_port_attr.port UAPI convention.  Callers convert from
+ * network byte order before emitting the event.
  */
 
 /**
@@ -56,19 +61,20 @@ TRACE_EVENT(
 
 	TP_ARGS(ruleset),
 
-	TP_STRUCT__entry(__field(__u64, ruleset_id) __field(access_mask_t,
-							    handled_fs)
+	TP_STRUCT__entry(__field(__u64, ruleset_id) __field(
+		__u32, ruleset_version) __field(access_mask_t, handled_fs)
 				 __field(access_mask_t, handled_net)
 					 __field(access_mask_t, scoped)),
 
 	TP_fast_assign(__entry->ruleset_id = ruleset->id;
+		       __entry->ruleset_version = ruleset->version;
 		       __entry->handled_fs = ruleset->layer.fs;
 		       __entry->handled_net = ruleset->layer.net;
 		       __entry->scoped = ruleset->layer.scope;),
 
-	TP_printk("ruleset=%llx handled_fs=0x%x handled_net=0x%x scoped=0x%x",
-		  __entry->ruleset_id, __entry->handled_fs,
-		  __entry->handled_net, __entry->scoped));
+	TP_printk("ruleset=%llx.%u handled_fs=0x%x handled_net=0x%x scoped=0x%x",
+		  __entry->ruleset_id, __entry->ruleset_version,
+		  __entry->handled_fs, __entry->handled_net, __entry->scoped));
 
 /**
  * landlock_free_ruleset - Ruleset freed
@@ -82,12 +88,83 @@ TRACE_EVENT(landlock_free_ruleset,
 
 	    TP_ARGS(ruleset),
 
-	    TP_STRUCT__entry(__field(__u64, ruleset_id)),
+	    TP_STRUCT__entry(__field(__u64, ruleset_id)
+				     __field(__u32, ruleset_version)),
+
+	    TP_fast_assign(__entry->ruleset_id = ruleset->id;
+			   __entry->ruleset_version = ruleset->version;),
+
+	    TP_printk("ruleset=%llx.%u", __entry->ruleset_id,
+		      __entry->ruleset_version));
+
+/**
+ * landlock_add_rule_fs - filesystem rule added to a ruleset
+ * @ruleset: Source ruleset (never NULL)
+ * @access_rights: Allowed access mask for this rule
+ * @path: Filesystem path for the rule (never NULL)
+ * @pathname: Resolved absolute path string (never NULL; error placeholder
+ *            on resolution failure)
+ */
+TRACE_EVENT(
+	landlock_add_rule_fs,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset,
+		 access_mask_t access_rights, const struct path *path,
+		 const char *pathname),
+
+	TP_ARGS(ruleset, access_rights, path, pathname),
+
+	TP_STRUCT__entry(__field(__u64, ruleset_id) __field(__u32,
+							    ruleset_version)
+				 __field(access_mask_t, access_rights)
+					 __field(dev_t, dev) __field(ino_t, ino)
+						 __string(pathname, pathname)),
+
+	TP_fast_assign(lockdep_assert_held(&ruleset->lock);
+		       __entry->ruleset_id = ruleset->id;
+		       __entry->ruleset_version = ruleset->version;
+		       __entry->access_rights = access_rights;
+		       __entry->dev = path->dentry->d_sb->s_dev;
+		       /*
+			     * The inode number may not be the user-visible one,
+			     * but it will be the same used by audit.
+			     */
+		       __entry->ino = d_backing_inode(path->dentry)->i_ino;
+		       __assign_str(pathname);),
+
+	TP_printk("ruleset=%llx.%u access_rights=0x%x dev=%u:%u ino=%lu path=%s",
+		  __entry->ruleset_id, __entry->ruleset_version,
+		  __entry->access_rights, MAJOR(__entry->dev),
+		  MINOR(__entry->dev), __entry->ino,
+		  __print_untrusted_str(pathname)));
+
+/**
+ * landlock_add_rule_net - network port rule added to a ruleset
+ * @ruleset: Source ruleset (never NULL)
+ * @port: Network port number in host endianness
+ * @access_rights: Allowed access mask for this rule
+ */
+TRACE_EVENT(landlock_add_rule_net,
+
+	    TP_PROTO(const struct landlock_ruleset *ruleset, __u64 port,
+		     access_mask_t access_rights),
+
+	    TP_ARGS(ruleset, port, access_rights),
 
-	    TP_fast_assign(__entry->ruleset_id = ruleset->id;),
+	    TP_STRUCT__entry(__field(__u64, ruleset_id) __field(__u32,
+								ruleset_version)
+				     __field(access_mask_t, access_rights)
+					     __field(__u64, port)),
 
-	    TP_printk("ruleset=%llx", __entry->ruleset_id));
+	    TP_fast_assign(lockdep_assert_held(&ruleset->lock);
+			   __entry->ruleset_id = ruleset->id;
+			   __entry->ruleset_version = ruleset->version;
+			   __entry->access_rights = access_rights;
+			   __entry->port = port;),
 
+	    TP_printk("ruleset=%llx.%u access_rights=0x%x port=%llu",
+		      __entry->ruleset_id, __entry->ruleset_version,
+		      __entry->access_rights, __entry->port));
 #endif /* _TRACE_LANDLOCK_H */
 
 /* This part must be outside protection */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a0b4d0dd261f..f627ecc537a5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -52,6 +52,8 @@
 #include "ruleset.h"
 #include "setup.h"
 
+#include <trace/events/landlock.h>
+
 /* Underlying object management */
 
 static void release_inode(struct landlock_object *const object)
@@ -345,7 +347,24 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights);
+
+	/*
+	 * Emit after the rule insertion succeeds, so every event corresponds
+	 * to a rule that is actually in the ruleset.  The ruleset lock is
+	 * still held for BTF consistency (enforced by lockdep_assert_held
+	 * in TP_fast_assign).
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
index bf9948941f2f..cc54133ae33d 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -11,6 +11,7 @@
 #define _SECURITY_LANDLOCK_FS_H
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
@@ -128,4 +129,33 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
 			    access_mask_t access_hierarchy);
 
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
+						  char *buf)
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
index 63f1fe0ec876..1e893123e787 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -20,6 +20,8 @@
 #include "net.h"
 #include "ruleset.h"
 
+#include <trace/events/landlock.h>
+
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			     const u16 port, access_mask_t access_rights)
 {
@@ -36,6 +38,16 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, id, access_rights);
+
+	/*
+	 * Emit after the rule insertion succeeds, so every event corresponds
+	 * to a rule that is actually in the ruleset.  The ruleset lock is
+	 * still held for BTF consistency (enforced by lockdep_assert_held
+	 * in TP_fast_assign).
+	 */
+	if (!err)
+		trace_landlock_add_rule_net(ruleset, port, access_rights);
+
 	mutex_unlock(&ruleset->lock);
 
 	return err;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 0d1e3dadb318..4bd997b58058 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2026 Cloudflare
  */
 
 #include <linux/bits.h>
@@ -159,8 +160,16 @@ static void build_check_ruleset(void)
 	const struct landlock_rules rules = {
 		.num_rules = ~0,
 	};
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	const struct landlock_ruleset ruleset = {
+		.version = ~0,
+	};
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	BUILD_BUG_ON(rules.num_rules < LANDLOCK_MAX_NUM_RULES);
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	BUILD_BUG_ON(ruleset.version < LANDLOCK_MAX_NUM_RULES);
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 }
 
 /**
@@ -293,11 +302,19 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		/* When @level is zero, landlock_rule_insert() extends @ruleset. */
 		.level = 0,
 	} };
+	int err;
 
 	build_check_layer();
 	lockdep_assert_held(&ruleset->lock);
-	return landlock_rule_insert(&ruleset->rules, id, &layers,
-				    ARRAY_SIZE(layers));
+	err = landlock_rule_insert(&ruleset->rules, id, &layers,
+				   ARRAY_SIZE(layers));
+
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	if (!err)
+		ruleset->version++;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+	return err;
 }
 
 void landlock_free_rules(struct landlock_rules *const rules)
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0d60e7fb8ff2..aa489ca9d450 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -156,6 +156,12 @@ struct landlock_ruleset {
 	refcount_t usage;
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	/**
+	 * @version: Monotonic counter incremented on each rule insertion.  Used
+	 * by tracepoints to correlate a domain with the exact ruleset state it
+	 * was created from.  Protected by @lock.
+	 */
+	u32 version;
 	/**
 	 * @id: Unique identifier for this ruleset, used for tracing.
 	 */
-- 
2.53.0


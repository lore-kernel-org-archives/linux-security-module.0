Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135C1BAEF8
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613436; cv=none; b=sB4WMtGFLA/vKK2JlS47PKyfJNflo98OoeS34lQjmBbyFXMZiimMP3IradTcmRJBeDWnZmo/I7TVHd2klEBlHLBkXYdGWdVBtbgQC78M2Sogh+BEr6XMP5duSjGVS9S44e1MFJJSj9SIIX/InajulXKJz4gdrLxUvX3sXMV3HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613436; c=relaxed/simple;
	bh=zmhwkIbq2Nzw7dLIYIDBKZR8BIYUBrnzSCFdbGv1tp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZArHXSa1SJJPsd22UJt6UA373OGDBRrKkQd86CGDbuaWHCGk8cxvJmfzO6PbDLV89f15+V3QhcWBKpDxwVdrqEJZf2UAHlXAUtInKzYPB95bALQmOraGCJwhURZPkDUyFWFJCUMriXhuGXzrt/7iDaBm38992m3cym+5RJBClew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1tIV8wjO; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1tIV8wjO"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwk719xz1Cdy;
	Tue, 22 Oct 2024 18:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613430;
	bh=e3cvOg21BTiTdLDc+medHtQMDJErjn7Jzic9oSgWEzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1tIV8wjOsm/jzdvdmVMugZdjmkv85++9nGs8bmOHNH3ozorVf2rUTgfSHyYXoXI07
	 /gZai/yy2kbxWNUtbl7eGoH42L+djS8v2ra2BIcVjT1zFZW5giWLIGiymPgfzjxVUa
	 6eetScbCJ+3dx2Bi9N8Qk6I9rfQ9hkZPgucSWMrg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwj3cjXz6kC;
	Tue, 22 Oct 2024 18:10:29 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 08/14] landlock: Log domain properties and release
Date: Tue, 22 Oct 2024 18:10:03 +0200
Message-ID: <20241022161009.982584-9-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Log domain informations when it denies an access.  This minimize the
amount of generated logs, which makes it possible to always log denials
since they should not happen (except with the new
LANDLOCK_RESTRICT_SELF_LOGLESS flag).  These records are identified by
AUDIT_LANDLOCK_DOM_INFO.

Domain's properties include their parent domains, which means that if a
domain was not logged before, it will be logged if one of its children
denies an access.  This means that a first denial by a domain A will
generate a record for the denial, another for the domain which is the
cause of this denial, and potentially a set of other records for each
parent domains if they were not logged before.

Log domain deletion with the AUDIT_LANDLOCK_DROP_DOMAIN record type when
a domain was previously logged.  This makes it possible for user space
to free potential resources when a domain ID will never show again.

The logged domain properties include:
- the domain ID
- its parent domain ID (or 0 if it is a root)
- its creator's PID
- its creator's UID
- its creator's executable path (exe)
- its creator's command line (comm)

This require each domain to save some task properties at creation time:
PID, credentials, exe path, and comm.

Audit record sample for a first denial:

  DENY:     domain=4533720530 blockers=ptrace opid=1 ocomm="systemd"
  DOM_INFO: domain=4533720530 parent=4533720526 pid=282 uid=0 exe="/root/sandboxer" comm="sandboxer"
  DOM_INFO: domain=4533720526 parent=0 pid=282 uid=0 exe="/root/sandboxer" comm="sandboxer"
  SYSCALL:  arch=c000003e syscall=101 success=no exit=-1 ...

Audit record sample for logged domains deletion:

  DROP: domain=4533720530
  DROP: domain=4533720526

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-9-mic@digikod.net
---

Questions:
* Should we also log the task's loginuid?
* Should we also log the task's sessionid?

Changes since v2:
* Do not log domain creation but log first domain use instead.
* Save task's properties that sandbox themselves.

Changes since v1:
* Add a ruleset's version for atomic logs.
* Rebased on the TCP patch series.
* Rename operation using "_" instead of "-".
* Rename AUDIT_LANDLOCK to AUDIT_LANDLOCK_RULESET.
* Only log when audit is enabled, but always set domain IDs.
* Don't log task's PID/TID with log_task() because it would be redundant
  with the SYSCALL record.
* Remove race condition when logging ruleset creation and logging
  ruleset modification while the related file descriptor was already
  registered but the ruleset creation not logged yet.
* Fix domain drop logs.
* Move the domain drop record from the previous patch into this one.
---
 include/uapi/linux/audit.h   |  2 +
 security/landlock/audit.c    | 78 ++++++++++++++++++++++++++++++++++++
 security/landlock/audit.h    |  7 ++++
 security/landlock/domain.c   | 35 ++++++++++++++++
 security/landlock/domain.h   | 37 +++++++++++++++++
 security/landlock/ruleset.c  |  7 ++++
 security/landlock/ruleset.h  |  1 +
 security/landlock/syscalls.c |  1 +
 8 files changed, 168 insertions(+)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 60c909c396c0..a72f7b3403be 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -147,6 +147,8 @@
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
 #define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
+#define AUDIT_LANDLOCK_DOM_INFO	1424	/* Landlock domain properties */
+#define AUDIT_LANDLOCK_DOM_DROP	1425	/* Landlock domain release */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 3c3f831f828f..f5860f396044 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -8,8 +8,11 @@
 #include <kunit/test.h>
 #include <linux/audit.h>
 #include <linux/lsm_audit.h>
+#include <linux/pid.h>
+#include <linux/uidgid.h>
 
 #include "audit.h"
+#include "cred.h"
 #include "domain.h"
 #include "ruleset.h"
 
@@ -30,6 +33,44 @@ static void log_blockers(struct audit_buffer *const ab,
 	audit_log_format(ab, "%s", get_blocker(type));
 }
 
+static void log_node(struct landlock_hierarchy *const node)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC,
+			     AUDIT_LANDLOCK_DOM_INFO);
+	if (!ab)
+		return;
+
+	WARN_ON_ONCE(node->id == 0);
+	audit_log_format(ab, "domain=%llu parent=%llu pid=%d uid=%u", node->id,
+			 node->parent ? node->parent->id : 0, pid_nr(node->pid),
+			 from_kuid(&init_user_ns, node->cred->uid));
+	audit_log_d_path(ab, " exe=", &node->exe);
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, node->comm);
+	audit_log_end(ab);
+
+	/*
+	 * There may be race condition leading to logging of the same domain
+	 * several times but that is OK.
+	 */
+	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
+}
+
+static void log_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+	struct landlock_hierarchy *walker;
+
+	if (WARN_ON_ONCE(!hierarchy))
+		return;
+
+	for (walker = hierarchy;
+	     walker && (READ_ONCE(walker->log_status) == LANDLOCK_LOG_PENDING);
+	     walker = walker->parent)
+		log_node(walker);
+}
+
 static struct landlock_hierarchy *
 get_hierarchy(const struct landlock_ruleset *const domain, size_t layer)
 {
@@ -116,6 +157,43 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	log_blockers(ab, request->type);
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
+
+	/* Logs this domain's hierarchy if it is the first time. */
+	log_hierarchy(youngest_denied);
+}
+
+/**
+ *
+ * landlock_log_drop_domain - Create an audit record when a domain is deleted
+ *
+ * Only domains which previously appeared in the audit logs are logged again.
+ * This is useful to know when a domain will never show again in the audit log.
+ *
+ * This record is not directly tied to a syscall entry.
+ *
+ * Called by the cred_free() hook, in an uninterruptible context.
+ */
+void landlock_log_drop_domain(const struct landlock_ruleset *const domain)
+{
+	struct audit_buffer *ab;
+
+	if (WARN_ON_ONCE(!domain->hierarchy))
+		return;
+
+	if (!audit_enabled)
+		return;
+
+	/* Ignores domains that were not logged.  */
+	if (READ_ONCE(domain->hierarchy->log_status) != LANDLOCK_LOG_RECORDED)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC,
+			     AUDIT_LANDLOCK_DOM_DROP);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "domain=%llu", domain->hierarchy->id);
+	audit_log_end(ab);
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index f33095afcd2f..7a1b1652f21b 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -36,11 +36,18 @@ struct landlock_request {
 
 #ifdef CONFIG_AUDIT
 
+void landlock_log_drop_domain(const struct landlock_ruleset *const domain);
+
 void landlock_log_denial(const struct landlock_ruleset *const domain,
 			 const struct landlock_request *const request);
 
 #else /* CONFIG_AUDIT */
 
+static inline void
+landlock_log_drop_domain(const struct landlock_ruleset *const domain)
+{
+}
+
 static inline void
 landlock_log_denial(const struct landlock_ruleset *const domain,
 		    const struct landlock_request *const request)
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 965e4dc21975..f57a0242e6b1 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -5,17 +5,52 @@
  * Copyright © 2024 Microsoft Corporation
  */
 
+#include <linux/cred.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+
 #include "domain.h"
 #include "id.h"
 
+static struct path get_current_exe(void)
+{
+	struct path exe_path = {};
+	struct file *exe_file;
+	struct mm_struct *mm = current->mm;
+
+	if (!mm)
+		return exe_path;
+
+	exe_file = get_mm_exe_file(mm);
+	if (!exe_file)
+		return exe_path;
+
+	exe_path = exe_file->f_path;
+	path_get(&exe_path);
+	fput(exe_file);
+	return exe_path;
+}
+
 /**
  * landlock_init_current_hierarchy - Partially initialize landlock_hierarchy
  *
  * @hierarchy: The hierarchy to initialize.
  *
+ * The current task is referenced as the domain creator.  The subjective
+ * credentials must not be in an overridden state.
+ *
  * @hierarchy->parent and @hierarchy->usage should already be set.
  */
 void landlock_init_current_hierarchy(struct landlock_hierarchy *const hierarchy)
 {
+	hierarchy->log_status = LANDLOCK_LOG_PENDING;
 	hierarchy->id = landlock_get_id(1);
+	WARN_ON_ONCE(current_cred() != current_real_cred());
+	hierarchy->cred = get_current_cred();
+	hierarchy->pid = get_pid(task_pid(current));
+	hierarchy->exe = get_current_exe();
+	get_task_comm(hierarchy->comm, current);
 }
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index f82d831ca0a7..f397a73ea0c7 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,8 +10,17 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include <linux/cred.h>
 #include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
+
+enum landlock_log_status {
+	LANDLOCK_LOG_PENDING = 0,
+	LANDLOCK_LOG_RECORDED,
+};
 
 /**
  * struct landlock_hierarchy - Node in a domain hierarchy
@@ -29,10 +38,32 @@ struct landlock_hierarchy {
 	refcount_t usage;
 
 #ifdef CONFIG_AUDIT
+	/**
+	 * @log_status: Whether this domain should be logged or not.  Because
+	 * concurrent log entries may be created at the same time, it is still
+	 * possible to have several domain records of the same domain.
+	 */
+	enum landlock_log_status log_status;
 	/**
 	 * @id: Landlock domain ID, sets once at domain creation time.
 	 */
 	u64 id;
+	/**
+	 * @cred: Credential of the domain's creator.
+	 */
+	const struct cred *cred;
+	/**
+	 * pid: Creator's PID.
+	 */
+	struct pid *pid;
+	/**
+	 * exe: Creator's exe path.
+	 */
+	struct path exe;
+	/**
+	 * comm: Command line of the domain's creator at creation time.
+	 */
+	char comm[TASK_COMM_LEN];
 #endif /* CONFIG_AUDIT */
 };
 
@@ -48,6 +79,12 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
 		const struct landlock_hierarchy *const freeme = hierarchy;
 
+#ifdef CONFIG_AUDIT
+		put_cred(hierarchy->cred);
+		put_pid(hierarchy->pid);
+		path_put(&hierarchy->exe);
+#endif /* CONFIG_AUDIT */
+
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
 	}
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 752dbadbe5ca..0a7f9d13b6f1 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -506,6 +506,9 @@ static void free_ruleset_work(struct work_struct *const work)
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		/* Logs with the current context. */
+		landlock_log_drop_domain(ruleset);
+
 		INIT_WORK(&ruleset->work_free, free_ruleset_work);
 		schedule_work(&ruleset->work_free);
 	}
@@ -517,6 +520,10 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
  * @parent: Parent domain.
  * @ruleset: New ruleset to be merged.
  *
+ * The current task is referenced as the domain creator.  The subjective
+ * credentials must not be in an overridden state (see
+ * landlock_init_current_hierarchy).
+ *
  * Returns the intersection of @parent and @ruleset, or returns @parent if
  * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
  */
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index d0a60a5f7cd9..1fe88027404b 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index c097d356fa45..335067e36feb 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -26,6 +26,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/landlock.h>
 
+#include "audit.h"
 #include "cred.h"
 #include "fs.h"
 #include "limits.h"
-- 
2.47.0


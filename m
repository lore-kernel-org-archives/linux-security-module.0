Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1540135A4B
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286469; cv=none; b=rlFjlU1LdGjEvYy+O0+NasLSU0KQzO484xqk4xtDNZ9446XuaCUoH4uKaOu0Yn0yH7/DxkT2iHaYVmM6JOMWibMNFo+xILWhd/AxXyaKtJQSN8G34reLkblCYz74sPrSvu0VP2LQ2hd6yQo9wV4LMncOQA5oj3xh4kMjLONGhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286469; c=relaxed/simple;
	bh=9/HAE6oN/4DdnJq2+IQRF9EYrlCmzEbE13r49t9ClLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M33WgfELgxK95hgH9Su6/5XY6Bc34m/4vJ6tirUmLBrHIFgfnBvxt6geaOWSgjmb8/aCwBGFmV3F1R1/1KkmUtIdoIoo2E3SDH06sdlj3RtN8rZ73LDN8AN/ZlvdmzqoRDOAa7cB5im6D9EjSJ4V+/rpcPRHhB11OUFNQRRzL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vcI8UqR6; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vcI8UqR6"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKN230Kzcpc;
	Fri, 22 Nov 2024 15:34:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286056;
	bh=4hM4h0jTTGz2zSWVoAgOj7GvhIjSm/gA9AToINwA4lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vcI8UqR6Fhm4XC/bHBEiAK2EdNHJQjf5LYbcl19m7zVyrcTFadZIGUfCCcY3lu5ux
	 19yFvTwgxwyZodlVr5B8vptopvuBUJYyLoIEwLhZjm5lnTw1BNDlL2S2s++Cs7ym65
	 QPYdrfKFg8QkHyVqYN1E3jO4rGOS6pWxRoOtm/b4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKM3njzzmn4;
	Fri, 22 Nov 2024 15:34:15 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 10/23] landlock: Log domain properties and release
Date: Fri, 22 Nov 2024 15:33:40 +0100
Message-ID: <20241122143353.59367-11-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

TODO: Update sample with audit's creation time and now-removed parent
hierarchy

Asynchronously log domain information when it first denies an access.
This minimize the amount of generated logs, which makes it possible to
always log denials since they should not happen (except with the new
LANDLOCK_RESTRICT_SELF_LOGLESS flag).  These records are identified by
AUDIT_LANDLOCK_DOM_INFO.

Log domain deletion with the AUDIT_LANDLOCK_DOM_DROP record type when
a domain was previously logged.  This makes it possible for user space
to free potential resources when a domain ID will never show again.

The logged domain properties include:
- the domain ID
- creation time
- its creator's PID
- its creator's UID
- its creator's executable path (exe)
- its creator's command line (comm)

This require each domain to save some task properties at creation time:
time, PID, credentials, exe path, and comm.

It should be noted that we cannot use audit event's serial numbers
because there may not be any related event.  However, it is still useful
to use the same potential timestamp instead of a close one.  What really
matter is how old the related Landlock domain is, not the uniquiness of
the creation time.  If audit is not enabled, Landlock creates its own
timestamp.  This timestamp will be exposed to user space with a future
unprivileged interface.

Audit event sample for a first denial:

  type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=LL_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

Audit event sample for logged domains deletion:

  type=LL_DOM_DROP msg=audit(1732186800.393:45): domain=195ba459b

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-11-mic@digikod.net
---

Questions:
- Should we also log the creator's loginuid?
- Should we also log the creator's sessionid?

Changes since v2:
- Fix docstring.
- Fix log_status check in log_hierarchy() to also log
  LANDLOCK_LOG_DISABLED.
- Add audit's creation time to domain's properties.
- Use hexadecimal notation for domain IDs.
- Remove domain's parent records: parent domains are not really useful
  in the logs.  They will be available with the upcoming introspection
  feature though.
- Extend commit message with audit's timestamp explanation.

Changes since v1:
- Add a ruleset's version for atomic logs.
- Rebased on the TCP patch series.
- Rename operation using "_" instead of "-".
- Rename AUDIT_LANDLOCK to AUDIT_LANDLOCK_RULESET.
- Only log when audit is enabled, but always set domain IDs.
- Don't log task's PID/TID with log_task() because it would be redundant
  with the SYSCALL record.
- Remove race condition when logging ruleset creation and logging
  ruleset modification while the related file descriptor was already
  registered but the ruleset creation not logged yet.
- Fix domain drop logs.
- Move the domain drop record from the previous patch into this one.
- Do not log domain creation but log first domain use instead.
- Save task's properties that sandbox themselves.
---
 include/uapi/linux/audit.h   |  2 +
 security/landlock/audit.c    | 74 ++++++++++++++++++++++++++++++++++++
 security/landlock/audit.h    |  7 ++++
 security/landlock/domain.c   | 41 ++++++++++++++++++++
 security/landlock/domain.h   | 43 +++++++++++++++++++++
 security/landlock/ruleset.c  |  7 ++++
 security/landlock/ruleset.h  |  1 +
 security/landlock/syscalls.c |  1 +
 8 files changed, 176 insertions(+)

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
index eab6b3a8a231..2d0a96797dd4 100644
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
 
@@ -30,6 +33,41 @@ static void log_blockers(struct audit_buffer *const ab,
 	audit_log_format(ab, "%s", get_blocker(type));
 }
 
+static void log_node(struct landlock_hierarchy *const node)
+{
+	struct audit_buffer *ab;
+
+	if (WARN_ON_ONCE(!node))
+		return;
+
+	/* Ignores already logged domains.  */
+	if (READ_ONCE(node->log_status) == LANDLOCK_LOG_RECORDED)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC,
+			     AUDIT_LANDLOCK_DOM_INFO);
+	if (!ab)
+		return;
+
+	WARN_ON_ONCE(node->id == 0);
+	audit_log_format(ab, "domain=%llx creation=%llu.%03lu pid=%d uid=%u",
+			 node->id,
+			 /* See audit_log_start() */
+			 (unsigned long long)node->creation.tv_sec,
+			 node->creation.tv_nsec / 1000000, pid_nr(node->pid),
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
 static struct landlock_hierarchy *
 get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
 {
@@ -116,6 +154,42 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	log_blockers(ab, request->type);
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
+
+	/* Logs this domain if it is the first time. */
+	log_node(youngest_denied);
+}
+
+/**
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
+	audit_log_format(ab, "domain=%llx", domain->hierarchy->id);
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
index 965e4dc21975..69b15c059583 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -5,17 +5,58 @@
  * Copyright © 2024 Microsoft Corporation
  */
 
+#include <linux/audit.h>
+#include <linux/cred.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/timekeeping.h>
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
+	hierarchy->creation = audit_get_ctime(audit_context());
+	if (!hierarchy->creation.tv_sec)
+		ktime_get_coarse_real_ts64(&hierarchy->creation);
+
+	hierarchy->log_status = LANDLOCK_LOG_PENDING;
 	hierarchy->id = landlock_get_id(1);
+	WARN_ON_ONCE(current_cred() != current_real_cred());
+	hierarchy->cred = get_current_cred();
+	hierarchy->pid = get_pid(task_pid(current));
+	hierarchy->exe = get_current_exe();
+	get_task_comm(hierarchy->comm, current);
 }
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index f82d831ca0a7..4a2864a66047 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,8 +10,18 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include <linux/cred.h>
 #include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/time64.h>
+
+enum landlock_log_status {
+	LANDLOCK_LOG_PENDING = 0,
+	LANDLOCK_LOG_RECORDED,
+};
 
 /**
  * struct landlock_hierarchy - Node in a domain hierarchy
@@ -29,10 +39,37 @@ struct landlock_hierarchy {
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
+	 * @creation: Time of the domain creation (i.e. syscall entry as used
+	 * in audit context).
+	 */
+	struct timespec64 creation;
+	/**
+	 * @cred: Credential of the domain's creator.
+	 */
+	const struct cred *cred;
+	/**
+	 * @pid: Creator's PID.
+	 */
+	struct pid *pid;
+	/**
+	 * @exe: Creator's exe path.
+	 */
+	struct path exe;
+	/**
+	 * @comm: Command line of the domain's creator at creation time.
+	 */
+	char comm[TASK_COMM_LEN];
 #endif /* CONFIG_AUDIT */
 };
 
@@ -48,6 +85,12 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
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
index 7a88fd9b2473..4619c7f63d05 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -508,6 +508,9 @@ static void free_ruleset_work(struct work_struct *const work)
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		/* Logs with the current context. */
+		landlock_log_drop_domain(ruleset);
+
 		INIT_WORK(&ruleset->work_free, free_ruleset_work);
 		schedule_work(&ruleset->work_free);
 	}
@@ -519,6 +522,10 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
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
index 39169b6860e3..73636f214aac 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
 #include <linux/workqueue.h>
 
 #include "access.h"
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


Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1D1F1920
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341096; cv=none; b=gfoZ2+w6wxkpS+mDPgIClWUanQWY3lyOC0YCzN2rFynuZkkbH6FUOqyX06iH7ezFBv7OTq/JE9kOHxMGdwZLwU27O1rrIAIYRICV1Tax8UV9JUAibtQvc8yKuMMUVaZqjRsLM0o5mAEm2QbxH61oe0yK4DbPHl+Xwf4wDbi1URo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341096; c=relaxed/simple;
	bh=C6hUngSl8C73AUV+wn9IB4gPxou8j4+aJ290t3Z8R4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8lDYA/EqUpAf/ygqAmsbCctsIQ+cVvBXgOkZyfRiz0GR7O6inJ5M3d7GjUV5o7XEfxswMtK3EewZCkBqUku7b0sIKRKR+MYfc3mn7hiCSHMYR0U2Xpwv5tOj1OoKGZyhdq7MAfgGYdkx895vngNlkB1YL3hD6I6H0a0O7Uc6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E6kAiV4g; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E6kAiV4g"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cN0x3JzRHk;
	Fri, 31 Jan 2025 17:31:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341091;
	bh=LxV8sh9TXrxppCho8dMbUqKXtC8gdTNonQZBwRPEq/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6kAiV4gka6o1n8PHUVui3032NRkcKAr3VdcZPclVM+zy9gtq17n73XDdpYLdzj13
	 dn1WDa6CvzWRf4FgPBEo9rd0a+MfaaW5S1eO7qWZFz05q3js9F1r5qxhYZKIWMsVWT
	 PIO8n+3RtIAljxkUIRkGbpEAL7IZqSxhkxHbrcMY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cM0K9TzcZq;
	Fri, 31 Jan 2025 17:31:31 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
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
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 10/24] landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status
Date: Fri, 31 Jan 2025 17:30:45 +0100
Message-ID: <20250131163059.1139617-11-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Asynchronously log domain information when it first denies an access.
This minimize the amount of generated logs, which makes it possible to
always log denials since they should not happen (except with the new
LANDLOCK_RESTRICT_SELF_QUIET flag).  These records are identified with
the new AUDIT_LANDLOCK_DOMAIN type.

The AUDIT_LANDLOCK_DOMAIN message contains:
- the "domain" ID which is described;
- the "status" which can either be "allocated" or "deallocated";
- the "mode" which is for now only "enforcing";
- for the "allocated" status, a minimal set of properties to easily
  identify the task that loaded the domain's policy with
  landlock_restrict_self(2): "pid", "uid", executable path ("exe"), and
  command line ("comm");
- for the "deallocated" state, the number of "denials" accounted to this
  domain, which is at least 1.

This requires each domain to save these task properties at creation
time in the new struct landlock_details.  A reference to the PID is kept
for the lifetime of the domain to avoid race conditions when
investigating the related task.  The executable path is resolved and
stored to not keep a reference to the filesystem and block related
actions.  All these metadata are stored for the lifetime of the related
domain and should then be minimal.  The required memory is not accounted
to the task calling landlock_restrict_self(2) contrary to most other
Landlock allocations (see related comment).

The AUDIT_LANDLOCK_DOMAIN record follows the first AUDIT_LANDLOCK_ACCESS
record for the same domain, which is always followed by AUDIT_SYSCALL
and AUDIT_PROCTITLE.  This is in line with the audit logic to first
record the cause of an event, and then add context with other types of
record.

Audit event sample for a first denial:

  type=LANDLOCK_ACCESS msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=LANDLOCK_DOMAIN msg=audit(1732186800.349:44): domain=195ba459b status=allocated mode=enforcing pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

Audit event sample for a following denial:

  type=LANDLOCK_ACCESS msg=audit(1732186800.372:45): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=SYSCALL msg=audit(1732186800.372:45): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

Log domain deletion with the "deallocated" state when a domain was
previously logged.  This makes it possible for log parsers to free
potential resources when a domain ID will never show again.

The number of denied access requests is useful to easily check how many
access requests a domain blocked and potentially if some of them are
missing in logs because of audit rate limiting or audit rules.  Rate
limiting could also drop this record though.

Audit event sample for a deletion of a domain that denied something:

  type=LANDLOCK_DOMAIN msg=audit(1732186800.393:46): domain=195ba459b status=deallocated denials=2

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-11-mic@digikod.net
---

Changes since v4:
- Rename AUDIT_LANDLOCK_DOM_{INFO,DROP} to AUDIT_LANDLOCK_DOMAIN and add
  a "status" field, as requested by Paul.
- Add a harcoded "mode=enforcing" to leave room for a potential future
  permissive mode, as suggested by Paul.
- Remove the "creation" timestamp, as suggested by Paul.
- Move LANDLOCK_PATH_MAX_SIZE to domain.h, check the size of the
  greatest landlock_details at build time, and improve comments.
- Improve audit check in landlock_log_drop_domain().
- Add missing headers.
- Fix typo in comment.
- Rebase on top of the landlock_log_denial() and subject type changes.

Changes since v3:
- Log number of denied access requests with AUDIT_LANDLOCK_DOM_DROP
  records, suggested by Tyler.
- Do not store a struct path pointer but the resolved string instead.
  This enables us to not block unmount of the initially restricted task
  executable's mount point.  See the new get_current_info() and
  get_current_exe().  A following patch add tests for this case.
- Create and allocate a new struct landlock_details for initially
  restricted task's information.
- Remove audit_get_ctime() call, as requested by Paul.  We now always
  have a standalone timestamp per Landlock domain creations.
- Fix docstring.

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
 include/uapi/linux/audit.h  |   1 +
 security/landlock/audit.c   |  90 ++++++++++++++++++++++++++++++--
 security/landlock/audit.h   |   7 +++
 security/landlock/domain.c  | 101 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h  |  68 ++++++++++++++++++++++++
 security/landlock/ruleset.c |   6 +++
 6 files changed, 270 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 5dd53f416a4a..9a4ecc9f6dc5 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -147,6 +147,7 @@
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
 #define AUDIT_LANDLOCK_ACCESS	1423	/* Landlock denial */
+#define AUDIT_LANDLOCK_DOMAIN	1424	/* Landlock domain status */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index b0dde6bcfb76..a5b055306757 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -8,6 +8,8 @@
 #include <kunit/test.h>
 #include <linux/audit.h>
 #include <linux/lsm_audit.h>
+#include <linux/pid.h>
+#include <linux/uidgid.h>
 
 #include "audit.h"
 #include "cred.h"
@@ -31,6 +33,40 @@ static void log_blockers(struct audit_buffer *const ab,
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
+			     AUDIT_LANDLOCK_DOMAIN);
+	if (!ab)
+		return;
+
+	WARN_ON_ONCE(node->id == 0);
+	audit_log_format(
+		ab,
+		"domain=%llx status=allocated mode=enforcing pid=%d uid=%u exe=",
+		node->id, pid_nr(node->details->pid),
+		from_kuid(&init_user_ns, node->details->cred->uid));
+	audit_log_untrustedstring(ab, node->details->exe_path);
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, node->details->comm);
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
@@ -106,16 +142,24 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (!is_valid_request(request))
 		return;
 
-	if (!unlikely(audit_context() && audit_enabled))
-		return;
-
 	youngest_layer = request->layer_plus_one - 1;
 	youngest_denied = get_hierarchy(subject->domain, youngest_layer);
 
+	/*
+	 * Consistently keeps track of the number of denied access requests
+	 * even if audit is currently disabled, if audit rules currently
+	 * exclude this record type, or if landlock_restrict_self(2)'s flags
+	 * quiet logs.
+	 */
+	atomic64_inc(&youngest_denied->num_denials);
+
 	/* Ignores denials after an execution. */
 	if (!(subject->domain_exec & (1 << youngest_layer)))
 		return;
 
+	if (!unlikely(audit_context() && audit_enabled))
+		return;
+
 	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
 			     AUDIT_LANDLOCK_ACCESS);
 	if (!ab)
@@ -125,6 +169,46 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
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
+ * @domain: The domain being deleted.
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
+	if (!unlikely(audit_enabled))
+		return;
+
+	/* Ignores domains that were not logged.  */
+	if (READ_ONCE(domain->hierarchy->log_status) != LANDLOCK_LOG_RECORDED)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC,
+			     AUDIT_LANDLOCK_DOMAIN);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "domain=%llx status=deallocated denials=%llu",
+			 domain->hierarchy->id,
+			 atomic64_read(&domain->hierarchy->num_denials));
+	audit_log_end(ab);
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index daca14d77649..0608241eb7e1 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -37,11 +37,18 @@ struct landlock_request {
 
 #ifdef CONFIG_AUDIT
 
+void landlock_log_drop_domain(const struct landlock_ruleset *const domain);
+
 void landlock_log_denial(const struct landlock_cred_security *const subject,
 			 const struct landlock_request *const request);
 
 #else /* CONFIG_AUDIT */
 
+static inline void
+landlock_log_drop_domain(const struct landlock_ruleset *const domain)
+{
+}
+
 static inline void
 landlock_log_denial(const struct landlock_cred_security *const subject,
 		    const struct landlock_request *const request)
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index f6877ae79380..6a731efca7be 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -7,21 +7,122 @@
  * Copyright © 2024-2025 Microsoft Corporation
  */
 
+#include <linux/cred.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+
 #include "domain.h"
+#include "fs.h"
 #include "id.h"
 
 #ifdef CONFIG_AUDIT
 
+/**
+ * get_current_exe - Get the current's executable path, if any
+ *
+ * @exe_str: Returned pointer to a path string with a lifetime tied to the
+ *           returned buffer, if any.
+ * @exe_size: Returned size of @exe_str (including the trailing null
+ *            character), if any.
+ *
+ * Returns: A pointer to an allocated buffer where @exe_str point to, %NULL if
+ * there is no executable path, or an error otherwise.
+ */
+static const void *get_current_exe(const char **const exe_str,
+				   size_t *const exe_size)
+{
+	const size_t buffer_size = LANDLOCK_PATH_MAX_SIZE;
+	struct mm_struct *mm = current->mm;
+	struct file *file __free(fput) = NULL;
+	char *buffer __free(kfree) = NULL;
+	const char *exe;
+	size_t size;
+
+	if (!mm)
+		return NULL;
+
+	file = get_mm_exe_file(mm);
+	if (!file)
+		return NULL;
+
+	buffer = kmalloc(buffer_size, GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+
+	exe = d_path(&file->f_path, buffer, buffer_size);
+	if (WARN_ON_ONCE(IS_ERR(exe)))
+		/* Should never happen according to LANDLOCK_PATH_MAX_SIZE. */
+		return ERR_CAST(exe);
+
+	size = buffer + buffer_size - exe;
+	if (WARN_ON_ONCE(size <= 0))
+		return ERR_PTR(-ENAMETOOLONG);
+
+	*exe_size = size;
+	*exe_str = exe;
+	return no_free_ptr(buffer);
+}
+
+/*
+ * Returns: A newly allocated object describing a domain, or an error
+ * otherwise.
+ */
+static struct landlock_details *get_current_details(void)
+{
+	/* Cf. audit_log_d_path_exe() */
+	static const char null_path[] = "(null)";
+	const char *path_str = null_path;
+	size_t path_size = sizeof(null_path);
+	const void *buffer __free(kfree) = NULL;
+	struct landlock_details *details;
+
+	buffer = get_current_exe(&path_str, &path_size);
+	if (IS_ERR(buffer))
+		return ERR_CAST(buffer);
+
+	/*
+	 * Create the new details according to the path's length.  Do not
+	 * allocate with GFP_KERNEL_ACCOUNT because it is independent from the
+	 * caller.
+	 */
+	details =
+		kzalloc(struct_size(details, exe_path, path_size), GFP_KERNEL);
+	if (!details)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(details->exe_path, path_str, path_size);
+	WARN_ON_ONCE(current_cred() != current_real_cred());
+	details->cred = get_current_cred();
+	details->pid = get_pid(task_pid(current));
+	get_task_comm(details->comm, current);
+	return details;
+}
+
 /**
  * landlock_init_hierarchy_log - Partially initialize landlock_hierarchy
  *
  * @hierarchy: The hierarchy to initialize.
  *
+ * The current task is referenced as the domain restrictor.  The subjective
+ * credentials must not be in an overridden state.
+ *
  * @hierarchy->parent and @hierarchy->usage should already be set.
  */
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 {
+	struct landlock_details *details;
+
+	details = get_current_details();
+	if (IS_ERR(details))
+		return PTR_ERR(details);
+
+	hierarchy->details = details;
 	hierarchy->id = landlock_get_id_range(1);
+	hierarchy->log_status = LANDLOCK_LOG_PENDING;
+	atomic64_set(&hierarchy->num_denials, 0);
 	return 0;
 }
 
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 1020878180d3..008ea7a26cb2 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,8 +10,61 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include <linux/cred.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+enum landlock_log_status {
+	LANDLOCK_LOG_PENDING = 0,
+	LANDLOCK_LOG_RECORDED,
+};
+
+/**
+ * struct landlock_details - Domain's creation information
+ *
+ * Rarely accessed, mainly when logging the first domain's denial.
+ *
+ * The contained pointers are initialized at the domain creation time and never
+ * changed again.  Contrary to most other Landlock object types, this one is
+ * not allocated with GFP_KERNEL_ACCOUNT because its size may not be under the
+ * caller's control (e.g. unknown exe_path) and the data is not explicitly
+ * requested nor used by tasks.
+ */
+struct landlock_details {
+	/**
+	 * @cred: Credential of the task that initially restricted itself, at
+	 * creation time.
+	 */
+	const struct cred *cred;
+	/**
+	 * @pid: PID of the task that initially restricted itself.  It still
+	 * identifies the same task.
+	 */
+	struct pid *pid;
+	/**
+	 * @comm: Command line of the task that initially restricted itself, at
+	 * creation time.  Always NULL terminated.
+	 */
+	char comm[TASK_COMM_LEN];
+	/**
+	 * @exe_path: Executable path of the task that initially restricted
+	 * itself, at creation time.  Always NULL terminated, and never greater
+	 * than LANDLOCK_PATH_MAX_SIZE.
+	 */
+	char exe_path[];
+};
+
+/* Adds 11 extra characters for the potential " (deleted)" suffix. */
+#define LANDLOCK_PATH_MAX_SIZE (PATH_MAX + 11)
+
+/* Makes sure the greatest landlock_details can be allocated. */
+static_assert(struct_size_t(struct landlock_details, exe_path,
+			    LANDLOCK_PATH_MAX_SIZE) <= KMALLOC_MAX_SIZE);
 
 /**
  * struct landlock_hierarchy - Node in a domain hierarchy
@@ -29,10 +82,25 @@ struct landlock_hierarchy {
 	refcount_t usage;
 
 #ifdef CONFIG_AUDIT
+	/**
+	 * @log_status: Whether this domain should be logged or not.  Because
+	 * concurrent log entries may be created at the same time, it is still
+	 * possible to have several domain records of the same domain.
+	 */
+	enum landlock_log_status log_status;
+	/**
+	 * @num_denials: Number of access requests denied by this domain.
+	 * Masked (i.e. never logged) denials are still counted.
+	 */
+	atomic64_t num_denials;
 	/**
 	 * @id: Landlock domain ID, sets once at domain creation time.
 	 */
 	u64 id;
+	/**
+	 * @details: Information about the related domain.
+	 */
+	const struct landlock_details *details;
 #endif /* CONFIG_AUDIT */
 };
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ae88cb88d892..de41e8bde2e4 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -510,6 +510,9 @@ static void free_ruleset_work(struct work_struct *const work)
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		/* Logs with the current context. */
+		landlock_log_drop_domain(ruleset);
+
 		INIT_WORK(&ruleset->work_free, free_ruleset_work);
 		schedule_work(&ruleset->work_free);
 	}
@@ -521,6 +524,9 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
  * @parent: Parent domain.
  * @ruleset: New ruleset to be merged.
  *
+ * The current task is requesting to be restricted.  The subjective credentials
+ * must not be in an overridden state. cf. landlock_init_hierarchy_log().
+ *
  * Returns the intersection of @parent and @ruleset, or returns @parent if
  * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
  */
-- 
2.48.1


Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57722A4E7
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497666; cv=none; b=fqufgfBy2kwniJXHUGDyABeA34btXzxQ/Rui4yPKbjecgdZH7LrOpHjxsHe/biuAhTOeSyF2pXn/XMybYYDQqOO3QpFpDEbrIvW9wOpyBDF60OE011Iq7dXAFD0kvn+mIhUtrHM1s5UWQxRl2ofD5w3+ukE+Hj23HgCyfWvKCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497666; c=relaxed/simple;
	bh=gou4wTV07PcxiKujCVqpX8f+aZ5s5Ym6AZvcZxQW160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzK4oc0YNfPZCNsc2etNeAizF2cekGaGASHU1XYtk9GmbGGQDGiMTs64t98UpOaBDJ7f2YulHALVnvJ3rI91OSRI8Z+dE4nHHUDHsbGwSr0Ha61axCZnPRMImENs+UngRjs7u/TFkuiMl8yVhm4hsV6/jZGu6vDyDVsXEAsM86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=D9RBc3Bw; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="D9RBc3Bw"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpN2Ltqz39;
	Thu, 20 Mar 2025 20:07:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497660;
	bh=KqMTBxBGURzJjUmJJV3U0YM+1WPqEqbaX/x2mNCOafA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9RBc3Bwy1Fvt/Z5dgqa3TR7nuOxr+3ZrPg31xtkrHCNtOQlmEyA7XW9LiXJmu64P
	 rb4V25YxI8lypUOYcM8uVBDFLYRFKte/zzHM3FMq6x+zHtu9TwrepXvsrSiYSgIGa4
	 1rf/4KH0QzG/YEhU6ZpTOiqZX8m/4gdDHTsYdIk0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpM2hVNzFBF;
	Thu, 20 Mar 2025 20:07:39 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 10/28] landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain status
Date: Thu, 20 Mar 2025 20:06:59 +0100
Message-ID: <20250320190717.2287696-11-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
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
always log denials for the current execution since they should not
happen.  These records are identified with the new AUDIT_LANDLOCK_DOMAIN
type.

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
missing in logs because of audit rate limiting, audit rules, or Landlock
log configuration flags (see following commit).

Audit event sample for a deletion of a domain that denied something:

  type=LANDLOCK_DOMAIN msg=audit(1732186800.393:46): domain=195ba459b status=deallocated denials=2

Cc: Günther Noack <gnoack@google.com>
Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Improve consistency and clarity by renaming log_node() to log_domain()
  and "node" variables to "hierarchy".
- Fix unsigned integer check, reported by Dan Carpenter:
  https://lore.kernel.org/r/2425110b-b5ca-4b33-bf75-e6fca0b0de63@stanley.mountain
- Fix inconsistent memory allocation flags and explain rationale,
  spotted by Paul.
- Fix domain deallocation logs by moving the call from cred put to
  hierarchy put.  Update landlock_log_drop_domain() accordingly.  This
  required to not include domain.h in ruleset.h anymore to avoid
  recursive include.
- Free hierarchy's details when putting a hierarchy.
- Save UID instead of keeping a reference to the current cred, which is
  not useful for now.
- Clean up includes.

Changes since v5:
- Add Acked-by Paul.
- Improve comment.
- Cosmetic code move in landlock_log_denial() for consistency, and to
  get a cleaner diff regarding the non-changing audit_enabled check.
- Remove unlikely().

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
 security/landlock/domain.h  |  86 ++++++++++++++++++++++++++++++
 security/landlock/ruleset.c |   3 ++
 security/landlock/ruleset.h |   3 +-
 7 files changed, 287 insertions(+), 4 deletions(-)

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
index b0752263012a..a0e6041a1e21 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <linux/audit.h>
 #include <linux/lsm_audit.h>
+#include <linux/pid.h>
 
 #include "audit.h"
 #include "cred.h"
@@ -32,6 +33,38 @@ static void log_blockers(struct audit_buffer *const ab,
 	audit_log_format(ab, "%s", get_blocker(type));
 }
 
+static void log_domain(struct landlock_hierarchy *const hierarchy)
+{
+	struct audit_buffer *ab;
+
+	/* Ignores already logged domains.  */
+	if (READ_ONCE(hierarchy->log_status) == LANDLOCK_LOG_RECORDED)
+		return;
+
+	/* Uses consistent allocation flags wrt common_lsm_audit(). */
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_LANDLOCK_DOMAIN);
+	if (!ab)
+		return;
+
+	WARN_ON_ONCE(hierarchy->id == 0);
+	audit_log_format(
+		ab,
+		"domain=%llx status=allocated mode=enforcing pid=%d uid=%u exe=",
+		hierarchy->id, pid_nr(hierarchy->details->pid),
+		hierarchy->details->uid);
+	audit_log_untrustedstring(ab, hierarchy->details->exe_path);
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, hierarchy->details->comm);
+	audit_log_end(ab);
+
+	/*
+	 * There may be race condition leading to logging of the same domain
+	 * several times but that is OK.
+	 */
+	WRITE_ONCE(hierarchy->log_status, LANDLOCK_LOG_RECORDED);
+}
+
 static struct landlock_hierarchy *
 get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
 {
@@ -110,12 +143,20 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (!is_valid_request(request))
 		return;
 
-	if (!audit_enabled)
-		return;
-
 	youngest_layer = request->layer_plus_one - 1;
 	youngest_denied = get_hierarchy(subject->domain, youngest_layer);
 
+	/*
+	 * Consistently keeps track of the number of denied access requests
+	 * even if audit is currently disabled, or if audit rules currently
+	 * exclude this record type, or if landlock_restrict_self(2)'s flags
+	 * quiet logs.
+	 */
+	atomic64_inc(&youngest_denied->num_denials);
+
+	if (!audit_enabled)
+		return;
+
 	/* Ignores denials after an execution. */
 	if (!(subject->domain_exec & (1 << youngest_layer)))
 		return;
@@ -130,6 +171,49 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	log_blockers(ab, request->type);
 	audit_log_lsm_data(ab, &request->audit);
 	audit_log_end(ab);
+
+	/* Logs this domain the first time it shows in log. */
+	log_domain(youngest_denied);
+}
+
+/**
+ * landlock_log_drop_domain - Create an audit record on domain deallocation
+ *
+ * @hierarchy: The domain's hierarchy being deallocated.
+ *
+ * Only domains which previously appeared in the audit logs are logged again.
+ * This is useful to know when a domain will never show again in the audit log.
+ *
+ * This record is not directly tied to a syscall entry.
+ *
+ * Called by the cred_free() hook, in an uninterruptible context.
+ */
+void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
+{
+	struct audit_buffer *ab;
+
+	if (WARN_ON_ONCE(!hierarchy))
+		return;
+
+	if (!audit_enabled)
+		return;
+
+	/* Ignores domains that were not logged.  */
+	if (READ_ONCE(hierarchy->log_status) != LANDLOCK_LOG_RECORDED)
+		return;
+
+	/*
+	 * If logging of domain allocation succeeded, warns about failure to log
+	 * domain deallocation to highlight unbalanced domain lifetime logs.
+	 */
+	ab = audit_log_start(audit_context(), GFP_ATOMIC,
+			     AUDIT_LANDLOCK_DOMAIN);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "domain=%llx status=deallocated denials=%llu",
+			 hierarchy->id, atomic64_read(&hierarchy->num_denials));
+	audit_log_end(ab);
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 3a6ec7c8e7c3..40ff230316c4 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -36,11 +36,18 @@ struct landlock_request {
 
 #ifdef CONFIG_AUDIT
 
+void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
+
 void landlock_log_denial(const struct landlock_cred_security *const subject,
 			 const struct landlock_request *const request);
 
 #else /* CONFIG_AUDIT */
 
+static inline void
+landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
+{
+}
+
 static inline void
 landlock_log_denial(const struct landlock_cred_security *const subject,
 		    const struct landlock_request *const request)
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index e6367933303c..3c1715e4b1c9 100644
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
+#include <linux/uidgid.h>
+
 #include "domain.h"
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
+	ssize_t size;
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
+	details->pid = get_pid(task_pid(current));
+	details->uid = from_kuid(&init_user_ns, current_uid());
+	get_task_comm(details->comm, current);
+	return details;
+}
+
 /**
  * landlock_init_hierarchy_log - Partially initialize landlock_hierarchy
  *
  * @hierarchy: The hierarchy to initialize.
  *
+ * The current task is referenced as the domain that is enforcing the
+ * restriction.  The subjective credentials must not be in an overridden state.
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
index f8df7103bd3d..2c6f04da3628 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,8 +10,62 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include <linux/limits.h>
 #include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "audit.h"
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
+	 * @pid: PID of the task that initially restricted itself.  It still
+	 * identifies the same task.  Keeping a reference to this PID ensures that
+	 * it will not be recycled.
+	 */
+	struct pid *pid;
+	/**
+	 * @uid: UID of the task that initially restricted itself, at creation time.
+	 */
+	uid_t uid;
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
@@ -29,10 +83,25 @@ struct landlock_hierarchy {
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
 
@@ -40,6 +109,16 @@ struct landlock_hierarchy {
 
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
+static inline void
+landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
+{
+	if (WARN_ON_ONCE(!hierarchy || !hierarchy->details))
+		return;
+
+	put_pid(hierarchy->details->pid);
+	kfree(hierarchy->details);
+}
+
 #else /* CONFIG_AUDIT */
 
 static inline int
@@ -48,6 +127,11 @@ landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	return 0;
 }
 
+static inline void
+landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
+{
+}
+
 #endif /* CONFIG_AUDIT */
 
 static inline void
@@ -62,6 +146,8 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
 		const struct landlock_hierarchy *const freeme = hierarchy;
 
+		landlock_log_drop_domain(hierarchy);
+		landlock_free_hierarchy_details(hierarchy);
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
 	}
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index f273a40e9780..ce7940efea51 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -521,6 +521,9 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
  * @parent: Parent domain.
  * @ruleset: New ruleset to be merged.
  *
+ * The current task is requesting to be restricted.  The subjective credentials
+ * must not be in an overridden state. cf. landlock_init_hierarchy_log().
+ *
  * Returns the intersection of @parent and @ruleset, or returns @parent if
  * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
  */
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index bbb5996545d2..28af42d66261 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -17,10 +17,11 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
-#include "domain.h"
 #include "limits.h"
 #include "object.h"
 
+struct landlock_hierarchy;
+
 /**
  * struct landlock_layer - Access rights for a given layer
  */
-- 
2.49.0


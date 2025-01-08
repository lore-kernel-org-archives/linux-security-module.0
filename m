Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123251FF1A1
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351045; cv=none; b=MdYgczvxFJ/aAItx4e7xY8GQi8dxCA8oma5FYriO25fQLWmOjrpJPk1fAsbOxiPC3FDhTn3v3RtvMH9xcply2VYmanHRmn+k0qP+lWfXh3sbJ5Um2h2RALhONzgoOHEpSExFIYZzEUHTZFfPtnrYpaDQMC3ivNm2Bi/Qz9FbxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351045; c=relaxed/simple;
	bh=O1ptSGTMtGLCQ6gzOrMyjL3blWYC4kR7zSOgH/Pmki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxzp+4RtfJZTITJ8q5DvJdN9Wt2SZ7OoDizgOlfm3xX5DDQbZcWNNO7wlU/JtsdxG0fLf/oVTWS5rZeeC8rGzaUFc4VEoEanOvMAas5OJN52IJD5yhbIW4yPCiB60lqOWERk1x91oylQY0VinO++F4OOXGp6yiPHAyUzE6luk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nWxGquXP; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nWxGquXP"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsf81pqqz5pK;
	Wed,  8 Jan 2025 16:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351040;
	bh=3Bs0C1dXcwoJq01MaXFSE9CnXw0KoaebNmPaW/e0NYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWxGquXPef2Iq/GisAaB8LY6X9Khu6VeOv8ArtzkDs0f/SUSJG1irC94nczqbJm7P
	 cTWjRIFkaVKyrLEBOg9uBOsoN/ntbljsivecJZn8yt3P5zaLJs22W6ErpoBb5LN4Yl
	 1gAC3A9TtTfeApSjfhfeedmczpcgjt+NsHMuzWME=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsf72CXTzKcS;
	Wed,  8 Jan 2025 16:43:59 +0100 (CET)
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
Subject: [PATCH v4 09/30] landlock: Add AUDIT_LANDLOCK_DOM_{INFO,DROP} and log domain properties
Date: Wed,  8 Jan 2025 16:43:17 +0100
Message-ID: <20250108154338.1129069-10-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
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
the new AUDIT_LANDLOCK_DOM_INFO type.

The AUDIT_LANDLOCK_DOM_INFO message contains:
- the "domain" ID which is described,
- the "creation" time of this domain,
- a minimal set of properties to easily identify the task that loaded
  the domain's policy with landlock_restrict_self(2): "pid", "uid",
  executable path ("exe"), and command line ("comm").

This requires each domain to save these task properties at creation
time in the new struct landlock_details.  A reference to the PID is kept
for the lifetime of the domain to avoid race conditions when
investigating the related task.  The executable path is resolved and
stored to not keep a reference to the filesystem and block related
actions.  All these metadata are stored for the lifetime of the related
domain and should then be minimal.  The required memory is not accounted
to the task calling landlock_restrict_self(2) contrary to most other
Landlock allocations (see related comment).

The AUDIT_LANDLOCK_DOM_INFO record follows the first AUDIT_LANDLOCK_DENY
record for the same domain, which is always followed by AUDIT_SYSCALL
and AUDIT_PROCTITLE.  This is in line with the audit logic to first
record the cause of an event, and then add context with other types of
record.

Audit event sample for a first denial:

  type=LANDLOCK_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=LANDLOCK_DOM_INFO msg=audit(1732186800.349:44): domain=195ba459b creation=1732186800.345 pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
  type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

Audit event sample for a following denial:

  type=LANDLOCK_DENY msg=audit(1732186800.372:45): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=SYSCALL msg=audit(1732186800.372:45): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

Log domain deletion with the new AUDIT_LANDLOCK_DOM_DROP record type
when a domain was previously logged.  This makes it possible for log
parsers to free potential resources when a domain ID will never show
again.

The AUDIT_LANDLOCK_DOM_DROP message contains:
- the "domain" ID which is being freed,
- the number of "denials" accounted to this domain, which is at least 1.

The number of denied access requests is useful to easily check how many
access requests a domain blocked and potentially if some of them are
missing in logs because of audit rate limiting or audit rules.  Rate
limiting could also drop this record though.

Audit event sample for a deletion of a domain that denied something:

  type=LANDLOCK_DOM_DROP msg=audit(1732186800.393:46): domain=195ba459b denials=2

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-10-mic@digikod.net
---

Questions about AUDIT_LANDLOCK_DOM_INFO messages (keeping in mind that
each logged metadata may need to be stored for the lifetime of each
domain):
- Should we also log the initially restricted task's loginuid?
- Should we also log the initially restricted task's sessionid?

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
 include/uapi/linux/audit.h  |   2 +
 security/landlock/audit.c   |  88 ++++++++++++++++++++++++++++-
 security/landlock/audit.h   |   7 +++
 security/landlock/domain.c  | 109 ++++++++++++++++++++++++++++++++++++
 security/landlock/domain.h  |  63 +++++++++++++++++++++
 security/landlock/ruleset.c |   6 ++
 6 files changed, 274 insertions(+), 1 deletion(-)

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
index d90680a5026a..ccc591146f8a 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -8,6 +8,8 @@
 #include <kunit/test.h>
 #include <linux/audit.h>
 #include <linux/lsm_audit.h>
+#include <linux/pid.h>
+#include <linux/uidgid.h>
 
 #include "audit.h"
 #include "domain.h"
@@ -30,6 +32,43 @@ static void log_blockers(struct audit_buffer *const ab,
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
+	audit_log_format(
+		ab,
+		"domain=%llx creation=%llu.%03lu pid=%d uid=%u exe=", node->id,
+		/* See audit_log_start() */
+		(unsigned long long)node->details->creation.tv_sec,
+		node->details->creation.tv_nsec / 1000000,
+		pid_nr(node->details->pid),
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
@@ -103,6 +142,15 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	if (!is_valid_request(request))
 		return;
 
+	youngest_denied = get_hierarchy(domain, request->layer_plus_one - 1);
+
+	/*
+	 * Consistently keeps track of the number of denied access requests
+	 * even if audit is currently disabled or if audit rules currently
+	 * exclude this record type.
+	 */
+	atomic64_inc(&youngest_denied->num_denials);
+
 	if (!unlikely(audit_context() && audit_enabled))
 		return;
 
@@ -111,11 +159,49 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	if (!ab)
 		return;
 
-	youngest_denied = get_hierarchy(domain, request->layer_plus_one - 1);
 	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
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
+	audit_log_format(ab, "domain=%llx denials=%llu", domain->hierarchy->id,
+			 atomic64_read(&domain->hierarchy->num_denials));
+	audit_log_end(ab);
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 4a635d8bc1af..7bc67ca2e470 100644
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
index 895874285fe2..d0cb9f8683b4 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -7,10 +7,17 @@
  * Copyright © 2024-2025 Microsoft Corporation
  */
 
+#include <linux/cred.h>
+#include <linux/file.h>
 #include <linux/landlock.h>
 #include <linux/mm.h>
+#include <linux/path.h>
+#include <linux/pid.h>
+#include <linux/sched.h>
+#include <linux/timekeeping.h>
 
 #include "domain.h"
+#include "fs.h"
 #include "id.h"
 
 void landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
@@ -24,6 +31,12 @@ void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
 		const struct landlock_hierarchy *const freeme = hierarchy;
 
+#ifdef CONFIG_AUDIT
+		put_cred(hierarchy->details->cred);
+		put_pid(hierarchy->details->pid);
+		kfree(hierarchy->details);
+#endif /* CONFIG_AUDIT */
+
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
 	}
@@ -31,16 +44,112 @@ void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 
 #ifdef CONFIG_AUDIT
 
+/**
+ * get_current_exe - Get the current's executable path, if any
+ *
+ * @path_str: Returned pointer to a path string with a lifetime tied to the
+ *            returned buffer, if any.
+ * @path_size: Returned size of the @path string (including the trailing null
+ *             character), if any.
+ *
+ * Returns: A pointer to an allocated buffer where @path point to, %NULL if
+ * there is no executable path, or an error otherwise.
+ */
+static const void *get_current_exe(const char **path_str, size_t *path_size)
+{
+	struct mm_struct *mm = current->mm;
+	struct file *file __free(fput) = NULL;
+	char *buffer __free(kfree) = NULL;
+	const char *path;
+	size_t size;
+
+	/* Adds 11 extra characters for the potential " (deleted)" suffix. */
+	const size_t buffer_size = PATH_MAX + 11;
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
+	path = d_path(&file->f_path, buffer, buffer_size);
+	if (WARN_ON_ONCE(IS_ERR(path)))
+		/* Should never happen according to buffer_size. */
+		return ERR_CAST(path);
+
+	size = buffer + buffer_size - path;
+	if (WARN_ON_ONCE(size <= 0))
+		return ERR_PTR(-ENAMETOOLONG);
+
+	*path_size = size;
+	*path_str = path;
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
+	struct landlock_details *details;
+	const void *buffer __free(kfree) = NULL;
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
+	ktime_get_coarse_real_ts64(&details->creation);
+
+	WARN_ON_ONCE(current_cred() != current_real_cred());
+	details->cred = get_current_cred();
+	details->pid = get_pid(task_pid(current));
+	get_task_comm(details->comm, current);
+	return details;
+}
+
 /**
  * landlock_init_current_hierarchy - Partially initialize landlock_hierarchy
  *
  * @hierarchy: The hierarchy to initialize.
  *
+ * The current task is referenced as the domain restrictor.  The subjective
+ * credentials must not be in an overridden state.
+ *
  * @hierarchy->parent and @hierarchy->usage should already be set.
  */
 int landlock_init_current_hierarchy(struct landlock_hierarchy *const hierarchy)
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
index 514281f64b20..a7fda9c6a5a3 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -10,8 +10,57 @@
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
 #define _SECURITY_LANDLOCK_DOMAIN_H
 
+#include <linux/cred.h>
 #include <linux/landlock.h>
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
+
+/**
+ * struct landlock_details - Dommain's creation information
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
+	 * @creation: Time of the domain creation (i.e. syscall entry as used
+	 * in audit context if available).
+	 */
+	struct timespec64 creation;
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
+	 * itself, at creation time.  Always NULL terminated.
+	 */
+	char exe_path[];
+};
 
 /**
  * struct landlock_hierarchy - Node in a domain hierarchy
@@ -29,10 +78,24 @@ struct landlock_hierarchy {
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
index 3e4deb2d0aa3..cd94d4660561 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -509,6 +509,9 @@ static void free_ruleset_work(struct work_struct *const work)
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		/* Logs with the current context. */
+		landlock_log_drop_domain(ruleset);
+
 		INIT_WORK(&ruleset->work_free, free_ruleset_work);
 		schedule_work(&ruleset->work_free);
 	}
@@ -520,6 +523,9 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
  * @parent: Parent domain.
  * @ruleset: New ruleset to be merged.
  *
+ * The current task is requesting to be restricted.  The subjective credentials
+ * must not be in an overridden state (see landlock_init_current_hierarchy).
+ *
  * Returns the intersection of @parent and @ruleset, or returns @parent if
  * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
  */
-- 
2.47.1


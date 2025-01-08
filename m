Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1937204F66
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351073; cv=none; b=cHw4kMhxZtM/R1p6xq04NBDOLQCv7xPz/XI4b776XkZqv2IlW7CnNvU8cUhLud0slGpdN25i1xecj430tNOsi5Lm6a0P4yipGn6Em+vpCxlMKdTuW38KGHnjniCpmYhqYkXLXr1sEDpNrOsnwti0HVtpZdZNpE6QiqeT4kE/F5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351073; c=relaxed/simple;
	bh=+c7kVWtu91Ld4/bjYLV7+UCoOamClJkWFYzPi6U0Cs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQ1pUWYaQ52EtHMr3LJwkPY8lJq/tqh/mwq0dZZPIy71P59w48g9HSt0gacIpDa1HKKkU2n9s0XnyuX0sbzVEgG5j1ePjL+/0FCO/Q3FQfQkdBd8pRUNTh/z/SzqpXENnFerZMXwnxqtM+LM+PKHJLruZbZ1F7s3IRmvVKUtRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=B8sgXbjO; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="B8sgXbjO"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfj1pb1zrYN;
	Wed,  8 Jan 2025 16:44:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351069;
	bh=TyzYyNTr0OuZU/1uH4aeoapTCDCFto4nCvOZ+6uvQng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8sgXbjOwLGA9KHgbvgMIrSuOMl0gkLJyehxstTnxBgGTqaohGS22F1tAKR60VQ95
	 RBnkmMd9LpKXDnFUJ2HEdcWbKnsdH4yHPdu8LEmQr15O/jw9Hn8m0d0Xr1EYc0YQJQ
	 4gxuYZTW08GTScElzp1XiqsZRQjKvp4gxoFljwIY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfh31g3z2FF;
	Wed,  8 Jan 2025 16:44:28 +0100 (CET)
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
Subject: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY rule type
Date: Wed,  8 Jan 2025 16:43:36 +0100
Message-ID: <20250108154338.1129069-29-mic@digikod.net>
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

Landlock manages a set of standalone security policies, which can be
loaded by any process.  Because a sandbox policy may contain errors and
can lead to log spam, we need a way to exclude some of them.  It is
simple and it makes sense to identify Landlock domains (i.e. security
policies) per binary path that loaded such policy.

Add a new AUDIT_EXE_LANDLOCK_DENY rule type to enables system
administrator to filter logs according to the origin or the security
policy responsible for a denial.

AUDIT_EXE identifies a property of the task calling the kernel, whereas
AUDIT_EXE_LANDLOCK_DENY identifies a property of a task that restricted
the task calling the kernel.  AUDIT_EXE_LANDLOCK_DENY leverages most of
AUDIT_EXE's code to track files and compare them.

AUDIT_EXE_LANDLOCK_DENY is only handled by these audit rule lists:
- AUDIT_FILTER_EXCLUDE
- AUDIT_FILTER_EXIT
- AUDIT_FILTER_URING_EXIT

Add a new audit_set_landlock_hierarchy() helper to enrich the audit
context with the Landlock domain's creator which is the origin of the
current denial (if any).

Pass the current audit context to audit_filter() to be able to filter
according to the Landlock domain creator that denied the current action.

Add a new landlock_read_domain_exe() helper for audit to compare a
Landlock domain creator's inode and device numbers with a rule.

If scripts are not directly executed but passed to an interpreter, like
with AUDIT_EXE and /proc/self/exe, only this interpreter's path will
show in the logs.  Scripts enforcing a security policy should then be
directly executed to differentiate between different scripts.

It does not make sense to add dedicated LSM hooks because it would not
make sense to treat all current and future LSM policies the same, and
there is currently only Landlock that handles different standalone and
unprivileged security policies.  Indeed, AUDIT_EXE_LANDLOCK_DENY has a
clear semantic: it identifies the source of a Landlock denial.

In the future, we might want to extend this filtering capability with
other properties of tasks that restrict themselves with Landlock (e.g.
UID, loginuid, sessionid).  This could be useful on systems where users
can bring their own executable code (which can already spam logs).  For
now, AUDIT_EXE_LANDLOCK_DENY is enough to exclude buggy sandboxed
applications that may spam logs.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-29-mic@digikod.net
---

We could have something like this to filter Landlock domains:
  -a never,exclude -F exe_landlock_deny=/usr/bin/buggy-sandboxed-app

Changes since v3:
- New patch.
---
 include/linux/audit.h      | 11 ++++++++
 include/linux/landlock.h   | 10 +++++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             |  4 +--
 kernel/audit.h             |  5 +++-
 kernel/auditfilter.c       | 30 ++++++++++++++++++++-
 kernel/auditsc.c           | 31 ++++++++++++++++++++++
 security/landlock/audit.c  |  4 +++
 security/landlock/domain.c | 54 ++++++++++++++++++++++++++++++++++++--
 security/landlock/domain.h | 20 ++++++++++++++
 security/landlock/fs.c     |  4 +--
 security/landlock/object.h |  4 ++-
 12 files changed, 169 insertions(+), 9 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..6397bc01c0c0 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/audit_arch.h>
+#include <linux/landlock.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/fanotify.h>
@@ -305,6 +306,7 @@ extern void audit_seccomp(unsigned long syscall, long signr, int code);
 extern void audit_seccomp_actions_logged(const char *names,
 					 const char *old_names, int res);
 extern void __audit_ptrace(struct task_struct *t);
+extern void __audit_set_landlock_hierarchy(struct landlock_hierarchy *hierarchy);
 
 static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
 {
@@ -357,6 +359,12 @@ static inline void audit_syscall_exit(void *pt_regs)
 		__audit_syscall_exit(success, return_code);
 	}
 }
+static inline void
+audit_set_landlock_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	if (unlikely(audit_context() && audit_enabled))
+		__audit_set_landlock_hierarchy(hierarchy);
+}
 static inline struct filename *audit_reusename(const __user char *name)
 {
 	if (unlikely(!audit_dummy_context()))
@@ -591,6 +599,9 @@ static inline void audit_syscall_entry(int major, unsigned long a0,
 { }
 static inline void audit_syscall_exit(void *pt_regs)
 { }
+static inline void
+audit_set_landlock_hierarchy(struct landlock_hierarchy *hierarchy)
+{ }
 static inline bool audit_dummy_context(void)
 {
 	return true;
diff --git a/include/linux/landlock.h b/include/linux/landlock.h
index 8491142658a1..1b6dae8d5631 100644
--- a/include/linux/landlock.h
+++ b/include/linux/landlock.h
@@ -16,6 +16,9 @@ void landlock_get_hierarchy(struct landlock_hierarchy *hierarchy);
 
 void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy);
 
+bool landlock_read_domain_exe(const struct landlock_hierarchy *const hierarchy,
+			      ino_t *ino, dev_t *dev);
+
 #else /* CONFIG_SECURITY_LANDLOCK */
 
 static inline void landlock_get_hierarchy(struct landlock_hierarchy *hierarchy)
@@ -26,6 +29,13 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 {
 }
 
+static inline bool
+landlock_read_domain_exe(const struct landlock_hierarchy *const hierarchy,
+			 ino_t *ino, dev_t *dev)
+{
+	return false;
+}
+
 #endif /* CONFIG_SECURITY_LANDLOCK */
 
 #endif /* _LINUX_LANDLOCK_H */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index a72f7b3403be..07b69d4ef076 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -296,6 +296,7 @@
 #define AUDIT_FIELD_COMPARE	111
 #define AUDIT_EXE	112
 #define AUDIT_SADDR_FAM	113
+#define AUDIT_EXE_LANDLOCK_DENY	114
 
 #define AUDIT_ARG0      200
 #define AUDIT_ARG1      (AUDIT_ARG0+1)
diff --git a/kernel/audit.c b/kernel/audit.c
index 6a95a6077953..edde6f5ebdc7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1381,7 +1381,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (data_len < 2)
 			return -EINVAL;
 
-		err = audit_filter(msg_type, AUDIT_FILTER_USER);
+		err = audit_filter(msg_type, AUDIT_FILTER_USER, NULL);
 		if (err == 1) { /* match or error */
 			char *str = data;
 
@@ -1866,7 +1866,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
 
-	if (unlikely(!audit_filter(type, AUDIT_FILTER_EXCLUDE)))
+	if (unlikely(!audit_filter(type, AUDIT_FILTER_EXCLUDE, ctx)))
 		return NULL;
 
 	/* NOTE: don't ever fail/sleep on these two conditions:
diff --git a/kernel/audit.h b/kernel/audit.h
index 0211cb307d30..4f20574462b4 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -13,6 +13,7 @@
 #include <linux/audit.h>
 #include <linux/security.h>
 #include <linux/skbuff.h>
+#include <linux/landlock.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 #include <uapi/linux/openat2.h> // struct open_how
@@ -209,6 +210,7 @@ struct audit_context {
 	};
 	int fds[2];
 	struct audit_proctitle proctitle;
+	struct landlock_hierarchy *landlock_hierarchy;
 };
 
 extern bool audit_ever_enabled;
@@ -340,7 +342,8 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
-extern int audit_filter(int msgtype, unsigned int listtype);
+extern int audit_filter(int msgtype, unsigned int listtype,
+			const struct audit_context *ctx);
 
 extern void audit_ctl_lock(void);
 extern void audit_ctl_unlock(void);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index bceb9f58a09e..36d258229437 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -13,6 +13,7 @@
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/fs.h>
+#include <linux/landlock.h>
 #include <linux/namei.h>
 #include <linux/netlink.h>
 #include <linux/sched.h>
@@ -340,6 +341,12 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
 		if (entry->rule.listnr == AUDIT_FILTER_URING_EXIT)
 			return -EINVAL;
 		break;
+	case AUDIT_EXE_LANDLOCK_DENY:
+		if (entry->rule.listnr != AUDIT_FILTER_EXCLUDE &&
+		    entry->rule.listnr != AUDIT_FILTER_EXIT &&
+		    entry->rule.listnr != AUDIT_FILTER_URING_EXIT)
+			return -EINVAL;
+		break;
 	}
 
 	switch (entry->rule.listnr) {
@@ -407,6 +414,7 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
 	case AUDIT_FILETYPE:
 	case AUDIT_FIELD_COMPARE:
 	case AUDIT_EXE:
+	case AUDIT_EXE_LANDLOCK_DENY:
 		/* only equal and not equal valid ops */
 		if (f->op != Audit_not_equal && f->op != Audit_equal)
 			return -EINVAL;
@@ -583,6 +591,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			entry->rule.filterkey = str;
 			break;
 		case AUDIT_EXE:
+		case AUDIT_EXE_LANDLOCK_DENY:
 			if (entry->rule.exe || f_val > PATH_MAX)
 				goto exit_free;
 			str = audit_unpack_string(&bufp, &remain, f_val);
@@ -681,6 +690,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
 				audit_pack_string(&bufp, krule->filterkey);
 			break;
 		case AUDIT_EXE:
+		case AUDIT_EXE_LANDLOCK_DENY:
 			data->buflen += data->values[i] =
 				audit_pack_string(&bufp, audit_mark_path(krule->exe));
 			break;
@@ -749,6 +759,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 				return 1;
 			break;
 		case AUDIT_EXE:
+		case AUDIT_EXE_LANDLOCK_DENY:
 			/* both paths exist based on above type compare */
 			if (strcmp(audit_mark_path(a->exe),
 				   audit_mark_path(b->exe)))
@@ -877,6 +888,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 				new->filterkey = fk;
 			break;
 		case AUDIT_EXE:
+		case AUDIT_EXE_LANDLOCK_DENY:
 			err = audit_dupe_exe(new, old);
 			break;
 		}
@@ -1328,7 +1340,8 @@ int audit_compare_dname_path(const struct qstr *dname, const char *path, int par
 	return strncmp(p, dname->name, dlen);
 }
 
-int audit_filter(int msgtype, unsigned int listtype)
+int audit_filter(int msgtype, unsigned int listtype,
+		 const struct audit_context *ctx)
 {
 	struct audit_entry *e;
 	int ret = 1; /* Audit by default */
@@ -1381,6 +1394,21 @@ int audit_filter(int msgtype, unsigned int listtype)
 				if (f->op == Audit_not_equal)
 					result = !result;
 				break;
+			case AUDIT_EXE_LANDLOCK_DENY:
+				if (ctx && ctx->landlock_hierarchy) {
+					ino_t ino = 0;
+					dev_t dev = 0;
+
+					result =
+						landlock_read_domain_exe(
+							ctx->landlock_hierarchy,
+							&ino, &dev) &&
+						audit_mark_compare(e->rule.exe,
+								   ino, dev);
+					if (f->op == Audit_not_equal)
+						result = !result;
+				}
+				break;
 			default:
 				goto unlock_and_return;
 			}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 561d96affe9f..0be7542852de 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -61,6 +61,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/fsnotify_backend.h>
+#include <linux/landlock.h>
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/openat2.h> // struct open_how
@@ -501,6 +502,20 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->op == Audit_not_equal)
 				result = !result;
 			break;
+		case AUDIT_EXE_LANDLOCK_DENY:
+			if (ctx && ctx->landlock_hierarchy) {
+				ino_t ino = 0;
+				dev_t dev = 0;
+
+				result =
+					landlock_read_domain_exe(
+						ctx->landlock_hierarchy, &ino,
+						&dev) &&
+					audit_mark_compare(rule->exe, ino, dev);
+				if (f->op == Audit_not_equal)
+					result = !result;
+			}
+			break;
 		case AUDIT_UID:
 			result = audit_uid_comparator(cred->uid, f->op, f->uid);
 			break;
@@ -1025,6 +1040,10 @@ static void audit_reset_context(struct audit_context *ctx)
 	WARN_ON(!list_empty(&ctx->killed_trees));
 	audit_free_module(ctx);
 	ctx->fds[0] = -1;
+	if (ctx->landlock_hierarchy) {
+		landlock_put_hierarchy(ctx->landlock_hierarchy);
+		ctx->landlock_hierarchy = NULL;
+	}
 	ctx->type = 0; /* reset last for audit_free_*() */
 }
 
@@ -2081,6 +2100,18 @@ void __audit_syscall_exit(int success, long return_code)
 	audit_reset_context(context);
 }
 
+/**
+ * __audit_set_landlock_hierarchy - record Landlock domain denying the syscall
+ * @hierarchy: Landlock domain's hierarchy
+ */
+void __audit_set_landlock_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	struct audit_context *context = audit_context();
+
+	landlock_get_hierarchy(hierarchy);
+	context->landlock_hierarchy = hierarchy;
+}
+
 static inline void handle_one(const struct inode *inode)
 {
 	struct audit_context *context;
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index cc01a0d663f3..a2d344c24f10 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <linux/audit.h>
 #include <linux/bitops.h>
+#include <linux/landlock.h>
 #include <linux/lsm_audit.h>
 #include <linux/pid.h>
 #include <linux/uidgid.h>
@@ -422,6 +423,7 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 			get_hierarchy(domain, request->layer_plus_one - 1);
 	}
 
+	/* Static filtering. */
 	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
 		return;
 
@@ -435,6 +437,8 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	if (!unlikely(audit_context() && audit_enabled))
 		return;
 
+	/* Dynamic filtering according to the domain's creator. */
+	audit_set_landlock_hierarchy(youngest_denied);
 	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
 			     AUDIT_LANDLOCK_DENY);
 	if (!ab)
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index f1a0d1b9af7c..7fe2a48ba102 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -39,6 +39,7 @@ void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 #ifdef CONFIG_AUDIT
 		put_cred(hierarchy->details->cred);
 		put_pid(hierarchy->details->pid);
+		landlock_put_object(hierarchy->details->exe_object);
 		kfree(hierarchy->details);
 #endif /* CONFIG_AUDIT */
 
@@ -56,11 +57,13 @@ void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
  *            returned buffer, if any.
  * @path_size: Returned size of the @path string (including the trailing null
  *             character), if any.
+ * @inode: Returned inode of the executable, if any.
  *
  * Returns: A pointer to an allocated buffer where @path point to, %NULL if
  * there is no executable path, or an error otherwise.
  */
-static const void *get_current_exe(const char **path_str, size_t *path_size)
+static const void *get_current_exe(const char **path_str, size_t *path_size,
+				   struct inode **inode)
 {
 	struct mm_struct *mm = current->mm;
 	struct file *file __free(fput) = NULL;
@@ -93,6 +96,8 @@ static const void *get_current_exe(const char **path_str, size_t *path_size)
 
 	*path_size = size;
 	*path_str = path;
+	ihold(file_inode(file));
+	*inode = file_inode(file);
 	return no_free_ptr(buffer);
 }
 
@@ -108,8 +113,9 @@ static struct landlock_details *get_current_details(void)
 	size_t path_size = sizeof(null_path);
 	struct landlock_details *details;
 	const void *buffer __free(kfree) = NULL;
+	struct inode *inode __free(iput) = NULL;
 
-	buffer = get_current_exe(&path_str, &path_size);
+	buffer = get_current_exe(&path_str, &path_size, &inode);
 	if (IS_ERR(buffer))
 		return ERR_CAST(buffer);
 
@@ -125,6 +131,11 @@ static struct landlock_details *get_current_details(void)
 
 	memcpy(details->exe_path, path_str, path_size);
 	ktime_get_coarse_real_ts64(&details->creation);
+	if (inode) {
+		details->exe_object = landlock_get_inode_object(inode);
+		details->exe_ino = inode->i_ino;
+		details->exe_dev = inode->i_sb->s_dev;
+	}
 
 	WARN_ON_ONCE(current_cred() != current_real_cred());
 	details->cred = get_current_cred();
@@ -267,6 +278,45 @@ static void test_landlock_get_deny_masks(struct kunit *const test)
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
+/**
+ * landlock_read_domain_exe - Read the domain creator's exe information
+ *
+ * @ino: Returned inode number, only set if the returned value is true.
+ * @dev: Returned device number, only set if the returned value is true.
+ *
+ * Returns: True if the underlying exe's inode is still alive (i.e. its
+ * superblock was not unmounted).
+ *
+ * To avoid a race condition, the caller must make sure that the compared
+ * object could not be changed in the check window.  audit_filter() and
+ * audit_filter_rules() dereference the compared audit entry in an RCU
+ * read-side critical section, which means that the related checked ino/dev
+ * stays consistent (see audit_update_watch()).
+ */
+bool landlock_read_domain_exe(const struct landlock_hierarchy *const hierarchy,
+			      ino_t *const ino, dev_t *const dev)
+{
+	if (!hierarchy || WARN_ON_ONCE(!ino || !dev))
+		return false;
+
+	/*
+	 * If the underlying inode does not exist, this means that the inode's
+	 * superblock was unmounted, and @ino and @dev do not identify the same
+	 * file.  Similarly, a removed inode leads to the related audit rule
+	 * removal, see audit_watch_handle_event()'s handling of
+	 * FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF.
+	 *
+	 * If the underlying inode exists, this means that the returned @ino
+	 * and @dev may match an audit rule.
+	 */
+	if (!READ_ONCE(hierarchy->details->exe_object->underobj))
+		return false;
+
+	*ino = hierarchy->details->exe_ino;
+	*dev = hierarchy->details->exe_dev;
+	return true;
+}
+
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
 static struct kunit_case test_cases[] = {
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 7176043bd0ff..7cf88b2bc72d 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -19,6 +19,7 @@
 #include <linux/time64.h>
 
 #include "access.h"
+#include "object.h"
 
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
@@ -53,6 +54,25 @@ struct landlock_details {
 	 * identifies the same task.
 	 */
 	struct pid *pid;
+	/**
+	 * @exe_object: Landlock object tracking the executable binary that
+	 * restricted itself, for its whole lifetime.
+	 */
+	struct landlock_object *exe_object;
+	/**
+	 * @exe_ino: Inode number cache of the executable binary.  This should
+	 * only be read if @exe_object is not NULL, while holding the related
+	 * inode.  This is useful to avoid locking @exe_object or the
+	 * underlying inode.
+	 */
+	ino_t exe_ino;
+	/**
+	 * @exe_dev: Device number cache of the executable binary.  This should
+	 * only be read if @exe_object is not NULL, while holding the related
+	 * inode.  This is useful to avoid locking @exe_object or the
+	 * underlying inode.
+	 */
+	dev_t exe_dev;
 	/**
 	 * @comm: Command line of the task that initially restricted itself, at
 	 * creation time.  Always NULL terminated.
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4b718b669ebe..d67f0da1b782 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -64,7 +64,7 @@ static void release_inode(struct landlock_object *const object)
 	 * Protects against concurrent use by hook_sb_delete() of the reference
 	 * to the underlying inode.
 	 */
-	object->underobj = NULL;
+	WRITE_ONCE(object->underobj, NULL);
 	/*
 	 * Makes sure that if the filesystem is concurrently unmounted,
 	 * hook_sb_delete() will wait for us to finish iput().
@@ -1323,7 +1323,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		 */
 		spin_lock(&object->lock);
 		if (object->underobj == inode) {
-			object->underobj = NULL;
+			WRITE_ONCE(object->underobj, NULL);
 			spin_unlock(&object->lock);
 			rcu_read_unlock();
 
diff --git a/security/landlock/object.h b/security/landlock/object.h
index 5f28c35e8aa8..216351f45e1c 100644
--- a/security/landlock/object.h
+++ b/security/landlock/object.h
@@ -57,7 +57,9 @@ struct landlock_object {
 	/**
 	 * @underobj: Used when cleaning up an object and to mark an object as
 	 * tied to its underlying kernel structure.  This pointer is protected
-	 * by @lock.  Cf. landlock_release_inodes() and release_inode().
+	 * by @lock, but it may concurrently be checked (but not dereferenced).
+	 * Cf. landlock_release_inodes(), release_inode(), and
+	 * landlock_read_domain_exe().
 	 */
 	void *underobj;
 	union {
-- 
2.47.1


From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 12 Mar 2017 13:41:25 +0900
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
Message-ID: <1489293685-53257-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Now that security_task_alloc() hook and "struct task_struct"->security
field are revived, switch TOMOYO to use them because TOMOYO's security
context is defined based on "struct task_struct" rather than "struct cred".

By applying this patch, TOMOYO no longer uses "struct cred"->security
which means that TOMOYO is ready for running with other fully armored LSM
modules which use "struct cred"->security field.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/common.h        |  18 ++++++-
 security/tomoyo/domain.c        |   8 ++-
 security/tomoyo/gc.c            |   6 +--
 security/tomoyo/securityfs_if.c |  22 ++++----
 security/tomoyo/tomoyo.c        | 112 +++++++++++++++++++---------------------
 5 files changed, 86 insertions(+), 80 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 361e7a2..db476e1 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -911,6 +911,11 @@ struct tomoyo_policy_namespace {
 	const char *name;
 };
 
+struct tomoyo_security {
+	struct tomoyo_domain_info *tomoyo_domain_info;
+	struct tomoyo_domain_info *saved_domain_info; /* Maybe NULL. */
+};
+
 /********** Function prototypes. **********/
 
 bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
@@ -1202,7 +1207,16 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info *tomoyo_domain(void)
 {
-	return current_cred()->security;
+	struct tomoyo_security *ts = current->security;
+
+	if (ts->saved_domain_info && !current->in_execve) {
+		struct tomoyo_domain_info *domain = ts->tomoyo_domain_info;
+
+		ts->tomoyo_domain_info = ts->saved_domain_info;
+		ts->saved_domain_info = NULL;
+		atomic_dec(&domain->users);
+	}
+	return ts->tomoyo_domain_info;
 }
 
 /**
@@ -1215,7 +1229,7 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
 static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
 							    *task)
 {
-	return task_cred_xxx(task, security);
+	return ((struct tomoyo_security *) task->security)->tomoyo_domain_info;
 }
 
 /**
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 00d223e..9f981d8 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -677,6 +677,7 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
  */
 int tomoyo_find_next_domain(struct linux_binprm *bprm)
 {
+	struct tomoyo_security *ts = current->security;
 	struct tomoyo_domain_info *old_domain = tomoyo_domain();
 	struct tomoyo_domain_info *domain = NULL;
 	const char *original_name = bprm->filename;
@@ -841,8 +842,11 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	if (!domain)
 		domain = old_domain;
 	/* Update reference count on "struct tomoyo_domain_info". */
-	atomic_inc(&domain->users);
-	bprm->cred->security = domain;
+	if (domain != ts->tomoyo_domain_info) {
+		atomic_inc(&domain->users);
+		ts->saved_domain_info =	ts->tomoyo_domain_info;
+		ts->tomoyo_domain_info = domain;
+	}
 	kfree(exename.name);
 	if (!retval) {
 		ee->r.domain = domain;
diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
index 540bc29..75ae368 100644
--- a/security/tomoyo/gc.c
+++ b/security/tomoyo/gc.c
@@ -248,8 +248,8 @@ static inline void tomoyo_del_domain(struct list_head *element)
 	struct tomoyo_acl_info *tmp;
 	/*
 	 * Since this domain is referenced from neither
-	 * "struct tomoyo_io_buffer" nor "struct cred"->security, we can delete
-	 * elements without checking for is_deleted flag.
+	 * "struct tomoyo_io_buffer" nor "struct tomoyo_security",
+	 * we can delete elements without checking for is_deleted flag.
 	 */
 	list_for_each_entry_safe(acl, tmp, &domain->acl_info_list, list) {
 		tomoyo_del_acl(&acl->list);
@@ -433,7 +433,7 @@ static void tomoyo_try_to_gc(const enum tomoyo_policy_id type,
 		break;
 	case TOMOYO_ID_DOMAIN:
 		/*
-		 * Don't kfree() until all "struct cred"->security forget this
+		 * Don't kfree() until all "struct tomoyo_security" forget this
 		 * element.
 		 */
 		if (atomic_read(&container_of
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 06ab41b1..988261a 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/security.h>
+#include <linux/lsm_hooks.h> /* security_module_enable() */
 #include "common.h"
 
 /**
@@ -66,18 +67,13 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 			if (!new_domain) {
 				error = -ENOENT;
 			} else {
-				struct cred *cred = prepare_creds();
-				if (!cred) {
-					error = -ENOMEM;
-				} else {
-					struct tomoyo_domain_info *old_domain =
-						cred->security;
-					cred->security = new_domain;
-					atomic_inc(&new_domain->users);
-					atomic_dec(&old_domain->users);
-					commit_creds(cred);
-					error = 0;
-				}
+				struct tomoyo_domain_info *old_domain =
+					tomoyo_domain();
+				((struct tomoyo_security *) current->security)
+					->tomoyo_domain_info = new_domain;
+				atomic_inc(&new_domain->users);
+				atomic_dec(&old_domain->users);
+				error = 0;
 			}
 		}
 		tomoyo_read_unlock(idx);
@@ -236,7 +232,7 @@ static int __init tomoyo_initerface_init(void)
 	struct dentry *tomoyo_dir;
 
 	/* Don't create securityfs entries unless registered. */
-	if (current_cred()->security != &tomoyo_kernel_domain)
+	if (!security_module_enable("tomoyo"))
 		return 0;
 
 	tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b5fb930..0de150d 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -8,59 +8,42 @@
 #include "common.h"
 
 /**
- * tomoyo_cred_alloc_blank - Target for security_cred_alloc_blank().
+ * tomoyo_task_alloc - Target for security_task_alloc().
  *
- * @new: Pointer to "struct cred".
- * @gfp: Memory allocation flags.
+ * @task: Pointer to "struct task_struct".
+ * @clone_flags: Not used.
  *
- * Returns 0.
- */
-static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
-{
-	new->security = NULL;
-	return 0;
-}
-
-/**
- * tomoyo_cred_prepare - Target for security_prepare_creds().
- *
- * @new: Pointer to "struct cred".
- * @old: Pointer to "struct cred".
- * @gfp: Memory allocation flags.
- *
- * Returns 0.
+ * Returns 0 on success, negative value otherwise.
  */
-static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
-			       gfp_t gfp)
+static int tomoyo_task_alloc(struct task_struct *task,
+			     unsigned long clone_flags)
 {
-	struct tomoyo_domain_info *domain = old->security;
-	new->security = domain;
-	if (domain)
-		atomic_inc(&domain->users);
+	struct tomoyo_security *ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	struct tomoyo_domain_info *domain = tomoyo_domain();
+
+	if (!ts)
+		return -ENOMEM;
+	ts->tomoyo_domain_info = domain;
+	atomic_inc(&domain->users);
+	task->security = ts;
 	return 0;
 }
 
 /**
- * tomoyo_cred_transfer - Target for security_transfer_creds().
+ * tomoyo_task_free - Target for security_task_free().
  *
- * @new: Pointer to "struct cred".
- * @old: Pointer to "struct cred".
+ * @task: Pointer to "struct task_struct".
  */
-static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
+static void tomoyo_task_free(struct task_struct *task)
 {
-	tomoyo_cred_prepare(new, old, 0);
-}
+	struct tomoyo_security *ts = task->security;
+	struct tomoyo_domain_info *domain = ts->tomoyo_domain_info;
 
-/**
- * tomoyo_cred_free - Target for security_cred_free().
- *
- * @cred: Pointer to "struct cred".
- */
-static void tomoyo_cred_free(struct cred *cred)
-{
-	struct tomoyo_domain_info *domain = cred->security;
+	atomic_dec(&domain->users);
+	domain = ts->saved_domain_info;
 	if (domain)
 		atomic_dec(&domain->users);
+	kfree(ts);
 }
 
 /**
@@ -68,7 +51,7 @@ static void tomoyo_cred_free(struct cred *cred)
  *
  * @bprm: Pointer to "struct linux_binprm".
  *
- * Returns 0 on success, negative value otherwise.
+ * Returns 0.
  */
 static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 {
@@ -86,19 +69,8 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	if (!tomoyo_policy_loaded)
 		tomoyo_load_policy(bprm->filename);
 #endif
-	/*
-	 * Release reference to "struct tomoyo_domain_info" stored inside
-	 * "bprm->cred->security". New reference to "struct tomoyo_domain_info"
-	 * stored inside "bprm->cred->security" will be acquired later inside
-	 * tomoyo_find_next_domain().
-	 */
-	atomic_dec(&((struct tomoyo_domain_info *)
-		     bprm->cred->security)->users);
-	/*
-	 * Tell tomoyo_bprm_check_security() is called for the first time of an
-	 * execve operation.
-	 */
-	bprm->cred->security = NULL;
+	/* Restore and clear saved_domain_info if needed. */
+	tomoyo_domain();
 	return 0;
 }
 
@@ -111,7 +83,8 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
  */
 static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 {
-	struct tomoyo_domain_info *domain = bprm->cred->security;
+	struct tomoyo_security *ts = current->security;
+	struct tomoyo_domain_info *domain = ts->saved_domain_info;
 
 	/*
 	 * Execute permission is checked against pathname passed to do_execve()
@@ -131,6 +104,24 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 }
 
 /**
+ * tomoyo_bprm_check_security - Target for security_bprm_check().
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ */
+static void tomoyo_bprm_committed_creds(struct linux_binprm *bprm)
+{
+	struct tomoyo_security *ts = current->security;
+	struct tomoyo_domain_info *domain = ts->saved_domain_info;
+
+	/* Clear saved_domain_info if needed. */
+	if (domain) {
+		ts->saved_domain_info = NULL;
+		atomic_dec(&domain->users);
+	}
+}
+
+
+/**
  * tomoyo_inode_getattr - Target for security_inode_getattr().
  *
  * @mnt:    Pointer to "struct vfsmount".
@@ -497,12 +488,11 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  * registering TOMOYO.
  */
 static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
-	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
-	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
-	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
-	LSM_HOOK_INIT(cred_free, tomoyo_cred_free),
+	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
+	LSM_HOOK_INIT(task_free, tomoyo_task_free),
 	LSM_HOOK_INIT(bprm_set_creds, tomoyo_bprm_set_creds),
 	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
+	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
 	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
 	LSM_HOOK_INIT(file_open, tomoyo_file_open),
 	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
@@ -537,14 +527,16 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  */
 static int __init tomoyo_init(void)
 {
-	struct cred *cred = (struct cred *) current_cred();
+	static struct tomoyo_security ts = {
+		.tomoyo_domain_info = &tomoyo_kernel_domain
+	};
 
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	cred->security = &tomoyo_kernel_domain;
+	current->security = &ts;
 	tomoyo_mm_init();
 	return 0;
 }
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

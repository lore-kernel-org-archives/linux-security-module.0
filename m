From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Fri, 14 Jul 2017 19:38:36 +0900
Subject: [PATCH] LSM: Remove security_task_create() hook.
Message-ID: <1500028716-29328-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Since commit a79be238600d1a03 ("selinux: Use task_alloc hook rather than
task_create hook") changed to use task_alloc hook, task_create hook is
no longer used.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_hooks.h | 7 -------
 include/linux/security.h  | 6 ------
 kernel/fork.c             | 4 ----
 security/security.c       | 5 -----
 4 files changed, 22 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3cc9d77..575703c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -529,11 +529,6 @@
  *
  * Security hooks for task operations.
  *
- * @task_create:
- *	Check permission before creating a child process.  See the clone(2)
- *	manual page for definitions of the @clone_flags.
- *	@clone_flags contains the flags indicating what should be shared.
- *	Return 0 if permission is granted.
  * @task_alloc:
  *	@task task being allocated.
  *	@clone_flags contains the flags indicating what should be shared.
@@ -1509,7 +1504,6 @@
 	int (*file_receive)(struct file *file);
 	int (*file_open)(struct file *file, const struct cred *cred);
 
-	int (*task_create)(unsigned long clone_flags);
 	int (*task_alloc)(struct task_struct *task, unsigned long clone_flags);
 	void (*task_free)(struct task_struct *task);
 	int (*cred_alloc_blank)(struct cred *cred, gfp_t gfp);
@@ -1784,7 +1778,6 @@ struct security_hook_heads {
 	struct list_head file_send_sigiotask;
 	struct list_head file_receive;
 	struct list_head file_open;
-	struct list_head task_create;
 	struct list_head task_alloc;
 	struct list_head task_free;
 	struct list_head cred_alloc_blank;
diff --git a/include/linux/security.h b/include/linux/security.h
index b6ea1dc..458e24b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -318,7 +318,6 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file, const struct cred *cred);
-int security_task_create(unsigned long clone_flags);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
@@ -885,11 +884,6 @@ static inline int security_file_open(struct file *file,
 	return 0;
 }
 
-static inline int security_task_create(unsigned long clone_flags)
-{
-	return 0;
-}
-
 static inline int security_task_alloc(struct task_struct *task,
 				      unsigned long clone_flags)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index aa1076c..3a13a94 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1568,10 +1568,6 @@ static __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
-	retval = security_task_create(clone_flags);
-	if (retval)
-		goto fork_out;
-
 	retval = -ENOMEM;
 	p = dup_task_struct(current, node);
 	if (!p)
diff --git a/security/security.c b/security/security.c
index 3013237..55b5997 100644
--- a/security/security.c
+++ b/security/security.c
@@ -979,11 +979,6 @@ int security_file_open(struct file *file, const struct cred *cred)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
-int security_task_create(unsigned long clone_flags)
-{
-	return call_int_hook(task_create, 0, clone_flags);
-}
-
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	return call_int_hook(task_alloc, 0, task, clone_flags);
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: rgb@redhat.com (Richard Guy Briggs)
Date: Sat, 12 May 2018 21:58:21 -0400
Subject: [PATCH ghak81 RFC V2 4/5] audit: use inline function to set audit
	context
In-Reply-To: <cover.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
Message-ID: <567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Recognizing that the audit context is an internal audit value, use an
access function to set the audit context pointer for the task
rather than reaching directly into the task struct to set it.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h | 6 ++++++
 kernel/auditsc.c      | 7 +++----
 kernel/fork.c         | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 786aa8e..f7973e4 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -235,6 +235,10 @@ extern void __audit_inode_child(struct inode *parent,
 extern void __audit_seccomp(unsigned long syscall, long signr, int code);
 extern void __audit_ptrace(struct task_struct *t);
 
+static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
+{
+	task->audit_context = ctx;
+}
 static inline struct audit_context *audit_context(void)
 {
 	return current->audit_context;
@@ -472,6 +476,8 @@ static inline bool audit_dummy_context(void)
 {
 	return true;
 }
+static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
+{ }
 static inline struct audit_context *audit_context(void)
 {
 	return NULL;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ecc0c23..d441d68 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -865,7 +865,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
 		audit_filter_inodes(tsk, context);
 	}
 
-	tsk->audit_context = NULL;
+	audit_set_context(tsk, NULL);
 	return context;
 }
 
@@ -952,7 +952,7 @@ int audit_alloc(struct task_struct *tsk)
 	}
 	context->filterkey = key;
 
-	tsk->audit_context  = context;
+	audit_set_context(tsk, context);
 	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
 	return 0;
 }
@@ -1554,7 +1554,6 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
  */
 void __audit_syscall_exit(int success, long return_code)
 {
-	struct task_struct *tsk = current;
 	struct audit_context *context;
 
 	if (success)
@@ -1589,7 +1588,7 @@ void __audit_syscall_exit(int success, long return_code)
 		kfree(context->filterkey);
 		context->filterkey = NULL;
 	}
-	tsk->audit_context = context;
+	audit_set_context(current, context);
 }
 
 static inline void handle_one(const struct inode *inode)
diff --git a/kernel/fork.c b/kernel/fork.c
index 242c8c9..cd18448 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1713,7 +1713,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->start_time = ktime_get_ns();
 	p->real_start_time = ktime_get_boot_ns();
 	p->io_context = NULL;
-	p->audit_context = NULL;
+	audit_set_context(p, NULL);
 	cgroup_fork(p);
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

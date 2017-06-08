From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 8 Jun 2017 13:49:56 -0700
Subject: [PATCH 4/6] LSM: manage task security blobs
In-Reply-To: <59cec608-608e-6de6-21d9-bdec7b0ded3b@schaufler-ca.com>
References: <59cec608-608e-6de6-21d9-bdec7b0ded3b@schaufler-ca.com>
Message-ID: <3630c42a-2944-0dcf-5053-e9afd598018e@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 4/6] LSM: manage task security blobs

Move management of task security blobs into the security
infrastructure. Modules are required to identify the space
they require. At this time there are no modules that use
task blobs.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  1 +
 security/security.c       | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dc012eb..feb78e4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1895,6 +1895,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int	lbs_task;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 3c22fb1..bdf8c04 100644
--- a/security/security.c
+++ b/security/security.c
@@ -89,6 +89,7 @@ int __init security_init(void)
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
 	return 0;
@@ -248,6 +249,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /**
@@ -273,6 +275,29 @@ int lsm_file_alloc(struct file *file)
 	return 0;
 }
 
+/**
+ * lsm_task_alloc - allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_task_alloc(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	if (task->security)
+		pr_info("%s: Inbound task blob is not NULL.\n", __func__);
+#endif
+	if (blob_sizes.lbs_task == 0)
+		return 0;
+
+	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
+	if (task->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1083,6 +1108,9 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 void security_task_free(struct task_struct *task)
 {
 	call_void_hook(task_free, task);
+
+	kfree(task->security);
+	task->security = NULL;
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-- 
2.5.5


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

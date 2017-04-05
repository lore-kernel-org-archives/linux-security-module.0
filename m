From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 5 Apr 2017 14:54:30 -0700
Subject: [PATCH RFC 11/11] LSM: manage task security blobs
In-Reply-To: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
Message-ID: <94362ac4-9c2a-eeec-ee33-a209d0c37a38@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH RFC 11/11] LSM: manage task security blobs

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
index d848a0a..f36b73f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1907,6 +1907,7 @@ struct lsm_blob_sizes {
 	int	lbs_msg_msg;
 	int	lbs_sock;
 	int	lbs_superblock;
+	int	lbs_task;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 5cf3214..f8943da 100644
--- a/security/security.c
+++ b/security/security.c
@@ -104,6 +104,7 @@ int __init security_init(void)
 	pr_info("LSM: msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	pr_info("LSM: sock blob size       = %d\n", blob_sizes.lbs_sock);
 	pr_info("LSM: superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 	pr_info("LSM: secid size           = %zu\n", sizeof(struct secids));
 #endif /* CONFIG_SECURITY_LSM_DEBUG */
 
@@ -268,6 +269,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 	/*
 	 * The inode blob gets an rcu_head in addition to
 	 * what the modules might need.
@@ -460,6 +462,29 @@ int lsm_superblock_alloc(struct super_block *sb)
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
  * A secids structure contains all of the modules specific
  * secids and the secmark used to represent the combination
@@ -1422,6 +1447,9 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 void security_task_free(struct task_struct *task)
 {
 	call_void_hook(task_free, task);
+
+	kfree(task->security);
+	task->security = NULL;
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

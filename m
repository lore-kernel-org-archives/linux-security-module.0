From: sargun@sargun.me (Sargun Dhillon)
Date: Fri, 8 Dec 2017 04:24:12 +0000
Subject: [RFC v2 2/3] LSM: Add statistics about the invocation of dynamic hooks
In-Reply-To: <cover.1512704909.git.sargun@netflix.com>
References: <cover.1512704909.git.sargun@netflix.com>
Message-ID: <0d030add49ec1dfd2971e955ab7856cc536e37b1.1512704909.git.sargun@netflix.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch builds on the dynamic hooks patch. With dynamic hooks,
/sys/kernel/security/lsm doesn't really make a lot of sense, because
the administrator is more likely interested in the per-hook modules.
There is now a /sys/kernel/security/dynamic_hooks/${HOOK_NAME} which
has the currently attached LSMs for that given hook.

Not only does it list which LSMs are hooked into each dynamic hook,
but it also lists the global accept / deny count, as well as the
per-hook accept / deny count. The earlier is useful to keep consistent
statistics across the attachment, and unattachment of LSMs.

The purpose of this is similar to the purpose of something like
iptables -L -n. With the proliferation of LSMs, it's going to
be more important to have a way to understand what's going on.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h |   4 ++
 security/Kconfig          |   7 +++
 security/Makefile         |   1 +
 security/dynamic.c        |  26 ++++++++++-
 security/dynamic.h        |  14 ++++++
 security/dynamicfs.c      | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 security/inode.c          |   2 +
 security/security.c       |  21 +++++++--
 8 files changed, 179 insertions(+), 5 deletions(-)
 create mode 100644 security/dynamicfs.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9c44300fc1f8..0aa9f7616f77 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -29,6 +29,8 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 #include <linux/module.h>
+#include <linux/percpu_counter.h>
+#include <linux/percpu.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -2212,6 +2214,8 @@ enum dynamic_security_hook_type {
 };
 
 struct dynamic_security_hook {
+	struct percpu_counter		invocation;
+	struct percpu_counter		deny;
 	struct list_head		list;
 	union security_list_options	hook;
 	enum dynamic_security_hook_type type;
diff --git a/security/Kconfig b/security/Kconfig
index 77841bdb5bc5..d6c579d6099f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -94,6 +94,13 @@ config SECURITY_DYNAMIC_HOOKS
 	  They cannot circumvent the built-in LSMs.
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_DYNAMIC_HOOKS_FS
+	bool
+	default y if SECURITY_DYNAMIC_HOOKS && SECURITYFS
+	depends on SECURITY_DYNAMIC_HOOKS && SECURITYFS
+	help
+	  This option enables listing of dynamically loaded LSM hooks.
+
 config INTEL_TXT
 	bool "Enable Intel(R) Trusted Execution Technology (Intel(R) TXT)"
 	depends on HAVE_INTEL_TXT
diff --git a/security/Makefile b/security/Makefile
index 59e695a7e4b6..51cbec0fa49e 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MMU)			+= min_addr.o
 obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_DYNAMIC_HOOKS)	+= dynamic.o
+obj-$(CONFIG_SECURITY_DYNAMIC_HOOKS_FS)	+= dynamicfs.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
 obj-$(CONFIG_AUDIT)			+= lsm_audit.o
diff --git a/security/dynamic.c b/security/dynamic.c
index cc2f5d232e9a..d96a50a93bad 100644
--- a/security/dynamic.c
+++ b/security/dynamic.c
@@ -250,7 +250,17 @@ struct dynamic_hook dynamic_hooks[__MAX_DYNAMIC_SECURITY_HOOK] = {
  */
 int security_add_dynamic_hook(struct dynamic_security_hook *hook)
 {
+	int ret;
+
 	WARN_ON(!try_module_get(hook->owner));
+	ret = percpu_counter_init(&hook->invocation, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+	ret = percpu_counter_init(&hook->deny, 0, GFP_KERNEL);
+	if (ret) {
+		percpu_counter_destroy(&hook->invocation);
+		return ret;
+	}
 	mutex_lock(&dynamic_hook_lock);
 	list_add_tail_rcu(&hook->list, &dynamic_hooks[hook->type].head);
 	mutex_unlock(&dynamic_hook_lock);
@@ -262,8 +272,20 @@ EXPORT_SYMBOL_GPL(security_add_dynamic_hook);
 
 void __init security_init_dynamic_hooks(void)
 {
-	int i;
+	int i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(dynamic_hooks); i++)
+	for (i = 0; i < ARRAY_SIZE(dynamic_hooks); i++) {
 		INIT_LIST_HEAD(&dynamic_hooks[i].head);
+		ret = percpu_counter_init(&dynamic_hooks[i].invocation, 0,
+					  GFP_KERNEL);
+		if (ret)
+			panic("%s - %d - Cannot init invocation counter.\n",
+			      __func__, ret);
+		ret = percpu_counter_init(&dynamic_hooks[i].deny, 0,
+					  GFP_KERNEL);
+		if (ret)
+			panic("%s - %d - Cannot init deny counter.\n",
+			      __func__, ret);
+
+	}
 }
diff --git a/security/dynamic.h b/security/dynamic.h
index 575bc4e3d370..402cfc3f3ea3 100644
--- a/security/dynamic.h
+++ b/security/dynamic.h
@@ -2,12 +2,20 @@
 #include <linux/srcu.h>
 #include <linux/list.h>
 #include <linux/jump_label.h>
+#include <linux/percpu_counter.h>
+#include <linux/percpu.h>
+#include <linux/fs.h>
 
 #ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
 extern struct static_key_false dynamic_hooks_keys[];
 
 struct dynamic_hook {
+	struct percpu_counter	invocation;
+	struct percpu_counter	deny;
 	const char		*name;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS_FS
+	struct dentry		*dentry;
+#endif
 	struct list_head	head;
 };
 
@@ -16,3 +24,9 @@ extern void security_init_dynamic_hooks(void);
 #else
 static void security_init_dynamic_hooks(void) {}
 #endif
+
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS_FS
+extern void securityfs_init_dynamic_hooks(void);
+#else
+static void securityfs_init_dynamic_hooks(void) {}
+#endif
diff --git a/security/dynamicfs.c b/security/dynamicfs.c
new file mode 100644
index 000000000000..d7079f0acd1c
--- /dev/null
+++ b/security/dynamicfs.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <linux/percpu_counter.h>
+#include <linux/percpu.h>
+#include "dynamic.h"
+
+struct seq_private_data {
+	struct dynamic_hook *dh;
+};
+
+static void *dynamic_hooks_sop_start(struct seq_file *s, loff_t *pos)
+{
+	struct seq_private_data *pd = s->private;
+
+	return seq_list_start_head(&pd->dh->head, *pos);
+}
+
+static void *dynamic_hooks_sop_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct seq_private_data *pd = s->private;
+
+	return seq_list_next(v, &pd->dh->head, pos);
+}
+
+static int dynamic_hooks_sop_show(struct seq_file *s, void *v)
+{
+	struct seq_private_data *pd = s->private;
+	struct dynamic_security_hook *dsh;
+
+	if (v == (void *)&pd->dh->head) {
+		seq_puts(s, "name\tinvocations\tdenies\n");
+		seq_printf(s, "all\t%lld\t%lld\n",
+			   percpu_counter_sum(&pd->dh->invocation),
+			   percpu_counter_sum(&pd->dh->deny));
+		return 0;
+	}
+
+	dsh = list_entry(v, typeof(*dsh), list);
+	seq_printf(s, "%s\t%lld\t%lld\n", dsh->lsm,
+		   percpu_counter_sum(&dsh->invocation),
+		   percpu_counter_sum(&dsh->deny));
+
+	return 0;
+}
+
+static void dynamic_hooks_sop_stop(struct seq_file *s, void *v) { }
+
+static const struct seq_operations dynamic_hooks_sops = {
+	.start	= dynamic_hooks_sop_start,
+	.next	= dynamic_hooks_sop_next,
+	.show	= dynamic_hooks_sop_show,
+	.stop	= dynamic_hooks_sop_stop,
+};
+
+static int security_dynamic_hook_open(struct inode *inode, struct file *file)
+{
+	struct seq_private_data *pd;
+
+	pd = (struct seq_private_data *)__seq_open_private(file,
+							   &dynamic_hooks_sops,
+							   sizeof(*pd));
+
+	if (!pd)
+		return -ENOMEM;
+
+	pd->dh = inode->i_private;
+
+	return 0;
+}
+
+static const struct file_operations dynamic_hooks_fops = {
+	.open		= security_dynamic_hook_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static struct dentry *dynamic_hooks_dir;
+void securityfs_init_dynamic_hooks(void)
+{
+	struct dynamic_hook *dh;
+	int i;
+
+	dynamic_hooks_dir = securityfs_create_dir("dynamic_hooks", NULL);
+	if (IS_ERR(dynamic_hooks_dir)) {
+		pr_err("Unable to create dynamic hooks LSM directory - %ld\n",
+			PTR_ERR(dynamic_hooks_dir));
+		return;
+	}
+
+	for (i = 0; i < __MAX_DYNAMIC_SECURITY_HOOK; i++) {
+
+		dh = &dynamic_hooks[i];
+		dh->dentry = securityfs_create_file(dh->name, 0444,
+						    dynamic_hooks_dir, dh,
+						    &dynamic_hooks_fops);
+		if (IS_ERR(dh->dentry))
+			goto err;
+	}
+	return;
+
+err:
+	pr_err("Unable to create dynamic hook directory - %s - %ld\n",
+	       dh->name, PTR_ERR(dh->dentry));
+}
diff --git a/security/inode.c b/security/inode.c
index 8dd9ca8848e4..0862be12a340 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include "dynamic.h"
 
 static struct vfsmount *mount;
 static int mount_count;
@@ -335,6 +336,7 @@ static int __init securityfs_init(void)
 		sysfs_remove_mount_point(kernel_kobj, "security");
 		return retval;
 	}
+	securityfs_init_dynamic_hooks();
 #ifdef CONFIG_SECURITY
 	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
 						&lsm_ops);
diff --git a/security/security.c b/security/security.c
index 278f46ac8fc3..efb9bdd42ece 100644
--- a/security/security.c
+++ b/security/security.c
@@ -213,8 +213,11 @@ static_branch_unlikely(&dynamic_hooks_keys[DYNAMIC_SECURITY_HOOK_##FUNC])
 	struct dynamic_security_hook *dsh;			\
 	struct dynamic_hook *dh;				\
 	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_##FUNC];	\
-	list_for_each_entry_rcu(dsh, &dh->head, list)		\
+	percpu_counter_inc(&dh->invocation);			\
+	list_for_each_entry_rcu(dsh, &dh->head, list) {		\
+		percpu_counter_inc(&dsh->invocation);		\
 		dsh->hook.FUNC(__VA_ARGS__);			\
+	}							\
 })
 
 #define call_void_hook(FUNC, ...)				\
@@ -244,10 +247,15 @@ static_branch_unlikely(&dynamic_hooks_keys[DYNAMIC_SECURITY_HOOK_##FUNC])
 		if (!continue_iteration)				\
 			break;						\
 		dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_##FUNC];	\
+		percpu_counter_inc(&dh->invocation);			\
 		list_for_each_entry(dsh, &dh->head, list) {		\
+			percpu_counter_inc(&dsh->invocation);		\
 			RC = dsh->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)					\
+			if (RC != 0) {					\
+				percpu_counter_inc(&dh->deny);		\
+				percpu_counter_inc(&dsh->deny);		\
 				break;					\
+			}						\
 		}							\
 	} while (0);							\
 	RC;								\
@@ -368,10 +376,15 @@ static int dynamic_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 		return 1;
 
 	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_vm_enough_memory];
+	percpu_counter_inc(&dh->invocation);
 	list_for_each_entry(dsh, &dh->head, list) {
+		percpu_counter_inc(&dsh->invocation);
 		rc = dsh->hook.vm_enough_memory(mm, pages);
-		if (rc <= 0)
+		if (rc <= 0) {
+			percpu_counter_inc(&dh->deny);
+			percpu_counter_inc(&dsh->deny);
 			break;
+		}
 	}
 	return rc;
 }
@@ -1215,7 +1228,9 @@ static int dynamic_task_prctl(int option, unsigned long arg2,
 		goto out;
 
 	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_task_prctl];
+	percpu_counter_inc(&dh->invocation);
 	list_for_each_entry(dsh, &dh->head, list) {
+		percpu_counter_inc(&dsh->invocation);
 		thisrc = dsh->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

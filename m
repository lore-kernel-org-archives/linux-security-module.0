From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 25 Apr 2018 08:58:56 +0000
Subject: [PATCH v7 1/6] security: Move LSM registration arguments to struct
	lsm_info
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <4184e7f3f244968a4fa411b8b91842665f317202.1524645853.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Previously, when LSMs registered, they independently passed their name
and hook count. This had two implications:

1) Is required us to clone the name, so we could present it in
   security FS. This required memory allocation at start time.
2) Every time we wanted to tie more information back from
   the security hooks, to the LSM, we would have to add
   duplicated fields in struct security_hook_list.

It also introduces a new file -- security/security.h, which is meant
to be private headers to be shared only between pieces of security
"infrastructure".

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h  | 44 ++++++++++-------------
 security/apparmor/lsm.c    |  6 ++--
 security/commoncap.c       |  8 +++--
 security/inode.c           | 56 +++++++++++++++++++++++++----
 security/loadpin/loadpin.c |  4 ++-
 security/security.c        | 89 +++++++++++++++++++++++-----------------------
 security/security.h        | 10 ++++++
 security/selinux/hooks.c   |  6 ++--
 security/smack/smack_lsm.c |  3 +-
 security/tomoyo/tomoyo.c   |  4 ++-
 security/yama/yama_lsm.c   |  4 ++-
 11 files changed, 147 insertions(+), 87 deletions(-)
 create mode 100644 security/security.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9d0b286f3dba..65f346cb6639 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2004,11 +2004,20 @@ struct security_hook_heads {
  * Security module hook list structure.
  * For use with generic list macros for common operations.
  */
+struct security_hook_list;
+struct lsm_info {
+	struct hlist_node		list;
+	const char			*name;
+	const unsigned int		count;
+	struct security_hook_list	*hooks;
+} __randomize_layout;
+
 struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	/* This field is not currently in use */
+	struct lsm_info			*info;
 } __randomize_layout;
 
 /*
@@ -2020,33 +2029,18 @@ struct security_hook_list {
 #define LSM_HOOK_INIT(HEAD, HOOK) \
 	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
 
-extern struct security_hook_heads security_hook_heads;
-extern char *lsm_names;
+#define LSM_MODULE_INIT(NAME, HOOKS)		\
+	{					\
+		.name	= NAME,			\
+		.hooks	= HOOKS,		\
+		.count	= ARRAY_SIZE(HOOKS),	\
+	}
 
-extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+extern struct security_hook_heads security_hook_heads;
+extern void security_add_hooks(struct lsm_info *lsm);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
-/*
- * Assuring the safety of deleting a security module is up to
- * the security module involved. This may entail ordering the
- * module's hook list in a particular way, refusing to disable
- * the module once a policy is loaded or any number of other
- * actions better imagined than described.
- *
- * The name of the configuration option reflects the only module
- * that currently uses the mechanism. Any developer who thinks
- * disabling their module is a good idea needs to be at least as
- * careful as the SELinux team.
- */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-						int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
-}
+void security_delete_hooks(struct lsm_info *lsm);
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
 /* Currently required to handle SELinux runtime hook disable. */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ce2b89e9ad94..d0b3f9a6d488 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1190,6 +1190,9 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 };
 
+static struct lsm_info apparmor_info =
+	LSM_MODULE_INIT("apparmor", apparmor_hooks);
+
 /*
  * AppArmor sysfs module parameters
  */
@@ -1561,8 +1564,7 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+	security_add_hooks(&apparmor_info);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c93d697..d25891adda81 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
@@ -1360,10 +1360,12 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
+static struct lsm_info capability_info =
+	LSM_MODULE_INIT("capability", capability_hooks);
+
 void __init capability_add_hooks(void)
 {
-	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+	security_add_hooks(&capability_info);
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/inode.c b/security/inode.c
index 8dd9ca8848e4..554258be2949 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/seq_file.h>
+#include "security.h"
 
 static struct vfsmount *mount;
 static int mount_count;
@@ -309,16 +311,58 @@ EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
 static struct dentry *lsm_dentry;
-static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
-			loff_t *ppos)
+
+static void *lsm_seq_start(struct seq_file *s, loff_t *pos)
+{
+	int ret;
+
+	ret = mutex_lock_killable(&lsm_info_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return seq_hlist_start(&lsm_info_head, *pos);
+}
+
+static int lsm_seq_show(struct seq_file *s, void *v)
+{
+	struct hlist_node *node = (struct hlist_node *)v;
+	struct lsm_info *info;
+
+	info = hlist_entry(node, struct lsm_info, list);
+	if (node->next)
+		seq_printf(s, "%s,", info->name);
+	else
+		seq_printf(s, "%s", info->name);
+	return 0;
+}
+
+static void *lsm_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	return seq_hlist_next(v, &lsm_info_head, pos);
+}
+
+static void lsm_seq_stop(struct seq_file *s, void *v)
+{
+	mutex_unlock(&lsm_info_lock);
+}
+
+static const struct seq_operations lsm_seq_ops = {
+	.start		= lsm_seq_start,
+	.next		= lsm_seq_next,
+	.stop		= lsm_seq_stop,
+	.show		= lsm_seq_show,
+};
+
+static int lsm_ops_open(struct inode *inode, struct file *file)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	return seq_open(file, &lsm_seq_ops);
 }
 
 static const struct file_operations lsm_ops = {
-	.read = lsm_read,
-	.llseek = generic_file_llseek,
+	.open		= lsm_ops_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 #endif
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..dabc49b855f7 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -178,10 +178,12 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
 
+static struct lsm_info loadpin_info = LSM_MODULE_INIT("loadpin", loadpin_hooks);
+
 void __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(&loadpin_info);
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
diff --git a/security/security.c b/security/security.c
index 7bc2fde023a7..36b9d2b0a135 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,7 +28,9 @@
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <linux/string.h>
+#include <linux/mutex.h>
 #include <net/flow.h>
+#include "security.h"
 
 #include <trace/events/initcall.h>
 
@@ -37,10 +39,12 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
+DEFINE_MUTEX(lsm_info_lock);
+struct hlist_head lsm_info_head __lsm_ro_after_init = HLIST_HEAD_INIT;
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
-char *lsm_names;
+
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
@@ -97,40 +101,6 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
-static bool match_last_lsm(const char *list, const char *lsm)
-{
-	const char *last;
-
-	if (WARN_ON(!list || !lsm))
-		return false;
-	last = strrchr(list, ',');
-	if (last)
-		/* Pass the comma, strcmp() will check for '\0' */
-		last++;
-	else
-		last = list;
-	return !strcmp(last, lsm);
-}
-
-static int lsm_append(char *new, char **result)
-{
-	char *cp;
-
-	if (*result == NULL) {
-		*result = kstrdup(new, GFP_KERNEL);
-	} else {
-		/* Check if it is the last registered name */
-		if (match_last_lsm(*result, new))
-			return 0;
-		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
-		if (cp == NULL)
-			return -ENOMEM;
-		kfree(*result);
-		*result = cp;
-	}
-	return 0;
-}
-
 /**
  * security_module_enable - Load given security module on boot ?
  * @module: the name of the module
@@ -154,25 +124,54 @@ int __init security_module_enable(const char *module)
 	return !strcmp(module, chosen_lsm);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+/*
+ * Assuring the safety of deleting a security module is up to
+ * the security module involved. This may entail ordering the
+ * module's hook list in a particular way, refusing to disable
+ * the module once a policy is loaded or any number of other
+ * actions better imagined than described.
+ *
+ * The name of the configuration option reflects the only module
+ * that currently uses the mechanism. Any developer who thinks
+ * disabling their module is a good idea needs to be at least as
+ * careful as the SELinux team.
+ */
+void security_delete_hooks(struct lsm_info *info)
+{
+	struct security_hook_list *hook;
+	int i;
+
+	for (i = 0; i < info->count; i++) {
+		hook = &info->hooks[i];
+		hlist_del_rcu(&hook->list);
+	}
+
+	mutex_lock(&lsm_info_lock);
+	hlist_del(&info->list);
+	mutex_unlock(&lsm_info_lock);
+}
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsm_info: The lsm_info struct for this security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+void __init security_add_hooks(struct lsm_info *info)
 {
+	struct security_hook_list *hook;
 	int i;
 
-	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+	for (i = 0; i < info->count; i++) {
+		hook = &info->hooks[i];
+		hook->info = info;
+		hlist_add_tail_rcu(&hook->list, hook->head);
 	}
-	if (lsm_append(lsm, &lsm_names) < 0)
-		panic("%s - Cannot get early memory.\n", __func__);
+
+	mutex_lock(&lsm_info_lock);
+	hlist_add_tail_rcu(&info->list, &lsm_info_head);
+	mutex_unlock(&lsm_info_lock);
 }
 
 int call_lsm_notifier(enum lsm_event event, void *data)
diff --git a/security/security.h b/security/security.h
new file mode 100644
index 000000000000..79d1388fb038
--- /dev/null
+++ b/security/security.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/lsm_hooks.h>
+
+#ifndef __SECURITY_SECURITY_H
+#define __SECURITY_SECURITY_H
+extern struct hlist_head lsm_info_head;
+extern struct mutex lsm_info_lock;
+#endif
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..a6d1bc76340e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7083,6 +7083,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 #endif
 };
 
+static struct lsm_info selinux_info = LSM_MODULE_INIT("selinux", selinux_hooks);
+
 static __init int selinux_init(void)
 {
 	if (!security_module_enable("selinux")) {
@@ -7122,7 +7124,7 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(&selinux_info);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
@@ -7269,7 +7271,7 @@ int selinux_disable(struct selinux_state *state)
 
 	selinux_enabled = 0;
 
-	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
+	security_delete_hooks(&selinux_info);
 
 	/* Try to destroy the avc node cache */
 	avc_disable();
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0b414836bebd..a8959cc29bde 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4764,6 +4764,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(dentry_create_files_as, smack_dentry_create_files_as),
 };
 
+static struct lsm_info smack_info = LSM_MODULE_INIT("smack", smack_hooks);
 
 static __init void init_smack_known_list(void)
 {
@@ -4842,7 +4843,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(&smack_info);
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..e8f08c10e339 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -528,6 +528,8 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_sendmsg, tomoyo_socket_sendmsg),
 };
 
+static struct lsm_info tomoyo_info = LSM_MODULE_INIT("tomoyo", tomoyo_hooks);
+
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);
 
@@ -543,7 +545,7 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(&tomoyo_info);
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..4f80b7031e20 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -430,6 +430,8 @@ static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, yama_task_free),
 };
 
+static struct lsm_info yama_info = LSM_MODULE_INIT("yama", yama_hooks);
+
 #ifdef CONFIG_SYSCTL
 static int yama_dointvec_minmax(struct ctl_table *table, int write,
 				void __user *buffer, size_t *lenp, loff_t *ppos)
@@ -480,6 +482,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(&yama_info);
 	yama_init_sysctl();
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

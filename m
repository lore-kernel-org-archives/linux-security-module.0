From: sargun@sargun.me (Sargun Dhillon)
Date: Thu, 17 May 2018 07:01:11 +0000
Subject: [PATCH 2/2] security: Convert lsm list file to a seq_file based on
	lsm_info_head
Message-ID: <20180517070109.GA22167@ircssh-2.c.rugged-nimbus-611.internal>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This moves the maintenance of the list of (loaded) LSMs from a string
that was manually managed, and appended to on every LSM load, to
a seq_file which dynamically iterates the lsm_info_head, an hlist
of all the LSMs currently loaded.

It also moves security_delete_hooks into security.h, as it has to
work with a private mutex, and hlist_head only to be shared with
securityfs.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h | 25 +++---------------
 security/inode.c          | 56 ++++++++++++++++++++++++++++++++++-----
 security/security.c       | 67 +++++++++++++++++++++--------------------------
 security/security.h       | 10 +++++++
 security/selinux/hooks.c  |  2 +-
 5 files changed, 94 insertions(+), 66 deletions(-)
 create mode 100644 security/security.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 78a97f8b45bb..33a5fe817562 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2013,7 +2013,8 @@ struct security_hook_heads {
  */
 struct security_hook_list;
 struct lsm_info {
-	char				*name;
+	struct hlist_node		list;
+	const char			*name;
 	const unsigned int		count;
 	struct security_hook_list	*hooks;
 } __randomize_layout;
@@ -2041,31 +2042,11 @@ struct security_hook_list {
 	}
 
 extern struct security_hook_heads security_hook_heads;
-extern char *lsm_names;
 
 extern void security_add_hooks(struct lsm_info *lsm);
 
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
+extern void security_delete_hooks(struct lsm_info *lsm);
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
 /* Currently required to handle SELinux runtime hook disable. */
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
 
diff --git a/security/security.c b/security/security.c
index dd2ac84e830d..4079435cfc9a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
+#include "security.h"
 
 #include <trace/events/initcall.h>
 
@@ -37,10 +38,11 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
+struct hlist_head lsm_info_head __lsm_ro_after_init = HLIST_HEAD_INIT;
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+DEFINE_MUTEX(lsm_info_lock);
 
-char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
@@ -97,40 +99,6 @@ static int __init choose_lsm(char *str)
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
@@ -165,14 +133,39 @@ void __init security_add_hooks(struct lsm_info *lsm)
 	struct security_hook_list *hook;
 	int i;
 
+	mutex_lock(&lsm_info_lock);
 	for (i = 0; i < lsm->count; i++) {
 		hook = &lsm->hooks[i];
 		hook->info = lsm;
 		hlist_add_tail_rcu(&hook->list, hook->head);
 	};
 
-	if (lsm_append(lsm->name, &lsm_names) < 0)
-		panic("%s - Cannot get early memory.\n", __func__);
+	hlist_add_tail_rcu(&lsm->list, &lsm_info_head);
+	mutex_unlock(&lsm_info_lock);
+}
+
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
+void security_delete_hooks(struct lsm_info *lsm)
+{
+	int i;
+
+	mutex_lock(&lsm_info_lock);
+	for (i = 0; i < lsm->count; i++)
+		hlist_del_rcu(&lsm->hooks[i].list);
+
+	hlist_del(&lsm->list);
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
index b90e3baf6d66..2b6b995abbea 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7285,7 +7285,7 @@ int selinux_disable(struct selinux_state *state)
 
 	selinux_enabled = 0;
 
-	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
+	security_delete_hooks(&selinux_info);
 
 	/* Try to destroy the avc node cache */
 	avc_disable();
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

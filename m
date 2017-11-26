From: sargun@sargun.me (Sargun Dhillon)
Date: Sun, 26 Nov 2017 22:16:20 +0000
Subject: [RFC 2/3] LSM: Add statistics about the invocation of dynamic hooks
Message-ID: <20171126221619.GA13769@ircssh-2.c.rugged-nimbus-611.internal>
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

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 security/Kconfig     |   7 +++
 security/Makefile    |   1 +
 security/dynamic.h   |   9 ++++
 security/dynamicfs.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++
 security/inode.c     |   2 +
 5 files changed, 137 insertions(+)
 create mode 100644 security/dynamicfs.c

diff --git a/security/Kconfig b/security/Kconfig
index 77841bd..d6c579d 100644
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
index 59e695a..51cbec0 100644
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
diff --git a/security/dynamic.h b/security/dynamic.h
index 6823e38..1362b08 100644
--- a/security/dynamic.h
+++ b/security/dynamic.h
@@ -13,6 +13,9 @@ struct dynamic_hook {
 	struct percpu_counter	invocation;
 	struct percpu_counter	deny;
 	const char		*name;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS_FS
+	struct dentry		*dentry;
+#endif
 	struct list_head	head;
 	struct srcu_struct	srcu;
 };
@@ -22,3 +25,9 @@ extern void security_init_dynamic_hooks(void);
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
index 0000000..a9292e2
--- /dev/null
+++ b/security/dynamicfs.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/srcu.h>
+#include <linux/seq_file.h>
+#include <linux/percpu_counter.h>
+#include <linux/percpu.h>
+
+#include "dynamic.h"
+
+struct seq_private_data {
+	struct dynamic_hook *dh;
+	int srcu_lock_index;
+};
+
+static void *dynamic_hooks_sop_start(struct seq_file *s, loff_t *pos)
+{
+	struct seq_private_data *pd = s->private;
+
+	pd->srcu_lock_index = srcu_read_lock(&pd->dh->srcu);
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
+static void dynamic_hooks_sop_stop(struct seq_file *s, void *v)
+{
+	struct seq_private_data *pd = s->private;
+
+	srcu_read_unlock(&pd->dh->srcu, pd->srcu_lock_index);
+}
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
index 8dd9ca8..0862be1 100644
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
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

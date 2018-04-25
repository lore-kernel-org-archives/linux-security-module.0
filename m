From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 25 Apr 2018 08:59:54 +0000
Subject: [PATCH v7 6/6] security: Add SECURITY_UNREGISTRABLE_HOOKS to allow
	for hook removal
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <bde7b42e8e041f9f9159ec5dc7a67d393a943d7f.1524645853.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This enables safe security hook module unloading, and long with code
unloading. It also comes with a knob to prevent unloading modules
at runtime, or after boot time, in case the administrator wants
to lock down their system as such.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h |   5 +-
 security/Kconfig          |  12 +++
 security/security.c       | 225 +++++++++++++++++++++++++++++++++++++---------
 security/selinux/hooks.c  |   2 +-
 4 files changed, 199 insertions(+), 45 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c794c8f2f8b9..5c227bbb2883 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2047,8 +2047,11 @@ extern int __must_check security_add_hooks(struct lsm_info *lsm,
 						bool is_mutable);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
-void security_delete_hooks(struct lsm_info *lsm);
+void __security_delete_hooks(struct lsm_info *lsm);
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
+#ifdef CONFIG_SECURITY_UNREGISTRABLE_HOOKS
+void security_delete_hooks(struct lsm_info *lsm);
+#endif /* CONFIG_SECURITY_UNREGISTRABLE_HOOKS */
 
 extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..c7039f625241 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -36,6 +36,18 @@ config SECURITY_WRITABLE_HOOKS
 	bool
 	default n
 
+config SECURITY_UNREGISTRABLE_HOOKS
+	depends on SECURITY_WRITABLE_HOOKS && SRCU
+	default n
+	bool "Enable security module unloading"
+	help
+		This allows arbitrary security modules to be unloaded by the
+		administrator after boot time. After boot time, this behaviour
+		can still be disabled via sysfs, or disabled at boot time via
+		a kernel parameter.
+
+		If you are unsure how to answer this question, answer N.
+
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
diff --git a/security/security.c b/security/security.c
index 204b9978ba24..36065128c6c5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,8 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/mutex.h>
+#include <linux/srcu.h>
+#include <linux/atomic.h>
 #include <net/flow.h>
 #include "security.h"
 
@@ -44,10 +46,44 @@ struct hlist_head lsm_info_head = HLIST_HEAD_INIT;
 static struct security_hook_heads security_hook_heads_ro __ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+/*
+ * security_allow_unregister_hooks blocks the delete_module syscall for
+ * hooks that are loaded into the  set of mutable hooks by getting a reference
+ * on those modules. This allows built-in modules to still delete their security
+ * hooks, so SELinux will still be able to deregister.
+ *
+ * If an arbitrary module tries to deregister, it will get a return code
+ * indicating failure.
+ *
+ * When this value turns true -> false -- Once, lock_existing_hooks will be
+ * called.
+ */
+static atomic_t security_allow_unregister_hooks =
+	ATOMIC_INIT(IS_ENABLED(CONFIG_SECURITY_UNREGISTRABLE_HOOKS) ? 1 : 0);
+
 #define FOR_EACH_SECURITY_HOOK_RO(ITERATOR, HEAD) \
 	hlist_for_each_entry_rcu(ITERATOR, &security_hook_heads_ro.HEAD, list)
 
 
+#if IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE) || \
+	IS_ENABLED(CONFIG_SECURITY_UNREGISTRABLE_HOOKS)
+/* This should only be used by SELinux directly */
+void __security_delete_hooks(struct lsm_info *info)
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
+#endif
+
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
 static struct security_hook_heads security_hook_heads_rw;
 
@@ -71,6 +107,111 @@ struct security_hook_heads *get_security_hook_heads(bool is_mutable)
 }
 #endif
 
+#ifdef CONFIG_SECURITY_UNREGISTRABLE_HOOKS
+DEFINE_STATIC_SRCU(security_hook_srcu);
+static inline int lock_lsm(void)
+{
+	return srcu_read_lock(&security_hook_srcu);
+}
+
+static inline void unlock_lsm(int idx)
+{
+	srcu_read_unlock(&security_hook_srcu, idx);
+}
+
+/**
+ * security_delete_hooks - Remove modules hooks from the mutable hooks lists.
+ * @lsm_info: The lsm_info struct for this security module
+ *
+ * If LSM unloading is disabled, this function will panic. It should not
+ * get called because we should have a refcount for the module.
+ */
+void security_delete_hooks(struct lsm_info *info)
+{
+	if (!atomic_read(&security_allow_unregister_hooks))
+		panic("Security module %s is attempting to delete hooks.\n",
+			info->name);
+
+	__security_delete_hooks(info);
+
+	synchronize_srcu(&security_hook_srcu);
+}
+EXPORT_SYMBOL_GPL(security_delete_hooks);
+
+static void lock_existing_hooks(void)
+{
+	struct lsm_info *info;
+
+	/*
+	 * Prevent module unloading while we're doing this
+	 * try_module_get may fail (safely), if the module
+	 * is already unloading -- allow that.
+	 */
+	mutex_lock(&module_mutex);
+	mutex_lock(&lsm_info_lock);
+	pr_info("Locking security hooks\n");
+
+	hlist_for_each_entry(info, &lsm_info_head, list)
+		WARN_ON(!try_module_get(info->owner));
+
+	mutex_unlock(&lsm_info_lock);
+	mutex_unlock(&module_mutex);
+}
+
+static int allow_unregister_hooks_set(const char *val,
+					const struct kernel_param *kp)
+{
+	const int current_val = atomic_read(&security_allow_unregister_hooks);
+	bool new_val;
+	int ret;
+
+	ret = strtobool(val, &new_val);
+	if (ret)
+		return 0;
+
+	/* Noop */
+	if (!!new_val == !!current_val)
+		return 0;
+
+	/* Do not allow for the transition from false -> true */
+	if (new_val)
+		return -EPERM;
+
+	/* The only legal transition true -> false */
+	if (atomic_cmpxchg(&security_allow_unregister_hooks, 1, 0) == 1)
+		lock_existing_hooks();
+
+	return 0;
+}
+
+static int allow_unregister_hooks_get(char *buffer,
+					const struct kernel_param *kp)
+{
+	const int current_val = atomic_read(&security_allow_unregister_hooks);
+	int ret;
+
+	ret = sprintf(buffer, "%c\n", current_val ? '1' : '0');
+
+	return ret;
+}
+
+static struct kernel_param_ops allow_unregister_hooks_param_ops = {
+	.set	= allow_unregister_hooks_set,
+	.get	= allow_unregister_hooks_get,
+};
+
+module_param_cb(allow_unregister_hooks, &allow_unregister_hooks_param_ops, NULL,
+		0644);
+MODULE_PARM_DESC(allow_unregister_hooks, "Allow deregistering security hooks");
+#else
+static inline int lock_lsm(void)
+{
+	return 0;
+}
+
+static inline void unlock_lsm(int idx) {}
+#endif
+
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
@@ -90,9 +231,9 @@ static void __init do_security_initcalls(void)
 }
 
 /*
- * Check if one of our modules is being unloaded. This can happen if
- * CONFIG_MODULE_FORCE_UNLOAD is enabled.
- * If it is being unloaded, panic and let the user know what's going on
+ * Check if one of our modules is being unloaded without the hooks being
+ * unregistered. If things have gone correctly, the LSM should already
+ * have been removed from lsm_info_head.
  */
 static int security_module_cb(struct notifier_block *nb, unsigned long val,
 				void *data)
@@ -106,7 +247,7 @@ static int security_module_cb(struct notifier_block *nb, unsigned long val,
 	mutex_lock(&lsm_info_lock);
 	hlist_for_each_entry(info, &lsm_info_head, list)
 		if (mod == info->owner)
-			panic("Security module %s is being unloaded forcefully\n",
+			panic("Security module %s is being unloaded without deregistering hooks",
 				info->name);
 	mutex_unlock(&lsm_info_lock);
 
@@ -117,6 +258,7 @@ static struct notifier_block security_nb = {
 	.notifier_call	= security_module_cb,
 };
 
+
 /**
  * security_init - initializes the security framework
  *
@@ -127,8 +269,7 @@ int __init security_init(void)
 	pr_info("Security Framework initialized with%s writable hooks\n",
 		IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS) ? "" : "out");
 
-	if (IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS) &&
-		IS_ENABLED(CONFIG_MODULE_FORCE_UNLOAD))
+	if (IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS))
 		register_module_notifier(&security_nb);
 	/*
 	 * Load minor LSMs, with the capability module always first.
@@ -176,35 +317,6 @@ int __init security_module_enable(const char *module)
 	return !strcmp(module, chosen_lsm);
 }
 
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
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
-void security_delete_hooks(struct lsm_info *info)
-{
-	struct security_hook_list *hook;
-	int i;
-
-	for (i = 0; i < info->count; i++) {
-		hook = &info->hooks[i];
-		hlist_del_rcu(&hook->list);
-	}
-
-	mutex_lock(&lsm_info_lock);
-	hlist_del(&info->list);
-	mutex_unlock(&lsm_info_lock);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
-
 static void security_add_hook(struct security_hook_list *hook,
 				struct lsm_info *info,
 				struct security_hook_heads *heads)
@@ -230,25 +342,33 @@ static void security_add_hook(struct security_hook_list *hook,
 int __must_check security_add_hooks(struct lsm_info *info, bool is_mutable)
 {
 	struct security_hook_heads *heads;
-	int i;
+	int i, ret = 0;
 
 	heads = get_security_hook_heads(is_mutable);
 	if (IS_ERR(heads))
 		return PTR_ERR(heads);
-	if (!try_module_get(info->owner))
-		return -EINVAL;
 
-	if (mutex_lock_killable(&lsm_info_lock)) {
-		module_put(info->owner);
+	if (mutex_lock_killable(&lsm_info_lock))
 		return -EINTR;
+
+	if (!atomic_read(&security_allow_unregister_hooks)) {
+		/*
+		 * Because hook deregistration is not allowed, we need to try
+		 * to get a refcount on the module owner.
+		 */
+		if (!try_module_get(info->owner)) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	for (i = 0; i < info->count; i++)
 		security_add_hook(&info->hooks[i], info, heads);
 	hlist_add_tail_rcu(&info->list, &lsm_info_head);
+out:
 	mutex_unlock(&lsm_info_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(security_add_hooks);
 
@@ -283,11 +403,14 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 #define call_void_hook(FUNC, ...)				\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu_idx;					\
 								\
 		FOR_EACH_SECURITY_HOOK_RO(P, FUNC)		\
 			P->hook.FUNC(__VA_ARGS__);		\
+		srcu_idx = lock_lsm();				\
 		FOR_EACH_SECURITY_HOOK_RW(P, FUNC)		\
 			P->hook.FUNC(__VA_ARGS__);		\
+		unlock_lsm(srcu_idx);				\
 	} while (0)
 
 /*
@@ -300,17 +423,20 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 	int RC = IRC;						\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu_idx;					\
 								\
 		FOR_EACH_SECURITY_HOOK_RO(P, FUNC) {		\
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				goto LABEL;			\
 		}						\
+		srcu_idx = lock_lsm();				\
 		FOR_EACH_SECURITY_HOOK_RW(P, FUNC) {		\
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
 		}						\
+		unlock_lsm(srcu_idx);				\
 	} while (0);						\
 LABEL:								\
 	RC;							\
@@ -408,7 +534,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
-	int rc;
+	int srcu_idx, rc;
 
 	/*
 	 * The module will respond with a positive value if
@@ -425,6 +551,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 		}
 	}
 
+	srcu_idx = lock_lsm();
 	FOR_EACH_SECURITY_HOOK_RW(hp, vm_enough_memory) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
@@ -432,6 +559,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 			break;
 		}
 	}
+	unlock_lsm(srcu_idx);
 out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
@@ -908,6 +1036,7 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 {
 	struct security_hook_list *hp;
 	int rc = -EOPNOTSUPP;
+	int srcu_idx;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
@@ -920,11 +1049,13 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 			goto out;
 	}
 
+	srcu_idx = lock_lsm();
 	FOR_EACH_SECURITY_HOOK_RW(hp, inode_getsecurity) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
 			break;
 	}
+	unlock_lsm(srcu_idx);
 
 out:
 	return rc;
@@ -934,6 +1065,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 {
 	struct security_hook_list *hp;
 	int rc = -EOPNOTSUPP;
+	int srcu_idx;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
@@ -947,12 +1079,14 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 			goto out;
 	}
 
+	srcu_idx = lock_lsm();
 	FOR_EACH_SECURITY_HOOK_RW(hp, inode_setsecurity) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 								flags);
 		if (rc != -EOPNOTSUPP)
 			break;
 	}
+	unlock_lsm(srcu_idx);
 
 out:
 	return rc;
@@ -1256,6 +1390,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
 	int thisrc;
+	int srcu_idx;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
 
@@ -1268,6 +1403,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		}
 	}
 
+	srcu_idx = lock_lsm();
 	FOR_EACH_SECURITY_HOOK_RW(hp, task_prctl) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
@@ -1276,6 +1412,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	unlock_lsm(srcu_idx);
 
 out:
 	return rc;
@@ -1784,7 +1921,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       const struct flowi *fl)
 {
 	struct security_hook_list *hp;
-	int rc = 1;
+	int srcu_idx, rc = 1;
 
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
@@ -1800,10 +1937,12 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 		goto out;
 	}
 
+	srcu_idx = lock_lsm();
 	FOR_EACH_SECURITY_HOOK_RW(hp, xfrm_state_pol_flow_match) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+	unlock_lsm(srcu_idx);
 out:
 	return rc;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fb830dc80e15..a6a4c7218282 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7279,7 +7279,7 @@ int selinux_disable(struct selinux_state *state)
 
 	selinux_enabled = 0;
 
-	security_delete_hooks(&selinux_info);
+	__security_delete_hooks(&selinux_info);
 
 	/* Try to destroy the avc node cache */
 	avc_disable();
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: sargun@sargun.me (Sargun Dhillon)
Date: Thu, 12 Apr 2018 18:42:26 +0000
Subject: [PATCH v6 1/1] security: Add mechanism to safely (un)load LSMs after
	boot time
In-Reply-To: <cover.1523558422.git.sargun@sargun.me>
References: <cover.1523558422.git.sargun@sargun.me>
Message-ID: <e75b87694dbd28b9e36bf1d53083e9ffb95a4c2f.1523558422.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces a mechanism to add mutable hooks and immutable
hooks to the callback chain. It does this by having two different
sets of heads -- traditional (immutable), and optionally (mutable)
security hooks. Immutable security hooks are always marked
__ro_after_init, whereas mutable hooks are allowed to register
whenever they'd like.

If a module tries to load a mutable set of hooks when not supported,
the kernel will respond with -EINVAL. If this happens, the module
should either report the error to the user, crash, or panic, as it
could leave the user in a false sense of security.

It also wraps the hook unloading and execution with an SRCU. One
SRCU is used across all hooks, as the SRCU struct can be memory
intensive, and hook execution time, in general, should be relatively
short.

Deregistration is gated by a kernel parameter
"security.allow_unregister_hooks". It is set to true by default, but
it can be disabled. This prevents, at runtime from hooks being
deregistered. It can be set either at boot time, or at runtime.
It cannot be reset without rebooting the system.

SELinux is unaffected, and can continue to come and go as it pleases.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
---
 include/linux/lsm_hooks.h  |  51 +++----
 security/Kconfig           |  18 ++-
 security/apparmor/lsm.c    |   6 +-
 security/commoncap.c       |   7 +-
 security/loadpin/loadpin.c |   2 +-
 security/security.c        | 370 ++++++++++++++++++++++++++++++++++++++++-----
 security/selinux/hooks.c   |  22 ++-
 security/smack/smack_lsm.c |   5 +-
 security/tomoyo/tomoyo.c   |   5 +-
 security/yama/yama_lsm.c   |   5 +-
 10 files changed, 413 insertions(+), 78 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ac491137b10a..699df4c17981 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <linux/module.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -1963,10 +1964,11 @@ struct security_hook_heads {
  * For use with generic list macros for common operations.
  */
 struct security_hook_list {
-	struct hlist_node		list;
-	struct hlist_head		*head;
-	union security_list_options	hook;
-	char				*lsm;
+	struct hlist_node			list;
+	const unsigned int			hook_idx;
+	const union security_list_options	hook;
+	struct module				*owner;
+	char					*lsm;
 } __randomize_layout;
 
 /*
@@ -1975,17 +1977,25 @@ struct security_hook_list {
  * care of the common case and reduces the amount of
  * text involved.
  */
-#define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+#define HOOK_OFFSET(HEAD)	offsetof(struct security_hook_heads, HEAD)
+#define HOOK_SIZE(HEAD)		FIELD_SIZEOF(struct security_hook_heads, HEAD)
+#define LSM_HOOK_IDX(HEAD)	(HOOK_OFFSET(HEAD) / HOOK_SIZE(HEAD))
 
-extern struct security_hook_heads security_hook_heads;
+#define LSM_HOOK_INIT(HEAD, HOOK) \
+	{						\
+		.hook = { .HEAD = HOOK },		\
+		.owner = THIS_MODULE,			\
+		.hook_idx = LSM_HOOK_IDX(HEAD),		\
+	}
 extern char *lsm_names;
 
-extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
-
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+extern int __must_check security_add_hooks(struct security_hook_list *hooks,
+						const int count, char *lsm,
+						const bool is_mutable);
+#ifdef CONFIG_SECURITY_UNREGISTRABLE_HOOKS
 /*
+ * Used to facilitate runtime hook unloading
+ *
  * Assuring the safety of deleting a security module is up to
  * the security module involved. This may entail ordering the
  * module's hook list in a particular way, refusing to disable
@@ -1997,22 +2007,9 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
  * disabling their module is a good idea needs to be at least as
  * careful as the SELinux team.
  */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-						int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
-
-/* Currently required to handle SELinux runtime hook disable. */
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
-#else
-#define __lsm_ro_after_init	__ro_after_init
-#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
+extern int __must_check security_delete_hooks(struct security_hook_list *hooks,
+						int count);
+#endif /* CONFIG_SECURITY_UNREGISTRABLE_HOOKS */
 
 extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..3dc1e51f97c6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -33,8 +33,24 @@ config SECURITY
 
 config SECURITY_WRITABLE_HOOKS
 	depends on SECURITY
-	bool
 	default n
+	bool "Enable mutable security module hooks"
+	help
+	  This allows for arbitrary security modules to be loaded by the user
+	  after boot time.
+
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_UNREGISTRABLE_HOOKS
+	depends on SECURITY_WRITABLE_HOOKS && SRCU
+	default n
+	bool "Enable security module unloading"
+	help
+	  This allows arbitrary security modules to be unloaded by the user
+	  after boot time. This feature can be disabled via the kernel command
+	  line or via sysfs after boot time.
+
+	  If you are unsure how to answer this question, answer N.
 
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 77bdfa7f8428..8bb078114a16 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -743,7 +743,7 @@ static int apparmor_task_kill(struct task_struct *target, struct siginfo *info,
 	return error;
 }
 
-static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 	LSM_HOOK_INIT(capget, apparmor_capget),
@@ -1161,8 +1161,8 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+	BUG_ON(security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
+					"apparmor", false));
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c93d697..6fd7fe833ca8 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
@@ -1362,8 +1362,9 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 
 void __init capability_add_hooks(void)
 {
-	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+	BUG_ON(security_add_hooks(capability_hooks,
+					ARRAY_SIZE(capability_hooks),
+					"capability", false));
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index dbe6efde77a0..aaef8d927603 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -174,7 +174,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
-static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list loadpin_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
diff --git a/security/security.c b/security/security.c
index dd246a38b3f0..2d86ab219ddc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,14 +29,35 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
+#include <linux/srcu.h>
+#include <linux/mutex.h>
+
+#define SECURITY_HOOK_COUNT \
+	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
 
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct security_hook_heads security_hook_heads __ro_after_init;
+
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static DEFINE_MUTEX(security_hook_mutex);
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
+static bool security_allow_unregister_hooks =
+	IS_ENABLED(CONFIG_SECURITY_UNREGISTRABLE_HOOKS);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
@@ -53,6 +74,193 @@ static void __init do_security_initcalls(void)
 	}
 }
 
+#define FOR_EACH_SECURITY_HOOK(ITERATOR, HEAD) \
+	hlist_for_each_entry(ITERATOR, &security_hook_heads.HEAD, list)
+
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+/*
+ * If mutable security hooks are enabled, it exposes a second set of
+ * security_hook_heads. These security_hook_heads will only be executed
+ * if all immutable hooks are executed successfully.
+ */
+static struct security_hook_heads security_hook_heads_mutable;
+#define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD) \
+	hlist_for_each_entry(ITERATOR, &security_hook_heads_mutable.HEAD, list)
+
+static struct hlist_head *get_heads(bool is_mutable)
+{
+	if (is_mutable)
+		return (struct hlist_head *)&security_hook_heads_mutable;
+	return (struct hlist_head *)&security_hook_heads;
+}
+#else
+#define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD)	while (0)
+
+static struct hlist_head *get_heads(bool is_mutable)
+{
+	if (is_mutable)
+		return ERR_PTR(-EINVAL);
+	return (struct hlist_head *)&security_hook_heads;
+}
+#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
+
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
+static inline void synchronize_lsm(void)
+{
+	synchronize_srcu(&security_hook_srcu);
+}
+
+/**
+ * security_delete_hooks - Remove modules hooks from the mutable hooks lists.
+ * @hooks: the hooks to remove
+ * @count: the number of hooks to remove
+ *
+ * 0 is returned on success, otherwise -errno is returned on failure.
+ * If an error is returned, it is up to the LSM author to handle the error
+ * appropriately. If they do not, their code could be unloaded, while
+ * leaving dangling pointers.
+ *
+ * At best, this will cause a kernel oops. At worst case scenario, this can
+ * lead to arbitrary code execution. Therefore, it is critical that module
+ * authors check the return code here, and act appropriately. In most cases
+ * a failure should result in panic.
+ */
+int __must_check security_delete_hooks(struct security_hook_list *hooks,
+					int count)
+{
+	int i, ret = 0;
+
+	mutex_lock(&security_hook_mutex);
+	if (security_allow_unregister_hooks)
+		for (i = 0; i < count; i++)
+			hlist_del_rcu(&hooks[i].list);
+	else
+		ret = -EPERM;
+	mutex_unlock(&security_hook_mutex);
+
+	if (!ret)
+		synchronize_lsm();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(security_delete_hooks);
+
+static void lock_existing_hooks(void)
+{
+	struct hlist_head *list = (struct hlist_head *)
+					&security_hook_heads_mutable;
+	struct security_hook_list *P;
+	int i;
+
+	/*
+	 * Prevent module unloading while we're doing this
+	 * try_module_get may fail (safely), if the module
+	 * is already unloading -- allow that.
+	 */
+	mutex_lock(&module_mutex);
+	for (i = 0; i < SECURITY_HOOK_COUNT; i++)
+		hlist_for_each_entry(P, &list[i], list)
+			if (P->owner)
+				WARN_ON(!try_module_get(P->owner));
+	mutex_unlock(&module_mutex);
+}
+#else
+
+static inline int lock_lsm(void)
+{
+	return 0;
+}
+
+static inline void lock_existing_hooks(void) {}
+static inline void unlock_lsm(int idx) {}
+static inline void synchronize_lsm(void) {}
+#endif /* CONFIG_SECURITY_UNREGISTRABLE_HOOKS */
+
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+/*
+ * Always succeeds.
+ * Only to be called by legacy code, like SELinux's delete hooks mechanism
+ * as it ignores whether or not allow_unregister_hooks is set.
+ */
+void __security_delete_hooks(struct security_hook_list *hooks, int count)
+{
+	int i;
+
+	mutex_lock(&security_hook_mutex);
+	for (i = 0; i < count; i++)
+		hlist_del_rcu(&hooks[i].list);
+	mutex_unlock(&security_hook_mutex);
+
+	synchronize_lsm();
+}
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
+
+static int allow_unregister_hooks_set(const char *val,
+					const struct kernel_param *kp)
+{
+	bool new_val;
+	int ret = 0;
+
+	ret = strtobool(val, &new_val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&security_hook_mutex);
+	/*
+	 * This is a noop
+	 * false -> false
+	 * true -> true
+	 */
+	if (new_val == security_allow_unregister_hooks)
+		goto out;
+
+	/* Do not allow for the transition from false -> true */
+	if (new_val) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* The only legal transition true -> false */
+	security_allow_unregister_hooks = new_val;
+	/* We now need to "lock" all of the existing hooks */
+	lock_existing_hooks();
+out:
+	mutex_unlock(&security_hook_mutex);
+	return ret;
+}
+
+static int allow_unregister_hooks_get(char *buffer,
+					const struct kernel_param *kp)
+{
+	int ret;
+
+	mutex_lock(&security_hook_mutex);
+	ret = sprintf(buffer, "%c\n",
+			security_allow_unregister_hooks ? '1' : '0');
+	mutex_unlock(&security_hook_mutex);
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
+
 /**
  * security_init - initializes the security framework
  *
@@ -60,12 +268,6 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
-
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -153,21 +355,41 @@ int __init security_module_enable(const char *module)
  * @hooks: the hooks to add
  * @count: the number of hooks to add
  * @lsm: the name of the security module
+ * @is_mutable: True if dynamic registration and/or unregistration is needed.
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * 0 is returned on success, otherwise -errno is returned on failure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+int __must_check security_add_hooks(struct security_hook_list *hooks,
+					const int count, char *lsm,
+					const bool is_mutable)
 {
-	int i;
+	struct hlist_head *heads;
+	int i, hook_idx, ret = 0;
+
+	mutex_lock(&security_hook_mutex);
+	heads = get_heads(is_mutable);
+	if (IS_ERR(heads)) {
+		ret = PTR_ERR(heads);
+		goto out;
+	}
 
 	for (i = 0; i < count; i++) {
+		hook_idx = hooks[i].hook_idx;
 		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		hlist_add_tail_rcu(&hooks[i].list, &heads[hook_idx]);
+		if (!security_allow_unregister_hooks && hooks[i].owner)
+			WARN_ON(!try_module_get(hooks->owner));
 	}
+
 	if (lsm_append(lsm, &lsm_names) < 0)
-		panic("%s - Cannot get early memory.\n", __func__);
+		panic("%s - Cannot get memory.\n", __func__);
+out:
+	mutex_unlock(&security_hook_mutex);
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(security_add_hooks);
 
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
@@ -200,25 +422,49 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 #define call_void_hook(FUNC, ...)				\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu_idx;					\
 								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
+		FOR_EACH_SECURITY_HOOK(P, FUNC)			\
+			P->hook.FUNC(__VA_ARGS__);		\
+		srcu_idx = lock_lsm();				\
+		FOR_EACH_SECURITY_HOOK_MUTABLE(P, FUNC)		\
 			P->hook.FUNC(__VA_ARGS__);		\
+		unlock_lsm(srcu_idx);				\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
+/*
+ * In certain functions, call_int_hook is invoked multiple times, therefore
+ * the flow-control labels for goto have to be unique with that namespace.
+ * In order to work around this, we wrap call_int_hook2 with a unique-label
+ * defined below in call_int_hook.
+ */
+#define call_int_hook2(LABEL, FUNC, IRC, ...) ({		\
 	int RC = IRC;						\
+								\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu_idx;					\
 								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+		FOR_EACH_SECURITY_HOOK(P, FUNC) {		\
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)				\
+				goto LABEL;			\
+		}						\
+		srcu_idx = lock_lsm();				\
+		FOR_EACH_SECURITY_HOOK_MUTABLE(P, FUNC) {	\
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
 		}						\
+		unlock_lsm(srcu_idx);				\
 	} while (0);						\
+LABEL:								\
 	RC;							\
 })
 
+#define call_int_hook(FUNC, IRC, ...)	\
+	call_int_hook2(__UNIQUE_ID(FUNC), FUNC, IRC, __VA_ARGS__)
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -308,8 +554,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
-	int rc;
-
+	int rc, srcu_idx;
 	/*
 	 * The module will respond with a positive value if
 	 * it thinks the __vm_enough_memory() call should be
@@ -317,13 +562,25 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+	FOR_EACH_SECURITY_HOOK(hp, vm_enough_memory) {
+		rc = hp->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0) {
+			cap_sys_admin = 0;
+			goto out;
+		}
+	}
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, vm_enough_memory) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
 		}
 	}
+	unlock_lsm(srcu_idx);
+
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -798,40 +1055,64 @@ int security_inode_killpriv(struct dentry *dentry)
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int srcu_idx, rc = EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+	FOR_EACH_SECURITY_HOOK(hp, inode_getsecurity) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			goto out;
 	}
-	return -EOPNOTSUPP;
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, inode_getsecurity) {
+		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			break;
+	}
+	unlock_lsm(srcu_idx);
+
+out:
+	return rc;
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int srcu_idx, rc = EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+
+	FOR_EACH_SECURITY_HOOK(hp, inode_setsecurity) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+						flags);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			goto out;
 	}
-	return -EOPNOTSUPP;
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, inode_setsecurity) {
+		rc = hp->hook.inode_setsecurity(inode, name, value, size,
+						flags);
+		if (rc != -EOPNOTSUPP)
+			break;
+	}
+	unlock_lsm(srcu_idx);
+
+out:
+	return rc;
 }
 
+
+
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1120,13 +1401,23 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
+			unsigned long arg4, unsigned long arg5)
 {
-	int thisrc;
-	int rc = -ENOSYS;
+	int srcu_idx, thisrc, rc = -ENOSYS;
 	struct security_hook_list *hp;
 
-	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+	FOR_EACH_SECURITY_HOOK(hp, task_prctl) {
+		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc != -ENOSYS) {
+			rc = thisrc;
+			if (thisrc != 0)
+				goto out;
+		}
+
+	}
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, task_prctl) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
@@ -1134,6 +1425,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	unlock_lsm(srcu_idx);
+
+out:
 	return rc;
 }
 
@@ -1618,7 +1912,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       const struct flowi *fl)
 {
 	struct security_hook_list *hp;
-	int rc = 1;
+	int srcu_idx, rc = 1;
 
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
@@ -1629,11 +1923,19 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
+	FOR_EACH_SECURITY_HOOK(hp, xfrm_state_pol_flow_match) {
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+		goto out;
+	}
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, xfrm_state_pol_flow_match) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+	unlock_lsm(srcu_idx);
+
+out:
 	return rc;
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8abd542c6b7c..c405d3ae2c61 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6396,7 +6396,13 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+#define __selinux_ro_after_init
+#else
+#define __selinux_ro_after_init	__ro_after_init
+#endif
+
+static struct security_hook_list selinux_hooks[] __selinux_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -6629,6 +6635,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static __init int selinux_init(void)
 {
+	const bool is_mutable = IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE);
+
 	if (!security_module_enable("selinux")) {
 		selinux_enabled = 0;
 		return 0;
@@ -6654,7 +6662,8 @@ static __init int selinux_init(void)
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	BUG_ON(security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+					"selinux", is_mutable));
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
@@ -6783,6 +6792,13 @@ static void selinux_nf_ip_exit(void)
 #endif /* CONFIG_NETFILTER */
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
+/*
+ * __security_delete_hooks does not respect security.allow_unload_hooks, and
+ * it not meant to be  used by new LSMs. Therefore, this is defined here, rather
+ * than in a shared header.
+ */
+extern void __security_delete_hooks(struct security_hook_list *hooks,
+					int count);
 static int selinux_disabled;
 
 int selinux_disable(void)
@@ -6802,7 +6818,7 @@ int selinux_disable(void)
 	selinux_disabled = 1;
 	selinux_enabled = 0;
 
-	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
+	__security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
 
 	/* Try to destroy the avc node cache */
 	avc_disable();
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index feada2665322..7ce4395444f7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4682,7 +4682,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	return 0;
 }
 
-static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
@@ -4900,7 +4900,8 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	BUG_ON(security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
+					false));
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..544a614af175 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -497,7 +497,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
  */
-static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
 	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
@@ -543,7 +543,8 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	BUG_ON(security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo",
+					false));
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..2e4bbb087c49 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -423,7 +423,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list yama_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
 	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
@@ -480,6 +480,7 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	BUG_ON(security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama",
+					false));
 	yama_init_sysctl();
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

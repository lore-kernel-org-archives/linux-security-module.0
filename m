From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 25 Apr 2018 08:59:19 +0000
Subject: [PATCH v7 3/6] security: Introduce mutable (RW) hooks
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <a0a7e1ad3186538c93f792f02479d48dc38af570.1524645853.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This PR introduces a separate set of immutable, versus mutable security
hooks. This means that modules (like SELinux) can safely unload themselves
after boot time, while not forcing the entire rest of the LSMs to suffer
from the same security issues.

Mutable (RW) hooks are only evaluated after all Immutable (RO) hooks
are successfully run.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h  |   9 +--
 security/apparmor/lsm.c    |   4 +-
 security/commoncap.c       |   4 +-
 security/loadpin/loadpin.c |   4 +-
 security/security.c        | 137 +++++++++++++++++++++++++++++++++++++--------
 security/security.h        |   2 +-
 security/selinux/hooks.c   |  12 +++-
 security/smack/smack_lsm.c |   4 +-
 security/tomoyo/tomoyo.c   |   4 +-
 security/yama/yama_lsm.c   |   4 +-
 10 files changed, 137 insertions(+), 47 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 93bb0f8a597f..5846b010de0d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2041,19 +2041,12 @@ struct security_hook_list {
 		.count	= ARRAY_SIZE(HOOKS),	\
 	}
 
-extern void security_add_hooks(struct lsm_info *lsm);
+extern void security_add_hooks(struct lsm_info *lsm, bool is_mutable);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 void security_delete_hooks(struct lsm_info *lsm);
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
-/* Currently required to handle SELinux runtime hook disable. */
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
-#else
-#define __lsm_ro_after_init	__ro_after_init
-#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
-
 extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d0b3f9a6d488..85ad007bcb92 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1117,7 +1117,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 		ctx->label = aa_get_current_label();
 }
 
-static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 	LSM_HOOK_INIT(capget, apparmor_capget),
@@ -1564,7 +1564,7 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(&apparmor_info);
+	security_add_hooks(&apparmor_info, false);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index d25891adda81..6ce5703075d7 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
@@ -1365,7 +1365,7 @@ static struct lsm_info capability_info =
 
 void __init capability_add_hooks(void)
 {
-	security_add_hooks(&capability_info);
+	security_add_hooks(&capability_info, false);
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index dabc49b855f7..c31907ab9724 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -173,7 +173,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
-static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list loadpin_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
@@ -183,7 +183,7 @@ static struct lsm_info loadpin_info = LSM_MODULE_INIT("loadpin", loadpin_hooks);
 void __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
-	security_add_hooks(&loadpin_info);
+	security_add_hooks(&loadpin_info, false);
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
diff --git a/security/security.c b/security/security.c
index acdbf65bd752..6b090d53bf9d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -40,14 +40,36 @@
 #define SECURITY_NAME_MAX	10
 
 DEFINE_MUTEX(lsm_info_lock);
-struct hlist_head lsm_info_head __lsm_ro_after_init = HLIST_HEAD_INIT;
-static struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+struct hlist_head lsm_info_head = HLIST_HEAD_INIT;
+static struct security_hook_heads security_hook_heads_ro __ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
-struct security_hook_heads *get_security_hook_heads(void)
+#define FOR_EACH_SECURITY_HOOK_RO(ITERATOR, HEAD) \
+	hlist_for_each_entry_rcu(ITERATOR, &security_hook_heads_ro.HEAD, list)
+
+
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+static struct security_hook_heads security_hook_heads_rw;
+
+#define FOR_EACH_SECURITY_HOOK_RW(ITERATOR, HEAD) \
+	hlist_for_each_entry_rcu(ITERATOR, &security_hook_heads_rw.HEAD, list)
+
+struct security_hook_heads *get_security_hook_heads(bool is_mutable)
+{
+	if (is_mutable)
+		return &security_hook_heads_rw;
+	return &security_hook_heads_ro;
+}
+#else
+#define FOR_EACH_SECURITY_HOOK_RW(ITERATOR, HEAD)	while (0)
+
+struct security_hook_heads *get_security_hook_heads(bool is_mutable)
 {
-	return &security_hook_heads;
+	if (is_mutable)
+		return ERR_PTR(-ENOTSUPP);
+	return &security_hook_heads_ro;
 }
+#endif
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -74,7 +96,8 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	pr_info("Security Framework initialized\n");
+	pr_info("Security Framework initialized with%s writable hooks\n",
+		IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS) ? "" : "out");
 
 	/*
 	 * Load minor LSMs, with the capability module always first.
@@ -152,7 +175,8 @@ void security_delete_hooks(struct lsm_info *info)
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
 static void __init security_add_hook(struct security_hook_list *hook,
-					struct lsm_info *info)
+					struct lsm_info *info,
+					struct security_hook_heads *heads)
 {
 	const unsigned int offset = hook->offset;
 	const unsigned int idx = offset / sizeof(struct hlist_head);
@@ -161,21 +185,27 @@ static void __init security_add_hook(struct security_hook_list *hook,
 	WARN_ON(offset % sizeof(struct hlist_head));
 
 	hook->info = info;
-	head = (struct hlist_head *)(&security_hook_heads) + idx;
+	head = (struct hlist_head *)(heads) + idx;
 	hlist_add_tail_rcu(&hook->list, head);
 }
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @lsm_info: The lsm_info struct for this security module
+ * @is_mutable: Can these hooks be loaded or unloaded after boot time
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct lsm_info *info)
+void __init security_add_hooks(struct lsm_info *info, bool is_mutable)
 {
+	struct security_hook_heads *heads;
 	int i;
 
+	heads = get_security_hook_heads(is_mutable);
+	if (IS_ERR(heads))
+		panic("Failed to get security heads: %ld\n", PTR_ERR(heads));
+
 	for (i = 0; i < info->count; i++)
-		security_add_hook(&info->hooks[i], info);
+		security_add_hook(&info->hooks[i], info, heads);
 
 	mutex_lock(&lsm_info_lock);
 	hlist_add_tail_rcu(&info->list, &lsm_info_head);
@@ -214,24 +244,41 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 	do {							\
 		struct security_hook_list *P;			\
 								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
+		FOR_EACH_SECURITY_HOOK_RO(P, FUNC)		\
+			P->hook.FUNC(__VA_ARGS__);		\
+		FOR_EACH_SECURITY_HOOK_RW(P, FUNC)		\
 			P->hook.FUNC(__VA_ARGS__);		\
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
 	do {							\
 		struct security_hook_list *P;			\
 								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+		FOR_EACH_SECURITY_HOOK_RO(P, FUNC) {		\
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)				\
+				goto LABEL;			\
+		}						\
+		FOR_EACH_SECURITY_HOOK_RW(P, FUNC) {		\
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
 		}						\
 	} while (0);						\
+LABEL:								\
 	RC;							\
 })
 
+#define call_int_hook(FUNC, IRC, ...)	\
+	call_int_hook2(__UNIQUE_ID(FUNC), FUNC, IRC, __VA_ARGS__)
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -330,13 +377,22 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+	FOR_EACH_SECURITY_HOOK_RO(hp, vm_enough_memory) {
+		rc = hp->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0) {
+			cap_sys_admin = 0;
+			goto out;
+		}
+	}
+
+	FOR_EACH_SECURITY_HOOK_RW(hp, vm_enough_memory) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
 		}
 	}
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -811,38 +867,55 @@ int security_inode_killpriv(struct dentry *dentry)
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+	FOR_EACH_SECURITY_HOOK_RO(hp, inode_getsecurity) {
+		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	}
+
+	FOR_EACH_SECURITY_HOOK_RW(hp, inode_getsecurity) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+
+out:
+	return rc;
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+	FOR_EACH_SECURITY_HOOK_RO(hp, inode_setsecurity) {
+		rc = hp->hook.inode_setsecurity(inode, name, value, size,
+								flags);
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	}
+
+	FOR_EACH_SECURITY_HOOK_RW(hp, inode_setsecurity) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 								flags);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+
+out:
+	return rc;
 }
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
@@ -1146,7 +1219,16 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
 
-	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+	FOR_EACH_SECURITY_HOOK_RO(hp, task_prctl) {
+		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc != -ENOSYS) {
+			rc = thisrc;
+			if (thisrc != 0)
+				goto out;
+		}
+	}
+
+	FOR_EACH_SECURITY_HOOK_RW(hp, task_prctl) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
@@ -1154,6 +1236,8 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+
+out:
 	return rc;
 }
 
@@ -1671,11 +1755,16 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
+	FOR_EACH_SECURITY_HOOK_RO(hp, xfrm_state_pol_flow_match) {
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+		goto out;
+	}
+
+	FOR_EACH_SECURITY_HOOK_RW(hp, xfrm_state_pol_flow_match) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+out:
 	return rc;
 }
 
diff --git a/security/security.h b/security/security.h
index b4d1a60862c3..3e757f55cc1d 100644
--- a/security/security.h
+++ b/security/security.h
@@ -7,5 +7,5 @@
 #define __SECURITY_SECURITY_H
 extern struct mutex lsm_info_lock;
 extern struct hlist_head lsm_info_head;
-extern struct security_hook_heads *get_security_hook_heads(void);
+extern struct security_hook_heads *get_security_hook_heads(bool is_mutable);
 #endif
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6d1bc76340e..b324f03ae723 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6848,7 +6848,13 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
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
@@ -7087,6 +7093,8 @@ static struct lsm_info selinux_info = LSM_MODULE_INIT("selinux", selinux_hooks);
 
 static __init int selinux_init(void)
 {
+	const bool is_mutable = IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE);
+
 	if (!security_module_enable("selinux")) {
 		selinux_enabled = 0;
 		return 0;
@@ -7124,7 +7132,7 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(&selinux_info);
+	security_add_hooks(&selinux_info, is_mutable);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a8959cc29bde..86fe6467e0fb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4623,7 +4623,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	return 0;
 }
 
-static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
@@ -4843,7 +4843,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(&smack_info);
+	security_add_hooks(&smack_info, false);
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index e8f08c10e339..879d358198b8 100644
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
@@ -545,7 +545,7 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(&tomoyo_info);
+	security_add_hooks(&tomoyo_info, false);
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 4f80b7031e20..7f2ce8f7c11f 100644
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
@@ -482,6 +482,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(&yama_info);
+	security_add_hooks(&yama_info, false);
 	yama_init_sysctl();
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

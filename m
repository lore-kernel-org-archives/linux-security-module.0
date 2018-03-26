From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 26 Mar 2018 19:24:34 +0000
Subject: [RFC PATCH 2/2] security: Add mechanism to (un)load LSMs after boot
	time
In-Reply-To: <cover.1522091329.git.sargun@sargun.me>
References: <cover.1522091329.git.sargun@sargun.me>
Message-ID: <af077529868a212caeb822ae79d72a1ac40f17ba.1522091329.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces a mechanism to add mutable hooks at the end of the
callback chain for each LSM hook. It allows for built-in kernel LSMs
to be unloaded, as well as modular LSMs to be loaded after boot-time.
It also does not compromise the security of hooks which are never
meant to be unloaded.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h  |  7 ++--
 security/apparmor/lsm.c    |  2 +-
 security/commoncap.c       |  2 +-
 security/security.c        | 87 +++++++++++++++++++++++++++++++++++++++++-----
 security/selinux/hooks.c   |  5 +--
 security/smack/smack_lsm.c |  3 +-
 security/tomoyo/tomoyo.c   |  3 +-
 security/yama/yama_lsm.c   |  2 +-
 8 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 09bc60fb35f1..c0c98758b1bf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1981,7 +1981,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+				char *lsm, bool is_mutable);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
@@ -2006,11 +2006,12 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
+#define __lsm_ro_after_init	__ro_after_init
 /* Currently required to handle SELinux runtime hook disable. */
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
+#define __lsm_mutable_after_init
 #else
-#define __lsm_ro_after_init	__ro_after_init
+#define __lsm_mutable_after_init __ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern int __init security_module_enable(const char *module);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9a65eeaf7dfa..d6cca8169df0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1155,7 +1155,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				"apparmor", false);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c93d697..fe4b0d9d44ce 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1363,7 +1363,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 void __init capability_add_hooks(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+				"capability", false);
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 3cafff61b049..c021a34ffe4c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,12 +30,16 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
+#define SECURITY_HOOK_COUNT \
+	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+EXPORT_SYMBOL_GPL(security_hook_heads);
+
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
@@ -53,6 +57,55 @@ static void __init do_security_initcalls(void)
 	}
 }
 
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
+{
+	struct security_hook_list *mutable_hook;
+	union {
+		void *cb_ptr;
+		union security_list_options slo;
+	} hook_options;
+
+	hlist_for_each_entry(mutable_hook, hook->head, list) {
+		hook_options.slo = mutable_hook->hook;
+		if (hook_options.cb_ptr)
+			continue;
+
+		if (is_mutable)
+			hlist_add_behind_rcu(&hook->list, &mutable_hook->list);
+		else
+			hlist_add_before_rcu(&hook->list, &mutable_hook->list);
+		return;
+	}
+
+	panic("Unable to install hook, cannot find mutable hook\n");
+}
+
+static void __init add_mutable_hooks(void)
+{
+	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct security_hook_list *shl;
+	int i;
+
+	for (i = 0; i < SECURITY_HOOK_COUNT; i++) {
+		shl = kzalloc(sizeof(*shl), GFP_KERNEL);
+		if (!shl)
+			panic("Unable to allocate memory for mutable hooks\n");
+		shl->head = &list[i];
+		hlist_add_head_rcu(&shl->list, shl->head);
+	}
+}
+#else
+static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
+{
+	WARN_ONCE(is_mutable,
+			"Mutable hook loaded with writable hooks disabled");
+	hlist_add_tail_rcu(hook.list, hooks.head);
+}
+
+static void __init add_mutable_hooks(void) {}
+#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
+
 /**
  * security_init - initializes the security framework
  *
@@ -63,11 +116,11 @@ int __init security_init(void)
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
+	for (i = 0; i < SECURITY_HOOK_COUNT; i++)
 		INIT_HLIST_HEAD(&list[i]);
 	pr_info("Security Framework initialized\n");
 
+	add_mutable_hooks();
 	/*
 	 * Load minor LSMs, with the capability module always first.
 	 */
@@ -153,21 +206,24 @@ int __init security_module_enable(const char *module)
  * @hooks: the hooks to add
  * @count: the number of hooks to add
  * @lsm: the name of the security module
+ * @is_mutable: is this hook mutable after kernel init
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+void security_add_hooks(struct security_hook_list *hooks, int count,
+				char *lsm, bool is_mutable)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		security_add_hook(&hooks[i], is_mutable);
 	}
+
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
+EXPORT_SYMBOL_GPL(security_add_hooks);
 
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
@@ -202,7 +258,8 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			P->hook.FUNC(__VA_ARGS__);		\
+			if (P->hook.FUNC)			\
+				P->hook.FUNC(__VA_ARGS__);	\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
@@ -211,9 +268,11 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
+			if (P->hook.FUNC) {			\
+				RC = P->hook.FUNC(__VA_ARGS__);	\
+				if (RC != 0)			\
+					break;			\
+			}					\
 		}						\
 	} while (0);						\
 	RC;							\
@@ -318,6 +377,8 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * thinks it should not be set it won't.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+		if (!hp->hook.vm_enough_memory)
+			continue;
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
@@ -806,6 +867,8 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+		if (!hp->hook.inode_getsecurity)
+			continue;
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
 			return rc;
@@ -824,6 +887,8 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+		if (!hp->hook.inode_setsecurity)
+			continue;
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 								flags);
 		if (rc != -EOPNOTSUPP)
@@ -1127,6 +1192,8 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+		if (!hp->hook.task_prctl)
+			continue;
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
@@ -1631,6 +1698,8 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
 				list) {
+		if (!hp->hook.xfrm_state_pol_flow_match)
+			continue;
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..f05184a3a7a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6393,7 +6393,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list selinux_hooks[] __lsm_mutable_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -6651,7 +6651,8 @@ static __init int selinux_init(void)
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
+				IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 03fdecba93bb..7a9f1bb06c8e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4902,7 +4902,8 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
+				false);
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..ba74fab0e9a5 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -543,7 +543,8 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo",
+				false);
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..04c9aed9e951 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -480,6 +480,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama", false);
 	yama_init_sysctl();
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

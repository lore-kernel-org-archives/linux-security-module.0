From: sargun@sargun.me (Sargun Dhillon)
Date: Thu, 17 May 2018 07:00:54 +0000
Subject: [PATCH 1/2] security: Move LSM registration arguments to struct
	lsm_info
Message-ID: <20180517070052.GA22158@ircssh-2.c.rugged-nimbus-611.internal>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Previously, when LSMs registered, they independently passed their name
and hook count. This combines it into one datastructure, that can
then be reused for other purposes.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h  | 24 ++++++++++++++++++------
 security/apparmor/lsm.c    |  5 +++--
 security/commoncap.c       |  6 ++++--
 security/loadpin/loadpin.c |  5 ++++-
 security/security.c        | 20 ++++++++++----------
 security/selinux/hooks.c   |  5 ++++-
 security/smack/smack_lsm.c |  4 +++-
 security/tomoyo/tomoyo.c   |  5 ++++-
 security/yama/yama_lsm.c   |  5 ++++-
 9 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..78a97f8b45bb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2011,11 +2011,18 @@ struct security_hook_heads {
  * Security module hook list structure.
  * For use with generic list macros for common operations.
  */
+struct security_hook_list;
+struct lsm_info {
+	char				*name;
+	const unsigned int		count;
+	struct security_hook_list	*hooks;
+} __randomize_layout;
+
 struct security_hook_list {
-	struct hlist_node		list;
-	struct hlist_head		*head;
-	union security_list_options	hook;
-	char				*lsm;
+	struct hlist_node			list;
+	struct hlist_head			*head;
+	const union security_list_options	hook;
+	struct lsm_info				*info;
 } __randomize_layout;
 
 /*
@@ -2026,12 +2033,17 @@ struct security_hook_list {
  */
 #define LSM_HOOK_INIT(HEAD, HOOK) \
 	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+#define LSM_MODULE_INIT(NAME, HOOKS) \
+	{					\
+		.name	= NAME,			\
+		.hooks	= HOOKS,		\
+		.count	= ARRAY_SIZE(HOOKS),	\
+	}
 
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
-extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+extern void security_add_hooks(struct lsm_info *lsm);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ce2b89e9ad94..561e8417fa58 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1190,6 +1190,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 };
 
+static struct lsm_info apparmor_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("apparmor", apparmor_hooks);
 /*
  * AppArmor sysfs module parameters
  */
@@ -1561,8 +1563,7 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+	security_add_hooks(&apparmor_info);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 1ce701fcb3f3..a347bda1eae3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1362,10 +1362,12 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
+static struct lsm_info capability_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("capability", capability_hooks);
+
 void __init capability_add_hooks(void)
 {
-	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+	security_add_hooks(&capability_info);
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..4274c9cfaec8 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -178,10 +178,13 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
 
+static struct lsm_info loadpin_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("loadpin", loadpin_hooks);
+
 void __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(&loadpin_info);
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..dd2ac84e830d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -156,22 +156,22 @@ int __init security_module_enable(const char *module)
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsm: lsm_info initialized by LSM_MODULE_INIT
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+void __init security_add_hooks(struct lsm_info *lsm)
 {
+	struct security_hook_list *hook;
 	int i;
 
-	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-	}
-	if (lsm_append(lsm, &lsm_names) < 0)
+	for (i = 0; i < lsm->count; i++) {
+		hook = &lsm->hooks[i];
+		hook->info = lsm;
+		hlist_add_tail_rcu(&hook->list, hook->head);
+	};
+
+	if (lsm_append(lsm->name, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 02ebd1585eaf..b90e3baf6d66 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7096,6 +7096,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 #endif
 };
 
+static struct lsm_info selinux_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("selinux", selinux_hooks);
+
 static __init int selinux_init(void)
 {
 	if (!security_module_enable("selinux")) {
@@ -7135,7 +7138,7 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(&selinux_info);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index dcb976f98df2..4bcaffbf3ec7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4786,6 +4786,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(dentry_create_files_as, smack_dentry_create_files_as),
 };
 
+static struct lsm_info smack_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("smack", smack_hooks);
 
 static __init void init_smack_known_list(void)
 {
@@ -4864,7 +4866,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(&smack_info);
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..8481a3edf851 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -528,6 +528,9 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_sendmsg, tomoyo_socket_sendmsg),
 };
 
+static struct lsm_info tomoyo_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("tomoyo", tomoyo_hooks);
+
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);
 
@@ -543,7 +546,7 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(&tomoyo_info);
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..f0622ffbfe32 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -430,6 +430,9 @@ static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, yama_task_free),
 };
 
+static struct lsm_info yama_info __lsm_ro_after_init =
+	LSM_MODULE_INIT("yama", yama_hooks);
+
 #ifdef CONFIG_SYSCTL
 static int yama_dointvec_minmax(struct ctl_table *table, int write,
 				void __user *buffer, size_t *lenp, loff_t *ppos)
@@ -480,6 +483,6 @@ static inline void yama_init_sysctl(void) { }
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

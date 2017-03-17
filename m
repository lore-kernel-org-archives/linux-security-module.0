From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Fri, 17 Mar 2017 21:52:09 +0900
Subject: [PATCH RFC 1/9] LSM: Add /sys/kernel/security/lsm
In-Reply-To: <4856407a-3c94-362f-d548-5228c09c84be@schaufler-ca.com>
References: <bdd17661-5f1f-833f-1e68-887b288616bb@schaufler-ca.com>
	<4856407a-3c94-362f-d548-5228c09c84be@schaufler-ca.com>
Message-ID: <201703172152.GBD04133.QLOSVFJHOOMtFF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> Subject: [PATCH RFC 1/9] LSM: Add /sys/kernel/security/lsm
> 
> This has been accepted into security next - provided for completeness

Before going to "[PATCH RFC 5/9] LSM: General but not extreme module
stacking", what do you think about below change?

----------------------------------------

>From 8fe80e4b6a479a81d720571ad3b5979f6fd1e6ae Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 17 Mar 2017 21:34:51 +0900
Subject: [PATCH] LSM: Pass module name via "union security_list_options".

Commit d69dece5f5b6bc7a ("LSM: Add /sys/kernel/security/lsm") added
"char *lsm" field to "struct security_hook_list". But it is currently
never used after set at initialization time. While there is a plan that
this field will be used by "LSM: General but not extreme module stacking"
patch, there is no point with setting the same value to each element of
"struct security_hook_list" array. We can keep "struct security_hook_list"
4 * sizeof(void *) bytes if we keep this field in "union
security_list_options".

The "char *" argument in security_add_hooks() was removed because we can
fetch it from security_list_options"->module_name field. This implies
that setting security_list_options"->module_name field is mandatory.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_hooks.h  |  8 +++++---
 security/apparmor/lsm.c    |  4 ++--
 security/commoncap.c       |  4 ++--
 security/loadpin/loadpin.c |  3 ++-
 security/security.c        | 13 +++++++------
 security/selinux/hooks.c   |  3 ++-
 security/smack/smack_lsm.c |  3 ++-
 security/tomoyo/tomoyo.c   |  3 ++-
 security/yama/yama_lsm.c   |  3 ++-
 9 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a4193c3..d10b4f7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -29,6 +29,8 @@
 #include <linux/rculist.h>
 
 /**
+ * @module_name: the name of the security module
+ *
  * Security hooks for program execution operations.
  *
  * @bprm_set_creds:
@@ -1340,6 +1342,7 @@
  */
 
 union security_list_options {
+	const char *module_name;
 	int (*binder_set_context_mgr)(struct task_struct *mgr);
 	int (*binder_transaction)(struct task_struct *from,
 					struct task_struct *to);
@@ -1664,6 +1667,7 @@
 };
 
 struct security_hook_heads {
+	struct list_head module_name;
 	struct list_head binder_set_context_mgr;
 	struct list_head binder_transaction;
 	struct list_head binder_transfer_binder;
@@ -1886,7 +1890,6 @@ struct security_hook_list {
 	struct list_head		list;
 	struct list_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
 };
 
 /*
@@ -1901,8 +1904,7 @@ struct security_hook_list {
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
-extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+extern void security_add_hooks(struct security_hook_list *hooks, int count);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e287b69..dc21835 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -588,6 +588,7 @@ static int apparmor_task_setrlimit(struct task_struct *task,
 }
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "apparmor"),
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 	LSM_HOOK_INIT(capget, apparmor_capget),
@@ -996,8 +997,7 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks));
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 7abebd7..1ced4ee 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1072,6 +1072,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 #ifdef CONFIG_SECURITY
 
 struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "capability"),
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
@@ -1094,8 +1095,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 
 void __init capability_add_hooks(void)
 {
-	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks));
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index dbe6efd..c126c74 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -175,6 +175,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 }
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "loadpin"),
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
@@ -182,7 +183,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 void __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks));
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
diff --git a/security/security.c b/security/security.c
index 5b6cdd0..ae57a84 100644
--- a/security/security.c
+++ b/security/security.c
@@ -79,7 +79,7 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -118,20 +118,20 @@ int __init security_module_enable(const char *module)
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+void __init security_add_hooks(struct security_hook_list *hooks, int count)
 {
 	int i;
+	const char *lsm = NULL;
 
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
 		list_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		if (hooks[i].head == &security_hook_heads.module_name)
+			lsm = hooks[i].hook.module_name;
 	}
-	if (lsm_append(lsm, &lsm_names) < 0)
+	if (!lsm || lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
@@ -1634,6 +1634,7 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 #endif /* CONFIG_AUDIT */
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init = {
+	.module_name = LIST_HEAD_INIT(security_hook_heads.module_name),
 	.binder_set_context_mgr =
 		LIST_HEAD_INIT(security_hook_heads.binder_set_context_mgr),
 	.binder_transaction =
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d37a723..cd7befe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6124,6 +6124,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 #endif
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "selinux"),
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -6366,7 +6367,7 @@ static __init int selinux_init(void)
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 927e60e..f2457b8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4634,6 +4634,7 @@ static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "smack"),
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
@@ -4850,7 +4851,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks));
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 0de150d..6ba6139 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -488,6 +488,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  * registering TOMOYO.
  */
 static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "tomoyo"),
 	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
 	LSM_HOOK_INIT(task_free, tomoyo_task_free),
 	LSM_HOOK_INIT(bprm_set_creds, tomoyo_bprm_set_creds),
@@ -534,7 +535,7 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks));
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	current->security = &ts;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 8298e09..3290d33 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -429,6 +429,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
 }
 
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(module_name, "yama"),
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
 	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
@@ -485,6 +486,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks));
 	yama_init_sysctl();
 }
-- 
1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

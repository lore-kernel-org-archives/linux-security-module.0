From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 25 Apr 2018 08:59:31 +0000
Subject: [PATCH v7 4/6] security: Expose security_add_hooks externally and
	add error handling
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <53a2efaab40c11ee79198149f81b6cadf385163d.1524645853.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This exports security_add_hooks. In order to safely export it, we need
have proper error handling for when mutable hooks are not available,
rather than crashing the kernel.

It now returns an error if it's unable to get a lock to install
hooks. For built-in modules, this should never happen, so by
default, they crash the kernel. It is up to 3rd party module
authors to handle this case for their own modules.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h  |  7 +++++--
 security/apparmor/lsm.c    |  2 +-
 security/commoncap.c       |  2 +-
 security/loadpin/loadpin.c |  2 +-
 security/security.c        | 23 ++++++++++++++++-------
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 security/yama/yama_lsm.c   |  2 +-
 9 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5846b010de0d..c794c8f2f8b9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,7 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
-
+#include <linux/module.h>
 /**
  * union security_list_options - Linux Security Module hook function list
  *
@@ -2010,6 +2010,7 @@ struct lsm_info {
 	const char			*name;
 	const unsigned int		count;
 	struct security_hook_list	*hooks;
+	struct module			*owner;
 } __randomize_layout;
 
 struct security_hook_list {
@@ -2039,9 +2040,11 @@ struct security_hook_list {
 		.name	= NAME,			\
 		.hooks	= HOOKS,		\
 		.count	= ARRAY_SIZE(HOOKS),	\
+		.owner	= THIS_MODULE,		\
 	}
 
-extern void security_add_hooks(struct lsm_info *lsm, bool is_mutable);
+extern int __must_check security_add_hooks(struct lsm_info *lsm,
+						bool is_mutable);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 void security_delete_hooks(struct lsm_info *lsm);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 85ad007bcb92..6477e9b088b1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1564,7 +1564,7 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(&apparmor_info, false);
+	BUG_ON(security_add_hooks(&apparmor_info, false));
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 6ce5703075d7..3739e11d02e9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1365,7 +1365,7 @@ static struct lsm_info capability_info =
 
 void __init capability_add_hooks(void)
 {
-	security_add_hooks(&capability_info, false);
+	BUG_ON(security_add_hooks(&capability_info, false));
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index c31907ab9724..b0a357034736 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -183,7 +183,7 @@ static struct lsm_info loadpin_info = LSM_MODULE_INIT("loadpin", loadpin_hooks);
 void __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
-	security_add_hooks(&loadpin_info, false);
+	BUG_ON(security_add_hooks(&loadpin_info, false));
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
diff --git a/security/security.c b/security/security.c
index 6b090d53bf9d..8d8a227eeeea 100644
--- a/security/security.c
+++ b/security/security.c
@@ -174,9 +174,9 @@ void security_delete_hooks(struct lsm_info *info)
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
-static void __init security_add_hook(struct security_hook_list *hook,
-					struct lsm_info *info,
-					struct security_hook_heads *heads)
+static void security_add_hook(struct security_hook_list *hook,
+				struct lsm_info *info,
+				struct security_hook_heads *heads)
 {
 	const unsigned int offset = hook->offset;
 	const unsigned int idx = offset / sizeof(struct hlist_head);
@@ -194,23 +194,32 @@ static void __init security_add_hook(struct security_hook_list *hook,
  * @is_mutable: Can these hooks be loaded or unloaded after boot time
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * Return 0 on success
  */
-void __init security_add_hooks(struct lsm_info *info, bool is_mutable)
+int __must_check security_add_hooks(struct lsm_info *info, bool is_mutable)
 {
 	struct security_hook_heads *heads;
 	int i;
 
 	heads = get_security_hook_heads(is_mutable);
 	if (IS_ERR(heads))
-		panic("Failed to get security heads: %ld\n", PTR_ERR(heads));
+		return PTR_ERR(heads);
+	if (!try_module_get(info->owner))
+		return -EINVAL;
+
+	if (mutex_lock_killable(&lsm_info_lock)) {
+		module_put(info->owner);
+		return -EINTR;
+	}
 
 	for (i = 0; i < info->count; i++)
 		security_add_hook(&info->hooks[i], info, heads);
-
-	mutex_lock(&lsm_info_lock);
 	hlist_add_tail_rcu(&info->list, &lsm_info_head);
 	mutex_unlock(&lsm_info_lock);
+
+	return 0;
 }
+EXPORT_SYMBOL_GPL(security_add_hooks);
 
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b324f03ae723..fb830dc80e15 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7132,7 +7132,7 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(&selinux_info, is_mutable);
+	BUG_ON(security_add_hooks(&selinux_info, is_mutable));
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 86fe6467e0fb..0844776c4d18 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4843,7 +4843,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(&smack_info, false);
+	BUG_ON(security_add_hooks(&smack_info, false));
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 879d358198b8..4b08021338dc 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -545,7 +545,7 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(&tomoyo_info, false);
+	BUG_ON(security_add_hooks(&tomoyo_info, false));
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 7f2ce8f7c11f..06dd2eb5d0ca 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -482,6 +482,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(&yama_info, false);
+	BUG_ON(security_add_hooks(&yama_info, false));
 	yama_init_sysctl();
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

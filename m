From: steve@steve.fi (Steve Kemp)
Date: Thu, 22 Jun 2017 08:45:07 +0000
Subject: [PATCH v2] Moved module init-functions into the module.
Message-ID: <20170622084507.GA4025@steve.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This commit moves the call to initialize the LSM modules inline
into the LSM-files themselves.

This removes the need to hunt around for the setup, which was
something that bit me when I wrote my own (unrelated) LSM.

Keeping LSM code in one place, including the setup of the
hooks seems like a sane choice.

This patch has been updated to use `security_init`, as per
feedback from Ethan Zhao.  This should ensure that the
LSM init is called "early".

Signed-off-by: Steve Kemp <steve@steve.fi>
---
 include/linux/lsm_hooks.h  | 10 ----------
 security/loadpin/loadpin.c |  5 ++++-
 security/security.c        |  2 --
 security/yama/yama_lsm.c   |  5 ++++-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 080f34e..a6dbdc7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1936,15 +1936,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index dbe6efd..127eb5ca 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -179,12 +179,15 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+security_initcall(loadpin_add_hooks);
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enabled, int, 0);
 MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
diff --git a/security/security.c b/security/security.c
index b9fea39..110b85b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -67,8 +67,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/*
 	 * Load all the remaining security modules.
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 8298e09..e3c1d10 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -482,9 +482,12 @@ static void __init yama_init_sysctl(void)
 static inline void yama_init_sysctl(void) { }
 #endif /* CONFIG_SYSCTL */
 
-void __init yama_add_hooks(void)
+static int __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
 	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
 	yama_init_sysctl();
+	return 0;
 }
+
+security_initcall(yama_add_hooks);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

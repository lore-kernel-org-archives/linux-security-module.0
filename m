From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:54 -0700
Subject: [PATCH 13/18] LoadPin: Initialize as LSM_TYPE_MINOR
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-14-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This converts LoadPin to use the new LSM_TYPE_MINOR marking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  5 -----
 security/loadpin/loadpin.c | 11 +++++++++--
 security/security.c        |  1 -
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 89e6ec8eac07..5e0ca4a05091 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2107,10 +2107,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 0716af28808a..8798d0b9b8e9 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,12 +184,19 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
-	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
+	pr_info("ready to pin\n");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin)
+	.enabled = &enabled,
+	.type = LSM_TYPE_MINOR,
+	.init = loadpin_init,
+END_LSM;
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enabled, int, 0);
 MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
diff --git a/security/security.c b/security/security.c
index 19afd7949426..65d7ba1bc1ef 100644
--- a/security/security.c
+++ b/security/security.c
@@ -126,7 +126,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 	lsm_init(LSM_TYPE_MINOR);
 
 	/*
-- 
2.17.1

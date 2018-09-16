From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:52 -0700
Subject: [PATCH 11/18] LSM: Lift LSM selection out of individual LSMs
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-12-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order to adjust LSM selection logic in the future, this moves the
selection logic up out of the individual LSMs, making their init functions
only run when actually enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  1 -
 security/apparmor/lsm.c    |  6 ---
 security/security.c        | 75 ++++++++++++++++++++++++++------------
 security/selinux/hooks.c   | 10 -----
 security/smack/smack_lsm.c |  3 --
 security/tomoyo/tomoyo.c   |  2 -
 6 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8a3a6cd26f03..6e71e1c47fa1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2094,7 +2094,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6cd630b34c3b..56c0982b48cd 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1542,12 +1542,6 @@ static int __init apparmor_init(void)
 {
 	int error;
 
-	if (!apparmor_enabled || !security_module_enable("apparmor")) {
-		aa_info_message("AppArmor disabled by boot time parameter");
-		apparmor_enabled = false;
-		return 0;
-	}
-
 	aa_secids_init();
 
 	error = aa_setup_dfa_engine();
diff --git a/security/security.c b/security/security.c
index da2a923f2609..3fedbee5f3ec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -43,13 +43,63 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static struct lsm_info *exclusive __initdata;
+
+/* Mark an LSM's enabled flag, if it exists. */
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	if (lsm->enabled)
+		*lsm->enabled = enabled;
+}
+
+/* Is an LSM allowed to be enabled? */
+static bool __init lsm_enabled(struct lsm_info *lsm)
+{
+	/* Report explicit disabling. */
+	if (lsm->enabled && !*lsm->enabled) {
+		pr_info("%s disabled with boot parameter\n", lsm->name);
+		return false;
+	}
+
+	/* If LSM isn't exclusive, ignore exclusive LSM selection rules. */
+	if (lsm->type != LSM_TYPE_EXCLUSIVE)
+		return true;
+
+	/* Disabled if another exclusive LSM already selected. */
+	if (exclusive)
+		return false;
+
+	/* Disabled if this LSM isn't the chosen one. */
+	if (strcmp(lsm->name, chosen_lsm) != 0)
+		return false;
+
+	return true;
+}
+
+/* Check if LSM should be enabled. Mark any that are disabled. */
+static void __init maybe_enable_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_enabled(lsm);
+
+	/* Record enablement. */
+	set_enabled(lsm, enabled);
+
+	/* If selected, initialize the LSM. */
+	if (enabled) {
+		if (lsm->type == LSM_TYPE_EXCLUSIVE) {
+			exclusive = lsm;
+		}
+		lsm->init();
+	}
+}
+
 static void __init lsm_init(enum lsm_type type)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (lsm->type == type)
-			lsm->init();
+			maybe_enable_lsm(lsm);
 	}
 }
 
@@ -128,29 +178,6 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
-/**
- * security_module_enable - Load given security module on boot ?
- * @module: the name of the module
- *
- * Each LSM must pass this method before registering its own operations
- * to avoid security registration races. This method may also be used
- * to check if your LSM is currently loaded during kernel initialization.
- *
- * Returns:
- *
- * true if:
- *
- * - The passed LSM is the one chosen by user at boot time,
- * - or the passed LSM is configured as the default and the user did not
- *   choose an alternate LSM at boot time.
- *
- * Otherwise, return false.
- */
-int __init security_module_enable(const char *module)
-{
-	return !strcmp(module, chosen_lsm);
-}
-
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 78b5afc188f3..5478abf51f3a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7133,16 +7133,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static __init int selinux_init(void)
 {
-	if (!security_module_enable("selinux")) {
-		selinux_enabled = 0;
-		return 0;
-	}
-
-	if (!selinux_enabled) {
-		pr_info("SELinux:  Disabled at boot.\n");
-		return 0;
-	}
-
 	pr_info("SELinux:  Initializing.\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1e1ace718e75..6e127c357ca2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4834,9 +4834,6 @@ static __init int smack_init(void)
 	struct cred *cred;
 	struct task_smack *tsp;
 
-	if (!security_module_enable("smack"))
-		return 0;
-
 	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
 	if (!smack_inode_cache)
 		return -ENOMEM;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index a280d4eab456..0471390409c5 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -540,8 +540,6 @@ static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
 
-	if (!security_module_enable("tomoyo"))
-		return 0;
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-- 
2.17.1

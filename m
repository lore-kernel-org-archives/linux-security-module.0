From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 17:30:51 -0700
Subject: [PATCH 10/18] LSM: Plumb visibility into optional "enabled" state
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Message-ID: <20180916003059.1046-11-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In preparation for lifting the "is this LSM enabled?" logic out of the
individual LSMs, pass in any special enabled state tracking (as needed
for SELinux, AppArmor, and LoadPin). This must be an "int" to include
handling cases where "enabled" is exposed via sysctl which has no "bool"
type (i.e. LoadPin's use).

LoadPin's "enabled" tracking will be added later when it is marked as
LSM_TYPE_MINOR.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 1 +
 security/apparmor/lsm.c   | 5 +++--
 security/selinux/hooks.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a7833193e9e9..8a3a6cd26f03 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2046,6 +2046,7 @@ enum lsm_type {
 
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
+	int *enabled;		/* Optional: NULL means enabled. */
 	enum lsm_type type;	/* Optional: default is LSM_TYPE_EXCLUSIVE */
 	int (*init)(void);
 };
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7fa7b4464cf4..6cd630b34c3b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1303,8 +1303,8 @@ bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
-static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
-module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
+static int apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
+module_param_named(enabled, apparmor_enabled, int, 0444);
 
 static int __init apparmor_enabled_setup(char *str)
 {
@@ -1607,5 +1607,6 @@ static int __init apparmor_init(void)
 }
 
 DEFINE_LSM(apparmor)
+	.enabled = &apparmor_enabled,
 	.init = apparmor_init,
 END_LSM;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 469a90806bc6..78b5afc188f3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7203,6 +7203,7 @@ void selinux_complete_init(void)
 /* SELinux requires early initialization in order to label
    all processes and objects when they are created. */
 DEFINE_LSM(selinux)
+	.enabled = &selinux_enabled,
 	.init = selinux_init,
 END_LSM;
 
-- 
2.17.1

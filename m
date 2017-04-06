From: john.johansen@canonical.com (John Johansen)
Date: Thu,  6 Apr 2017 06:55:23 -0700
Subject: [PATCH 5/6] apparmor: fix parameters so that the permission test is
	bypassed at boot
In-Reply-To: <20170406135524.25481-1-john.johansen@canonical.com>
References: <20170406135524.25481-1-john.johansen@canonical.com>
Message-ID: <20170406135524.25481-6-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Boot parameters are written before apparmor is ready to answer whether
the user is policy_view_capable(). Setting the parameters at boot results
in an oops and failure to boot. Setting the parameters at boot is
obviously allowed so skip the permission check when apparmor is not
initialized.

While we are at it move the more complicated check to last.

Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/lib.h |  2 +-
 security/apparmor/lsm.c         | 47 +++++++++++++++++++----------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index fa281c2..66d8bc0 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -57,7 +57,7 @@
 	pr_err_ratelimited("AppArmor: " fmt, ##args)
 
 /* Flag indicating whether initialization completed */
-extern int apparmor_initialized __initdata;
+extern int apparmor_initialized;
 
 /* fn's in lib */
 char *aa_split_fqname(char *args, char **ns_name);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5f7d4dd..77d4045 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -39,7 +39,7 @@
 #include "include/procattr.h"
 
 /* Flag indicating whether initialization completed */
-int apparmor_initialized __initdata;
+int apparmor_initialized;
 
 DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 
@@ -738,78 +738,77 @@ __setup("apparmor=", apparmor_enabled_setup);
 /* set global flag turning off the ability to load policy */
 static int param_set_aalockpolicy(const char *val, const struct kernel_param *kp)
 {
-	if (!policy_admin_capable(NULL))
+	if (!apparmor_enabled)
+		return -EINVAL;
+	if (apparmor_initialized && !policy_admin_capable(NULL))
 		return -EPERM;
 	return param_set_bool(val, kp);
 }
 
 static int param_get_aalockpolicy(char *buffer, const struct kernel_param *kp)
 {
-	if (!policy_view_capable(NULL))
-		return -EPERM;
 	if (!apparmor_enabled)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_view_capable(NULL))
+		return -EPERM;
 	return param_get_bool(buffer, kp);
 }
 
 static int param_set_aabool(const char *val, const struct kernel_param *kp)
 {
-	if (!policy_admin_capable(NULL))
-		return -EPERM;
 	if (!apparmor_enabled)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_admin_capable(NULL))
+		return -EPERM;
 	return param_set_bool(val, kp);
 }
 
 static int param_get_aabool(char *buffer, const struct kernel_param *kp)
 {
-	if (!policy_view_capable(NULL))
-		return -EPERM;
 	if (!apparmor_enabled)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_view_capable(NULL))
+		return -EPERM;
 	return param_get_bool(buffer, kp);
 }
 
 static int param_set_aauint(const char *val, const struct kernel_param *kp)
 {
-	if (!policy_admin_capable(NULL))
-		return -EPERM;
 	if (!apparmor_enabled)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_admin_capable(NULL))
+		return -EPERM;
 	return param_set_uint(val, kp);
 }
 
 static int param_get_aauint(char *buffer, const struct kernel_param *kp)
 {
-	if (!policy_view_capable(NULL))
-		return -EPERM;
 	if (!apparmor_enabled)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_view_capable(NULL))
+		return -EPERM;
 	return param_get_uint(buffer, kp);
 }
 
 static int param_get_audit(char *buffer, struct kernel_param *kp)
 {
-	if (!policy_view_capable(NULL))
-		return -EPERM;
-
 	if (!apparmor_enabled)
 		return -EINVAL;
-
+	if (apparmor_initialized && !policy_view_capable(NULL))
+		return -EPERM;
 	return sprintf(buffer, "%s", audit_mode_names[aa_g_audit]);
 }
 
 static int param_set_audit(const char *val, struct kernel_param *kp)
 {
 	int i;
-	if (!policy_admin_capable(NULL))
-		return -EPERM;
 
 	if (!apparmor_enabled)
 		return -EINVAL;
-
 	if (!val)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_admin_capable(NULL))
+		return -EPERM;
 
 	for (i = 0; i < AUDIT_MAX_INDEX; i++) {
 		if (strcmp(val, audit_mode_names[i]) == 0) {
@@ -823,11 +822,10 @@ static int param_set_audit(const char *val, struct kernel_param *kp)
 
 static int param_get_mode(char *buffer, struct kernel_param *kp)
 {
-	if (!policy_view_capable(NULL))
-		return -EPERM;
-
 	if (!apparmor_enabled)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_view_capable(NULL))
+		return -EPERM;
 
 	return sprintf(buffer, "%s", aa_profile_mode_names[aa_g_profile_mode]);
 }
@@ -835,14 +833,13 @@ static int param_get_mode(char *buffer, struct kernel_param *kp)
 static int param_set_mode(const char *val, struct kernel_param *kp)
 {
 	int i;
-	if (!policy_admin_capable(NULL))
-		return -EPERM;
 
 	if (!apparmor_enabled)
 		return -EINVAL;
-
 	if (!val)
 		return -EINVAL;
+	if (apparmor_initialized && !policy_admin_capable(NULL))
+		return -EPERM;
 
 	for (i = 0; i < APPARMOR_MODE_NAMES_MAX_INDEX; i++) {
 		if (strcmp(val, aa_profile_mode_names[i]) == 0) {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

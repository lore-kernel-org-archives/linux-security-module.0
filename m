From: thomas@m3y3r.de (Thomas Meyer)
Date: Sat, 07 Oct 2017 16:02:21 +0200
Subject: [PATCH] apparmor: Fix bool initialization/comparison
In-Reply-To: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Message-ID: <1507383097088-925464657-17-diffsplit-thomas@m3y3r.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/security/apparmor/lsm.c b/security/apparmor/lsm.c
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -761,7 +761,7 @@ module_param_call(audit, param_set_audit
 /* Determines if audit header is included in audited messages.  This
  * provides more context if the audit daemon is not running
  */
-bool aa_g_audit_header = 1;
+bool aa_g_audit_header = true;
 module_param_named(audit_header, aa_g_audit_header, aabool,
 		   S_IRUSR | S_IWUSR);
 
@@ -786,7 +786,7 @@ module_param_named(path_max, aa_g_path_m
  * DEPRECATED: read only as strict checking of load is always done now
  * that none root users (user namespaces) can load policy.
  */
-bool aa_g_paranoid_load = 1;
+bool aa_g_paranoid_load = true;
 module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
 
 /* Boot time disable flag */
@@ -1034,7 +1034,7 @@ static int __init apparmor_init(void)
 
 	if (!apparmor_enabled || !security_module_enable("apparmor")) {
 		aa_info_message("AppArmor disabled by boot time parameter");
-		apparmor_enabled = 0;
+		apparmor_enabled = false;
 		return 0;
 	}
 
@@ -1090,7 +1090,7 @@ alloc_out:
 	aa_destroy_aafs();
 	aa_teardown_dfa_engine();
 
-	apparmor_enabled = 0;
+	apparmor_enabled = false;
 	return error;
 }
 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

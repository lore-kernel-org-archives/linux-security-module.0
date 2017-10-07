From: thomas@m3y3r.de (Thomas Meyer)
Date: Sat, 07 Oct 2017 16:02:21 +0200
Subject: [PATCH] ima: Fix bool initialization/comparison
In-Reply-To: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
Message-ID: <1507383097088-1495282871-18-diffsplit-thomas@m3y3r.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Bool initializations should use true and false. Bool tests don't need
comparisons.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -32,7 +32,7 @@ bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
 #ifdef __BIG_ENDIAN
-	ima_canonical_fmt = 1;
+	ima_canonical_fmt = true;
 #endif
 	return 1;
 }
diff -u -p a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -196,9 +196,9 @@ static int __init policy_setup(char *str
 		if ((strcmp(p, "tcb") == 0) && !ima_policy)
 			ima_policy = DEFAULT_TCB;
 		else if (strcmp(p, "appraise_tcb") == 0)
-			ima_use_appraise_tcb = 1;
+			ima_use_appraise_tcb = true;
 		else if (strcmp(p, "secure_boot") == 0)
-			ima_use_secure_boot = 1;
+			ima_use_secure_boot = true;
 	}
 
 	return 1;
@@ -207,7 +207,7 @@ __setup("ima_policy=", policy_setup);
 
 static int __init default_appraise_policy_setup(char *str)
 {
-	ima_use_appraise_tcb = 1;
+	ima_use_appraise_tcb = true;
 	return 1;
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

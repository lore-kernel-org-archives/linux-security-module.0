From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  2 May 2017 14:47:09 -0400
Subject: [PATCH 1/4] ima: extend the "ima_policy" boot command line to support
	multiple policies
In-Reply-To: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1493750832-11981-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add support for providing multiple builtin policies on the "ima_policy="
boot command line.  Use "|" as the delimitor separating the policy names.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++------
 security/integrity/ima/ima_policy.c             | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ba45caabada..06b95e28e5e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1477,12 +1477,17 @@
 			in crypto/hash_info.h.
 
 	ima_policy=	[IMA]
-			The builtin measurement policy to load during IMA
-			setup.  Specyfing "tcb" as the value, measures all
-			programs exec'd, files mmap'd for exec, and all files
-			opened with the read mode bit set by either the
-			effective uid (euid=0) or uid=0.
-			Format: "tcb"
+			The builtin policies to load during IMA setup.
+			Format: "tcb | appraise_tcb"
+
+			The "tcb" policy measures all programs exec'd, files
+			mmap'd for exec, and all files opened with the read
+			mode bit set by either the effective uid (euid=0) or
+			uid=0.
+
+			The "appraise_tcb" policy appraises the integrity of
+			all files owned by root. (This is the equivalent
+			of ima_appraise_tcb.)
 
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ab1067db624..0ddc41389a9c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -170,19 +170,24 @@ static int __init default_measure_policy_setup(char *str)
 }
 __setup("ima_tcb", default_measure_policy_setup);
 
+static bool ima_use_appraise_tcb __initdata;
 static int __init policy_setup(char *str)
 {
-	if (ima_policy)
-		return 1;
+	char *p;
 
-	if (strcmp(str, "tcb") == 0)
-		ima_policy = DEFAULT_TCB;
+	while ((p = strsep(&str, " |\n")) != NULL) {
+		if (*p == ' ')
+			continue;
+		if ((strcmp(p, "tcb") == 0) && !ima_policy)
+			ima_policy = DEFAULT_TCB;
+		else if (strcmp(p, "appraise_tcb") == 0)
+			ima_use_appraise_tcb = 1;
+	}
 
 	return 1;
 }
 __setup("ima_policy=", policy_setup);
 
-static bool ima_use_appraise_tcb __initdata;
 static int __init default_appraise_policy_setup(char *str)
 {
 	ima_use_appraise_tcb = 1;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

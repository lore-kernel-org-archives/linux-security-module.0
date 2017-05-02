From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  2 May 2017 14:47:10 -0400
Subject: [PATCH 2/4] ima: define a set of appraisal rules requiring file
	signatures
In-Reply-To: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1493750832-11981-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The builtin "ima_appraise_tcb" policy should require file signatures for
at least a few of the hooks (eg. kernel modules, firmware, and the kexec
kernel image), but changing it would break the existing userspace/kernel
ABI.

This patch defines a new builtin policy named "secure_boot", which
can be specified on the "ima_policy=" boot command line, independently
or in conjunction with the "ima_appraise_tcb" policy, by specifing
ima_policy="appraise_tcb | secure_boot".  The new appraisal rules
requiring file signatures will be added prior to the "ima_appraise_tcb"
rules.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Changelog:
- Reference secure boot in the new builtin policy name. (Thiago Bauermann)
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++++-
 security/integrity/ima/ima_policy.c             | 26 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 06b95e28e5e2..4e15b6a67d2c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1478,7 +1478,7 @@
 
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
-			Format: "tcb | appraise_tcb"
+			Format: "tcb | appraise_tcb | secure_boot"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -1489,6 +1489,10 @@
 			all files owned by root. (This is the equivalent
 			of ima_appraise_tcb.)
 
+			The "secure_boot" policy appraises the integrity
+			of files (eg. kexec kernel image, kernel modules,
+			firmware, policy, etc) based on file signatures.
+
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
 			Computing Base.  This means IMA will measure all
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0ddc41389a9c..3653c86c70df 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -153,6 +153,17 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 #endif
 };
 
+static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
+	{.action = APPRAISE, .func = MODULE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	{.action = APPRAISE, .func = FIRMWARE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	{.action = APPRAISE, .func = POLICY_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+};
+
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
@@ -171,6 +182,7 @@ static int __init default_measure_policy_setup(char *str)
 __setup("ima_tcb", default_measure_policy_setup);
 
 static bool ima_use_appraise_tcb __initdata;
+static bool ima_use_secure_boot __initdata;
 static int __init policy_setup(char *str)
 {
 	char *p;
@@ -182,6 +194,8 @@ static int __init policy_setup(char *str)
 			ima_policy = DEFAULT_TCB;
 		else if (strcmp(p, "appraise_tcb") == 0)
 			ima_use_appraise_tcb = 1;
+		else if (strcmp(p, "secure_boot") == 0)
+			ima_use_secure_boot = 1;
 	}
 
 	return 1;
@@ -410,12 +424,14 @@ void ima_update_policy_flag(void)
  */
 void __init ima_init_policy(void)
 {
-	int i, measure_entries, appraise_entries;
+	int i, measure_entries, appraise_entries, secure_boot_entries;
 
 	/* if !ima_policy set entries = 0 so we load NO default rules */
 	measure_entries = ima_policy ? ARRAY_SIZE(dont_measure_rules) : 0;
 	appraise_entries = ima_use_appraise_tcb ?
 			 ARRAY_SIZE(default_appraise_rules) : 0;
+	secure_boot_entries = ima_use_secure_boot ?
+			ARRAY_SIZE(secure_boot_rules) : 0;
 
 	for (i = 0; i < measure_entries; i++)
 		list_add_tail(&dont_measure_rules[i].list, &ima_default_rules);
@@ -434,6 +450,14 @@ void __init ima_init_policy(void)
 		break;
 	}
 
+	/*
+	 * Insert the appraise rules requiring file signatures, prior to
+	 * any other appraise rules.
+	 */
+	for (i = 0; i < secure_boot_entries; i++)
+		list_add_tail(&secure_boot_rules[i].list,
+			      &ima_default_rules);
+
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
 			      &ima_default_rules);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

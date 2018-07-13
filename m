From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 13 Jul 2018 14:06:01 -0400
Subject: [PATCH v6 6/8] ima: add build time policy
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA by default does not measure, appraise or audit files, but can be
enabled at runtime by specifying a builtin policy on the boot command line
or by loading a custom policy.

This patch defines a build time policy, which verifies kernel modules,
firmware, kexec image, and/or the IMA policy signatures.  This build time
policy is automatically enabled at runtime and persists after loading a
custom policy.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      | 58 +++++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c | 46 +++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 94c2151331aa..13b446328dda 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -157,6 +157,64 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_APPRAISE_BUILD_POLICY
+	bool "IMA build time configured policy rules"
+	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+	default n
+	help
+	  This option defines an IMA appraisal policy at build time, which
+	  is enforced at run time without having to specify a builtin
+	  policy name on the boot command line.  The build time appraisal
+	  policy rules persist after loading a custom policy.
+
+	  Depending on the rules configured, this policy may require kernel
+	  modules, firmware, the kexec kernel image, and/or the IMA policy
+	  to be signed.  Unsigned files might prevent the system from
+	  booting or applications from working properly.
+
+config IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
+	bool "Appraise firmware signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  This option defines a policy requiring all firmware to be signed,
+	  including the regulatory.db.  If both this option and
+	  CFG80211_REQUIRE_SIGNED_REGDB are enabled, then both signature
+	  verification methods are necessary.
+
+config IMA_APPRAISE_REQUIRE_KEXEC_SIGS
+	bool "Appraise kexec kernel image signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require all kexec'ed kernel images to
+	  be signed and verified by a public key on the trusted IMA
+	  keyring.
+
+	  Kernel image signatures can not be verified by the original
+	  kexec_load syscall.  Enabling this rule will prevent its
+	  usage.
+
+config IMA_APPRAISE_REQUIRE_MODULE_SIGS
+	bool "Appraise kernel modules signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require all kernel modules to be signed
+	  and verified by a public key on the trusted IMA keyring.
+
+	  Kernel module signatures can only be verified by IMA-appraisal,
+	  via the finit_module syscall. Enabling this rule will prevent
+	  the usage of the init_module syscall.
+
+config IMA_APPRAISE_REQUIRE_POLICY_SIGS
+	bool "Appraise IMA policy signature"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require the IMA policy to be signed and
+	  and verified by a key on the trusted IMA keyring.
+
 config IMA_APPRAISE_BOOTPARAM
 	bool "ima_appraise boot parameter"
 	depends on IMA_APPRAISE
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ebfb389b79df..8c9499867c91 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -49,6 +49,7 @@
 
 int ima_policy_flag;
 static int temp_ima_appraise;
+static int build_ima_appraise __ro_after_init;
 
 #define MAX_LSM_RULES 6
 enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
@@ -162,6 +163,25 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 #endif
 };
 
+static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS
+	{.action = APPRAISE, .func = MODULE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
+	{.action = APPRAISE, .func = FIRMWARE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS
+	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_POLICY_SIGS
+	{.action = APPRAISE, .func = POLICY_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+};
+
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
@@ -435,7 +455,7 @@ void ima_update_policy_flag(void)
 			ima_policy_flag |= entry->action;
 	}
 
-	ima_appraise |= temp_ima_appraise;
+	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
@@ -488,8 +508,8 @@ void __init ima_init_policy(void)
 	}
 
 	/*
-	 * Insert the appraise rules requiring file signatures, prior to
-	 * any other appraise rules.
+	 * Insert the builtin "secure_boot" policy rules requiring file
+	 * signatures, prior to any other appraise rules.
 	 */
 	for (i = 0; i < secure_boot_entries; i++) {
 		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
@@ -497,6 +517,26 @@ void __init ima_init_policy(void)
 		    ima_appraise_flag(secure_boot_rules[i].func);
 	}
 
+	/*
+	 * Insert the build time appraise rules requiring file signatures
+	 * for both the initial and custom policies, prior to other appraise
+	 * rules.
+	 */
+	for (i = 0; i < ARRAY_SIZE(build_appraise_rules); i++) {
+		struct ima_rule_entry *entry;
+
+		if (!secure_boot_entries)
+			list_add_tail(&build_appraise_rules[i].list,
+				      &ima_default_rules);
+
+		entry = kmemdup(&build_appraise_rules[i], sizeof(*entry),
+				GFP_KERNEL);
+		if (entry)
+			list_add_tail(&entry->list, &ima_policy_rules);
+		build_ima_appraise |=
+			ima_appraise_flag(build_appraise_rules[i].func);
+	}
+
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
 			      &ima_default_rules);
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

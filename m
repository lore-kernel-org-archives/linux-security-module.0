From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 23 Oct 2017 11:59:47 -0400
Subject: [RFC PATCH] ima: require secure_boot rules in lockdown mode
Message-ID: <1508774387.3639.128.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Require the "secure_boot" rules, whether or not it is specified
on the boot command line, for both the builtin and custom policies
in secure boot lockdown mode.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 46 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 95209a5f8595..81a7496171d0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -196,9 +196,9 @@ static int __init policy_setup(char *str)
 		if ((strcmp(p, "tcb") == 0) && !ima_policy)
 			ima_policy = DEFAULT_TCB;
 		else if (strcmp(p, "appraise_tcb") == 0)
-			ima_use_appraise_tcb = 1;
+			ima_use_appraise_tcb = TRUE;
 		else if (strcmp(p, "secure_boot") == 0)
-			ima_use_secure_boot = 1;
+			ima_use_secure_boot = TRUE;
 	}
 
 	return 1;
@@ -427,14 +427,21 @@ void ima_update_policy_flag(void)
  */
 void __init ima_init_policy(void)
 {
-	int i, measure_entries, appraise_entries, secure_boot_entries;
+	int i;
+	int measure_entries = 0;
+	int appraise_entries = 0;
+	int secure_boot_entries = 0;
+	bool kernel_locked_down = kernel_is_locked_down();
 
 	/* if !ima_policy set entries = 0 so we load NO default rules */
-	measure_entries = ima_policy ? ARRAY_SIZE(dont_measure_rules) : 0;
-	appraise_entries = ima_use_appraise_tcb ?
-			 ARRAY_SIZE(default_appraise_rules) : 0;
-	secure_boot_entries = ima_use_secure_boot ?
-			ARRAY_SIZE(secure_boot_rules) : 0;
+	if (ima_policy)
+		measure_entries = ARRAY_SIZE(dont_measure_rules);
+
+	if (ima_use_appraise_tcb)
+		appraise_entries = ARRAY_SIZE(default_appraise_rules);
+
+	if (ima_use_secure_boot || kernel_locked_down)
+		secure_boot_entries = ARRAY_SIZE(secure_boot_rules);
 
 	for (i = 0; i < measure_entries; i++)
 		list_add_tail(&dont_measure_rules[i].list, &ima_default_rules);
@@ -455,11 +462,26 @@ void __init ima_init_policy(void)
 
 	/*
 	 * Insert the appraise rules requiring file signatures, prior to
-	 * any other appraise rules.
+	 * any other appraise rules.  In secure boot lock-down mode, also
+	 * require these appraise rules for custom policies.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
-		list_add_tail(&secure_boot_rules[i].list,
-			      &ima_default_rules);
+	for (i = 0; i < secure_boot_entries; i++) {
+		struct ima_rule_entry *entry;
+
+		/* Include for builtin policies */
+		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
+
+		/* Include for custom policies */
+		if (kernel_locked_down) {
+			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+			if (entry) {
+				memcpy(entry, &secure_boot_rules[i],
+				       sizeof(*entry));
+				INIT_LIST_HEAD(&entry->list);
+				list_add_tail(&entry->list, &ima_policy_rules);
+			}
+		}
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

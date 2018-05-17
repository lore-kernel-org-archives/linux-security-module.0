From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 May 2018 10:48:43 -0400
Subject: [PATCH v2 2/9] ima: fix updating the ima_appraise flag
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1526568530-9144-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

As IMA policy rules are added, a mask of the type of rule (eg. kexec
kernel image, firmware, IMA policy) is updated.  Based on this mask,
integrity decisions can be made quickly.

Unlike custom IMA policy rules, which replace the original builtin
policy rules and update the mask, the builtin "secure_boot" policy
rules were loaded, but did not update the mask.

This patch refactors the code to load custom policies, defining a new
function named ima_appraise_flag().  The new function is called either
when loading the builtin "secure_boot" or custom policies.

Fixes: 503ceaef8e2e ("ima: define a set of appraisal rules requiring file signatures")
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 03cbba423e59..8bbc18eb07eb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -440,6 +440,17 @@ void ima_update_policy_flag(void)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
 
+static int ima_appraise_flag(enum ima_hooks func)
+{
+	if (func == MODULE_CHECK)
+		return IMA_APPRAISE_MODULES;
+	else if (func == FIRMWARE_CHECK)
+		return IMA_APPRAISE_FIRMWARE;
+	else if (func == POLICY_CHECK)
+		return IMA_APPRAISE_POLICY;
+	return 0;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -478,9 +489,11 @@ void __init ima_init_policy(void)
 	 * Insert the appraise rules requiring file signatures, prior to
 	 * any other appraise rules.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
-		list_add_tail(&secure_boot_rules[i].list,
-			      &ima_default_rules);
+	for (i = 0; i < secure_boot_entries; i++) {
+		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
+		temp_ima_appraise |=
+		    ima_appraise_flag(secure_boot_rules[i].func);
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
@@ -934,12 +947,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	}
 	if (!result && (entry->action == UNKNOWN))
 		result = -EINVAL;
-	else if (entry->func == MODULE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_MODULES;
-	else if (entry->func == FIRMWARE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
-	else if (entry->func == POLICY_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_POLICY;
+	else if (entry->action == APPRAISE)
+		temp_ima_appraise |= ima_appraise_flag(entry->func);
+
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

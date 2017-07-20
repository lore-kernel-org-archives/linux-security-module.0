From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Thu, 20 Jul 2017 18:50:32 -0400
Subject: [RFC PATCH 4/5] ima: differentiate auditing policy rules from "audit"
	actions
In-Reply-To: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
Message-ID: <20170720225033.21298-5-mkayaalp@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
to reflect the IMA policy rules.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/uapi/linux/audit.h          | 3 ++-
 security/integrity/ima/ima_policy.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 0714a66..649d4c4 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -144,7 +144,8 @@
 #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
 #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
 #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
-#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
+#define AUDIT_INTEGRITY_RULE	    1805 /* IMA audit action policy msgs */
+#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f443662..9844eb1 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -613,7 +613,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
+	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

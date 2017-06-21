From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:23 -0400
Subject: [PATCH v2 03/10] ima: define "dont_failsafe" policy action rule
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Permit normally denied access/execute permission for files in policy
on IMA unsupported filesystems.  This patch defines the "dont_failsafe"
policy action rule.

Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  3 ++-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_main.c    | 11 ++++++++++-
 security/integrity/ima/ima_policy.c  | 14 +++++++++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e76432b9954d..f271207743e5 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -17,7 +17,8 @@ Description:
 
 		rule format: action [condition ...]
 
-		action: measure | dont_measure | appraise | dont_appraise | audit
+		action: measure | dont_meaure | appraise | dont_appraise |
+			audit | dont_failsafe
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
 				[euid=] [fowner=]]
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d52b487ad259..c5f34f7c5b0f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -224,6 +224,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
+void set_failsafe(bool flag);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 63777d1210b1..59e271a20600 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -38,6 +38,11 @@ int ima_appraise;
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
+static bool ima_failsafe = 1;
+void set_failsafe(bool flag) {
+	ima_failsafe = flag;
+}
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -263,8 +268,12 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 		__putname(pathbuf);
 out:
 	inode_unlock(inode);
-	if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE))
+	if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+		if (!ima_failsafe && rc == -EBADF)
+			return 0;
+
 		return -EACCES;
+	}
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f4436626ccb7..cb92c9c04e80 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -46,6 +46,7 @@
 
 int ima_policy_flag;
 static int temp_ima_appraise;
+static bool temp_failsafe = 1;
 
 #define MAX_LSM_RULES 6
 enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
@@ -513,6 +514,12 @@ void ima_update_policy(void)
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
 		ima_rules = policy;
+
+		/*
+		 * Only permit initial policy replacement, not append, to
+		 * set dont_failsafe.
+		 */
+		set_failsafe(temp_failsafe);
 	}
 	ima_update_policy_flag();
 }
@@ -529,7 +536,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_dont_failsafe
 };
 
 static match_table_t policy_tokens = {
@@ -560,6 +567,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_dont_failsafe, "dont_failsafe"},
 	{Opt_err, NULL}
 };
 
@@ -671,6 +679,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->action = AUDIT;
 			break;
+		case Opt_dont_failsafe:
+			ima_log_string(ab, "action", "dont_failsafe");
+			temp_failsafe = 0;
+			break;
 		case Opt_func:
 			ima_log_string(ab, "func", args[0].from);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

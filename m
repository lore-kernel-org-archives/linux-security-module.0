From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 26 Jul 2017 09:22:53 -0400
Subject: [PATCH v4 3/5] ima: define "dont_failsafe" policy action rule
In-Reply-To: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1501075375-29469-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Permit normally denied access/execute permission for files in policy
on IMA unsupported filesystems.  This patch defines the "dont_failsafe"
policy action rule.

Mimi Zohar <zohar@linux.vnet.ibm.com>

---
Changelog v3:
- include dont_failsafe rule when displaying policy
- fail attempt to add dont_failsafe rule when appending to the policy

 Documentation/ABI/testing/ima_policy |  3 ++-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_main.c    | 11 ++++++++++-
 security/integrity/ima/ima_policy.c  | 29 ++++++++++++++++++++++++++++-
 4 files changed, 41 insertions(+), 3 deletions(-)

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
index 3941371402ff..664edab0f758 100644
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
index 95209a5f8595..43b85a4fb8e8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -40,12 +40,14 @@
 #define APPRAISE	0x0004	/* same as IMA_APPRAISE */
 #define DONT_APPRAISE	0x0008
 #define AUDIT		0x0040
+#define DONT_FAILSAFE	0x0400
 
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (FIELD_SIZEOF(struct integrity_iint_cache, measured_pcrs) * 8))
 
 int ima_policy_flag;
 static int temp_ima_appraise;
+static bool temp_failsafe = 1;
 
 #define MAX_LSM_RULES 6
 enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
@@ -513,6 +515,9 @@ void ima_update_policy(void)
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
 		ima_rules = policy;
+
+		/* Only update on initial policy replacement, not append */
+		set_failsafe(temp_failsafe);
 	}
 	ima_update_policy_flag();
 }
@@ -529,7 +534,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_dont_failsafe
 };
 
 static match_table_t policy_tokens = {
@@ -560,6 +565,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_dont_failsafe, "dont_failsafe"},
 	{Opt_err, NULL}
 };
 
@@ -630,6 +636,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		if ((*p == '\0') || (*p == ' ') || (*p == '\t'))
 			continue;
 		token = match_token(p, policy_tokens, args);
+		if (entry->action == DONT_FAILSAFE) {
+			/* no args permitted, force invalid rule */
+			token = Opt_dont_failsafe;
+		}
+
 		switch (token) {
 		case Opt_measure:
 			ima_log_string(ab, "action", "measure");
@@ -671,6 +682,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->action = AUDIT;
 			break;
+		case Opt_dont_failsafe:
+			ima_log_string(ab, "action", "dont_failsafe");
+
+			if (entry->action != UNKNOWN)
+				result = -EINVAL;
+
+			/* Permit on initial policy replacement only */
+			if (ima_rules != &ima_policy_rules)
+				temp_failsafe = 0;
+			else
+				result = -EINVAL;
+			entry->action = DONT_FAILSAFE;
+			break;
 		case Opt_func:
 			ima_log_string(ab, "func", args[0].from);
 
@@ -949,6 +973,7 @@ void ima_delete_rules(void)
 	int i;
 
 	temp_ima_appraise = 0;
+	temp_failsafe = 1;
 	list_for_each_entry_safe(entry, tmp, &ima_temp_rules, list) {
 		for (i = 0; i < MAX_LSM_RULES; i++)
 			kfree(entry->lsm[i].args_p);
@@ -1040,6 +1065,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, pt(Opt_dont_appraise));
 	if (entry->action & AUDIT)
 		seq_puts(m, pt(Opt_audit));
+	if (entry->action & DONT_FAILSAFE)
+		seq_puts(m, pt(Opt_dont_failsafe));
 
 	seq_puts(m, " ");
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

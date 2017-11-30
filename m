From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:09 +0100
Subject: [RFC][PATCH v2 8/9] ima: introduce policy action try_appraise
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-9-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

According to the Biba integrity models, TCB processes won't be corrupted by
writing non-TCB objects.

Introduce the new policy action try_appraise, so that TCB processes are
allowed to write files regardless of the appraisal status. security.ima
will not be updated. An IMA policy for open() that satisfies the
requirements of the Biba integrity models could be:

appraise uid=0 mask=^MAY_EXEC (check read up)
appraise euid=0 mask=^MAY_EXEC (check read up)
appraise uid=0 mask=^MAY_READ (check read up)
appraise euid=0 mask=^MAY_READ (check read up)
try_appraise uid=0 mask=^MAY_WRITE (update security.ima if possible)
try_appraise euid=0 mask=^MAY_WRITE (update security.ima if possible)

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c   |  4 +++-
 security/integrity/ima/ima_policy.c | 16 +++++++++++++---
 security/integrity/integrity.h      |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ee9897c8d0cc..0f746b8bd965 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -178,6 +178,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
+	int try_appraise;
 	int rc = -ENOMEM, action, must_appraise;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
@@ -199,6 +200,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		return 0;
 
 	must_appraise = action & IMA_APPRAISE;
+	try_appraise = action & IMA_TRY_APPRAISE;
 
 	/*  Is the appraise rule hook specific?  */
 	if (action & IMA_FILE_APPRAISE)
@@ -286,7 +288,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	inode_unlock(inode);
 	if (((rc && must_appraise) ||
 	    (ima_integrity_model && model_violation)) &&
-	    (ima_appraise & IMA_APPRAISE_ENFORCE))
+	    (ima_appraise & IMA_APPRAISE_ENFORCE) && !try_appraise)
 		return -EACCES;
 	return 0;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cd2289daacee..dd8e4c226089 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -532,7 +532,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_try_appraise
 };
 
 static match_table_t policy_tokens = {
@@ -563,6 +563,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_try_appraise, "try_appraise"},
 	{Opt_err, NULL}
 };
 
@@ -652,11 +653,16 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		case Opt_appraise:
 			ima_log_string(ab, "action", "appraise");
+		case Opt_try_appraise:
+			if (token == Opt_try_appraise)
+				ima_log_string(ab, "action", "try_appraise");
 
 			if (entry->action != UNKNOWN)
 				result = -EINVAL;
 
 			entry->action = APPRAISE;
+			if (token == Opt_try_appraise)
+				entry->flags |= IMA_TRY_APPRAISE;
 			break;
 		case Opt_dont_appraise:
 			ima_log_string(ab, "action", "dont_appraise");
@@ -1039,8 +1045,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, pt(Opt_measure));
 	if (entry->action & DONT_MEASURE)
 		seq_puts(m, pt(Opt_dont_measure));
-	if (entry->action & APPRAISE)
-		seq_puts(m, pt(Opt_appraise));
+	if (entry->action & APPRAISE) {
+		if (entry->flags & IMA_TRY_APPRAISE)
+			seq_puts(m, pt(Opt_try_appraise));
+		else
+			seq_puts(m, pt(Opt_appraise));
+	}
 	if (entry->action & DONT_APPRAISE)
 		seq_puts(m, pt(Opt_dont_appraise));
 	if (entry->action & AUDIT)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index d70fd875d62f..86274385f9f4 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -33,6 +33,7 @@
 #define IMA_DIGSIG_REQUIRED	0x02000000
 #define IMA_PERMIT_DIRECTIO	0x04000000
 #define IMA_NEW_FILE		0x08000000
+#define IMA_TRY_APPRAISE	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_APPRAISE_SUBMASK)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

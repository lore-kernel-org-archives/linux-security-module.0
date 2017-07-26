From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 26 Jul 2017 09:22:55 -0400
Subject: [PATCH v4 5/5] ima: remove permit_directio policy option
In-Reply-To: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1501075375-29469-6-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

With the new ->integrity_read file_operations method support, files
opened with the O_DIRECT flag should work properly.  This patch
reverts commit f9b2a735bddd "ima: audit log files opened with O_DIRECT
flag".

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy | 2 +-
 security/integrity/ima/ima_api.c     | 6 ------
 security/integrity/ima/ima_main.c    | 5 +----
 security/integrity/ima/ima_policy.c  | 8 +-------
 security/integrity/integrity.h       | 1 -
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index f271207743e5..441a78e7b87e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -24,7 +24,7 @@ Description:
 				[euid=] [fowner=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=]] [permit_directio]
+			option:	[[appraise_type=]]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bbf3ba8bbb09..7bc8e76c06f5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -210,12 +210,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	if (iint->flags & IMA_COLLECTED)
 		goto out;
 
-	if (file->f_flags & O_DIRECT) {
-		audit_cause = "failed(directio)";
-		result = -EACCES;
-		goto out;
-	}
-
 	i_version = file_inode(file)->i_version;
 	hash.hdr.algo = algo;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 664edab0f758..9b8ede84337f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -240,11 +240,8 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
 	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
-	if (rc != 0 && rc != -EBADF && rc != -EINVAL) {
-		if (file->f_flags & O_DIRECT)
-			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
+	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_digsig;
-	}
 
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cddd9dfb01e1..3b54fb32e837 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -545,7 +545,7 @@ enum {
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
-	Opt_appraise_type, Opt_permit_directio,
+	Opt_appraise_type,
 	Opt_pcr, Opt_dont_failsafe
 };
 
@@ -575,7 +575,6 @@ static match_table_t policy_tokens = {
 	{Opt_euid_lt, "euid<%s"},
 	{Opt_fowner_lt, "fowner<%s"},
 	{Opt_appraise_type, "appraise_type=%s"},
-	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_dont_failsafe, "dont_failsafe"},
 	{Opt_err, NULL}
@@ -892,9 +891,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else
 				result = -EINVAL;
 			break;
-		case Opt_permit_directio:
-			entry->flags |= IMA_PERMIT_DIRECTIO;
-			break;
 		case Opt_pcr:
 			if (entry->action != MEASURE) {
 				result = -EINVAL;
@@ -1179,8 +1175,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 	if (entry->flags & IMA_DIGSIG_REQUIRED)
 		seq_puts(m, "appraise_type=imasig ");
-	if (entry->flags & IMA_PERMIT_DIRECTIO)
-		seq_puts(m, "permit_directio ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a53e7e4ab06c..790f07e515a7 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -31,7 +31,6 @@
 #define IMA_ACTION_RULE_FLAGS	0x06000000
 #define IMA_DIGSIG		0x01000000
 #define IMA_DIGSIG_REQUIRED	0x02000000
-#define IMA_PERMIT_DIRECTIO	0x04000000
 #define IMA_NEW_FILE		0x08000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

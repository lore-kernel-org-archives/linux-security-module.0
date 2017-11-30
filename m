From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:07 +0100
Subject: [RFC][PATCH v2 6/9] ima: enforce the Biba strict policy on appraised
	files
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-7-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA does not make any distinction between immutable and mutable files. The
measurement list often contains unknown digests of mutable files, which
cannot be recognized by comparing them with reference values. If mutable
files can be modified only by the TCB, and are protected against offline
attacks, it wouldn't be necessary to measure them.

Security policies for general purpose systems often do not satisfy the
requirements of an integrity model. Thus, mutable files have to be measured
because their integrity cannot be guaranteed.

With this patch, IMA can enforce the constraints of the Biba strict model
on top of existing LSMs. The decision is made depending on the IMA policy,
which should specify criteria for TCB processes, and depending on the
appraisal status.

This patch ensures that: files with a valid appraisal status can be written
only by processes in the TCB (write down constraint); every file read by a
process in the TCB must have a valid appraisal status (read up constraint).

Changelog

v1:
- added loop in integrity_policy_setup()
- check read up violations
- clear IMA_APPRAISE if there is a policy violation
- kernel parameter ima_integrity_policy renamed to ima_integrity_model
- detect write down violations only if appraisal status is valid

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 security/integrity/ima/ima.h                    |  16 ++++
 security/integrity/ima/ima_appraise.c           | 101 ++++++++++++++++++++++++
 security/integrity/ima/ima_main.c               |  29 ++++---
 4 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 05496622b4ef..6d184a94ba20 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1532,6 +1532,10 @@
 	                [IMA] Define a custom template format.
 			Format: { "field1|...|fieldN" }
 
+	ima_integrity_model=
+			[IMA] Select an integrity model.
+			Models: { "biba-strict" }
+
 	ima.ahash_minsize= [IMA] Minimum file size for asynchronous hash usage
 			Format: <min_file_size>
 			Set the minimal file size for using asynchronous hash.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f2cdd528f8ff..b9fdf0264c9d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -36,6 +36,8 @@ enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 
+enum integrity_models { BIBA_STRICT = 1, INTEGRITY_POLICY__LAST };
+
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
 #define IMA_EVENT_NAME_LEN_MAX	255
@@ -58,6 +60,7 @@ extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct path ima_null;
+extern int ima_integrity_model;
 
 /* IMA event related data */
 struct ima_event_data {
@@ -249,6 +252,10 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
+bool ima_appraise_integrity_check(struct file *file,
+				  struct integrity_iint_cache *iint,
+				  int must_appraise, char **pathbuf,
+				  const char **pathname, char *namebuf);
 
 #else
 static inline int ima_appraise_measurement(enum ima_hooks func,
@@ -291,6 +298,15 @@ static inline int ima_read_xattr(struct dentry *dentry,
 	return 0;
 }
 
+static inline bool ima_appraise_integrity_check(struct file *file,
+					   struct integrity_iint_cache *iint,
+					   int must_appraise, char **pathbuf,
+					   const char **pathname,
+					   char *namebuf)
+{
+	return false;
+}
+
 #endif /* CONFIG_IMA_APPRAISE */
 
 /* LSM based policy rules require audit */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 23e025e86aed..27bbf48596cb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -18,6 +18,12 @@
 
 #include "ima.h"
 
+int ima_integrity_model;
+
+static char *ima_integrity_models_str[INTEGRITY_POLICY__LAST] = {
+	[BIBA_STRICT] = "biba-strict",
+};
+
 static int __init default_appraise_setup(char *str)
 {
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
@@ -33,6 +39,27 @@ static int __init default_appraise_setup(char *str)
 
 __setup("ima_appraise=", default_appraise_setup);
 
+static int __init integrity_model_setup(char *str)
+{
+	int i;
+
+	for (i = BIBA_STRICT; i < INTEGRITY_POLICY__LAST; i++) {
+		if (strcmp(str, ima_integrity_models_str[i]) == 0) {
+			ima_integrity_model = i;
+			break;
+		}
+	}
+
+	if (i == INTEGRITY_POLICY__LAST) {
+		pr_err("Invalid model %s, using %s\n", str,
+		       ima_integrity_models_str[BIBA_STRICT]);
+		ima_integrity_model = BIBA_STRICT;
+	}
+
+	return 1;
+}
+__setup("ima_integrity_model=", integrity_model_setup);
+
 /*
  * is_ima_appraise_enabled - return appraise status
  *
@@ -197,6 +224,80 @@ int ima_read_xattr(struct dentry *dentry,
 	return ret;
 }
 
+bool ima_inode_is_appraised(struct dentry *dentry, struct inode *inode)
+{
+	ssize_t len;
+
+	len =  __vfs_getxattr(dentry, inode, XATTR_NAME_IMA, NULL, 0);
+
+	return (len > 0 && len >= sizeof(struct evm_ima_xattr_data));
+}
+
+/*
+ * ima_appraise_integrity_check - detect violations of an integrity policy
+ *
+ * The appraisal policy identifies which subjects belong to the TCB. Files
+ * with a valid digital signature or HMAC are also part of the TCB. This
+ * function enforces constraints of the selected integrity model.
+ *
+ * Conventions:
+ * - must_appraise: true (TCB subject), false (non-TCB subject)
+ * - iint status: INTEGRITY_PASS (TCB object), other values (non-TCB object)
+ *
+ * Constraints:
+ * - write down: TCB object can be written only by TCB subject
+ * - read up: TCB subject can read only TCB objects
+ *
+ * Integrity models:
+ * - biba-strict: write down, read up
+ *
+ * Return: true if constraints are violated, false otherwise
+ */
+bool ima_appraise_integrity_check(struct file *file,
+				  struct integrity_iint_cache *iint,
+				  int must_appraise, char **pathbuf,
+				  const char **pathname, char *namebuf)
+{
+	struct inode *inode = file_inode(file);
+	fmode_t mode = file->f_mode;
+	char *cause = "write_down_violation";
+	int expected_writecount = (mode & FMODE_WRITE) ? 1 : 0;
+
+	/* check write down violations */
+	if (!must_appraise && (mode & FMODE_WRITE)) {
+		if (IS_IMA(inode)) {
+			if (!iint)
+				iint = integrity_iint_find(inode);
+			if (iint->flags & IMA_APPRAISED)
+				goto out_violation;
+		} else if (ima_inode_is_appraised(file_dentry(file), inode)) {
+			goto out_violation;
+		}
+	/* concurrent write to non-TCB object by non-TCB subjects */
+	} else if (must_appraise && !(iint->flags & IMA_APPRAISED) &&
+		   atomic_read(&inode->i_writecount) > expected_writecount) {
+		/* updating security.ima will cause a write down violation */
+		if (mode & FMODE_WRITE) {
+			cause = "write_down_violation_tcb";
+			goto out_violation;
+		}
+
+		/* check read up violations */
+		if (mode & (FMODE_READ | FMODE_EXEC)) {
+			cause = "read_up_violation";
+			goto out_violation;
+		}
+	}
+
+	return false;
+out_violation:
+	*pathname = ima_d_path(&file->f_path, pathbuf, namebuf);
+	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
+			    ima_integrity_models_str[ima_integrity_model],
+			    cause, 0, 0);
+	return true;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a12f8a148e5e..ee9897c8d0cc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -108,7 +108,8 @@ static void ima_rdwr_violation_check(struct file *file,
 	if (!send_tomtou && !send_writers)
 		return;
 
-	*pathname = ima_d_path(&file->f_path, pathbuf, filename);
+	if (!*pathname)
+		*pathname = ima_d_path(&file->f_path, pathbuf, filename);
 
 	if (send_tomtou)
 		ima_add_violation(file, *pathname, iint,
@@ -181,7 +182,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	int xattr_len = 0;
-	bool violation_check;
+	bool violation_check, model_violation = false;
 	enum hash_algo hash_algo;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
@@ -194,7 +195,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	action = ima_get_action(inode, cred, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
-	if (!action && !violation_check)
+	if (!action && !violation_check && !ima_integrity_model)
 		return 0;
 
 	must_appraise = action & IMA_APPRAISE;
@@ -211,13 +212,21 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			goto out;
 	}
 
-	if (violation_check) {
+	if (ima_integrity_model) {
+		model_violation = ima_appraise_integrity_check(file, iint,
+							must_appraise, &pathbuf,
+							&pathname, filename);
+		/* access will be denied */
+		if (model_violation)
+			action &= ~IMA_APPRAISE;
+	}
+
+	if (violation_check)
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename);
-		if (!action) {
-			rc = 0;
-			goto out_free;
-		}
+	if (!action) {
+		rc = 0;
+		goto out_free;
 	}
 
 	/* Determine if already appraised/measured based on bitmask
@@ -275,7 +284,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		__putname(pathbuf);
 out:
 	inode_unlock(inode);
-	if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE))
+	if (((rc && must_appraise) ||
+	    (ima_integrity_model && model_violation)) &&
+	    (ima_appraise & IMA_APPRAISE_ENFORCE))
 		return -EACCES;
 	return 0;
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

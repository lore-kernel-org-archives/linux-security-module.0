From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:08 +0100
Subject: [RFC][PATCH v2 7/9] ima: enforce the Biba low watermark for objects
	policy on appraised files
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-8-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

With this patch, IMA enforces a less restrictive integrity policy on
appraised files. Instead of preventing processes outside the TCB from
writing appraised files, IMA removes security.ima and then allows the
operation. TCB processes won't be able to access demoted files anymore.

Removing security.ima allows attacks to TCB to be detected by remote
verifiers even if appraisal is not in enforcing mode. If an integrity
model is selected, only files with a valid appraisal status will be
excluded from measurement.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 security/integrity/ima/ima.h                    |  3 ++-
 security/integrity/ima/ima_appraise.c           | 29 ++++++++++++++++++++++---
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6d184a94ba20..491fc3b312e7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1534,7 +1534,7 @@
 
 	ima_integrity_model=
 			[IMA] Select an integrity model.
-			Models: { "biba-strict" }
+			Models: { "biba-strict", "low-watermark-obj" }
 
 	ima.ahash_minsize= [IMA] Minimum file size for asynchronous hash usage
 			Format: <min_file_size>
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b9fdf0264c9d..ad615051e51b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -36,7 +36,8 @@ enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 
-enum integrity_models { BIBA_STRICT = 1, INTEGRITY_POLICY__LAST };
+enum integrity_models { BIBA_STRICT = 1, BIBA_LOW_WATERMARK_OBJ,
+			INTEGRITY_POLICY__LAST };
 
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 27bbf48596cb..302d7e3ade65 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -22,6 +22,7 @@ int ima_integrity_model;
 
 static char *ima_integrity_models_str[INTEGRITY_POLICY__LAST] = {
 	[BIBA_STRICT] = "biba-strict",
+	[BIBA_LOW_WATERMARK_OBJ] = "low-watermark-obj",
 };
 
 static int __init default_appraise_setup(char *str)
@@ -250,6 +251,7 @@ bool ima_inode_is_appraised(struct dentry *dentry, struct inode *inode)
  *
  * Integrity models:
  * - biba-strict: write down, read up
+ * - low-watermark-obj: read up
  *
  * Return: true if constraints are violated, false otherwise
  */
@@ -262,6 +264,8 @@ bool ima_appraise_integrity_check(struct file *file,
 	fmode_t mode = file->f_mode;
 	char *cause = "write_down_violation";
 	int expected_writecount = (mode & FMODE_WRITE) ? 1 : 0;
+	int expected_readcount = 0;
+	int violation = true;
 
 	/* check write down violations */
 	if (!must_appraise && (mode & FMODE_WRITE)) {
@@ -269,9 +273,9 @@ bool ima_appraise_integrity_check(struct file *file,
 			if (!iint)
 				iint = integrity_iint_find(inode);
 			if (iint->flags & IMA_APPRAISED)
-				goto out_violation;
+				goto out_write_down_violation;
 		} else if (ima_inode_is_appraised(file_dentry(file), inode)) {
-			goto out_violation;
+			goto out_write_down_violation;
 		}
 	/* concurrent write to non-TCB object by non-TCB subjects */
 	} else if (must_appraise && !(iint->flags & IMA_APPRAISED) &&
@@ -290,12 +294,31 @@ bool ima_appraise_integrity_check(struct file *file,
 	}
 
 	return false;
+out_write_down_violation:
+	/* demote TCB object, if no concurrent access by TCB subjects */
+	if (ima_integrity_model == BIBA_LOW_WATERMARK_OBJ) {
+		cause = "demote_failed_open_readers";
+		if (mode & (FMODE_READ | FMODE_WRITE) == FMODE_READ)
+			expected_readcount = 1;
+		if (atomic_read(&inode->i_readcount) == expected_readcount) {
+			if (iint)
+				iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
+						 IMA_APPRAISE_SUBMASK |
+						 IMA_APPRAISED_SUBMASK |
+						 IMA_ACTION_RULE_FLAGS);
+
+			__vfs_removexattr(file->f_path.dentry, XATTR_NAME_IMA);
+
+			violation = false;
+			cause = "demote_successful";
+		}
+	}
 out_violation:
 	*pathname = ima_d_path(&file->f_path, pathbuf, namebuf);
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
 			    ima_integrity_models_str[ima_integrity_model],
 			    cause, 0, 0);
-	return true;
+	return violation;
 }
 
 /*
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

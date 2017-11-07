From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:09 +0100
Subject: [PATCH v2 14/15] ima: add support for appraisal with digest lists
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-15-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Appraisal verification consists on comparing the calculated digest of an
accessed file with the value of the security.ima extended attribute. With
digest lists, appraisal verification succeeds if the calculated digest is
included in a list. Since the digital signature of each digest list is
verified, it is not possible to allow access of unauthorized files.

For mutable files, IMA writes the current digest to security.ima so that
next file accesses are allowed even if the files have been modified. For
immutable files, IMA writes security.ima only if also additional extended
attributes should be protected by EVM. Otherwise, security.ima would be
redundant, as digest lists provide reference values.

When IMA writes security.ima, EVM calculates the HMAC based on the current
value of protected extended attributes. Without file signatures, initial
extended attribute values will not checked until digest lists include them.
When extended attribute values are available, IMA will check them as the
same as the digest, and will not write security.ima for immutable files if
values are provided for all extended attributes protected by EVM.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  6 +++--
 security/integrity/ima/ima_appraise.c | 47 +++++++++++++++++++++++++++++++----
 security/integrity/ima/ima_main.c     |  6 +++--
 security/integrity/integrity.h        |  2 ++
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ddd0e1e7e99b..5f8e0740a33e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -261,7 +261,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, int opened);
+			     int xattr_len, int opened,
+			     struct ima_digest *found_digest);
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -277,7 +278,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   struct file *file,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
-					   int xattr_len, int opened)
+					   int xattr_len, int opened,
+					   struct ima_digest *found_digest)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 1b2236e637ff..fd03a0278fba 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -201,17 +201,27 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, int opened)
+			     int xattr_len, int opened,
+			     struct ima_digest *found_digest)
 {
 	static const char op[] = "appraise_data";
 	char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
-	int rc = xattr_len, hash_start = 0;
+	struct evm_ima_xattr_data digest_list_value;
+	char *list_metadata = XATTR_NAME_IMA;
+	int rc = xattr_len, hash_start = 0, cache_flags_disabled = 0;
 
 	if (!(inode->i_opflags & IOP_XATTR))
-		return INTEGRITY_UNKNOWN;
+		return found_digest ? INTEGRITY_PASS : INTEGRITY_UNKNOWN;
+
+	if (found_digest && (!rc || rc == -ENODATA)) {
+		digest_list_value.type = found_digest->is_mutable ?
+			IMA_DIGEST_LIST_MUTABLE : IMA_DIGEST_LIST_IMMUTABLE;
+		xattr_value = &digest_list_value;
+		rc = sizeof(*xattr_value);
+	}
 
 	if (rc <= 0) {
 		if (rc && rc != -ENODATA)
@@ -228,6 +238,9 @@ int ima_appraise_measurement(enum ima_hooks func,
 		goto out;
 	}
 
+	if (xattr_value == &digest_list_value)
+		goto no_evm_check;
+
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
 	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
 		if ((status == INTEGRITY_NOLABEL)
@@ -237,13 +250,17 @@ int ima_appraise_measurement(enum ima_hooks func,
 			cause = "invalid-HMAC";
 		goto out;
 	}
+
+no_evm_check:
 	switch (xattr_value->type) {
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		hash_start = 1;
 		/* fall through */
 	case IMA_XATTR_DIGEST:
-		if (iint->flags & IMA_DIGSIG_REQUIRED) {
+		if (found_digest && !found_digest->is_mutable)
+			iint->flags |= IMA_DIGSIG;
+		else if (iint->flags & IMA_DIGSIG_REQUIRED) {
 			cause = "IMA-signature-required";
 			status = INTEGRITY_FAIL;
 			break;
@@ -280,6 +297,25 @@ int ima_appraise_measurement(enum ima_hooks func,
 			status = INTEGRITY_PASS;
 		}
 		break;
+	case IMA_DIGEST_LIST_MUTABLE:
+		if (iint->flags & IMA_DIGSIG_REQUIRED) {
+			cause = "IMA-signature-required";
+			status = INTEGRITY_FAIL;
+			break;
+		}
+		if (ima_fix_xattr(dentry, iint) == -EROFS)
+			cache_flags_disabled = 1;
+
+		status = INTEGRITY_PASS;
+		break;
+	case IMA_DIGEST_LIST_IMMUTABLE:
+		iint->flags |= IMA_DIGSIG;
+		if (!evm_set_includes_protected_xattrs(&list_metadata, 1))
+			if (ima_fix_xattr(dentry, iint) == -EROFS)
+				cache_flags_disabled = 1;
+
+		status = INTEGRITY_PASS;
+		break;
 	default:
 		status = INTEGRITY_UNKNOWN;
 		cause = "unknown-ima-data";
@@ -302,7 +338,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else {
-		ima_cache_flags(iint, func);
+		if (!cache_flags_disabled)
+			ima_cache_flags(iint, func);
 	}
 	ima_set_cache_status(iint, func, status);
 	return status;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d58199c8435c..a6cd414b46e3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -270,7 +270,8 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 			action &= ~action_done;
 			iint->flags |= (action_done << 1);
 
-			if (!(digest_lookup & IMA_APPRAISE))
+			if (!(digest_lookup & IMA_APPRAISE) ||
+			    opened & FILE_CREATED)
 				found_digest = NULL;
 			if (digest_lookup & IMA_MEASURE)
 				iint->measured_pcrs |= (0x1 << pcr);
@@ -282,7 +283,8 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK))
 		rc = ima_appraise_measurement(func, iint, file, pathname,
-					      xattr_value, xattr_len, opened);
+					      xattr_value, xattr_len, opened,
+					      found_digest);
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index b46461a5f43f..f6b3c15dc57f 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -59,6 +59,8 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_HMAC,
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
+	IMA_DIGEST_LIST_MUTABLE,
+	IMA_DIGEST_LIST_IMMUTABLE,
 	IMA_XATTR_LAST
 };
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

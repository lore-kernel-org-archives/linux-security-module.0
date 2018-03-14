From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 14 Mar 2018 17:20:19 -0300
Subject: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

Replace nested ifs in the EVM xattr verification logic with a switch
statement, making the code easier to understand.

Also, add comments to the if statements in the out section and constify the
cause variable.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 0c5f94b7b9c3..dd10ecbdce45 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -215,7 +215,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     int xattr_len, int opened)
 {
 	static const char op[] = "appraise_data";
-	char *cause = "unknown";
+	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
@@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) &&
-	    (status != INTEGRITY_PASS_IMMUTABLE) &&
-	    (status != INTEGRITY_UNKNOWN)) {
-		if ((status == INTEGRITY_NOLABEL)
-		    || (status == INTEGRITY_NOXATTRS))
-			cause = "missing-HMAC";
-		else if (status == INTEGRITY_FAIL)
-			cause = "invalid-HMAC";
+	switch (status) {
+	case INTEGRITY_PASS:
+	case INTEGRITY_PASS_IMMUTABLE:
+	case INTEGRITY_UNKNOWN:
+		break;
+	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
+	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
+		cause = "missing-HMAC";
+		goto out;
+	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
+		cause = "invalid-HMAC";
 		goto out;
 	}
+
 	switch (xattr_value->type) {
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
@@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
+		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
-		} else if ((inode->i_size == 0) &&
-			   (iint->flags & IMA_NEW_FILE) &&
-			   (xattr_value &&
-			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
+		}
+
+		/* Permit new files with file signatures, but without data. */
+		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
+		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
 			status = INTEGRITY_PASS;
 		}
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else {

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

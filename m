From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 17 Oct 2017 22:53:14 -0200
Subject: [PATCH v5 01/18] ima: Remove redundant conditional operator
In-Reply-To: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
References: <20171018005331.2688-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20171018005331.2688-2-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

A non-zero value is converted to 1 when assigned to a bool variable, so the
conditional operator in is_ima_appraise_enabled is redundant.

The value of a comparison operator is either 1 or 0 so the conditional
operator in ima_inode_setxattr is redundant as well.

Confirmed that the patch is correct by comparing the object file from
before and after the patch. They are identical.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 809ba70fbbbf..ec7dfa02c051 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -40,7 +40,7 @@ __setup("ima_appraise=", default_appraise_setup);
  */
 bool is_ima_appraise_enabled(void)
 {
-	return (ima_appraise & IMA_APPRAISE_ENFORCE) ? 1 : 0;
+	return ima_appraise & IMA_APPRAISE_ENFORCE;
 }
 
 /*
@@ -405,7 +405,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
 			return -EINVAL;
 		ima_reset_appraise_flags(d_backing_inode(dentry),
-			 (xvalue->type == EVM_IMA_XATTR_DIGSIG) ? 1 : 0);
+			xvalue->type == EVM_IMA_XATTR_DIGSIG);
 		result = 0;
 	}
 	return result;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

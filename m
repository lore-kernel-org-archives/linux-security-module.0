From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 14 Mar 2018 17:20:20 -0300
Subject: [PATCH 4/4] integrity: Introduce struct evm_xattr
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20180314202020.3794-5-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Even though struct evm_ima_xattr_data includes a fixed-size array to hold a
SHA1 digest, most of the code ignores the array and uses the struct to mean
"type indicator followed by data of unspecified size" and tracks the real
size of what the struct represents in a separate length variable.

The only exception to that is the EVM code, which correctly uses the
definition of struct evm_ima_xattr_data.

This patch makes this explicit in the code by removing the length
specification from the array in struct evm_ima_xattr_data. It also changes
the name of the element from digest to data, since in most places the array
doesn't hold a digest.

A separate struct evm_xattr is introduced, with the original definition of
evm_ima_xattr_data to be used in the places that actually expect that
definition.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/evm/evm_crypto.c   |  4 ++--
 security/integrity/evm/evm_main.c     | 10 +++++-----
 security/integrity/ima/ima_appraise.c |  7 ++++---
 security/integrity/integrity.h        |  5 +++++
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..86511cf171c1 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -302,7 +302,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct evm_ima_xattr_data xattr_data;
+	struct evm_xattr xattr_data;
 	int rc = 0;
 
 	/*
@@ -318,7 +318,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
 			   xattr_value_len, xattr_data.digest);
 	if (rc == 0) {
-		xattr_data.type = EVM_XATTR_HMAC;
+		xattr_data.data.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
 					   &xattr_data,
 					   sizeof(xattr_data), 0);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7a968faca739..cd17744d4749 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -122,7 +122,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     struct integrity_iint_cache *iint)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
-	struct evm_ima_xattr_data calc;
+	struct evm_xattr calc;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	int rc, xattr_len;
 
@@ -154,7 +154,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* check value type */
 	switch (xattr_data->type) {
 	case EVM_XATTR_HMAC:
-		if (xattr_len != sizeof(struct evm_ima_xattr_data)) {
+		if (xattr_len != sizeof(struct evm_xattr)) {
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
@@ -162,7 +162,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 				   xattr_value_len, calc.digest);
 		if (rc)
 			break;
-		rc = crypto_memneq(xattr_data->digest, calc.digest,
+		rc = crypto_memneq(xattr_data->data, calc.digest,
 			    sizeof(calc.digest));
 		if (rc)
 			rc = -EINVAL;
@@ -501,7 +501,7 @@ int evm_inode_init_security(struct inode *inode,
 				 const struct xattr *lsm_xattr,
 				 struct xattr *evm_xattr)
 {
-	struct evm_ima_xattr_data *xattr_data;
+	struct evm_xattr *xattr_data;
 	int rc;
 
 	if (!evm_key_loaded() || !evm_protected_xattr(lsm_xattr->name))
@@ -511,7 +511,7 @@ int evm_inode_init_security(struct inode *inode,
 	if (!xattr_data)
 		return -ENOMEM;
 
-	xattr_data->type = EVM_XATTR_HMAC;
+	xattr_data->data.type = EVM_XATTR_HMAC;
 	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
 	if (rc < 0)
 		goto out;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index dd10ecbdce45..96e0f95c294b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -167,7 +167,8 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		return sig->hash_algo;
 		break;
 	case IMA_XATTR_DIGEST_NG:
-		ret = xattr_value->digest[0];
+		/* first byte contains algorithm id */
+		ret = xattr_value->data[0];
 		if (ret < HASH_ALGO__LAST)
 			return ret;
 		break;
@@ -175,7 +176,7 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 		/* this is for backward compatibility */
 		if (xattr_len == 21) {
 			unsigned int zero = 0;
-			if (!memcmp(&xattr_value->digest[16], &zero, 4))
+			if (!memcmp(&xattr_value->data[16], &zero, 4))
 				return HASH_ALGO_MD5;
 			else
 				return HASH_ALGO_SHA1;
@@ -272,7 +273,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			/* xattr length may be longer. md5 hash in previous
 			   version occupied 20 bytes in xattr, instead of 16
 			 */
-			rc = memcmp(&xattr_value->digest[hash_start],
+			rc = memcmp(&xattr_value->data[hash_start],
 				    iint->ima_hash->digest,
 				    iint->ima_hash->length);
 		else
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5e58e02ba8dc..79799a0d9195 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -78,6 +78,11 @@ enum evm_ima_xattr_type {
 
 struct evm_ima_xattr_data {
 	u8 type;
+	u8 data[];
+} __packed;
+
+struct evm_xattr {
+	struct evm_ima_xattr_data data;
 	u8 digest[SHA1_DIGEST_SIZE];
 } __packed;
 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

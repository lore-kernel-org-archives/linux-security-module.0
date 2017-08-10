From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 10 Aug 2017 19:41:44 -0400
Subject: [PATCH v5 1/4] ima: always measure and audit files in policy
In-Reply-To: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1502408507-4257-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

All files matching a "measure" rule must be included in the IMA
measurement list, even when the file hash cannot be calculated.
Similarly, all files matching an "audit" rule must be audited, even
when the file hash can not be calculated.

The file data hash field contained in the IMA measurement list template
data will contain 0's instead of the actual file hash digest.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

---
Changelog v5:
- Fail files opened O_DIRECT, but include attempt in measurement list.

Changelog v4:
- Based on both -EBADF and -EINVAL
- clean up ima_collect_measurement()

 security/integrity/ima/ima_api.c    | 60 +++++++++++++++++++++----------------
 security/integrity/ima/ima_crypto.c | 10 +++++++
 security/integrity/ima/ima_main.c   |  7 ++---
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c2edba8de35e..f110a60e5db6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -199,42 +199,52 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	struct inode *inode = file_inode(file);
 	const char *filename = file->f_path.dentry->d_name.name;
 	int result = 0;
+	int length;
+	void *tmpbuf;
+	u64 i_version;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash;
 
-	if (!(iint->flags & IMA_COLLECTED)) {
-		u64 i_version = file_inode(file)->i_version;
+	if (iint->flags & IMA_COLLECTED)
+		goto out;
 
-		if (file->f_flags & O_DIRECT) {
-			audit_cause = "failed(directio)";
-			result = -EACCES;
-			goto out;
-		}
+	i_version = file_inode(file)->i_version;
+	hash.hdr.algo = algo;
 
-		hash.hdr.algo = algo;
-
-		result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
-			ima_calc_buffer_hash(buf, size, &hash.hdr);
-		if (!result) {
-			int length = sizeof(hash.hdr) + hash.hdr.length;
-			void *tmpbuf = krealloc(iint->ima_hash, length,
-						GFP_NOFS);
-			if (tmpbuf) {
-				iint->ima_hash = tmpbuf;
-				memcpy(iint->ima_hash, &hash, length);
-				iint->version = i_version;
-				iint->flags |= IMA_COLLECTED;
-			} else
-				result = -ENOMEM;
-		}
+	/* Initialize hash digest to 0's in case of failure */
+	memset(&hash.digest, 0, sizeof(hash.digest));
+
+	result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
+		ima_calc_buffer_hash(buf, size, &hash.hdr);
+
+	if (result && result != -EBADF && result != -EINVAL)
+		goto out;
+
+	length = sizeof(hash.hdr) + hash.hdr.length;
+	tmpbuf = krealloc(iint->ima_hash, length, GFP_NOFS);
+	if (!tmpbuf) {
+		result = -ENOMEM;
+		goto out;
 	}
+
+	iint->ima_hash = tmpbuf;
+	memcpy(iint->ima_hash, &hash, length);
+	iint->version = i_version;
+
+	/* Possibly temporary failure due to type of read (eg. DAX, O_DIRECT) */
+	if (result != -EBADF && result != -EINVAL)
+		iint->flags |= IMA_COLLECTED;
 out:
-	if (result)
+	if (result) {
+		if (file->f_flags & O_DIRECT)
+			audit_cause = "failed(directio)";
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
 				    filename, "collect_data", audit_cause,
 				    result, 0);
+	}
 	return result;
 }
 
@@ -278,7 +288,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	}
 
 	result = ima_store_template(entry, violation, inode, filename, pcr);
-	if (!result || result == -EEXIST) {
+	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
 	}
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 802d5d20f36f..afdc8da1269c 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -441,6 +441,16 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 	loff_t i_size;
 	int rc;
 
+	/*
+	 * O_DIRECT not supported for buffered read. For consistency,
+	 * don't support O_DIRECT on DAX either.
+	 */
+	if (file->f_flags & O_DIRECT) {
+		hash->length = hash_digest_size[ima_hash_algo];
+		hash->algo = ima_hash_algo;
+		return -EINVAL;
+	}
+
 	i_size = i_size_read(file_inode(file));
 
 	if (ima_ahash_minsize && i_size >= ima_ahash_minsize) {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..eccac00c7e94 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,11 +235,8 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
 	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
-	if (rc != 0) {
-		if (file->f_flags & O_DIRECT)
-			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
+	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_digsig;
-	}
 
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
@@ -247,7 +244,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
-	if (action & IMA_APPRAISE_SUBMASK)
+	if ((rc == 0) && (action & IMA_APPRAISE_SUBMASK))
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
 	if (action & IMA_AUDIT)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

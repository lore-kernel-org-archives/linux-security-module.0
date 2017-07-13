From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 13 Jul 2017 09:54:47 -0400
Subject: [PATCH v3 1/4] ima: always measure and audit files in policy
In-Reply-To: <1499954090-30054-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1499954090-30054-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1499954090-30054-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

All files matching a "measure" rule must be included in the IMA
measurement list, even when the file hash cannot be calculated.
Similarly, all files matching an "audit" rule must be audited, even when
the file hash can not be calculated.

The file data hash field contained in the IMA measurement list template
data will contain 0's instead of the actual file hash digest.

Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_api.c  | 7 +++++--
 security/integrity/ima/ima_main.c | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c2edba8de35e..174cf2e8dd45 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -217,15 +217,18 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 
 		result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
 			ima_calc_buffer_hash(buf, size, &hash.hdr);
-		if (!result) {
+		if (!result || (result == -EBADF)) {
 			int length = sizeof(hash.hdr) + hash.hdr.length;
 			void *tmpbuf = krealloc(iint->ima_hash, length,
 						GFP_NOFS);
 			if (tmpbuf) {
 				iint->ima_hash = tmpbuf;
+				if (result == -EBADF)
+					memset(&hash.digest, 0, hash.hdr.length);
 				memcpy(iint->ima_hash, &hash, length);
 				iint->version = i_version;
-				iint->flags |= IMA_COLLECTED;
+				if (result != -EBADF)
+					iint->flags |= IMA_COLLECTED;
 			} else
 				result = -ENOMEM;
 		}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..63777d1210b1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,7 +235,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
 	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
-	if (rc != 0) {
+	if (rc != 0 && rc != -EBADF) {
 		if (file->f_flags & O_DIRECT)
 			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
 		goto out_digsig;
@@ -247,7 +247,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
-	if (action & IMA_APPRAISE_SUBMASK)
+	if ((rc != -EBADF) && (action & IMA_APPRAISE_SUBMASK))
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
 	if (action & IMA_AUDIT)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

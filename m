From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Thu,  6 Jul 2017 19:17:52 -0300
Subject: [PATCH v3 6/7] ima: Store measurement after appraisal
In-Reply-To: <20170706221753.17380-1-bauerman@linux.vnet.ibm.com>
References: <20170706221753.17380-1-bauerman@linux.vnet.ibm.com>
Message-ID: <20170706221753.17380-7-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When module-style signatures appended at the end of files are supported for
IMA appraisal, the code will fallback to the xattr signature if the
appended one fails to verify.

The problem is that we don't know whether we need to fallback to the xattr
signature until the appraise step, and by then the measure step was already
completed and would need to be done again in case the template includes the
signature.

To avoid this problem, do the appraisal first so that the correct signature
is stored by the template in the measure step.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..0b4845e7248d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -244,12 +244,12 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, pcr);
 	if (action & IMA_APPRAISE_SUBMASK)
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
+	if (action & IMA_MEASURE)
+		ima_store_measurement(iint, file, pathname,
+				      xattr_value, xattr_len, pcr);
 	if (action & IMA_AUDIT)
 		ima_audit_measurement(iint, pathname);
 
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

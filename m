From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:10 +0100
Subject: [RFC][PATCH v2 9/9] ima: don't measure files with valid appraisal
	status
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-10-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If an integrity model is selected, access to mutable files is restricted to
TCB processes or mutable files are demoted. Then, files with a valid
appraisal status can be excluded from measurement because they won't
compromise the TCB. Remote verifiers would only require that the file
didn't contain malformed data at first access (which can be guaranteed for
example with a digital signature).

Changelog

v1
- don't clear IMA_MEASURE for files with digital signature
- clear IMA_MEASURE for any integrity model
- don't measure mutable files also if ima_appraise == IMA_APPRAISE_LOG

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 0f746b8bd965..6f1e23682c90 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -221,6 +221,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		/* access will be denied */
 		if (model_violation)
 			action &= ~IMA_APPRAISE;
+
+		/* do not measure mutable files, if they are appraised */
+		if (ima_appraise & (IMA_APPRAISE_ENFORCE | IMA_APPRAISE_LOG) &&
+		    iint && (iint->flags & IMA_APPRAISED) &&
+		    !(iint->flags & IMA_DIGSIG))
+			action &= ~IMA_MEASURE;
 	}
 
 	if (violation_check)
@@ -265,9 +271,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK))
+	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
+		/* do not measure mutable files, if rc == INTEGRITY_PASS */
+		if (!rc && ima_integrity_model &&
+		    ima_appraise & (IMA_APPRAISE_ENFORCE | IMA_APPRAISE_LOG) &&
+		    !(iint->flags & IMA_DIGSIG)) {
+			iint->flags &= ~IMA_MEASURE;
+			action &= ~IMA_MEASURE;
+		}
+	}
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

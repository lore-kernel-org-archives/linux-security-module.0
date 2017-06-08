From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed,  7 Jun 2017 22:49:12 -0300
Subject: [PATCH v2 3/6] ima: Log the same audit cause whenever a file has no
	signature
In-Reply-To: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If the file doesn't have an xattr, ima_appraise_measurement sets cause to
"missing-hash" while if there's an xattr but it's a digest instead of a
signature it sets cause to "IMA-signature-required".

Fix it by setting cause to "IMA-signature-required" in both cases.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ea36a4f134f4..809ba70fbbbf 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -217,7 +217,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 		if (rc && rc != -ENODATA)
 			goto out;
 
-		cause = "missing-hash";
+		cause = iint->flags & IMA_DIGSIG_REQUIRED ?
+				"IMA-signature-required" : "missing-hash";
 		status = INTEGRITY_NOLABEL;
 		if (opened & FILE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

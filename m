From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 18 Apr 2017 17:17:44 -0300
Subject: [PATCH 4/6] ima: Log the same audit cause whenever a file has no
	signature
In-Reply-To: <1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <1492546666-16615-5-git-send-email-bauerman@linux.vnet.ibm.com>
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
index 427a896bc806..8c8030a29117 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -205,7 +205,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 		if (rc && rc != -ENODATA)
 			goto out;
 
-		cause = "missing-hash";
+		cause = iint->flags & IMA_DIGSIG_REQUIRED ?
+				"IMA-signature-required" : "missing-hash";
 		status = INTEGRITY_NOLABEL;
 		if (opened & FILE_CREATED) {
 			iint->flags |= IMA_NEW_FILE;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

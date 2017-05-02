From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue,  2 May 2017 14:47:11 -0400
Subject: [PATCH 3/4] ima: define Kconfig IMA_APPRAISE_BOOTPARAM option
In-Reply-To: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1493750832-11981-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1493750832-11981-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Permit enabling the different "ima_appraise=" modes (eg. log, fix)
from the boot command line.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig        | 8 ++++++++
 security/integrity/ima/ima_appraise.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 370eb2f4dd37..8b688a26033d 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -155,6 +155,14 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_APPRAISE_BOOTPARAM
+	bool "ima_appraise boot parameter"
+	depends on IMA_APPRAISE
+	default y
+	help
+	  This option enables the different "ima_appraise=" modes
+	  (eg. fix, log) from the boot command line.
+
 config IMA_TRUSTED_KEYRING
 	bool "Require all keys on the .ima keyring be signed (deprecated)"
 	depends on IMA_APPRAISE && SYSTEM_TRUSTED_KEYRING
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5d0785cfe063..ac546df73afc 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -20,12 +20,14 @@
 
 static int __init default_appraise_setup(char *str)
 {
+#ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 	if (strncmp(str, "off", 3) == 0)
 		ima_appraise = 0;
 	else if (strncmp(str, "log", 3) == 0)
 		ima_appraise = IMA_APPRAISE_LOG;
 	else if (strncmp(str, "fix", 3) == 0)
 		ima_appraise = IMA_APPRAISE_FIX;
+#endif
 	return 1;
 }
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

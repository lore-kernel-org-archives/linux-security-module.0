From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 18 Apr 2017 17:17:42 -0300
Subject: [PATCH 2/6] ima: Tidy up constant strings
In-Reply-To: <1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <1492546666-16615-3-git-send-email-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Strictly speaking, boot_aggregate_name is a constant string, not a
modifiable pointer to a constant string.

Also, constify mask_tokens and func_tokens arrays.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_init.c   | 2 +-
 security/integrity/ima/ima_policy.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 2967d497a665..24c703366ba8 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -25,7 +25,7 @@
 #include "ima.h"
 
 /* name for boot aggregate entry */
-static const char *boot_aggregate_name = "boot_aggregate";
+static const char boot_aggregate_name[] = "boot_aggregate";
 int ima_used_chip;
 
 /* Add the boot aggregate to the IMA measurement list and extend
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index aed47b777a57..cfda5d7b17ec 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -889,7 +889,7 @@ enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
 
-static char *mask_tokens[] = {
+static const char *const mask_tokens[] = {
 	"MAY_EXEC",
 	"MAY_WRITE",
 	"MAY_READ",
@@ -903,7 +903,7 @@ enum {
 	func_policy
 };
 
-static char *func_tokens[] = {
+static const char *const func_tokens[] = {
 	"FILE_CHECK",
 	"MMAP_CHECK",
 	"BPRM_CHECK",
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

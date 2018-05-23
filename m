From: bauerman@linux.ibm.com (Thiago Jung Bauermann)
Date: Tue, 22 May 2018 21:12:48 -0300
Subject: [PATCH v7 09/14] ima: Export func_tokens
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
Message-ID: <20180523001253.15247-10-bauerman@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

ima_read_modsig() will need it so that it can show an error message.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_policy.c | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 43d4aaf31f7a..567be3c6568c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -195,6 +195,8 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+extern const char *const func_tokens[];
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bbc18eb07eb..d454949493c6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1021,6 +1021,12 @@ void ima_delete_rules(void)
 	}
 }
 
+#define __ima_hook_stringify(str)	(#str),
+
+const char *const func_tokens[] = {
+	__ima_hooks(__ima_hook_stringify)
+};
+
 #ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
@@ -1033,12 +1039,6 @@ static const char *const mask_tokens[] = {
 	"MAY_APPEND"
 };
 
-#define __ima_hook_stringify(str)	(#str),
-
-static const char *const func_tokens[] = {
-	__ima_hooks(__ima_hook_stringify)
-};
-
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

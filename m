From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed,  7 Jun 2017 22:49:11 -0300
Subject: [PATCH v2 2/6] ima: Simplify policy_func_show.
In-Reply-To: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <1496886555-10082-3-git-send-email-bauerman@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If the func_tokens array uses the same indices as enum ima_hooks,
policy_func_show can be a lot simpler, and the func_* enum becomes
unnecessary.

Also, if we use the same macro trick used by kernel_read_file_id_str we can
use one hooks list for both the enum and the string array, making sure they
are always in sync (suggested by Mimi Zohar).

Finally, by using the printf pattern for the function token directly
instead of using the pt macro we can simplify policy_func_show even further
and avoid needing a temporary buffer.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        | 25 +++++++++-------
 security/integrity/ima/ima_policy.c | 58 ++++---------------------------------
 2 files changed, 21 insertions(+), 62 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 215a93c41b51..d52b487ad259 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -172,17 +172,22 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	return hash_long(*digest, IMA_HASH_BITS);
 }
 
+#define __ima_hooks(hook)		\
+	hook(NONE)			\
+	hook(FILE_CHECK)		\
+	hook(MMAP_CHECK)		\
+	hook(BPRM_CHECK)		\
+	hook(POST_SETATTR)		\
+	hook(MODULE_CHECK)		\
+	hook(FIRMWARE_CHECK)		\
+	hook(KEXEC_KERNEL_CHECK)	\
+	hook(KEXEC_INITRAMFS_CHECK)	\
+	hook(POLICY_CHECK)		\
+	hook(MAX_CHECK)
+#define __ima_hook_enumify(ENUM)	ENUM,
+
 enum ima_hooks {
-	FILE_CHECK = 1,
-	MMAP_CHECK,
-	BPRM_CHECK,
-	POST_SETATTR,
-	MODULE_CHECK,
-	FIRMWARE_CHECK,
-	KEXEC_KERNEL_CHECK,
-	KEXEC_INITRAMFS_CHECK,
-	POLICY_CHECK,
-	MAX_CHECK
+	__ima_hooks(__ima_hook_enumify)
 };
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 949ad3858327..f4436626ccb7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -972,23 +972,10 @@ static const char *const mask_tokens[] = {
 	"MAY_APPEND"
 };
 
-enum {
-	func_file = 0, func_mmap, func_bprm,
-	func_module, func_firmware, func_post,
-	func_kexec_kernel, func_kexec_initramfs,
-	func_policy
-};
+#define __ima_hook_stringify(str)	(#str),
 
 static const char *const func_tokens[] = {
-	"FILE_CHECK",
-	"MMAP_CHECK",
-	"BPRM_CHECK",
-	"MODULE_CHECK",
-	"FIRMWARE_CHECK",
-	"POST_SETATTR",
-	"KEXEC_KERNEL_CHECK",
-	"KEXEC_INITRAMFS_CHECK",
-	"POLICY_CHECK"
+	__ima_hooks(__ima_hook_stringify)
 };
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
@@ -1025,49 +1012,16 @@ void ima_policy_stop(struct seq_file *m, void *v)
 
 #define pt(token)	policy_tokens[token + Opt_err].pattern
 #define mt(token)	mask_tokens[token]
-#define ft(token)	func_tokens[token]
 
 /*
  * policy_func_show - display the ima_hooks policy rule
  */
 static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 {
-	char tbuf[64] = {0,};
-
-	switch (func) {
-	case FILE_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_file));
-		break;
-	case MMAP_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_mmap));
-		break;
-	case BPRM_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_bprm));
-		break;
-	case MODULE_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_module));
-		break;
-	case FIRMWARE_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_firmware));
-		break;
-	case POST_SETATTR:
-		seq_printf(m, pt(Opt_func), ft(func_post));
-		break;
-	case KEXEC_KERNEL_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_kexec_kernel));
-		break;
-	case KEXEC_INITRAMFS_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_kexec_initramfs));
-		break;
-	case POLICY_CHECK:
-		seq_printf(m, pt(Opt_func), ft(func_policy));
-		break;
-	default:
-		snprintf(tbuf, sizeof(tbuf), "%d", func);
-		seq_printf(m, pt(Opt_func), tbuf);
-		break;
-	}
-	seq_puts(m, " ");
+	if (func > 0 && func < MAX_CHECK)
+		seq_printf(m, "func=%s ", func_tokens[func]);
+	else
+		seq_printf(m, "func=%d ", func);
 }
 
 int ima_policy_show(struct seq_file *m, void *v)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 24 May 2018 07:09:32 -0400
Subject: [PATCH v3 3/7] ima: based on policy require signed kexec kernel images
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527160176-29269-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The original kexec_load syscall can not verify file signatures.  This
patch differentiates between the kexec_load and kexec_file_load
syscalls.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>

Changelog v3:
- use switch/case
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 22 +++++++++++++++++-----
 security/integrity/ima/ima_policy.c |  2 ++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..78c15264b17b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -232,6 +232,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
+#define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index eeb7075868db..fbbcc02a1380 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -432,15 +432,27 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_data(struct file *file, enum kernel_read_file_id read_id)
 {
-	bool sig_enforce = is_module_sig_enforced();
+	bool sig_enforce;
 
-	if (!file && read_id == READING_MODULE) {
-		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
+		return 0;
+
+	switch (read_id) {
+	case READING_MODULE:
+		sig_enforce = is_module_sig_enforced(); /* appended sig */
+		if (!file && !sig_enforce &&
+		    (ima_appraise & IMA_APPRAISE_MODULES)) {
 			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
-		return 0;	/* We rely on module signature checking */
+		break;
+	case READING_KEXEC_IMAGE:
+		if (!file && (ima_appraise & IMA_APPRAISE_KEXEC)) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+	default:
+		break;
 	}
 	return 0;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bbc18eb07eb..c27f6993b07a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_FIRMWARE;
 	else if (func == POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
+	else if (func == KEXEC_KERNEL_CHECK)
+		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
 
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

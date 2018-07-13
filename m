From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 13 Jul 2018 14:05:58 -0400
Subject: [PATCH v6 3/8] ima: based on policy require signed kexec kernel images
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The original kexec_load syscall can not verify file signatures, nor can
the kexec image be measured.  Based on policy, deny the kexec_load
syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>

---
Changelog v3:
- use switch/case

 include/linux/ima.h                 |  7 +++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 27 +++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c |  2 ++
 security/security.c                 |  7 ++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..84806b54b50a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 struct linux_binprm;
 
@@ -19,6 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
@@ -49,6 +51,11 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
+static inline int ima_load_data(enum kernel_load_data_id id)
+{
+	return 0;
+}
+
 static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
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
index dca44cf7838e..71fecfef0939 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -496,6 +496,33 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				   MAY_READ, func, 0);
 }
 
+/**
+ * ima_load_data - appraise decision based on policy
+ * @id: kernel load data caller identifier
+ *
+ * Callers of this LSM hook can not measure, appraise, or audit the
+ * data provided by userspace.  Enforce policy rules requring a file
+ * signature (eg. kexec'ed kernel image).
+ *
+ * For permission return 0, otherwise return -EACCES.
+ */
+int ima_load_data(enum kernel_load_data_id id)
+{
+	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
+		return 0;
+
+	switch (id) {
+	case LOADING_KEXEC_IMAGE:
+		if (ima_appraise & IMA_APPRAISE_KEXEC) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7f4a4de7e831..ebfb389b79df 100644
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
 
diff --git a/security/security.c b/security/security.c
index 05fe5b1932d7..7b870df0a335 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1063,7 +1063,12 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
 int security_kernel_load_data(enum kernel_load_data_id id)
 {
-	return call_int_hook(kernel_load_data, 0, id);
+	int ret;
+
+	ret = call_int_hook(kernel_load_data, 0, id);
+	if (ret)
+		return ret;
+	return ima_load_data(id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

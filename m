From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 24 May 2018 07:09:30 -0400
Subject: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In order for LSMs and IMA-appraisal to differentiate between the original
and new syscalls (eg. kexec, kernel modules, firmware), both the original
and new syscalls must call an LSM hook.

Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
introduced calling security_kernel_module_from_file() in both the original
and new syscalls.  Commit a1db74209483 ("module: replace
copy_module_from_fd with kernel version") replaced these LSM calls with
security_kernel_read_file().

Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
with kernel version") and commit b804defe4297  ("kexec: replace call to
copy_file_from_fd() with kernel version") replaced their own version of
reading a file from the kernel with the generic
kernel_read_file_from_path/fd() versions, which call the pre and post
security_kernel_read_file LSM hooks.

Missing are LSM calls in the original kexec syscall and firmware sysfs
fallback method.  Instead of defining a new LSM hook or wrapper for
security_kernel_read_file(), this patch renames the original
security_kernel_read_file() hook to security_kernel_read_data(), and
updates LSM usage of the hook (eg. loadpin, init_module, IMA).

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>

Changelog v3:
- Rename security_kernel_read_file to security_kernel_read_data().

Changelog v2:
- Define a generic wrapper named security_kernel_read_blob() for
security_kernel_read_file().

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().
---
 fs/exec.c                         | 2 +-
 include/linux/ima.h               | 4 ++--
 include/linux/security.h          | 4 ++--
 kernel/module.c                   | 2 +-
 security/integrity/ima/ima_main.c | 4 ++--
 security/loadpin/loadpin.c        | 2 +-
 security/security.c               | 6 +++---
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..0c832b4c6a22 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -904,7 +904,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id);
+	ret = security_kernel_read_data(file, id);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..423aaf88f8c6 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -19,7 +19,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
+extern int ima_read_data(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
@@ -49,7 +49,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+static inline int ima_read_data(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..836a9081b2f3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -320,7 +320,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
+int security_kernel_read_data(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -909,7 +909,7 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
-static inline int security_kernel_read_file(struct file *file,
+static inline int security_kernel_read_data(struct file *file,
 					    enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index ce8066b88178..cb84a0b7fbe9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_read_file(NULL, READING_MODULE);
+	err = security_kernel_read_data(NULL, READING_MODULE);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 83f84928ad76..eeb7075868db 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -420,7 +420,7 @@ void ima_post_path_mknod(struct dentry *dentry)
 }
 
 /**
- * ima_read_file - pre-measure/appraise hook decision based on policy
+ * ima_read_data - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
  * @read_id: caller identifier
  *
@@ -430,7 +430,7 @@ void ima_post_path_mknod(struct dentry *dentry)
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
+int ima_read_data(struct file *file, enum kernel_read_file_id read_id)
 {
 	bool sig_enforce = is_module_sig_enforced();
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..8d7db638fdeb 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -175,7 +175,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
-	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
+	LSM_HOOK_INIT(kernel_read_data, loadpin_read_file),
 };
 
 void __init loadpin_add_hooks(void)
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..fc7a2bcf3177 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1033,16 +1033,16 @@ int security_kernel_module_request(char *kmod_name)
 	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+int security_kernel_read_data(struct file *file, enum kernel_read_file_id id)
 {
 	int ret;
 
 	ret = call_int_hook(kernel_read_file, 0, file, id);
 	if (ret)
 		return ret;
-	return ima_read_file(file, id);
+	return ima_read_data(file, id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_read_file);
+EXPORT_SYMBOL_GPL(security_kernel_read_data);
 
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 17 May 2018 10:48:44 -0400
Subject: [PATCH v2 3/9] security: define security_kernel_read_blob() wrapper
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
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
fallback method.  From a technical perspective there is no justification
for defining a new LSM hook, as the existing security_kernel_read_file()
works just fine.  The original syscalls, however, do not read a file, so
the security hook name is inappropriate.  Instead of defining a new LSM
hook, this patch defines security_kernel_read_blob() as a wrapper for
the existing LSM security_kernel_file_read() hook.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>

Changelog v2:
- Define a generic wrapper named security_kernel_read_blob() for
security_kernel_read_file().

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().
---
 include/linux/security.h | 6 ++++++
 security/security.c      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..4db1967a688b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -323,6 +323,7 @@ int security_kernel_module_request(char *kmod_name);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
+int security_kernel_read_blob(enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -922,6 +923,11 @@ static inline int security_kernel_post_read_file(struct file *file,
 	return 0;
 }
 
+static inline int security_kernel_read_blob(enum kernel_read_file_id id)
+{
+	return 0;
+}
+
 static inline int security_task_fix_setuid(struct cred *new,
 					   const struct cred *old,
 					   int flags)
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..8f199b2bf4a2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1044,6 +1044,12 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
+int security_kernel_read_blob(enum kernel_read_file_id id)
+{
+	return security_kernel_read_file(NULL, id);
+}
+EXPORT_SYMBOL_GPL(security_kernel_read_blob);
+
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

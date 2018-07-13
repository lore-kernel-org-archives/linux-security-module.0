From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 13 Jul 2018 14:06:02 -0400
Subject: [PATCH v6 7/8] module: replace the existing LSM hook in init_module
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Both the init_module and finit_module syscalls call either directly
or indirectly the security_kernel_read_file LSM hook.  This patch
replaces the direct call in init_module with a call to the new
security_kernel_load_data hook and makes the corresponding changes
in SELinux, LoadPin, and IMA.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>

---
Changelog v6:
- LoadPin: add missing cast from enum kernel_load_file_id to
kernel_read_file_id.

Changelog v5:
- For SELinux, have both the security_kernel_read_file and
security_kernel_load_data LSM hooks call selinux_kernel_read_file().
- LoadPin: replace existing init_module LSM hook support with
new security_kernel_load_data hook.

 kernel/module.c                   |  2 +-
 security/integrity/ima/ima_main.c | 23 ++++++++++-------------
 security/loadpin/loadpin.c        |  6 ++++++
 security/selinux/hooks.c          | 15 +++++++++++++++
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index f475f30eed8c..a7615d661910 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2876,7 +2876,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_read_file(NULL, READING_MODULE);
+	err = security_kernel_load_data(LOADING_MODULE);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e467664965e7..ef349a761609 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -429,16 +429,6 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
-	bool sig_enforce = is_module_sig_enforced();
-
-	if (!file && read_id == READING_MODULE) {
-		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		}
-		return 0;	/* We rely on module signature checking */
-	}
 	return 0;
 }
 
@@ -479,9 +469,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
-		return 0;
-
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -510,6 +497,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id)
 {
+	bool sig_enforce;
+
 	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
 		return 0;
 
@@ -525,6 +514,14 @@ int ima_load_data(enum kernel_load_data_id id)
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case LOADING_MODULE:
+		sig_enforce = is_module_sig_enforced();
+
+		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
+			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 	default:
 		break;
 	}
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..0716af28808a 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -173,9 +173,15 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
+static int loadpin_load_data(enum kernel_load_data_id id)
+{
+	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
+}
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
+	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
 void __init loadpin_add_hooks(void)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2b5ee5fbd652..a8bf324130f5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4073,6 +4073,20 @@ static int selinux_kernel_read_file(struct file *file,
 	return rc;
 }
 
+static int selinux_kernel_load_data(enum kernel_load_data_id id)
+{
+	int rc = 0;
+
+	switch (id) {
+	case LOADING_MODULE:
+		rc = selinux_kernel_module_from_file(NULL);
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return avc_has_perm(&selinux_state,
@@ -6972,6 +6986,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
 	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

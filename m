From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 21 Sep 2018 17:18:40 -0700
Subject: [PATCH v4 09/19] SELinux: Abstract use of file security blob
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Message-ID: <ee568e97-ae0b-e809-0f4f-2619bf283cce@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b629cc302088..641a8ce726ff 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -396,7 +396,7 @@ static int file_alloc_security(struct file *file)
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	file->f_security = NULL;
 	kmem_cache_free(file_security_cache, fsec);
 }
@@ -1879,7 +1879,7 @@ static int file_has_perm(const struct cred *cred,
 			 struct file *file,
 			 u32 av)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
@@ -2223,7 +2223,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct file *file)
 {
 	u32 sid = task_sid(to);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
@@ -3535,7 +3535,7 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 static int selinux_file_permission(struct file *file, int mask)
 {
 	struct inode *inode = file_inode(file);
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
 
@@ -3570,7 +3570,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = selinux_file(file);
 	struct inode *inode = file_inode(file);
 	struct inode_security_struct *isec;
 	struct lsm_ioctlop_audit ioctl;
@@ -3822,7 +3822,7 @@ static void selinux_file_set_fowner(struct file *file)
 {
 	struct file_security_struct *fsec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	fsec->fown_sid = current_sid();
 }
 
@@ -3837,7 +3837,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	/* struct fown_struct is never outside the context of a struct file */
 	file = container_of(fown, struct file, f_owner);
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -3861,7 +3861,7 @@ static int selinux_file_open(struct file *file)
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	isec = inode_security(file_inode(file));
 	/*
 	 * Save inode label and policy sequence number
@@ -4000,7 +4000,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = file;
 
-	fsec = file->f_security;
+	fsec = selinux_file(file);
 	if (sid != fsec->sid) {
 		rc = avc_has_perm(&selinux_state,
 				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ad511c3d2eb7..cad8b765f6dd 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -165,4 +165,9 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security;
 }
 
+static inline struct file_security_struct *selinux_file(const struct file *file)
+{
+	return file->f_security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.17.1

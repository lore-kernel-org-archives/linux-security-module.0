From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 29 May 2018 14:01:53 -0400
Subject: [PATCH v4 1/8] security: define new LSM hook named
	security_kernel_load_data
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1527616920-5415-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Differentiate between the kernel reading a file from the kernel loading
data provided by userspace.  This patch defines a new LSM hook named
security_kernel_load_data.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>

Changelog v4:
- Define new LSM hook named security_kernel_load_data.

Changelog v3:
- Rename security_kernel_read_file to security_kernel_read_data().

Changelog v2:
- Define a generic wrapper named security_kernel_read_blob() for
security_kernel_read_file().

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().
---
 include/linux/lsm_hooks.h |  6 ++++++
 include/linux/security.h  | 33 +++++++++++++++++++++++++++++++++
 security/security.c       |  5 +++++
 3 files changed, 44 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..a08bc2587b96 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -576,6 +576,10 @@
  *	userspace to load a kernel module with the given name.
  *	@kmod_name name of the module requested by the kernel
  *	Return 0 if successful.
+ * @kernel_load_data:
+ *	Load data provided by userspace.
+ *	@id kernel load data identifier
+ *	Return 0 if permission is granted.
  * @kernel_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
@@ -1582,6 +1586,7 @@ union security_list_options {
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
+	int (*kernel_load_data)(enum kernel_load_data_id id);
 	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
 	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
 				     enum kernel_read_file_id id);
@@ -1872,6 +1877,7 @@ struct security_hook_heads {
 	struct hlist_head cred_getsecid;
 	struct hlist_head kernel_act_as;
 	struct hlist_head kernel_create_files_as;
+	struct hlist_head kernel_load_data;
 	struct hlist_head kernel_read_file;
 	struct hlist_head kernel_post_read_file;
 	struct hlist_head kernel_module_request;
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..3d54d5945755 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -159,6 +159,33 @@ extern int mmap_min_addr_handler(struct ctl_table *table, int write,
 typedef int (*initxattrs) (struct inode *inode,
 			   const struct xattr *xattr_array, void *fs_data);
 
+
+#define __kernel_load_data_id(id) \
+	id(UNKNOWN, unknown)		\
+	id(FIRMWARE, firmware)		\
+	id(MODULE, kernel-module)		\
+	id(KEXEC_IMAGE, kexec-image)		\
+	id(MAX_ID, )
+
+#define __data_id_enumify(ENUM, dummy) LOADING_ ## ENUM,
+#define __data_id_stringify(dummy, str) #str,
+
+enum kernel_load_data_id {
+	__kernel_load_data_id(__data_id_enumify)
+};
+
+static const char * const kernel_load_data_str[] = {
+	__kernel_load_data_id(__data_id_stringify)
+};
+
+static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
+{
+	if ((unsigned)id >= LOADING_MAX_ID)
+		return kernel_load_data_str[LOADING_UNKNOWN];
+
+	return kernel_load_data_str[id];
+}
+
 #ifdef CONFIG_SECURITY
 
 struct security_mnt_opts {
@@ -320,6 +347,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
+int security_kernel_load_data(enum kernel_load_data_id id);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
@@ -909,6 +937,11 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
+static inline int security_kernel_load_data(enum kernel_load_data_id id)
+{
+	return 0;
+}
+
 static inline int security_kernel_read_file(struct file *file,
 					    enum kernel_read_file_id id)
 {
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..c2de2f134854 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1056,6 +1056,11 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
+int security_kernel_load_data(enum kernel_load_data_id id)
+{
+	return call_int_hook(kernel_load_data, 0, id);
+}
+
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:36:58 +0100
Subject: [PATCH v2 03/15] ima: generalize policy file operations
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-4-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch renames ima_open_policy() and ima_release_policy() respectively
to ima_open_data_upload() and ima_release_data_upload(). They will be used
to implement file operations for interfaces allowing to upload and read
provided data.

Also, the new flag IMA_POLICY_BUSY has been defined specifically for the
policy, as it might not be cleared at file release. This would prevent
userspace applications from uploading files after a policy has been loaded.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Changelog

v1:
- clear correct flag in ima_release_data_upload()
---
 security/integrity/ima/ima_fs.c | 48 ++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 864d34581081..a5b82e075ec8 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -384,6 +384,7 @@ static ssize_t ima_write_data(struct file *file, const char __user *buf,
 }
 
 enum ima_fs_flags {
+	IMA_POLICY_BUSY,
 	IMA_FS_BUSY,
 };
 
@@ -399,22 +400,33 @@ static const struct seq_operations ima_policy_seqops = {
 #endif
 
 /*
- * ima_open_policy: sequentialize access to the policy file
+ * ima_open_data_upload: sequentialize access to the data upload interface
  */
-static int ima_open_policy(struct inode *inode, struct file *filp)
+static int ima_open_data_upload(struct inode *inode, struct file *filp)
 {
+	enum kernel_read_file_id file_id = ima_get_file_id(filp->f_path.dentry);
+	const struct seq_operations *seq_ops = NULL;
+	enum ima_fs_flags flag = IMA_FS_BUSY;
+	bool read_allowed = false;
+
+	if (file_id == READING_POLICY) {
+		flag = IMA_POLICY_BUSY;
+#ifdef	CONFIG_IMA_READ_POLICY
+		read_allowed = true;
+		seq_ops = &ima_policy_seqops;
+#endif
+	}
+
 	if (!(filp->f_flags & O_WRONLY)) {
-#ifndef	CONFIG_IMA_READ_POLICY
-		return -EACCES;
-#else
+		if (!read_allowed)
+			return -EACCES;
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		return seq_open(filp, &ima_policy_seqops);
-#endif
+		return seq_open(filp, seq_ops);
 	}
-	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
+	if (test_and_set_bit(flag, &ima_fs_flags))
 		return -EBUSY;
 	return 0;
 }
@@ -426,13 +438,19 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  * point to the new policy rules, and remove the securityfs policy file,
  * assuming a valid policy.
  */
-static int ima_release_policy(struct inode *inode, struct file *file)
+static int ima_release_data_upload(struct inode *inode, struct file *file)
 {
+	enum kernel_read_file_id file_id = ima_get_file_id(file->f_path.dentry);
 	const char *cause = valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
+	if (file_id != READING_POLICY) {
+		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+		return 0;
+	}
+
 	if (valid_policy && ima_check_policy() < 0) {
 		cause = "failed";
 		valid_policy = 0;
@@ -445,7 +463,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	if (!valid_policy) {
 		ima_delete_rules();
 		valid_policy = 1;
-		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+		clear_bit(IMA_POLICY_BUSY, &ima_fs_flags);
 		return 0;
 	}
 
@@ -454,16 +472,16 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
-	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+	clear_bit(IMA_POLICY_BUSY, &ima_fs_flags);
 #endif
 	return 0;
 }
 
-static const struct file_operations ima_measure_policy_ops = {
-	.open = ima_open_policy,
+static const struct file_operations ima_data_upload_ops = {
+	.open = ima_open_data_upload,
 	.write = ima_write_data,
 	.read = seq_read,
-	.release = ima_release_policy,
+	.release = ima_release_data_upload,
 	.llseek = generic_file_llseek,
 };
 
@@ -502,7 +520,7 @@ int __init ima_fs_init(void)
 
 	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
-					    &ima_measure_policy_ops);
+					    &ima_data_upload_ops);
 	if (IS_ERR(ima_policy))
 		goto out;
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

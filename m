From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 16 May 2017 14:53:46 +0200
Subject: [PATCH 6/7] ima: add securityfs interface to restore a measurements
	list
In-Reply-To: <20170516125347.10574-1-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
Message-ID: <20170516125347.10574-7-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Through the new interface restore_kexec_list, it will be possible
to restore a measurements list, previously read from
binary_kexec_runtime_measurements.

The patch reuses the policy functions to create a buffer, read
the measurements and call ima_restore_measurement_list().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index a93f941..6e3f93f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -77,6 +77,7 @@ static const struct file_operations ima_measurements_count_ops = {
 };
 
 static struct dentry *binary_kexec_runtime_measurements;
+static struct dentry *restore_kexec_list;
 
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
@@ -297,7 +298,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_policy(char *path, bool khdr)
 {
 	void *data;
 	char *datap;
@@ -317,6 +318,13 @@ static ssize_t ima_read_policy(char *path)
 	}
 
 	datap = data;
+
+	if (khdr) {
+		rc = ima_restore_measurement_list(size, data);
+		size = 0;
+		goto out;
+	}
+
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
 		rc = ima_parse_add_rule(p);
@@ -325,6 +333,7 @@ static ssize_t ima_read_policy(char *path)
 		size -= rc;
 	}
 
+out:
 	vfree(data);
 	if (rc < 0)
 		return rc;
@@ -337,6 +346,7 @@ static ssize_t ima_read_policy(char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
+	bool khdr = file->f_path.dentry == restore_kexec_list;
 	char *data;
 	ssize_t result;
 
@@ -363,8 +373,13 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	if (result < 0)
 		goto out_free;
 
+	if (khdr && data[0] != '/') {
+		mutex_unlock(&ima_write_mutex);
+		goto out_free;
+	}
+
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_policy(data, khdr);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("IMA: signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
@@ -393,7 +408,7 @@ static struct dentry *violations;
 static struct dentry *ima_policy;
 
 enum ima_fs_flags {
-	IMA_FS_BUSY,
+	IMA_FS_BUSY, IMA_RESTORE_LIST_BUSY,
 };
 
 static unsigned long ima_fs_flags;
@@ -412,6 +427,9 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+	bool khdr = filp->f_path.dentry == restore_kexec_list;
+	unsigned long bit = khdr ? IMA_RESTORE_LIST_BUSY : IMA_FS_BUSY;
+
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
 		return -EACCES;
@@ -423,7 +441,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 		return seq_open(filp, &ima_policy_seqops);
 #endif
 	}
-	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
+	if (test_and_set_bit(bit, &ima_fs_flags))
 		return -EBUSY;
 	return 0;
 }
@@ -439,6 +457,11 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	const char *cause = valid_policy ? "completed" : "failed";
 
+	if (file->f_path.dentry == restore_kexec_list) {
+		clear_bit(IMA_RESTORE_LIST_BUSY, &ima_fs_flags);
+		return 0;
+	}
+
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
@@ -522,9 +545,16 @@ int __init ima_fs_init(void)
 				   &ima_measurements_ops);
 	if (IS_ERR(binary_kexec_runtime_measurements))
 		goto out;
+
+	restore_kexec_list = securityfs_create_file("restore_kexec_list",
+						    S_IWUSR, ima_dir, NULL,
+						    &ima_measure_policy_ops);
+	if (IS_ERR(restore_kexec_list))
+		goto out;
 #endif
 	return 0;
 out:
+	securityfs_remove(restore_kexec_list);
 	securityfs_remove(binary_kexec_runtime_measurements);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

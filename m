From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:36:57 +0100
Subject: [PATCH v2 02/15] ima: generalize ima_write_policy()
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-3-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch renames ima_write_policy() to ima_write_data(). Also, it
determines the kernel_read_file_id from the dentry associated to the file,
and passes it to ima_read_file().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 55 ++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 27de4558303e..864d34581081 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -28,6 +28,21 @@
 
 static DEFINE_MUTEX(ima_write_mutex);
 
+static struct dentry *ima_dir;
+static struct dentry *binary_runtime_measurements;
+static struct dentry *ascii_runtime_measurements;
+static struct dentry *runtime_measurements_count;
+static struct dentry *violations;
+static struct dentry *ima_policy;
+
+static enum kernel_read_file_id ima_get_file_id(struct dentry *dentry)
+{
+	if (dentry == ima_policy)
+		return READING_POLICY;
+
+	return READING_UNKNOWN;
+}
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -315,11 +330,12 @@ static ssize_t ima_read_file(char *path, enum kernel_read_file_id file_id)
 		return pathlen;
 }
 
-static ssize_t ima_write_policy(struct file *file, const char __user *buf,
-				size_t datalen, loff_t *ppos)
+static ssize_t ima_write_data(struct file *file, const char __user *buf,
+			      size_t datalen, loff_t *ppos)
 {
 	char *data;
 	ssize_t result;
+	enum kernel_read_file_id file_id = ima_get_file_id(file->f_path.dentry);
 
 	if (datalen >= PAGE_SIZE)
 		datalen = PAGE_SIZE - 1;
@@ -340,34 +356,33 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_file(data, READING_POLICY);
-	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
-		pr_err("IMA: signed policy file (specified as an absolute pathname) required\n");
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-				    "policy_update", "signed policy required",
-				    1, 0);
-		if (ima_appraise & IMA_APPRAISE_ENFORCE)
-			result = -EACCES;
+		result = ima_read_file(data, file_id);
+	} else if (file_id == READING_POLICY) {
+		if (ima_appraise & IMA_APPRAISE_POLICY) {
+			pr_err("IMA: signed policy file (specified "
+			       "as an absolute pathname) required\n");
+			integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+				"policy_update", "signed policy required",
+				1, 0);
+			if (ima_appraise & IMA_APPRAISE_ENFORCE)
+				result = -EACCES;
+		} else {
+			result = ima_parse_add_rule(data);
+		}
 	} else {
-		result = ima_parse_add_rule(data);
+		pr_err("Unknown data type\n");
+		result = -EINVAL;
 	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
 	kfree(data);
 out:
-	if (result < 0)
+	if (file_id == READING_POLICY && result < 0)
 		valid_policy = 0;
 
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
-
 enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
@@ -446,7 +461,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_measure_policy_ops = {
 	.open = ima_open_policy,
-	.write = ima_write_policy,
+	.write = ima_write_data,
 	.read = seq_read,
 	.release = ima_release_policy,
 	.llseek = generic_file_llseek,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html

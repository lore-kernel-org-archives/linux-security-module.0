From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:15 +0200
Subject: [PATCH 04/12] ima: use ima_show_htable_value to show hash table data
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-5-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch removes ima_show_htable_violations() and
ima_show_measurements_count(). ima_show_htable_value(), called
by those functions, determines which hash table data should be
copied to the buffer depending on the dentry of the file passed
as argument.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index f4199f2..ad3d674 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -55,38 +55,24 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 #define TMPBUFLEN 12
-static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+static ssize_t ima_show_htable_value(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
 {
+	atomic_long_t *val = NULL;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t len;
 
+	if (filp->f_path.dentry == violations)
+		val = &ima_htable.violations;
+	else if (filp->f_path.dentry == runtime_measurements_count)
+		val = &ima_htable.len;
+
 	len = scnprintf(tmpbuf, TMPBUFLEN, "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
-static ssize_t ima_show_htable_violations(struct file *filp,
-					  char __user *buf,
-					  size_t count, loff_t *ppos)
-{
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
-}
-
-static const struct file_operations ima_htable_violations_ops = {
-	.read = ima_show_htable_violations,
-	.llseek = generic_file_llseek,
-};
-
-static ssize_t ima_show_measurements_count(struct file *filp,
-					   char __user *buf,
-					   size_t count, loff_t *ppos)
-{
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
-
-}
-
-static const struct file_operations ima_measurements_count_ops = {
-	.read = ima_show_measurements_count,
+static const struct file_operations ima_htable_value_ops = {
+	.read = ima_show_htable_value,
 	.llseek = generic_file_llseek,
 };
 
@@ -508,13 +494,13 @@ int __init ima_fs_init(void)
 	runtime_measurements_count =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_count_ops);
+				   &ima_htable_value_ops);
 	if (IS_ERR(runtime_measurements_count))
 		goto out;
 
 	violations =
 	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
-				   ima_dir, NULL, &ima_htable_violations_ops);
+				   ima_dir, NULL, &ima_htable_value_ops);
 	if (IS_ERR(violations))
 		goto out;
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:05 +0100
Subject: [RFC][PATCH v2 4/9] ima: introduce ima_mk_null_file()
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-5-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces ima_mk_null_file(), which creates a file descriptor
connected to the null device. File descriptors inherited by child processes
will be replaced with the new file descriptor if the appraisal status is
not valid and appraisal is in enforcing mode.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h    |  1 +
 security/integrity/ima/ima_fs.c | 57 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2bdf10417125..f2cdd528f8ff 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -57,6 +57,7 @@ extern int ima_initialized;
 extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
+extern struct path ima_null;
 
 /* IMA event related data */
 struct ima_event_data {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fa540c0469da..15bde1042afd 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -23,6 +23,10 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <uapi/linux/major.h>
+#include <uapi/linux/magic.h>
 
 #include "ima.h"
 
@@ -438,6 +442,52 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/* taken from security/apparmor/apparmorfs.c */
+#define NULL_FILE_NAME ".null"
+struct path ima_null;
+
+static int ima_mk_null_file(struct dentry *parent)
+{
+	struct vfsmount *mount = NULL;
+	struct dentry *dentry;
+	struct inode *inode;
+	int count = 0;
+	int error = simple_pin_fs(parent->d_sb->s_type, &mount, &count);
+
+	if (error)
+		return error;
+
+	inode_lock(d_inode(parent));
+	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
+	if (IS_ERR(dentry)) {
+		error = PTR_ERR(dentry);
+		goto out;
+	}
+	inode = new_inode(parent->d_inode->i_sb);
+	if (!inode) {
+		error = -ENOMEM;
+		goto out1;
+	}
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = S_IFCHR | S_IRUGO | S_IWUGO;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
+			   MKDEV(MEM_MAJOR, 3));
+	d_instantiate(dentry, inode);
+	ima_null.dentry = dget(dentry);
+	ima_null.mnt = mntget(mount);
+
+	error = 0;
+
+out1:
+	dput(dentry);
+out:
+	inode_unlock(d_inode(parent));
+	simple_release_fs(&mount, &count);
+	return error;
+}
+
 static const struct file_operations ima_measure_policy_ops = {
 	.open = ima_open_policy,
 	.write = ima_write_policy,
@@ -448,6 +498,8 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int __init ima_fs_init(void)
 {
+	int error;
+
 	ima_dir = securityfs_create_dir("ima", NULL);
 	if (IS_ERR(ima_dir))
 		return -1;
@@ -485,8 +537,13 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+	error = ima_mk_null_file(ima_dir);
+	if (error)
+		goto out;
+
 	return 0;
 out:
+	securityfs_remove(ima_null.dentry);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:04 +0100
Subject: [PATCH v2 09/15] ima: introduce securityfs interfaces for digest lists
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-10-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces the file 'digest_lists' in the securityfs filesystem,
to load digest lists metadata. IMA will parse the metadata and load the
digest lists from the path provided.

It also introduces 'digests_count', to show the number of digests stored in
the ima_digests_htable hash table.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Changelog

v1:
- Deny upload of digest lists if no policy is loaded
---
 security/integrity/ima/ima_fs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 4158ced5d3c9..1ed717d94487 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -34,11 +34,15 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *digest_lists;
+static struct dentry *digests_count;
 
 static enum kernel_read_file_id ima_get_file_id(struct dentry *dentry)
 {
 	if (dentry == ima_policy)
 		return READING_POLICY;
+	else if (dentry == digest_lists)
+		return READING_DIGEST_LIST_METADATA;
 
 	return READING_UNKNOWN;
 }
@@ -66,6 +70,8 @@ static ssize_t ima_show_htable_value(struct file *filp, char __user *buf,
 		val = &ima_htable.violations;
 	else if (filp->f_path.dentry == runtime_measurements_count)
 		val = &ima_htable.len;
+	else if (filp->f_path.dentry == digests_count)
+		val = &ima_digests_htable.len;
 
 	len = scnprintf(tmpbuf, TMPBUFLEN, "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
@@ -301,6 +307,9 @@ static ssize_t ima_read_file(char *path, enum kernel_read_file_id file_id)
 
 			pr_debug("rule: %s\n", p);
 			rc = ima_parse_add_rule(p);
+		} else if (file_id == READING_DIGEST_LIST_METADATA) {
+			rc = ima_parse_digest_list_metadata(size, datap);
+			datap += rc;
 		}
 		if (rc < 0)
 			break;
@@ -401,7 +410,8 @@ static int ima_open_data_upload(struct inode *inode, struct file *filp)
 		read_allowed = true;
 		seq_ops = &ima_policy_seqops;
 #endif
-	}
+	} else if (file_id == READING_DIGEST_LIST_METADATA && !ima_policy_flag)
+		return -EACCES;
 
 	if (!(filp->f_flags & O_WRONLY)) {
 		if (!read_allowed)
@@ -510,8 +520,22 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+#ifdef CONFIG_IMA_DIGEST_LIST
+	digest_lists = securityfs_create_file("digest_lists", S_IWUSR, ima_dir,
+					      NULL, &ima_data_upload_ops);
+	if (IS_ERR(digest_lists))
+		goto out;
+
+	digests_count = securityfs_create_file("digests_count",
+					       S_IRUSR | S_IRGRP, ima_dir,
+					       NULL, &ima_htable_value_ops);
+	if (IS_ERR(digests_count))
+		goto out;
+#endif
 	return 0;
 out:
+	securityfs_remove(digests_count);
+	securityfs_remove(digest_lists);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

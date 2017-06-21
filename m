From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:22 -0400
Subject: [PATCH v2 02/10] ima: use fs method to read integrity data
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Add a new ->integrity_read file operation to read data for integrity
hash collection.  This is defined to be equivalent to ->read_iter,
except that it will be called with the i_rwsem held exclusively.

Changelog v2:
- change iovec to kvec

Changelog v1:
- update the patch description, removing the concept that the presence of
->integrity_read indicates that the file system can support IMA. (Mimi)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/btrfs/file.c           |  1 +
 fs/ext4/file.c            |  1 +
 fs/xfs/xfs_file.c         | 21 +++++++++++++++++++++
 include/linux/fs.h        |  1 +
 security/integrity/iint.c | 20 ++++++++++++++------
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index da1096eb1a40..003e859b56c4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3087,6 +3087,7 @@ const struct file_operations btrfs_file_operations = {
 #endif
 	.clone_file_range = btrfs_clone_file_range,
 	.dedupe_file_range = btrfs_dedupe_file_range,
+	.integrity_read = generic_file_read_iter,
 };
 
 void btrfs_auto_defrag_exit(void)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 831fd6beebf0..e7b2bd43cdc4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -753,6 +753,7 @@ const struct file_operations ext4_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
+	.integrity_read	= ext4_file_read_iter,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 35703a801372..3d6ace2a79bc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -288,6 +288,26 @@ xfs_file_read_iter(
 	return ret;
 }
 
+static ssize_t
+xfs_integrity_read(
+	struct kiocb		*iocb,
+	struct iov_iter		*to)
+{
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_mount	*mp = XFS_I(inode)->i_mount;
+
+	lockdep_assert_held(&inode->i_rwsem);
+
+	XFS_STATS_INC(mp, xs_read_calls);
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	if (IS_DAX(inode))
+		return dax_iomap_rw(iocb, to, &xfs_iomap_ops);
+	return generic_file_read_iter(iocb, to);
+}
+
 /*
  * Zero any on disk space between the current EOF and the new, larger EOF.
  *
@@ -1534,6 +1554,7 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.clone_file_range = xfs_file_clone_range,
 	.dedupe_file_range = xfs_file_dedupe_range,
+	.integrity_read	= xfs_integrity_read,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 803e5a9b2654..36edfe84c4bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1690,6 +1690,7 @@ struct file_operations {
 			u64);
 	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
 			u64);
+	ssize_t (*integrity_read)(struct kiocb *, struct iov_iter *);
 };
 
 struct inode_operations {
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 6fc888ca468e..df04f35a1d40 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -21,6 +21,7 @@
 #include <linux/rbtree.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
@@ -184,18 +185,25 @@ security_initcall(integrity_iintcache_init);
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	char __user *buf = (char __user *)addr;
+	struct inode *inode = file_inode(file);
+	struct kvec iov = { .iov_base = addr, .iov_len = count };
+	struct kiocb kiocb;
+	struct iov_iter iter;
 	ssize_t ret;
 
+	lockdep_assert_held(&inode->i_rwsem);
+
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
+	if (!file->f_op->integrity_read)
+		return -EBADF;
 
-	old_fs = get_fs();
-	set_fs(get_ds());
-	ret = __vfs_read(file, buf, count, &offset);
-	set_fs(old_fs);
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = offset;
+	iov_iter_kvec(&iter, READ | ITER_KVEC, &iov, 1, count);
 
+	ret = file->f_op->integrity_read(&kiocb, &iter);
+	BUG_ON(ret == -EIOCBQUEUED);
 	return ret;
 }
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

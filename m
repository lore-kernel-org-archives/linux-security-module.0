From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 01 Aug 2017 16:24:30 -0400
Subject: [PATCH v4 2/5] ima: use fs method to read integrity data [updated]
In-Reply-To: <1501075375-29469-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1501075375-29469-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1501619070.3204.4.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Add a new ->integrity_read file operation to read data for integrity
hash collection.  This is defined to be equivalent to ->read_iter,
except that it will be called with the i_rwsem held exclusively.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Jan Kara <jack@suse.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Chris Mason <clm@fb.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

---
Changelog v5:
- removed ocf2 and gfs2 integrity_read support based on Jan Kara's review.

Changelog v4:
- define ext2/4 specific ->integrity_read functions.
- properly fail file open with O_DIRECT on filesystem not mounted
with "-o dax".

Changelog v3:
- define simple_read_iter_from_buffer
- replace the existing efivarfs ->read method with ->read_iter method.
- squashed other fs definitions of ->integrity_read with this patch.

Changelog v2:
- change iovec to kvec

Changelog v1:
- update the patch description, removing the concept that the presence of
->integrity_read indicates that the file system can support IMA. (Mimi)

 fs/btrfs/file.c           |  1 +
 fs/efivarfs/file.c        | 12 +++++++-----
 fs/ext2/file.c            | 17 +++++++++++++++++
 fs/ext4/file.c            | 23 +++++++++++++++++++++++
 fs/f2fs/file.c            |  1 +
 fs/jffs2/file.c           |  1 +
 fs/jfs/file.c             |  1 +
 fs/libfs.c                | 32 ++++++++++++++++++++++++++++++++
 fs/nilfs2/file.c          |  1 +
 fs/ramfs/file-mmu.c       |  1 +
 fs/ramfs/file-nommu.c     |  1 +
 fs/ubifs/file.c           |  1 +
 fs/xfs/xfs_file.c         | 21 +++++++++++++++++++++
 include/linux/fs.h        |  3 +++
 mm/shmem.c                |  1 +
 security/integrity/iint.c | 20 ++++++++++++++------
 16 files changed, 126 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9e75d8a39aac..2542dc66c85c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3125,6 +3125,7 @@ const struct file_operations btrfs_file_operations = {
 #endif
 	.clone_file_range = btrfs_clone_file_range,
 	.dedupe_file_range = btrfs_dedupe_file_range,
+	.integrity_read = generic_file_read_iter,
 };
 
 void btrfs_auto_defrag_exit(void)
diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 5f22e74bbade..17955a92a5b3 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -64,9 +64,10 @@ static ssize_t efivarfs_file_write(struct file *file,
 	return bytes;
 }
 
-static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
-		size_t count, loff_t *ppos)
+static ssize_t efivarfs_file_read_iter(struct kiocb *iocb,
+				       struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
 	struct efivar_entry *var = file->private_data;
 	unsigned long datasize = 0;
 	u32 attributes;
@@ -96,8 +97,8 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 		goto out_free;
 
 	memcpy(data, &attributes, sizeof(attributes));
-	size = simple_read_from_buffer(userbuf, count, ppos,
-				       data, datasize + sizeof(attributes));
+	size = simple_read_iter_from_buffer(iocb, iter, data,
+					    datasize + sizeof(attributes));
 out_free:
 	kfree(data);
 
@@ -174,8 +175,9 @@ efivarfs_file_ioctl(struct file *file, unsigned int cmd, unsigned long p)
 
 const struct file_operations efivarfs_file_operations = {
 	.open	= simple_open,
-	.read	= efivarfs_file_read,
+	.read_iter = efivarfs_file_read_iter,
 	.write	= efivarfs_file_write,
 	.llseek	= no_llseek,
 	.unlocked_ioctl = efivarfs_file_ioctl,
+	.integrity_read	= efivarfs_file_read_iter,
 };
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index d34d32bdc944..111069de1973 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -192,6 +192,22 @@ static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return generic_file_read_iter(iocb, to);
 }
 
+static ssize_t ext2_file_integrity_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	lockdep_assert_held(&inode->i_rwsem);
+#ifdef CONFIG_FS_DAX
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+	if (IS_DAX(iocb->ki_filp->f_mapping->host))
+		return dax_iomap_rw(iocb, to, &ext2_iomap_ops);
+#endif
+	return generic_file_read_iter(iocb, to);
+}
+
 static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 #ifdef CONFIG_FS_DAX
@@ -216,6 +232,7 @@ const struct file_operations ext2_file_operations = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.integrity_read	= ext2_file_integrity_read_iter,
 };
 
 const struct inode_operations ext2_file_inode_operations = {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 58294c9a7e1d..cb423fff935f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -74,6 +74,28 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return generic_file_read_iter(iocb, to);
 }
 
+static ssize_t ext4_file_integrity_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	int o_direct = iocb->ki_flags & IOCB_DIRECT;
+
+	lockdep_assert_held(&inode->i_rwsem);
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+		return -EIO;
+
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return dax_iomap_rw(iocb, to, &ext4_iomap_ops);
+#endif
+	if (o_direct)
+		return -EINVAL;
+	return generic_file_read_iter(iocb, to);
+}
+
 /*
  * Called when an inode is released. Note that this is different
  * from ext4_file_open: open gets called at every open, but release
@@ -747,6 +769,7 @@ const struct file_operations ext4_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
+	.integrity_read	= ext4_file_integrity_read_iter,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2706130c261b..82ea81da0b2d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2514,4 +2514,5 @@ const struct file_operations f2fs_file_operations = {
 #endif
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.integrity_read	= generic_file_read_iter,
 };
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index c12476e309c6..5a63034cccf5 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -57,6 +57,7 @@ const struct file_operations jffs2_file_operations =
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
 	.splice_read =	generic_file_splice_read,
+	.integrity_read = generic_file_read_iter,
 };
 
 /* jffs2_file_inode_operations */
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 739492c7a3fd..423512a810e4 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -162,4 +162,5 @@ const struct file_operations jfs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= jfs_compat_ioctl,
 #endif
+	.integrity_read	= generic_file_read_iter,
 };
diff --git a/fs/libfs.c b/fs/libfs.c
index 3aabe553fc45..99333264a0a7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -16,6 +16,7 @@
 #include <linux/exportfs.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h> /* sync_mapping_buffers */
+#include <linux/uio.h>
 
 #include <linux/uaccess.h>
 
@@ -676,6 +677,37 @@ ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 EXPORT_SYMBOL(simple_write_to_buffer);
 
 /**
+ * simple_read_iter_from_buffer - copy data from the buffer to user space
+ * @iocb: struct containing the file, the current position and other info
+ * @to: the user space buffer to read to
+ * @from: the buffer to read from
+ * @available: the size of the buffer
+ *
+ * The simple_read_iter_from_buffer() function reads up to @available bytes
+ * from the current buffer into the user space buffer.
+ *
+ * On success, the current buffer offset is advanced by the number of bytes
+ * read, or a negative value is returned on error.
+ **/
+ssize_t simple_read_iter_from_buffer(struct kiocb *iocb, struct iov_iter *to,
+                                const void *from, size_t available)
+{
+	loff_t pos = iocb->ki_pos;
+	size_t ret;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available)
+		return 0;
+	ret = copy_to_iter(from + pos, available - pos, to);
+	if (!ret && iov_iter_count(to))
+		return -EFAULT;
+	iocb->ki_pos = pos + ret;
+	return ret;
+}
+EXPORT_SYMBOL(simple_read_iter_from_buffer);
+
+/**
  * memory_read_from_buffer - copy data from the buffer
  * @to: the kernel space buffer to read to
  * @count: the maximum number of bytes to read
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index c5fa3dee72fc..55e058ac487f 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -150,6 +150,7 @@ const struct file_operations nilfs_file_operations = {
 	/* .release	= nilfs_release_file, */
 	.fsync		= nilfs_sync_file,
 	.splice_read	= generic_file_splice_read,
+	.integrity_read	= generic_file_read_iter,
 };
 
 const struct inode_operations nilfs_file_inode_operations = {
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index 12af0490322f..4f24d1b589b1 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -47,6 +47,7 @@ const struct file_operations ramfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.llseek		= generic_file_llseek,
 	.get_unmapped_area	= ramfs_mmu_get_unmapped_area,
+	.integrity_read	= generic_file_read_iter,
 };
 
 const struct inode_operations ramfs_file_inode_operations = {
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 2ef7ce75c062..5ee704fa84e0 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -50,6 +50,7 @@ const struct file_operations ramfs_file_operations = {
 	.splice_read		= generic_file_splice_read,
 	.splice_write		= iter_file_splice_write,
 	.llseek			= generic_file_llseek,
+	.integrity_read		= generic_file_read_iter,
 };
 
 const struct inode_operations ramfs_file_inode_operations = {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 8cad0b19b404..5e52a315e18b 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1747,4 +1747,5 @@ const struct file_operations ubifs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = ubifs_compat_ioctl,
 #endif
+	.integrity_read = generic_file_read_iter,
 };
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c4893e226fd8..0a6704b563d6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -292,6 +292,26 @@ xfs_file_read_iter(
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
@@ -1175,6 +1195,7 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.clone_file_range = xfs_file_clone_range,
 	.dedupe_file_range = xfs_file_dedupe_range,
+	.integrity_read	= xfs_integrity_read,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d21248..8d0d10e1dd93 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1699,6 +1699,7 @@ struct file_operations {
 			u64);
 	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
 			u64);
+	ssize_t (*integrity_read)(struct kiocb *, struct iov_iter *);
 } __randomize_layout;
 
 struct inode_operations {
@@ -3097,6 +3098,8 @@ extern void simple_release_fs(struct vfsmount **mount, int *count);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
+extern ssize_t simple_read_iter_from_buffer(struct kiocb *iocb,
+		struct iov_iter *to, const void *from, size_t available);
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index b0aa6075d164..805d99011ca4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3849,6 +3849,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.integrity_read	= shmem_file_read_iter,
 #endif
 };
 
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

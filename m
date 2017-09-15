From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 15 Sep 2017 00:58:14 -0400
Subject: [PATCH 3/3] ima: use fs method to read integrity data
In-Reply-To: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Add a new ->integrity_read file operation to read data for integrity
hash collection.  This is defined to be equivalent to ->read_iter,
except that it will be called with the i_rwsem held exclusively.

(Based on Christoph's original patch.)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
---
 fs/btrfs/file.c           |  1 +
 fs/efivarfs/file.c        |  1 +
 fs/ext2/file.c            | 17 +++++++++++++++++
 fs/ext4/file.c            | 20 ++++++++++++++++++++
 fs/f2fs/file.c            |  1 +
 fs/jffs2/file.c           |  1 +
 fs/jfs/file.c             |  1 +
 fs/nilfs2/file.c          |  1 +
 fs/ramfs/file-mmu.c       |  1 +
 fs/ramfs/file-nommu.c     |  1 +
 fs/ubifs/file.c           |  1 +
 fs/xfs/xfs_file.c         | 21 +++++++++++++++++++++
 include/linux/fs.h        |  1 +
 mm/shmem.c                |  1 +
 security/integrity/iint.c | 20 ++++++++++++++------
 15 files changed, 83 insertions(+), 6 deletions(-)

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
index 863f1b100165..17955a92a5b3 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -179,4 +179,5 @@ const struct file_operations efivarfs_file_operations = {
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
index 58294c9a7e1d..3ab4105c8578 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -74,6 +74,25 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return generic_file_read_iter(iocb, to);
 }
 
+static ssize_t ext4_file_integrity_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
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
+	return generic_file_read_iter(iocb, to);
+}
+
 /*
  * Called when an inode is released. Note that this is different
  * from ext4_file_open: open gets called at every open, but release
@@ -747,6 +766,7 @@ const struct file_operations ext4_file_operations = {
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
index e522d25d0836..f6a01d3efce5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1699,6 +1699,7 @@ struct file_operations {
 			u64);
 	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
 			u64);
+	ssize_t (*integrity_read)(struct kiocb *, struct iov_iter *);
 } __randomize_layout;
 
 struct inode_operations {
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
index c84e05866052..c3a07276f745 100644
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

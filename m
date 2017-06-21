From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:26 -0400
Subject: [PATCH v2 06/10] fs: define integrity_read method for ext2, gfs2, f2fs,
	jfs, ramfs
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-7-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Define ->integrity_read file operation methods to read data for
integrity hash collection.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/ext2/file.c        | 1 +
 fs/f2fs/file.c        | 1 +
 fs/gfs2/file.c        | 2 ++
 fs/jfs/file.c         | 1 +
 fs/ramfs/file-mmu.c   | 1 +
 fs/ramfs/file-nommu.c | 1 +
 6 files changed, 7 insertions(+)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index b21891a6bfca..d57c4259945d 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -219,6 +219,7 @@ const struct file_operations ext2_file_operations = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.integrity_read	= generic_file_read_iter,
 };
 
 const struct inode_operations ext2_file_inode_operations = {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 61af721329fa..e93fdeb3eba4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2406,4 +2406,5 @@ const struct file_operations f2fs_file_operations = {
 #endif
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.integrity_read	= generic_file_read_iter,
 };
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index c2062a108d19..9b49d09ba180 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1124,6 +1124,7 @@ const struct file_operations gfs2_file_fops = {
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
+	.integrity_read	= generic_file_read_iter,
 };
 
 const struct file_operations gfs2_dir_fops = {
@@ -1152,6 +1153,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= generic_setlease,
 	.fallocate	= gfs2_fallocate,
+	.integrity_read	= generic_file_read_iter,
 };
 
 const struct file_operations gfs2_dir_fops_nolock = {
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
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

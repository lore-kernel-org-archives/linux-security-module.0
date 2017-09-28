From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 28 Sep 2017 08:39:31 -0400
Subject: [RFC PATCH 1/3] fs: define new read_iter rwf flag
In-Reply-To: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Writing extended attributes requires exclusively taking the i_rwsem
lock.  To synchronize the file hash calculation and writing the file
hash as security.ima xattr, IMA-appraisal takes the i_rwsem lock
exclusively before calculating the file hash.  (Once the file hash
is calculated, the result is cached.  Taking the lock exclusively
prevents calculating the file hash multiple times.)

Some filesystems have recently replaced their filesystem dependent
lock with the global i_rwsem to read a file.  As a result, when IMA
attempts to calculate the file hash, reading the file attempts to
take the i_rwsem again.

To resolve this problem, this patch defines a new read_iter flag
named "rwf" to indicate that the i_rwsem has already been taken
exclusively.  Subsequent patches will set or test the "rwf" flag.

Fixes: Commit 6552321831dc "xfs: remove i_iolock and use i_rwsem in
the VFS inode instead"
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 arch/s390/hypfs/inode.c                      |  3 ++-
 drivers/block/loop.c                         |  2 +-
 drivers/char/mem.c                           |  6 ++++--
 drivers/gpu/drm/drm_dp_aux_dev.c             |  3 ++-
 drivers/net/tap.c                            |  3 ++-
 drivers/net/tun.c                            |  3 ++-
 drivers/staging/android/ashmem.c             |  3 ++-
 drivers/staging/lustre/lustre/llite/file.c   |  3 ++-
 drivers/staging/lustre/lustre/llite/vvp_io.c |  2 +-
 drivers/usb/gadget/function/f_fs.c           |  3 ++-
 drivers/usb/gadget/legacy/inode.c            |  2 +-
 drivers/vhost/net.c                          |  3 ++-
 fs/9p/vfs_file.c                             |  8 +++++---
 fs/aio.c                                     |  2 +-
 fs/block_dev.c                               |  4 ++--
 fs/ceph/file.c                               |  5 +++--
 fs/cifs/cifsfs.c                             |  6 +++---
 fs/cifs/cifsfs.h                             |  4 ++--
 fs/cifs/file.c                               | 10 +++++-----
 fs/coda/file.c                               |  2 +-
 fs/ecryptfs/file.c                           |  4 ++--
 fs/efivarfs/file.c                           |  2 +-
 fs/ext2/file.c                               | 10 ++++++----
 fs/ext4/file.c                               | 12 +++++++-----
 fs/fuse/cuse.c                               |  3 ++-
 fs/fuse/dev.c                                |  3 ++-
 fs/fuse/file.c                               |  8 +++++---
 fs/hugetlbfs/inode.c                         |  3 ++-
 fs/ncpfs/file.c                              |  2 +-
 fs/nfs/file.c                                |  4 ++--
 fs/nfs/internal.h                            |  2 +-
 fs/ocfs2/file.c                              |  5 +++--
 fs/orangefs/file.c                           |  3 ++-
 fs/pipe.c                                    |  2 +-
 fs/read_write.c                              |  4 ++--
 fs/splice.c                                  |  2 +-
 fs/xfs/xfs_file.c                            | 20 ++++++++++++--------
 include/linux/fs.h                           | 10 +++++-----
 mm/filemap.c                                 |  3 ++-
 mm/shmem.c                                   |  3 ++-
 net/socket.c                                 |  4 ++--
 sound/core/pcm_native.c                      |  2 +-
 42 files changed, 109 insertions(+), 79 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index cf8a2d92467f..b31adc0e286a 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -141,7 +141,8 @@ static int hypfs_open(struct inode *inode, struct file *filp)
 	return nonseekable_open(inode, filp);
 }
 
-static ssize_t hypfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t hypfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
+			       bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	char *data = file->private_data;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 85de67334695..840e3d655a50 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -539,7 +539,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &cmd->iocb, &iter);
+		ret = call_read_iter(file, &cmd->iocb, &iter, 0);
 
 	lo_rw_aio_do_completion(cmd);
 
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 593a8818aca9..d1b13f2bf506 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -635,7 +635,8 @@ static ssize_t write_null(struct file *file, const char __user *buf,
 	return count;
 }
 
-static ssize_t read_iter_null(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t read_iter_null(struct kiocb *iocb, struct iov_iter *to,
+			      bool rwf)
 {
 	return 0;
 }
@@ -659,7 +660,8 @@ static ssize_t splice_write_null(struct pipe_inode_info *pipe, struct file *out,
 	return splice_from_pipe(pipe, out, ppos, len, flags, pipe_to_null);
 }
 
-static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter,
+			      bool rwf)
 {
 	size_t written = 0;
 
diff --git a/drivers/gpu/drm/drm_dp_aux_dev.c b/drivers/gpu/drm/drm_dp_aux_dev.c
index d34e5096887a..1604e666df6b 100644
--- a/drivers/gpu/drm/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/drm_dp_aux_dev.c
@@ -141,7 +141,8 @@ static loff_t auxdev_llseek(struct file *file, loff_t offset, int whence)
 	return fixed_size_llseek(file, offset, whence, AUX_MAX_OFFSET);
 }
 
-static ssize_t auxdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t auxdev_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				bool rwf)
 {
 	struct drm_dp_aux_dev *aux_dev = iocb->ki_filp->private_data;
 	loff_t pos = iocb->ki_pos;
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 21b71ae947fd..cc8225eb4b9d 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -869,7 +869,8 @@ static ssize_t tap_do_read(struct tap_queue *q,
 	return ret;
 }
 
-static ssize_t tap_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t tap_read_iter(struct kiocb *iocb, struct iov_iter *to,
+			     bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct tap_queue *q = file->private_data;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 3c9985f29950..453b0890ff23 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1750,7 +1750,8 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 	return ret;
 }
 
-static ssize_t tun_chr_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t tun_chr_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				 bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct tun_file *tfile = file->private_data;
diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 0f695df14c9d..3641f1e0fd0c 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -294,7 +294,8 @@ static int ashmem_release(struct inode *ignored, struct file *file)
 	return 0;
 }
 
-static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t ashmem_read_iter(struct kiocb *iocb, struct iov_iter *iter,
+				bool rwf)
 {
 	struct ashmem_area *asma = iocb->ki_filp->private_data;
 	int ret = 0;
diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging/lustre/lustre/llite/file.c
index be665454f407..68848af2dd66 100644
--- a/drivers/staging/lustre/lustre/llite/file.c
+++ b/drivers/staging/lustre/lustre/llite/file.c
@@ -1150,7 +1150,8 @@ ll_file_io_generic(const struct lu_env *env, struct vvp_io_args *args,
 	return result > 0 ? result : rc;
 }
 
-static ssize_t ll_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t ll_file_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				 bool rwf)
 {
 	struct lu_env      *env;
 	struct vvp_io_args *args;
diff --git a/drivers/staging/lustre/lustre/llite/vvp_io.c b/drivers/staging/lustre/lustre/llite/vvp_io.c
index c83853fa1bb4..c2cde697398b 100644
--- a/drivers/staging/lustre/lustre/llite/vvp_io.c
+++ b/drivers/staging/lustre/lustre/llite/vvp_io.c
@@ -719,7 +719,7 @@ static int vvp_io_read_start(const struct lu_env *env,
 	/* BUG: 5972 */
 	file_accessed(file);
 	LASSERT(vio->vui_iocb->ki_pos == pos);
-	result = generic_file_read_iter(vio->vui_iocb, vio->vui_iter);
+	result = generic_file_read_iter(vio->vui_iocb, vio->vui_iter, 0);
 
 out:
 	if (result >= 0) {
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 9990944a7245..ceaa3f7edf80 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1123,7 +1123,8 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	return res;
 }
 
-static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
+static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to,
+				    bool rwf)
 {
 	struct ffs_io_data io_data, *p = &io_data;
 	ssize_t res;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 684900fcfe24..937a0c6bbee7 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -572,7 +572,7 @@ static ssize_t ep_aio(struct kiocb *iocb,
 }
 
 static ssize_t
-ep_read_iter(struct kiocb *iocb, struct iov_iter *to)
+ep_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct ep_data *epdata = file->private_data;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 58585ec8699e..b0dd97ccc910 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1337,7 +1337,8 @@ static long vhost_net_compat_ioctl(struct file *f, unsigned int ioctl,
 }
 #endif
 
-static ssize_t vhost_net_chr_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t vhost_net_chr_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				       bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct vhost_net *n = file->private_data;
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 03c9e325bfbc..a78e5791042f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -375,11 +375,12 @@ static int v9fs_file_flock_dotl(struct file *filp, int cmd,
  * @udata: user data buffer to read data into
  * @count: size of buffer
  * @offset: offset at which to read data
+ * @rwf: i_rwsem taken exclusively
  *
  */
 
 static ssize_t
-v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct p9_fid *fid = iocb->ki_filp->private_data;
 	int ret, err = 0;
@@ -569,13 +570,14 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
  * @data: user data buffer to read data into
  * @count: size of buffer
  * @offset: offset at which to read data
+ * @rwf: i_rwsem taken exclusively
  *
  */
 static ssize_t
-v9fs_mmap_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+v9fs_mmap_file_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	/* TODO: Check if there are dirty pages */
-	return v9fs_file_read_iter(iocb, to);
+	return v9fs_file_read_iter(iocb, to, rwf);
 }
 
 /**
diff --git a/fs/aio.c b/fs/aio.c
index 5a2487217072..0d11f0729afd 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1508,7 +1508,7 @@ static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
-		ret = aio_ret(req, call_read_iter(file, req, &iter));
+		ret = aio_ret(req, call_read_iter(file, req, &iter, 0));
 	kfree(iovec);
 	return ret;
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 93d088ffc05c..7c726a0ac447 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1908,7 +1908,7 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL_GPL(blkdev_write_iter);
 
-ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
+ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *bd_inode = bdev_file_inode(file);
@@ -1920,7 +1920,7 @@ ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	size -= pos;
 	iov_iter_truncate(to, size);
-	return generic_file_read_iter(iocb, to);
+	return generic_file_read_iter(iocb, to, rwf);
 }
 EXPORT_SYMBOL_GPL(blkdev_read_iter);
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 65a6fa12c857..514781336232 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1153,7 +1153,8 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
  *
  * Hmm, the sync read case isn't actually async... should it be?
  */
-static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to,
+			      bool rwf)
 {
 	struct file *filp = iocb->ki_filp;
 	struct ceph_file_info *fi = filp->private_data;
@@ -1202,7 +1203,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		     ceph_cap_string(got));
 		current->journal_info = filp;
-		ret = generic_file_read_iter(iocb, to);
+		ret = generic_file_read_iter(iocb, to, rwf);
 		current->journal_info = NULL;
 	}
 	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8c8b75d33f31..8e38e4ec53da 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -765,19 +765,19 @@ cifs_do_mount(struct file_system_type *fs_type,
 }
 
 static ssize_t
-cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter, bool rwf)
 {
 	ssize_t rc;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (iocb->ki_filp->f_flags & O_DIRECT)
-		return cifs_user_readv(iocb, iter);
+		return cifs_user_readv(iocb, iter, rwf);
 
 	rc = cifs_revalidate_mapping(inode);
 	if (rc)
 		return rc;
 
-	return generic_file_read_iter(iocb, iter);
+	return generic_file_read_iter(iocb, iter, rwf);
 }
 
 static ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 5a10e566f0e6..a1c6900e8f3e 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -101,8 +101,8 @@ extern const struct file_operations cifs_file_strict_nobrl_ops;
 extern int cifs_open(struct inode *inode, struct file *file);
 extern int cifs_close(struct inode *inode, struct file *file);
 extern int cifs_closedir(struct inode *inode, struct file *file);
-extern ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
+extern ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to, bool rwf);
+extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to, bool rwf);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
 extern int cifs_lock(struct file *, int, struct file_lock *);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 92fdf9c35de2..685be7dbb4fc 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3249,7 +3249,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 		complete(&ctx->done);
 }
 
-ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
+ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	ssize_t rc;
@@ -3337,7 +3337,7 @@ ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
 }
 
 ssize_t
-cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
+cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
@@ -3356,12 +3356,12 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	 * pos+len-1.
 	 */
 	if (!CIFS_CACHE_READ(cinode))
-		return cifs_user_readv(iocb, to);
+		return cifs_user_readv(iocb, to, rwf);
 
 	if (cap_unix(tcon->ses) &&
 	    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&
 	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0))
-		return generic_file_read_iter(iocb, to);
+		return generic_file_read_iter(iocb, to, rwf);
 
 	/*
 	 * We need to hold the sem to be sure nobody modifies lock list
@@ -3371,7 +3371,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(to),
 				     tcon->ses->server->vals->shared_lock_type,
 				     NULL, CIFS_READ_OP))
-		rc = generic_file_read_iter(iocb, to);
+		rc = generic_file_read_iter(iocb, to, rwf);
 	up_read(&cinode->lock_sem);
 	return rc;
 }
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 363402fcb3ed..f96cf884ca68 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -27,7 +27,7 @@
 #include "coda_int.h"
 
 static ssize_t
-coda_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+coda_file_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct file *coda_file = iocb->ki_filp;
 	struct coda_file_info *cfi = CODA_FTOC(coda_file);
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c74ed3ca3372..3356d43538db 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -44,13 +44,13 @@
  * The function to be used for directory reads is ecryptfs_read.
  */
 static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
-				struct iov_iter *to)
+				struct iov_iter *to, bool rwf)
 {
 	ssize_t rc;
 	struct path *path;
 	struct file *file = iocb->ki_filp;
 
-	rc = generic_file_read_iter(iocb, to);
+	rc = generic_file_read_iter(iocb, to, rwf);
 	if (rc >= 0) {
 		path = ecryptfs_dentry_to_lower_path(file->f_path.dentry);
 		touch_atime(path);
diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 863f1b100165..3419461d6e39 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -65,7 +65,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 }
 
 static ssize_t efivarfs_file_read_iter(struct kiocb *iocb,
-				       struct iov_iter *iter)
+				       struct iov_iter *iter, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct efivar_entry *var = file->private_data;
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index ff3a3636a5ca..839095f66d8d 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -29,7 +29,8 @@
 #include "acl.h"
 
 #ifdef CONFIG_FS_DAX
-static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				  bool rwf)
 {
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	ssize_t ret;
@@ -160,13 +161,14 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return ret;
 }
 
-static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				   bool rwf)
 {
 #ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
-		return ext2_dax_read_iter(iocb, to);
+		return ext2_dax_read_iter(iocb, to, rwf);
 #endif
-	return generic_file_read_iter(iocb, to);
+	return generic_file_read_iter(iocb, to, rwf);
 }
 
 static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index b1da660ac3bc..10789666725e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -32,7 +32,8 @@
 #include "acl.h"
 
 #ifdef CONFIG_FS_DAX
-static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				  bool rwf)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
@@ -49,7 +50,7 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (!IS_DAX(inode)) {
 		inode_unlock_shared(inode);
 		/* Fallback to buffered IO in case we cannot support DAX */
-		return generic_file_read_iter(iocb, to);
+		return generic_file_read_iter(iocb, to, rwf);
 	}
 	ret = dax_iomap_rw(iocb, to, &ext4_iomap_ops);
 	inode_unlock_shared(inode);
@@ -59,7 +60,8 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 #endif
 
-static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				   bool rwf)
 {
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
 		return -EIO;
@@ -69,9 +71,9 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #ifdef CONFIG_FS_DAX
 	if (IS_DAX(file_inode(iocb->ki_filp)))
-		return ext4_dax_read_iter(iocb, to);
+		return ext4_dax_read_iter(iocb, to, rwf);
 #endif
-	return generic_file_read_iter(iocb, to);
+	return generic_file_read_iter(iocb, to, rwf);
 }
 
 /*
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index e9e97803442a..79d69a4a1d3f 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -88,7 +88,8 @@ static struct list_head *cuse_conntbl_head(dev_t devt)
  * FUSE file.
  */
 
-static ssize_t cuse_read_iter(struct kiocb *kiocb, struct iov_iter *to)
+static ssize_t cuse_read_iter(struct kiocb *kiocb, struct iov_iter *to,
+			      bool rwf)
 {
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(kiocb);
 	loff_t pos = 0;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 13c65dd2d37d..10295052a140 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1331,7 +1331,8 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to,
+			     bool rwf)
 {
 	struct fuse_copy_state cs;
 	struct file *file = iocb->ki_filp;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cb7dff5c45d7..049dc4cb0ba9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -913,7 +913,8 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
 	return err;
 }
 
-static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				   bool rwf)
 {
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -931,7 +932,7 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return err;
 	}
 
-	return generic_file_read_iter(iocb, to);
+	return generic_file_read_iter(iocb, to, rwf);
 }
 
 static void fuse_write_fill(struct fuse_req *req, struct fuse_file *ff,
@@ -1421,7 +1422,8 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 	return res;
 }
 
-static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				     bool rwf)
 {
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	return __fuse_direct_read(&io, to, &iocb->ki_pos);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 59073e9f01a4..bcfc48e04a14 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -248,7 +248,8 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
  * data. Its *very* similar to do_generic_mapping_read(), we can't use that
  * since it has PAGE_SIZE assumptions.
  */
-static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				   bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct hstate *h = hstate_file(file);
diff --git a/fs/ncpfs/file.c b/fs/ncpfs/file.c
index a06c07619ee6..332e50c16d4f 100644
--- a/fs/ncpfs/file.c
+++ b/fs/ncpfs/file.c
@@ -98,7 +98,7 @@ int ncp_make_open(struct inode *inode, int right)
 }
 
 static ssize_t
-ncp_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+ncp_file_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0214dd1e1060..185832abc9ce 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -151,7 +151,7 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 }
 
 ssize_t
-nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
+nfs_file_read(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t result;
@@ -166,7 +166,7 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	nfs_start_io_read(inode);
 	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 	if (!result) {
-		result = generic_file_read_iter(iocb, to);
+		result = generic_file_read_iter(iocb, to, rwf);
 		if (result > 0)
 			nfs_add_stats(inode, NFSIOS_NORMALREADBYTES, result);
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 5bdf952f414b..29cac66ad5b7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -368,7 +368,7 @@ int nfs_rename(struct inode *, struct dentry *,
 /* file.c */
 int nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 loff_t nfs_file_llseek(struct file *, loff_t, int);
-ssize_t nfs_file_read(struct kiocb *, struct iov_iter *);
+ssize_t nfs_file_read(struct kiocb *, struct iov_iter *, bool rwf);
 int nfs_file_mmap(struct file *, struct vm_area_struct *);
 ssize_t nfs_file_write(struct kiocb *, struct iov_iter *);
 int nfs_file_release(struct inode *, struct file *);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6e41fc8fabbe..bb003879c01d 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2345,7 +2345,8 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
 }
 
 static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
-				   struct iov_iter *to)
+				    struct iov_iter *to,
+				    bool rwf)
 {
 	int ret = 0, rw_level = -1, lock_level = 0;
 	struct file *filp = iocb->ki_filp;
@@ -2395,7 +2396,7 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	}
 	ocfs2_inode_unlock(inode, lock_level);
 
-	ret = generic_file_read_iter(iocb, to);
+	ret = generic_file_read_iter(iocb, to, rwf);
 	trace_generic_file_aio_read_ret(ret);
 
 	/* buffered aio wouldn't have proper lock coverage today */
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 336ecbf8c268..cd36d0468614 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -442,7 +442,8 @@ ssize_t orangefs_inode_read(struct inode *inode,
 	return ret;
 }
 
-static ssize_t orangefs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
+				       struct iov_iter *iter, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos = *(&iocb->ki_pos);
diff --git a/fs/pipe.c b/fs/pipe.c
index 97e5be897753..b4977ed7693e 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -247,7 +247,7 @@ static const struct pipe_buf_operations packet_pipe_buf_ops = {
 };
 
 static ssize_t
-pipe_read(struct kiocb *iocb, struct iov_iter *to)
+pipe_read(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	size_t total_len = iov_iter_count(to);
 	struct file *filp = iocb->ki_filp;
diff --git a/fs/read_write.c b/fs/read_write.c
index a2b9a47235c5..b68ed6fe01e5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -397,7 +397,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	kiocb.ki_pos = *ppos;
 	iov_iter_init(&iter, READ, &iov, 1, len);
 
-	ret = call_read_iter(filp, &kiocb, &iter);
+	ret = call_read_iter(filp, &kiocb, &iter, 0);
 	BUG_ON(ret == -EIOCBQUEUED);
 	*ppos = kiocb.ki_pos;
 	return ret;
@@ -668,7 +668,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	kiocb.ki_pos = *ppos;
 
 	if (type == READ)
-		ret = call_read_iter(filp, &kiocb, iter);
+		ret = call_read_iter(filp, &kiocb, iter, 0);
 	else
 		ret = call_write_iter(filp, &kiocb, iter);
 	BUG_ON(ret == -EIOCBQUEUED);
diff --git a/fs/splice.c b/fs/splice.c
index f3084cce0ea6..6c6facdb1466 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -304,7 +304,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	idx = to.idx;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
+	ret = call_read_iter(in, &kiocb, &to, 0);
 	if (ret > 0) {
 		*ppos = kiocb.ki_pos;
 		file_accessed(in);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ebdd0bd2b261..cf1ce8961601 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -203,7 +203,8 @@ xfs_file_fsync(
 STATIC ssize_t
 xfs_file_dio_aio_read(
 	struct kiocb		*iocb,
-	struct iov_iter		*to)
+	struct iov_iter		*to,
+	bool			rwf)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	size_t			count = iov_iter_count(to);
@@ -226,7 +227,8 @@ xfs_file_dio_aio_read(
 static noinline ssize_t
 xfs_file_dax_read(
 	struct kiocb		*iocb,
-	struct iov_iter		*to)
+	struct iov_iter		*to,
+	bool			rwf)
 {
 	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
 	size_t			count = iov_iter_count(to);
@@ -252,7 +254,8 @@ xfs_file_dax_read(
 STATIC ssize_t
 xfs_file_buffered_aio_read(
 	struct kiocb		*iocb,
-	struct iov_iter		*to)
+	struct iov_iter		*to,
+	bool			rwf)
 {
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	ssize_t			ret;
@@ -264,7 +267,7 @@ xfs_file_buffered_aio_read(
 			return -EAGAIN;
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
-	ret = generic_file_read_iter(iocb, to);
+	ret = generic_file_read_iter(iocb, to, rwf);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -273,7 +276,8 @@ xfs_file_buffered_aio_read(
 STATIC ssize_t
 xfs_file_read_iter(
 	struct kiocb		*iocb,
-	struct iov_iter		*to)
+	struct iov_iter		*to,
+	bool			rwf)
 {
 	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_mount	*mp = XFS_I(inode)->i_mount;
@@ -285,11 +289,11 @@ xfs_file_read_iter(
 		return -EIO;
 
 	if (IS_DAX(inode))
-		ret = xfs_file_dax_read(iocb, to);
+		ret = xfs_file_dax_read(iocb, to, rwf);
 	else if (iocb->ki_flags & IOCB_DIRECT)
-		ret = xfs_file_dio_aio_read(iocb, to);
+		ret = xfs_file_dio_aio_read(iocb, to, rwf);
 	else
-		ret = xfs_file_buffered_aio_read(iocb, to);
+		ret = xfs_file_buffered_aio_read(iocb, to, rwf);
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a23720787f73..9e4f2ed9cfcf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1693,7 +1693,7 @@ struct file_operations {
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
+	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *, bool rwf);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
@@ -1759,9 +1759,9 @@ struct inode_operations {
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
-				     struct iov_iter *iter)
+				     struct iov_iter *iter, bool rwf)
 {
-	return file->f_op->read_iter(kio, iter);
+	return file->f_op->read_iter(kio, iter, rwf);
 }
 
 static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
@@ -2910,7 +2910,7 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
-extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
+extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *, bool rwf);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
@@ -2922,7 +2922,7 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
 
 /* fs/block_dev.c */
-extern ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to);
+extern ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf);
 extern ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from);
 extern int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 			int datasync);
diff --git a/mm/filemap.c b/mm/filemap.c
index 870971e20967..bd7ca92f208b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2185,12 +2185,13 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
  * generic_file_read_iter - generic filesystem read routine
  * @iocb:	kernel I/O control block
  * @iter:	destination for the data read
+ * @rwf:	i_rwsem taken exclusively
  *
  * This is the "read_iter()" routine for all filesystems
  * that can use the page cache directly.
  */
 ssize_t
-generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter, bool rwf)
 {
 	size_t count = iov_iter_count(iter);
 	ssize_t retval = 0;
diff --git a/mm/shmem.c b/mm/shmem.c
index 07a1d22807be..5ba4834d248f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2406,7 +2406,8 @@ shmem_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to,
+				    bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
diff --git a/net/socket.c b/net/socket.c
index c729625eb5d3..e9858b840f40 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -113,7 +113,7 @@ unsigned int sysctl_net_busy_read __read_mostly;
 unsigned int sysctl_net_busy_poll __read_mostly;
 #endif
 
-static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf);
 static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static int sock_mmap(struct file *file, struct vm_area_struct *vma);
 
@@ -870,7 +870,7 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 	return sock->ops->splice_read(sock, ppos, pipe, len, flags);
 }
 
-static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct file *file = iocb->ki_filp;
 	struct socket *sock = file->private_data;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2fec2feac387..1294aa7a1435 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3061,7 +3061,7 @@ static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
 	return result;
 }
 
-static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to, bool rwf)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

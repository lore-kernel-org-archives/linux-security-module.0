From: hw.likun@huawei.com (Li Kun)
Date: Thu, 11 May 2017 08:34:18 +0800
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <20170510064507.1764-2-hch@lst.de>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
Message-ID: <479df139-b2e4-07f8-c7bc-ae6734856ee5@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Why we don't make some rules like"the fs should use nested i_rwsem in 
read_iter" instead?

Although i think your approach is safer.


? 2017/5/10 14:45, Christoph Hellwig ??:
> Add a new ->integrity_read file operation to read data for
> integrity hash collection.  This is defined to be equivalent
> to ->read_iter, except that it will be called with the i_rwsem
> held exclusively.  Also the presence of ->integrity_read indicates
> that the file system can support IMA.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/file.c           |  1 +
>   fs/ext4/file.c            |  1 +
>   fs/xfs/xfs_file.c         | 21 +++++++++++++++++++++
>   include/linux/fs.h        |  1 +
>   security/integrity/iint.c | 20 ++++++++++++++------
>   5 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 520cb7230b2d..c5afb2264737 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3041,6 +3041,7 @@ const struct file_operations btrfs_file_operations = {
>   #endif
>   	.clone_file_range = btrfs_clone_file_range,
>   	.dedupe_file_range = btrfs_dedupe_file_range,
> +	.integrity_read = generic_file_read_iter,
>   };
>   
>   void btrfs_auto_defrag_exit(void)
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 8210c1f43556..b2a5025c7e0d 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -740,6 +740,7 @@ const struct file_operations ext4_file_operations = {
>   	.splice_read	= generic_file_splice_read,
>   	.splice_write	= iter_file_splice_write,
>   	.fallocate	= ext4_fallocate,
> +	.integrity_read	= ext4_file_read_iter,
>   };
>   
>   const struct inode_operations ext4_file_inode_operations = {
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 35703a801372..3d6ace2a79bc 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -288,6 +288,26 @@ xfs_file_read_iter(
>   	return ret;
>   }
>   
> +static ssize_t
> +xfs_integrity_read(
> +	struct kiocb		*iocb,
> +	struct iov_iter		*to)
> +{
> +	struct inode		*inode = file_inode(iocb->ki_filp);
> +	struct xfs_mount	*mp = XFS_I(inode)->i_mount;
> +
> +	lockdep_assert_held(&inode->i_rwsem);
> +
> +	XFS_STATS_INC(mp, xs_read_calls);
> +
> +	if (XFS_FORCED_SHUTDOWN(mp))
> +		return -EIO;
> +
> +	if (IS_DAX(inode))
> +		return dax_iomap_rw(iocb, to, &xfs_iomap_ops);
> +	return generic_file_read_iter(iocb, to);
> +}
> +
>   /*
>    * Zero any on disk space between the current EOF and the new, larger EOF.
>    *
> @@ -1534,6 +1554,7 @@ const struct file_operations xfs_file_operations = {
>   	.fallocate	= xfs_file_fallocate,
>   	.clone_file_range = xfs_file_clone_range,
>   	.dedupe_file_range = xfs_file_dedupe_range,
> +	.integrity_read	= xfs_integrity_read,
>   };
>   
>   const struct file_operations xfs_dir_file_operations = {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7251f7bb45e8..0c86816ca25f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1689,6 +1689,7 @@ struct file_operations {
>   			u64);
>   	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
>   			u64);
> +	ssize_t (*integrity_read)(struct kiocb *, struct iov_iter *);
>   };
>   
>   struct inode_operations {
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index c710d22042f9..c5489672b5aa 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -21,6 +21,7 @@
>   #include <linux/rbtree.h>
>   #include <linux/file.h>
>   #include <linux/uaccess.h>
> +#include <linux/uio.h>
>   #include "integrity.h"
>   
>   static struct rb_root integrity_iint_tree = RB_ROOT;
> @@ -184,18 +185,25 @@ security_initcall(integrity_iintcache_init);
>   int integrity_kernel_read(struct file *file, loff_t offset,
>   			  char *addr, unsigned long count)
>   {
> -	mm_segment_t old_fs;
> -	char __user *buf = (char __user *)addr;
> +	struct inode *inode = file_inode(file);
> +	struct iovec iov = { .iov_base = addr, .iov_len = count };
> +	struct kiocb kiocb;
> +	struct iov_iter iter;
>   	ssize_t ret;
>   
> +	lockdep_assert_held(&inode->i_rwsem);
> +
>   	if (!(file->f_mode & FMODE_READ))
>   		return -EBADF;
> +	if (!file->f_op->integrity_read)
> +		return -EBADF;
>   
> -	old_fs = get_fs();
> -	set_fs(get_ds());
> -	ret = __vfs_read(file, buf, count, &offset);
> -	set_fs(old_fs);
> +	init_sync_kiocb(&kiocb, file);
> +	kiocb.ki_pos = offset;
> +	iov_iter_init(&iter, READ | ITER_KVEC, &iov, 1, count);
>   
> +	ret = file->f_op->integrity_read(&kiocb, &iter);
> +	BUG_ON(ret == -EIOCBQUEUED);
>   	return ret;
>   }
>   

-- 
Best Regards
Li Kun

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

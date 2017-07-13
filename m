From: jack@suse.cz (Jan Kara)
Date: Thu, 13 Jul 2017 18:03:07 +0200
Subject: [PATCH v3 2/4] ima: use fs method to read integrity data
In-Reply-To: <1499954090-30054-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1499954090-30054-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1499954090-30054-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170713160307.GG5884@quack2.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu 13-07-17 09:54:48, Mimi Zohar wrote:
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index b21891a6bfca..d57c4259945d 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -219,6 +219,7 @@ const struct file_operations ext2_file_operations = {
>  	.get_unmapped_area = thp_get_unmapped_area,
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
> +	.integrity_read	= generic_file_read_iter,
>  };
>  
>  const struct inode_operations ext2_file_inode_operations = {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 831fd6beebf0..e7b2bd43cdc4 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -753,6 +753,7 @@ const struct file_operations ext4_file_operations = {
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= ext4_fallocate,
> +	.integrity_read	= ext4_file_read_iter,
>  };

I think both ext2 and ext4 need a bit more special handling (similarly to
XFS) due to DAX. E.g. ext4_dax_read_iter() will try to get i_rwsem which is
wrong for integrity_read handler as far as I understand.

> index c2062a108d19..9b49d09ba180 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1124,6 +1124,7 @@ const struct file_operations gfs2_file_fops = {
>  	.splice_write	= gfs2_file_splice_write,
>  	.setlease	= simple_nosetlease,
>  	.fallocate	= gfs2_fallocate,
> +	.integrity_read	= generic_file_read_iter,
>  };
>  
>  const struct file_operations gfs2_dir_fops = {
> @@ -1152,6 +1153,7 @@ const struct file_operations gfs2_file_fops_nolock = {
>  	.splice_write	= gfs2_file_splice_write,
>  	.setlease	= generic_setlease,
>  	.fallocate	= gfs2_fallocate,
> +	.integrity_read	= generic_file_read_iter,
>  };
>  
>  const struct file_operations gfs2_dir_fops_nolock = {
...
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index bfeb647459d9..2832a7c92acd 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2536,6 +2536,7 @@ const struct file_operations ocfs2_fops = {
>  	.fallocate	= ocfs2_fallocate,
>  	.clone_file_range = ocfs2_file_clone_range,
>  	.dedupe_file_range = ocfs2_file_dedupe_range,
> +	.integrity_read	= ocfs2_file_read_iter,
>  };
>  
>  const struct file_operations ocfs2_dops = {

For cluster filesystems like gfs2 or ocfs2 I actually wonder whether IMA
works as it should - without special cluster locking another node may be
modifying the file while you read it even when you hold i_rwsem. So don't
these filesystems need some special treatment?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

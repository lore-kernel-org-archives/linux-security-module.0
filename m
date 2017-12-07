From: jlayton@redhat.com (Jeff Layton)
Date: Thu, 07 Dec 2017 07:26:24 -0500
Subject: [RFC PATCH 2/4] ima: define new ima_sb_post_new_mount hook
In-Reply-To: <1502904620-20075-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502904620-20075-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1512649584.1350.14.camel@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-08-16 at 13:30 -0400, Mimi Zohar wrote:
> IMA measures a file, verifies a file's integrity, and caches the
> results.  On filesystems with MS_I_VERSION enabled, IMA can detect
> file changes and cause them to be re-measured and verified.  On
> filesystems without MS_I_VERSION enabled, files are measured and
> verified just once.
> 
> This patch logs filesystems mounted without MS_I_VERSION.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  include/linux/ima.h               |  5 +++++
>  security/integrity/ima/ima_main.c | 44 +++++++++++++++++++++++++++++++++++++++
>  security/security.c               |  1 +
>  3 files changed, 50 insertions(+)
> 

Sorry for the late review. I just started dusting off my i_version
rework, and noticed that IMA still has unaddressed problems here.

> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0e4647e0eb60..4475cb01149c 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -23,6 +23,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> +extern void ima_sb_post_new_mount(const struct vfsmount *newmnt,
> +				  const struct path *path);
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> @@ -65,6 +67,9 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  	return;
>  }
>  
> +static inline void ima_sb_post_new_mount(const struct vfsmount *newmnt,
> +					 const struct path *path)
> +{ }
>  #endif /* CONFIG_IMA */
>  
>  #ifndef CONFIG_IMA_KEXEC
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index b00186914df8..a0a685189001 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -354,6 +354,50 @@ void ima_post_path_mknod(struct dentry *dentry)
>  }
>  
>  /**
> + * ima_sb_post_new_mount - check filesystem mounted flags
> + *
> + * Indicate that filesystem isn't mounted with i_version enabled.
> + */
> +void ima_sb_post_new_mount(const struct vfsmount *newmnt,
> +			   const struct path *path)
> +{
> +	struct super_block *sb;
> +	unsigned long pseudo_fs[] = {CGROUP_SUPER_MAGIC, CGROUP2_SUPER_MAGIC,
> +		SYSFS_MAGIC, DEVPTS_SUPER_MAGIC, PSTOREFS_MAGIC, EFIVARFS_MAGIC,
> +		DEBUGFS_MAGIC, TMPFS_MAGIC};

Barf. What about procfs? This looks like something that will very
subject to bitrot.


> +	char *pathbuf = NULL;
> +	char filename[NAME_MAX];
> +	const char *pathname;
> +	bool found = 0;
> +	int i;
> +
> +	sb = newmnt ? newmnt->mnt_sb : path->mnt->mnt_sb;
> +
> +	if ((sb->s_flags & MS_I_VERSION) || (sb->s_flags & MS_RDONLY) ||
> +	    (sb->s_flags & MS_KERNMOUNT))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(pseudo_fs); i++) {
> +		if (pseudo_fs[i] != sb->s_magic)
> +			continue;
> +
> +		found = 1;
> +		break;
> +	}
> +	if (found)
> +		return;
> +
> +	pathname = ima_d_path(path, &pathbuf, filename);
> +	if (!pathname)
> +		return;
> +
> +	if (newmnt)
> +		pr_warn("ima: %s mounted without i_version enabled\n",
> +			pathname);
> +	 __putname(pathbuf);
> +}
> +
> +/**
>   * ima_read_file - pre-measure/appraise hook decision based on policy
>   * @file: pointer to the file to be measured/appraised/audit
>   * @read_id: caller identifier
> diff --git a/security/security.c b/security/security.c
> index 592153e8d2b6..79111141b383 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -402,6 +402,7 @@ void security_sb_post_new_mount(const struct vfsmount *newmnt,
>  				const struct path *path)
>  {
>  	call_void_hook(sb_post_new_mount, newmnt, path);
> +	ima_sb_post_new_mount(newmnt, path);
>  }
>  
>  int security_sb_umount(struct vfsmount *mnt, int flags)

Personally, I'm not a huge fan of this scheme. It seems quite invasive,
and doesn't really seem to address the stated problem well.

The warning itself seems ok, but I don't really see what's wrong with
performing remeasurement when the mtime changes on filesystems that
don't have SB_I_VERSION set. Surely that's better than limiting it to an
initial measurement?

Maybe I just don't understand what you're really trying to achieve here.
-- 
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: keescook@google.com (Kees Cook)
Date: Wed, 24 May 2017 12:27:49 -0700
Subject: [PATCH 1/3] securityfs: add the ability to support symlinks
In-Reply-To: <20170511024625.13887-2-john.johansen@canonical.com>
References: <20170511024625.13887-1-john.johansen@canonical.com>
	<20170511024625.13887-2-john.johansen@canonical.com>
Message-ID: <CAGXu5jKzruTtA8-cQALViKfL=txR=zKTO7jFhf9CTxWxHLjckQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 10, 2017 at 7:46 PM, John Johansen
<john.johansen@canonical.com> wrote:
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Seth Arnold <seth.arnold@canonical.com>

This looks correct to me; it matches what other pseudo-filesystems do,
and provides the expected interfaces.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h |  12 ++++
>  security/inode.c         | 140 +++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 134 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 78d8e03be5d3..28e2be5dd6df 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1645,6 +1645,10 @@ extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
>                                              struct dentry *parent, void *data,
>                                              const struct file_operations *fops);
>  extern struct dentry *securityfs_create_dir(const char *name, struct dentry *parent);
> +struct dentry *securityfs_create_symlink(const char *name,
> +                                        struct dentry *parent,
> +                                        const char *target,
> +                                        const struct inode_operations *iops);
>  extern void securityfs_remove(struct dentry *dentry);
>
>  #else /* CONFIG_SECURITYFS */
> @@ -1664,6 +1668,14 @@ static inline struct dentry *securityfs_create_file(const char *name,
>         return ERR_PTR(-ENODEV);
>  }
>
> +struct dentry *securityfs_create_symlink(const char *name,
> +                                        struct dentry *parent,
> +                                        const char *target,
> +                                        const struct inode_operations *iops)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline void securityfs_remove(struct dentry *dentry)
>  {}
>
> diff --git a/security/inode.c b/security/inode.c
> index 2cb14162ff8d..10c4955d0bed 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -26,11 +26,31 @@
>  static struct vfsmount *mount;
>  static int mount_count;
>
> +static void securityfs_evict_inode(struct inode *inode)
> +{
> +       truncate_inode_pages_final(&inode->i_data);
> +       clear_inode(inode);
> +       if (S_ISLNK(inode->i_mode))
> +               kfree(inode->i_link);
> +}
> +
> +static const struct super_operations securityfs_super_operations = {
> +       .statfs         = simple_statfs,
> +       .evict_inode    = securityfs_evict_inode,
> +};
> +
>  static int fill_super(struct super_block *sb, void *data, int silent)
>  {
>         static struct tree_descr files[] = {{""}};
> +       int error;
> +
> +       error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
> +       if (error)
> +               return error;
> +
> +       sb->s_op = &securityfs_super_operations;
>
> -       return simple_fill_super(sb, SECURITYFS_MAGIC, files);
> +       return 0;
>  }
>
>  static struct dentry *get_sb(struct file_system_type *fs_type,
> @@ -48,7 +68,7 @@ static struct file_system_type fs_type = {
>  };
>
>  /**
> - * securityfs_create_file - create a file in the securityfs filesystem
> + * securityfs_create_dentry - create a dentry in the securityfs filesystem
>   *
>   * @name: a pointer to a string containing the name of the file to create.
>   * @mode: the permission that the file should have
> @@ -60,34 +80,35 @@ static struct file_system_type fs_type = {
>   *        the open() call.
>   * @fops: a pointer to a struct file_operations that should be used for
>   *        this file.
> + * @iops: a point to a struct of inode_operations that should be used for
> + *        this file/dir
>   *
> - * This is the basic "create a file" function for securityfs.  It allows for a
> - * wide range of flexibility in creating a file, or a directory (if you
> - * want to create a directory, the securityfs_create_dir() function is
> - * recommended to be used instead).
> + * This is the basic "create a file/dir/symlink" function for
> + * securityfs.  It allows for a wide range of flexibility in creating
> + * a file, or a directory (if you want to create a directory, the
> + * securityfs_create_dir() function is recommended to be used
> + * instead).
>   *
>   * This function returns a pointer to a dentry if it succeeds.  This
> - * pointer must be passed to the securityfs_remove() function when the file is
> - * to be removed (no automatic cleanup happens if your module is unloaded,
> - * you are responsible here).  If an error occurs, the function will return
> - * the error value (via ERR_PTR).
> + * pointer must be passed to the securityfs_remove() function when the
> + * file is to be removed (no automatic cleanup happens if your module
> + * is unloaded, you are responsible here).  If an error occurs, the
> + * function will return the error value (via ERR_PTR).
>   *
>   * If securityfs is not enabled in the kernel, the value %-ENODEV is
>   * returned.
>   */
> -struct dentry *securityfs_create_file(const char *name, umode_t mode,
> -                                  struct dentry *parent, void *data,
> -                                  const struct file_operations *fops)
> +static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
> +                                       struct dentry *parent, void *data,
> +                                       const struct file_operations *fops,
> +                                       const struct inode_operations *iops)
>  {
>         struct dentry *dentry;
> -       int is_dir = S_ISDIR(mode);
>         struct inode *dir, *inode;
>         int error;
>
> -       if (!is_dir) {
> -               BUG_ON(!fops);
> +       if (!(mode & S_IFMT))
>                 mode = (mode & S_IALLUGO) | S_IFREG;
> -       }
>
>         pr_debug("securityfs: creating file '%s'\n",name);
>
> @@ -120,11 +141,14 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
>         inode->i_mode = mode;
>         inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
>         inode->i_private = data;
> -       if (is_dir) {
> +       if (S_ISDIR(mode)) {
>                 inode->i_op = &simple_dir_inode_operations;
>                 inode->i_fop = &simple_dir_operations;
>                 inc_nlink(inode);
>                 inc_nlink(dir);
> +       } else if (S_ISLNK(mode)) {
> +               inode->i_op = iops ? iops : &simple_symlink_inode_operations;
> +               inode->i_link = data;
>         } else {
>                 inode->i_fop = fops;
>         }
> @@ -141,6 +165,38 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
>         simple_release_fs(&mount, &mount_count);
>         return dentry;
>  }
> +
> +/**
> + * securityfs_create_file - create a file in the securityfs filesystem
> + *
> + * @name: a pointer to a string containing the name of the file to create.
> + * @mode: the permission that the file should have
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          file will be created in the root of the securityfs filesystem.
> + * @data: a pointer to something that the caller will want to get to later
> + *        on.  The inode.i_private pointer will point to this value on
> + *        the open() call.
> + * @fops: a pointer to a struct file_operations that should be used for
> + *        this file.
> + *
> + * This function creates a file in securityfs with the given @name.
> + *
> + * This function returns a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the securityfs_remove() function when the file is
> + * to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here).  If an error occurs, the function will return
> + * the error value (via ERR_PTR).
> + *
> + * If securityfs is not enabled in the kernel, the value %-ENODEV is
> + * returned.
> + */
> +struct dentry *securityfs_create_file(const char *name, umode_t mode,
> +                                     struct dentry *parent, void *data,
> +                                     const struct file_operations *fops)
> +{
> +       return securityfs_create_dentry(name, mode, parent, data, fops, NULL);
> +}
>  EXPORT_SYMBOL_GPL(securityfs_create_file);
>
>  /**
> @@ -172,6 +228,54 @@ struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
>  EXPORT_SYMBOL_GPL(securityfs_create_dir);
>
>  /**
> + * securityfs_create_symlink - create a symlink in the securityfs filesystem
> + *
> + * @name: a pointer to a string containing the name of the symlink to
> + *        create.
> + * @parent: a pointer to the parent dentry for the symlink.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          directory will be created in the root of the securityfs filesystem.
> + * @target: a pointer to a string containing the name of the symlink's target.
> + *          If this parameter is %NULL, then the @iops parameter needs to be
> + *          setup to handle .readlink and .get_link inode_operations.
> + * @iops: a pointer to the struct inode_operations to use for the symlink. If
> + *        this parameter is %NULL, then the default simple_symlink_inode
> + *        operations will be used.
> + *
> + * This function creates a symlink in securityfs with the given @name.
> + *
> + * This function returns a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the securityfs_remove() function when the file is
> + * to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here).  If an error occurs, the function will return
> + * the error value (via ERR_PTR).
> + *
> + * If securityfs is not enabled in the kernel, the value %-ENODEV is
> + * returned.
> + */
> +struct dentry *securityfs_create_symlink(const char *name,
> +                                        struct dentry *parent,
> +                                        const char *target,
> +                                        const struct inode_operations *iops)
> +{
> +       struct dentry *dent;
> +       char *link = NULL;
> +
> +       if (target) {
> +               link = kstrdup(target, GFP_KERNEL);
> +               if (!link)
> +                       return ERR_PTR(-ENOMEM);
> +       }
> +       dent = securityfs_create_dentry(name, S_IFLNK | S_IRUGO, parent,
> +                                       link, NULL, iops);
> +       if (IS_ERR(dent))
> +               kfree(link);
> +
> +       return dent;
> +}
> +EXPORT_SYMBOL_GPL(securityfs_create_symlink);
> +
> +/**
>   * securityfs_remove - removes a file or directory from the securityfs filesystem
>   *
>   * @dentry: a pointer to a the dentry of the file or directory to be removed.
> --
> 2.11.0
>



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

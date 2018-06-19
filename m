From: paul@paul-moore.com (Paul Moore)
Date: Tue, 19 Jun 2018 13:15:24 -0400
Subject: [PATCH 07/13] selinux: Cleanup printk logging in selinuxfs
In-Reply-To: <20180612080912.7827-8-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
	<20180612080912.7827-8-peter.enderborg@sony.com>
Message-ID: <CAHC9VhT_FRmjXe_6_t+FS3OvPKQTX91dzLK3=nVvJ3aPAohZcA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/selinuxfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c0cadbc5f85c..2adfade99945 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -620,7 +620,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> +               pr_err("SELinux: %s:  context size (%u) exceeds "
>                         "payload max\n", __func__, len);
>                 goto out;
>         }
> @@ -956,7 +956,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> +               pr_err("SELinux: %s:  context size (%u) exceeds "
>                         "payload max\n", __func__, len);
>                 goto out;
>         }
> @@ -1147,7 +1147,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>
>         length = -ERANGE;
>         if (len > SIMPLE_TRANSACTION_LIMIT) {
> -               printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
> +               pr_err("SELinux: %s:  context size (%u) exceeds "
>                         "payload max\n", __func__, len);
>                 goto out;
>         }
> @@ -1996,7 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>                 goto err;
>         return 0;
>  err:
> -       printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
> +       pr_err("SELinux: %s:  failed while creating inodes\n",
>                 __func__);
>
>         selinux_fs_info_free(sb);
> @@ -2046,7 +2046,7 @@ static int __init init_sel_fs(void)
>
>         selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
>         if (IS_ERR(selinuxfs_mount)) {
> -               printk(KERN_ERR "selinuxfs:  could not mount!\n");
> +               pr_err("selinuxfs:  could not mount!\n");
>                 err = PTR_ERR(selinuxfs_mount);
>                 selinuxfs_mount = NULL;
>         }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

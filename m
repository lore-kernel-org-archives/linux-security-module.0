From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 30 Mar 2017 12:10:44 -0700
Subject: [PATCH RFC 1/4] proc: add proc_fs_info struct to store proc
	options
In-Reply-To: <1490887379-25880-2-git-send-email-tixxdz@gmail.com>
References: <1490887379-25880-1-git-send-email-tixxdz@gmail.com>
	<1490887379-25880-2-git-send-email-tixxdz@gmail.com>
Message-ID: <CALCETrUG2Smb-+SWKphnB_oMFakZn9AuJDa7WeahnN9hBoENTQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 30, 2017 at 8:22 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
> This is a preparation patch that adds a proc_fs_info to be able to store
> different procfs options. Right now some mount options are stored inside
> the pid namespace which make multiple proc share the same mount options.
> This patch will help also to fix this.
>
> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>

>  static struct dentry *proc_mount(struct file_system_type *fs_type,
>         int flags, const char *dev_name, void *data)
>  {
> +       int error;
> +       struct super_block *sb;
>         struct pid_namespace *ns;
> +       struct proc_fs_info *fs_info;
> +
> +       if (!(flags & MS_KERNMOUNT) && !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +               return ERR_PTR(-EPERM);

Why is this check needed?

> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 2d2bf59..e1cb9c3 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -6,11 +6,27 @@
>
>  #include <linux/types.h>
>  #include <linux/fs.h>
> +#include <linux/refcount.h>
> +
> +enum {
> +       PROC_FS_V1      = 1,
> +       PROC_FS_V2      = 2,
> +};
> +
> +struct proc_fs_info {
> +       refcount_t users;
> +       struct pid_namespace *pid_ns;
> +       kgid_t pid_gid;
> +       int hide_pid;
> +       int version;
> +};

What is version?

Should this patch have just users and pid_ns and move the other stuff
to patch 2?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: tixxdz@gmail.com (Djalal Harouni)
Date: Sun, 12 Mar 2017 22:12:49 +0100
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <1489293685-53257-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1489293685-53257-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <CAEiveUfGHiz_oXgG9cscOF3ErdH9DJtp5zRxyCW+QbpzpYqc1w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On Sun, Mar 12, 2017 at 5:41 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Now that security_task_alloc() hook and "struct task_struct"->security
> field are revived, switch TOMOYO to use them because TOMOYO's security
> context is defined based on "struct task_struct" rather than "struct cred".
>
> By applying this patch, TOMOYO no longer uses "struct cred"->security
> which means that TOMOYO is ready for running with other fully armored LSM
> modules which use "struct cred"->security field.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/common.h        |  18 ++++++-
>  security/tomoyo/domain.c        |   8 ++-
>  security/tomoyo/gc.c            |   6 +--
>  security/tomoyo/securityfs_if.c |  22 ++++----
>  security/tomoyo/tomoyo.c        | 112 +++++++++++++++++++---------------------
>  5 files changed, 86 insertions(+), 80 deletions(-)
>
> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 361e7a2..db476e1 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -911,6 +911,11 @@ struct tomoyo_policy_namespace {
>         const char *name;
>  };
>
> +struct tomoyo_security {
> +       struct tomoyo_domain_info *tomoyo_domain_info;
> +       struct tomoyo_domain_info *saved_domain_info; /* Maybe NULL. */
> +};
> +
>  /********** Function prototypes. **********/
>
>  bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
> @@ -1202,7 +1207,16 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
>   */
>  static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -       return current_cred()->security;
> +       struct tomoyo_security *ts = current->security;
> +
> +       if (ts->saved_domain_info && !current->in_execve) {
> +               struct tomoyo_domain_info *domain = ts->tomoyo_domain_info;
> +
> +               ts->tomoyo_domain_info = ts->saved_domain_info;
> +               ts->saved_domain_info = NULL;
> +               atomic_dec(&domain->users);
> +       }
> +       return ts->tomoyo_domain_info;
>  }
>
>  /**
> @@ -1215,7 +1229,7 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
>                                                             *task)
>  {
> -       return task_cred_xxx(task, security);
> +       return ((struct tomoyo_security *) task->security)->tomoyo_domain_info;
>  }
>
>  /**
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index 00d223e..9f981d8 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -677,6 +677,7 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
>   */
>  int tomoyo_find_next_domain(struct linux_binprm *bprm)
>  {
> +       struct tomoyo_security *ts = current->security;
>         struct tomoyo_domain_info *old_domain = tomoyo_domain();
>         struct tomoyo_domain_info *domain = NULL;
>         const char *original_name = bprm->filename;
> @@ -841,8 +842,11 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>         if (!domain)
>                 domain = old_domain;
>         /* Update reference count on "struct tomoyo_domain_info". */
> -       atomic_inc(&domain->users);
> -       bprm->cred->security = domain;
> +       if (domain != ts->tomoyo_domain_info) {
> +               atomic_inc(&domain->users);
> +               ts->saved_domain_info = ts->tomoyo_domain_info;
> +               ts->tomoyo_domain_info = domain;
> +       }
>         kfree(exename.name);
>         if (!retval) {
>                 ee->r.domain = domain;
> diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
> index 540bc29..75ae368 100644
> --- a/security/tomoyo/gc.c
> +++ b/security/tomoyo/gc.c
> @@ -248,8 +248,8 @@ static inline void tomoyo_del_domain(struct list_head *element)
>         struct tomoyo_acl_info *tmp;
>         /*
>          * Since this domain is referenced from neither
> -        * "struct tomoyo_io_buffer" nor "struct cred"->security, we can delete
> -        * elements without checking for is_deleted flag.
> +        * "struct tomoyo_io_buffer" nor "struct tomoyo_security",
> +        * we can delete elements without checking for is_deleted flag.
>          */
>         list_for_each_entry_safe(acl, tmp, &domain->acl_info_list, list) {
>                 tomoyo_del_acl(&acl->list);
> @@ -433,7 +433,7 @@ static void tomoyo_try_to_gc(const enum tomoyo_policy_id type,
>                 break;
>         case TOMOYO_ID_DOMAIN:
>                 /*
> -                * Don't kfree() until all "struct cred"->security forget this
> +                * Don't kfree() until all "struct tomoyo_security" forget this
>                  * element.
>                  */
>                 if (atomic_read(&container_of
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 06ab41b1..988261a 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/security.h>
> +#include <linux/lsm_hooks.h> /* security_module_enable() */
>  #include "common.h"
>
>  /**
> @@ -66,18 +67,13 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
>                         if (!new_domain) {
>                                 error = -ENOENT;
>                         } else {
> -                               struct cred *cred = prepare_creds();
> -                               if (!cred) {
> -                                       error = -ENOMEM;
> -                               } else {
> -                                       struct tomoyo_domain_info *old_domain =
> -                                               cred->security;
> -                                       cred->security = new_domain;
> -                                       atomic_inc(&new_domain->users);
> -                                       atomic_dec(&old_domain->users);
> -                                       commit_creds(cred);
> -                                       error = 0;
> -                               }
> +                               struct tomoyo_domain_info *old_domain =
> +                                       tomoyo_domain();
> +                               ((struct tomoyo_security *) current->security)
> +                                       ->tomoyo_domain_info = new_domain;
> +                               atomic_inc(&new_domain->users);
> +                               atomic_dec(&old_domain->users);
> +                               error = 0;
>                         }
>                 }
>                 tomoyo_read_unlock(idx);
> @@ -236,7 +232,7 @@ static int __init tomoyo_initerface_init(void)
>         struct dentry *tomoyo_dir;
>
>         /* Don't create securityfs entries unless registered. */
> -       if (current_cred()->security != &tomoyo_kernel_domain)
> +       if (!security_module_enable("tomoyo"))
>                 return 0;
>
>         tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index b5fb930..0de150d 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -8,59 +8,42 @@
>  #include "common.h"
>
>  /**
> - * tomoyo_cred_alloc_blank - Target for security_cred_alloc_blank().
> + * tomoyo_task_alloc - Target for security_task_alloc().
>   *
> - * @new: Pointer to "struct cred".
> - * @gfp: Memory allocation flags.
> + * @task: Pointer to "struct task_struct".
> + * @clone_flags: Not used.
>   *
> - * Returns 0.
> - */
> -static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
> -{
> -       new->security = NULL;
> -       return 0;
> -}
> -
> -/**
> - * tomoyo_cred_prepare - Target for security_prepare_creds().
> - *
> - * @new: Pointer to "struct cred".
> - * @old: Pointer to "struct cred".
> - * @gfp: Memory allocation flags.
> - *
> - * Returns 0.
> + * Returns 0 on success, negative value otherwise.
>   */
> -static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
> -                              gfp_t gfp)
> +static int tomoyo_task_alloc(struct task_struct *task,
> +                            unsigned long clone_flags)
>  {
> -       struct tomoyo_domain_info *domain = old->security;
> -       new->security = domain;
> -       if (domain)
> -               atomic_inc(&domain->users);
> +       struct tomoyo_security *ts = kzalloc(sizeof(*ts), GFP_KERNEL);
> +       struct tomoyo_domain_info *domain = tomoyo_domain();
> +
> +       if (!ts)
> +               return -ENOMEM;
> +       ts->tomoyo_domain_info = domain;
> +       atomic_inc(&domain->users);
> +       task->security = ts;

Is it possible to adapt some stacking bits from Casey's patches and
stack this security field ? or at least try first to stack
task->security without having to stack all the others cred->security,
inode->security ... ?

IMO it would be better if the first LSM user gets this right, or at
least the second LSM that uses the field without having to wait for
the support of all security fields stacking. IMHO having some support
is better then waiting for 100% stacking support, this may improve the
situation a bit. It will make it deadly easy to add more minor
per-task context LSMs, and it allows to protect some users (containers
that may disable global LSMs protections) from certain
vulnerabilities. At same time I'm missing lot of bits here and sure
Casey knows better if this is possible or not  ?



>         return 0;
>  }
>
>  /**

Thanks!

-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

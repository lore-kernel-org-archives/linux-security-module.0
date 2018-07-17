From: keescook@chromium.org (Kees Cook)
Date: Tue, 17 Jul 2018 13:19:27 -0700
Subject: [PATCH] security: Add LSM fixup hooks to set*gid syscalls.
In-Reply-To: <CAJ-EccNh5B84yowXL4u5-X8m-jYhOtuRwBOmstUnCB5Tc74dBg@mail.gmail.com>
References: <CAJ-EccNh5B84yowXL4u5-X8m-jYhOtuRwBOmstUnCB5Tc74dBg@mail.gmail.com>
Message-ID: <CAGXu5j+ha--Hw_o0W9A5VKqXgy3nXuxU9+049akj9=dA0KdMRw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 17, 2018 at 8:05 AM, Micah Morton <mortonm@chromium.org> wrote:
> The set*uid system calls all call an LSM fixup hook called
> security_task_fix_setuid, which allows for altering the behavior of those
> calls by a security module. Comments explaining the LSM_SETID_* constants
> in /include/linux/security.h imply that the constants are to be used for
> both the set*uid and set*gid syscalls, but the set*gid syscalls do not
> have the relevant hooks, meaning a security module can only alter syscalls
> that change user identity attributes but not ones that change group
> identity attributes. This patch adds the necessary LSM hook, called
> security_task_fix_setgid, and calls the hook from the appropriate places
> in the set*gid syscalls.Tested by putting a print statement in the hook and
> seeing it triggered from the various set*gid syscalls.
>
> Signed-off-by: Micah Morton <mortonm@chromium.org>

Sounds reasonable to me! :)

nits below...

> ---
> NOTE: the security_task_fix_setgid line in sys_setfsgid is over 80
> characters, but I figured I'd just follow how it was done in sys_setfsuid
> rather than trying to wrap the line, since the functions are nearly
> identical.
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 8f1131c8dd54..52f40d7cff02 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -599,6 +599,15 @@
>   * @old is the set of credentials that are being replaces
>   * @flags contains one of the LSM_SETID_* values.
>   * Return 0 on success.
> + * @task_fix_setgid:
> + *     Update the module's state after setting one or more of the group
> + *     identity attributes of the current process.  The @flags parameter
> + *     indicates which of the set*gid system calls invoked this hook.
> + *     @new is the set of credentials that will be installed. Modifications
> + *     should be made to this rather than to @current->cred.
> + *     @old is the set of credentials that are being replaced
> + *     @flags contains one of the LSM_SETID_* values.
> + *     Return 0 on success.
>   * @task_setpgid:
>   * Check permission before setting the process group identifier of the
>   * process @p to @pgid.
> @@ -1587,6 +1596,8 @@ union security_list_options {
>        enum kernel_read_file_id id);
>   int (*task_fix_setuid)(struct cred *new, const struct cred *old,
>   int flags);
> +        int (*task_fix_setgid)(struct cred *new, const struct cred *old,
> +                                int flags);

Unexpected indentation?

>   int (*task_setpgid)(struct task_struct *p, pid_t pgid);
>   int (*task_getpgid)(struct task_struct *p);
>   int (*task_getsid)(struct task_struct *p);
> @@ -1876,6 +1887,7 @@ struct security_hook_heads {
>   struct hlist_head kernel_post_read_file;
>   struct hlist_head kernel_module_request;
>   struct hlist_head task_fix_setuid;
> +        struct hlist_head task_fix_setgid;

Same?

Also, I think this needs a LSM_HOOK_INIT call somewhere too?

>   struct hlist_head task_setpgid;
>   struct hlist_head task_getpgid;
>   struct hlist_head task_getsid;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 63030c85ee19..a82d97cf13ab 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -325,6 +325,8 @@ int security_kernel_post_read_file(struct file *file,
> char *buf, loff_t size,
>      enum kernel_read_file_id id);
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>        int flags);
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +      int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
>  int security_task_getsid(struct task_struct *p);
> @@ -929,6 +931,13 @@ static inline int security_task_fix_setuid(struct cred
> *new,
>   return cap_task_fix_setuid(new, old, flags);
>  }
>
> +static inline int security_task_fix_setgid(struct cred *new,
> +    const struct cred *old,
> +    int flags)
> +{
> + return 0;
> +}
> +
>  static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>   return 0;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 38509dc1f77b..f6ef922c6815 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>   new->sgid = new->egid;
>   new->fsgid = new->egid;
>
> + retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
> + if (retval < 0)
> + goto error;
> +
>   return commit_creds(new);
>
>  error:
> @@ -434,6 +438,10 @@ long __sys_setgid(gid_t gid)
>   else
>   goto error;
>
> + retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
> + if (retval < 0)
> + goto error;
> +
>   return commit_creds(new);
>
>  error:
> @@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t
> sgid)
>   new->sgid = ksgid;
>   new->fsgid = new->egid;
>
> + retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
> + if (retval < 0)
> + goto error;
> +
>   return commit_creds(new);
>
>  error:
> @@ -861,7 +873,8 @@ long __sys_setfsgid(gid_t gid)
>       ns_capable(old->user_ns, CAP_SETGID)) {
>   if (!gid_eq(kgid, old->fsgid)) {
>   new->fsgid = kgid;
> - goto change_okay;
> + if (security_task_fix_setgid(new, old, LSM_SETID_FS) == 0)
> + goto change_okay;
>   }
>   }
>
> diff --git a/security/security.c b/security/security.c
> index 68f46d849abe..587786fc0aaa 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1062,6 +1062,12 @@ int security_task_fix_setuid(struct cred *new, const
> struct cred *old,
>   return call_int_hook(task_fix_setuid, 0, new, old, flags);
>  }
>
> +int security_task_fix_setgid(struct cred *new, const struct cred *old,
> +      int flags)
> +{
> + return call_int_hook(task_fix_setgid, 0, new, old, flags);
> +}
> +
>  int security_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>   return call_int_hook(task_setpgid, 0, p, pgid);
>
> --
> 4.18-rc2
>
> --

Otherwise looks good!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: jobol@nonadev.net (=?UTF-8?B?Sm9zw6k=?= Bollo)
Date: Fri, 24 Mar 2017 13:11:44 +0100
Subject: [PATCH] LSM: Revive security_task_alloc() hook and per "struct
	task_struct" security blob.
In-Reply-To: <1490355993-15773-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1490355993-15773-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <20170324131144.3ef645b6@d-jobol.iot.bzh>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 24 Mar 2017 20:46:33 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> We switched from "struct task_struct"->security to "struct
> cred"->security in Linux 2.6.29. But not all LSM modules were happy
> with that change. TOMOYO LSM module is an example which want to use
> per "struct task_struct" security blob, for TOMOYO's security context
> is defined based on "struct task_struct" rather than "struct cred".
> AppArmor LSM module is another example which want to use it, for
> AppArmor is currently abusing the cred a little bit to store the
> change_hat and setexeccon info. Although security_task_free() hook
> was revived in Linux 3.4 because Yama LSM module wanted to release
> per "struct task_struct" security blob, security_task_alloc() hook
> and "struct task_struct"->security field were not revived. Nowadays,
> we are getting proposals of lightweight LSM modules which want to use
> per "struct task_struct" security blob. PTAGS LSM module and CaitSith
> LSM module which are currently under proposal for inclusion also want
> to use it. Therefore, it will be time to revive security_task_alloc()
> hook and "struct task_struct"->security field.
> 
> We are already allowing multiple concurrent LSM modules (up to one
> fully armored module which uses "struct cred"->security field or
> exclusive hooks like security_xfrm_state_pol_flow_match(), plus
> unlimited number of lightweight modules which do not use "struct
> cred"->security nor exclusive hooks) as long as they are built into
> the kernel. But this patch does not implement variable length "struct
> task_struct"->security field which will become needed when multiple
> LSM modules want to use "struct task_struct"-> security field.
> Although it won't be difficult to implement variable length "struct
> task_struct"->security field, let's think about it after we merged
> this patch.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Jos? Bollo <jobol@nonadev.net>

(if it cares ;)

Also below, I expect in some future that task_alloc and task_create
will be merged. IMHO not allocating the task is of less importance than
having a simple and unique hook. Statistically the normal is "the
task is allowed" so the cost of creating the task structure for
nothing is only relevant in cases where efficiency is just not expected.


> Tested-by: Djalal Harouni <tixxdz@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Jos? Bollo <jobol@nonadev.net>
> ---
>  include/linux/init_task.h | 7 +++++++
>  include/linux/lsm_hooks.h | 9 ++++++++-
>  include/linux/sched.h     | 4 ++++
>  include/linux/security.h  | 7 +++++++
>  kernel/fork.c             | 7 ++++++-
>  security/security.c       | 5 +++++
>  6 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> index 91d9049..926f2f5 100644
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -210,6 +210,12 @@
>  # define INIT_TASK_TI(tsk)
>  #endif
>  
> +#ifdef CONFIG_SECURITY
> +#define INIT_TASK_SECURITY .security = NULL,
> +#else
> +#define INIT_TASK_SECURITY
> +#endif
> +
>  /*
>   *  INIT_TASK is used to set up the first task table, touch at
>   * your own risk!. Base=0, limit=0x1fffff (=2MB)
> @@ -288,6 +294,7 @@
>  	INIT_VTIME(tsk)
> \ INIT_NUMA_BALANCING(tsk)					\
>  	INIT_KASAN(tsk)
> \
> +
> INIT_TASK_SECURITY						\ }
>  
>  
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 54191cf..865c11d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -533,8 +533,13 @@
>   *	manual page for definitions of the @clone_flags.
>   *	@clone_flags contains the flags indicating what should be
> shared.
>   *	Return 0 if permission is granted.
> + * @task_alloc:
> + *	@task task being allocated.
> + *	@clone_flags contains the flags indicating what should be
> shared.
> + *	Handle allocation of task-related resources.
> + *	Returns a zero on success, negative values on failure.
>   * @task_free:
> - *	@task task being freed
> + *	@task task about to be freed.
>   *	Handle release of task-related resources. (Note that this
> can be called
>   *	from interrupt context.)
>   * @cred_alloc_blank:
> @@ -1482,6 +1487,7 @@
>  	int (*file_open)(struct file *file, const struct cred *cred);
>  
>  	int (*task_create)(unsigned long clone_flags);
> +	int (*task_alloc)(struct task_struct *task, unsigned long
> clone_flags); void (*task_free)(struct task_struct *task);
>  	int (*cred_alloc_blank)(struct cred *cred, gfp_t gfp);
>  	void (*cred_free)(struct cred *cred);
> @@ -1748,6 +1754,7 @@ struct security_hook_heads {
>  	struct list_head file_receive;
>  	struct list_head file_open;
>  	struct list_head task_create;
> +	struct list_head task_alloc;
>  	struct list_head task_free;
>  	struct list_head cred_alloc_blank;
>  	struct list_head cred_free;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d67eee8..71b8df3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1038,6 +1038,10 @@ struct task_struct {
>  	/* A live task holds one reference: */
>  	atomic_t			stack_refcount;
>  #endif
> +#ifdef CONFIG_SECURITY
> +	/* Used by LSM modules for access restriction: */
> +	void				*security;
> +#endif
>  	/* CPU-specific state of this task: */
>  	struct thread_struct		thread;
>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 97df7ba..af675b5 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -308,6 +308,7 @@ int security_file_send_sigiotask(struct
> task_struct *tsk, int security_file_receive(struct file *file);
>  int security_file_open(struct file *file, const struct cred *cred);
>  int security_task_create(unsigned long clone_flags);
> +int security_task_alloc(struct task_struct *task, unsigned long
> clone_flags); void security_task_free(struct task_struct *task);
>  int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
>  void security_cred_free(struct cred *cred);
> @@ -861,6 +862,12 @@ static inline int security_task_create(unsigned
> long clone_flags) return 0;
>  }
>  
> +static inline int security_task_alloc(struct task_struct *task,
> +				      unsigned long clone_flags)
> +{
> +	return 0;
> +}
> +
>  static inline void security_task_free(struct task_struct *task)
>  { }
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6c463c80..3d32513 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1679,9 +1679,12 @@ static __latent_entropy struct task_struct
> *copy_process( goto bad_fork_cleanup_perf;
>  	/* copy all the process information */
>  	shm_init_task(p);
> -	retval = copy_semundo(clone_flags, p);
> +	retval = security_task_alloc(p, clone_flags);
>  	if (retval)
>  		goto bad_fork_cleanup_audit;
> +	retval = copy_semundo(clone_flags, p);
> +	if (retval)
> +		goto bad_fork_cleanup_security;
>  	retval = copy_files(clone_flags, p);
>  	if (retval)
>  		goto bad_fork_cleanup_semundo;
> @@ -1903,6 +1906,8 @@ static __latent_entropy struct task_struct
> *copy_process( exit_files(p); /* blocking */
>  bad_fork_cleanup_semundo:
>  	exit_sem(p);
> +bad_fork_cleanup_security:
> +	security_task_free(p);
>  bad_fork_cleanup_audit:
>  	audit_free(p);
>  bad_fork_cleanup_perf:
> diff --git a/security/security.c b/security/security.c
> index 45af8fb..8c62fc3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -946,6 +946,11 @@ int security_task_create(unsigned long
> clone_flags) return call_int_hook(task_create, 0, clone_flags);
>  }
>  
> +int security_task_alloc(struct task_struct *task, unsigned long
> clone_flags) +{
> +	return call_int_hook(task_alloc, 0, task, clone_flags);
> +}
> +
>  void security_task_free(struct task_struct *task)
>  {
>  	call_void_hook(task_free, task);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

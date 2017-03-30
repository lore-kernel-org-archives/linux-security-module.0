From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 30 Mar 2017 08:06:16 -0700
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <201703302009.HFI48472.MOFJOQStHFVOLF@I-love.SAKURA.ne.jp>
References: <1490698960-29861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<0dbdca69-ae69-a07e-957a-246d3e7532f2@schaufler-ca.com>
	<201703302009.HFI48472.MOFJOQStHFVOLF@I-love.SAKURA.ne.jp>
Message-ID: <c0e1918a-a483-23b7-2bef-871082f80e10@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/30/2017 4:09 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 3/28/2017 4:02 AM, Tetsuo Handa wrote:
>>> Now that security_task_alloc() hook and "struct task_struct"->security
>>> field are revived, switch TOMOYO to use them because TOMOYO's security
>>> context is defined based on "struct task_struct" rather than "struct cred".
>>>
>>> By applying this patch, TOMOYO no longer uses "struct cred"->security
>>> which means that TOMOYO is ready for running with other fully armored LSM
>>> modules which use "struct cred"->security field.
>> Are you planning to come up with a way to enable
>> TOMOYO at the same time as "fully armored" modules?
>> I don't think it would be right to use the "minor"
>> module (e.g. Yama) scheme, as you are using a blob.
>> The "extreme" stacking that I've been working on
>> will take care of this, but you may become impatient
>> if that takes as long to land as I fear it might.
> I'm not trying to remove security_module_enable() call from TOMOYO.

OK, great.

> What does the "minor" module (e.g. Yama) scheme mean?

Calling tomoyo_init_hooks() in security_init().

> Even though TOMOYO uses per "struct task_struct" blob, TOMOYO can
> start running with any other LSM modules by applying below change.
> What are you worrying about?

Until such time as a blob sharing scheme, either the one
I've been working on, yours below or something else, is
adopted, and until another module starts using the task
blob, you could use TOMOYO with any other module. The
existing model for choosing a "major" module does not
allow for TOMOYO+AppArmor. Ignoring the blob management
issue, how would you suggest enabling TOMOYO+AppArmor? 

> If we want per LSM module per "struct task_struct" blob before
> TOMOYO is converted to use per "struct task_struct" blob, I'm ready to
> propose that part (picked up from below change) first.

I suggest that the best thing to do regarding the task blob
is to adopt a general blob sharing scheme that is useful for
all of the blobs rather than inventing a special one for TOMOYO.

>
> >From a6c16d77c2b0a454adb8274b61562fb3edcaeee4 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 30 Mar 2017 19:59:54 +0900
> Subject: [PATCH] LSM: Allow per LSM module per "struct task_struct" blob.
>
> Since several modules are planning to use per "struct task_struct" blob,
> we will need a layer for isolating it in the not too distant future.
> Therefore, this patch introduces per LSM module per "struct task_struct"
> blob and converts TOMOYO to use the isolated blob.
>
> It would be possible to remember location in security_hook_heads.task_alloc
> list and undo up to the corresponding security_hook_heads.task_free list
> when task_alloc hook failed. But this patch calls all task_free hooks
> without checking whether the corresponding task_free hook was called
> due to reasons described below.
>
>   SELinux will not call task_free because SELinux will start using
>   task_alloc for permission check rather than initialize security blob,
>   but permission check for creating a thread unlikely returns an error.
>
>   Yama is safe to call task_free even if security blob was not allocated
>   because Yama does not call task_alloc hook.
>
>   TOMOYO will no longer return an error from task_alloc hook because memory
>   is already allocated before calling each module's task_alloc hook.
>
>   TOMOYO can detect task_free call without corresponding task_alloc call
>   because "struct tomoyo_security" is initialized with 0 when memory is
>   allocated before calling each module's task_alloc hook. This applies to
>   any future modules; module foo can check whether corresponding task_alloc
>   was called by embedding a boolean flag into "struct foo_blob" for module
>   foo which tells whether "struct foo_blob" is initialized.
>
> How to calculate amount of needed bytes and allocate memory for initial
> task is a chicken-or-egg syndrome. We need to know how many bytes needs
> to be allocated for initial task's security blobs before security_init()
> is called. But security_reserve_task_blob_index() which calculates amount
> of needed bytes is called from security_init(). We will need to split
> module registration into three steps. The first step is call
> security_reserve_task_blob_index() on all modules which should be
> activated. The second step is allocate memory for the initial task's
> security blob. The third step is actually activate all modules which
> should be activated. Or maybe we can allocate memory with a worst case
> estimation before calling security_init() because wasting some memory
> for initial task would be tolerable. But since currently only TOMOYO
> needs to allocate memory and initialize it for initial task, and
> initialization is not a heavy operation, this patch makes TOMOYO to
> initialize "struct tomoyo_security" for initial task when needed.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/lsm_hooks.h       |  36 ++++++++++-
>  security/security.c             |  37 +++++++++++-
>  security/tomoyo/common.h        |  49 ++++++++++++++-
>  security/tomoyo/domain.c        |   8 ++-
>  security/tomoyo/gc.c            |   6 +-
>  security/tomoyo/securityfs_if.c |  22 +++----
>  security/tomoyo/tomoyo.c        | 129 ++++++++++++++++++++--------------------
>  7 files changed, 201 insertions(+), 86 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 080f34e..ca19cdb 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -27,6 +27,7 @@
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/rculist.h>
> +#include <linux/sched.h> /* "struct task_struct" */
>  
>  /**
>   * Security hooks for program execution operations.
> @@ -536,7 +537,10 @@
>   * @task_alloc:
>   *	@task task being allocated.
>   *	@clone_flags contains the flags indicating what should be shared.
> - *	Handle allocation of task-related resources.
> + *	Handle allocation of task-related resources. Note that task_free is
> + *	called even if task_alloc failed. This means that all task_free users
> + *	have to be prepared for task_free being called without corresponding
> + *	task_alloc call.
>   *	Returns a zero on success, negative values on failure.
>   * @task_free:
>   *	@task task about to be freed.
> @@ -1947,4 +1951,34 @@ static inline void __init yama_add_hooks(void) { }
>  static inline void loadpin_add_hooks(void) { };
>  #endif
>  
> +/*
> + * Per "struct task_struct" security blob is managed using index numbers.
> + *
> + * Any user who wants to use per "struct task_struct" security blob reserves an
> + * index number using security_reserve_task_blob_index() before calling
> + * security_add_hooks().
> + *
> + * security_reserve_task_blob_index() returns an index number which has to be
> + * passed to task_security() by that user when fetching security blob of given
> + * "struct task_struct" for that user.
> + *
> + * Security blob for newly allocated "struct task_struct" is allocated and
> + * initialized with 0 inside security_task_alloc(), before calling each user's
> + * task_alloc hook. Be careful with task_free hook, for security_task_free()
> + * can be called when calling each user's task_alloc hook failed.
> + *
> + * Note that security_reserve_task_blob_index() uses "u16". It is not a good
> + * idea to directly reserve large amount. Sum of reserved amount by all users
> + * should be less than PAGE_SIZE bytes, for per "struct task_struct" security
> + * blob is allocated for each "struct task_struct" using kcalloc().
> + */
> +extern u16 __init security_reserve_task_blob_index(const u16 size);
> +static inline void *task_security(const struct task_struct *task,
> +				  const u16 index)
> +{
> +	unsigned long *p = task->security;
> +
> +	return p + index;
> +}
> +
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 549bddc..4dc6bca 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,6 +32,7 @@
>  /* Maximum number of letters for an LSM name string */
>  #define SECURITY_NAME_MAX	10
>  
> +static u16 lsm_max_per_task_blob_index __ro_after_init;
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  char *lsm_names;
>  /* Boot-time LSM user choice */
> @@ -75,6 +76,15 @@ int __init security_init(void)
>  	 */
>  	do_security_initcalls();
>  
> +	/*
> +	 * Allocate per "struct task_struct" blob for initial task.
> +	 * Initialization is done later by each module which needs it.
> +	 */
> +	if (lsm_max_per_task_blob_index)
> +		current->security = kcalloc(lsm_max_per_task_blob_index,
> +					    sizeof(unsigned long),
> +					    GFP_KERNEL | __GFP_NOFAIL);
> +
>  	return 0;
>  }
>  
> @@ -86,6 +96,15 @@ static int __init choose_lsm(char *str)
>  }
>  __setup("security=", choose_lsm);
>  
> +u16 __init security_reserve_task_blob_index(const u16 size)
> +{
> +	const u16 index = lsm_max_per_task_blob_index;
> +	u16 requested = DIV_ROUND_UP(size, sizeof(unsigned long));
> +
> +	lsm_max_per_task_blob_index += requested;
> +	return index;
> +}
> +
>  static int lsm_append(char *new, char **result)
>  {
>  	char *cp;
> @@ -939,12 +958,28 @@ int security_task_create(unsigned long clone_flags)
>  
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  {
> -	return call_int_hook(task_alloc, 0, task, clone_flags);
> +	int rc;
> +	const unsigned long index = lsm_max_per_task_blob_index;
> +
> +	if (index) {
> +		task->security = kcalloc(index, sizeof(unsigned long),
> +					 GFP_KERNEL);
> +		if (unlikely(!task->security))
> +			return -ENOMEM;
> +	}
> +	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> +	if (unlikely(rc))
> +		security_task_free(task);
> +	return rc;
>  }
>  
>  void security_task_free(struct task_struct *task)
>  {
>  	call_void_hook(task_free, task);
> +	if (lsm_max_per_task_blob_index) {
> +		kfree(task->security);
> +		task->security = NULL;
> +	}
>  }
>  
>  int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 361e7a2..1e3c552 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -33,6 +33,7 @@
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  #include <net/udp.h>
> +#include <linux/lsm_hooks.h> /* task_security() */
>  
>  /********** Constants definitions. **********/
>  
> @@ -684,7 +685,7 @@ struct tomoyo_domain_info {
>  	u8 group;          /* Group number to use.   */
>  	bool is_deleted;   /* Delete flag.           */
>  	bool flags[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
> -	atomic_t users; /* Number of referring credentials. */
> +	atomic_t users; /* Number of referring "struct task_struct". */
>  };
>  
>  /*
> @@ -911,6 +912,11 @@ struct tomoyo_policy_namespace {
>  	const char *name;
>  };
>  
> +struct tomoyo_security {
> +	struct tomoyo_domain_info *tomoyo_domain_info;
> +	struct tomoyo_domain_info *saved_domain_info; /* Maybe NULL. */
> +};
> +
>  /********** Function prototypes. **********/
>  
>  bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
> @@ -1060,6 +1066,7 @@ void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
>  
>  /********** External variable definitions. **********/
>  
> +extern u16 tomoyo_task_security_index;
>  extern bool tomoyo_policy_loaded;
>  extern const char * const tomoyo_condition_keyword
>  [TOMOYO_MAX_CONDITION_KEYWORD];
> @@ -1196,13 +1203,49 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
>  }
>  
>  /**
> + * tomoyo_task_security - Get "struct tomoyo_security" for specified thread.
> + *
> + * @task: Pointer to "struct task_struct".
> + *
> + * Returns pointer to "struct tomoyo_security" for specified thread.
> + */
> +static inline struct tomoyo_security *
> +tomoyo_task_security(struct task_struct *task)
> +{
> +	struct tomoyo_security *ts = task_security(task,
> +						   tomoyo_task_security_index);
> +
> +	/*
> +	 * Initialize "struct tomoyo_security" for initial task if not yet
> +	 * initialized.
> +	 */
> +	if (unlikely(!ts->tomoyo_domain_info))
> +		ts->tomoyo_domain_info = &tomoyo_kernel_domain;
> +	return ts;
> +}
> +
> +/**
>   * tomoyo_domain - Get "struct tomoyo_domain_info" for current thread.
>   *
>   * Returns pointer to "struct tomoyo_domain_info" for current thread.
>   */
>  static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -	return current_cred()->security;
> +	struct tomoyo_security *ts = tomoyo_task_security(current);
> +
> +	/*
> +	 * Since security_bprm_free() is missing, we need to check and clear
> +	 * saved_domain_info in case subsequent execve() is called immediately
> +	 * after previous execve() failed after setting saved_domain_info.
> +	 */
> +	if (ts->saved_domain_info && !current->in_execve) {
> +		struct tomoyo_domain_info *domain = ts->tomoyo_domain_info;
> +
> +		ts->tomoyo_domain_info = ts->saved_domain_info;
> +		ts->saved_domain_info = NULL;
> +		atomic_dec(&domain->users);
> +	}
> +	return ts->tomoyo_domain_info;
>  }
>  
>  /**
> @@ -1215,7 +1258,7 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
>  static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
>  							    *task)
>  {
> -	return task_cred_xxx(task, security);
> +	return tomoyo_task_security(task)->tomoyo_domain_info;
>  }
>  
>  /**
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index 00d223e..e75c2f6 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -677,6 +677,7 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
>   */
>  int tomoyo_find_next_domain(struct linux_binprm *bprm)
>  {
> +	struct tomoyo_security *ts = tomoyo_task_security(current);
>  	struct tomoyo_domain_info *old_domain = tomoyo_domain();
>  	struct tomoyo_domain_info *domain = NULL;
>  	const char *original_name = bprm->filename;
> @@ -841,8 +842,11 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>  	if (!domain)
>  		domain = old_domain;
>  	/* Update reference count on "struct tomoyo_domain_info". */
> -	atomic_inc(&domain->users);
> -	bprm->cred->security = domain;
> +	if (domain != ts->tomoyo_domain_info) {
> +		atomic_inc(&domain->users);
> +		ts->saved_domain_info =	ts->tomoyo_domain_info;
> +		ts->tomoyo_domain_info = domain;
> +	}
>  	kfree(exename.name);
>  	if (!retval) {
>  		ee->r.domain = domain;
> diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
> index 540bc29..75ae368 100644
> --- a/security/tomoyo/gc.c
> +++ b/security/tomoyo/gc.c
> @@ -248,8 +248,8 @@ static inline void tomoyo_del_domain(struct list_head *element)
>  	struct tomoyo_acl_info *tmp;
>  	/*
>  	 * Since this domain is referenced from neither
> -	 * "struct tomoyo_io_buffer" nor "struct cred"->security, we can delete
> -	 * elements without checking for is_deleted flag.
> +	 * "struct tomoyo_io_buffer" nor "struct tomoyo_security",
> +	 * we can delete elements without checking for is_deleted flag.
>  	 */
>  	list_for_each_entry_safe(acl, tmp, &domain->acl_info_list, list) {
>  		tomoyo_del_acl(&acl->list);
> @@ -433,7 +433,7 @@ static void tomoyo_try_to_gc(const enum tomoyo_policy_id type,
>  		break;
>  	case TOMOYO_ID_DOMAIN:
>  		/*
> -		 * Don't kfree() until all "struct cred"->security forget this
> +		 * Don't kfree() until all "struct tomoyo_security" forget this
>  		 * element.
>  		 */
>  		if (atomic_read(&container_of
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 06ab41b1..96e2cb5 100644
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
>  			if (!new_domain) {
>  				error = -ENOENT;
>  			} else {
> -				struct cred *cred = prepare_creds();
> -				if (!cred) {
> -					error = -ENOMEM;
> -				} else {
> -					struct tomoyo_domain_info *old_domain =
> -						cred->security;
> -					cred->security = new_domain;
> -					atomic_inc(&new_domain->users);
> -					atomic_dec(&old_domain->users);
> -					commit_creds(cred);
> -					error = 0;
> -				}
> +				struct tomoyo_domain_info *old_domain =
> +					tomoyo_domain();
> +				tomoyo_task_security(current)->
> +					tomoyo_domain_info = new_domain;
> +				atomic_inc(&new_domain->users);
> +				atomic_dec(&old_domain->users);
> +				error = 0;
>  			}
>  		}
>  		tomoyo_read_unlock(idx);
> @@ -236,7 +232,7 @@ static int __init tomoyo_initerface_init(void)
>  	struct dentry *tomoyo_dir;
>  
>  	/* Don't create securityfs entries unless registered. */
> -	if (current_cred()->security != &tomoyo_kernel_domain)
> +	if (!security_module_enable("tomoyo"))
>  		return 0;
>  
>  	tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 130b4fa..79235dd 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -8,20 +8,6 @@
>  #include "common.h"
>  
>  /**
> - * tomoyo_cred_alloc_blank - Target for security_cred_alloc_blank().
> - *
> - * @new: Pointer to "struct cred".
> - * @gfp: Memory allocation flags.
> - *
> - * Returns 0.
> - */
> -static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
> -{
> -	new->security = NULL;
> -	return 0;
> -}
> -
> -/**
>   * tomoyo_cred_prepare - Target for security_prepare_creds().
>   *
>   * @new: Pointer to "struct cred".
> @@ -33,42 +19,17 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
>  static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
>  			       gfp_t gfp)
>  {
> -	struct tomoyo_domain_info *domain = old->security;
> -	new->security = domain;
> -	if (domain)
> -		atomic_inc(&domain->users);
> +	/* Clear saved_domain_info if needed. */
> +	tomoyo_domain();
>  	return 0;
>  }
>  
>  /**
> - * tomoyo_cred_transfer - Target for security_transfer_creds().
> - *
> - * @new: Pointer to "struct cred".
> - * @old: Pointer to "struct cred".
> - */
> -static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
> -{
> -	tomoyo_cred_prepare(new, old, 0);
> -}
> -
> -/**
> - * tomoyo_cred_free - Target for security_cred_free().
> - *
> - * @cred: Pointer to "struct cred".
> - */
> -static void tomoyo_cred_free(struct cred *cred)
> -{
> -	struct tomoyo_domain_info *domain = cred->security;
> -	if (domain)
> -		atomic_dec(&domain->users);
> -}
> -
> -/**
>   * tomoyo_bprm_set_creds - Target for security_bprm_set_creds().
>   *
>   * @bprm: Pointer to "struct linux_binprm".
>   *
> - * Returns 0 on success, negative value otherwise.
> + * Returns 0.
>   */
>  static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>  {
> @@ -86,19 +47,6 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>  	if (!tomoyo_policy_loaded)
>  		tomoyo_load_policy(bprm->filename);
>  #endif
> -	/*
> -	 * Release reference to "struct tomoyo_domain_info" stored inside
> -	 * "bprm->cred->security". New reference to "struct tomoyo_domain_info"
> -	 * stored inside "bprm->cred->security" will be acquired later inside
> -	 * tomoyo_find_next_domain().
> -	 */
> -	atomic_dec(&((struct tomoyo_domain_info *)
> -		     bprm->cred->security)->users);
> -	/*
> -	 * Tell tomoyo_bprm_check_security() is called for the first time of an
> -	 * execve operation.
> -	 */
> -	bprm->cred->security = NULL;
>  	return 0;
>  }
>  
> @@ -111,7 +59,8 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>   */
>  static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>  {
> -	struct tomoyo_domain_info *domain = bprm->cred->security;
> +	struct tomoyo_security *ts = tomoyo_task_security(current);
> +	struct tomoyo_domain_info *domain = ts->saved_domain_info;
>  
>  	/*
>  	 * Execute permission is checked against pathname passed to do_execve()
> @@ -131,6 +80,59 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>  }
>  
>  /**
> + * tomoyo_bprm_check_security - Target for security_bprm_check().
> + *
> + * @bprm: Pointer to "struct linux_binprm".
> + */
> +static void tomoyo_bprm_committed_creds(struct linux_binprm *bprm)
> +{
> +	struct tomoyo_security *ts = tomoyo_task_security(current);
> +	struct tomoyo_domain_info *domain = ts->saved_domain_info;
> +
> +	/* Clear saved_domain_info if needed. */
> +	if (domain) {
> +		ts->saved_domain_info = NULL;
> +		atomic_dec(&domain->users);
> +	}
> +}
> +
> +/**
> + * tomoyo_task_alloc - Target for security_task_alloc().
> + *
> + * @task: Pointer to "struct task_struct".
> + * @clone_flags: Not used.
> + *
> + * Returns 0.
> + */
> +static int tomoyo_task_alloc(struct task_struct *task,
> +			     unsigned long clone_flags)
> +{
> +	struct tomoyo_domain_info *domain = tomoyo_domain();
> +
> +	tomoyo_task_security(task)->tomoyo_domain_info = domain;
> +	atomic_inc(&domain->users);
> +	return 0;
> +}
> +
> +/**
> + * tomoyo_task_free - Target for security_task_free().
> + *
> + * @task: Pointer to "struct task_struct".
> + */
> +static void tomoyo_task_free(struct task_struct *task)
> +{
> +	struct tomoyo_security *ts = tomoyo_task_security(task);
> +	struct tomoyo_domain_info *domain = ts->tomoyo_domain_info;
> +
> +	if (domain)
> +		atomic_dec(&domain->users);
> +	/* Clear saved_domain_info if needed. */
> +	domain = ts->saved_domain_info;
> +	if (domain)
> +		atomic_dec(&domain->users);
> +}
> +
> +/**
>   * tomoyo_inode_getattr - Target for security_inode_getattr().
>   *
>   * @mnt:    Pointer to "struct vfsmount".
> @@ -497,12 +499,12 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   * registering TOMOYO.
>   */
>  static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> -	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
>  	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
> -	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
> -	LSM_HOOK_INIT(cred_free, tomoyo_cred_free),
> +	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
> +	LSM_HOOK_INIT(task_free, tomoyo_task_free),
>  	LSM_HOOK_INIT(bprm_set_creds, tomoyo_bprm_set_creds),
>  	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
> +	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
>  	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
>  	LSM_HOOK_INIT(file_open, tomoyo_file_open),
>  	LSM_HOOK_INIT(path_truncate, tomoyo_path_truncate),
> @@ -530,6 +532,9 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>  /* Lock for GC. */
>  DEFINE_SRCU(tomoyo_ss);
>  
> +/* Index number of per "struct task_struct" blob for TOMOYO. */
> +u16 tomoyo_task_security_index __ro_after_init;
> +
>  /**
>   * tomoyo_init - Register TOMOYO Linux as a LSM module.
>   *
> @@ -537,16 +542,14 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   */
>  static int __init tomoyo_init(void)
>  {
> -	struct cred *cred = (struct cred *) current_cred();
> -
>  	if (!security_module_enable("tomoyo"))
>  		return 0;
> +	tomoyo_task_security_index =
> +	security_reserve_task_blob_index(sizeof(struct tomoyo_security));
>  	/* register ourselves with the security framework */
>  	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>  	printk(KERN_INFO "TOMOYO Linux initialized\n");
> -	cred->security = &tomoyo_kernel_domain;
>  	tomoyo_mm_init();
>  	return 0;
>  }
> -
>  security_initcall(tomoyo_init);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

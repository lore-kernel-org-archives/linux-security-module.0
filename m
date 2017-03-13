From: serge@hallyn.com (Serge E. Hallyn)
Date: Mon, 13 Mar 2017 11:47:10 -0500
Subject: [PATCH] apparmor: move task specific domain change info out of
	cred
In-Reply-To: <f502734d-a16c-5414-a6bd-ee9b8b40618f@canonical.com>
References: <1489293309-41929-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<f502734d-a16c-5414-a6bd-ee9b8b40618f@canonical.com>
Message-ID: <20170313164710.GA30654@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting John Johansen (john.johansen at canonical.com):
> Now that security_task_alloc() hook and "struct task_struct"->security
> field are revived, move task specific domain change information for
> change_onexec (equiv of setexeccon) and change_hat out of the cred
> into a context off of the task_struct.
> 
> This cleans up apparmor's use of the cred structure so that it only
> carries the reference to current mediation.
> 
> Signed-off-by: John Johansen <john.johansen@canonical.com>

Thanks, John, that helps in compelling a review of the previous patch :)

So the task_struct->security pointer is only to store requested
transition profiles right?

> ---
>  security/apparmor/context.c         | 129 +++++++++++++++++-------------------
>  security/apparmor/domain.c          |  28 ++++----
>  security/apparmor/include/context.h |  63 ++++++++----------
>  security/apparmor/lsm.c             |  65 ++++++++++--------
>  security/apparmor/policy.c          |   5 +-
>  5 files changed, 143 insertions(+), 147 deletions(-)
> 
> diff --git a/security/apparmor/context.c b/security/apparmor/context.c
> index 1fc16b8..8afb304 100644
> --- a/security/apparmor/context.c
> +++ b/security/apparmor/context.c
> @@ -13,11 +13,9 @@
>   * License.
>   *
>   *
> - * AppArmor sets confinement on every task, via the the aa_task_ctx and
> - * the aa_task_ctx.profile, both of which are required and are not allowed
> - * to be NULL.  The aa_task_ctx is not reference counted and is unique
> - * to each cred (which is reference count).  The profile pointed to by
> - * the task_ctx is reference counted.
> + * AppArmor sets confinement on every task, via the cred_profile() which
> + * is required and is not allowed to be NULL.  The cred_profile is
> + * reference counted.
>   *
>   * TODO
>   * If a task uses change_hat it currently does not return to the old
> @@ -29,25 +27,42 @@
>  #include "include/context.h"
>  #include "include/policy.h"
>  
> +
> +/**
> + * aa_get_task_profile - Get another task's profile
> + * @task: task to query  (NOT NULL)
> + *
> + * Returns: counted reference to @task's profile
> + */
> +struct aa_profile *aa_get_task_profile(struct task_struct *task)
> +{
> +	struct aa_profile *p;
> +
> +	rcu_read_lock();
> +	p = aa_get_profile(__aa_task_profile(task));
> +	rcu_read_unlock();
> +
> +	return p;
> +}
> +
>  /**
> - * aa_alloc_task_context - allocate a new task_ctx
> + * aa_alloc_task_ctx - allocate a new task_ctx
>   * @flags: gfp flags for allocation
>   *
>   * Returns: allocated buffer or NULL on failure
>   */
> -struct aa_task_ctx *aa_alloc_task_context(gfp_t flags)
> +struct aa_task_ctx *aa_alloc_task_ctx(gfp_t flags)
>  {
>  	return kzalloc(sizeof(struct aa_task_ctx), flags);
>  }
>  
>  /**
> - * aa_free_task_context - free a task_ctx
> + * aa_free_task_ctx - free a task_ctx
>   * @ctx: task_ctx to free (MAYBE NULL)
>   */
> -void aa_free_task_context(struct aa_task_ctx *ctx)
> +void aa_free_task_ctx(struct aa_task_ctx *ctx)
>  {
>  	if (ctx) {
> -		aa_put_profile(ctx->profile);
>  		aa_put_profile(ctx->previous);
>  		aa_put_profile(ctx->onexec);
>  
> @@ -56,36 +71,18 @@ void aa_free_task_context(struct aa_task_ctx *ctx)
>  }
>  
>  /**
> - * aa_dup_task_context - duplicate a task context, incrementing reference counts
> + * aa_dup_task_ctx - duplicate a task context, incrementing reference counts
>   * @new: a blank task context      (NOT NULL)
>   * @old: the task context to copy  (NOT NULL)
>   */
> -void aa_dup_task_context(struct aa_task_ctx *new, const struct aa_task_ctx *old)
> +void aa_dup_task_ctx(struct aa_task_ctx *new, const struct aa_task_ctx *old)
>  {
>  	*new = *old;
> -	aa_get_profile(new->profile);
>  	aa_get_profile(new->previous);
>  	aa_get_profile(new->onexec);
>  }
>  
>  /**
> - * aa_get_task_profile - Get another task's profile
> - * @task: task to query  (NOT NULL)
> - *
> - * Returns: counted reference to @task's profile
> - */
> -struct aa_profile *aa_get_task_profile(struct task_struct *task)
> -{
> -	struct aa_profile *p;
> -
> -	rcu_read_lock();
> -	p = aa_get_profile(__aa_task_profile(task));
> -	rcu_read_unlock();
> -
> -	return p;
> -}
> -
> -/**
>   * aa_replace_current_profile - replace the current tasks profiles
>   * @profile: new profile  (NOT NULL)
>   *
> @@ -93,36 +90,37 @@ struct aa_profile *aa_get_task_profile(struct task_struct *task)
>   */
>  int aa_replace_current_profile(struct aa_profile *profile)
>  {
> -	struct aa_task_ctx *ctx = current_ctx();
> +	struct aa_profile *old = __aa_current_profile();
>  	struct cred *new;
> +
>  	AA_BUG(!profile);
>  
> -	if (ctx->profile == profile)
> +	if (old == profile)
>  		return 0;
>  
>  	if (current_cred() != current_real_cred())
>  		return -EBUSY;
>  
>  	new  = prepare_creds();
> +	old = cred_profile(new);
>  	if (!new)
>  		return -ENOMEM;
>  
> -	ctx = cred_ctx(new);
> -	if (unconfined(profile) || (ctx->profile->ns != profile->ns))
> +	if (unconfined(profile) || (old->ns != profile->ns))
>  		/* if switching to unconfined or a different profile namespace
>  		 * clear out context state
>  		 */
> -		aa_clear_task_ctx_trans(ctx);
> +		aa_clear_task_ctx(current_task_ctx());
>  
>  	/*
> -	 * be careful switching ctx->profile, when racing replacement it
> -	 * is possible that ctx->profile->proxy->profile is the reference
> +	 * be careful switching cred profile, when racing replacement it
> +	 * is possible that the cred profile's->proxy->profile is the reference
>  	 * keeping @profile valid, so make sure to get its reference before
> -	 * dropping the reference on ctx->profile
> +	 * dropping the reference on the cred's profile
>  	 */
>  	aa_get_profile(profile);
> -	aa_put_profile(ctx->profile);
> -	ctx->profile = profile;
> +	aa_put_profile(old);
> +	cred_profile(new) = profile;
>  
>  	commit_creds(new);
>  	return 0;
> @@ -137,16 +135,12 @@ int aa_replace_current_profile(struct aa_profile *profile)
>  int aa_set_current_onexec(struct aa_profile *profile)
>  {
>  	struct aa_task_ctx *ctx;
> -	struct cred *new = prepare_creds();
> -	if (!new)
> -		return -ENOMEM;
>  
> -	ctx = cred_ctx(new);
> +	ctx = current_task_ctx();
>  	aa_get_profile(profile);
>  	aa_put_profile(ctx->onexec);
>  	ctx->onexec = profile;
>  
> -	commit_creds(new);
>  	return 0;
>  }
>  
> @@ -162,25 +156,28 @@ int aa_set_current_onexec(struct aa_profile *profile)
>   */
>  int aa_set_current_hat(struct aa_profile *profile, u64 token)
>  {
> -	struct aa_task_ctx *ctx;
> -	struct cred *new = prepare_creds();
> +	struct aa_task_ctx *ctx = current_task_ctx();
> +	struct cred *new;
> +
> +	AA_BUG(!profile);
> +
> +	new = prepare_creds();
>  	if (!new)
>  		return -ENOMEM;
> -	AA_BUG(!profile);
>  
> -	ctx = cred_ctx(new);
>  	if (!ctx->previous) {
>  		/* transfer refcount */
> -		ctx->previous = ctx->profile;
> +		ctx->previous = cred_profile(new);
>  		ctx->token = token;
>  	} else if (ctx->token == token) {
> -		aa_put_profile(ctx->profile);
> +		aa_put_profile(cred_profile(new));
>  	} else {
>  		/* previous_profile && ctx->token != token */
>  		abort_creds(new);
>  		return -EACCES;
>  	}
> -	ctx->profile = aa_get_newest_profile(profile);
> +
> +	cred_profile(new) = aa_get_newest_profile(profile);
>  	/* clear exec on switching context */
>  	aa_put_profile(ctx->onexec);
>  	ctx->onexec = NULL;
> @@ -200,28 +197,26 @@ int aa_set_current_hat(struct aa_profile *profile, u64 token)
>   */
>  int aa_restore_previous_profile(u64 token)
>  {
> -	struct aa_task_ctx *ctx;
> -	struct cred *new = prepare_creds();
> -	if (!new)
> -		return -ENOMEM;
> +	struct aa_task_ctx *ctx = current_task_ctx();
> +	struct cred *new;
>  
> -	ctx = cred_ctx(new);
> -	if (ctx->token != token) {
> -		abort_creds(new);
> +	if (ctx->token != token)
>  		return -EACCES;
> -	}
>  	/* ignore restores when there is no saved profile */
> -	if (!ctx->previous) {
> -		abort_creds(new);
> +	if (!ctx->previous)
>  		return 0;
> -	}
>  
> -	aa_put_profile(ctx->profile);
> -	ctx->profile = aa_get_newest_profile(ctx->previous);
> -	AA_BUG(!ctx->profile);
> +	new = prepare_creds();
> +	if (!new)
> +		return -ENOMEM;
> +
> +	aa_put_profile(cred_profile(new));
> +	cred_profile(new) = aa_get_newest_profile(ctx->previous);
> +	AA_BUG(!cred_profile(new));
>  	/* clear exec && prev information when restoring to previous context */
> -	aa_clear_task_ctx_trans(ctx);
> +	aa_clear_task_ctx(ctx);
>  
>  	commit_creds(new);
> +
>  	return 0;
>  }
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index ef4beef..1994c02 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -353,10 +353,10 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  	if (bprm->cred_prepared)
>  		return 0;
>  
> -	ctx = cred_ctx(bprm->cred);
> +	ctx = current_task_ctx();
>  	AA_BUG(!ctx);
> -
> -	profile = aa_get_newest_profile(ctx->profile);
> +	AA_BUG(!cred_profile(bprm->cred));
> +	profile = aa_get_newest_profile(cred_profile(bprm->cred));
>  	/*
>  	 * get the namespace from the replacement profile as replacement
>  	 * can change the namespace
> @@ -499,14 +499,11 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
>  	bprm->per_clear |= PER_CLEAR_ON_SETID;
>  
>  x_clear:
> -	aa_put_profile(ctx->profile);
> -	/* transfer new profile reference will be released when ctx is freed */
> -	ctx->profile = new_profile;
> +	aa_put_profile(profile);
> +	/* transfer new profile reference will be released when cred is freed */
> +	cred_profile(bprm->cred) = new_profile;
>  	new_profile = NULL;
>  
> -	/* clear out all temporary/transitional state from the context */
> -	aa_clear_task_ctx_trans(ctx);
> -
>  audit:
>  	error = aa_audit_file(profile, &perms, OP_EXEC, MAY_EXEC, name,
>  			      new_profile ? new_profile->base.hname : NULL,
> @@ -544,17 +541,16 @@ int apparmor_bprm_secureexec(struct linux_binprm *bprm)
>  void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
>  {
>  	struct aa_profile *profile = __aa_current_profile();
> -	struct aa_task_ctx *new_ctx = cred_ctx(bprm->cred);
> +	struct aa_profile *new = cred_profile(bprm->cred);
>  
>  	/* bail out if unconfined or not changing profile */
> -	if ((new_ctx->profile == profile) ||
> -	    (unconfined(new_ctx->profile)))
> +	if (new == profile || unconfined(new))
>  		return;
>  
>  	current->pdeath_signal = 0;
>  
>  	/* reset soft limits and set hard limits for the new profile */
> -	__aa_transition_rlimits(profile, new_ctx->profile);
> +	__aa_transition_rlimits(profile, new);
>  }
>  
>  /**
> @@ -564,6 +560,10 @@ void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
>  void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
>  {
>  	/* TODO: cleanup signals - ipc mediation */
> +
> +	/* clear out all temporary/transitional state from the context */
> +	aa_clear_task_ctx(current_task_ctx());
> +
>  	return;
>  }
>  
> @@ -621,7 +621,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, bool permtest)
>  
>  	/* released below */
>  	cred = get_current_cred();
> -	ctx = cred_ctx(cred);
> +	ctx = current_task_ctx();
>  	profile = aa_get_newest_profile(aa_cred_profile(cred));
>  	previous_profile = aa_get_newest_profile(ctx->previous);
>  
> diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
> index 5b18fed..9943969 100644
> --- a/security/apparmor/include/context.h
> +++ b/security/apparmor/include/context.h
> @@ -22,8 +22,9 @@
>  #include "policy.h"
>  #include "policy_ns.h"
>  
> -#define cred_ctx(X) ((X)->security)
> -#define current_ctx() cred_ctx(current_cred())
> +#define task_ctx(X) ((X)->security)
> +#define current_task_ctx() (task_ctx(current))
> +#define cred_profile(X) ((X)->security)
>  
>  /* struct aa_file_ctx - the AppArmor context the file was opened in
>   * @perms: the permission the file was opened with
> @@ -58,28 +59,23 @@ static inline void aa_free_file_context(struct aa_file_ctx *ctx)
>  }
>  
>  /**
> - * struct aa_task_ctx - primary label for confined tasks
> - * @profile: the current profile   (NOT NULL)
> - * @exec: profile to transition to on next exec  (MAYBE NULL)
> - * @previous: profile the task may return to     (MAYBE NULL)
> + * struct aa_task_ctx - information for current task label change
> + * @onexec: profile to transition to on next exec  (MAY BE NULL)
> + * @previous: profile the task may return to     (MAY BE NULL)
>   * @token: magic value the task must know for returning to @previous_profile
>   *
> - * Contains the task's current profile (which could change due to
> - * change_hat).  Plus the hat_magic needed during change_hat.
> - *
>   * TODO: make so a task can be confined by a stack of contexts
>   */
>  struct aa_task_ctx {
> -	struct aa_profile *profile;
>  	struct aa_profile *onexec;
>  	struct aa_profile *previous;
>  	u64 token;
>  };
>  
> -struct aa_task_ctx *aa_alloc_task_context(gfp_t flags);
> -void aa_free_task_context(struct aa_task_ctx *ctx);
> -void aa_dup_task_context(struct aa_task_ctx *new,
> -			 const struct aa_task_ctx *old);
> +struct aa_task_ctx *aa_alloc_task_ctx(gfp_t flags);
> +void aa_free_task_ctx(struct aa_task_ctx *ctx);
> +void aa_dup_task_ctx(struct aa_task_ctx *new, const struct aa_task_ctx *old);
> +
>  int aa_replace_current_profile(struct aa_profile *profile);
>  int aa_set_current_onexec(struct aa_profile *profile);
>  int aa_set_current_hat(struct aa_profile *profile, u64 token);
> @@ -97,10 +93,11 @@ struct aa_profile *aa_get_task_profile(struct task_struct *task);
>   */
>  static inline struct aa_profile *aa_cred_profile(const struct cred *cred)
>  {
> -	struct aa_task_ctx *ctx = cred_ctx(cred);
> +	struct aa_profile *profile = cred_profile(cred);
>  
> -	AA_BUG(!ctx || !ctx->profile);
> -	return ctx->profile;
> +	AA_BUG(!profile);
> +
> +	return profile;
>  }
>  
>  /**
> @@ -117,17 +114,6 @@ static inline struct aa_profile *__aa_task_profile(struct task_struct *task)
>  }
>  
>  /**
> - * __aa_task_is_confined - determine if @task has any confinement
> - * @task: task to check confinement of  (NOT NULL)
> - *
> - * If @task != current needs to be called in RCU safe critical section
> - */
> -static inline bool __aa_task_is_confined(struct task_struct *task)
> -{
> -	return !unconfined(__aa_task_profile(task));
> -}
> -
> -/**
>   * __aa_current_profile - find the current tasks confining profile
>   *
>   * Returns: up to date confining profile or the ns unconfined profile (NOT NULL)
> @@ -150,19 +136,17 @@ static inline struct aa_profile *__aa_current_profile(void)
>   */
>  static inline struct aa_profile *aa_current_profile(void)
>  {
> -	const struct aa_task_ctx *ctx = current_ctx();
> -	struct aa_profile *profile;
> +	struct aa_profile *profile = __aa_current_profile();
>  
> -	AA_BUG(!ctx || !ctx->profile);
> +	AA_BUG(!profile);
>  
> -	if (profile_is_stale(ctx->profile)) {
> -		profile = aa_get_newest_profile(ctx->profile);
> +	if (profile_is_stale(profile)) {
> +		profile = aa_get_newest_profile(profile);
>  		aa_replace_current_profile(profile);
>  		aa_put_profile(profile);
> -		ctx = current_ctx();
>  	}
>  
> -	return ctx->profile;
> +	return profile;
>  }
>  
>  static inline struct aa_ns *aa_get_current_ns(void)
> @@ -170,12 +154,17 @@ static inline struct aa_ns *aa_get_current_ns(void)
>  	return aa_get_ns(__aa_current_profile()->ns);
>  }
>  
> +
> +
> +
>  /**
> - * aa_clear_task_ctx_trans - clear transition tracking info from the ctx
> + * aa_clear_task_ctx - clear transition tracking info from the ctx
>   * @ctx: task context to clear (NOT NULL)
>   */
> -static inline void aa_clear_task_ctx_trans(struct aa_task_ctx *ctx)
> +static inline void aa_clear_task_ctx(struct aa_task_ctx *ctx)
>  {
> +	AA_BUG(!ctx);
> +
>  	aa_put_profile(ctx->previous);
>  	aa_put_profile(ctx->onexec);
>  	ctx->previous = NULL;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 1f2000d..ed9bf71 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -49,12 +49,12 @@ DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
>   */
>  
>  /*
> - * free the associated aa_task_ctx and put its profiles
> + * put the associated profiles
>   */
>  static void apparmor_cred_free(struct cred *cred)
>  {
> -	aa_free_task_context(cred_ctx(cred));
> -	cred_ctx(cred) = NULL;
> +	aa_put_profile(cred_profile(cred));
> +	cred_profile(cred) = NULL;
>  }
>  
>  /*
> @@ -62,30 +62,19 @@ static void apparmor_cred_free(struct cred *cred)
>   */
>  static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>  {
> -	/* freed by apparmor_cred_free */
> -	struct aa_task_ctx *ctx = aa_alloc_task_context(gfp);
> -
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	cred_ctx(cred) = ctx;
> +	cred_profile(cred) = NULL;
>  	return 0;
>  }
>  
>  /*
> - * prepare new aa_task_ctx for modification by prepare_cred block
> + * prepare new cred profile for modification by prepare_cred block
>   */
>  static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
>  				 gfp_t gfp)
>  {
> -	/* freed by apparmor_cred_free */
> -	struct aa_task_ctx *ctx = aa_alloc_task_context(gfp);
> -
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	aa_dup_task_context(ctx, cred_ctx(old));
> -	cred_ctx(new) = ctx;
> +	struct aa_profile *tmp = cred_profile(new);
> +	cred_profile(new) = aa_get_newest_profile(cred_profile(old));
> +	aa_put_profile(tmp);
>  	return 0;
>  }
>  
> @@ -94,10 +83,30 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
>   */
>  static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
>  {
> -	const struct aa_task_ctx *old_ctx = cred_ctx(old);
> -	struct aa_task_ctx *new_ctx = cred_ctx(new);
> +	struct aa_profile *tmp = cred_profile(new);
> +	cred_profile(new) = aa_get_newest_profile(cred_profile(old));
> +	aa_put_profile(tmp);
> +}
>  
> -	aa_dup_task_context(new_ctx, old_ctx);
> +static void apparmor_task_free(struct task_struct *task)
> +{
> +
> +	aa_free_task_ctx(task_ctx(task));
> +	task_ctx(task) = NULL;
> +}
> +
> +static int apparmor_task_alloc(struct task_struct *task,
> +			       unsigned long clone_flags)
> +{
> +	struct aa_task_ctx *new = aa_alloc_task_ctx(GFP_KERNEL);
> +
> +	if (!new)
> +		return -ENOMEM;
> +
> +	aa_dup_task_ctx(new, current_task_ctx());
> +	task_ctx(task) = new;
> +
> +	return 0;
>  }
>  
>  static int apparmor_ptrace_access_check(struct task_struct *child,
> @@ -484,11 +493,11 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	int error = -ENOENT;
>  	/* released below */
>  	const struct cred *cred = get_task_cred(task);
> -	struct aa_task_ctx *ctx = cred_ctx(cred);
> +	struct aa_task_ctx *ctx = current_task_ctx();
>  	struct aa_profile *profile = NULL;
>  
>  	if (strcmp(name, "current") == 0)
> -		profile = aa_get_newest_profile(ctx->profile);
> +		profile = aa_get_newest_profile(cred_profile(cred));
>  	else if (strcmp(name, "prev") == 0  && ctx->previous)
>  		profile = aa_get_newest_profile(ctx->previous);
>  	else if (strcmp(name, "exec") == 0 && ctx->onexec)
> @@ -629,6 +638,8 @@ static struct security_hook_list apparmor_hooks[] = {
>  	LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
>  	LSM_HOOK_INIT(bprm_secureexec, apparmor_bprm_secureexec),
>  
> +	LSM_HOOK_INIT(task_free, apparmor_task_free),
> +	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
>  	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
>  };
>  
> @@ -871,12 +882,12 @@ static int __init set_init_ctx(void)
>  	struct cred *cred = (struct cred *)current->real_cred;
>  	struct aa_task_ctx *ctx;
>  
> -	ctx = aa_alloc_task_context(GFP_KERNEL);
> +	ctx = aa_alloc_task_ctx(GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	ctx->profile = aa_get_profile(root_ns->unconfined);
> -	cred_ctx(cred) = ctx;
> +	cred_profile(cred) = aa_get_profile(root_ns->unconfined);
> +	task_ctx(current) = ctx;
>  
>  	return 0;
>  }
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index f44312a..b9c300b 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -827,8 +827,9 @@ static int __lookup_replace(struct aa_ns *ns, const char *hname,
>   * @udata: serialized data stream  (NOT NULL)
>   *
>   * unpack and replace a profile on the profile list and uses of that profile
> - * by any aa_task_ctx.  If the profile does not exist on the profile list
> - * it is added.
> + * by any task creds via invalidating the old version of the profile, which
> + * tasks will notice to update their own cred.  If the profile does not exist
> + * on the profile list it is added.
>   *
>   * Returns: size of data consumed else error code on failure.
>   */
> -- 
> 2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

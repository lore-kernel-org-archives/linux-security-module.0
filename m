Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FD26E948
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689604; cv=none; b=HM+Ifg4/TKJmQthYb7vd6g0q2/cqcfYlBewghKOGhCtEBwOjcqsw7HHErHiGM22fEY7q+1klOn17bhRBfJgSRZtmsuwZackp9eHsV7dbVkqQTqmFWWALK38VPRc3uGXsvctNlx8WFLtzDcWwGR+9QMCmEHzCGICQoWlUrEi0BvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689604; c=relaxed/simple;
	bh=GNcZTd6cAjYIgC+yiCsEdHrF1wQyqeJeTpYh/4/SQiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSWyAbuU7VxkKf0zWrWLQyUVgyWLqzVwXDb/Bo/a+edIYZyAN/jrP//zfR5mDFG/CSwS7N8utNOXrkHbFeyziA6UoN+OU5AMB0VI4xfeNu2nUf7Z7r5Vn67IH1ZjYDhmcZbwssyORMJwfCZk5h46mdAyzsiud20eOkPTLTvg0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G2JEOIFs; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G2JEOIFs"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z3k7r28cFz1Tg;
	Thu, 27 Feb 2025 21:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740689592;
	bh=xCgOi5W1uHwKsV2GLr+EKxHsf0Ip3GcDlngCzqY9X7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2JEOIFsaWiat0dP+7pNu2L5dO6Rk11z+HDbhvRnNksrRkZlPQsdEfJMt1wUc/F+z
	 6JI79NVS+EK3VYkvPoE4UziGMUAeOSPadaWz/b+JR9YwvyPTh2o/KBTLm0SjYPOJ2j
	 siFvthYWedWyq0W/a3T0Y0SM4e89ObFZEnqCIUgE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z3k7q5Rk4zlVs;
	Thu, 27 Feb 2025 21:53:11 +0100 (CET)
Date: Thu, 27 Feb 2025 21:53:11 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250227.Aequah6Avieg@digikod.net>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221184417.27954-3-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 21, 2025 at 07:44:17PM +0100, Günther Noack wrote:
> Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
> given Landlock ruleset is applied to all threads of the calling
> process, instead of only the current one.

I initially though that we may pick another flag name but I now think
reusing the same name as for seccomp would be less confusing for users.

> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h |  10 ++
>  security/landlock/syscalls.c  | 232 +++++++++++++++++++++++++++++++++-
>  2 files changed, 237 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 33745642f7875..fb971e4e0fb2b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -62,6 +62,16 @@ struct landlock_ruleset_attr {
>  #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
>  /* clang-format on */
>  
> +/*
> + * sys_landlock_restrict_self() flags:
> + *
> + * - %LANDLOCK_RESTRICT_SELF_TSYNC: Apply the given ruleset to all threads of
> + *    the current process.
> + */
> +/* clang-format off */
> +#define LANDLOCK_RESTRICT_SELF_TSYNC			(1U << 0)
> +/* clang-format on */
> +
>  /**
>   * enum landlock_rule_type - Landlock rule type
>   *
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index a9760d252fc2d..63792a6cde5ca 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -23,6 +23,7 @@
>  #include <linux/security.h>
>  #include <linux/stddef.h>
>  #include <linux/syscalls.h>
> +#include <linux/task_work.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/landlock.h>
> @@ -425,17 +426,233 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  
>  /* Enforcement */
>  
> +/*
> + * Shared state between multiple threads which are enforcing Landlock rulesets
> + * in lockstep with each other.
> + */
> +struct landlock_tsync_shared_context {
> +	/* Expected existing Landlock domain on every thread. */
> +	struct landlock_ruleset *old_dom;
> +
> +	/* Replacement Landlock domain to be applied if prerequisites are met */
> +	struct landlock_ruleset *new_dom;
> +
> +	/* Barrier after preparation step. */
> +	atomic_t num_preparing;
> +	struct completion all_prepared;
> +
> +	/* An error encountered in preparation step, or 0. */
> +	atomic_t preparation_error;
> +
> +	/*
> +	 * Barrier after commit step (used by syscall impl to wait for
> +	 * completion).
> +	 */
> +	atomic_t num_unfinished;
> +	struct completion all_finished;
> +};
> +
> +struct landlock_tsync_context {
> +	struct callback_head work;
> +	struct landlock_tsync_shared_context *ctx;
> +};
> +
> +static struct cred *
> +landlock_prepare_creds(const struct landlock_ruleset *old_dom,
> +		       struct landlock_ruleset *new_dom)
> +{
> +	struct cred *new_cred;
> +	struct landlock_cred_security *new_llcred;
> +
> +	/*
> +	 * Similar checks as for seccomp(2), except that an -EPERM may be
> +	 * returned.
> +	 */
> +	if (!task_no_new_privs(current) &&
> +	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> +		return ERR_PTR(-EPERM);

This should only be done for the calling thread, so just reusing the
existing code from landlock_restrict_self().

If the no_new_privs property is set for the current thread, it would
make sense to just set it for all other threads once we are sure we can
sandbox all of them (see seccomp_sync_threads).

For this we need to have two for_each_thread loops: one to check that
the current thread is legitimate to sandbox all the other threads and
make sure no error could arise (e.g. memory allocation), and another
loop to safely enforce the restrictions if the first one was OK.

The handling of the following prepare_cred()'s failure is the main
issue, but see my proposal below.

> +
> +	/* Prepares new credentials. */
> +	new_cred = prepare_creds();
> +	if (!new_cred)
> +		return ERR_PTR(-ENOMEM);

Instead of creating one new credential per thread, we should use the
newly created one (from landlock_restrict_self) and increment its
references.  In most cases that would avoid duplicating information and
wasting memory by creating one struct cred per thread.

> +
> +	new_llcred = landlock_cred(new_cred);
> +	if (new_llcred->domain != old_dom) {
> +		abort_creds(new_cred);
> +		return ERR_PTR(-ESRCH);

To avoid dealing with prepare_creds()'s error, I think we could just
check that all threads have (initially) the same credentials, and either
swap this same old credential with the new one (created by the caller),
or swap the Landlock domain (and set no_new_privs) if the credentials
changed between the initial check and now.  Actually it might be up to
three loops:

(lock cred_guard_mutex)

1. Check that all threads use the same credential, or abort the whole
   operation otherwise.

2. If the caller has no_new_privs (and passed the Landlock checks), set
   no_new_privs to all threads.

3. Run a work_task on each thread that will either:
   - if old thread's credential is still the same as the caller's
     credentials, swap it with the new one with get_cred()/put_cred();
   - otherwise, this means that the thread changed its credential after
     the first loop but because we set no_new_privs, this alternative
     credential should not give more privileges and we should be safe to
     only swap the Landlock domain with the new one (if different).
     Indeed, this alternative credential might be used by other threads
     from the same process, but AFAIK not by threads from other
     processes thanks to cred_guard_mutex.  This would require to bypass
     the const pointer though.  Holding cred_guard_mutex will also make
     sure that domains were not updated under our feet by another call
     to landlock_restrict_self().

(unlock cred_guard_mutex)

Another approach would be to leverage an LSM hook to deny credential
changes for a thread while we are changing them for the whole process,
but I'm not sure it would be better.

Kees, Paul, Jann, any better idea?

> +	}
> +
> +	/* Replaces the old (prepared) domain. */
> +	landlock_put_ruleset(new_llcred->domain);
> +	landlock_get_ruleset(new_dom);
> +	new_llcred->domain = new_dom;
> +
> +	return new_cred;
> +}
> +
> +/*
> + * restrict_one_thread - update a thread's Landlock domain in lockstep with the
> + * other threads in the same process.
> + *
> + * When this is run, the same function gets run in all other threads in the same
> + * process.  The concurrently running function invocations coordinate to wait
> + * until they are all done with the preparation step and have reported back
> + * errors from the preparation step, if necessary.
> + *
> + * Afterwards, depending on the presence of an error, all threads either commit
> + * or abort the prepared credentials.  The commit operation can not fail any more.
> + */
> +static void restrict_one_thread(struct landlock_tsync_shared_context *ctx)
> +{
> +	int res;
> +	struct cred *cred = landlock_prepare_creds(ctx->old_dom, ctx->new_dom);
> +
> +	/* On error, set the error and continue. (Do not return early.) */
> +	if (IS_ERR(cred))
> +		atomic_set(&ctx->preparation_error, PTR_ERR(cred));
> +
> +	/*
> +	 * Barrier: Wait until all threads are done preparing.
> +	 * After this point, we can have no more failures.
> +	 */
> +	if (atomic_dec_return(&ctx->num_preparing) == 0)
> +		complete_all(&ctx->all_prepared);
> +	wait_for_completion(&ctx->all_prepared);

The logic is OK but the side effect would be to block all threads, which
is an issue.  That's why we need at least two loops run by the calling
thread, and the other threads should not have to wait.

> +
> +	/*
> +	 * Abort the commit if any of the threads had an error.
> +	 * (It might also be this thread.)  Otherwise, commit.
> +	 */
> +	res = atomic_read(&ctx->preparation_error);
> +	if (res) {
> +		if (!IS_ERR(cred))
> +			abort_creds(cred);
> +	} else {
> +		commit_creds(cred);
> +	}
> +
> +	/* Notify the calling thread once all threads are done */
> +	if (atomic_dec_return(&ctx->num_unfinished) == 0)
> +		complete_all(&ctx->all_finished);
> +}
> +
> +/*
> + * restrict_one_thread_callback - task_work callback for restricting a thread
> + *
> + * Calls restrict_one_thread with the struct landlock_shared_tsync_context
> + * and frees up the per-work_task landlock_tsync_context afterwards.
> + */
> +static void restrict_one_thread_callback(struct callback_head *work)
> +{
> +	struct landlock_tsync_context *ctx =
> +		container_of(work, struct landlock_tsync_context, work);
> +	struct landlock_tsync_shared_context *sctx = ctx->ctx;
> +
> +	restrict_one_thread(sctx);
> +	kfree(ctx);
> +}
> +
> +/*
> + * restrict_all_threads - enables a Landlock policy for all threads
> + */
> +static int restrict_all_threads(const int ruleset_fd)
> +{
> +	int res;
> +	struct task_struct *thread, *caller;
> +	struct landlock_tsync_shared_context sctx;
> +	struct landlock_ruleset *ruleset;
> +
> +	/*
> +	 * XXX: Need to double check race conditions and deadlocks before
> +	 * merging this upstream. We probably need additional locking.
> +	 */
> +
> +	/* Starting with 1, as we're already counting current. */
> +	atomic_set(&sctx.num_preparing, 1);
> +	atomic_set(&sctx.num_unfinished, 1);
> +	init_completion(&sctx.all_prepared);
> +	init_completion(&sctx.all_finished);
> +	atomic_set(&sctx.preparation_error, 0);
> +	sctx.old_dom = landlock_get_current_domain();
> +
> +	/* Gets and checks the ruleset. */
> +	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
> +	if (IS_ERR(ruleset))
> +		return PTR_ERR(ruleset);
> +
> +	/*
> +	 * We pre-merge the domain for all threads,
> +	 * so that all threads end up with exactly the same domain.
> +	 */
> +	sctx.new_dom = landlock_merge_ruleset(sctx.old_dom, ruleset);
> +	landlock_put_ruleset(ruleset);
> +	if (IS_ERR(sctx.new_dom))
> +		return PTR_ERR(sctx.new_dom);

What is specific to this function should only start here.  The flag
checks (new ones are coming with the audit patch series), the ruleset
FD, the preapre_creds(), and the landlock_merge_ruleset() should be the
same.  We can initialize shared states from here.

> +
> +	landlock_get_ruleset(sctx.old_dom);
> +
> +	caller = current;
> +	for_each_thread(caller, thread) {
> +		/* Skip current, since it is initiating the sync. */
> +		if (thread == caller)
> +			continue;
> +
> +		/* Skip exited threads. */
> +		if (thread->flags & PF_EXITING)
> +			continue;
> +
> +		/* Deallocation is done by the task_work itself. */
> +		struct landlock_tsync_context *ctx =
> +			kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
> +		if (!ctx) {
> +			/*
> +			 * On error, keep already started threads from
> +			 * accidentally committing.  Do not start additional
> +			 * threads.
> +			 */
> +			atomic_set(&sctx.preparation_error, -ENOMEM);
> +			break;
> +		}
> +
> +		ctx->ctx = &sctx;
> +		atomic_inc(&sctx.num_preparing);
> +		atomic_inc(&sctx.num_unfinished);
> +		init_task_work(&ctx->work, restrict_one_thread_callback);
> +		res = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> +		if (res) {
> +			atomic_set(&sctx.preparation_error, res);
> +			atomic_dec(&sctx.num_preparing);
> +			atomic_dec(&sctx.num_unfinished);
> +		}
> +	}
> +
> +	/* and do the same on the current thread */
> +	restrict_one_thread(&sctx);
> +
> +	res = atomic_read(&sctx.preparation_error);
> +	wait_for_completion(&sctx.all_finished);
> +	landlock_put_ruleset(sctx.new_dom);
> +	landlock_put_ruleset(sctx.old_dom);
> +	return res;
> +}
> +
>  /**
>   * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
>   *
>   * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
> - * @flags: Must be 0.
> + * @flags: Flags to modify the behavior.
>   *
> - * This system call enables to enforce a Landlock ruleset on the current
> - * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
> + * This system call enforces a Landlock ruleset on the current thread.
> + * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
>   * namespace or is running with no_new_privs.  This avoids scenarios where
>   * unprivileged tasks can affect the behavior of privileged children.
>   *
> + * If %LANDLOCK_RESTRICT_SELF_TSYNC is specified in @flags, the ruleset will be
> + * applied to all threads of the current process.  For this, all threads must be
> + * in the same Landlock domain and fulfill the normal requirements for enforcing
> + * a Landlock ruleset.
> + *
>   * Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> @@ -447,6 +664,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>   *   %CAP_SYS_ADMIN in its namespace.
>   * - %E2BIG: The maximum number of stacked rulesets is reached for the current
>   *   thread.
> + * - %ESRCH: When called with %LANDLOCK_RESTRICT_SELF_TSYNC, the processes'
> + *   threads were in different Landlock domains.
>   */
>  SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  		flags)
> @@ -467,10 +686,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	/* No flag for now. */
> -	if (flags)
> +	/* TSYNC is the only supported flag. */
> +	if (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC)
>  		return -EINVAL;
>  
> +	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC)
> +		return restrict_all_threads(ruleset_fd);
> +

As explained above, restrict_all_threads()'s logic should be called
later.

Starting here, as seccomp does, we can lock siglock (whatever flags are
used) to be sure there is not concurrent call to
landlock_restrict_self() on other threads of the same process.

If LANDLOCK_RESTRICT_SELF_TSYNC is set, we also need to lock
cred_guard_mutex to avoid race conditions with concurrent execve calls.

>  	/* Gets and checks the ruleset. */
>  	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
>  	if (IS_ERR(ruleset))
> -- 
> 2.48.1
> 
> 

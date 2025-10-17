Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634B336EDD
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713480; cv=none; b=fMWKZrCLcb5v+A1e9NM2fAxICiOhTn6WRlBXWMse4Jd7H1XxFFmmilK1BvpX5uUdDh0h9TWF+5MU1fFypg+1WABvqZOvZcwEI3HqZ8p03EllM0IZeTVugJcuqhnj+yH5FlKH/PyyiZ8/lSF64a9bQxTWFPoTQ1t79OwNUICyFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713480; c=relaxed/simple;
	bh=MmBx7CdS+qBpkcIXi4OKIxiuf69IAKmxlYiYoLwmrKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpeS03dy/pZmsH6vt0YTh2CTOeLNejOX5EYUei+S5u8SiqdL6wGqE5FRZQxYf71JCtRK00xWT6qc7S+KmljpVIYvphc9wSnQ1s43tKqWgmAwdlm0w4vDi2koSbVDpL0rAzf0tSP/b9UyDPzax2RNVhkhkafdbaiKYRtE0cTDbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Qvob4/Rn; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Qvob4/Rn"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cp7QJ4HnGztRM;
	Fri, 17 Oct 2025 17:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760713464;
	bh=fbVlw5NqM31Xvfzkfo1cyuiiWlIpaz/bXW/NZzxRa+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qvob4/Rne7oaM3GsmGnk4lUCFOK0GWyL2Vcwn7NcZ9VVg0KNJmKmc0LTzKhzc8LQV
	 rHznIlBMPgYZqTz/5i5Pjh4nd4lhi3kgiFPjIWNdl4PzRhVEhO733VE/zu06Ljbmgt
	 gvN4rSpumgpy4WCllqhs7Hf4f8plSGPrtRsqo9G0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cp7QH5Pgbzdj8;
	Fri, 17 Oct 2025 17:04:23 +0200 (CEST)
Date: Fri, 17 Oct 2025 17:04:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20251017.ohthoos9Ogha@digikod.net>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001111807.18902-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

This patch series is complex but it looks very good, thanks for all the
explanations!  I don't have major concern but a few comments.

I'm wondering if this could be simplified but, except the flat array, I
couldn't find a better approach.

Jann, could you please take a look?


On Wed, Oct 01, 2025 at 01:18:06PM +0200, Günther Noack wrote:
> Introduce the LANDLOCK_RESTRICT_SELF_TSYNC flag.  With this flag, a
> given Landlock ruleset is applied to all threads of the calling
> process, instead of only the current one.
> 
> Without this flag, multithreaded userspace programs currently resort
> to using the nptl(7)/libpsx hack for multithreaded policy enforcement,
> which is also used by libcap and for setuid(2).  Using this scheme,
> the threads of a process enforce the same Landlock ruleset, but the
> resulting Landlock domains are still separate, which makes a
> difference for Landlock's "scoped" access rights, where the domain
> identity and nesting is used.  As a result, when using
> LANLDOCK_SCOPE_SIGNAL, signaling between sibling threads stops
> working.  This is a problem for programming languages and frameworks
> which are inherently multithreaded (e.g. Go).

Having different Landlock domains also means that we get different
domains ID, and the audit logs might confuse users.

> 
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h |   4 +
>  security/landlock/cred.h      |  12 +
>  security/landlock/limits.h    |   2 +-
>  security/landlock/syscalls.c  | 433 +++++++++++++++++++++++++++++++++-

You can move most of this code to a new tsync.c file.

>  4 files changed, 448 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f030adc462ee..7c6c7f004a41 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -117,11 +117,15 @@ struct landlock_ruleset_attr {
>   *     future nested domains, not the one being created. It can also be used
>   *     with a @ruleset_fd value of -1 to mute subdomain logs without creating a
>   *     domain.
> + *
> + * %LANDLOCK_RESTRICT_SELF_TSYNC
> + *    Apply the given ruleset atomically to all threads of the current process.

Please bump the Landlock ABI version and update the doc.

>   */
>  /* clang-format off */
>  #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
>  #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
>  #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
> +#define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> index c82fe63ec598..eb28eeade760 100644
> --- a/security/landlock/cred.h
> +++ b/security/landlock/cred.h
> @@ -65,6 +65,18 @@ landlock_cred(const struct cred *cred)
>  	return cred->security + landlock_blob_sizes.lbs_cred;
>  }
>  
> +static inline void landlock_cred_copy(struct landlock_cred_security *dst,
> +				      const struct landlock_cred_security *src)
> +{

You can simplify by removing the domain checks which are already done by
landlock_put/get_ruleset().

> +	if (dst->domain)
> +		landlock_put_ruleset(dst->domain);
> +
> +	*dst = *src;
> +
> +	if (dst->domain)
> +		landlock_get_ruleset(src->domain);

> +}
> +
>  static inline struct landlock_ruleset *landlock_get_current_domain(void)
>  {
>  	return landlock_cred(current_cred())->domain;
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 65b5ff051674..eb584f47288d 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -31,7 +31,7 @@
>  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
>  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  
> -#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
> +#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
>  #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
>  
>  /* clang-format on */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0116e9f93ffe..5ba14d641c11 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -14,6 +14,7 @@
>  #include <linux/capability.h>
>  #include <linux/cleanup.h>
>  #include <linux/compiler_types.h>
> +#include <linux/completion.h>
>  #include <linux/dcache.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> @@ -25,6 +26,7 @@
>  #include <linux/security.h>
>  #include <linux/stddef.h>
>  #include <linux/syscalls.h>
> +#include <linux/task_work.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/landlock.h>
> @@ -445,6 +447,416 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  
>  /* Enforcement */
>  
> +/*
> + * Shared state between multiple threads which are enforcing Landlock rulesets
> + * in lockstep with each other.
> + */
> +struct tsync_shared_context {
> +	/* The old and tentative new creds of the calling thread. */
> +	const struct cred *old_cred;
> +	const struct cred *new_cred;
> +
> +	/* An error encountered in preparation step, or 0. */
> +	atomic_t preparation_error;
> +
> +	/*
> +	 * Barrier after preparation step in the inner loop.
> +	 * The calling thread waits for completion.
> +	 *
> +	 * Re-initialized on every round of looking for newly spawned threads.
> +	 */
> +	atomic_t num_preparing;
> +	struct completion all_prepared;
> +
> +	/* Sibling threads wait for completion. */
> +	struct completion ready_to_commit;
> +
> +	/*
> +	 * Barrier after commit step (used by syscall impl to wait for
> +	 * completion).
> +	 */
> +	atomic_t num_unfinished;
> +	struct completion all_finished;
> +};
> +
> +struct tsync_work {
> +	struct callback_head work;
> +	struct task_struct *task;
> +	struct tsync_shared_context *shared_ctx;
> +};
> +
> +/*
> + * restrict_one_thread - update a thread's Landlock domain in lockstep with the
> + * other threads in the same process
> + *
> + * When this is run, the same function gets run in all other threads in the same
> + * process (except for the calling thread which called landlock_restrict_self).
> + * The concurrently running invocations of restrict_one_thread coordinate
> + * through the shared ctx object to do their work in lockstep to implement
> + * all-or-nothing semantics for enforcing the new Landlock domain.
> + *
> + * Afterwards, depending on the presence of an error, all threads either commit
> + * or abort the prepared credentials.  The commit operation can not fail any more.
> + */
> +static void restrict_one_thread(struct tsync_shared_context *ctx)
> +{
> +	int res;

For consistency with existing code, please use "err" instead of "res".

> +	struct cred *cred = NULL;
> +	const struct cred *current_cred = current_cred();

No need for this variable.

> +
> +	if (current_cred == ctx->old_cred) {
> +		/*
> +		 * As a shortcut, switch out old_cred with new_cred, if
> +		 * possible.
> +		 *
> +		 * Note: We are intentionally dropping the const qualifier here,
> +		 * because it is required by commit_creds() and abort_creds().
> +		 */
> +		cred = (struct cred *)get_cred(ctx->new_cred);

Good.  You can extend the comment to explain that this optimization
avoid creating new credentials in most cases, and then save memory.

> +	} else {
> +		/* Else, prepare new creds and populate them. */
> +		cred = prepare_creds();
> +
> +		if (!cred) {
> +			atomic_set(&ctx->preparation_error, -ENOMEM);
> +
> +			/*
> +			 * Even on error, we need to adhere to the protocol and
> +			 * coordinate with concurrently running invocations.
> +			 */
> +			if (atomic_dec_return(&ctx->num_preparing) == 0)
> +				complete_all(&ctx->all_prepared);
> +
> +			goto out;
> +		}
> +
> +		landlock_cred_copy(landlock_cred(cred),
> +				   landlock_cred(ctx->new_cred));
> +	}
> +
> +	/*
> +	 * Barrier: Wait until all threads are done preparing.
> +	 * After this point, we can have no more failures.
> +	 */
> +	if (atomic_dec_return(&ctx->num_preparing) == 0)
> +		complete_all(&ctx->all_prepared);
> +
> +	/*
> +	 * Wait for signal from calling thread that it's safe to read the
> +	 * preparation error now and we are ready to commit (or abort).
> +	 */
> +	wait_for_completion(&ctx->ready_to_commit);
> +
> +	/* Abort the commit if any of the other threads had an error. */
> +	res = atomic_read(&ctx->preparation_error);
> +	if (res) {
> +		abort_creds(cred);
> +		goto out;
> +	}
> +
> +	/* If needed, establish enforcement prerequisites. */
> +	if (!ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> +		task_set_no_new_privs(current);

We should always set PR_SET_NO_NEW_PRIVS if it is set on the calling
thread as done by seccomp.  We should just store the result of
task_no_new_privs() in tsync_shared_context and use it as condition here.
This should be explained in the documentation.

This also mean that if the calling thread has CAP_SYS_ADMIN but not
PR_SET_NO_NEW_PRIVS, then a sibling thread could not have CAP_SYS_ADMIN
nor PR_SET_NO_NEW_PRIVS.  This would be a risky state but mainly because
of the CAP_SYS_ADMIN inconsistency, not really the missing
PR_SET_NO_NEW_PRIVS.

> +
> +	commit_creds(cred);
> +
> +out:
> +	/* Notify the calling thread once all threads are done */
> +	if (atomic_dec_return(&ctx->num_unfinished) == 0)
> +		complete_all(&ctx->all_finished);
> +}
> +
> +/*
> + * restrict_one_thread_callback - task_work callback for restricting a thread
> + *
> + * Calls restrict_one_thread with the struct landlock_shared_tsync_context.
> + */
> +static void restrict_one_thread_callback(struct callback_head *work)
> +{
> +	struct tsync_work *ctx = container_of(work, struct tsync_work, work);
> +
> +	restrict_one_thread(ctx->shared_ctx);
> +}
> +
> +/*
> + * struct tsync_works - a growable array of per-task contexts
> + *
> + * The zero-initialized struct represents the empty array.
> + */
> +struct tsync_works {
> +	struct tsync_work **works;
> +	size_t size;
> +	size_t capacity;
> +};
> +
> +/*
> + * tsync_works_provide - provides a preallocated tsync_work for the given task
> + *
> + * This also stores a task pointer in the context and increments the reference
> + * count of the task.
> + *
> + * Returns:
> + *   A pointer to the preallocated context struct, with task filled in.
> + *
> + *   NULL, if we ran out of preallocated context structs.
> + */
> +static struct tsync_work *tsync_works_provide(struct tsync_works *s,
> +					      struct task_struct *task)
> +{
> +	struct tsync_work *ctx;
> +
> +	if (s->size >= s->capacity)

In which case can this happen?  Should we wrap this in a WARN_ON_ONCE()?

> +		return NULL;
> +
> +	ctx = s->works[s->size];
> +	s->size++;
> +
> +	ctx->task = get_task_struct(task);
> +	return ctx;
> +}
> +
> +/*
> + * tsync_works_grow_by - preallocates space for n more contexts in s
> + *
> + * Returns:
> + *   -ENOMEM if the (re)allocation fails
> + *   0       if the allocation succeeds, partially succeeds, or no reallocation was needed
> + */
> +static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
> +{
> +	int i;

size_t i;

> +	size_t new_capacity = s->capacity + n;

> +	struct tsync_work **works;
> +
> +	if (new_capacity <= s->capacity)

This integer overflow check should return an error instead.

> +		return 0;
> +
> +	works = krealloc_array(s->works, new_capacity, sizeof(s->works[0]),
> +			       flags);
> +	if (IS_ERR(works))
> +		return PTR_ERR(works);
> +
> +	s->works = works;
> +
> +	for (i = s->capacity; i < new_capacity; i++) {
> +		s->works[i] = kzalloc(sizeof(*s->works[i]), flags);

We should use a local variable to avoid storing an error code in
s->works[i] and potentially dereferencing it later (e.g. in
tsync_work_free).

Why can't we avoid this loop entirely and allocate a flat array with
only one call to krealloc_array()?  Why struct tsync_works->works needs
to be a pointer to a pointer?

> +		if (IS_ERR(s->works[i])) {
> +			/*
> +			 * Leave the object in a consistent state,
> +			 * but return an error.
> +			 */
> +			s->capacity = i;
> +			return PTR_ERR(s->works[i]);
> +		}
> +	}
> +	s->capacity = new_capacity;
> +	return 0;
> +}
> +
> +/*
> + * tsync_works_contains - checks for presence of task in s
> + */
> +static bool tsync_works_contains_task(struct tsync_works *s,
> +				      struct task_struct *task)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < s->size; i++)
> +		if (s->works[i]->task == task)
> +			return true;
> +	return false;
> +}
> +
> +/*
> + * tsync_works_free - free memory held by s and drop all task references
> + */
> +static void tsync_works_free(struct tsync_works *s)

tsync_works_put() would be more appropriate since this function doesn't
free s.

> +{
> +	int i;
> +
> +	for (i = 0; i < s->size; i++)
> +		put_task_struct(s->works[i]->task);
> +	for (i = 0; i < s->capacity; i++)
> +		kfree(s->works[i]);
> +	kfree(s->works);
> +	s->works = NULL;
> +	s->size = 0;
> +	s->capacity = 0;
> +}
> +
> +/*
> + * restrict_sibling_threads - enables a Landlock policy for all sibling threads
> + */
> +static int restrict_sibling_threads(const struct cred *old_cred,
> +				    const struct cred *new_cred)
> +{
> +	int res;
> +	struct task_struct *thread, *caller;
> +	struct tsync_shared_context shared_ctx;
> +	struct tsync_works works = {};
> +	size_t newly_discovered_threads;
> +	bool found_more_threads;
> +	struct tsync_work *ctx;
> +
> +	atomic_set(&shared_ctx.preparation_error, 0);
> +	init_completion(&shared_ctx.all_prepared);
> +	init_completion(&shared_ctx.ready_to_commit);
> +	atomic_set(&shared_ctx.num_unfinished, 0);
> +	init_completion(&shared_ctx.all_finished);
> +	shared_ctx.old_cred = old_cred;
> +	shared_ctx.new_cred = new_cred;
> +
> +	caller = current;
> +
> +	/*
> +	 * We schedule a pseudo-signal task_work for each of the calling task's
> +	 * sibling threads.  In the task work, each thread:
> +	 *
> +	 * 1) runs prepare_creds() and writes back the error to
> +	 *    shared_ctx.preparation_error, if needed.
> +	 *
> +	 * 2) signals that it's done with prepare_creds() to the calling task.
> +	 *    (completion "all_prepared").
> +	 *
> +	 * 3) waits for the completion "ready_to_commit".  This is sent by the
> +	 *    calling task after ensuring that all sibling threads have done
> +	 *    with the "preparation" stage.
> +	 *
> +	 *    After this barrier is reached, it's safe to read
> +	 *    shared_ctx.preparation_error.
> +	 *
> +	 * 4) reads shared_ctx.preparation_error and then either does
> +	 *    commit_creds() or abort_creds().
> +	 *
> +	 * 5) signals that it's done altogether (barrier synchronization
> +	 *    "all_finished")
> +	 */
> +	do {
> +		found_more_threads = false;
> +
> +		/*
> +		 * The "all_prepared" barrier is used locally to the inner loop,
> +		 * this use of for_each_thread().  We can reset it on each loop
> +		 * iteration because all previous loop iterations are done with
> +		 * it already.
> +		 *
> +		 * num_preparing is initialized to 1 so that the counter can not
> +		 * go to 0 and mark the completion as done before all task works
> +		 * are registered.  (We decrement it at the end of this loop.)
> +		 */
> +		atomic_set(&shared_ctx.num_preparing, 1);
> +		reinit_completion(&shared_ctx.all_prepared);
> +
> +		/* In RCU read-lock, count the threads we need. */
> +		newly_discovered_threads = 0;
> +		rcu_read_lock();
> +		for_each_thread(caller, thread) {
> +			/* Skip current, since it is initiating the sync. */
> +			if (thread == caller)
> +				continue;
> +
> +			/* Skip exited threads. */
> +			if (thread->flags & PF_EXITING)
> +				continue;
> +
> +			/* Skip threads that we have already seen. */
> +			if (tsync_works_contains_task(&works, thread))
> +				continue;
> +
> +			newly_discovered_threads++;
> +		}
> +		rcu_read_unlock();
> +
> +		if (newly_discovered_threads == 0)
> +			break; /* done */
> +
> +		res = tsync_works_grow_by(&works, newly_discovered_threads,
> +					  GFP_KERNEL_ACCOUNT);
> +		if (res) {
> +			atomic_set(&shared_ctx.preparation_error, res);
> +			break;
> +		}
> +
> +		rcu_read_lock();
> +		for_each_thread(caller, thread) {
> +			/* Skip current, since it is initiating the sync. */
> +			if (thread == caller)
> +				continue;
> +
> +			/* Skip exited threads. */
> +			if (thread->flags & PF_EXITING)
> +				continue;
> +
> +			/* Skip threads that we already looked at. */
> +			if (tsync_works_contains_task(&works, thread))
> +				continue;
> +
> +			/*
> +			 * We found a sibling thread that is not doing its
> +			 * task_work yet, and which might spawn new threads
> +			 * before our task work runs, so we need at least one
> +			 * more round in the outer loop.
> +			 */
> +			found_more_threads = true;
> +
> +			ctx = tsync_works_provide(&works, thread);
> +			if (!ctx) {
> +				/*
> +				 * We ran out of preallocated contexts -- we
> +				 * need to try again with this thread at a later
> +				 * time!  found_more_threads is already true
> +				 * at this point.
> +				 */
> +				break;
> +			}
> +
> +			ctx->shared_ctx = &shared_ctx;
> +
> +			atomic_inc(&shared_ctx.num_preparing);
> +			atomic_inc(&shared_ctx.num_unfinished);
> +
> +			init_task_work(&ctx->work,
> +				       restrict_one_thread_callback);
> +			res = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> +			if (res) {
> +				/*
> +				 * Remove the task from ctx so that we will
> +				 * revisit the task at a later stage, if it
> +				 * still exists.
> +				 */
> +				put_task_struct_rcu_user(ctx->task);
> +				ctx->task = NULL;
> +
> +				atomic_set(&shared_ctx.preparation_error, res);
> +				atomic_dec(&shared_ctx.num_preparing);
> +				atomic_dec(&shared_ctx.num_unfinished);
> +			}
> +		}
> +		rcu_read_unlock();
> +
> +		/*
> +		 * Decrement num_preparing for current, to undo that we
> +		 * initialized it to 1 at the beginning of the inner loop.
> +		 */
> +		if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
> +			wait_for_completion(&shared_ctx.all_prepared);
> +	} while (found_more_threads &&
> +		 !atomic_read(&shared_ctx.preparation_error));
> +
> +	/*
> +	 * We now have all sibling threads blocking and in "prepared" state in
> +	 * the task work. Ask all threads to commit.
> +	 */
> +	complete_all(&shared_ctx.ready_to_commit);
> +
> +	if (works.size)
> +		wait_for_completion(&shared_ctx.all_finished);
> +
> +	tsync_works_free(&works);
> +
> +	return atomic_read(&shared_ctx.preparation_error);
> +}
> +
>  /**
>   * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
>   *
> @@ -454,12 +866,20 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>   *         - %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF
>   *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
>   *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
> + *         - %LANDLOCK_RESTRICT_SELF_TSYNC
>   *
> - * This system call enables to enforce a Landlock ruleset on the current
> - * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
> + * This system call enforces a Landlock ruleset on the current thread.
> + * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
>   * namespace or is running with no_new_privs.  This avoids scenarios where
>   * unprivileged tasks can affect the behavior of privileged children.
>   *
> + * If %LANDLOCK_RESTRICT_SELF_TSYNC is specified in @flags, all other threads of
> + * the process will be brought into the exact same Landlock configuration as the
> + * calling thread.  This includes both the enforced ruleset and logging
> + * configuration, and happens irrespective of previously established rulesets
> + * and logging configurations on these threads.  If required, this operation
> + * also enables the no_new_privs flag for these threads.
> + *
>   * Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> @@ -484,6 +904,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  	struct landlock_cred_security *new_llcred;
>  	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
>  		prev_log_subdomains;
> +	int res;
>  
>  	if (!is_initialized())
>  		return -EOPNOTSUPP;
> @@ -566,5 +987,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
>  #endif /* CONFIG_AUDIT */
>  
> +	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
> +		res = restrict_sibling_threads(current_cred(), new_cred);
> +		if (res != 0) {

if (!err) {

> +			abort_creds(new_cred);
> +			return res;
> +		}
> +	}
> +
>  	return commit_creds(new_cred);
>  }
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
> 

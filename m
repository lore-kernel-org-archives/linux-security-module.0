Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47A2D3A7C
	for <linux-security-module@vger.kernel.org>; Mon, 20 Oct 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991752; cv=none; b=GdQBLPAaiU8HJ5ULAKuYx2MptkCDGMkm5BQ4dvYPrGRbOmLEKBF2iVdrhG9hzg3gDJSUtngh62I0QvZx6lCqDsYaZSjb4dOFSuIAKfmB0Hcr6mRqx4n9vICciI+NpcQ0uq2Z+GVLgZHN7W6GRBOwxeZvnmJU/a5WjC1JrXDg2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991752; c=relaxed/simple;
	bh=6kNPhuRiBBz6eK85k02AcQPOM8SZT6X4c9MTYpvct88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOsxaq3NcqqvUc91CHA9TDZonauYBZi71QnUUtaXj3c9P4Tz3al2v36lxscUk/2WK36PttH5hq4NOFGfZrESXHTz46aVu9WcwnF8vfbLZauBXAUeWpc47XkZv5nJHWbQuOM3Z/TroP1iEqTCY0cEUD0pzdPx9cb5GSw5Ko1ZHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Wqm0DmOF; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Wqm0DmOF"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cr66j1JMyzXgN;
	Mon, 20 Oct 2025 22:12:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1760991165;
	bh=m6emVONqhZZHyt02jsZvQbeIf6OtX3AvAAi7i5edG6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wqm0DmOFHUXDTYU8CcZZ+w5vqMFGwNsYJm6Ny3+LUq4gpP2HQDBEHqErPx0vjHCbE
	 HgzgC7X+Uxldoib7dW7tUR510wqO4P95o4Nr3lYKRccY0aO73bSNUH1aL9BEPk7518
	 c4CPs+FKLlbmNHbDs7Z5A7Am1K9gO/dn66+b6X/s=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cr66h4tpkzWLP;
	Mon, 20 Oct 2025 22:12:44 +0200 (CEST)
Date: Mon, 20 Oct 2025 22:12:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20251020.fohbo6Iecahz@digikod.net>
/rom: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
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
>  4 files changed, 448 insertions(+), 3 deletions(-)

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

This RCU block could be moved in a dedicated helper that will return the
number of newly discovered threads.  In this helper, we could use
guard()(rcu).

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

As for the other RCU block, it might help to move this RCU block into a
dedicated helper.  It seems that it would look easier to read and
maintain.

> +
> +		/*
> +		 * Decrement num_preparing for current, to undo that we
> +		 * initialized it to 1 at the beginning of the inner loop.
> +		 */
> +		if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
> +			wait_for_completion(&shared_ctx.all_prepared);
> +	} while (found_more_threads &&
> +		 !atomic_read(&shared_ctx.preparation_error));

Is it safe to prevent inconsistencies wrt execve?  seccomp uses
cred_guard_mutex (new code should probably use exec_update_lock), why
should Landlock not do the same?

Why shouldn't we lock sighand as well?

Answers to these questions should be explained in comments.

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

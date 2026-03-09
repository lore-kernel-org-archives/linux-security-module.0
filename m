Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B52367B5
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078083; cv=none; b=HiostgyGLrf552zJufyguD6LaQqnppPwPX59ZToIMUHiKd2LTNox8DBkXvfyhVWS+znzQlldpcN5FbwX3rsAPHTDNRuMZhxKkp7DdyZP5DMNqnsP+vshRnPh8yc5i6aBsfXIi6kFeQVYg/0Yi1XoWAB4kZJ6XNs8OgHq/Wgoj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078083; c=relaxed/simple;
	bh=vvnhLC4v60DGIVE4hzcQutnZiSAO4gCwZEuDKVxOIbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwP/J3xSNzkZ5GIkP/g7cmZlhBWeLtLW+HooTIyLepPeXvd5EVd/F+hBIqNTcTxmEBnw4VSppPy9/I6OfK9nQ+0si3w2NfW/Zum/hW4iUq8XDn/flM+iu6bp/cOvGQ3PFXIC4mscpBJng/dwin1P8iesvV15FLA6mIbX4s+x/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YAEJWQKc; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YAEJWQKc"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fV40J3R2qzCTK;
	Mon,  9 Mar 2026 18:35:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773077712;
	bh=y5OX+9i3BOttrCeyJOOG2nIvNZNXt9kGM/gn72Ng6Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAEJWQKcfxynqTjw7m5v7jxQI8wNPh1YikK1F8uakg1EeZRSxUndoxxzRZaQMhJmL
	 qxlGpI5oTw0sMMqnAaQcN2165Gr4S9pDuhXEzh2eKn3QtZSymkYCwxCkQuciTRB81r
	 rc9EamYPpiAHPD0qjYcro+ZJMT8nCaV+2lP1mfJ4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fV40J0S2SzTN4;
	Mon,  9 Mar 2026 18:35:12 +0100 (CET)
Date: Mon, 9 Mar 2026 18:35:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 4/4] landlock: Fix formatting in tsync.c
Message-ID: <20260309.oXoob3Eghuyo@digikod.net>
References: <20260304193134.250495-1-mic@digikod.net>
 <20260304193134.250495-4-mic@digikod.net>
 <20260306.73159b8566b4@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306.73159b8566b4@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Mar 06, 2026 at 08:13:59AM +0100, Günther Noack wrote:
> On Wed, Mar 04, 2026 at 08:31:27PM +0100, Mickaël Salaün wrote:
> > Fix comment formatting in tsync.c to fit in 80 columns.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > My previous squashed fix was wrong.
> > ---
> >  security/landlock/tsync.c | 121 +++++++++++++++++++++-----------------
> >  1 file changed, 66 insertions(+), 55 deletions(-)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index 359aecbb1e4b..50445ae167dd 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -85,12 +85,14 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
> >  		/*
> >  		 * Switch out old_cred with new_cred, if possible.
> >  		 *
> > -		 * In the common case, where all threads initially point to the same
> > -		 * struct cred, this optimization avoids creating separate redundant
> > -		 * credentials objects for each, which would all have the same contents.
> > +		 * In the common case, where all threads initially point to the
> > +		 * same struct cred, this optimization avoids creating separate
> > +		 * redundant credentials objects for each, which would all have
> > +		 * the same contents.
> >  		 *
> > -		 * Note: We are intentionally dropping the const qualifier here, because
> > -		 * it is required by commit_creds() and abort_creds().
> > +		 * Note: We are intentionally dropping the const qualifier
> > +		 * here, because it is required by commit_creds() and
> > +		 * abort_creds().
> >  		 */
> >  		cred = (struct cred *)get_cred(ctx->new_cred);
> >  	} else {
> > @@ -101,8 +103,8 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
> >  			atomic_set(&ctx->preparation_error, -ENOMEM);
> >  
> >  			/*
> > -			 * Even on error, we need to adhere to the protocol and coordinate
> > -			 * with concurrently running invocations.
> > +			 * Even on error, we need to adhere to the protocol and
> > +			 * coordinate with concurrently running invocations.
> >  			 */
> >  			if (atomic_dec_return(&ctx->num_preparing) == 0)
> >  				complete_all(&ctx->all_prepared);
> > @@ -135,9 +137,9 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
> >  	}
> >  
> >  	/*
> > -	 * Make sure that all sibling tasks fulfill the no_new_privs prerequisite.
> > -	 * (This is in line with Seccomp's SECCOMP_FILTER_FLAG_TSYNC logic in
> > -	 * kernel/seccomp.c)
> > +	 * Make sure that all sibling tasks fulfill the no_new_privs
> > +	 * prerequisite.  (This is in line with Seccomp's
> > +	 * SECCOMP_FILTER_FLAG_TSYNC logic in kernel/seccomp.c)
> >  	 */
> >  	if (ctx->set_no_new_privs)
> >  		task_set_no_new_privs(current);
> > @@ -221,16 +223,17 @@ static void tsync_works_trim(struct tsync_works *s)
> >  	ctx = s->works[s->size - 1];
> >  
> >  	/*
> > -	 * For consistency, remove the task from ctx so that it does not look like
> > -	 * we handed it a task_work.
> > +	 * For consistency, remove the task from ctx so that it does not look
> > +	 * like we handed it a task_work.
> >  	 */
> >  	put_task_struct(ctx->task);
> >  	*ctx = (typeof(*ctx)){};
> >  
> >  	/*
> > -	 * Cancel the tsync_works_provide() change to recycle the reserved memory
> > -	 * for the next thread, if any.  This also ensures that cancel_tsync_works()
> > -	 * and tsync_works_release() do not see any NULL task pointers.
> > +	 * Cancel the tsync_works_provide() change to recycle the reserved
> > +	 * memory for the next thread, if any.  This also ensures that
> > +	 * cancel_tsync_works() and tsync_works_release() do not see any NULL
> > +	 * task pointers.
> >  	 */
> >  	s->size--;
> >  }
> > @@ -388,17 +391,17 @@ static bool schedule_task_work(struct tsync_works *works,
> >  			continue;
> >  
> >  		/*
> > -		 * We found a sibling thread that is not doing its task_work yet, and
> > -		 * which might spawn new threads before our task work runs, so we need
> > -		 * at least one more round in the outer loop.
> > +		 * We found a sibling thread that is not doing its task_work
> > +		 * yet, and which might spawn new threads before our task work
> > +		 * runs, so we need at least one more round in the outer loop.
> >  		 */
> >  		found_more_threads = true;
> >  
> >  		ctx = tsync_works_provide(works, thread);
> >  		if (!ctx) {
> >  			/*
> > -			 * We ran out of preallocated contexts -- we need to try again with
> > -			 * this thread at a later time!
> > +			 * We ran out of preallocated contexts -- we need to
> > +			 * try again with this thread at a later time!
> >  			 * found_more_threads is already true at this point.
> >  			 */
> >  			break;
> > @@ -413,10 +416,10 @@ static bool schedule_task_work(struct tsync_works *works,
> >  		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> >  		if (unlikely(err)) {
> >  			/*
> > -			 * task_work_add() only fails if the task is about to exit.  We
> > -			 * checked that earlier, but it can happen as a race.  Resume
> > -			 * without setting an error, as the task is probably gone in the
> > -			 * next loop iteration.
> > +			 * task_work_add() only fails if the task is about to
> > +			 * exit.  We checked that earlier, but it can happen as
> > +			 * a race.  Resume without setting an error, as the
> > +			 * task is probably gone in the next loop iteration.
> >  			 */
> >  			tsync_works_trim(works);
> >  
> > @@ -497,24 +500,25 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	 *    After this barrier is reached, it's safe to read
> >  	 *    shared_ctx.preparation_error.
> >  	 *
> > -	 * 4) reads shared_ctx.preparation_error and then either does commit_creds()
> > -	 *    or abort_creds().
> > +	 * 4) reads shared_ctx.preparation_error and then either does
> > +	 *    commit_creds() or abort_creds().
> >  	 *
> >  	 * 5) signals that it's done altogether (barrier synchronization
> >  	 *    "all_finished")
> >  	 *
> > -	 * Unlike seccomp, which modifies sibling tasks directly, we do not need to
> > -	 * acquire the cred_guard_mutex and sighand->siglock:
> > +	 * Unlike seccomp, which modifies sibling tasks directly, we do not
> > +	 * need to acquire the cred_guard_mutex and sighand->siglock:
> >  	 *
> > -	 * - As in our case, all threads are themselves exchanging their own struct
> > -	 *   cred through the credentials API, no locks are needed for that.
> > +	 * - As in our case, all threads are themselves exchanging their own
> > +	 *   struct cred through the credentials API, no locks are needed for
> > +	 *   that.
> >  	 * - Our for_each_thread() loops are protected by RCU.
> > -	 * - We do not acquire a lock to keep the list of sibling threads stable
> > -	 *   between our for_each_thread loops.  If the list of available sibling
> > -	 *   threads changes between these for_each_thread loops, we make up for
> > -	 *   that by continuing to look for threads until they are all discovered
> > -	 *   and have entered their task_work, where they are unable to spawn new
> > -	 *   threads.
> > +	 * - We do not acquire a lock to keep the list of sibling threads
> > +	 *   stable between our for_each_thread loops.  If the list of
> > +	 *   available sibling threads changes between these for_each_thread
> > +	 *   loops, we make up for that by continuing to look for threads until
> > +	 *   they are all discovered and have entered their task_work, where
> > +	 *   they are unable to spawn new threads.
> >  	 */
> >  	do {
> >  		/* In RCU read-lock, count the threads we need. */
> > @@ -531,43 +535,50 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  		}
> >  
> >  		/*
> > -		 * The "all_prepared" barrier is used locally to the loop body, this use
> > -		 * of for_each_thread().  We can reset it on each loop iteration because
> > -		 * all previous loop iterations are done with it already.
> > +		 * The "all_prepared" barrier is used locally to the loop body,
> > +		 * this use of for_each_thread().  We can reset it on each loop
> > +		 * iteration because all previous loop iterations are done with
> > +		 * it already.
> >  		 *
> > -		 * num_preparing is initialized to 1 so that the counter can not go to 0
> > -		 * and mark the completion as done before all task works are registered.
> > -		 * We decrement it at the end of the loop body.
> > +		 * num_preparing is initialized to 1 so that the counter can
> > +		 * not go to 0 and mark the completion as done before all task
> > +		 * works are registered.  We decrement it at the end of the
> > +		 * loop body.
> >  		 */
> >  		atomic_set(&shared_ctx.num_preparing, 1);
> >  		reinit_completion(&shared_ctx.all_prepared);
> >  
> >  		/*
> > -		 * In RCU read-lock, schedule task work on newly discovered sibling
> > -		 * tasks.
> > +		 * In RCU read-lock, schedule task work on newly discovered
> > +		 * sibling tasks.
> >  		 */
> >  		found_more_threads = schedule_task_work(&works, &shared_ctx);
> >  
> >  		/*
> > -		 * Decrement num_preparing for current, to undo that we initialized it
> > -		 * to 1 a few lines above.
> > +		 * Decrement num_preparing for current, to undo that we
> > +		 * initialized it to 1 a few lines above.
> >  		 */
> >  		if (atomic_dec_return(&shared_ctx.num_preparing) > 0) {
> >  			if (wait_for_completion_interruptible(
> >  				    &shared_ctx.all_prepared)) {
> > -				/* In case of interruption, we need to retry the system call. */
> > +				/*
> > +				 * In case of interruption, we need to retry
> > +				 * the system call.
> > +				 */
> >  				atomic_set(&shared_ctx.preparation_error,
> >  					   -ERESTARTNOINTR);
> >  
> >  				/*
> > -				 * Cancel task works for tasks that did not start running yet,
> > -				 * and decrement all_prepared and num_unfinished accordingly.
> > +				 * Cancel task works for tasks that did not
> > +				 * start running yet, and decrement
> > +				 * all_prepared and num_unfinished accordingly.
> >  				 */
> >  				cancel_tsync_works(&works, &shared_ctx);
> >  
> >  				/*
> > -				 * The remaining task works have started running, so waiting for
> > -				 * their completion will finish.
> > +				 * The remaining task works have started
> > +				 * running, so waiting for their completion
> > +				 * will finish.
> >  				 */
> >  				wait_for_completion(&shared_ctx.all_prepared);
> >  			}
> > @@ -576,14 +587,14 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  		 !atomic_read(&shared_ctx.preparation_error));
> >  
> >  	/*
> > -	 * We now have all sibling threads blocking and in "prepared" state in the
> > -	 * task work. Ask all threads to commit.
> > +	 * We now have all sibling threads blocking and in "prepared" state in
> > +	 * the task work. Ask all threads to commit.
> >  	 */
> >  	complete_all(&shared_ctx.ready_to_commit);
> >  
> >  	/*
> > -	 * Decrement num_unfinished for current, to undo that we initialized it to 1
> > -	 * at the beginning.
> > +	 * Decrement num_unfinished for current, to undo that we initialized it
> > +	 * to 1 at the beginning.
> >  	 */
> >  	if (atomic_dec_return(&shared_ctx.num_unfinished) > 0)
> >  		wait_for_completion(&shared_ctx.all_finished);
> > -- 
> > 2.53.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> Thanks!  (It's irritating that the default clang-format configuration
> does not fix these.  Do you use a special tool for this?)

I mostly use vim's colorcolumn but I should update check-linux.sh with
such check.

I guess you're also OK with the first patch?

> 
> –Günther
> 

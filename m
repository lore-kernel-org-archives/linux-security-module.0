Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865136BCF6
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781245; cv=none; b=oR9PEwM7ZezTE0MI0jIyn18rAP6mDFFc/Ah7A2UpaFalBvgfJuGsXsntapv1K37wA7zhwfTYkMtPXidMaEcyEFK0aGPCrn/8Ha236Bw53KhASzQV+DpkS7HQt0IqyEKbsmH9mbeyUG6Myjj1BIilPzfHXd3vbCi+C1/ttlDhTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781245; c=relaxed/simple;
	bh=2PGiCuMN+n9rFou3eLIePPRnGP/YD/HizgF6EC76/EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB4Mn6MXNmqMU54pNSA8WJy2CjhS5QEnjCSsRGuAahArHT/tOEUjYDz964ITcvnUXLZE/830HQy4VNuCE6MC8jNxrcIRizgi4lFb1T5iHNS7KoHqSdMa6Cjqev/iEFM9YMDlBggnIQEI1EbGDqHTbFUhlE45vTA7g2ZLbfWl2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLIhyaW1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLIhyaW1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so3358353f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2026 23:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772781242; x=1773386042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Q2qCPlrSr4Ebww2v5WVaIlgnzlaKHHAI78qaSGWtXA=;
        b=NLIhyaW1RYhI4tvAnkuCsAJqkHe9H0VDcGkrsGktP4Rp8LCMsROQnEbhHAQF5ctMQa
         VJy6WZegKnCqrQwxTC1y8A9zniivrPBcnW5HIpP66Of17nZkkRGUAQySYR6uocvIpE3S
         3xMUYG7oriva0maPkuXtU2fOYcPBQhuiLtx7eBzzRQ8gAvbcYdBCcWoVfY2qkNwe6Oof
         Uw3dazSWjpDKu3wC7KjFPWEBfSL9WE22KKO4JQv4iImAkoavoahOp9t++CnpDk7+1Kcz
         c7X7PRk9hWRu83mQBtyh9mytXPxWoA4XpF7ixkxLHTNka/4XHKpAzkEMnMrbYvtrH/yo
         T9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781242; x=1773386042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Q2qCPlrSr4Ebww2v5WVaIlgnzlaKHHAI78qaSGWtXA=;
        b=atqC4l5IGVjtObe5m4pLvaTOsAmQcPeBGHa1PO2hl9UKmJfavh3jlw83dJWzFxN8dG
         on2Eyr65lGwhQvdPjLvfzUeaTJ7QKKYtPPZHHHk0NymK0FvDw6dyu/np1cmbBUQEhiR9
         7Pp+NrRSZAqwsfZCfvEto1pV6I23eY28vmrqqlwupc+szSBgf3Tv/Nd1KueI7CqG/qoc
         FDaDJId971qixpCOzob6IS3iPS/OmgBnk0YAHKoGKdrEA6fP4FVIDMFH89OKgPtg9l9v
         a8pzBS9FYljP2/2F2/WkAgyv7/mQh+9NtozJX+bs5f6ss1hkiGrBPhgGCAkIKjQzKkad
         FMJA==
X-Forwarded-Encrypted: i=1; AJvYcCXUtmn6n4dmcKih11hyXh62UlOmCGRjGWMcAkcXGiFRmTNk1PXKUAlUtcThzENnEtwh0D9TiVoIpGL9CRGWWU44SitJTu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWV/+XDU8u6y8Sw13EWZZ7vL8VDO5YlDRe9ztwZCGUShw0mCRu
	sSeRw7FAoDcagMQbNW13aQs1ET+YlHGNIgm4+BfInnUvep1iVUgof3+G
X-Gm-Gg: ATEYQzyspvte4wXQyBa9+ebyF/C78KqWTmz96dZUfibb8wXD0QfDo17kNmrL2mnsb3Z
	amSSI6QlYz5SK1Vb498tvkU0K3dMCNS455YHbkgmIz6quia/Nir7x4pmn5kxc7SD1dchUtaYpxL
	rntfUj++y9Hnfsk4krtrMDxDjO25RWJJMDO6Cg+6RK7rwQCjS8tN4gPkZsfqtNEdCX0nFbsW8O6
	8sPEAYvMQ+oizRKuu4rKUEuMiKrFesbCQYdM8E7FbzUTdEbMTgshttpm2B476CLutREpANeCIGt
	PNyBWSAHnT5jSJD/GE2gPm2K3cj/qcWdHTmKGMnCrRfL5EVk+zZOY66pcczZzbNAPfwMHWBrWff
	5Tn5K8tjwlY4/Z+b7SCVGFqXN8bgwE4eDdDMiXp7OU+GCho2Qr5rZwAEunk/p3brR5PhBNjQ+j3
	M74n5F8wFKHyzYEWWL9026Tc8ImJXpTRXGZB/2KiIUDEATX7hZ
X-Received: by 2002:a05:6000:310c:b0:439:bd46:41ec with SMTP id ffacd0b85a97d-439da348416mr1702736f8f.2.1772781241429;
        Thu, 05 Mar 2026 23:14:01 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dada3b43sm1623926f8f.13.2026.03.05.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:14:00 -0800 (PST)
Date: Fri, 6 Mar 2026 08:13:59 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 4/4] landlock: Fix formatting in tsync.c
Message-ID: <20260306.73159b8566b4@gnoack.org>
References: <20260304193134.250495-1-mic@digikod.net>
 <20260304193134.250495-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304193134.250495-4-mic@digikod.net>

On Wed, Mar 04, 2026 at 08:31:27PM +0100, Mickaël Salaün wrote:
> Fix comment formatting in tsync.c to fit in 80 columns.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> My previous squashed fix was wrong.
> ---
>  security/landlock/tsync.c | 121 +++++++++++++++++++++-----------------
>  1 file changed, 66 insertions(+), 55 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 359aecbb1e4b..50445ae167dd 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -85,12 +85,14 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
>  		/*
>  		 * Switch out old_cred with new_cred, if possible.
>  		 *
> -		 * In the common case, where all threads initially point to the same
> -		 * struct cred, this optimization avoids creating separate redundant
> -		 * credentials objects for each, which would all have the same contents.
> +		 * In the common case, where all threads initially point to the
> +		 * same struct cred, this optimization avoids creating separate
> +		 * redundant credentials objects for each, which would all have
> +		 * the same contents.
>  		 *
> -		 * Note: We are intentionally dropping the const qualifier here, because
> -		 * it is required by commit_creds() and abort_creds().
> +		 * Note: We are intentionally dropping the const qualifier
> +		 * here, because it is required by commit_creds() and
> +		 * abort_creds().
>  		 */
>  		cred = (struct cred *)get_cred(ctx->new_cred);
>  	} else {
> @@ -101,8 +103,8 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
>  			atomic_set(&ctx->preparation_error, -ENOMEM);
>  
>  			/*
> -			 * Even on error, we need to adhere to the protocol and coordinate
> -			 * with concurrently running invocations.
> +			 * Even on error, we need to adhere to the protocol and
> +			 * coordinate with concurrently running invocations.
>  			 */
>  			if (atomic_dec_return(&ctx->num_preparing) == 0)
>  				complete_all(&ctx->all_prepared);
> @@ -135,9 +137,9 @@ static void restrict_one_thread(struct tsync_shared_context *ctx)
>  	}
>  
>  	/*
> -	 * Make sure that all sibling tasks fulfill the no_new_privs prerequisite.
> -	 * (This is in line with Seccomp's SECCOMP_FILTER_FLAG_TSYNC logic in
> -	 * kernel/seccomp.c)
> +	 * Make sure that all sibling tasks fulfill the no_new_privs
> +	 * prerequisite.  (This is in line with Seccomp's
> +	 * SECCOMP_FILTER_FLAG_TSYNC logic in kernel/seccomp.c)
>  	 */
>  	if (ctx->set_no_new_privs)
>  		task_set_no_new_privs(current);
> @@ -221,16 +223,17 @@ static void tsync_works_trim(struct tsync_works *s)
>  	ctx = s->works[s->size - 1];
>  
>  	/*
> -	 * For consistency, remove the task from ctx so that it does not look like
> -	 * we handed it a task_work.
> +	 * For consistency, remove the task from ctx so that it does not look
> +	 * like we handed it a task_work.
>  	 */
>  	put_task_struct(ctx->task);
>  	*ctx = (typeof(*ctx)){};
>  
>  	/*
> -	 * Cancel the tsync_works_provide() change to recycle the reserved memory
> -	 * for the next thread, if any.  This also ensures that cancel_tsync_works()
> -	 * and tsync_works_release() do not see any NULL task pointers.
> +	 * Cancel the tsync_works_provide() change to recycle the reserved
> +	 * memory for the next thread, if any.  This also ensures that
> +	 * cancel_tsync_works() and tsync_works_release() do not see any NULL
> +	 * task pointers.
>  	 */
>  	s->size--;
>  }
> @@ -388,17 +391,17 @@ static bool schedule_task_work(struct tsync_works *works,
>  			continue;
>  
>  		/*
> -		 * We found a sibling thread that is not doing its task_work yet, and
> -		 * which might spawn new threads before our task work runs, so we need
> -		 * at least one more round in the outer loop.
> +		 * We found a sibling thread that is not doing its task_work
> +		 * yet, and which might spawn new threads before our task work
> +		 * runs, so we need at least one more round in the outer loop.
>  		 */
>  		found_more_threads = true;
>  
>  		ctx = tsync_works_provide(works, thread);
>  		if (!ctx) {
>  			/*
> -			 * We ran out of preallocated contexts -- we need to try again with
> -			 * this thread at a later time!
> +			 * We ran out of preallocated contexts -- we need to
> +			 * try again with this thread at a later time!
>  			 * found_more_threads is already true at this point.
>  			 */
>  			break;
> @@ -413,10 +416,10 @@ static bool schedule_task_work(struct tsync_works *works,
>  		err = task_work_add(thread, &ctx->work, TWA_SIGNAL);
>  		if (unlikely(err)) {
>  			/*
> -			 * task_work_add() only fails if the task is about to exit.  We
> -			 * checked that earlier, but it can happen as a race.  Resume
> -			 * without setting an error, as the task is probably gone in the
> -			 * next loop iteration.
> +			 * task_work_add() only fails if the task is about to
> +			 * exit.  We checked that earlier, but it can happen as
> +			 * a race.  Resume without setting an error, as the
> +			 * task is probably gone in the next loop iteration.
>  			 */
>  			tsync_works_trim(works);
>  
> @@ -497,24 +500,25 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	 *    After this barrier is reached, it's safe to read
>  	 *    shared_ctx.preparation_error.
>  	 *
> -	 * 4) reads shared_ctx.preparation_error and then either does commit_creds()
> -	 *    or abort_creds().
> +	 * 4) reads shared_ctx.preparation_error and then either does
> +	 *    commit_creds() or abort_creds().
>  	 *
>  	 * 5) signals that it's done altogether (barrier synchronization
>  	 *    "all_finished")
>  	 *
> -	 * Unlike seccomp, which modifies sibling tasks directly, we do not need to
> -	 * acquire the cred_guard_mutex and sighand->siglock:
> +	 * Unlike seccomp, which modifies sibling tasks directly, we do not
> +	 * need to acquire the cred_guard_mutex and sighand->siglock:
>  	 *
> -	 * - As in our case, all threads are themselves exchanging their own struct
> -	 *   cred through the credentials API, no locks are needed for that.
> +	 * - As in our case, all threads are themselves exchanging their own
> +	 *   struct cred through the credentials API, no locks are needed for
> +	 *   that.
>  	 * - Our for_each_thread() loops are protected by RCU.
> -	 * - We do not acquire a lock to keep the list of sibling threads stable
> -	 *   between our for_each_thread loops.  If the list of available sibling
> -	 *   threads changes between these for_each_thread loops, we make up for
> -	 *   that by continuing to look for threads until they are all discovered
> -	 *   and have entered their task_work, where they are unable to spawn new
> -	 *   threads.
> +	 * - We do not acquire a lock to keep the list of sibling threads
> +	 *   stable between our for_each_thread loops.  If the list of
> +	 *   available sibling threads changes between these for_each_thread
> +	 *   loops, we make up for that by continuing to look for threads until
> +	 *   they are all discovered and have entered their task_work, where
> +	 *   they are unable to spawn new threads.
>  	 */
>  	do {
>  		/* In RCU read-lock, count the threads we need. */
> @@ -531,43 +535,50 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		}
>  
>  		/*
> -		 * The "all_prepared" barrier is used locally to the loop body, this use
> -		 * of for_each_thread().  We can reset it on each loop iteration because
> -		 * all previous loop iterations are done with it already.
> +		 * The "all_prepared" barrier is used locally to the loop body,
> +		 * this use of for_each_thread().  We can reset it on each loop
> +		 * iteration because all previous loop iterations are done with
> +		 * it already.
>  		 *
> -		 * num_preparing is initialized to 1 so that the counter can not go to 0
> -		 * and mark the completion as done before all task works are registered.
> -		 * We decrement it at the end of the loop body.
> +		 * num_preparing is initialized to 1 so that the counter can
> +		 * not go to 0 and mark the completion as done before all task
> +		 * works are registered.  We decrement it at the end of the
> +		 * loop body.
>  		 */
>  		atomic_set(&shared_ctx.num_preparing, 1);
>  		reinit_completion(&shared_ctx.all_prepared);
>  
>  		/*
> -		 * In RCU read-lock, schedule task work on newly discovered sibling
> -		 * tasks.
> +		 * In RCU read-lock, schedule task work on newly discovered
> +		 * sibling tasks.
>  		 */
>  		found_more_threads = schedule_task_work(&works, &shared_ctx);
>  
>  		/*
> -		 * Decrement num_preparing for current, to undo that we initialized it
> -		 * to 1 a few lines above.
> +		 * Decrement num_preparing for current, to undo that we
> +		 * initialized it to 1 a few lines above.
>  		 */
>  		if (atomic_dec_return(&shared_ctx.num_preparing) > 0) {
>  			if (wait_for_completion_interruptible(
>  				    &shared_ctx.all_prepared)) {
> -				/* In case of interruption, we need to retry the system call. */
> +				/*
> +				 * In case of interruption, we need to retry
> +				 * the system call.
> +				 */
>  				atomic_set(&shared_ctx.preparation_error,
>  					   -ERESTARTNOINTR);
>  
>  				/*
> -				 * Cancel task works for tasks that did not start running yet,
> -				 * and decrement all_prepared and num_unfinished accordingly.
> +				 * Cancel task works for tasks that did not
> +				 * start running yet, and decrement
> +				 * all_prepared and num_unfinished accordingly.
>  				 */
>  				cancel_tsync_works(&works, &shared_ctx);
>  
>  				/*
> -				 * The remaining task works have started running, so waiting for
> -				 * their completion will finish.
> +				 * The remaining task works have started
> +				 * running, so waiting for their completion
> +				 * will finish.
>  				 */
>  				wait_for_completion(&shared_ctx.all_prepared);
>  			}
> @@ -576,14 +587,14 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		 !atomic_read(&shared_ctx.preparation_error));
>  
>  	/*
> -	 * We now have all sibling threads blocking and in "prepared" state in the
> -	 * task work. Ask all threads to commit.
> +	 * We now have all sibling threads blocking and in "prepared" state in
> +	 * the task work. Ask all threads to commit.
>  	 */
>  	complete_all(&shared_ctx.ready_to_commit);
>  
>  	/*
> -	 * Decrement num_unfinished for current, to undo that we initialized it to 1
> -	 * at the beginning.
> +	 * Decrement num_unfinished for current, to undo that we initialized it
> +	 * to 1 at the beginning.
>  	 */
>  	if (atomic_dec_return(&shared_ctx.num_unfinished) > 0)
>  		wait_for_completion(&shared_ctx.all_finished);
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thanks!  (It's irritating that the default clang-format configuration
does not fix these.  Do you use a special tool for this?)

–Günther

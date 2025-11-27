Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B412DA755
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764237400; cv=none; b=SDo8W2dR0pdq7JdC5xt7ZPcXsMqa71ct+OsKO0lQADL6i2/hDoDelsMKqfJoWjADFj4KUhIhZ9sWlcTotzynV4+WiEqntzZUNV2Tr81GXkg+bD79Gb1Yz8lE+9iMQHicB6ssFHUy5jD3C6U+tjmrZt7JuYrq37pYRgBlod5bq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764237400; c=relaxed/simple;
	bh=RVFZ72QSFRW3SzU6u2DWUv8oW61AMfWGq9cmcgVhZKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwC1TsLLV1rXHBWyr4X8ww2nIRR58ntBs7TguyKkrqVugKdQJRjR7oZSWkkmvfINwH+tL8W+gzRuEzqxFIzR96rAiYT7RHRyQoIr1ug5lrKvaIFL2pRHmjPc6xONiNRO+I0klBCDxozt/srtiMu+MNFCJJEikqsbFFWGp/NKIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT7jpvvp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT7jpvvp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso431113f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 01:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764237396; x=1764842196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mixXIpXqN4gwl09Ckd7GpapZPbGIXTWxeRisfJedRLc=;
        b=fT7jpvvpcda20B3E6Q4tqOxAn1gZc2yxfZID6jcAMjfSDt48StvxB9GJEu8JxAO1pU
         jGoIhqrUqUbKu0dBxMWmR588h92iz5GFO3RQZ5shaOTB0cl7xm/ePvqjGygy7tDJx3K7
         thKIUQR4hauEx9Zz7yJ+FTfR3MnbeAoRefX9h8imWY5wiEvb7+N1ZVNKl+XUUFPHwZY7
         gfoPMsqRVv/RHMQZwqFllyj3MtWPrrCg6P+Wh0PwED9V7jVZfWb71nWAIEhAEPoIGgzs
         9iR4IhyD60qlxBkK8700l1bQw3r7ui1JM/BQnhtx/o2HjLuXIq8WeowrUypfTFb7AwGi
         xfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764237396; x=1764842196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mixXIpXqN4gwl09Ckd7GpapZPbGIXTWxeRisfJedRLc=;
        b=AK6wuIlBweL2V4/cS+IVrpQXey0vAIFjdhkoX9K6fedMDBPSVbZHk13J3sb8Oq+d9I
         SNWy19Qzaoxdxb6UooqwySE2Ntn2MBLrIDa0gyNcsuU9F7t6jCjMj0mfjoBsJBV3BjVU
         Mv92exk4CXleesUT9XD3wxc0cxuzcXzSpSBCL6orG45zJoyKXFrsBaRjxdSX2IUv/toE
         bZ7JPV/OZK2uoOa09wo6pTEw2ah1lTUBlWaherIj4CqlOBFTdMZhDl24hWud9biUgPc9
         2I8Zc7AhtGpgAsjdKx/YPOq59Cc4nEDgkIP4b9wtwZjHE0VQvuguVuAkbH1qF24NF3D8
         wiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+WMXA9BH9Kt1WQaMZmFZrKCW+A7MUGanerRoYZNtQ6yy0LJ7SDBNKYPdsE+tW8To5udvuq885+4cLAessuFYMm8U6YQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJz4LH+uIzQOPMHr0psx/ciWTnfJuCfn0eg9+pni7y2JTxs2QE
	gQWQAgoXBwQY36bEs8ku/BMWyBNuAP0kgfRvnoXA+xtJ8jRS4AlqMYnDbHe3xEME+g==
X-Gm-Gg: ASbGncuVPTdenAppcGrC4+pty1skpDMAVmY7WPpmmoqo7oXkDswgD5HAsi/DxlKMNCd
	uA6NrbrQ6VTjQ3tU9dUzWA0u1OvEGQj3q6lr5O3IoaoPdSRHmZY+GE0yJlvFAxPCVfRKRaZWxeB
	29DTwMMmGd2rtrv+avHtumkot9yIP85ybYGIY0C23PqUwjXkWAmTyOgkpafhKOE2C3pP521DFov
	EvDy2ZupKlPAW6+lx/jVW5VQWkAEG/X++tTkvFVPB/QXhGhrXMFS2lujTJmf6qR76NlRVCHHFQ8
	nAp6wTDDoso+UcKb4MFy8sSAjlOhpMG2DJzvlPSjL8eg2FSZZSykeaL5mYK9DWmcN0OtqoqYwSs
	Dp78OS/ODYlS1RBK5CnCwtBy/9zME3oUOv6OnxyU/LzRHG4UNskGQsM9FOAu9gqIlhoOLkL5FJv
	w6s2CxAoEyefY8GvozjOLChKADgAbTeUvc5l6TV77fwU9gFbEAqhmi
X-Google-Smtp-Source: AGHT+IGoWAoFksveT7Rx/wWdOH6V8kdb8agbErlkrGXJzQ6hovBHckmpFUbm/fumDNZShOGQEAdIGA==
X-Received: by 2002:a05:6000:2681:b0:42b:41a6:a670 with SMTP id ffacd0b85a97d-42cc1d51b98mr24593389f8f.54.1764237396295;
        Thu, 27 Nov 2025 01:56:36 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:2372:89e8:ec59:7515])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5e3857sm2948906f8f.19.2025.11.27.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:56:35 -0800 (PST)
Date: Thu, 27 Nov 2025 10:56:31 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <aSggT4V8U1XE0-iI@google.com>
References: <20251001111807.18902-1-gnoack@google.com>
 <20251001111807.18902-2-gnoack@google.com>
 <20251020.fohbo6Iecahz@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020.fohbo6Iecahz@digikod.net>

Hello!

On Mon, Oct 20, 2025 at 10:12:44PM +0200, Mickaël Salaün wrote:
> On Wed, Oct 01, 2025 at 01:18:06PM +0200, Günther Noack wrote:
> > +/*
> > + * restrict_sibling_threads - enables a Landlock policy for all sibling threads
> > + */
> > +static int restrict_sibling_threads(const struct cred *old_cred,
> > +				    const struct cred *new_cred)
> > +{
> > +	int res;
> > +	struct task_struct *thread, *caller;
> > +	struct tsync_shared_context shared_ctx;
> > +	struct tsync_works works = {};
> > +	size_t newly_discovered_threads;
> > +	bool found_more_threads;
> > +	struct tsync_work *ctx;
> > +
> > +	atomic_set(&shared_ctx.preparation_error, 0);
> > +	init_completion(&shared_ctx.all_prepared);
> > +	init_completion(&shared_ctx.ready_to_commit);
> > +	atomic_set(&shared_ctx.num_unfinished, 0);
> > +	init_completion(&shared_ctx.all_finished);
> > +	shared_ctx.old_cred = old_cred;
> > +	shared_ctx.new_cred = new_cred;
> > +
> > +	caller = current;
> > +
> > +	/*
> > +	 * We schedule a pseudo-signal task_work for each of the calling task's
> > +	 * sibling threads.  In the task work, each thread:
> > +	 *
> > +	 * 1) runs prepare_creds() and writes back the error to
> > +	 *    shared_ctx.preparation_error, if needed.
> > +	 *
> > +	 * 2) signals that it's done with prepare_creds() to the calling task.
> > +	 *    (completion "all_prepared").
> > +	 *
> > +	 * 3) waits for the completion "ready_to_commit".  This is sent by the
> > +	 *    calling task after ensuring that all sibling threads have done
> > +	 *    with the "preparation" stage.
> > +	 *
> > +	 *    After this barrier is reached, it's safe to read
> > +	 *    shared_ctx.preparation_error.
> > +	 *
> > +	 * 4) reads shared_ctx.preparation_error and then either does
> > +	 *    commit_creds() or abort_creds().
> > +	 *
> > +	 * 5) signals that it's done altogether (barrier synchronization
> > +	 *    "all_finished")
> > +	 */
> > +	do {
> > +		found_more_threads = false;
> > +
> > +		/*
> > +		 * The "all_prepared" barrier is used locally to the inner loop,
> > +		 * this use of for_each_thread().  We can reset it on each loop
> > +		 * iteration because all previous loop iterations are done with
> > +		 * it already.
> > +		 *
> > +		 * num_preparing is initialized to 1 so that the counter can not
> > +		 * go to 0 and mark the completion as done before all task works
> > +		 * are registered.  (We decrement it at the end of this loop.)
> > +		 */
> > +		atomic_set(&shared_ctx.num_preparing, 1);
> > +		reinit_completion(&shared_ctx.all_prepared);
> > +
> 
> > +		/* In RCU read-lock, count the threads we need. */
> > +		newly_discovered_threads = 0;
> > +		rcu_read_lock();
> > +		for_each_thread(caller, thread) {
> > +			/* Skip current, since it is initiating the sync. */
> > +			if (thread == caller)
> > +				continue;
> > +
> > +			/* Skip exited threads. */
> > +			if (thread->flags & PF_EXITING)
> > +				continue;
> > +
> > +			/* Skip threads that we have already seen. */
> > +			if (tsync_works_contains_task(&works, thread))
> > +				continue;
> > +
> > +			newly_discovered_threads++;
> > +		}
> > +		rcu_read_unlock();
> 
> This RCU block could be moved in a dedicated helper that will return the
> number of newly discovered threads.  In this helper, we could use
> guard()(rcu).

Done.


> > +
> > +		if (newly_discovered_threads == 0)
> > +			break; /* done */
> > +
> > +		res = tsync_works_grow_by(&works, newly_discovered_threads,
> > +					  GFP_KERNEL_ACCOUNT);
> > +		if (res) {
> > +			atomic_set(&shared_ctx.preparation_error, res);
> > +			break;
> > +		}
> > +
> > +		rcu_read_lock();
> > +		for_each_thread(caller, thread) {
> > +			/* Skip current, since it is initiating the sync. */
> > +			if (thread == caller)
> > +				continue;
> > +
> > +			/* Skip exited threads. */
> > +			if (thread->flags & PF_EXITING)
> > +				continue;
> > +
> > +			/* Skip threads that we already looked at. */
> > +			if (tsync_works_contains_task(&works, thread))
> > +				continue;
> > +
> > +			/*
> > +			 * We found a sibling thread that is not doing its
> > +			 * task_work yet, and which might spawn new threads
> > +			 * before our task work runs, so we need at least one
> > +			 * more round in the outer loop.
> > +			 */
> > +			found_more_threads = true;
> > +
> > +			ctx = tsync_works_provide(&works, thread);
> > +			if (!ctx) {
> > +				/*
> > +				 * We ran out of preallocated contexts -- we
> > +				 * need to try again with this thread at a later
> > +				 * time!  found_more_threads is already true
> > +				 * at this point.
> > +				 */
> > +				break;
> > +			}
> > +
> > +			ctx->shared_ctx = &shared_ctx;
> > +
> > +			atomic_inc(&shared_ctx.num_preparing);
> > +			atomic_inc(&shared_ctx.num_unfinished);
> > +
> > +			init_task_work(&ctx->work,
> > +				       restrict_one_thread_callback);
> > +			res = task_work_add(thread, &ctx->work, TWA_SIGNAL);
> > +			if (res) {
> > +				/*
> > +				 * Remove the task from ctx so that we will
> > +				 * revisit the task at a later stage, if it
> > +				 * still exists.
> > +				 */
> > +				put_task_struct_rcu_user(ctx->task);
> > +				ctx->task = NULL;
> > +
> > +				atomic_set(&shared_ctx.preparation_error, res);
> > +				atomic_dec(&shared_ctx.num_preparing);
> > +				atomic_dec(&shared_ctx.num_unfinished);
> > +			}
> > +		}
> > +		rcu_read_unlock();
> 
> As for the other RCU block, it might help to move this RCU block into a
> dedicated helper.  It seems that it would look easier to read and
> maintain.

Done.


> > +		/*
> > +		 * Decrement num_preparing for current, to undo that we
> > +		 * initialized it to 1 at the beginning of the inner loop.
> > +		 */
> > +		if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
> > +			wait_for_completion(&shared_ctx.all_prepared);
> > +	} while (found_more_threads &&
> > +		 !atomic_read(&shared_ctx.preparation_error));
> 
> Is it safe to prevent inconsistencies wrt execve?  seccomp uses
> cred_guard_mutex (new code should probably use exec_update_lock), why
> should Landlock not do the same?
> 
> Why shouldn't we lock sighand as well?
> 
> Answers to these questions should be explained in comments.

Added something to the top of the loop, based on Jann's explanation in [1].

[1] https://lore.kernel.org/all/CAG48ez3MxN524ge_sZeTwL0FEDASaSTb-gm1vPO8UwpijTeHqw@mail.gmail.com/

—Günther

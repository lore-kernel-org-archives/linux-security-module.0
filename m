Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445361D5147
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839774; cv=none; b=k3Fsv+1Lcv0GL2AVMlQbJqGYEv6T2/UyZVrSe/lfJ/4mOohhj4elYXZuiA5I2RyK0IfRZl+tvFYab3UC9BQPqalTP2+D+kGqL+QVJeUqOQRYxagiBGFirmnThnXvsFTLHfiM/rq9rnWC9jpYeJofcCvQbPcyEej+QC4W1V7AbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839774; c=relaxed/simple;
	bh=rsGzaY+gk29DLUfuZ5qXXIo6jay9Xgh2QuPWyj7qpMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKfkGDQ6KcADDtkmrBQNroTlEK6i4f8GOEz8EtHTz8egbpqt0FRdLD0Sq7C7JbF05ajby0PRs8WJmWF0cjwL3MEE40IJ9uMCzzNuJsCe4bk/NKE+OBLKbcPkrl+tVQS7V2COJxobGwzvlcRiyla02RQ07RWCdDIbbOOAmEm5j5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiunS95h; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiunS95h"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso49869975e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 01:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839772; x=1772444572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwHciiZE1k+9HjWjWRtjQxii/9K6Y59T95l0V4Aat3w=;
        b=OiunS95hJJlHlY6Uz+0Cz6tFMlRr3ljVP/VvjsakzESrNvq0GMcKXm+pzlRFkmO6g/
         mN35RZGwXJDcV4+m/Q7m5526NAluGjYF7R76mvGJx/qoFX9q3+e4bNFUS48fxCaeyJsf
         ukDzd1WbnpRQdbPJo/1Z4+SrQpokJmgoZOqcbN+IPL0/bLJlM/EuuB76CfsL0gsbwVFf
         IXBdo9JHdAQwVAjo9f8+iARieeUFp26Zxkj9M/8I0CGD4G/WW3+RRqsfkaPbJCQK42Pe
         z26vao9wVrvAJZnaHsCFMr0/DKo7cDkWVRkoTSJeammskues+xc8sPdq1cUF1Lt9XMoQ
         KBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839772; x=1772444572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwHciiZE1k+9HjWjWRtjQxii/9K6Y59T95l0V4Aat3w=;
        b=QWjda5Iexgpp1WIAJD6s5r1/jDv9TmT14TVfGWp+wHqEU7wO+ZWZMBuPbNbFn30VLe
         1Yn9T3nM/FaKDwSriVBK3dPL+l4t3vX5lKmjEV7ldzp+xDuNi2Sr3nH6vcj8lzp7qZrC
         RhUJxxM+QYMmka3pKPGlBb1ogiaRLR0mL8P84m3DHjQw56an4Iscz1uHgQuahIdVrdca
         JFqJOVJMKSDuEQ5MltKWX5GASC/DXtAceSF9mHZ3RMxsM3gYCrx4501L7kThGjOHFS4m
         pVO0LmYMpvXlRj0aAoVQIACiSto2qhR73rx9rZksuPXscxGy9KaV/RyU9mAGnFWqK4tT
         6aPA==
X-Forwarded-Encrypted: i=1; AJvYcCU95PCKiFfN+9u/xXLlSHmaNC0dUQewvAOQTtIXBEqa+JaPaC/mGWcbsiG/GF0DdoHuGxz4nlY06BHsQ0bvM1NasSW2KFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUZqvySJEK6U3+Q5p6nfcUPxYYXXJhWoPME2uG1qe56SEtM8f
	zqwoG5iJvV49MTJFInEJd9pJeWmCSIPxbQ1OitIgnQ9IvijQpyhJYWTZ
X-Gm-Gg: AZuq6aKAh/2eHmj2B39cENhde8RnPYWcSTXFqGIGJSozc5gWd9R01U1QIjzQs1XeVTa
	TKr6h9EfvuZ5XJAXOdosqD6R039ql+S/sZnydVvB9//mKYWoNbWD0bjMm0MuTq8Ef5mtD/46cdB
	WY43EF23UHRMMLgomGpORnSrA0X4iuhXFNcvZT+kCpPqTJ3+hXi9drmg31mIuV+rhacx1wdnMoq
	b+j2iebnmNcRZBTRXjFumIJCPvphrF7x3koyBSunNzUzggh+Q8Dph77+M+A4ubtXaVGX4MnseBl
	74rLsOZwPJifm5im8F9082g2JHN6lb1VsZpgyGHDdxzBjNDiEGeSbsIsXP9R5A8UJGb+HLFR5zO
	bD1EX0a/d46LBGd3FAQV7zUPHIf+FGtxF1EgkoCfe7GYC7rDkj0A9TMk0z6nmGtaHlY1YnGQV0+
	u3opF43WJgbc0zQwTTlFh3MC0znSjkChYko57HKZRsyLTgdJUmE3uX0ubHJTQ=
X-Received: by 2002:a05:600c:3516:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-483a963df3cmr163818325e9.35.1771839771162;
        Mon, 23 Feb 2026 01:42:51 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3d88sm274897565e9.3.2026.02.23.01.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:42:50 -0800 (PST)
Date: Mon, 23 Feb 2026 10:42:45 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Ding Yihan <dingyihan@uniontech.com>
Cc: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <20260223.52c45aed20f8@gnoack.org>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
 <20260221.5d8a306bcaf1@gnoack.org>
 <20260221.3ff0e30e4010@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221.3ff0e30e4010@gnoack.org>

On Sat, Feb 21, 2026 at 02:19:53PM +0100, Günther Noack wrote:
> OK, I think I understand now.  Our existing recovery code for this
> conflict is this:
> 
> /*
>  * Decrement num_preparing for current, to undo that we initialized it
>  * to 1 a few lines above.
>  */
> if (atomic_dec_return(&shared_ctx.num_preparing) > 0) {
> 	if (wait_for_completion_interruptible(
> 		    &shared_ctx.all_prepared)) {
> 		/* In case of interruption, we need to retry the system call. */
> 		atomic_set(&shared_ctx.preparation_error,
> 			   -ERESTARTNOINTR);
> 
> 		/*
> 		 * Cancel task works for tasks that did not start running yet,
> 		 * and decrement all_prepared and num_unfinished accordingly.
> 		 */
> 		cancel_tsync_works(&works, &shared_ctx);
> 
> 		/*
> 		 * The remaining task works have started running, so waiting for
> 		 * their completion will finish.
> 		 */
> 		wait_for_completion(&shared_ctx.all_prepared);
> 	}
> }
> 
> When I wrote this, I assumed, as the last comment states, that the
> task works which we could not cancel, are already running.
> 
> I was wrong there, because I had misunderstood task_work_run().  When
> the task works get run there, it first *atomically dequeues the entire
> queue of scheduled task works*, and then runs them sequentially.
> 
> That is why, if we have one task work that belongs to the first
> landlock_restrict_self() call and one which belongs to the other, the
> task work which is scheduled later can (a) not be dequeued with
> cancel_tsync_works() any more, and (b) also has not started running
> yet.
> 
> Now the only thing that is necessary to produce the deadlock is that
> we have a pair of threads where the task works for the restriction
> calls have been scheduled in different order.  When the two
> landlock_restrict_self() calls end up in the recovery path quoted
> above, they will wait for one of their task works to run which is
> blocked from running by another task work that is scheduled before and
> does not finish either.
> 
> (Just pasting a brain dump here to save you some time hunting for the
> root cause. I don't know the best solution yet either.)

Let me propose the following fixes:

1. Immediate fix for that specific issue
----------------------------------------

Proposal:
* Remove the wait_for_completion(&shared_ctx.all_prepared)
  call in the code snippet above.
* Rewrite surrounding comments: Be clear about the fact that
  cancel_tsync_works() is an opportunistic improvement, but we don't
  have a guarantee at all that it cancels any of the enqueued task
  works (because task_work_run might already have popped them off).

This removes the hold-and-wait dependency circle between the threads,
which produces the observed deadlock.  The way that we shut down now
is that we exit the main loop (happens already without it, but we
might also "break" to be explicit).

I think that this fix or an equivalent one is needed here, because in
either way, our assumptions in the quoted code above were wrong.


2. Can we reason constructively about correctness?
--------------------------------------------------

The remaining question: If on the shutdown path, we can not actually
remove all the enqueued task works, under what circumstances are we
even able to interrupt and return from the landlock_restrict_self()
system call?

2.1 For n competing restrict_self calls, n-1 of them need to get interrupted
----------------------------------------------------------------------------

To answer this, consider a multithreaded process with threads named
"red", "green" and "blue" and many additional threads: When "red",
"green" and "blue" enforce landlock_restrict_self() concurrently, due
to differing iteration order, we might end up enqueueing the task
works on other threads in all of the following combinations:

  t0:  R G B  <- front of queue
  t1:  R B G
  t2:  G R B
  t3:  G B R
  t4:  B R G
  t5:  B G R

In this configuration, for any of the landlock_restrict_self() system
calls to even return (successfully or unsuccessfully), at least two
threads must receive an interrupt and therefore remove their enqueued
task works from the front of the queue.  Assuming those are green and
blue, we get:

  t0:  R      <- front of queue
  t1:  R
  t2:  G R
  t3:  G B R
  t4:  B R
  t5:  B G R

(This works because after the patch above, all of the enqueued G and B
works finish even if there are remaining G and B works that are still
blocked by an "R" entry.)

Now, "R" is in the front of the queue, and the
landlock_restrict_self() call for the red thread can finish normally,
even without it being interrupted.

Once the "R" task works are done as well, the remaining G and B works
can run and finish as well.

This scheme generalizes: If we have n competing
landlock_restrict_self() calls, then in worst case, at least n-1 of
these system calls need to be interrupted so that they can all
terminate.

2.2 Can we guarantee that two system calls get interrupted?
-----------------------------------------------------------

In case of competing landlock_restrict_self() calls, I think it is
possible that not all relevant system calls get seen.  The scenario is
one where we have a "red" and "green" thread calling
landlock_restrict_self().

  (a set of additional threads)
  t0: task_works: R G
  t1: task_works: G R
  tR: red thread
  tG: green thread

In the red thread, the following happens:
 * Under RCU, count the number of total threads => get a low number
 * Allocate space for that number of task_works
 * Under RCU
   * Enqueue "R" into t0 and t1
   * Enqueue "R" for some of the "additional threads"
   * But we do not have enough pre-allocated space to enqueue "R" for
     the green thread tG.

The same thing happens in the green thread as well.

The result is that we still have a deadlock between t0 and t1, but
neither the red nor the green thread get interrupted so that they can
resolve it.

(FWIW, you could resolve it from the outside by sending a signal to
the red or green thread manually, but it is not guaranteed to happen
on its own.)

Caveat: I am making pessimistic assumptions about the iteration order
of the task list here, and I am assuming that the number of
"additional threads" is swinging up and down during the competing
enforcement, so that the enforcing threads are mis-approximating the
required space for memory pre-allocation.

2.3 Possible resolutions
------------------------

* We could try to interrupt all sibling threads during the teardown,
  to fix the issue discussed in 2.2. (Downside: Complicated, more
  expensive)
* The reason why landlock_restrict_self() can't return is because it
  needs to wait until all task works are done before it can free the
  memory.  Alternatively, we could make the task works take ownership
  of these memory structures (refcounting the shared_ctx).  (Downside:
  The used memory is not linear to the number of threads any more.)

Side remark: In testing, I had the impression that the
landlock_restrict_self() calls can go into a retry loop for a while
where all competing threads get interrupted all the time; in a debug
build, when the Syzkaller test prints out a line for each attempt,
sometimes it was hanging for seconds and *then* resolving itself
again.

3 Conclusion
---------------

I would prefer if the final solution would not require deadlock
reasoning at that level and we could do it in simpler way.  I
therefore propose to do what Ding Yihan suggested, and what we had
also discussed previously in the code review:

* Let's serialize the landlock_restrict_self()-with-TSYNC operations
  through the cred_guard_mutex.

This will resolve the issue where competing landlock_restrict_self()
calls with TSYNC can deadlock.  It will also remove the jittery
behavior for that worst case where the conflict is resolved through
retry.


So in my mind, we need both patches:

 * The fix to the cleanup path from 1. above, to make interruption
   work more reliably and to correct the misunderstandings in the
   comments.
 * cred_guard_mutex to serialize the TSYNC invocations.

Please let me know what you think.

Thanks,
–Günther

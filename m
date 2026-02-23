Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5F353EE3
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846276; cv=none; b=tYSo+frJKhH5VwXRYMaMXB7681j0+DnJ2eQGCKhHx30OTKa7v9Il1FWctEO5PJekplz1PNFix0vubvOHgoLN5ozvV0M6oKSNbu0JisMK4YoJtHd6lxbyk/cqZ7JY1NN4EMyW1MEGVwloJkQrt5o5DpNqwiX1BnzCLSu9sGpcoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846276; c=relaxed/simple;
	bh=6Yeg9YFUIZ9jFXNfrhMekSOWUEWMIBkJz4guVHgTZp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLX9iKzvagQth/rHOi/U6BxvFKmE8uDhGHJ+BPJ6E7l3/nlM7Ydka1Ar4Kvda50RXJuOKva91nvnbc72tr9UjGVABjtqd/KpRuthS6YA2jj66lU8amZ4yHTLzROhRz7dscmyfLCvTI6ykI3lWdPY5nnsv8I0N0F5Zg9hMdM4uEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=f4hJcgtF; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="f4hJcgtF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771846206;
	bh=9gU8gHxfnXWwTv2qYErx4M0UIXIbxOYCTRj0cBM6btI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=f4hJcgtFfVdxavmqBleeBX/ujQUhM/kUjPsfxb+xAui8Cl4uJX/Zhet2RJHfF1Raj
	 ko5gh099ofjlMXWwOA74H+kgD+mPsJhsFysPqgRv9Bav0MNAvRuaU/LXViMaGeuxUN
	 ADkPWexZ6yLlHU8MaqtffJrWQUEaTo22Lmy/oRPo=
X-QQ-mid: esmtpsz19t1771846198t59eace30
X-QQ-Originating-IP: 1ljOQunEE0aFFz1BZ6pPf4Nuuq0KhmPaU2+uHs6WCdY=
Received: from [10.10.74.107] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Feb 2026 19:29:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3567115187674417676
Message-ID: <32095877A7CB47CB+bb9e1be8-59c2-46d9-b1ef-f22d2d8c386e@uniontech.com>
Date: Mon, 23 Feb 2026 19:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
 Paul Moore <paul@paul-moore.com>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
 <20260221.5d8a306bcaf1@gnoack.org> <20260221.3ff0e30e4010@gnoack.org>
 <20260223.52c45aed20f8@gnoack.org>
From: Ding Yihan <dingyihan@uniontech.com>
In-Reply-To: <20260223.52c45aed20f8@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OetTBC9nymcUKgV9ckbEYkr295ozrNC1Wjmisd2OC2xJJY7P8YnroKDw
	159BKMbdDesz+D51bJaY3+sNxh9b67K4ZMdLed/4LvXtrt6XL+sG4JsIfv/QmaQuTNA1vFu
	VtPyLf8SvZF2z1cA6S21vrvMv+rXmAwOwgjqMci2osHguzYzadHfd7cWj25HfGIbk5eVK99
	y/GFM2mNu5Nftweemy1LP8ysZTArcBYas9IOn6sYXphAlmwrZxl2J2BfpiiHZzLB0/3SdD8
	/OwCIIOIyNX21RVAx/9W2m+wKzWr+k4ZFRfwPoiT9qTLLpVUeHgnqe/GaLFPYt3g5BAgI3N
	kH1xmo9ewa6lLo0voJP5BPyu4uYfKr+x5xcKllNHoJUgDwZI4IPl8jCHkbTgXOGnZ0Dl3vf
	WoU5RJRRfEN16ROQM7mp0g8af7zyYSldZg/Jol6lJThwrt6mnEgD3IDvMb8KND8IRZuwzQR
	Ea+HV1rA6R/NrUNdcoRa6r9FnaFLSnoM5PlGpQ7L/N3ShhrqSku9+kklXO0hceYAPdyZuQU
	FfpZ2A4GBJV/FoHXEmpumY9BfDmR/78xe3Wz+yidBvL5DMYx9Sawn0sM+MVhRUVtE/W9dGo
	igMKJYUOuW+dC3OMo2sJLcVbSwTKqzw7Y7piGOjJ8ZMUPeT7qp/qkMvvkjYZxVbIbPodoNF
	oa/lyg0u2TM1PpTJZihPebzrusRE+IVuDgTGoGxNm/mP6+uhmENtG2uMmR45z2rW5aXK+lg
	vnPxCpA+RhS3P800dLRK43ZkGxz6M3WvJy5Rwh04/MJdULkdsmeRx3AYwZAHhpYPkTB5E8N
	vOyuMpSgqp77OnvDwTWR9PaeqFQAetLTDMVfN5Lr5BftC8AOvIfcCBOxo2OaekNYZ8iDQZX
	kXbcOKJ5MPqy4hAhBYUxd8AmQX8pylb5Hb5anIll93nuOTA+GB7KuUiBQVwPKWjCEByR04W
	+Jch1HBQ/Ck/CWojTHoS6ANzrQ+GCP/plsMROWLuYiTfr8scAu75NNRGThIqv4KUmxuKiuH
	zPp500Jw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ykba08/jSGAxUhV/n68F+PQ==
X-QQ-RECHKSPAM: 0

Hi Günther,
﻿
Thank you for the detailed analysis and the clear breakdown. 
Apologies for the delayed response. I spent the last couple of days
thoroughly reading through the previous mailing list discussions. I
was trying hard to see if there was any viable pure lockless design
that could solve this concurrency issue while preserving the original
architecture. 
﻿
However, after looking at the complexities you outlined, I completely
agree with your conclusion: serializing the TSYNC operations is indeed
the most robust and reasonable path forward to prevent the deadlock.
﻿
Regarding the lock choice, since 'cred_guard_mutex' is explicitly
marked as deprecated for new code in the kernel,maybe we can use its
modern replacement: 'exec_update_lock' (using down_write_trylock /
up_write on current->signal). This aligns with the current subsystem
standards and was also briefly touched upon by Jann in the older
discussions.
﻿
I fully understand the requirement for the two-part patch series:
1. Cleaning up the cancellation logic and comments.
2. Introducing the serialization lock for TSYNC.
﻿
I will take some time to draft and test this patch series properly. 
I also plan to discuss this with my kernel colleagues here at 
UnionTech to see if they have any additional suggestions on the 
implementation details before I submit it.
﻿
I will send out the v1 patch series to the list as soon as it is
ready. Thanks again for your guidance and the great discussion!
﻿
Best regards,
Yihan Ding

在 2026/2/23 17:42, Günther Noack 写道:
> On Sat, Feb 21, 2026 at 02:19:53PM +0100, Günther Noack wrote:
>> OK, I think I understand now.  Our existing recovery code for this
>> conflict is this:
>>
>> /*
>>  * Decrement num_preparing for current, to undo that we initialized it
>>  * to 1 a few lines above.
>>  */
>> if (atomic_dec_return(&shared_ctx.num_preparing) > 0) {
>> 	if (wait_for_completion_interruptible(
>> 		    &shared_ctx.all_prepared)) {
>> 		/* In case of interruption, we need to retry the system call. */
>> 		atomic_set(&shared_ctx.preparation_error,
>> 			   -ERESTARTNOINTR);
>>
>> 		/*
>> 		 * Cancel task works for tasks that did not start running yet,
>> 		 * and decrement all_prepared and num_unfinished accordingly.
>> 		 */
>> 		cancel_tsync_works(&works, &shared_ctx);
>>
>> 		/*
>> 		 * The remaining task works have started running, so waiting for
>> 		 * their completion will finish.
>> 		 */
>> 		wait_for_completion(&shared_ctx.all_prepared);
>> 	}
>> }
>>
>> When I wrote this, I assumed, as the last comment states, that the
>> task works which we could not cancel, are already running.
>>
>> I was wrong there, because I had misunderstood task_work_run().  When
>> the task works get run there, it first *atomically dequeues the entire
>> queue of scheduled task works*, and then runs them sequentially.
>>
>> That is why, if we have one task work that belongs to the first
>> landlock_restrict_self() call and one which belongs to the other, the
>> task work which is scheduled later can (a) not be dequeued with
>> cancel_tsync_works() any more, and (b) also has not started running
>> yet.
>>
>> Now the only thing that is necessary to produce the deadlock is that
>> we have a pair of threads where the task works for the restriction
>> calls have been scheduled in different order.  When the two
>> landlock_restrict_self() calls end up in the recovery path quoted
>> above, they will wait for one of their task works to run which is
>> blocked from running by another task work that is scheduled before and
>> does not finish either.
>>
>> (Just pasting a brain dump here to save you some time hunting for the
>> root cause. I don't know the best solution yet either.)
> 
> Let me propose the following fixes:
> 
> 1. Immediate fix for that specific issue
> ----------------------------------------
> 
> Proposal:
> * Remove the wait_for_completion(&shared_ctx.all_prepared)
>   call in the code snippet above.
> * Rewrite surrounding comments: Be clear about the fact that
>   cancel_tsync_works() is an opportunistic improvement, but we don't
>   have a guarantee at all that it cancels any of the enqueued task
>   works (because task_work_run might already have popped them off).
> 
> This removes the hold-and-wait dependency circle between the threads,
> which produces the observed deadlock.  The way that we shut down now
> is that we exit the main loop (happens already without it, but we
> might also "break" to be explicit).
> 
> I think that this fix or an equivalent one is needed here, because in
> either way, our assumptions in the quoted code above were wrong.
> 
> 
> 2. Can we reason constructively about correctness?
> --------------------------------------------------
> 
> The remaining question: If on the shutdown path, we can not actually
> remove all the enqueued task works, under what circumstances are we
> even able to interrupt and return from the landlock_restrict_self()
> system call?
> 
> 2.1 For n competing restrict_self calls, n-1 of them need to get interrupted
> ----------------------------------------------------------------------------
> 
> To answer this, consider a multithreaded process with threads named
> "red", "green" and "blue" and many additional threads: When "red",
> "green" and "blue" enforce landlock_restrict_self() concurrently, due
> to differing iteration order, we might end up enqueueing the task
> works on other threads in all of the following combinations:
> 
>   t0:  R G B  <- front of queue
>   t1:  R B G
>   t2:  G R B
>   t3:  G B R
>   t4:  B R G
>   t5:  B G R
> 
> In this configuration, for any of the landlock_restrict_self() system
> calls to even return (successfully or unsuccessfully), at least two
> threads must receive an interrupt and therefore remove their enqueued
> task works from the front of the queue.  Assuming those are green and
> blue, we get:
> 
>   t0:  R      <- front of queue
>   t1:  R
>   t2:  G R
>   t3:  G B R
>   t4:  B R
>   t5:  B G R
> 
> (This works because after the patch above, all of the enqueued G and B
> works finish even if there are remaining G and B works that are still
> blocked by an "R" entry.)
> 
> Now, "R" is in the front of the queue, and the
> landlock_restrict_self() call for the red thread can finish normally,
> even without it being interrupted.
> 
> Once the "R" task works are done as well, the remaining G and B works
> can run and finish as well.
> 
> This scheme generalizes: If we have n competing
> landlock_restrict_self() calls, then in worst case, at least n-1 of
> these system calls need to be interrupted so that they can all
> terminate.
> 
> 2.2 Can we guarantee that two system calls get interrupted?
> -----------------------------------------------------------
> 
> In case of competing landlock_restrict_self() calls, I think it is
> possible that not all relevant system calls get seen.  The scenario is
> one where we have a "red" and "green" thread calling
> landlock_restrict_self().
> 
>   (a set of additional threads)
>   t0: task_works: R G
>   t1: task_works: G R
>   tR: red thread
>   tG: green thread
> 
> In the red thread, the following happens:
>  * Under RCU, count the number of total threads => get a low number
>  * Allocate space for that number of task_works
>  * Under RCU
>    * Enqueue "R" into t0 and t1
>    * Enqueue "R" for some of the "additional threads"
>    * But we do not have enough pre-allocated space to enqueue "R" for
>      the green thread tG.
> 
> The same thing happens in the green thread as well.
> 
> The result is that we still have a deadlock between t0 and t1, but
> neither the red nor the green thread get interrupted so that they can
> resolve it.
> 
> (FWIW, you could resolve it from the outside by sending a signal to
> the red or green thread manually, but it is not guaranteed to happen
> on its own.)
> 
> Caveat: I am making pessimistic assumptions about the iteration order
> of the task list here, and I am assuming that the number of
> "additional threads" is swinging up and down during the competing
> enforcement, so that the enforcing threads are mis-approximating the
> required space for memory pre-allocation.
> 
> 2.3 Possible resolutions
> ------------------------
> 
> * We could try to interrupt all sibling threads during the teardown,
>   to fix the issue discussed in 2.2. (Downside: Complicated, more
>   expensive)
> * The reason why landlock_restrict_self() can't return is because it
>   needs to wait until all task works are done before it can free the
>   memory.  Alternatively, we could make the task works take ownership
>   of these memory structures (refcounting the shared_ctx).  (Downside:
>   The used memory is not linear to the number of threads any more.)
> 
> Side remark: In testing, I had the impression that the
> landlock_restrict_self() calls can go into a retry loop for a while
> where all competing threads get interrupted all the time; in a debug
> build, when the Syzkaller test prints out a line for each attempt,
> sometimes it was hanging for seconds and *then* resolving itself
> again.
> 
> 3 Conclusion
> ---------------
> 
> I would prefer if the final solution would not require deadlock
> reasoning at that level and we could do it in simpler way.  I
> therefore propose to do what Ding Yihan suggested, and what we had
> also discussed previously in the code review:
> 
> * Let's serialize the landlock_restrict_self()-with-TSYNC operations
>   through the cred_guard_mutex.
> 
> This will resolve the issue where competing landlock_restrict_self()
> calls with TSYNC can deadlock.  It will also remove the jittery
> behavior for that worst case where the conflict is resolved through
> retry.
> 
> 
> So in my mind, we need both patches:
> 
>  * The fix to the cleanup path from 1. above, to make interruption
>    work more reliably and to correct the misunderstandings in the
>    comments.
>  * cred_guard_mutex to serialize the TSYNC invocations.
> 
> Please let me know what you think.
> 
> Thanks,
> –Günther
> 


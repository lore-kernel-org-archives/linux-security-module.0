Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53A3BB40
	for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771679999; cv=none; b=eJiKl6mw5VWAECe8Sv0QCb75vKd5u0CYOGB8QYVH3Sg01lkWc9ztZ+dWJs1EViTIasAJ77fC2tGemhmV6L7SnZzUqyY1mtEf6Y6l3ahizPEEbi4dKCX8xOmnhSrosj4OA/4gbaAx45kPurytI5M2Axvgx8kt5+dvGYNf6zvbYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771679999; c=relaxed/simple;
	bh=+/to1bAV0gd6j69nr3mC0w24jMcJ0rvEYd4G3GruVbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6E7g0oMMKxhltDMCqrLVw4YrNd7wbf204qh8eXHFZX5y7RQiQS3P4D9TYNZNcyAWBjYJyG5QuxPL9p97vEeomB6RJYaPfRLw6334rB8HdNrZnTuF8cRTuTzJd3mB0Qm/Tdxjzji0p54vINRuTWllcJFqA0nYObet/igXUyi6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0HkJ081; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0HkJ081"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-436317c80f7so2628701f8f.1
        for <linux-security-module@vger.kernel.org>; Sat, 21 Feb 2026 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771679996; x=1772284796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYPDwJD6U6knslsVaPs+nIxh4MMHD5DI34InEK2BjNQ=;
        b=l0HkJ081SThccIRiI795GA3UAsDhdu/3xHJZ7iNj+GE/7ViTkb+BYbQUBCoMAkBf87
         ask173xh0wTfijiO0WU/GnF+WPPpAQyTdyoezUEiQFBH6QpGo/GMBCmx3aJFNtLdIkaP
         RxzF8p6L/blfD0cir7UelTE8NGYzxh1yxNLxsvDrHoHGMPkV/8g14mAOetc0D9u5uFYo
         hWNdyJmTpvZRzgkFBOjABTPylzL8g9YB5iDkEZFvvRnoYQOQpZzogo4Y1imAB9ieC7xs
         YWvJOyh/avjKjXnK4r8EsgNEWFmhj2KPv6eWtar5PyW4Ks9AEizURWQwE+RgvB0tMHOp
         RNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771679996; x=1772284796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYPDwJD6U6knslsVaPs+nIxh4MMHD5DI34InEK2BjNQ=;
        b=peQR/raujeleo22G6EZZzYyWM2bK63Yy7KvJNrS5cpC7kmr7A5Z3i5VGNP3Hcbi0YP
         yJC0pyDM9j8B4NOY3VOxeh9jKaeJZoALeHpGGGnvPu+P0Kqr7SD68ZFF7P+NbCQjJS3K
         fjjcYZ8Xyk0oG6M3LahbYCnP2ZBAuvTlQRtV2ul/hCbaCPFSZhOGr6Nbqf3Ip27ht324
         K63vAH9MguDmI+P/spWNpg7qO/xeov8allq4wnSIop4SMJkzza4CauYdKxlcC8g4HEiO
         LZyVxK8eyh8lMGLKrLSd3YYpCh0U8Y7eNeeDrRIbXSpHBjD00kIS7l6dTGfTsn+7GY14
         7aag==
X-Forwarded-Encrypted: i=1; AJvYcCUHChgwNCfRZcZSUW9ZmeNN4TeusjAeN7JKXj9Vs7i/334nGcALiSlWutBsw0W+Wonxe4kRvX/Kez/gbi7WCgHX/f8lVbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyw4DnYrEcpKRRrsc2dtgDUyksx5wweanfR3w4fgntejooeSKx
	6vNXntt52cDgCKL4VnldfY0Xu/c/ju5ksMF3EhNCd7ZMJzMeu8npwvZc
X-Gm-Gg: AZuq6aIEWUHQz3z/19Kdl68yUfmkVsh9FzbKXN5OUg2sUPKpuPhzc1as28JiF613cJV
	SGVIBYJgj0b2ZDJEThOxyVSfbfS1z6R+N8RMqf8xHa+fIFSDwDlQZ3MSMYHYxoljuvMIKGEhRZn
	VD+iZN4b2n7FHFavdl+DXbBO3euM3hEctnGoEe+cmWpoUVMwl9/aPgKkh0nqIjSqPXX6uP+c8Jh
	VpWKHQ2/dSdr6z1HPU06QeAPgRTlRgnrMau3HqwsHuQTwh+/rSmYTUBGqTemAyhBoclMZRVlt6E
	yArSUpIOsPIJFiItuXmLUdFKGnXJSptUTK2bU0D59sSZ0lsG0mQ0Y7mQxCrW04ZPCS0gOwBbnMD
	RzgMl2zuiFAn+Zh2hRaC2Q2mrgz9LuV0Ak6gZ2MscKXlHmM1ZJO0izwyQpnXKHwrZk1SLsDf3H4
	ssJgmBDzWH4YwgVC1HQXy1B0zDp4mjRDI62Cc5mMN/P+6tJHIp
X-Received: by 2002:a5d:4e10:0:b0:435:96a1:ee4d with SMTP id ffacd0b85a97d-4396ffc46a8mr4284128f8f.14.1771679995824;
        Sat, 21 Feb 2026 05:19:55 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d5463dsm5204302f8f.34.2026.02.21.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:19:55 -0800 (PST)
Date: Sat, 21 Feb 2026 14:19:53 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Ding Yihan <dingyihan@uniontech.com>
Cc: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <20260221.3ff0e30e4010@gnoack.org>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
 <20260221.5d8a306bcaf1@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221.5d8a306bcaf1@gnoack.org>

On Sat, Feb 21, 2026 at 01:00:03PM +0100, Günther Noack wrote:
> (Very) tentative investigation:
> 
> In the Syzkaller report [2], it seems that the reproducer [2.1] is
> creating two rulesets and then enforcing them in parallel, a scenario
> which we are exercising in the TEST(competing_enablement) in
> tools/testing/selftests/landlock/tsync_test.c already, but which has
> not failed in my own selftest runs.
> 
> In the crash report, there are four threads in total:
> 
> * Two are stuck in the line
>   wait_for_completion(&ctx->ready_to_commit);
>   in the per-thread task work (line 128 [4.1])
> * Two are stuck in the line
>   wait_for_completion(&shared_ctx.all_prepared)
>   in the calling thread's coordination logic (line 539 [4.2])
> 
> In line 539, we are already on the code path where we detected that we
> are getting interrupted by another thread and where we are attempting
> to deal with the scenario where two landlock_restrict_self() calls
> compete.  This is detected on line 523 when
> wait_for_completion_interruptible() is true.  The approach to handle
> this is to set the overall -ERESTARTNOINTR error and cancel the work
> that has been ongoing so far, by canceling the task works that did not
> start running yet and waiting for the ones that did start running
> (that is the step where we are blocked!).  The reasoning there was
> that these task works will all hit the "all_prepared" stage now, but
> as we can see in the stack trace, the task works that are actively
> running are already on line 128 and have passed the "all_prepared"
> stage).
> 
> Differences I can see between syzkaller and our own test:
> 
> * The reproducer also calls openat() and then twice socketpair().
>   These syscalls should be unrelated, but it's possible that the
>   "async" invocation of socketpair() contributes to adding more
>   threads. (Assuming that "async" means "in new thread" in syzkaller)
> * Syzkaller gives it more attempts. ([2.2])
> 
> I do not understand yet what went wrong in our scheme and need to look
> deeper.

OK, I think I understand now.  Our existing recovery code for this
conflict is this:

/*
 * Decrement num_preparing for current, to undo that we initialized it
 * to 1 a few lines above.
 */
if (atomic_dec_return(&shared_ctx.num_preparing) > 0) {
	if (wait_for_completion_interruptible(
		    &shared_ctx.all_prepared)) {
		/* In case of interruption, we need to retry the system call. */
		atomic_set(&shared_ctx.preparation_error,
			   -ERESTARTNOINTR);

		/*
		 * Cancel task works for tasks that did not start running yet,
		 * and decrement all_prepared and num_unfinished accordingly.
		 */
		cancel_tsync_works(&works, &shared_ctx);

		/*
		 * The remaining task works have started running, so waiting for
		 * their completion will finish.
		 */
		wait_for_completion(&shared_ctx.all_prepared);
	}
}

When I wrote this, I assumed, as the last comment states, that the
task works which we could not cancel, are already running.

I was wrong there, because I had misunderstood task_work_run().  When
the task works get run there, it first *atomically dequeues the entire
queue of scheduled task works*, and then runs them sequentially.

That is why, if we have one task work that belongs to the first
landlock_restrict_self() call and one which belongs to the other, the
task work which is scheduled later can (a) not be dequeued with
cancel_tsync_works() any more, and (b) also has not started running
yet.

Now the only thing that is necessary to produce the deadlock is that
we have a pair of threads where the task works for the restriction
calls have been scheduled in different order.  When the two
landlock_restrict_self() calls end up in the recovery path quoted
above, they will wait for one of their task works to run which is
blocked from running by another task work that is scheduled before and
does not finish either.

(Just pasting a brain dump here to save you some time hunting for the
root cause. I don't know the best solution yet either.)

–Günther

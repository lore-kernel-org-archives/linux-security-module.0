Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11137DEBD
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572094; cv=none; b=X0H+8PC4SEw7FdFobBWZdKvyYida4hKeIItYeiprl6SHDX544QRl8pqkx86g37fib2sDiFoeLhf7zXGpaURpSjEAVnbu+zWCtsonkkqjsrETxzIvOlXPJHTPyFPL3tg/WW7KkoZGf/EjM3TQHY7H9TMrR/LoNvfdP98dgRVNWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572094; c=relaxed/simple;
	bh=UjaZNyIPng8TuWtp3YKTEyeVxFXERN8GpE3+D/pkwOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQrSguo4Dq0wb+qT1FDwvjKpXdyqlRTQvdNQNkZ5IB4CrYcQ5tpPzeonrCPt6Ft1ixrUmdiGWM9RsxkEMLrrKi4BZtFXHq9dCS0QG8J59UDcf7D5grxnjP4sWMJVXRFFZs3vtnWebY/CxjcdUhYe2TB1RXxeMlmHEzh0cEEPRfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqzzrSEu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqzzrSEu"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79801df3e42so77294107b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772572092; x=1773176892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKwUSV4101HDm1LA60SgAuqxDg4A7MfSvGav2EetINw=;
        b=EqzzrSEuYkFuc7iHEaxBqfonnxL+57M12NWWKyXuEjseypijDClMl41DrGwU0gzzom
         YcmvAYKFgGNr4zk1Wh0YgFJ3ZZ11XvSTJB5aePwJY3JLG6QBro4makdiyh0nKizqVaGn
         sQyXw6YApH1NLrs5egBPaNdbUVrfVmqyoQMNl7mmZa9xBSqRSJowTfdc5Iz82hS4QDnP
         pM4RdN6o+1jJogiEH01cJY/sUW+XeiOE2PLK39rYXoPKELSqaYXZxhirCEZUzpucNMeG
         sOGWhlFDVmZdLUm6d2yAV0rSGeCPx9KhIXH3OWG19lZ9mHOu7vNz8r2Lr7z/zheSqcEW
         UW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572092; x=1773176892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKwUSV4101HDm1LA60SgAuqxDg4A7MfSvGav2EetINw=;
        b=wNFyOBj7Fh64KbBE4uqoN5MZwN9u/l50ov+Rl8LXehm5/Rz8euzKDJjiLH2zptnbTy
         8eoOYQO9vr+wAiNBSDHp/TgGdect5gKEH0QUHx33e7xrYXm9mcL1RW2PA5S3cgOSuUqu
         msHM5GbBWweWNKOH8nR4IGgP9xw57QWSPBVLunIxeg3p0s9RyaSqxOU5x67PLzxhJ5aL
         y0qVhlucDynC6EFmNx2qIzrs4mhItrBFYPIVhGfgIPyqMWA7psHWQggQTAlNO91V3ryB
         L7PILjbMMmpUQ/77vuazwXQkZ0Kw4xu74uK63ujeNzUJ/JyXKm+AEnaWHiVJFk5Ns1mJ
         XIIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlQwFYgQgbWry3/IM9cH/TQcVf8IzJz/UdiOFM/lEeP7hwKIyl1VU+ZlZdkqLwU6NkHnh9yuVdkloxBzJ6IIYBluzYhA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyba8Eza+SEiJoBEdc5tmbouirJFC1SI/31h/eoUgNPzSACELh
	dtnwMJBvQgg3rt8VjZFDKan19rwIVSiSxttqRWkvN7bg1HLeA/LBI8F1/8M5hg==
X-Gm-Gg: ATEYQzw/N9r72T6Yz/R8YEqCL2YK/+dpZwPVysBEz4Y5dHLR2p2iSSIkTWcXDAGrGR7
	+8lyLTd92UsgoiE2wafmRgUQYtuVx3r/tajHLNojUpPTMG5ixrSQ0lvDAagf+/owsa8HgaqNDMv
	faqcqx+h+xowieEeJeoi2CGOZj5vuqB3VsgyVZkkimlWw8ZOd1OcbwwBuhfND6Zun0LDvRAWbdX
	31S7QoL4d8/b/K10LQm1LN7dDJGwobtmRgq+rrb8XhIUA44HVRO3W9I4iunbjp2d+TffsDhABMw
	Opg8+DdhRtz7X3KNq9SC49SsKUUsHV0QmF5TQoRShmtjbGCKUbHHx86cR0K7IZLACq3HkaWyoz+
	vph950bMdLltMG+e7zCAt7tMjWsdoVnsFB/hpkLQ5Gl1JpV07QtwXVLvZfLw3wdFRVd8y37Y8vS
	nEy3ybtibX9qS9hle6hwKBUEa83yk=
X-Received: by 2002:a05:690c:45c8:b0:798:68a6:f053 with SMTP id 00721157ae682-798bb420c8amr30124937b3.33.1772572092188;
        Tue, 03 Mar 2026 13:08:12 -0800 (PST)
Received: from suesslenovo ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ad9045sm66552987b3.16.2026.03.03.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:08:11 -0800 (PST)
Date: Tue, 3 Mar 2026 16:08:05 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc: Yihan Ding <dingyihan@uniontech.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <aadNtfsgcjirPS3n@suesslenovo>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
 <20260303.2e4c89f9fdfe@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303.2e4c89f9fdfe@gnoack.org>

On Tue, Mar 03, 2026 at 08:50:50PM +0100, Günther Noack wrote:
> Oof, thanks for catching this, Justin! 🏆
> 
> I was convinced I had tried the selftests for that variant,
> but apparently I had not. Mea culpa.
> 
> On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
> > On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> > > syzbot found a deadlock in landlock_restrict_sibling_threads().
> > > When multiple threads concurrently call landlock_restrict_self() with
> > > sibling thread restriction enabled, they can deadlock by mutually
> > > queueing task_works on each other and then blocking in kernel space
> > > (waiting for the other to finish).
> > > 
> > > Fix this by serializing the TSYNC operations within the same process
> > > using the exec_update_lock. This prevents concurrent invocations
> > > from deadlocking. 
> > > 
> > > We use down_write_trylock() and return -ERESTARTNOINTR if the lock
> > > cannot be acquired immediately. This ensures that if a thread fails
> > > to get the lock, it will return to userspace, allowing it to process
> > > any pending TSYNC task_works from the lock holder, and then
> > > transparently restart the syscall.
> > > 
> > > Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> > > Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> > > Suggested-by: Günther Noack <gnoack3000@gmail.com>
> > > Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> > > ---
> > > Changes in v3:
> > > - Replaced down_write_killable() with down_write_trylock() and 
> > >   returned -ERESTARTNOINTR to avoid a secondary deadlock caused by 
> > >   blocking the execution of task_works. (Caught by Günther Noack).
> > > 
> > > Changes in v2:
> > > - Use down_write_killable() instead of down_write().
> > > - Split the interrupt path cleanup into a separate patch.
> > > ---
> > >  security/landlock/tsync.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > > index de01aa899751..xxxxxxxxxxxx 100644
> > > --- a/security/landlock/tsync.c
> > > +++ b/security/landlock/tsync.c
> > > @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> > >  	shared_ctx.new_cred = new_cred;
> > >  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> > >  
> > > +	/*
> > > +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> > > +	 * when multiple threads call landlock_restrict_self() simultaneously.
> > > +	 */
> > > +	if (!down_write_trylock(&current->signal->exec_update_lock))
> > > +		return -ERESTARTNOINTR;
> > These two lines above introduced a test failure in tsync_test
> > completing_enablement.
> > 
> > The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
> > (this patch) and is currently in the mic/next branch.
> > 
> > I noticed the test failure while testing an unrelated patch.
> > 
> > The bug is because this code never actually yields or restarts the syscall.
> > 
> > This is the test output I observed:
> > 
> >   [+] Running tsync_test:
> >   TAP version 13
> >   1..4
> >   # Starting 4 tests from 1 test cases.
> >   #  RUN           global.single_threaded_success ...
> >   #            OK  global.single_threaded_success
> >   ok 1 global.single_threaded_success
> >   #  RUN           global.multi_threaded_success ...
> >   #            OK  global.multi_threaded_success
> >   ok 2 global.multi_threaded_success
> >   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
> >   #            OK  global.multi_threaded_success_despite_diverging_domains
> >   ok 3 global.multi_threaded_success_despite_diverging_domains
> >   #  RUN           global.competing_enablement ...
> >   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
> 
> The interesting part here is when you print out the errno that is
> returned from the syscall -- it is 513, the value of ERESTARTNOINTR!
> 
> My understanding so far: Poking around in kernel/entry/common.c, it
> seems that __exit_to_user_mode_loop() calls
> arch_do_signal_or_restart() only when there is a pending signal
> (_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL).  So it was possible that the
> system call returns with the (normally internal) error code
> ERESTARTNOINTR, in the case where the trylock fails, but where current
> has not received a signal from the other competing TSYNC thread yet.
> 
> So with that in mind, would it work to do this?
> 
>   while (try-to-acquire-the-lock) {
>     if (current-has-task-works-pending)
>       return -ERESTARTNOINTR;
> 
>     cond_resched();
>   }
Returning -ERESTARTNOINTR does *work* in my testing.

But really anything that would yield to the scheduler technically would!

But it smells funny to me to restart the whole syscall to wait for a
lock to become free.

Also the documentation for that code ERESTARTNOINTR is:
"System call was interrupted by a signal and will be restarted".

That clearly isn't happening here, we're not being interrupted by a
(literal) signal, we're really waiting on a semaphore.

And this lock is held by a task in this code, so why not run the pending
tasks with task_work_run so you can get out of the lock ASAP instead of
jumping through hoops back down to userspace and back?

> 
> Then we could avoid calling task_work_run() directly; (I find it
> difficult to reason about the implications of calling taks_work_run()
> directly, because these task works may make assumptions about the
> context in which they are running.)
Hmm possibly? I really don't know because there aren't many examples or
docs to look at.

My thought process for picking task_work_run was like this:
1. We have to wait for a lock.
2. So how do we do something useful while waiting to avoid deadlock?
3. We can simply help the other task get through doing whatever needs to
be done to get done the lock (doing the jobs we made with task_work_add)

And the way I decided to do that was task_work_run after grepping around
for some examples in io_uring code.
> 
> (Apologies for the somewhat draft-state source code; I have not had
> the time to test my theories yet; I'll fully accept it if I am wrong
> about it.)
> 
> –Günther
> 
> 
> >   # competing_enablement: Test failed
> >   #          FAIL  global.competing_enablement
> >   not ok 4 global.competing_enablement
> >   # FAILED: 3 / 4 tests passed.
> > 
> > 
> > Brief investigation and the additions of these pr_warn lines:
> > 
> > 
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 0d66a68677b7..84909232b220 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -574,6 +574,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
> >  		const int err = landlock_restrict_sibling_threads(
> >  			current_cred(), new_cred);
> >  		if (err) {
> > +			pr_warn("landlock: restrict_self tsync err pid=%d tgid=%d err=%d flags=0x%x ruleset_fd=%d\n",
> > +				task_pid_nr(current), task_tgid_nr(current), err,
> > +				flags, ruleset_fd);
> >  			abort_creds(new_cred);
> >  			return err;
> >  		}
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index 5afc5d639b8f..deb0f0b1f081 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -489,8 +489,11 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	 * Serialize concurrent TSYNC operations to prevent deadlocks when multiple
> >  	 * threads call landlock_restrict_self() simultaneously.
> >  	 */
> > -	if (!down_write_trylock(&current->signal->exec_update_lock))
> > +	if (!down_write_trylock(&current->signal->exec_update_lock)) {
> > +		pr_warn("landlock: tsync trylock busy pid=%d tgid=%d\n",
> > +			task_pid_nr(current), task_tgid_nr(current));
> >  		return -ERESTARTNOINTR;
> > +	}
> >  
> >  	/*
> >  	 * We schedule a pseudo-signal task_work for each of the calling task's
> > @@ -602,6 +605,10 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  
> >  	tsync_works_release(&works);
> >  	up_write(&current->signal->exec_update_lock);
> > +	if (atomic_read(&shared_ctx.preparation_error))
> > +		pr_warn("landlock: tsync preparation_error pid=%d tgid=%d err=%d\n",
> > +			task_pid_nr(current), task_tgid_nr(current),
> > +			atomic_read(&shared_ctx.preparation_error));
> >  
> >  	return atomic_read(&shared_ctx.preparation_error);
> >  }
> > 
> > Resulted in the following output:
> > 
> >   landlock: tsync trylock busy pid=1263 tgid=1261
> >   landlock: landlock: restrict_self tsync err pid=1263 tgid=1261 err=-513 flags=0x8 ruleset_fd=6
> >   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
> >   # competing_enablement: Test failed
> >   #          FAIL  global.competing_enablement
> >   not ok 4 global.competing_enablement
> > 
> > I have a fix that I will send as a patch.
> > 
> > Kind Regards,
> > Justin Suess

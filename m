Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE04384254
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567455; cv=none; b=OLaIyjbV6GEKbhTeXAiRYxYzx6di1xwDBnqRgCHnKyPiNrRUo+Q88wPqQSNRRsS7L8Ks1zkLkp/Af6X1syd/AI3cCdY2zkhOXrGYcELQdx6syO4NjT2bb7+Z0qFb5LTuXVUgFryyVMFEaj/zUJKk3oA0JO9cCg+o38c8/FRyLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567455; c=relaxed/simple;
	bh=WuPeItsIPw3jLiXJ04nMWO0uXl3DsryUt2yd4w92YVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMyXF6aqKUJXV5Bo4HdDM/Zr4wFjIxuNmvQB/vUoVDtCQecH/n0isLWpiOPgkHGDj9oKcQXvmoykBV84fUelaqkVqAFS0DrrM4RFWE2Ln2n8V/3DxxjQNcxCh2Mry0WEDn9dgIIUkYnlxF1pY1hX+BA9E9/tLS35i3CrGXJgi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV9/V61F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV9/V61F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48372efa020so53605705e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772567453; x=1773172253; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EFeYHQfzL3FoWqiekEs0nkrgdg7HMglsCMddymekjc0=;
        b=VV9/V61FHVxViAci18tIq+EjNIFQNWrerE82vuGjNnqjxTi2Dn/tRT5iaAYqgh3dTC
         ycYnhrZcINlUKLay8brz1xTlR5bMpTSPN+kolu7KjtLBo5Nzy24VT2v5mbn5qaGAsz53
         8H9pAvTVmKve+s6ad6uo+qk6xpTeZHnUgA9++Mt+F3EMq5BPVHAdn0+GGVtFkdDUL8ni
         KBmkCrONgYUh9Y114QC76X3ojgk/PAwD25aGBB2RS5pKcQj1tOeqfJuhnk13vxohMzns
         ar1+OA3hqjQvI4PftDHqPbEL7B16f3WSaDuzCJgjdDAmlwukn7t++aje5sZUJ+6dhhdL
         Evgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567453; x=1773172253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFeYHQfzL3FoWqiekEs0nkrgdg7HMglsCMddymekjc0=;
        b=SCuM81bXwqJHJHxRyyn+GYdsQNDLH8WK25SAgb4r8bnKY/2i3+oHi+SMZm682jiAPP
         F9oQbS8mK/ul60BIyzCzHvUOxH14/AIwkI3WTRacCe9MJuX29aoyoyViBIAPBrdZxJ5h
         J5wYWibA1kJxwp6lfmcXHXjgG4CNPetdQytReFibAe4cktDS1pTcEBSWKTkVewn+ccUq
         yWG19O67ZL3JZa54T8LT1r1AHi/dESya24IAB6tWMLApFdZEiUm2kAUstWczAOWp1nIj
         6BPrSaV4orFZOuQFKQTr1xJ46itL1U+C9bEMEhBrHtXNoud20zLiWQJFOLt/c0nAqAm/
         ReTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGZboEwFcWgE6afS1cpeP/kGECoOsDhhxMRJ1h2Jq6Z8CAOeotjd10dnsIAwzy0+dACoh9urFztwYDdl29G3wmH/HVIcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4CUqf1OFkQ3acedECl1Pj2SMVMEAUVMGMjKfKyZrPdZNNv2N
	qThn8oYgDwY7O6XQpvP2zan023u9alqown+YCVBJ//BX+vgYBk4VS3iM
X-Gm-Gg: ATEYQzxphQiNt82vaZ40LXOAxRrfrDnCPggjTwC1vRMH2jvo39vR438huAIZomNha5d
	cJisWnYq7qPq0M0lRREwgSxKq4MzZ0EQAaCufgDUtO84XXsJlK4lIcVem80U5mQrxdxc/3+DZ1l
	k02DZbpJAqYi2e3B51yBcPeJHmJzCceRBplSakT4eGBtJVddrt9o/+IvyFdPJO7wWkeP2Iwy2yR
	mVJt/KKcH+eoNn4156x6K7dnK/hd389aHyRm8IvBosnSsVKLWN4cemVZTsgsACVboq2I/acCYeW
	n2HhFwHgfbyvObRBLpGfiidWBRVK2480Nkm2LwtWTFwn4K1L+fno1RxGuwIzeky5HTZvmUofRNm
	4qZmPfoTYCg4exGeyJ7cWmu3gZurv0jeCFqX9gRA6S8CnT2OXU+b1ILRWN2ZZz/2uxyO80w1kPk
	UEdo4ifl2mNBVJnw5ApB7Fhto5a865L/Kfb/dXgHcYsEqAr0FU
X-Received: by 2002:a05:600c:a16:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-483c9bfb2f2mr315293915e9.19.1772567452401;
        Tue, 03 Mar 2026 11:50:52 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851880724esm914295e9.9.2026.03.03.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 11:50:52 -0800 (PST)
Date: Tue, 3 Mar 2026 20:50:50 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Yihan Ding <dingyihan@uniontech.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260303.2e4c89f9fdfe@gnoack.org>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aacKOr1wywSSOAVv@suesslenovo>

Oof, thanks for catching this, Justin! 🏆

I was convinced I had tried the selftests for that variant,
but apparently I had not. Mea culpa.

On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
> On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> > syzbot found a deadlock in landlock_restrict_sibling_threads().
> > When multiple threads concurrently call landlock_restrict_self() with
> > sibling thread restriction enabled, they can deadlock by mutually
> > queueing task_works on each other and then blocking in kernel space
> > (waiting for the other to finish).
> > 
> > Fix this by serializing the TSYNC operations within the same process
> > using the exec_update_lock. This prevents concurrent invocations
> > from deadlocking. 
> > 
> > We use down_write_trylock() and return -ERESTARTNOINTR if the lock
> > cannot be acquired immediately. This ensures that if a thread fails
> > to get the lock, it will return to userspace, allowing it to process
> > any pending TSYNC task_works from the lock holder, and then
> > transparently restart the syscall.
> > 
> > Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> > Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> > Suggested-by: Günther Noack <gnoack3000@gmail.com>
> > Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> > ---
> > Changes in v3:
> > - Replaced down_write_killable() with down_write_trylock() and 
> >   returned -ERESTARTNOINTR to avoid a secondary deadlock caused by 
> >   blocking the execution of task_works. (Caught by Günther Noack).
> > 
> > Changes in v2:
> > - Use down_write_killable() instead of down_write().
> > - Split the interrupt path cleanup into a separate patch.
> > ---
> >  security/landlock/tsync.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index de01aa899751..xxxxxxxxxxxx 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	shared_ctx.new_cred = new_cred;
> >  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> >  
> > +	/*
> > +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> > +	 * when multiple threads call landlock_restrict_self() simultaneously.
> > +	 */
> > +	if (!down_write_trylock(&current->signal->exec_update_lock))
> > +		return -ERESTARTNOINTR;
> These two lines above introduced a test failure in tsync_test
> completing_enablement.
> 
> The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
> (this patch) and is currently in the mic/next branch.
> 
> I noticed the test failure while testing an unrelated patch.
> 
> The bug is because this code never actually yields or restarts the syscall.
> 
> This is the test output I observed:
> 
>   [+] Running tsync_test:
>   TAP version 13
>   1..4
>   # Starting 4 tests from 1 test cases.
>   #  RUN           global.single_threaded_success ...
>   #            OK  global.single_threaded_success
>   ok 1 global.single_threaded_success
>   #  RUN           global.multi_threaded_success ...
>   #            OK  global.multi_threaded_success
>   ok 2 global.multi_threaded_success
>   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
>   #            OK  global.multi_threaded_success_despite_diverging_domains
>   ok 3 global.multi_threaded_success_despite_diverging_domains
>   #  RUN           global.competing_enablement ...
>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)

The interesting part here is when you print out the errno that is
returned from the syscall -- it is 513, the value of ERESTARTNOINTR!

My understanding so far: Poking around in kernel/entry/common.c, it
seems that __exit_to_user_mode_loop() calls
arch_do_signal_or_restart() only when there is a pending signal
(_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL).  So it was possible that the
system call returns with the (normally internal) error code
ERESTARTNOINTR, in the case where the trylock fails, but where current
has not received a signal from the other competing TSYNC thread yet.

So with that in mind, would it work to do this?

  while (try-to-acquire-the-lock) {
    if (current-has-task-works-pending)
      return -ERESTARTNOINTR;

    cond_resched();
  }

Then we could avoid calling task_work_run() directly; (I find it
difficult to reason about the implications of calling taks_work_run()
directly, because these task works may make assumptions about the
context in which they are running.)

(Apologies for the somewhat draft-state source code; I have not had
the time to test my theories yet; I'll fully accept it if I am wrong
about it.)

–Günther


>   # competing_enablement: Test failed
>   #          FAIL  global.competing_enablement
>   not ok 4 global.competing_enablement
>   # FAILED: 3 / 4 tests passed.
> 
> 
> Brief investigation and the additions of these pr_warn lines:
> 
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0d66a68677b7..84909232b220 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -574,6 +574,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  		const int err = landlock_restrict_sibling_threads(
>  			current_cred(), new_cred);
>  		if (err) {
> +			pr_warn("landlock: restrict_self tsync err pid=%d tgid=%d err=%d flags=0x%x ruleset_fd=%d\n",
> +				task_pid_nr(current), task_tgid_nr(current), err,
> +				flags, ruleset_fd);
>  			abort_creds(new_cred);
>  			return err;
>  		}
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 5afc5d639b8f..deb0f0b1f081 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -489,8 +489,11 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	 * Serialize concurrent TSYNC operations to prevent deadlocks when multiple
>  	 * threads call landlock_restrict_self() simultaneously.
>  	 */
> -	if (!down_write_trylock(&current->signal->exec_update_lock))
> +	if (!down_write_trylock(&current->signal->exec_update_lock)) {
> +		pr_warn("landlock: tsync trylock busy pid=%d tgid=%d\n",
> +			task_pid_nr(current), task_tgid_nr(current));
>  		return -ERESTARTNOINTR;
> +	}
>  
>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
> @@ -602,6 +605,10 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  
>  	tsync_works_release(&works);
>  	up_write(&current->signal->exec_update_lock);
> +	if (atomic_read(&shared_ctx.preparation_error))
> +		pr_warn("landlock: tsync preparation_error pid=%d tgid=%d err=%d\n",
> +			task_pid_nr(current), task_tgid_nr(current),
> +			atomic_read(&shared_ctx.preparation_error));
>  
>  	return atomic_read(&shared_ctx.preparation_error);
>  }
> 
> Resulted in the following output:
> 
>   landlock: tsync trylock busy pid=1263 tgid=1261
>   landlock: landlock: restrict_self tsync err pid=1263 tgid=1261 err=-513 flags=0x8 ruleset_fd=6
>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
>   # competing_enablement: Test failed
>   #          FAIL  global.competing_enablement
>   not ok 4 global.competing_enablement
> 
> I have a fix that I will send as a patch.
> 
> Kind Regards,
> Justin Suess

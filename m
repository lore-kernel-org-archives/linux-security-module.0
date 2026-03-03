Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E544370D65
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561603; cv=none; b=Ge8qjeV3ca9NiVzIuGIwFIdFJVxTidDtXiWBQggR1tjTD35tydxCpxNnXJRiu4GuCRgxzcpxmVHlYp4IcyW7fZ8HkKloLZFkxjSTvfr4ofdmLX/Q3WcQqI7FVIwdS3o9I/U4Lafwf72Tsauf2gJ/L9LTtwnk234mtR2wclDFdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561603; c=relaxed/simple;
	bh=WMKmwEccfv+9Ou96ZSfBBzYTzXCskhHWU8Bf1NJTA/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uESZ7o8fP7v8tkmIf7K5SE8ewC03a+T8+EHHiJIsQX4KZMB+V0fzL93tOJNVwU1LqMIzJRX7VRtsAUuXVeMLtByd9KjL23ajU93V+cHoBaOWe6Sts57AjkEXDZgYperdstImfxeGhdHNn+qBczJkSdk036nYaOkPe/D7Aae70co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHnQuFIM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHnQuFIM"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-797ab169454so58386927b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561600; x=1773166400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8h8/HyPUe+6pyzot1oP2GoxWQob4BkCfeosynleWUkQ=;
        b=RHnQuFIMD9zMLfOuWdKcJY8Di1D5hH3cn+Qfs+QqTkR/DaGrYF/0uLRlKCInl7u6R8
         FBGQQYbiw0bCB1v/4Hb709ThMrim13CHK+5e9sVrGN24JHSyXUfw0Gz5teZeF/6CJfOA
         y8CHslkWymfy6DJW1NxOj6hqpbJ6k6vYpsT6xAYwwmC2f6JECMp0VxUboaAkyMnpBZuz
         cBZshZ9CFQDrk+zrPNMEVNbHU4p7BS01DRYkdcTfNdNb3y8cjIOPSf/+7szuFGXzsvM0
         l5ZYswOoBVX28w2mRHajIrBgZI7xWjeqElWLxyvJUU0ltF8phtN7yeHc71ffqN2SFDA2
         Oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561600; x=1773166400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8h8/HyPUe+6pyzot1oP2GoxWQob4BkCfeosynleWUkQ=;
        b=McXnSExixtuPKKU4/y225lG60uv2ujTX9UvmLT29d3jiwWQRRL99mGzKGgSFov6/Ed
         7B3087dRR/LZA4WfVDtXcVETqi9h8UX/wDXH61By9zW1ri/lVZVQLkMdEKya5z4PJ+9u
         pAXdRt4SaSJiKyp+D10Gc05cLCyhWFaTLJqjQbRsjzxQbcOddcG3LDx2WxWL2d7G5JI4
         jGZJ3VtweO+tHGC63EoMFrvKgHZzjBMt1gEismmFT3/WvxGsSHHyhNWvJ7+16U9COfvY
         Bi1vzuCgJkx2Df8gqHAJ7+obGHMNIR6tYFI0i9dllPULOmb+XezWk0LFA9NIjGZBWRQM
         /YUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdWuSmaUxOlTPQDSLgj47YdNJm9/FUR2hRpoxWIMCkww7Ia3UakVtjPhCCwKv197U36zh1TRdD5O1IboDz8wguypdSHm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPfizaNNk26zOMpoqUuIPF3ijhkUgBgKACpjS5FazM6F5lJ4C
	Eml1NNbJciXGdWXjAc+HddH8MCUDpKZ5laWquZByH8MO4moVdcr9sBgL
X-Gm-Gg: ATEYQzyjkYBb/Fj1UqXJG7yIh7Ki0Apn8r7PFQF051VMFuA6bJAsTvZlah3nsXQzvHb
	PqdqfElCgv8zO1Gno3QuKKAotJYpDEfWqi9wof4JMWDrPuZlsX40bcPOcw83h4lcUT/8jvpXlxR
	pN3w8JQwOG3pbaWeinVzaasZ5XtmSIqpxgLv7zbMzOAyMNP1VExLceTQHE/a4JQ+rEH+Q2r9Fp9
	x0L5gneeEDA3+D+65KGfCOtQLMhTxfG3S+gRA+IEZrp24RUa4nYb/vMNHOAWk8Ryr1MaMNB1V4q
	62En4XWOs7luwM0QvQ33HCxoVAecANdWKy+Kk3LzthFBPWwXf2rPNj5TBZUZoCh8vGelMZJBCt9
	4E7JbKCeze4NP4/snwBcJXrcauCPyfbFCL8IvbMz/aBdvyDt8LG5h79khEYWRvNtkLqnp0oHicH
	LUnitnMOaRWrZJcT4IYkUk9xCxOFH41USnoWcGR5LP
X-Received: by 2002:a05:690c:2604:b0:798:36:e110 with SMTP id 00721157ae682-7988564ceccmr158027517b3.62.1772561599751;
        Tue, 03 Mar 2026 10:13:19 -0800 (PST)
Received: from suesslenovo ([129.222.254.128])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876c53644sm66329827b3.39.2026.03.03.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:13:19 -0800 (PST)
Date: Tue, 3 Mar 2026 13:13:17 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Yihan Ding <dingyihan@uniontech.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <aackvfZN1JD4yq2S@suesslenovo>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
 <20260303.kuSho2nooFie@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303.kuSho2nooFie@digikod.net>

On Tue, Mar 03, 2026 at 06:47:30PM +0100, Mickaël Salaün wrote:
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
> 
> You're right, I have the same issue, not sure how I missed it last time.
> 
> > 
> > I have a fix that I will send as a patch.
> 
> I'll need to squash your fix to this fix to only have one non-buggy
> patch.  So, either you send a new patch and I'll squash it with
> Co-developed-by, or Yihan takes your patch and send a new version with
> your contribution (I'll prefer the later to make it easier to follow
> this series).
>
Agreed.

The latter option is probably better. Yihan, are you ok to squash / apply
my patch [1] yourself to your next version of this series?

Feel free to do whatever you think is best. (or submit your own fix if
you think mine isn't a good fit)

[1]: https://lore.kernel.org/linux-security-module/20260303174354.1839461-1-utilityemal77@gmail.com/
> > 
> > Kind Regards,
> > Justin Suess
> > 

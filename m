Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A82390C8A
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572806; cv=none; b=b5Rh5hfSWgVwzGq+lBWWck2mpnZWMCbgB3K5sI7KljWwnJ1PmciLWYsf8iJy5CcRbAExLUdlqPgg+PhreXSG1+Oktfgo0LQ3XA1KyR6eev7vxSVXWibhe42cS+ABVJyBdRSy/aB0Nu/QWcbp1z0SlTqsdxzMLaOFngfaOZAAqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572806; c=relaxed/simple;
	bh=317VmixvhubKv4RVnZyfmTaDHR2+m7I/4r6rAVawp/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/1Ew0j9l+nsnOlvorMhkWHhEdeOgxCZzyIwv5PMwhHCeH6nsZfzYFl8WiQgYHmLu7Jb3DMufPzEoXarp/gVtNjKk/JNhN+BQ+npA4rf4vUuIuU/BFgDcf7bNGhBDeAVRew/gixDSgmYntv8KK8H80cqQtH1WcmGlGtaLwSzjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeNFLYtN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeNFLYtN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b78b638eso2708635f8f.2
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772572803; x=1773177603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W4MG/HQS2MSoFvEGAatmbg03vbzyG0ISERe9FdpLdI4=;
        b=KeNFLYtNwte0iImV2N75xaihlIaxsCdLN/7RGozH+yKAS1YRR0G2DqENVtqyw82hkx
         7CpQka+DRkELAnRkP63AlObtIsT+EyAADY1HUZz3CzCIo0qQMvVO3++A052o3R9ofLUu
         3eNoaKBT40DmoPWdajlO4G7CqCKb5FIPsruABRv10iSgqyNidLH56aXZvNxQmV+yyTag
         Y9ELSJ4bIQDD1wlNsZrQ1Qmjq6riBp7+bxWt2tKqnLz1phM7zFAsYzUxPtrIFUQoFqve
         uNoq/UathYLwtrzeh5K/3Yv7iPLq8i3HMUtzEgcxbz47ou8KFltsII4cPDbNL3InAV43
         w/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572803; x=1773177603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4MG/HQS2MSoFvEGAatmbg03vbzyG0ISERe9FdpLdI4=;
        b=MvnM6/mg5eziX7olUlvdxSOYkWKZjg7Uqf6xneO9wInfq5lPNR9Qpq7F3QRphcUEqe
         LeHZBUW4tKGPR8ol/zTKbyBDqizpQ/3WAInNoVd3PatJ3StA0B+Fwjh0b/Fbu5H5oU+6
         m5Fg+UgMMRYDe0XjrMoQilCATUNo1tNV173ecThrq8Y7cfEzt0HkwZuVnB3ban5DlNdQ
         diRREWw4g7dCZibQRmayctYeWyiZgPyC/4cusCEqloTR9nbikwTzWyqNgXq509go+Rzw
         U7sZvFgqfLzoysN9V67IqWnZ4wIkK7lgOSDVinZlkU48s5BjyWz9al0AnILIE5hpaC7V
         eqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQJoJsjYbhKnvj/LMo8xuBa+3eGRbX9OWOkDqQkqb1+UkrmIR6AhRk7OAlDnKF4ftEwihIHR9uVMI/QXhyexV5LAX9Mv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8wzbLMBQB8X/8tdL+lwrUlwO4en8pv0yAUYO3Rp6MOUEPNkD
	8/1sBJegR515gqEjWGHoSrxXGUk476078yzsk7p8ySyl1XYBIINTx3Pi
X-Gm-Gg: ATEYQzy8DMTBqlGNF4bPjuqKYhi7KQB45O1zTf1Qc1LP/JYrzUo3Sw3214O/t/FioPD
	TUCUOCQZojzRQoD35+Jj0eO/Ak+Pt7+8yPH6jg6lcnDnFdmVkHuyvfK+R1Kd7eJpBtCxlBfGarO
	LGqT/FQXWYDnuVhK8OFSvtUCFWdpASmWPIr0eU3plWQefr7dIPUPq0Wd0FWlcPvSkvw+BMcG7Pn
	RC9KSyJhW3QtS8L0+JyJtIJW7f05tY3aF4zbaEVNfhz2mxMJ7aOb6q+B2Haiften2AI1rOLAb05
	PJP7e4WuNA4WlpRKfTRN7Dvy4lX6aHysUqKyDln5NmvKtUQFtsxXjoIlFu2NzOb5xE2qhCJk1k6
	tuDiDyRfebBvUYGbRfwwtXjArkllxbnO9oMg9calAPDytVr9DV9HbecybKxhYgehOuT39Uq2QrX
	494+VSCoWJTCnw6f9q9esw3Zy2Q0NCWm/D76SHXM1Ht0OlaH01
X-Received: by 2002:a5d:5271:0:b0:439:a95c:ef0d with SMTP id ffacd0b85a97d-439a95cf230mr17613322f8f.35.1772572803236;
        Tue, 03 Mar 2026 13:20:03 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4175fd2sm21922926f8f.14.2026.03.03.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:20:02 -0800 (PST)
Date: Tue, 3 Mar 2026 22:19:57 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: Yihan Ding <dingyihan@uniontech.com>,
	Justin Suess <utilityemal77@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260303.94e335a9bdaa@gnoack.org>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
 <20260303.2e4c89f9fdfe@gnoack.org>
 <c482a8bb-d8c5-4008-9c8d-704d6a880022@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c482a8bb-d8c5-4008-9c8d-704d6a880022@maowtm.org>

On Tue, Mar 03, 2026 at 08:38:13PM +0000, Tingmao Wang wrote:
> On 3/3/26 19:50, Günther Noack wrote:
> > [...]
> > On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
> >> On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> >>> [...]
> >>> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> >>> index de01aa899751..xxxxxxxxxxxx 100644
> >>> --- a/security/landlock/tsync.c
> >>> +++ b/security/landlock/tsync.c
> >>> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >>>  	shared_ctx.new_cred = new_cred;
> >>>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> >>>  
> >>> +	/*
> >>> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> >>> +	 * when multiple threads call landlock_restrict_self() simultaneously.
> >>> +	 */
> >>> +	if (!down_write_trylock(&current->signal->exec_update_lock))
> >>> +		return -ERESTARTNOINTR;
> >> These two lines above introduced a test failure in tsync_test
> >> completing_enablement.
> >>
> >> The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
> >> (this patch) and is currently in the mic/next branch.
> >>
> >> I noticed the test failure while testing an unrelated patch.
> >>
> >> The bug is because this code never actually yields or restarts the syscall.
> >>
> >> This is the test output I observed:
> >>
> >>   [+] Running tsync_test:
> >>   TAP version 13
> >>   1..4
> >>   # Starting 4 tests from 1 test cases.
> >>   #  RUN           global.single_threaded_success ...
> >>   #            OK  global.single_threaded_success
> >>   ok 1 global.single_threaded_success
> >>   #  RUN           global.multi_threaded_success ...
> >>   #            OK  global.multi_threaded_success
> >>   ok 2 global.multi_threaded_success
> >>   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
> >>   #            OK  global.multi_threaded_success_despite_diverging_domains
> >>   ok 3 global.multi_threaded_success_despite_diverging_domains
> >>   #  RUN           global.competing_enablement ...
> >>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
> > 
> > The interesting part here is when you print out the errno that is
> > returned from the syscall -- it is 513, the value of ERESTARTNOINTR!
> > 
> > My understanding so far: Poking around in kernel/entry/common.c, it
> > seems that __exit_to_user_mode_loop() calls
> > arch_do_signal_or_restart() only when there is a pending signal
> > (_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL).  So it was possible that the
> > system call returns with the (normally internal) error code
> > ERESTARTNOINTR, in the case where the trylock fails, but where current
> > has not received a signal from the other competing TSYNC thread yet.
> > 
> > So with that in mind, would it work to do this?
> > 
> >   while (try-to-acquire-the-lock) {
> >     if (current-has-task-works-pending)
> >       return -ERESTARTNOINTR;
> > 
> >     cond_resched();
> >   }
> > 
> > Then we could avoid calling task_work_run() directly; (I find it
> > difficult to reason about the implications of calling taks_work_run()
> > directly, because these task works may make assumptions about the
> > context in which they are running.)
> 
> I've not caught up with the full discussion so might be missing some context on why RESTARTNOINTR was used here,
> but wouldn't
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index 950b63d23729..f695fe44e2f1 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -490,7 +490,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	 * when multiple threads call landlock_restrict_self() simultaneously.
>  	 */
>  	if (!down_write_trylock(&current->signal->exec_update_lock))
> -		return -ERESTARTNOINTR;
> +		return restart_syscall();
>  
>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
> 
> achieve what the original patch intended?

Thanks, that's an excellent point!

restart_syscall() (a) sets TIF_SIGPENDING and then (b) returns
-ERESTARTNOINTR.  (a) was the part that we have been missing for the
restart to work (see discussion above).  Together, (a) and (b) cause
__exit_to_user_mode_loop() to restart the syscall.  Given that this is
offered in signal.h, this seems like a clean and more "official" way
to do this than using the task works APIs.

It also fixes the previously failing selftest (I tried).

Yihan, Justin: Does that seem reasonable to you as well?

–Günther

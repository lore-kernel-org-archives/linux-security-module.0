Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3B3B582C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633323; cv=none; b=nydg5tWSX26g9wpBoA7d0fykOg2Raxa+fqzHdHC1KDX2Yuy8Ng1Hxf39+5WSKEjakGGGGFRDH+at90BIemzGoKTpllb5qTeMT9GLFoHyGRMFa74bcO1lDui8HxZuQ8iyET8m3i6P675Egjb7KUSk761hiINnhOG/Ldkp4QqF25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633323; c=relaxed/simple;
	bh=zDgWqS2xRaga2yyhENFSzZXYKsx5B/zeyas7Y+wIuB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ2E1sLMg+uUxZDVsUe419ejouGm+SW+JVLb99Z/Uqjh9sEhlb+aetYdMCW69MdLdN2DYh/v++9Qt1zHSo5OCwdob4u4IHKrhpgknmAWWwNF0opfymX5huE+qFRRVgxTkqGK/oatR2zlHm8gmDtnQ2aHr4XHHHv5lh2EGIiYeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjOcAt6V; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjOcAt6V"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ca09f2056so4932719d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2026 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633322; x=1773238122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1aX+9DZxt1V2Kn/aE5UDCbHqlpHewxSiNS2JNjXRqw=;
        b=EjOcAt6VvjmpufWnemLhmF4IebN9oHI/ICY97KnttH9AZe+CVk/X9h6+UIwYozMH6t
         bwcdOajoye8B0WfNAjfEXa/B0VvtihUXSzlYv8m6L1cavJxGlI2OHnFsq68XHHi/mKkO
         n26ev3r7b2qlicykFRc+9N3tQrR+8g1fSBLP+X0ibBj2V3byTzJ1WUDz+x+cFrxH9vXE
         3q7QoMTRQ2peQItqa5pjK/ZQOQYBdBx7Ak7YXU/aTy1eI/W2ItnuoYF6T8URT+8xFKAU
         ggW/I9V9AhVMbGV6NvfKAcx0DFOOAnGTbRSrcOeNg+2Bxd7Q1xCByJl3H36b/dYPsuuK
         gm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633322; x=1773238122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1aX+9DZxt1V2Kn/aE5UDCbHqlpHewxSiNS2JNjXRqw=;
        b=H3O7mXD8Y37sYhWrtUjhjAEjkREtTGdBMqE0yZwWbHegn64AkPNZTm8/poYo7uDeOd
         bAPKcOtZip1qGyO8Y1WIbnEWQm4oVNsLCt9yDCsDyXlXO/9YP+KJmZiBCKLTNe/rhaU2
         eUA7sB142qFT2TaxMxL59fwnV1T1xMEJaMfvkRkJ7obKf5quiBowuQCq3NIEYbAGTi7h
         SM86y/NT6NgILZ2IRldPT7tHywJs9I1eegeLTITV2muJtLeow4RTZm55eEsbmI4g5rQk
         gcShLW2QIiV/F0wpJnVnH8+vqvek1vsiF+8E14cH9FhYyb+y1ojPgiYaa/c3AMBnfxSW
         nQtw==
X-Forwarded-Encrypted: i=1; AJvYcCWZX65/ALXn8v52T5ahxo1EHHkxBLX+/TEnJRtNOfVl7eAc8Vfz7YXYyhCzBqkCT6c/fka2aGkpxxss0nszky6Ixi9m9mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoaI2bvXDJDWtJpSzry536uMAY6eeyt1bFmVbB7Eaah6di8zi
	h8Nh6K5UQxrXR2qBmRgAud+bOEUqz/jc+fMJ4lbVlyuC8a3GEml2atJSVeqKRA==
X-Gm-Gg: ATEYQzwCytpfXzwjieQR6mRvJ+8xhYU6T/JFYeMi2FR6IoAhkpsh+hkOmB2HzAqR3Ab
	+MLpRUA+5v/zTsJYRvIpHCAkma5UpIGe/IU4wjRtd3BN/lurjMOXcxWv4pQlAZjYFDlPdCxke0k
	2QrOjfueI67r6zLiKhQLusXIAChcaUNGqGNYkNoN6G9CzddKrx2689UPbchcn7m+GPu9DvaDkVF
	y0BtJeNl3feshvTgqm+QLOKS/iGx0riphUOcIAIEth2lBHKCf8OVmjyKOWNW9y2fmqOe6lBuOFa
	kn3FWPnVjCffoecSclcqtZQAdzHxCRfMmebrz5fbnvA4swGdp0NMahz5yAQvYt2WDLOQH7RUFZ9
	xb+1StrW0sVilqjwTOqrmGvT1JflDMBHo757dxKp1o0Aw403ql/BMJSsv8zXY4s9vn0h5hPcGWG
	s0n9SJW4KpixzE7pZeGDAhPCdx1I9bBNornhJV0g96
X-Received: by 2002:a05:690e:134e:b0:649:e501:21af with SMTP id 956f58d0204a3-64cf9b34895mr1715955d50.14.1772633321575;
        Wed, 04 Mar 2026 06:08:41 -0800 (PST)
Received: from suesslenovo ([129.222.254.128])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7641c33sm7922672d50.20.2026.03.04.06.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:08:41 -0800 (PST)
Date: Wed, 4 Mar 2026 09:08:38 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: Ding Yihan <dingyihan@uniontech.com>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <aag85lfE3lfSSGEH@suesslenovo>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
 <20260303.2e4c89f9fdfe@gnoack.org>
 <c482a8bb-d8c5-4008-9c8d-704d6a880022@maowtm.org>
 <20260303.94e335a9bdaa@gnoack.org>
 <D31C8311F753F56D+d07bcc15-ede7-4a04-829d-d80f69abda83@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D31C8311F753F56D+d07bcc15-ede7-4a04-829d-d80f69abda83@uniontech.com>

On Wed, Mar 04, 2026 at 10:46:39AM +0800, Ding Yihan wrote:
> Hi all,
> ﻿
> Thank you Justin for catching the test failure and the thorough
> investigation! And thanks Günther and Tingmao for diving into the
> syscall restart mechanics.
> ﻿
> I've evaluated both the `while` loop approach with `task_work_run()`
> and the `restart_syscall()` approach. I strongly lean towards using
> `restart_syscall()` as suggested by Tingmao. 
> ﻿
> As Günther pointed out earlier, executing `task_work_run()` directly
> deep inside the syscall context can be risky. Task works often assume
> they are running at the kernel-user boundary with a specific state.
> Using `restart_syscall()` safely bounces us to that boundary, processes
> the works cleanly, and restarts the syscall via standard mechanisms.
> ﻿
> After some selftests,I will prepare the v4 patch series using `restart_syscall()`.
> I will also ensure all comments are properly wrapped to 80 columns as requested
> by Mickaël, and make sure to include the proper Reported-by and
> Suggested-by tags for everyone's excellent input here.
> ﻿
> Expect the v4 series shortly. Thanks again for the great collaboration!
> ﻿
> ﻿
> Best regards,
> Yihan Ding
>
After review, I agree Tingmao's solution is better.

Coming from a userspace background, I didn't think of that as a solution
for a lock contention, but kernel space has different needs/conventions.

I agree this is probably the right way to go. The simplest approach is
probably best here, and the restart_syscall seems better here, seeing as
task_work_run is rarely called in kernel code outside core paths.

I've learned a lot about kernel task workers and how locking is handled
as a result.

Thank you for your work with this series, this fix is useful!
> 在 2026/3/4 05:19, Günther Noack 写道:
> > On Tue, Mar 03, 2026 at 08:38:13PM +0000, Tingmao Wang wrote:
> >> On 3/3/26 19:50, Günther Noack wrote:
> >>> [...]
> >>> On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
> >>>> On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> >>>>> [...]
> >>>>> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> >>>>> index de01aa899751..xxxxxxxxxxxx 100644
> >>>>> --- a/security/landlock/tsync.c
> >>>>> +++ b/security/landlock/tsync.c
> >>>>> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >>>>>  	shared_ctx.new_cred = new_cred;
> >>>>>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> >>>>>  
> >>>>> +	/*
> >>>>> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> >>>>> +	 * when multiple threads call landlock_restrict_self() simultaneously.
> >>>>> +	 */
> >>>>> +	if (!down_write_trylock(&current->signal->exec_update_lock))
> >>>>> +		return -ERESTARTNOINTR;
> >>>> These two lines above introduced a test failure in tsync_test
> >>>> completing_enablement.
> >>>>
> >>>> The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
> >>>> (this patch) and is currently in the mic/next branch.
> >>>>
> >>>> I noticed the test failure while testing an unrelated patch.
> >>>>
> >>>> The bug is because this code never actually yields or restarts the syscall.
> >>>>
> >>>> This is the test output I observed:
> >>>>
> >>>>   [+] Running tsync_test:
> >>>>   TAP version 13
> >>>>   1..4
> >>>>   # Starting 4 tests from 1 test cases.
> >>>>   #  RUN           global.single_threaded_success ...
> >>>>   #            OK  global.single_threaded_success
> >>>>   ok 1 global.single_threaded_success
> >>>>   #  RUN           global.multi_threaded_success ...
> >>>>   #            OK  global.multi_threaded_success
> >>>>   ok 2 global.multi_threaded_success
> >>>>   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
> >>>>   #            OK  global.multi_threaded_success_despite_diverging_domains
> >>>>   ok 3 global.multi_threaded_success_despite_diverging_domains
> >>>>   #  RUN           global.competing_enablement ...
> >>>>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
> >>>
> >>> The interesting part here is when you print out the errno that is
> >>> returned from the syscall -- it is 513, the value of ERESTARTNOINTR!
> >>>
> >>> My understanding so far: Poking around in kernel/entry/common.c, it
> >>> seems that __exit_to_user_mode_loop() calls
> >>> arch_do_signal_or_restart() only when there is a pending signal
> >>> (_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL).  So it was possible that the
> >>> system call returns with the (normally internal) error code
> >>> ERESTARTNOINTR, in the case where the trylock fails, but where current
> >>> has not received a signal from the other competing TSYNC thread yet.
> >>>
> >>> So with that in mind, would it work to do this?
> >>>
> >>>   while (try-to-acquire-the-lock) {
> >>>     if (current-has-task-works-pending)
> >>>       return -ERESTARTNOINTR;
> >>>
> >>>     cond_resched();
> >>>   }
> >>>
> >>> Then we could avoid calling task_work_run() directly; (I find it
> >>> difficult to reason about the implications of calling taks_work_run()
> >>> directly, because these task works may make assumptions about the
> >>> context in which they are running.)
> >>
> >> I've not caught up with the full discussion so might be missing some context on why RESTARTNOINTR was used here,
> >> but wouldn't
> >>
> >> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> >> index 950b63d23729..f695fe44e2f1 100644
> >> --- a/security/landlock/tsync.c
> >> +++ b/security/landlock/tsync.c
> >> @@ -490,7 +490,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >>  	 * when multiple threads call landlock_restrict_self() simultaneously.
> >>  	 */
> >>  	if (!down_write_trylock(&current->signal->exec_update_lock))
> >> -		return -ERESTARTNOINTR;
> >> +		return restart_syscall();
> >>  
> >>  	/*
> >>  	 * We schedule a pseudo-signal task_work for each of the calling task's
> >>
> >> achieve what the original patch intended?
> > 
> > Thanks, that's an excellent point!
> > 
> > restart_syscall() (a) sets TIF_SIGPENDING and then (b) returns
> > -ERESTARTNOINTR.  (a) was the part that we have been missing for the
> > restart to work (see discussion above).  Together, (a) and (b) cause
> > __exit_to_user_mode_loop() to restart the syscall.  Given that this is
> > offered in signal.h, this seems like a clean and more "official" way
> > to do this than using the task works APIs.
> > 
> > It also fixes the previously failing selftest (I tried).
> > 
> > Yihan, Justin: Does that seem reasonable to you as well?
> > 
> > –Günther
> > 
> 

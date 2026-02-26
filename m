Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800C372B3C;
	Thu, 26 Feb 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070269; cv=none; b=c+fWgC3bvUFjGucZRwT0Z0DTGo2ioI7dMiyIuX83B4hji0u5lXBBanSfuH1QbjKN9glGljHK1Fa3nZG3o48131nnQ++Z5DKMX1fIsBIX9oLcqF7ctNBquRH2HWrrQrMRsyF7ukPir8hPRbeFk4WNOBDzxdlVPH2GiqUPY3xnnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070269; c=relaxed/simple;
	bh=QMJ49ZAskuQe5Jbw+sT/20hYVM2nL2XoJRa4C0i2bPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpLsMGlc59mWdAtASfi6z1u8b8X4fipiEdhAJVBKYtiIuYeK0PoMzS3lnBee0pxd9NcAEfwMP9UIwWufBeccqp88KxGcalAW3BFUNFwmzGxgqCR6huhqkuBzZfwJu6h3U0T1hFfn3nGl+4qGIP4VoSZRO9DDL/5F4lB48HH5DyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KtUNrrYA; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KtUNrrYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772070215;
	bh=+aldXynsHEKwS3gX15utKN+AyOGAwNGFqltZ315IyP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KtUNrrYA+uNFGogevQ6x+Dl+i724lyVt2GGZAL/wx99s7/NvdaPYZDNw/ar87idt6
	 CTMFhCsLas0Y+8f08T/eD1P7OfnXiixm3O/hkNcAaTD+mrni5iSjNBiitRYC9HuFCg
	 7gDH8zXRDVUy7qoqhYCyeYHkqPrM/1UiEukZAQpY=
X-QQ-mid: zesmtpsz8t1772070211tef1f0882
X-QQ-Originating-IP: mkGZt94Dl8eRqsJIr+/u7GhwNqADnxqQhPeSSE9ov2c=
Received: from [10.10.74.107] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 09:43:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18325226792580244632
Message-ID: <3EC648DE4021DF76+25b0698a-4b80-4ff2-abd5-1cf2d4351277@uniontech.com>
Date: Thu, 26 Feb 2026 09:43:29 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] landlock: Serialize TSYNC thread restriction
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
References: <20260225024734.3024732-1-dingyihan@uniontech.com>
 <20260225024734.3024732-2-dingyihan@uniontech.com>
 <aZ7l6jU7XJ1BYbN-@google.com> <20260225.42330125301c@gnoack.org>
From: Ding Yihan <dingyihan@uniontech.com>
In-Reply-To: <20260225.42330125301c@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NYzMHWjxYhxlmRtPdNg5Y8TvCe3sTxbdeLbNlXY3dR3g2vjIbL4Tsgz0
	7qVB27JA7xWI6SjNVcBiuH6Q5ZBN/IS3BzMxFY2pKkluoKrpm5PWDB07vq6dvFH3JUg5t9A
	9Xn7lcU7Owl0PV6XSENeM+8Z7SYszv5Y0qxYu+8SazDJ25IQXk46r3mWq3E1W1WNdsI5mLf
	Z3bYpMwEiHcFwEjytYoEbM1qcGdIzw3Rx1HVMLIz6uxciLe1wrfZYaybd1P8lzkTqLaGpO0
	PrymTdZ1om/hxdr0GyteP1Q6D9CMbixe3qECFlf7FAox/7pmcYw5jelbmgVG+ND3l9sxPbb
	72LDMPe2CnEWj9B/PXlEPW9V28K2MpVJWzaNc+Fu0kCJCw67Ojo+eBiTchPULFwtpqlSV3G
	Ib2E1DzCOM8vsKeIkK5EtyU1Vqu+k7FHUNUTZMK2Rm/npvViY03+iFFO4BptFlwEfOWPyxV
	zKySu7eGjA9nzUdV/AmbIuUrqSkKKo/6X/eNvUWEiLadE/tCfU+e9rDiwGmIRu4VvuSJ5me
	4pcinNSR1mN4FI6VgBmWDOOAPxogb1qvnA3Q2EtiwFUPTFGBNh3VVk3j9LHkI2WIBdXiJLI
	MFhmEvLgSfS9cIbSeEqo7VoeLXv4/U/ml8I6aYIyWUv4yVUjmxk/CPt+9XY4ZzsgnvtN28g
	wrn5QW1TJ5rTsJcIafxt1ORNfWL6z8+ClKS2H5eLUiLfxZJ9mxB6wCyrLly7Twga12VVbAB
	FXx2nxGRJ9RNDUPv0Pv1eoRxWTnD8nfjaxBkRzSD2qUoBPuaaY3HsZA4Xk7hgF7LtIJQTw+
	gPbUwG4Lm82yfEdnC3EwBLBAFWDoY/yVk8//vnWB/klA1n/2DvkC4UKM+CdGmm2LDvvVVEX
	x8QI35LwwLF9uGD4vRa81MPssQvUigKFOM5UDZa3Y5JCCVV2luTtWRwnyTLYm3lifn+1e/3
	2KrTSFrK8JyPIpcCOLv6eZb0G1kJT6Q/TneJykTODg4mi/qT9OFZlQ2JD9hJQqxHok/Ip1Y
	4Fry+AKyS5NSs1gOYIiLeUVBpr+mbGzcw0ZPhIKw==
X-QQ-XMRINFO: NS+P29fieYNw88tcJIVJEPwWx5NUTCROXA==
X-QQ-RECHKSPAM: 0

Hi Günther, great catch with the QEMU test! Returning -ERESTARTNOINTR via down_write_trylock() 
is indeed the perfect way to allow the blocked thread to process the TWA_SIGNAL and retry. 
I have sent v3 with this update.

在 2026/2/26 06:33, Günther Noack 写道:
> On Wed, Feb 25, 2026 at 01:07:26PM +0100, Günther Noack wrote:
>> On Wed, Feb 25, 2026 at 10:47:33AM +0800, Yihan Ding wrote:
>>> syzbot found a deadlock in landlock_restrict_sibling_threads().
>>> When multiple threads concurrently call landlock_restrict_self() with
>>> sibling thread restriction enabled, they can deadlock by mutually
>>> queueing task_works on each other and then blocking in kernel space
>>> (waiting for the other to finish).
>>>
>>> Fix this by serializing the TSYNC operations within the same process
>>> using the exec_update_lock. This prevents concurrent invocations
>>> from deadlocking. We use down_write_killable() to ensure the thread
>>> remains responsive to fatal signals while waiting for the lock.
>>>
>>> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
>>> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
>>> Suggested-by: Günther Noack <gnoack3000@gmail.com>
>>> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
>>> ---
>>>  security/landlock/tsync.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
>>> index de01aa899751..420fcfc2fe9a 100644
>>> --- a/security/landlock/tsync.c
>>> +++ b/security/landlock/tsync.c
>>> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>>>  	shared_ctx.new_cred = new_cred;
>>>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>>>  
>>> +	/*
>>> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
>>> +	 * when multiple threads call landlock_restrict_self() simultaneously.
>>> +	 */
>>> +	if (down_write_killable(&current->signal->exec_update_lock))
>>> +		return -EINTR;
>>> +
>>>  	/*
>>>  	 * We schedule a pseudo-signal task_work for each of the calling task's
>>>  	 * sibling threads.  In the task work, each thread:
>>> @@ -556,6 +563,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>>>  		wait_for_completion(&shared_ctx.all_finished);
>>>  
>>>  	tsync_works_release(&works);
>>> +	up_write(&current->signal->exec_update_lock);
>>>  
>>>  	return atomic_read(&shared_ctx.preparation_error);
>>>  }
>>> -- 
>>> 2.51.0
>>>
>>
>> Thank you!
>>
>> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Hello Yihan Ding!
> 
> Apologies, I have to take this back -- applying the patch in this form
> would be a mistake.  When I tried this out with the Syzkaller test
> case, I noticed that the tests started taking multiple seconds per
> run.  The way I reproduced it was by running the Syzkaller reproducer
> under Qemu and looking for the frequency of the "executing program"
> lines that it prints for each test run.
> 
> When I looked deeper, what was happening was actually that we got
> ourselves into a deadlock again, which, in hindsight should have been
> obvious: When two threads call landlock_restrict_self() roughly at the
> same time, then the one that grabs the lock first will (a) keep the
> other (killably) blocked on the lock acquisition, and (b) later ask
> the other thread to run a task work.  But in order to run a task work,
> the blocked thread must first return from the syscall.  However,
> down_write_killable() only returns when either the lock is available
> or when the thread was killed.
> 
> To resolve this, we need to actually use a lock acquisition that
> respects other ways of interruption as well; we can either use a
> down_write_trylock() and return -ERESTARTNOINTR, or we can use
> down_write_interruptible().
> 
> Sorry for the poor advice to use the _killable variant earlier.  Could
> I ask you to please send another revision using _trylock() or
> _interruptible()?
> 
> Thanks,
> –Günther
> 


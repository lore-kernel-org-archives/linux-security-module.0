Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3340352C5B;
	Wed,  4 Mar 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592464; cv=none; b=o0ncl9LQoZ1NvoM6CLViSZ6zZE7pV9TPzK3oF4Gm9QLOmS24fS4rCse+trFV1uQ8w/XgCBrdi7ZCsheklb0HebhDox4gyDGdWSgqVu/jJtDQaGW0eluGCr7/uCZ/vWnAyu5rxI3OaI176WD229BwU4PLssFjGSfutzXvLRxmRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592464; c=relaxed/simple;
	bh=F1l8tk2PIf7hDlW+ZqklgZZgn2kNYa3aC+wAzXlGD2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkcAYbjw0IeFGPpBwrtrCUb6+oeMbUoV0d0RJeD0wvYFFeCuWoS02ZGXLNphPv4N+bOkcAnUbkpIlMWyvqwRFSQetNeGxNk/3JybtZIqOjRzxg/yldjrmCipEYFlDc33WGgj6wp0zYc6yqCRIzxFdCNb7+vq9aNXMfITvIPfXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ppt4ZsVP; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ppt4ZsVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772592412;
	bh=yNogZjh8R25rWXICvL/Vv0D83HCOCVjY9r9wo4TFOGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ppt4ZsVPhyTw+qsq4RQ21SUocDA5nQF96Kc1Scax+GSGvhj5vU96R9Nj7W9iMY2L8
	 tbhJGHhDtA1CUdm8s3O3Ti+K+MrJVm4qFQgXf+z9hx2HDicvrYZg7DQ8GUWGct2BiZ
	 Z8S22NiO343q4YHnKu0F74CofFctbR5uGTqKvSHU=
X-QQ-mid: zesmtpsz4t1772592403t8b21b79f
X-QQ-Originating-IP: 9I8NfFU45lP2p8YG5Z7gLbQbUlxK/BvAmjUVkl3OLpU=
Received: from [10.10.74.107] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Mar 2026 10:46:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 589727514512561061
Message-ID: <D31C8311F753F56D+d07bcc15-ede7-4a04-829d-d80f69abda83@uniontech.com>
Date: Wed, 4 Mar 2026 10:46:39 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 Tingmao Wang <m@maowtm.org>
Cc: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Paul Moore <paul@paul-moore.com>,
 Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo> <20260303.2e4c89f9fdfe@gnoack.org>
 <c482a8bb-d8c5-4008-9c8d-704d6a880022@maowtm.org>
 <20260303.94e335a9bdaa@gnoack.org>
From: Ding Yihan <dingyihan@uniontech.com>
In-Reply-To: <20260303.94e335a9bdaa@gnoack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NWujniBqiFoN3RkhC4qpPmhMqCN1YOLuTQajhAzcKwAv0lWNvBLhkD9q
	yy69UjGKGzoScJoLiadzbKTO8yHsmtlRjhhPiTXqHx3S6dwXb2feoBLBWokLtSAMSoD7XDm
	+nSK09M3qkehANjc232/hMZef4uoqkomIJXIGi3yyqfzSZoKkmwDPmMnqLmQxJa/juR2qJ2
	ESmiwbAFNrccJbH7ZPJs9u8RoB2/Ax2pxn1Ne9mHvYxutjgfWBuRP0D5/Cpm4jsQj4bCBE7
	uZ0C73AqZCdYgED/BH9estxFkttgrOXNCpQCTvihcjAXqoinm0nSLlZfo0A0dqehT0hkWmD
	KpfcdWyUjpy3h8mP2JHdK+sLdYKIs3dULTJ1lM+w4yNeiuXuxhFc1OBnMdfUUB8qAMMU/6m
	P1jmkSnUvPGq8bKoe7ObpvIOAhdjo5QMmJOzJK4ISHTHO3zDM3kqZaoHZHqqz7K5C0OBXWm
	ws+BTe2HRKxnsRPrgkED7vqHOJzt9d0l6Vk13uL6yFNX0zHm9M+ZEfn39TixRuJNjRCKgH+
	4Dygn8SJkz6QxKjEzUEo6QrelIAnD6kvAWQrFIh2B1tS6HQpMKLogm3DsBVkVXa3Uf1EMLW
	h5adxx1W3oUTBOU5l1swIPAnJIPtZ7mfc+M8qru2Rz1WZfUgRHj0qp3rGxrqojZLPrTvk+L
	wj+w2MYcbFAd3N7IE4560/fQ6mmlDMkJt3a0S1Ya+bRes8fsLdnpzZoeyl9zQdDSjV4/z17
	2XJyZ/2drRuxkh26RrP8vl5KrxbrPmPsAH+7R54L7KELzJYHXnbcNrs6za3FVVRI91kBLD7
	3Hk58u+zt5BAO8HNr1eFyUbB0t+gRirRuV49deY8xDpdu/gRaynb7Ob4u6Pza49T2/QRdXs
	SkY95DfhF/VyGHxu/l949O1Qq6Jl11JE6ziuGDBSw0gqsUJyLD4KOnT/fZBKKKBdyIc7bwF
	kjUUdtqjmgm6DHauaGhfmSAOhWscHy6my2uhKRYQJKp2+6HEDBU/20QgXCblSlNG68IyU7Q
	INwu99ex9cRtFgGNzH
X-QQ-XMRINFO: NS+P29fieYNwPngkqxogtd7TSCvM0pZABg==
X-QQ-RECHKSPAM: 0

Hi all,
﻿
Thank you Justin for catching the test failure and the thorough
investigation! And thanks Günther and Tingmao for diving into the
syscall restart mechanics.
﻿
I've evaluated both the `while` loop approach with `task_work_run()`
and the `restart_syscall()` approach. I strongly lean towards using
`restart_syscall()` as suggested by Tingmao. 
﻿
As Günther pointed out earlier, executing `task_work_run()` directly
deep inside the syscall context can be risky. Task works often assume
they are running at the kernel-user boundary with a specific state.
Using `restart_syscall()` safely bounces us to that boundary, processes
the works cleanly, and restarts the syscall via standard mechanisms.
﻿
After some selftests,I will prepare the v4 patch series using `restart_syscall()`.
I will also ensure all comments are properly wrapped to 80 columns as requested
by Mickaël, and make sure to include the proper Reported-by and
Suggested-by tags for everyone's excellent input here.
﻿
Expect the v4 series shortly. Thanks again for the great collaboration!
﻿
﻿
Best regards,
Yihan Ding

在 2026/3/4 05:19, Günther Noack 写道:
> On Tue, Mar 03, 2026 at 08:38:13PM +0000, Tingmao Wang wrote:
>> On 3/3/26 19:50, Günther Noack wrote:
>>> [...]
>>> On Tue, Mar 03, 2026 at 11:20:10AM -0500, Justin Suess wrote:
>>>> On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
>>>>> [...]
>>>>> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
>>>>> index de01aa899751..xxxxxxxxxxxx 100644
>>>>> --- a/security/landlock/tsync.c
>>>>> +++ b/security/landlock/tsync.c
>>>>> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>>>>>  	shared_ctx.new_cred = new_cred;
>>>>>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>>>>>  
>>>>> +	/*
>>>>> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
>>>>> +	 * when multiple threads call landlock_restrict_self() simultaneously.
>>>>> +	 */
>>>>> +	if (!down_write_trylock(&current->signal->exec_update_lock))
>>>>> +		return -ERESTARTNOINTR;
>>>> These two lines above introduced a test failure in tsync_test
>>>> completing_enablement.
>>>>
>>>> The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
>>>> (this patch) and is currently in the mic/next branch.
>>>>
>>>> I noticed the test failure while testing an unrelated patch.
>>>>
>>>> The bug is because this code never actually yields or restarts the syscall.
>>>>
>>>> This is the test output I observed:
>>>>
>>>>   [+] Running tsync_test:
>>>>   TAP version 13
>>>>   1..4
>>>>   # Starting 4 tests from 1 test cases.
>>>>   #  RUN           global.single_threaded_success ...
>>>>   #            OK  global.single_threaded_success
>>>>   ok 1 global.single_threaded_success
>>>>   #  RUN           global.multi_threaded_success ...
>>>>   #            OK  global.multi_threaded_success
>>>>   ok 2 global.multi_threaded_success
>>>>   #  RUN           global.multi_threaded_success_despite_diverging_domains ...
>>>>   #            OK  global.multi_threaded_success_despite_diverging_domains
>>>>   ok 3 global.multi_threaded_success_despite_diverging_domains
>>>>   #  RUN           global.competing_enablement ...
>>>>   # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
>>>
>>> The interesting part here is when you print out the errno that is
>>> returned from the syscall -- it is 513, the value of ERESTARTNOINTR!
>>>
>>> My understanding so far: Poking around in kernel/entry/common.c, it
>>> seems that __exit_to_user_mode_loop() calls
>>> arch_do_signal_or_restart() only when there is a pending signal
>>> (_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL).  So it was possible that the
>>> system call returns with the (normally internal) error code
>>> ERESTARTNOINTR, in the case where the trylock fails, but where current
>>> has not received a signal from the other competing TSYNC thread yet.
>>>
>>> So with that in mind, would it work to do this?
>>>
>>>   while (try-to-acquire-the-lock) {
>>>     if (current-has-task-works-pending)
>>>       return -ERESTARTNOINTR;
>>>
>>>     cond_resched();
>>>   }
>>>
>>> Then we could avoid calling task_work_run() directly; (I find it
>>> difficult to reason about the implications of calling taks_work_run()
>>> directly, because these task works may make assumptions about the
>>> context in which they are running.)
>>
>> I've not caught up with the full discussion so might be missing some context on why RESTARTNOINTR was used here,
>> but wouldn't
>>
>> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
>> index 950b63d23729..f695fe44e2f1 100644
>> --- a/security/landlock/tsync.c
>> +++ b/security/landlock/tsync.c
>> @@ -490,7 +490,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>>  	 * when multiple threads call landlock_restrict_self() simultaneously.
>>  	 */
>>  	if (!down_write_trylock(&current->signal->exec_update_lock))
>> -		return -ERESTARTNOINTR;
>> +		return restart_syscall();
>>  
>>  	/*
>>  	 * We schedule a pseudo-signal task_work for each of the calling task's
>>
>> achieve what the original patch intended?
> 
> Thanks, that's an excellent point!
> 
> restart_syscall() (a) sets TIF_SIGPENDING and then (b) returns
> -ERESTARTNOINTR.  (a) was the part that we have been missing for the
> restart to work (see discussion above).  Together, (a) and (b) cause
> __exit_to_user_mode_loop() to restart the syscall.  Given that this is
> offered in signal.h, this seems like a clean and more "official" way
> to do this than using the task works APIs.
> 
> It also fixes the previously failing selftest (I tried).
> 
> Yihan, Justin: Does that seem reasonable to you as well?
> 
> –Günther
> 


Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4F1CBEB9
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902240; cv=none; b=tijRCfQvfRPp94UMd9T0uQsYnux2TFK288m/+qZ9PY9Dns0+t0zhlndTL+pU8SU6rVp+wtfWKf1Bx78/YsXxHtnVTS+guKwzRmMYhuhgl5kUamZ74oi9jB4qzbnOn5mgPAT1Ccg5b1DDu0WuaWzbCnf1vwEl+8xYBZsjntlsoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902240; c=relaxed/simple;
	bh=UnMnE4AvOgoDaUKHQu4BcSAPw0V33aqjiXmilLNGAEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNU09XBe7kwCnhTsYNozf1Lr1e34uVWmpXK+k6JTy4lzoH1MoiR0L1A+mJ62md/Bbf1EzlRHEf3JrAJFcyC6QCo5XHpzWJsDTQ19SdNWkIPb9aVYWN3ORt9extGvpC7Hk+ZNd+mt94cihUvwq2i8oREaPJ/77kJYY8tPktBqNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Eu1qAumU; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Eu1qAumU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771902170;
	bh=z1N0LEged4wL71tJBsKAdaCRqLDVKlZWiBUjoaRGemQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Eu1qAumUY8tikZfcjtznaN74o/ZLkETtB2T/nq5dTfUS31UXHI5eepHl0q76eQx1P
	 FwqaZOoUrlKAoK1A2Db9thEfCDlY7uJlBObPw7KGhUBMDnj2JeGJhZwRPCw6byv3ef
	 GfbngeaElKjE9/QHi4t7bGqUSyUUf3ZCgvoyxcCE=
X-QQ-mid: esmtpsz17t1771902167tded7203f
X-QQ-Originating-IP: wyBaZQ66MIhq9o4z2CIlULeYrkn9Ii6Fkwa5WBELUjg=
Received: from [10.10.74.107] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 11:02:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 327181849731919882
Message-ID: <D0013EA515055145+3e08a07b-e384-4c08-ab17-f558f0130d30@uniontech.com>
Date: Tue, 24 Feb 2026 11:02:44 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>,
 Paul Moore <paul@paul-moore.com>
References: <69995a88.050a0220.340abe.0d25.GAE@google.com>
 <00A9E53EDC82309F+7b1dfc69-95f8-4ffc-a67c-967de0e2dfee@uniontech.com>
 <20260221.5d8a306bcaf1@gnoack.org> <20260221.3ff0e30e4010@gnoack.org>
 <20260223.52c45aed20f8@gnoack.org>
 <32095877A7CB47CB+bb9e1be8-59c2-46d9-b1ef-f22d2d8c386e@uniontech.com>
 <aZxvXARvYf6aQBUv@google.com>
From: Ding Yihan <dingyihan@uniontech.com>
In-Reply-To: <aZxvXARvYf6aQBUv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MMgPz8MirN77H54mtFG/ehL6q2az4y039GcpTksbRWlClofnXiaIZS3c
	btkpZWmTZI7wm/Vra2sRdT4QlpSVXKRpFj3mAKsq6xikFg1o/bee4fz8s1/hRqBJfxlptTc
	V2dkB2H7Bu9YlvW5KWPb4dlXURdNxAqIbkKgEPL8jmupVT5p+tLnBDN1H9r8h5Xqxvelru2
	QnWCyFfnds9zRwl7Zd7ZQcnbJPvoL3CIl47OsYDVAv/dSwybnWemWvF5HpR3XEHQQDoDjSW
	gefA2ar/f/ivtZ/nuXPvjz3QggQTpiCVD31NBUGA4Uqf4gUuzgIeVUhJtgzdWpgTNEiwD8v
	gbHwnqF3tzzmB5yIAgUAggLRClmA3xxgetnr9f0rUBqMwkRlMOX2SzQON9tFhdnGlBZdjSZ
	JCBlA7i0yV3OcsKfdLtGXl53+e4ennU+odYoUrj7uribx9Hx7tcmQNZBVRWrNnaoHMQbV1n
	mpzOY18f0q/yS0UnmNWVZlYgw8Lhse4aGe+Z2uyRDC1kDrwAJWluewhhY1sRj9m2vJfsep3
	LXyBUQPcoprZovFLCXOkOtreFSBmtwnBh5nFH2678zeYSo/1Eaw1J96xfb35pSLrvyz0rhf
	2Xik8/wHwxEBo10Uj9YdeP8TLbeQq+5zbckna9A9FjR6EBSR5WMVZBOxgwhCZZ0jaaUJbiA
	x/ci1Ee/srJfL1Bk7bkg98+/lc6+ZN1Knrql24rAwQ6JMcyJ8Un2/a/NeufcacwwH0dQZR/
	tqPIQTLGOHJ6mwyHgc9HRVP//IWbot7mB2ExOcxsb1oZPWzC8J3OhXyqdf3KgOuiQeT3A24
	YQ1rje61AH8xUO5ZjH0FDYKq2PmA/a+9pK1DC9x39EWU4WVn4S4dllR5udm9LQfRiGZU6G4
	mOpc4aWdDVbw7du1apISsDicx2lHpVDdn9WsM98ck7dzFvsMdNmO/Ys0DJXmybyTizO2+H5
	D9lCv699L9z36UioRK/LEFQTgLO7CPMpd7uP+9ok1M4Bbhsp/P5btz53D01V/AxsDfbjyT7
	BQxvqs/yHTaFulz3D2
X-QQ-XMRINFO: OD9hHCdaPRBwLDy8cgx64ga/W8i2gvq5OA==
X-QQ-RECHKSPAM: 0

Hi Günther,

Thank you for the detailed analysis! I completely agree that serializing the TSYNC 
operations is the right way to prevent this deadlock. I have drafted a patch using 
`exec_update_lock` (similar to how seccomp uses `cred_guard_mutex`).

Regarding your proposal to split this into two patches (one for the cleanup 
path and one for the lock): Maybe combining them into a single patch is a better choice. Here is why:

We actually *cannot* remove `wait_for_completion(&shared_ctx.all_prepared)` 
in the interrupt recovery path. Since `shared_ctx` is allocated on the local 
stack of the caller, removing the wait would cause a severe Use-After-Free (UAF) if the 
thread returns to userspace while sibling task_works are still executing and dereferencing `ctx`. 

By adding the lock, we inherently resolve the deadlock, meaning the sibling task_works 
will never get stuck. Thus, `wait_for_completion` becomes perfectly safe to keep, 
and it remains strictly necessary to protect the stack memory. Therefore, the "fix" for the 
cleanup path is simply updating the comments to reflect this reality, which is tightly coupled with the locking fix. 
It felt more cohesive as a single patch.

I have test the patch on my laptop,and it will not trigger the issue.Let's have syzbot test this combined logic:

#syz test: 

--- a/security/landlock/tsync.c

+++ b/security/landlock/tsync.c

@@ -447,6 +447,12 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,

        shared_ctx.new_cred = new_cred;

        shared_ctx.set_no_new_privs = task_no_new_privs(current);

 

+       /*

+        * Serialize concurrent TSYNC operations to prevent deadlocks

+        * when multiple threads call landlock_restrict_self() simultaneously.

+        */

+       down_write(&current->signal->exec_update_lock);

+

        /*

         * We schedule a pseudo-signal task_work for each of the calling task's

         * sibling threads.  In the task work, each thread:

@@ -527,14 +533,17 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,

                                           -ERESTARTNOINTR);

 

                                /*

-                                * Cancel task works for tasks that did not start running yet,

-                                * and decrement all_prepared and num_unfinished accordingly.

+                                * Opportunistic improvement: try to cancel task works

+                                * for tasks that did not start running yet. We do not

+                                * have a guarantee that it cancels any of the enqueued

+                                * task works (because task_work_run() might already have

+                                * dequeued them).

                                 */

                                cancel_tsync_works(&works, &shared_ctx);

 

                                /*

-                                * The remaining task works have started running, so waiting for

-                                * their completion will finish.

+                                * We must wait for the remaining task works to finish to

+                                * prevent a use-after-free of the local shared_ctx.

                                 */

                                wait_for_completion(&shared_ctx.all_prepared);

                        }

@@ -557,5 +566,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,

 

        tsync_works_release(&works);

 

+       up_write(&current->signal->exec_update_lock);

+

        return atomic_read(&shared_ctx.preparation_error);

 }

--
在 2026/2/23 23:16, Günther Noack 写道:
> Hello!
> 
> On Mon, Feb 23, 2026 at 07:29:56PM +0800, Ding Yihan wrote:
>> Thank you for the detailed analysis and the clear breakdown. 
>> Apologies for the delayed response. I spent the last couple of days
>> thoroughly reading through the previous mailing list discussions. I
>> was trying hard to see if there was any viable pure lockless design
>> that could solve this concurrency issue while preserving the original
>> architecture. 
>> ﻿
>> However, after looking at the complexities you outlined, I completely
>> agree with your conclusion: serializing the TSYNC operations is indeed
>> the most robust and reasonable path forward to prevent the deadlock.
>> ﻿
>> Regarding the lock choice, since 'cred_guard_mutex' is explicitly
>> marked as deprecated for new code in the kernel,maybe we can use its
>> modern replacement: 'exec_update_lock' (using down_write_trylock /
>> up_write on current->signal). This aligns with the current subsystem
>> standards and was also briefly touched upon by Jann in the older
>> discussions.
>> ﻿
>> I fully understand the requirement for the two-part patch series:
>> 1. Cleaning up the cancellation logic and comments.
>> 2. Introducing the serialization lock for TSYNC.
>> ﻿
>> I will take some time to draft and test this patch series properly. 
>> I also plan to discuss this with my kernel colleagues here at 
>> UnionTech to see if they have any additional suggestions on the 
>> implementation details before I submit it.
>> ﻿
>> I will send out the v1 patch series to the list as soon as it is
>> ready. Thanks again for your guidance and the great discussion!
> 
> Thank you, Ding, this is much appreciated!
> 
> I agree, the `exec_update_lock` might be the better solution;
> I also need to familiarize myself more with it to double-check.
> 
> —Günther
> 


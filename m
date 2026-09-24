Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882C346E59;
	Thu, 24 Sep 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239618; cv=none; b=feS4LMVfopTJ39P+pSFXn9dAlKyXuM/0zCjVA8w5hgcyicuhUGzEkx13L8FRXJMGdZY7Wfwx7wfR+KJxxYd3zNGm9mQO12hArW97S31pbVeGoPnEY2mAVMwjOExf4j+cuiNN+mdMvFwD3CWxeWuafPDXQhA7TMr3YirumPcG0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239618; c=relaxed/simple;
	bh=WlSam2aE7u/o4uytK8Yq6yToLBX/T1/7yKSH7w2zlTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AQWiBIiBImSHmBbdyWTYo8GVbJDEjUb/UTPMo0zTegHU3/wzsJ/IduTq1o7ASupJgW9l+qUh1jap8T+xB8AmQ5wVMdXVXtY0Klq9F/dXbI23oL3GZ0N65Fd9uEFw3/DamAfe2XsBYy4GqaEvGL5wzOtgbZp3SBjt5PB3BQ9t3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=07JmkPWJ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="07JmkPWJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bhzODlLJc6t8g21HePyOpmjFlBcHaXmPIdBQ4qRLw7g=;
	b=07JmkPWJfvxdv8YTWVgwM1ppNqrJ6GTtsp+kZ/2wDj1CZFzAIyraeIMm3XjKkoKWizIB3oLjP
	S9qhbRtrRvSe4yOQY5V7ktlOFulfPC57VmUFxfoS1BRSSmiXfVuXlRoHJ28bPEDj5yiy59pRRbJ
	ve/LMbgvFJdIl/jLPaZQNX8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hr6Zp0Lb7z12LJK;
	Thu, 24 Sep 2026 16:34:42 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A086940561;
	Thu, 24 Sep 2026 16:46:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 16:46:46 +0800
Message-ID: <29353ab9-f746-42ef-9c64-4c07b5371dec@huawei.com>
Date: Thu, 24 Sep 2026 16:46:46 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
To: "Andrew G. Morgan" <morgan@kernel.org>, "Serge E. Hallyn"
	<serge@hallyn.com>
CC: <paul@paul-moore.com>, <jmorris@namei.org>, <pjw@kernel.org>,
	<tglx@kernel.org>, <peterz@infradead.org>, <debug@rivosinc.com>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
 <arK0cT7CGb3Khy69@hallyn.com>
 <CACmP8UK5wGZmBTRVBOm2_ZGhpFG-jWpihvUNxrcrgXr5K2GYEw@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CACmP8UK5wGZmBTRVBOm2_ZGhpFG-jWpihvUNxrcrgXr5K2GYEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/23 10:10, Andrew G. Morgan 写道:
> The https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/cap#IAB.SetProc
> already handles this for the whole process. It can be run from main()

I think libcap argues *for* a kernel primitive here.

Its docs say whole-process (POSIX) semantics are implemented via
`libcap/psx`, which uses `syscall.AllThreadsSyscall()` when available,
and it exports `Prctlw` ("executes on all the threads of the process").
So `IAB.SetProc` does the same per-thread prctl dance as gvisor do
below— it doesn't avoid the cost.

112 // Apply applies `r` to every thread of the current process.
113 // May be run without procfs available.
114 // Fails with `ENOTSUP` in cgo builds.
115 func (r *ResolvedThreadCaps) Apply(timer *timing.Timer) error {
116 >-------// 1. Trim the bounding set on every thread. This must
happen before
117 >-------// capset drops CAP_SETPCAP from the effective set
(PR_CAPBSET_DROP
118 >-------// requires it).
119 >-------if r.haveSetPCap {
120 >------->-------for c := capability.Cap(0); c <= r.lastCap; c++ {
121 >------->------->-------if r.bounding&(uint64(1)<<uint(c)) != 0 {
122 >------->------->------->-------continue
123 >------->------->-------}
124 >------->------->-------if err :=
allThreadsPrctl(unix.PR_CAPBSET_DROP, uintptr(c), 0); err != nil {
125 >------->------->------->-------return fmt.Errorf("dropping bounding
capability %v on all threads: %w", c, err)
126 >------->------->-------}
127 >------->-------}
128 >-------}

58 // allThreadsPrctl issues `prctl(option, arg2, arg3)` on every OS
thread of the
 59 // process via `syscall.AllThreadsSyscall6`.
 60 func allThreadsPrctl(option, arg2, arg3 uintptr) error {
 61 >-------// EINVAL is ignored to mirror `capability.Apply`'s handling
of unsupported caps.
 62 >-------if _, _, errno := syscall.AllThreadsSyscall6(unix.SYS_PRCTL,
option, arg2, arg3, 0, 0, 0); errno != 0 && err    no != unix.EINVAL {
 63 >------->-------return errno
 64 >-------}
 65 >-------return nil
 66 }


> if you need it to happen early, and it will track down all of the
> threads in the runtime.
> 
> To Serge's point, I am also curious what benefit there is from doing
> it more quickly. After all, this is pretty much a one-time function
> request for any executable.

Every cap drop across all threads requires pausing each thread to
deliver a signal and resume it — effectively stop-the-world signal
delivery per thread, which serializes the operation and can't be
parallelized across cores.

The bounding-set trim is the worst case. As the code shows,
PR_CAPBSET_DROP must run per-thread for each capability bit.

So it's N threads × M capability bits stop-and-resume operations, all
serialized.

The benefit of doing this faster isn't about a one-time cost — gVisor
starts a sandbox per container and an agent starts a fresh sandbox per
task, so this runs on every sandbox start. And the local test shows that
warm end-to-end startup is ~160 ms (sentry boot ~70 ms), and the ~10 ms
trim on a high-core host is ~6% of end-to-end and ~14% of the sentry
boot — the largest single syscall phase in early boot. That's the hot
path, which is why making it faster matters.

> 
> FYI The "sendmail capabilities bug" reference is written up here:
> https://sites.google.com/site/fullycapable/thesendmailcapabilitiesissue
> 
> Cheers
> 
> Andrew
> 
> On Tue, Sep 22, 2026 at 10:01 AM Serge E. Hallyn <serge@hallyn.com> wrote:
>>
>> On Tue, Sep 22, 2026 at 05:58:16PM +0800, Jinjie Ruan wrote:
>>> The capability bounding set is per-thread: PR_CAPBSET_DROP only affects
>>> the calling thread, since its bounding set lives in the per-task struct
>>> cred.  User space that wants to drop capabilities for a whole process
>>> must therefore invoke PR_CAPBSET_DROP once per capability per thread,
>>> which on a many-threaded process is expensive, and from a Go runtime
>>> requires stopping the world and signalling every thread.
>>>
>>> Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
>>> capabilities, given as a 64-bit mask in arg2 (low 32 bits) and arg3
>>> (high 32 bits), from the bounding set of every thread of the calling
>>> thread group in a single call.
>>>
>>> The calling thread drops the capabilities synchronously, last; every
>>> sibling that still holds any of them is asked to drop them through a
>>> task_work item, so that it applies the drop in its own context.  This
>>> avoids racing with a sibling's concurrent credential updates such as
>>> setuid() or capset().  The call does not wait for the siblings: a
>>> sibling may be parked in a wait that is not woken by TIF_NOTIFY_SIGNAL
>>> (e.g. futex), so waiting could block for an unbounded time.  This is
>>> still safe, because TIF_NOTIFY_SIGNAL is handled on the way out to user
>>> mode, so a sibling applies the drop before executing any further
>>> userspace code.  It does not synchronize against a sibling that is
>>> concurrently creating threads, so callers must keep the thread group
>>> quiescent while dropping.
>>>
>>> Measured with gVisor's "bounding set trimmed" boot phase on an arm64 KVM
>>> guest (medians over repeated boots):
>>>   - 8 vCPUs:  ~1.6ms  -> ~0.10ms
>>>   - 32 vCPUs: ~3.5ms  -> ~0.11ms
>>>   - 64 vCPUs: ~10.1ms -> ~0.1-0.6ms
>>>   - cost goes from O(capabilities * threads) stop-the-world prctls to a
>>>     single thread-group walk.
>>
>> That is impressive, but please do detail the specific use case where
>> you need to drop from the bounding set after the go scheduler has started.
>> I can imagine some cases where you need to do some early setup and then
>> want to drop privileges, but you could also do that by re-exec'ing, so
>> I'd like to hear specifics.
>>
>> This makes me nervous, reminding me of the 'sendmail capabilities bug'.
>> If some program specifically locks down one thread, I could imagine the
>> locked down thread forcing wrong behavior from the privileged threads
>> by calling this.
>>
>>>
>>> Cc: Serge Hallyn <serge@hallyn.com>
>>> Cc: Paul Moore <paul@paul-moore.com>
>>> Cc: James Morris <jmorris@namei.org>
>>> Cc: Paul Walmsley <pjw@kernel.org>
>>> Cc: Thomas Gleixner <tglx@kernel.org>
>>> Cc: Zong Li <zong.li@sifive.com>
>>> Cc: Deepak Gupta <debug@rivosinc.com>
>>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  include/uapi/linux/prctl.h |   1 +
>>>  security/commoncap.c       | 129 +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 130 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>> index b6ec6f693719..750a7824d3bc 100644
>>> --- a/include/uapi/linux/prctl.h
>>> +++ b/include/uapi/linux/prctl.h
>>> @@ -70,6 +70,7 @@
>>>  /* Get/set the capability bounding set (as per security/commoncap.c) */
>>>  #define PR_CAPBSET_READ 23
>>>  #define PR_CAPBSET_DROP 24
>>> +#define PR_CAPBSET_DROP_MASK 83
>>>
>>>  /* Get/set the process' ability to use the timestamp counter instruction */
>>>  #define PR_GET_TSC 25
>>> diff --git a/security/commoncap.c b/security/commoncap.c
>>> index 3399535808fe..ae7ce50a8151 100644
>>> --- a/security/commoncap.c
>>> +++ b/security/commoncap.c
>>> @@ -19,7 +19,14 @@
>>>  #include <linux/hugetlb.h>
>>>  #include <linux/mount.h>
>>>  #include <linux/sched.h>
>>> +#include <linux/cred.h>
>>> +#include <linux/rcupdate.h>
>>> +#include <linux/sched/signal.h>
>>> +#include <linux/sched/task.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/task_work.h>
>>>  #include <linux/prctl.h>
>>> +#include <linux/printk.h>
>>>  #include <linux/securebits.h>
>>>  #include <linux/user_namespace.h>
>>>  #include <linux/binfmts.h>
>>> @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long cap)
>>>       return commit_creds(new);
>>>  }
>>>
>>> +/*
>>> + * Structure used to queue process-wide bounding set drops via task_work.
>>> + */
>>> +struct cap_bset_drop_work {
>>> +     struct callback_head work;
>>> +     struct task_struct *task;
>>> +     kernel_cap_t mask;
>>> +     struct cap_bset_drop_work *next;
>>> +};
>>> +
>>> +static void cap_bset_drop_work_fn(struct callback_head *work)
>>> +{
>>> +     struct cap_bset_drop_work *w = container_of(work, struct cap_bset_drop_work, work);
>>> +     struct cred *new = prepare_creds();
>>> +
>>> +     if (!new) {
>>> +             /* Out of memory: bounding set drop failed silently for this thread. */
>>> +             pr_warn_ratelimited("capability bounding set drop failed for pid %d (%s)\n",
>>> +                                 task_pid_nr(current), current->comm);
>>> +             goto out;
>>> +     }
>>> +
>>> +     new->cap_bset = cap_drop(new->cap_bset, w->mask);
>>> +     commit_creds(new);
>>> +
>>> +out:
>>> +     put_task_struct(w->task);
>>> +     kfree(w);
>>> +}
>>> +
>>> +/*
>>> + * cap_bset_drop_process - Drop capabilities from all threads in the group.
>>> + * @mask: Mask of capabilities to drop from the bounding set.
>>> + *
>>> + * Drops @mask from the calling thread synchronously, and queues a task_work
>>> + * item for each sibling thread to safely apply the drop in its own context.
>>> + *
>>> + * The caller must hold CAP_SETPCAP. Thread group must be quiescent to avoid
>>> + * racing with concurrent thread creation.
>>> + *
>>> + * Returns 0 on success, or -ENOMEM if allocations fail (all-or-nothing).
>>> + */
>>> +static int cap_bset_drop_process(kernel_cap_t mask)
>>> +{
>>> +     struct cap_bset_drop_work *list = NULL, *w, *next;
>>> +     struct task_struct *thread;
>>> +     struct cred *new = NULL;
>>> +     int ret = 0;
>>> +
>>> +     rcu_read_lock();
>>> +     for_each_thread(current, thread) {
>>> +             const struct cred *cred;
>>> +
>>> +             if (thread == current || (thread->flags & PF_EXITING))
>>> +                     continue;
>>> +
>>> +             cred = __task_cred(thread);
>>> +             if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
>>> +                     continue;
>>> +
>>> +             w = kmalloc_obj(*w, GFP_ATOMIC);
>>> +             if (!w) {
>>> +                     ret = -ENOMEM;
>>> +                     break;
>>> +             }
>>> +
>>> +             w->task = get_task_struct(thread);
>>> +             w->mask = mask;
>>> +             w->next = list;
>>> +             list = w;
>>> +     }
>>> +     rcu_read_unlock();
>>> +
>>> +     if (!ret) {
>>> +             new = prepare_creds();
>>> +             if (!new)
>>> +                     ret = -ENOMEM;
>>> +     }
>>> +
>>> +     if (ret) {
>>> +             while (list) {
>>> +                     next = list->next;
>>> +                     put_task_struct(list->task);
>>> +                     kfree(list);
>>> +                     list = next;
>>> +             }
>>> +             return ret;
>>> +     }
>>> +
>>> +     for (w = list; w; w = next) {
>>> +             next = w->next;
>>> +             init_task_work(&w->work, cap_bset_drop_work_fn);
>>> +             if (task_work_add(w->task, &w->work, TWA_SIGNAL)) {
>>> +                     put_task_struct(w->task);
>>> +                     kfree(w);
>>> +             }
>>> +     }
>>> +
>>> +     new->cap_bset = cap_drop(new->cap_bset, mask);
>>> +     commit_creds(new);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int cap_prctl_drop_mask(unsigned long low, unsigned long high)
>>> +{
>>> +     kernel_cap_t mask = mk_kernel_cap((u32)low, (u32)high);
>>> +
>>> +     if (cap_isclear(mask))
>>> +             return 0;
>>> +
>>> +     if (!ns_capable(current_user_ns(), CAP_SETPCAP))
>>> +             return -EPERM;
>>> +
>>> +     return cap_bset_drop_process(mask);
>>> +}
>>> +
>>>  /**
>>>   * cap_task_prctl - Implement process control functions for this security module
>>>   * @option: The process control function requested
>>> @@ -1313,6 +1437,11 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>>       case PR_CAPBSET_DROP:
>>>               return cap_prctl_drop(arg2);
>>>
>>> +     case PR_CAPBSET_DROP_MASK:
>>> +             if (arg4 || arg5)
>>> +                     return -EINVAL;
>>> +             return cap_prctl_drop_mask(arg2, arg3);
>>> +
>>>       /*
>>>        * The next four prctl's remain to assist with transitioning a
>>>        * system from legacy UID=0 based privilege (when filesystem
>>> --
>>> 2.34.1

-- 
Best regards,
Jinjie


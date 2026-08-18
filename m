Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF4376A06;
	Tue, 18 Aug 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050479; cv=none; b=szrBz/mONe9WTF2l5GiIVM/4lss6JKlYVYZNNHdEtBWAYLah1hene0hmX0+FOzmp/mlfqn2kgL4JcvuaRxYa2SxmGo4q5Kpfnoql18zR30Oqjkp/mXhvDO3fq4QEI5YJvXYnGRaG2QOAxGorNoRnHayGaLC4ClHnzHU0fKJnLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050479; c=relaxed/simple;
	bh=8LIYkA5df85h5KKCgu/PeRQD1B589bZmXCvuSFNl9HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ueys1I7gpUCUsO2HiafSgK7Kse1OCK/A09QgOUlkAbJKuhQoIU4EdlfROFhPclp+mbffVySUxQBK70IO+gFOvAshW+ofwYi6pxa0TyXlbC0J9tXQAGiL9+2crehNIqYtDUJKmsRWiNoTSJuEZ310MmndPVK/tH79oB0B9G/h0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hPRQw5YPkzYQv39;
	Tue, 18 Aug 2026 18:54:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF2CF40587;
	Tue, 18 Aug 2026 18:54:31 +0800 (CST)
Received: from [10.34.206.8] (unknown [10.34.206.8])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC38UDmOYRqW2cLCw--.720S2;
	Tue, 18 Aug 2026 18:54:31 +0800 (CST)
Message-ID: <698623ea-22d2-4f73-8a71-7ade1624dc01@huaweicloud.com>
Date: Tue, 18 Aug 2026 18:54:30 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: Justin Suess <utilityemal77@gmail.com>,
 Xiujianfeng <xiujianfeng@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <6ab57477-69f8-4c60-852e-58ce7ef25023@huaweicloud.com>
 <aoPXqkqJJ5a1J9JZ@zenbox>
From: Xiujianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <aoPXqkqJJ5a1J9JZ@zenbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC38UDmOYRqW2cLCw--.720S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3tw18Cw18ZF43uryfJFb_yoWxJr1Dpa
	yvg3WakrZrAF1xZF1IqFW7WF4Sq395Cry7AFn3G3yUAF4DXFn7Zr4IyF4Yka1IgrZ5Xr4F
	vFy29a9xCFyDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

On 8/18/2026 12:46 PM, Justin Suess wrote:
> On Tue, Aug 18, 2026 at 11:47:55AM +0800, Xiujianfeng wrote:
>> +cc Nicolas
>>
>> On 8/15/2026 7:20 PM, Justin Suess wrote:
>>> Howdy,
>>>
>>> BPF programs can attach to the locked_down LSM hook and contribute a
>>> verdict, but they have never been able to ask the locked_down question
>>> themselves: there is no way for a program to invoke the hook and learn
>>> whether a given operation is locked down. (i.e be a caller of
>>> security_locked_down rather than a consumer).
>>>
>>> Today the state has to be fed in out of band, for example userspace
>>> reading /sys/kernel/security/lockdown and writing the result into a
>>> map. That is a time-of-check/time-of-use race: a security_locked_down
>>> verdict can be raised at runtime, so the cached answer can be stale
>>> by the time the program acts on it.
>>
>> Adding the bpf_security_locked_down() kfunc does not actually solve the
>> TOCTOU issue you mentioned. Even after bpf_security_locked_down() is
>> called, userspace can still change the lockdown state via /sys/kernel/
>> security/lockdown.
>>
> This would put it at the same raciness level as any kernel caller of
> security_locked_down.
> 
> More importantly, the sysfs file is not equivalent to calling the
> hook. /sys/kernel/security/lockdown reflects only the lockdown LSM's
> static level.
> 
> security_locked_down() is a generic LSM hook and other
> implementers of locked_down: including BPF LSM programs attached to
> that hook (which is already supported) can contribute per-reason,
> dynamic verdicts that never appear in sysfs. The composite answer is
> only obtainable by invoking the hook, which is what this kfunc exposes.
> 
>> I fail to see the necessity for a BPF program to know whether a specific
>> operation is locked down. The test case provided in patch 2 does not
>> clearly demonstrate a scenario where this is required. In my view, the
>> verdict should happen exactly where security_locked_down() is currently
>> invoked.
>>
> Elaborating a bit more on the use cases:
> 
> 1. Being able to know if features LOCKDOWN_BPF_READ / LOCKDOWN_KPROBES is
>     locked down without a userspace hop / polling an LSM-specific interface
>     for error handling.
> 
> 2. Use with the BPF LSM implmentations of security_locked_down, without
>     Lockdown even in the picture.
> 
> 3. A BPF LSM can restrict access to arbritrary sensitive resources based
>     on the security_locked_down verdict.
> 

I stand by my view that LSM arbitration should happen right where the 
action is actually executed. Wrapping it inside BPF kfuncs introduces
dangerous nested invocations between LSM and BPF. While your patch
blocks the locked_down hook from calling bpf_security_locked_down, it is
a whack-a-mole workaround and does not alter the fact of nesting itself.

>> Furthermore, based on the current implementation of Lockdown, integrity
>> is the prerequisite for confidentiality. It is designed to be coarse-
>> grained and does not support per-operation lockdown. The fact that LSM
>> BPF can already hook into locked_down seems to violate this foundational
>> model, this is is analogous to the bitmap implementation [1], I’m
>> considering whether we should restrict BPF from attaching to the
>> locked_down hook. Nicolas, what are your thoughts on this?
> 
> You describe a Lockdown-specific model, why should other security models /
> implementations of the same hook be made to have the same semantics?
> 
> The point of the LSM hooks are to be generic.
> 
> (I have use cases that do rely on that hook; though I'm embarrased to
> speak on it and it is probably abuse: I use this hook to temporarily
> disable hibernation in BPF)
> 
> Justin
>>
>> [1]
>> https://lore.kernel.org/all/20250728111517.134116-1-nik.borisov@suse.com/
>>
>>>
>>> Add a bpf_security_locked_down() kfunc that calls
>>> security_locked_down() and returns its verdict, letting LSM and
>>> syscall programs query locked_down state at decision time. Out-of-range
>>> reasons are rejected with -EINVAL before dispatching the hook, and the
>>> kfunc is refused to programs attached to the locked_down hook itself,
>>> which would recurse into the dispatch. (how the obvious recursion issue
>>> is addressed).
>>>
>>> As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
>>> to host it.
>>>
>>> This kfunc has no reliance on / relation to the Lockdown LSM, despite the
>>> similar naming. It is an LSM-agnostic caller of security_locked_down, and
>>> Lockdown just happens to be the only in-tree subscriber to this hook at the
>>> moment.
>>>
>>> In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
>>> all, and uses a BPF implementation of security_locked_down.
>>>
>>> This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
>>> enabled due to this line in security/lockdown/lockdown.c:
>>>
>>>     pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
>>> 				                 current->comm, lockdown_reasons[what]);
>>>
>>> Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
>>> applies cleanly to the lsm tree.
>>>
>>> Justin
>>>
>>> Justin Suess (2):
>>>     lsm: add bpf_security_locked_down() kfunc
>>>     selftests/bpf: Test bpf_security_locked_down kfunc
>>>
>>>    security/Makefile                             |  1 +
>>>    security/lsm_kfuncs.c                         | 84 +++++++++++++++++++
>>>    .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 28 +++++++
>>>    .../testing/selftests/bpf/progs/lsm_kfuncs.c  | 34 ++++++++
>>>    .../selftests/bpf/progs/lsm_kfuncs_fail.c     | 26 ++++++
>>>    5 files changed, 173 insertions(+)
>>>    create mode 100644 security/lsm_kfuncs.c
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c
>>>
>>>
>>> base-commit: d82ebfc685c91e7f5623a8be949da1ddb767420b
>>


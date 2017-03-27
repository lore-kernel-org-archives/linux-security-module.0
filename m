From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Mon, 27 Mar 2017 18:02:52 +0300
Subject: [PATCH] mm: Remove pointless might_sleep() in remove_vm_area().
In-Reply-To: <201703272329.AIE32232.LtVSOOOFFQJFHM@I-love.SAKURA.ne.jp>
References: <201703242140.CHJ64587.LFSFQOJOOMtFHV@I-love.SAKURA.ne.jp>
	<fe511b26-f2e5-0a0e-09cc-303d38d2ad05@virtuozzo.com>
	<20170324161732.GA23110@bombadil.infradead.org>
	<0eceef23-a20c-bca7-2153-b9b5baf1f1d8@virtuozzo.com>
	<f1c0b9ec-c0c8-502c-c7f0-fe692c73ab04@vmware.com>
	<201703272329.AIE32232.LtVSOOOFFQJFHM@I-love.SAKURA.ne.jp>
Message-ID: <4a4f546c-4a92-1cea-14b6-bf3a8725b0e8@virtuozzo.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 03/27/2017 05:29 PM, Tetsuo Handa wrote:
> Thomas Hellstrom wrote:
>> So to summarize. Yes, the drm callers can be fixed up, but IMO requiring
>> vfree() to be non-atomic is IMO not a good idea if avoidable.
> 
> I agree.
> 
> I don't know about drm code. But I can find AppArmor code doing
> kvfree() from dfa_free() from aa_dfa_free_kref() from kref_put() from
> aa_put_dfa() from aa_free_profile() which says
> 
>  * If the profile was referenced from a task context, free_profile() will
>  * be called from an rcu callback routine, so we must not sleep here.
> 

It's safe to call vfree() from rcu callback as in any other interrupt context.
Commits you listed bellow didn't change anything in that respect.
They made impossible to call vfree() under stuff like preempt_disable()/spin_lock()


> which means that below changes broke things without properly auditing
> all vfree()/kvfree() users.
> 
>   commit bf22e37a641327e3 ("mm: add vfree_atomic()")
>   commit 0f110a9b956c1678 ("kernel/fork: use vfree_atomic() to free thread stack")
>   commit 8d5341a6260a59cf ("x86/ldt: use vfree_atomic() to free ldt entries")
>   commit 5803ed292e63a1bf ("mm: mark all calls into the vmalloc subsystem as potentially sleeping")
>   commit f9e09977671b618a ("mm: turn vmap_purge_lock into a mutex")
>   commit 763b218ddfaf5676 ("mm: add preempt points into __purge_vmap_area_lazy()")
> 
> Since above commits did not take appropriate proceedure for changing
> non-blocking API to blocking API, we must fix vfree() part for 4.10 and 4.11.
> 
> Updated patch is at
> http://lkml.kernel.org/r/201703271916.FBI69340.SQFtOFVJHOLOMF at I-love.SAKURA.ne.jp .
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

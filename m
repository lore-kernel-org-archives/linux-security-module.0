Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ADB3D3CE2;
	Tue, 22 Sep 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096509; cv=none; b=F4OZXlKfr8DBIafEl935K/gY7tyKC/wWptgjevEI49fV6rwzHrQgTB7CQVpYnxNPTkXaMV4hxp9hBYU10AlNUWcOnUbLPavn42r5X5vec2a5VkE1/tomLsU4vj2MTHO64kHxmeBzfDyUErjMsXVhExj+vVTtP/LGuB/INytES4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096509; c=relaxed/simple;
	bh=B+eidD3FB0I05W+6UpYXN0ptKgEAVZh88GMDy26/+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzLXzaHE8/tEgvXjr+DaKBTPETyTGn1Re9MVa/mvqNVX2q9yAB7cq3Fc65lQ8diZtnxaonKzbfoMEJqE04zq2lUpWsagTVNJCkLN/xDxHo+D2tKDG7GvTPMoKzGKmfAgl+S37eqnguLBxS1MxFvtVaaGTpkN0p6dvnDU3TGeFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=bnUBgO1E; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="bnUBgO1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1790096497; bh=B+eidD3FB0I05W+6UpYXN0ptKgEAVZh88GMDy26/+6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnUBgO1E5JHonb2aKR3pHs4nkpp06rz54lK8XHUDfIsB+NWM7rhTlzsGOxsTLkBW2
	 gU3qsqbejJQ6o/GWr5tBTsMDOhWsUEL4eGxc948KPVueStVrxsMvEi5+Cs61FoWkvk
	 bo4M9rnSN3X22uxKJyiDMhghgtN8lJ1DhPBT0Bp+x9RUkKfDmLYCwm8QEsFGvO2dCv
	 45T9fxNVoa430ak9IdxK2o+vZHK4gyRum158uwXpv+IwQxPIgzDSmmgQt4OJ9+NO50
	 +bHsdgxp+TqKDjDf3Gry38ebXSsHxhWZwCAZxcOOJuLBy7nldR1USCVvVcNwZ4WdSe
	 XQhKALNwygGKw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 28E921D11; Tue, 22 Sep 2026 12:01:37 -0500 (CDT)
Date: Tue, 22 Sep 2026 12:01:37 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>,
	"Andrew G. Morgan" <morgan@kernel.org>
Cc: paul@paul-moore.com, jmorris@namei.org, pjw@kernel.org, tglx@kernel.org,
	peterz@infradead.org, debug@rivosinc.com, broonie@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
Message-ID: <arK0cT7CGb3Khy69@hallyn.com>
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922095816.1191799-1-ruanjinjie@huawei.com>

On Tue, Sep 22, 2026 at 05:58:16PM +0800, Jinjie Ruan wrote:
> The capability bounding set is per-thread: PR_CAPBSET_DROP only affects
> the calling thread, since its bounding set lives in the per-task struct
> cred.  User space that wants to drop capabilities for a whole process
> must therefore invoke PR_CAPBSET_DROP once per capability per thread,
> which on a many-threaded process is expensive, and from a Go runtime
> requires stopping the world and signalling every thread.
> 
> Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> capabilities, given as a 64-bit mask in arg2 (low 32 bits) and arg3
> (high 32 bits), from the bounding set of every thread of the calling
> thread group in a single call.
> 
> The calling thread drops the capabilities synchronously, last; every
> sibling that still holds any of them is asked to drop them through a
> task_work item, so that it applies the drop in its own context.  This
> avoids racing with a sibling's concurrent credential updates such as
> setuid() or capset().  The call does not wait for the siblings: a
> sibling may be parked in a wait that is not woken by TIF_NOTIFY_SIGNAL
> (e.g. futex), so waiting could block for an unbounded time.  This is
> still safe, because TIF_NOTIFY_SIGNAL is handled on the way out to user
> mode, so a sibling applies the drop before executing any further
> userspace code.  It does not synchronize against a sibling that is
> concurrently creating threads, so callers must keep the thread group
> quiescent while dropping.
> 
> Measured with gVisor's "bounding set trimmed" boot phase on an arm64 KVM
> guest (medians over repeated boots):
>   - 8 vCPUs:  ~1.6ms  -> ~0.10ms
>   - 32 vCPUs: ~3.5ms  -> ~0.11ms
>   - 64 vCPUs: ~10.1ms -> ~0.1-0.6ms
>   - cost goes from O(capabilities * threads) stop-the-world prctls to a
>     single thread-group walk.

That is impressive, but please do detail the specific use case where
you need to drop from the bounding set after the go scheduler has started.
I can imagine some cases where you need to do some early setup and then
want to drop privileges, but you could also do that by re-exec'ing, so
I'd like to hear specifics.

This makes me nervous, reminding me of the 'sendmail capabilities bug'.
If some program specifically locks down one thread, I could imagine the
locked down thread forcing wrong behavior from the privileged threads
by calling this.

> 
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Zong Li <zong.li@sifive.com>
> Cc: Deepak Gupta <debug@rivosinc.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  include/uapi/linux/prctl.h |   1 +
>  security/commoncap.c       | 129 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index b6ec6f693719..750a7824d3bc 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -70,6 +70,7 @@
>  /* Get/set the capability bounding set (as per security/commoncap.c) */
>  #define PR_CAPBSET_READ 23
>  #define PR_CAPBSET_DROP 24
> +#define PR_CAPBSET_DROP_MASK 83
>  
>  /* Get/set the process' ability to use the timestamp counter instruction */
>  #define PR_GET_TSC 25
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fe..ae7ce50a8151 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -19,7 +19,14 @@
>  #include <linux/hugetlb.h>
>  #include <linux/mount.h>
>  #include <linux/sched.h>
> +#include <linux/cred.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched/signal.h>
> +#include <linux/sched/task.h>
> +#include <linux/slab.h>
> +#include <linux/task_work.h>
>  #include <linux/prctl.h>
> +#include <linux/printk.h>
>  #include <linux/securebits.h>
>  #include <linux/user_namespace.h>
>  #include <linux/binfmts.h>
> @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long cap)
>  	return commit_creds(new);
>  }
>  
> +/*
> + * Structure used to queue process-wide bounding set drops via task_work.
> + */
> +struct cap_bset_drop_work {
> +	struct callback_head work;
> +	struct task_struct *task;
> +	kernel_cap_t mask;
> +	struct cap_bset_drop_work *next;
> +};
> +
> +static void cap_bset_drop_work_fn(struct callback_head *work)
> +{
> +	struct cap_bset_drop_work *w = container_of(work, struct cap_bset_drop_work, work);
> +	struct cred *new = prepare_creds();
> +
> +	if (!new) {
> +		/* Out of memory: bounding set drop failed silently for this thread. */
> +		pr_warn_ratelimited("capability bounding set drop failed for pid %d (%s)\n",
> +				    task_pid_nr(current), current->comm);
> +		goto out;
> +	}
> +
> +	new->cap_bset = cap_drop(new->cap_bset, w->mask);
> +	commit_creds(new);
> +
> +out:
> +	put_task_struct(w->task);
> +	kfree(w);
> +}
> +
> +/*
> + * cap_bset_drop_process - Drop capabilities from all threads in the group.
> + * @mask: Mask of capabilities to drop from the bounding set.
> + *
> + * Drops @mask from the calling thread synchronously, and queues a task_work
> + * item for each sibling thread to safely apply the drop in its own context.
> + *
> + * The caller must hold CAP_SETPCAP. Thread group must be quiescent to avoid
> + * racing with concurrent thread creation.
> + *
> + * Returns 0 on success, or -ENOMEM if allocations fail (all-or-nothing).
> + */
> +static int cap_bset_drop_process(kernel_cap_t mask)
> +{
> +	struct cap_bset_drop_work *list = NULL, *w, *next;
> +	struct task_struct *thread;
> +	struct cred *new = NULL;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	for_each_thread(current, thread) {
> +		const struct cred *cred;
> +
> +		if (thread == current || (thread->flags & PF_EXITING))
> +			continue;
> +
> +		cred = __task_cred(thread);
> +		if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
> +			continue;
> +
> +		w = kmalloc_obj(*w, GFP_ATOMIC);
> +		if (!w) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		w->task = get_task_struct(thread);
> +		w->mask = mask;
> +		w->next = list;
> +		list = w;
> +	}
> +	rcu_read_unlock();
> +
> +	if (!ret) {
> +		new = prepare_creds();
> +		if (!new)
> +			ret = -ENOMEM;
> +	}
> +
> +	if (ret) {
> +		while (list) {
> +			next = list->next;
> +			put_task_struct(list->task);
> +			kfree(list);
> +			list = next;
> +		}
> +		return ret;
> +	}
> +
> +	for (w = list; w; w = next) {
> +		next = w->next;
> +		init_task_work(&w->work, cap_bset_drop_work_fn);
> +		if (task_work_add(w->task, &w->work, TWA_SIGNAL)) {
> +			put_task_struct(w->task);
> +			kfree(w);
> +		}
> +	}
> +
> +	new->cap_bset = cap_drop(new->cap_bset, mask);
> +	commit_creds(new);
> +
> +	return 0;
> +}
> +
> +static int cap_prctl_drop_mask(unsigned long low, unsigned long high)
> +{
> +	kernel_cap_t mask = mk_kernel_cap((u32)low, (u32)high);
> +
> +	if (cap_isclear(mask))
> +		return 0;
> +
> +	if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> +		return -EPERM;
> +
> +	return cap_bset_drop_process(mask);
> +}
> +
>  /**
>   * cap_task_prctl - Implement process control functions for this security module
>   * @option: The process control function requested
> @@ -1313,6 +1437,11 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  	case PR_CAPBSET_DROP:
>  		return cap_prctl_drop(arg2);
>  
> +	case PR_CAPBSET_DROP_MASK:
> +		if (arg4 || arg5)
> +			return -EINVAL;
> +		return cap_prctl_drop_mask(arg2, arg3);
> +
>  	/*
>  	 * The next four prctl's remain to assist with transitioning a
>  	 * system from legacy UID=0 based privilege (when filesystem
> -- 
> 2.34.1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236325;
	b=5aHKXSqYH0qJVXgCLXoSyLmUi/r0vwf4v9hRMaKcKhvMA3Ud0MSi3yrJWm5HiiB7Jtit
	 nT4QLBZxj2hrwozSN+dTRxL5iTIptlIy3+S7GB8J9xLxPfkEcLhrblZYhLsK71ujNIaW6
	 HrkllQiC70X1/gOEOMH6INgM2mcw6+S3QGJ3Z228oGuUUU8pDDydg5zwr5CowAGTiVSlE
	 0HY4wfutufd4LNVUsJISpMA4+qqNl9XPWBtdPCwBteyGwCVM6Px1kOrTQDZzr/xEarU8W
	 oG1F/DFeMWWbksoAEsc6qGoA+W5cHJs4b769NddZtQUJnQZhM4IAa/bSh/o0abnc+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236325;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=XxR8fHB9uwpHx/w1MdmC4KVzPrSjE7trNWzwMBlrWf0=;
	b=J4qJRQ8phECoGvpiFSqdSTjls+nax9MUso2EDkjMMqoAzFcZVnspjPscMmkFK50iZXxu
	 pXH1HiFhjrUAUGHB1sMLpEu5UVFspHzlW+Ch4lFEz7EyftllHTwg/4nGiY+Uclgcees63
	 /4YY+5JcVh/8DI7ZRe+iZx27TUQfzCVHhlw171LcTxjnV1/4XwGkDUvZk/qNUoO3j58g/
	 anI/XVeK8kDdvpPC9JHlRti3dyLsvISSTmNjvPI4q5gkkzAXZ74lrNSEwG0va7Go8F96a
	 gtb+DlE1vVCpBsT2ToUv8OMOqst/fDb5mJYEFbktRPNCPBG7P5XCSxUhjY/6HQ8M2mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=1aHqcvaN;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3B606A334;
	Mon,  9 Nov 2026 14:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A3B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=1aHqcvaN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794236315; bh=WymjN7N7Rid2IaonT15EX/ExjWOvKCz8vVek03LKJZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1aHqcvaNHHRpS+s+aQBcPz5e7zLme2tM6bA6GEwn+RSqAOChg4vsOqbgVsQX3bu/8
	 t7TU8qwzZWfUKLNARWUou1sBc8cvCterI6n5ofIizvdj9zPpVgWttR7Q6vxcFcxBJo
	 onxMGaoQ1PJMtXgaxEr0dY+cUHrnI0hBCwFgFG3cCGS3ZA2NoHbvVvW2mD3mFaNRQC
	 79U4XbDxfHdnmM+Q4I3bZ6kYkGBQf3bP/OjNBJizgoTW8Z9+5ifWPVWwoIzp+PvMqv
	 I/thUftT15qhjRtfm3q3OG8DaPfDEAL8SNRarZfz+ADBOQb3OM9OYJrk08rRitXEFb
	 CnQjloEt4saiA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6A7C8310; Mon,  9 Nov 2026 08:58:35 -0600 (CST)
Date: Mon, 9 Nov 2026 08:58:35 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, paul@paul-moore.com,
	jmorris@namei.org, shuah@kernel.org, brauner@kernel.org,
	alexjlzheng@tencent.com, jannh@google.com, jaime.saguillo@gmail.com,
	elver@google.com, blbllhy@gmail.com, bvanassche@acm.org,
	pjw@kernel.org, broonie@kernel.org, debug@rivosinc.com,
	tglx@kernel.org, aleksey.oladko@virtuozzo.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, morgan@kernel.org
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
Message-ID: <avHfm5/mVtuN/oPW@hallyn.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
 <atjN3JX7sWx9kpQ5@hallyn.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atjN3JX7sWx9kpQ5@hallyn.com>

Hi Oleg,

please see below.  Do you have any issues with this use of sighand?

On Wed, Oct 21, 2026 at 09:36:12AM -0500, Serge E. Hallyn wrote:
> On Tue, Sep 29, 2026 at 09:01:59PM +0800, Jinjie Ruan wrote:
> > PR_CAPBSET_DROP only affects the calling thread. Process-wide capability
> > dropping requires user space to loop over every thread and every
> > capability, which is highly expensive. For instance, long-lived
> > multi-threaded processes (like gVisor's sentry) spend milliseconds
> > trimming the bounding set because the runtime has to coordinate
> > and signal every thread.
> > 
> > Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> > capabilities from the entire thread group's bounding set in a single call.
> > The capabilities are specified via a 64-bit mask across arg2 (low 32 bits)
> > and arg3 (high 32 bits).
> > 
> > The drop is recorded in a per-thread-group mask,
> > signal_struct::cap_bset_pending, under sighand->siglock. This pending drop
> > is dynamically folded into the bounding set in critical paths:
> > cap_capset(), PR_CAPBSET_READ(), and cap_bprm_creds_from_file().
> > Running, concurrently created, or future threads within the group will
> > all immediately observe the drop. A forked child inherits this mask
> > in cap_bset_drop_fork() under siglock to close the race window
> > against clone().
> > 
> > The operation is drop-only, so concurrent callers commute and a single
> > atomic OR is the linearization point.  It performs no per-thread allocation
> > and only the caller's replacement cred can fail, reported synchronously as
> > -ENOMEM before anything changes.
> > 
> > In an arm64 KVM guest, trimming 41 capabilities of a multi-threaded Go
> > process takes ~8.5-23.6ms with the per-thread PR_CAPBSET_DROP loop and
> > ~11-14us with PR_CAPBSET_DROP_MASK, independent of the thread count.
> > 
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Interesting idea, storing it in the sighand.
> 
> Oleg, do you see any issues with that part of this?
> 
> Overall, this seems ok to me.  That is, I think it addresses all the
> concerns I had with the previous version.
> 
> > ---
> >  fs/proc/array.c              |  3 +-
> >  include/linux/capability.h   |  5 ++
> >  include/linux/sched/signal.h |  8 ++++
> >  include/uapi/linux/prctl.h   |  1 +
> >  kernel/fork.c                |  1 +
> >  security/commoncap.c         | 91 ++++++++++++++++++++++++++++++++++--
> >  6 files changed, 105 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/proc/array.c b/fs/proc/array.c
> > index f6f75d206762..f1cde26d079c 100644
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -63,6 +63,7 @@
> >  #include <linux/tty.h>
> >  #include <linux/string.h>
> >  #include <linux/mman.h>
> > +#include <linux/capability.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/sched/numa_balancing.h>
> >  #include <linux/sched/task_stack.h>
> > @@ -318,7 +319,7 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
> >  	cap_inheritable	= cred->cap_inheritable;
> >  	cap_permitted	= cred->cap_permitted;
> >  	cap_effective	= cred->cap_effective;
> > -	cap_bset	= cred->cap_bset;
> > +	cap_bset	= cap_bset_effective(p, cred);
> >  	cap_ambient	= cred->cap_ambient;
> >  	rcu_read_unlock();
> >  
> > diff --git a/include/linux/capability.h b/include/linux/capability.h
> > index 7921a0b3b04a..6413c7fedb69 100644
> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > @@ -38,6 +38,7 @@ struct file;
> >  struct inode;
> >  struct dentry;
> >  struct task_struct;
> > +struct cred;
> >  struct user_namespace;
> >  struct mnt_idmap;
> >  
> > @@ -197,6 +198,10 @@ bool capable_wrt_inode_uidgid(struct mnt_idmap *idmap,
> >  			      const struct inode *inode, int cap);
> >  extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
> >  extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
> > +extern kernel_cap_t cap_bset_effective(const struct task_struct *task,
> > +				       const struct cred *cred);
> > +extern void cap_bset_drop_fork(struct task_struct *p);
> > +
> >  static inline bool perfmon_capable(void)
> >  {
> >  	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> > index d45a5476b97d..bda6f18b65b9 100644
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -98,6 +98,14 @@ struct signal_struct {
> >  	int			quick_threads;
> >  	struct list_head	thread_head;
> >  
> > +	/*
> > +	 * Capabilities being removed from the bounding set of every thread in
> > +	 * this group by PR_CAPBSET_DROP_MASK.  Read on capability-transition
> > +	 * paths without sighand->siglock, hence atomic64 (a 64-bit value would
> > +	 * otherwise tear on 32-bit).
> > +	 */
> > +	atomic64_t		cap_bset_pending;
> > +
> >  	wait_queue_head_t	wait_chldexit;	/* for wait4() */
> >  
> >  	/* current thread group signal load-balancing target: */
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index b6ec6f693719..85ac71897070 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -70,6 +70,7 @@
> >  /* Get/set the capability bounding set (as per security/commoncap.c) */
> >  #define PR_CAPBSET_READ 23
> >  #define PR_CAPBSET_DROP 24
> > +#define PR_CAPBSET_DROP_MASK 82
> >  
> >  /* Get/set the process' ability to use the timestamp counter instruction */
> >  #define PR_GET_TSC 25
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 5ef413368912..bf671a85d39d 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2504,6 +2504,7 @@ __latent_entropy struct task_struct *copy_process(
> >  	 * before holding sighand lock.
> >  	 */
> >  	copy_seccomp(p);
> > +	cap_bset_drop_fork(p);
> >  
> >  	if (clone_flags & CLONE_NNP)
> >  		task_set_no_new_privs(p);
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 3399535808fe..3bec15d43731 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -3,6 +3,7 @@
> >   */
> >  
> >  #include <linux/capability.h>
> > +#include <linux/cred.h>
> >  #include <linux/audit.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > @@ -19,6 +20,7 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/mount.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> >  #include <linux/prctl.h>
> >  #include <linux/securebits.h>
> >  #include <linux/user_namespace.h>
> > @@ -30,6 +32,25 @@
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/capability.h>
> >  
> > +/**
> > + * Effective bounding set of @cred in @task's thread group
> > + * @task: task whose thread group's pending drop applies
> > + * @cred: credentials to read the bounding set from
> > + *
> > + * A drop recorded by PR_CAPBSET_DROP_MASK is authoritative on the thread group
> > + * and may not have been materialized into every thread's cred yet, so the
> > + * effective bounding set is the cred's own set minus the group's pending drop.
> > + */
> > +kernel_cap_t cap_bset_effective(const struct task_struct *task,
> > +				const struct cred *cred)
> > +{
> > +	kernel_cap_t pending = {
> > +		.val = atomic64_read(&task->signal->cap_bset_pending),
> > +	};
> > +
> > +	return cap_drop(cred->cap_bset, pending);
> > +}
> > +
> >  /*
> >   * If a non-root user executes a setuid-root binary in
> >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > @@ -284,8 +305,8 @@ int cap_capset(struct cred *new,
> >  
> >  	if (!cap_issubset(*inheritable,
> >  			  cap_combine(old->cap_inheritable,
> > -				      old->cap_bset)))
> >  		/* no new pI capabilities outside bounding set */
> > +				      cap_bset_effective(current, old))))
> >  		return -EPERM;
> >  
> >  	/* verify restrictions on target's new Permitted set */
> > @@ -849,7 +870,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
> >  	 */
> >  	if (__is_eff(root_uid, new) || __is_real(root_uid, new)) {
> >  		/* pP' = (cap_bset & ~0) | (pI & ~0) */
> > -		new->cap_permitted = cap_combine(old->cap_bset,
> > +		new->cap_permitted = cap_combine(new->cap_bset,
> >  						 old->cap_inheritable);
> >  	}
> >  	/*
> > @@ -925,6 +946,8 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
> >  	int ret;
> >  	kuid_t root_uid;
> >  
> > +	new->cap_bset = cap_bset_effective(current, new);
> > +
> >  	if (WARN_ON(!cap_ambient_invariant_ok(old)))
> >  		return -EPERM;
> >  
> > @@ -1283,6 +1306,63 @@ static int cap_prctl_drop(unsigned long cap)
> >  	return commit_creds(new);
> >  }
> >  
> > +static int cap_bset_drop_process(kernel_cap_t mask)
> > +{
> > +	kernel_cap_t pending;
> > +	struct cred *new;
> > +
> > +	new = prepare_creds();
> > +	if (!new)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Record the drop before committing the caller's cred, so that a
> > +	 * thread created from now on is guaranteed to observe it.  Apply the
> > +	 * current union, not just this call's mask, to the caller's cred.
> > +	 */
> > +	spin_lock_irq(&current->sighand->siglock);
> > +	atomic64_or(mask.val, &current->signal->cap_bset_pending);
> > +	pending.val = atomic64_read(&current->signal->cap_bset_pending);
> > +	spin_unlock_irq(&current->sighand->siglock);
> > +
> > +	new->cap_bset = cap_drop(new->cap_bset, pending);
> > +	commit_creds(new);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Propagate a pending process-wide bounding-set drop to @p, a task being
> > + * created by the current thread.  Threads sharing the group read
> > + * current->signal->cap_bset_pending directly; a forked child gets its own
> > + * signal_struct and must carry the mask itself.  Called under
> > + * current->sighand->siglock, which serializes it with cap_bset_drop_process().
> > + */
> > +void cap_bset_drop_fork(struct task_struct *p)
> > +{
> > +	kernel_cap_t mask = {
> > +		.val = atomic64_read(&current->signal->cap_bset_pending),
> > +	};
> > +
> > +	if (cap_isclear(mask) || p->signal == current->signal)
> > +		return;
> > +
> > +	atomic64_or(mask.val, &p->signal->cap_bset_pending);
> > +}
> > +
> > +static int cap_prctl_drop_mask(unsigned long low, unsigned long high)
> > +{
> > +	kernel_cap_t mask = mk_kernel_cap((u32)low, (u32)high);
> > +
> > +	if (cap_isclear(mask))
> > +		return 0;
> > +
> > +	if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> > +		return -EPERM;
> > +
> > +	return cap_bset_drop_process(mask);
> > +}
> > +
> >  /**
> >   * cap_task_prctl - Implement process control functions for this security module
> >   * @option: The process control function requested
> > @@ -1308,11 +1388,16 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >  	case PR_CAPBSET_READ:
> >  		if (!cap_valid(arg2))
> >  			return -EINVAL;
> > -		return !!cap_raised(old->cap_bset, arg2);
> > +		return !!cap_raised(cap_bset_effective(current, old), arg2);
> >  
> >  	case PR_CAPBSET_DROP:
> >  		return cap_prctl_drop(arg2);
> >  
> > +	case PR_CAPBSET_DROP_MASK:
> > +		if (arg4 || arg5)
> > +			return -EINVAL;
> > +		return cap_prctl_drop_mask(arg2, arg3);
> > +
> >  	/*
> >  	 * The next four prctl's remain to assist with transitioning a
> >  	 * system from legacy UID=0 based privilege (when filesystem
> > -- 
> > 2.34.1

Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708936194F;
	Fri, 25 Sep 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347361; cv=none; b=J3Ca2KX8MRpe6BYd3NwvuT6LHaR53xINuJnPM5SL7NS0Pr1bHwIYY+zPsC0smp5SkiPXMzOv/3QHYZUKBLr0TdfjjDVb2fxW0D0SUZJLlH5wKQaplLn1zUYJgxnnKcA1SpfAcWXSE90gSvPD+/AhKkoaUomwto1n0pnSRJntuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347361; c=relaxed/simple;
	bh=gBMJJ1TQqBja3X8kFWISk1lQVl6qtuplfPx7+gvki9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaeB+/08xWR3/OKW0Z51CyxTqWtxMP/ucDFoq/GSJlHUOCL8DACg8pksZSffeGNtjdA8jFUjMoHOEEk23l183CUxAxgbdC8aYvJ3H/GbFBJL7J107oy9sp89A+miCgfvnokp05HGXUAetnI2j1tOdpDhrbs3IMB8KzJaBGaAS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=CZlMbzoz; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="CZlMbzoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1790347345; bh=gBMJJ1TQqBja3X8kFWISk1lQVl6qtuplfPx7+gvki9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZlMbzoz6bhDaKZ2vzsBO8WjM9a9BtlhpGrODE57UZ0OJ1KVZqnL2urdxpy8cl/MU
	 fO5iMjOvYPY2uIgvfsm+B/RU/kyTtFTmgOfvkLgE6lbLMeW/qiEfouZ+TkjIdUMkCE
	 q2YXbn0RfEHPJY1vZzvK6Y8EuaQPSYlizvWA/6tafBS4AdTUgGImLIPN4Q6jfPGxmX
	 S9aOezIAS1DMAlhTKEoh+lgYQ0hKJOCqppuAq14PVxieY66JBePi9XxuO8l1DG99Rv
	 iB4hnd9KpvasIwSEiHEfLRyTzWj0wW1ycgnjBjO+BCzb6y+gjRiaqNqpfiqIBNXlL+
	 j08ZBBzU9ZUKQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 71B83277; Fri, 25 Sep 2026 09:42:25 -0500 (CDT)
Date: Fri, 25 Sep 2026 09:42:25 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Andrew G. Morgan" <morgan@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, paul@paul-moore.com,
	jmorris@namei.org, pjw@kernel.org, tglx@kernel.org,
	peterz@infradead.org, debug@rivosinc.com, broonie@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
Message-ID: <araIUXjOOQ9KuXki@hallyn.com>
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
 <arK0cT7CGb3Khy69@hallyn.com>
 <7f0c935f-2c3f-4511-924f-822c3acf93da@huawei.com>
 <arZ0TfXSLjmDtyRy@hallyn.com>
 <CACmP8UL0SEZxMn4XkByVPtKbRuc_mWQLafwgPZ_=dOFUzo5HKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACmP8UL0SEZxMn4XkByVPtKbRuc_mWQLafwgPZ_=dOFUzo5HKQ@mail.gmail.com>

Also (not sure whether this is what Andrew is referring to here), in your
code below, what keeps one thread from doing a clone in between the
task harvesting loop and the task_work_add() loop?  It seems like you'd
need to do another loop after to make sure you didn't miss any new
tasks?

And of course we'd need a more robust solution to

> > > >> +          /* Out of memory: bounding set drop failed silently for this thread. */

-serge

On Fri, Sep 25, 2026 at 07:28:08AM -0700, Andrew G. Morgan wrote:
> I don't see a race condition in the (*cap.IAB).Set() code. The
> semantics of this sort of thing can't be allowed to include a race;
> otherwise, back-to-back calls to this "system call" might generate
> divergent thread state. How you do that without some serialization
> isn't clear to me.
> 
> Cheers
> 
> Andrew
> 
> On Fri, Sep 25, 2026 at 6:17 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Thu, Sep 24, 2026 at 04:05:59PM +0800, Jinjie Ruan wrote:
> > >
> > >
> > > 在 2026/9/23 1:01, Serge E. Hallyn 写道:
> > > > On Tue, Sep 22, 2026 at 05:58:16PM +0800, Jinjie Ruan wrote:
> > > >> The capability bounding set is per-thread: PR_CAPBSET_DROP only affects
> > > >> the calling thread, since its bounding set lives in the per-task struct
> > > >> cred.  User space that wants to drop capabilities for a whole process
> > > >> must therefore invoke PR_CAPBSET_DROP once per capability per thread,
> > > >> which on a many-threaded process is expensive, and from a Go runtime
> > > >> requires stopping the world and signalling every thread.
> > > >>
> > > >> Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> > > >> capabilities, given as a 64-bit mask in arg2 (low 32 bits) and arg3
> > > >> (high 32 bits), from the bounding set of every thread of the calling
> > > >> thread group in a single call.
> > > >>
> > > >> The calling thread drops the capabilities synchronously, last; every
> > > >> sibling that still holds any of them is asked to drop them through a
> > > >> task_work item, so that it applies the drop in its own context.  This
> > > >> avoids racing with a sibling's concurrent credential updates such as
> > > >> setuid() or capset().  The call does not wait for the siblings: a
> > > >> sibling may be parked in a wait that is not woken by TIF_NOTIFY_SIGNAL
> > > >> (e.g. futex), so waiting could block for an unbounded time.  This is
> > > >> still safe, because TIF_NOTIFY_SIGNAL is handled on the way out to user
> > > >> mode, so a sibling applies the drop before executing any further
> > > >> userspace code.  It does not synchronize against a sibling that is
> > > >> concurrently creating threads, so callers must keep the thread group
> > > >> quiescent while dropping.
> > > >>
> > > >> Measured with gVisor's "bounding set trimmed" boot phase on an arm64 KVM
> > > >> guest (medians over repeated boots):
> > > >>   - 8 vCPUs:  ~1.6ms  -> ~0.10ms
> > > >>   - 32 vCPUs: ~3.5ms  -> ~0.11ms
> > > >>   - 64 vCPUs: ~10.1ms -> ~0.1-0.6ms
> > > >>   - cost goes from O(capabilities * threads) stop-the-world prctls to a
> > > >>     single thread-group walk.
> > > >
> > > > That is impressive, but please do detail the specific use case where
> > > > you need to drop from the bounding set after the go scheduler has started.
> > > > I can imagine some cases where you need to do some early setup and then
> > > > want to drop privileges, but you could also do that by re-exec'ing, so
> > > > I'd like to hear specifics.
> > >
> > > Hi Serge,
> > >
> > > Thanks for the review.
> > >
> > > The use case is gVisor's sentry: a long-lived, pure-Go process that
> > > starts a sandbox per container/pod. The final capability set depends on
> > > the spec, the platform (ptrace requires CAP_SYS_PTRACE),
> > > directfs/networking, and the capabilities granted to the runtime's user
> > > namespace.
> > >
> > > It is therefore only known after the runtime and gVisor's own threads
> > > are already up — the trim happens multi-threaded. We do have a re-exec
> > > path, but it re-loads a ~100 MB binary and re-runs Go init, so we only
> > > take it when forced.
> > >
> > > >
> > > > This makes me nervous, reminding me of the 'sendmail capabilities bug'.
> > > > If some program specifically locks down one thread, I could imagine the
> > > > locked down thread forcing wrong behavior from the privileged threads
> > > > by calling this.
> > >
> > > Fair concern. This new prcoess-wide drop is also a drop — it only
> > > removes capabilities from all threads, and requires CAP_SETPCAP. But it
> >
> > Good point, CAP_SETPCAP requirement might mitigate my concern.  I'll look
> > at this a bit more, thanks.
> >
> > > must actually reach every thread, so the thread-creation race still
> > > needs to be addressed.
> > >
> > > >
> > > >>
> > > >> Cc: Serge Hallyn <serge@hallyn.com>
> > > >> Cc: Paul Moore <paul@paul-moore.com>
> > > >> Cc: James Morris <jmorris@namei.org>
> > > >> Cc: Paul Walmsley <pjw@kernel.org>
> > > >> Cc: Thomas Gleixner <tglx@kernel.org>
> > > >> Cc: Zong Li <zong.li@sifive.com>
> > > >> Cc: Deepak Gupta <debug@rivosinc.com>
> > > >> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > > >> ---
> > > >>  include/uapi/linux/prctl.h |   1 +
> > > >>  security/commoncap.c       | 129 +++++++++++++++++++++++++++++++++++++
> > > >>  2 files changed, 130 insertions(+)
> > > >>
> > > >> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > > >> index b6ec6f693719..750a7824d3bc 100644
> > > >> --- a/include/uapi/linux/prctl.h
> > > >> +++ b/include/uapi/linux/prctl.h
> > > >> @@ -70,6 +70,7 @@
> > > >>  /* Get/set the capability bounding set (as per security/commoncap.c) */
> > > >>  #define PR_CAPBSET_READ 23
> > > >>  #define PR_CAPBSET_DROP 24
> > > >> +#define PR_CAPBSET_DROP_MASK 83
> > > >>
> > > >>  /* Get/set the process' ability to use the timestamp counter instruction */
> > > >>  #define PR_GET_TSC 25
> > > >> diff --git a/security/commoncap.c b/security/commoncap.c
> > > >> index 3399535808fe..ae7ce50a8151 100644
> > > >> --- a/security/commoncap.c
> > > >> +++ b/security/commoncap.c
> > > >> @@ -19,7 +19,14 @@
> > > >>  #include <linux/hugetlb.h>
> > > >>  #include <linux/mount.h>
> > > >>  #include <linux/sched.h>
> > > >> +#include <linux/cred.h>
> > > >> +#include <linux/rcupdate.h>
> > > >> +#include <linux/sched/signal.h>
> > > >> +#include <linux/sched/task.h>
> > > >> +#include <linux/slab.h>
> > > >> +#include <linux/task_work.h>
> > > >>  #include <linux/prctl.h>
> > > >> +#include <linux/printk.h>
> > > >>  #include <linux/securebits.h>
> > > >>  #include <linux/user_namespace.h>
> > > >>  #include <linux/binfmts.h>
> > > >> @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long cap)
> > > >>    return commit_creds(new);
> > > >>  }
> > > >>
> > > >> +/*
> > > >> + * Structure used to queue process-wide bounding set drops via task_work.
> > > >> + */
> > > >> +struct cap_bset_drop_work {
> > > >> +  struct callback_head work;
> > > >> +  struct task_struct *task;
> > > >> +  kernel_cap_t mask;
> > > >> +  struct cap_bset_drop_work *next;
> > > >> +};
> > > >> +
> > > >> +static void cap_bset_drop_work_fn(struct callback_head *work)
> > > >> +{
> > > >> +  struct cap_bset_drop_work *w = container_of(work, struct cap_bset_drop_work, work);
> > > >> +  struct cred *new = prepare_creds();
> > > >> +
> > > >> +  if (!new) {
> > > >> +          /* Out of memory: bounding set drop failed silently for this thread. */
> > > >> +          pr_warn_ratelimited("capability bounding set drop failed for pid %d (%s)\n",
> > > >> +                              task_pid_nr(current), current->comm);
> > > >> +          goto out;
> > > >> +  }
> > > >> +
> > > >> +  new->cap_bset = cap_drop(new->cap_bset, w->mask);
> > > >> +  commit_creds(new);
> > > >> +
> > > >> +out:
> > > >> +  put_task_struct(w->task);
> > > >> +  kfree(w);
> > > >> +}
> > > >> +
> > > >> +/*
> > > >> + * cap_bset_drop_process - Drop capabilities from all threads in the group.
> > > >> + * @mask: Mask of capabilities to drop from the bounding set.
> > > >> + *
> > > >> + * Drops @mask from the calling thread synchronously, and queues a task_work
> > > >> + * item for each sibling thread to safely apply the drop in its own context.
> > > >> + *
> > > >> + * The caller must hold CAP_SETPCAP. Thread group must be quiescent to avoid
> > > >> + * racing with concurrent thread creation.
> > > >> + *
> > > >> + * Returns 0 on success, or -ENOMEM if allocations fail (all-or-nothing).
> > > >> + */
> > > >> +static int cap_bset_drop_process(kernel_cap_t mask)
> > > >> +{
> > > >> +  struct cap_bset_drop_work *list = NULL, *w, *next;
> > > >> +  struct task_struct *thread;
> > > >> +  struct cred *new = NULL;
> > > >> +  int ret = 0;
> > > >> +
> > > >> +  rcu_read_lock();
> > > >> +  for_each_thread(current, thread) {
> > > >> +          const struct cred *cred;
> > > >> +
> > > >> +          if (thread == current || (thread->flags & PF_EXITING))
> > > >> +                  continue;
> > > >> +
> > > >> +          cred = __task_cred(thread);
> > > >> +          if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
> > > >> +                  continue;
> > > >> +
> > > >> +          w = kmalloc_obj(*w, GFP_ATOMIC);
> > > >> +          if (!w) {
> > > >> +                  ret = -ENOMEM;
> > > >> +                  break;
> > > >> +          }
> > > >> +
> > > >> +          w->task = get_task_struct(thread);
> > > >> +          w->mask = mask;
> > > >> +          w->next = list;
> > > >> +          list = w;
> > > >> +  }
> > > >> +  rcu_read_unlock();
> > > >> +
> > > >> +  if (!ret) {
> > > >> +          new = prepare_creds();
> > > >> +          if (!new)
> > > >> +                  ret = -ENOMEM;
> > > >> +  }
> > > >> +
> > > >> +  if (ret) {
> > > >> +          while (list) {
> > > >> +                  next = list->next;
> > > >> +                  put_task_struct(list->task);
> > > >> +                  kfree(list);
> > > >> +                  list = next;
> > > >> +          }
> > > >> +          return ret;
> > > >> +  }
> > > >> +
> > > >> +  for (w = list; w; w = next) {
> > > >> +          next = w->next;
> > > >> +          init_task_work(&w->work, cap_bset_drop_work_fn);
> > > >> +          if (task_work_add(w->task, &w->work, TWA_SIGNAL)) {
> > > >> +                  put_task_struct(w->task);
> > > >> +                  kfree(w);
> > > >> +          }
> > > >> +  }
> > > >> +
> > > >> +  new->cap_bset = cap_drop(new->cap_bset, mask);
> > > >> +  commit_creds(new);
> > > >> +
> > > >> +  return 0;
> > > >> +}
> > > >> +
> > > >> +static int cap_prctl_drop_mask(unsigned long low, unsigned long high)
> > > >> +{
> > > >> +  kernel_cap_t mask = mk_kernel_cap((u32)low, (u32)high);
> > > >> +
> > > >> +  if (cap_isclear(mask))
> > > >> +          return 0;
> > > >> +
> > > >> +  if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> > > >> +          return -EPERM;
> > > >> +
> > > >> +  return cap_bset_drop_process(mask);
> > > >> +}
> > > >> +
> > > >>  /**
> > > >>   * cap_task_prctl - Implement process control functions for this security module
> > > >>   * @option: The process control function requested
> > > >> @@ -1313,6 +1437,11 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> > > >>    case PR_CAPBSET_DROP:
> > > >>            return cap_prctl_drop(arg2);
> > > >>
> > > >> +  case PR_CAPBSET_DROP_MASK:
> > > >> +          if (arg4 || arg5)
> > > >> +                  return -EINVAL;
> > > >> +          return cap_prctl_drop_mask(arg2, arg3);
> > > >> +
> > > >>    /*
> > > >>     * The next four prctl's remain to assist with transitioning a
> > > >>     * system from legacy UID=0 based privilege (when filesystem
> > > >> --
> > > >> 2.34.1
> > >
> > > --
> > > Best regards,
> > > Jinjie

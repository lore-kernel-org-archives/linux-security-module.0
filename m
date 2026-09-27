Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511F215075
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790523123; cv=none; b=n3FkVxdsoTT4QrNgEzzkCRuxjlWT3IJteTLbRQ+LcKL3RfMlztwO7dBMvbft3cHwIj7jsPXo7cC0vzDwFXGSYTvWne+k0Egxn4JRL1+fS5zQXLHlbsGZtCd/1QD7rwpD459aG6U76A5yizs9fes+TVzEX5jInX5rJ6lYSE/UGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790523123; c=relaxed/simple;
	bh=cAI4grjwLOIe/dpBrGVYGklNtZOwir4iXihLzkWBmYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1+tEhz7b258IPR+ffVdRCVhTkwgifqBfuWt/gcdRFrgf6r22NBRsdr0w6z3W5PBIwCyDa0ZaYnZ5dHZ4a3KbISCZ8QUrL3bEuPK9p89M7Xpx52rBuvAFofqFTmPQU4K6+s9kW8LcxsL/xuhbjgaqR4qdDWiPmQsXws6nU8yR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdK+JITG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdK+JITG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A851F00898
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790523120;
	bh=i+XtjOEr25mKpcBS2dPaibacr4BPHuZTb9SBTDpfO60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GdK+JITG7Mg196rmB/7a+z9a7RugSE40/BPKA3onhtDTymB/ywYrL6hlDZtvyNMW2
	 h5m06xWIeyORV9rq6z2O1AZNghz3dNCsWzd4Z0DZ7WGCpiBaZzJfExTMhbjdiHAwGZ
	 4ArS7ztRlNEiYbLySSe9k7cbq8vDFQPCdqpcKUWzt63vZ+EBE7JRBNtlbo3Wt4gQGg
	 rDwJK9MSI6If1jWOWQP7G730iayWfQNlGHEOqvrNLjmMwNaYSh0VyKGaJReO1pDlIh
	 jvvAd9/AcHMB81PAEgVjMswGkdX1uNNs4zN/v9iZiOVfLUkTkpFUqfpk4t0a9/hT0Z
	 qs74qguxuUQJA==
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88272e1d069so406583b3a.1
        for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 08:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByeRRP7xpePBpsrR85Ro+d1VE43SE6AqfOM55z/8tqEuLHdMfxJDhb0Ms3LM+wwESvHYUHZw/vN4SoEo5Rg1xQqaRHYaNc=@vger.kernel.org
X-Gm-Message-State: AFuF++m/rTxOwVln70M9vIXSgM6x1/A3+hUtFLO11lx54eiWcec6+1Iq
	ZPWYYS/tvI56g4MEvWSVl6vsqYUXUVCPFCrx2tbCkauRJjFTleEh9IW0pqn/ZnDa9duqADnvEC7
	nbuPl6cFpzq+7nlQEhRJjNWOexIWkN98=
X-Received: by 2002:a05:6300:44:b0:3dd:85a9:55ac with SMTP id
 adf61e73a8af0-3de26db6d92mr6968432637.37.1790523120448; Sun, 27 Sep 2026
 08:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
 <arK0cT7CGb3Khy69@hallyn.com> <7f0c935f-2c3f-4511-924f-822c3acf93da@huawei.com>
 <arZ0TfXSLjmDtyRy@hallyn.com> <CACmP8UL0SEZxMn4XkByVPtKbRuc_mWQLafwgPZ_=dOFUzo5HKQ@mail.gmail.com>
 <araIUXjOOQ9KuXki@hallyn.com>
In-Reply-To: <araIUXjOOQ9KuXki@hallyn.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Sun, 27 Sep 2026 08:31:49 -0700
X-Gmail-Original-Message-ID: <CACmP8ULzE-m2d+76AdyQ7nsVj=t6kWvyed05KCc2=99EOr+6Yw@mail.gmail.com>
X-Gm-Features: AclHuK-g5jLY9vtCYryLzo9EQRYbXMxOCc23AgY8CTsQL90wFe8oridMtYkpiFU
Message-ID: <CACmP8ULzE-m2d+76AdyQ7nsVj=t6kWvyed05KCc2=99EOr+6Yw@mail.gmail.com>
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, paul@paul-moore.com, jmorris@namei.org, 
	pjw@kernel.org, tglx@kernel.org, peterz@infradead.org, debug@rivosinc.com, 
	broonie@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My point is as follows.

- Let's say proc p1 contains threads t1, t2, t3.
- Both t1 and t2 call this new system call at the same time with
different target states.
- All while t3 is calling clone (creating t4 at some point).

Without serialization, what state results? The state t1 wants or the
state t2 wants? If a loop around is included for t4, what happens if
t1, having set its own thread state and "returned" immediately calls
this syscall again? What state will the threads end up with?

Serialization, for me, is that one of t1 and t2 wins the first race,
and its will is enforced on every thread (including t4) before t2's
intent can take effect. That intent may, indeed, not be attainable, if
t1 has denied something t2 wants and that attempt should fail.

Cheers

Andrew

On Fri, Sep 25, 2026 at 7:42=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> Also (not sure whether this is what Andrew is referring to here), in your
> code below, what keeps one thread from doing a clone in between the
> task harvesting loop and the task_work_add() loop?  It seems like you'd
> need to do another loop after to make sure you didn't miss any new
> tasks?
>
> And of course we'd need a more robust solution to
>
> > > > >> +          /* Out of memory: bounding set drop failed silently f=
or this thread. */
>
> -serge
>
> On Fri, Sep 25, 2026 at 07:28:08AM -0700, Andrew G. Morgan wrote:
> > I don't see a race condition in the (*cap.IAB).Set() code. The
> > semantics of this sort of thing can't be allowed to include a race;
> > otherwise, back-to-back calls to this "system call" might generate
> > divergent thread state. How you do that without some serialization
> > isn't clear to me.
> >
> > Cheers
> >
> > Andrew
> >
> > On Fri, Sep 25, 2026 at 6:17=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > >
> > > On Thu, Sep 24, 2026 at 04:05:59PM +0800, Jinjie Ruan wrote:
> > > >
> > > >
> > > > =E5=9C=A8 2026/9/23 1:01, Serge E. Hallyn =E5=86=99=E9=81=93:
> > > > > On Tue, Sep 22, 2026 at 05:58:16PM +0800, Jinjie Ruan wrote:
> > > > >> The capability bounding set is per-thread: PR_CAPBSET_DROP only =
affects
> > > > >> the calling thread, since its bounding set lives in the per-task=
 struct
> > > > >> cred.  User space that wants to drop capabilities for a whole pr=
ocess
> > > > >> must therefore invoke PR_CAPBSET_DROP once per capability per th=
read,
> > > > >> which on a many-threaded process is expensive, and from a Go run=
time
> > > > >> requires stopping the world and signalling every thread.
> > > > >>
> > > > >> Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> > > > >> capabilities, given as a 64-bit mask in arg2 (low 32 bits) and a=
rg3
> > > > >> (high 32 bits), from the bounding set of every thread of the cal=
ling
> > > > >> thread group in a single call.
> > > > >>
> > > > >> The calling thread drops the capabilities synchronously, last; e=
very
> > > > >> sibling that still holds any of them is asked to drop them throu=
gh a
> > > > >> task_work item, so that it applies the drop in its own context. =
 This
> > > > >> avoids racing with a sibling's concurrent credential updates suc=
h as
> > > > >> setuid() or capset().  The call does not wait for the siblings: =
a
> > > > >> sibling may be parked in a wait that is not woken by TIF_NOTIFY_=
SIGNAL
> > > > >> (e.g. futex), so waiting could block for an unbounded time.  Thi=
s is
> > > > >> still safe, because TIF_NOTIFY_SIGNAL is handled on the way out =
to user
> > > > >> mode, so a sibling applies the drop before executing any further
> > > > >> userspace code.  It does not synchronize against a sibling that =
is
> > > > >> concurrently creating threads, so callers must keep the thread g=
roup
> > > > >> quiescent while dropping.
> > > > >>
> > > > >> Measured with gVisor's "bounding set trimmed" boot phase on an a=
rm64 KVM
> > > > >> guest (medians over repeated boots):
> > > > >>   - 8 vCPUs:  ~1.6ms  -> ~0.10ms
> > > > >>   - 32 vCPUs: ~3.5ms  -> ~0.11ms
> > > > >>   - 64 vCPUs: ~10.1ms -> ~0.1-0.6ms
> > > > >>   - cost goes from O(capabilities * threads) stop-the-world prct=
ls to a
> > > > >>     single thread-group walk.
> > > > >
> > > > > That is impressive, but please do detail the specific use case wh=
ere
> > > > > you need to drop from the bounding set after the go scheduler has=
 started.
> > > > > I can imagine some cases where you need to do some early setup an=
d then
> > > > > want to drop privileges, but you could also do that by re-exec'in=
g, so
> > > > > I'd like to hear specifics.
> > > >
> > > > Hi Serge,
> > > >
> > > > Thanks for the review.
> > > >
> > > > The use case is gVisor's sentry: a long-lived, pure-Go process that
> > > > starts a sandbox per container/pod. The final capability set depend=
s on
> > > > the spec, the platform (ptrace requires CAP_SYS_PTRACE),
> > > > directfs/networking, and the capabilities granted to the runtime's =
user
> > > > namespace.
> > > >
> > > > It is therefore only known after the runtime and gVisor's own threa=
ds
> > > > are already up =E2=80=94 the trim happens multi-threaded. We do hav=
e a re-exec
> > > > path, but it re-loads a ~100 MB binary and re-runs Go init, so we o=
nly
> > > > take it when forced.
> > > >
> > > > >
> > > > > This makes me nervous, reminding me of the 'sendmail capabilities=
 bug'.
> > > > > If some program specifically locks down one thread, I could imagi=
ne the
> > > > > locked down thread forcing wrong behavior from the privileged thr=
eads
> > > > > by calling this.
> > > >
> > > > Fair concern. This new prcoess-wide drop is also a drop =E2=80=94 i=
t only
> > > > removes capabilities from all threads, and requires CAP_SETPCAP. Bu=
t it
> > >
> > > Good point, CAP_SETPCAP requirement might mitigate my concern.  I'll =
look
> > > at this a bit more, thanks.
> > >
> > > > must actually reach every thread, so the thread-creation race still
> > > > needs to be addressed.
> > > >
> > > > >
> > > > >>
> > > > >> Cc: Serge Hallyn <serge@hallyn.com>
> > > > >> Cc: Paul Moore <paul@paul-moore.com>
> > > > >> Cc: James Morris <jmorris@namei.org>
> > > > >> Cc: Paul Walmsley <pjw@kernel.org>
> > > > >> Cc: Thomas Gleixner <tglx@kernel.org>
> > > > >> Cc: Zong Li <zong.li@sifive.com>
> > > > >> Cc: Deepak Gupta <debug@rivosinc.com>
> > > > >> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > > >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > > > >> ---
> > > > >>  include/uapi/linux/prctl.h |   1 +
> > > > >>  security/commoncap.c       | 129 ++++++++++++++++++++++++++++++=
+++++++
> > > > >>  2 files changed, 130 insertions(+)
> > > > >>
> > > > >> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prc=
tl.h
> > > > >> index b6ec6f693719..750a7824d3bc 100644
> > > > >> --- a/include/uapi/linux/prctl.h
> > > > >> +++ b/include/uapi/linux/prctl.h
> > > > >> @@ -70,6 +70,7 @@
> > > > >>  /* Get/set the capability bounding set (as per security/commonc=
ap.c) */
> > > > >>  #define PR_CAPBSET_READ 23
> > > > >>  #define PR_CAPBSET_DROP 24
> > > > >> +#define PR_CAPBSET_DROP_MASK 83
> > > > >>
> > > > >>  /* Get/set the process' ability to use the timestamp counter in=
struction */
> > > > >>  #define PR_GET_TSC 25
> > > > >> diff --git a/security/commoncap.c b/security/commoncap.c
> > > > >> index 3399535808fe..ae7ce50a8151 100644
> > > > >> --- a/security/commoncap.c
> > > > >> +++ b/security/commoncap.c
> > > > >> @@ -19,7 +19,14 @@
> > > > >>  #include <linux/hugetlb.h>
> > > > >>  #include <linux/mount.h>
> > > > >>  #include <linux/sched.h>
> > > > >> +#include <linux/cred.h>
> > > > >> +#include <linux/rcupdate.h>
> > > > >> +#include <linux/sched/signal.h>
> > > > >> +#include <linux/sched/task.h>
> > > > >> +#include <linux/slab.h>
> > > > >> +#include <linux/task_work.h>
> > > > >>  #include <linux/prctl.h>
> > > > >> +#include <linux/printk.h>
> > > > >>  #include <linux/securebits.h>
> > > > >>  #include <linux/user_namespace.h>
> > > > >>  #include <linux/binfmts.h>
> > > > >> @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long =
cap)
> > > > >>    return commit_creds(new);
> > > > >>  }
> > > > >>
> > > > >> +/*
> > > > >> + * Structure used to queue process-wide bounding set drops via =
task_work.
> > > > >> + */
> > > > >> +struct cap_bset_drop_work {
> > > > >> +  struct callback_head work;
> > > > >> +  struct task_struct *task;
> > > > >> +  kernel_cap_t mask;
> > > > >> +  struct cap_bset_drop_work *next;
> > > > >> +};
> > > > >> +
> > > > >> +static void cap_bset_drop_work_fn(struct callback_head *work)
> > > > >> +{
> > > > >> +  struct cap_bset_drop_work *w =3D container_of(work, struct ca=
p_bset_drop_work, work);
> > > > >> +  struct cred *new =3D prepare_creds();
> > > > >> +
> > > > >> +  if (!new) {
> > > > >> +          /* Out of memory: bounding set drop failed silently f=
or this thread. */
> > > > >> +          pr_warn_ratelimited("capability bounding set drop fai=
led for pid %d (%s)\n",
> > > > >> +                              task_pid_nr(current), current->co=
mm);
> > > > >> +          goto out;
> > > > >> +  }
> > > > >> +
> > > > >> +  new->cap_bset =3D cap_drop(new->cap_bset, w->mask);
> > > > >> +  commit_creds(new);
> > > > >> +
> > > > >> +out:
> > > > >> +  put_task_struct(w->task);
> > > > >> +  kfree(w);
> > > > >> +}
> > > > >> +
> > > > >> +/*
> > > > >> + * cap_bset_drop_process - Drop capabilities from all threads i=
n the group.
> > > > >> + * @mask: Mask of capabilities to drop from the bounding set.
> > > > >> + *
> > > > >> + * Drops @mask from the calling thread synchronously, and queue=
s a task_work
> > > > >> + * item for each sibling thread to safely apply the drop in its=
 own context.
> > > > >> + *
> > > > >> + * The caller must hold CAP_SETPCAP. Thread group must be quies=
cent to avoid
> > > > >> + * racing with concurrent thread creation.
> > > > >> + *
> > > > >> + * Returns 0 on success, or -ENOMEM if allocations fail (all-or=
-nothing).
> > > > >> + */
> > > > >> +static int cap_bset_drop_process(kernel_cap_t mask)
> > > > >> +{
> > > > >> +  struct cap_bset_drop_work *list =3D NULL, *w, *next;
> > > > >> +  struct task_struct *thread;
> > > > >> +  struct cred *new =3D NULL;
> > > > >> +  int ret =3D 0;
> > > > >> +
> > > > >> +  rcu_read_lock();
> > > > >> +  for_each_thread(current, thread) {
> > > > >> +          const struct cred *cred;
> > > > >> +
> > > > >> +          if (thread =3D=3D current || (thread->flags & PF_EXIT=
ING))
> > > > >> +                  continue;
> > > > >> +
> > > > >> +          cred =3D __task_cred(thread);
> > > > >> +          if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
> > > > >> +                  continue;
> > > > >> +
> > > > >> +          w =3D kmalloc_obj(*w, GFP_ATOMIC);
> > > > >> +          if (!w) {
> > > > >> +                  ret =3D -ENOMEM;
> > > > >> +                  break;
> > > > >> +          }
> > > > >> +
> > > > >> +          w->task =3D get_task_struct(thread);
> > > > >> +          w->mask =3D mask;
> > > > >> +          w->next =3D list;
> > > > >> +          list =3D w;
> > > > >> +  }
> > > > >> +  rcu_read_unlock();
> > > > >> +
> > > > >> +  if (!ret) {
> > > > >> +          new =3D prepare_creds();
> > > > >> +          if (!new)
> > > > >> +                  ret =3D -ENOMEM;
> > > > >> +  }
> > > > >> +
> > > > >> +  if (ret) {
> > > > >> +          while (list) {
> > > > >> +                  next =3D list->next;
> > > > >> +                  put_task_struct(list->task);
> > > > >> +                  kfree(list);
> > > > >> +                  list =3D next;
> > > > >> +          }
> > > > >> +          return ret;
> > > > >> +  }
> > > > >> +
> > > > >> +  for (w =3D list; w; w =3D next) {
> > > > >> +          next =3D w->next;
> > > > >> +          init_task_work(&w->work, cap_bset_drop_work_fn);
> > > > >> +          if (task_work_add(w->task, &w->work, TWA_SIGNAL)) {
> > > > >> +                  put_task_struct(w->task);
> > > > >> +                  kfree(w);
> > > > >> +          }
> > > > >> +  }
> > > > >> +
> > > > >> +  new->cap_bset =3D cap_drop(new->cap_bset, mask);
> > > > >> +  commit_creds(new);
> > > > >> +
> > > > >> +  return 0;
> > > > >> +}
> > > > >> +
> > > > >> +static int cap_prctl_drop_mask(unsigned long low, unsigned long=
 high)
> > > > >> +{
> > > > >> +  kernel_cap_t mask =3D mk_kernel_cap((u32)low, (u32)high);
> > > > >> +
> > > > >> +  if (cap_isclear(mask))
> > > > >> +          return 0;
> > > > >> +
> > > > >> +  if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> > > > >> +          return -EPERM;
> > > > >> +
> > > > >> +  return cap_bset_drop_process(mask);
> > > > >> +}
> > > > >> +
> > > > >>  /**
> > > > >>   * cap_task_prctl - Implement process control functions for thi=
s security module
> > > > >>   * @option: The process control function requested
> > > > >> @@ -1313,6 +1437,11 @@ int cap_task_prctl(int option, unsigned l=
ong arg2, unsigned long arg3,
> > > > >>    case PR_CAPBSET_DROP:
> > > > >>            return cap_prctl_drop(arg2);
> > > > >>
> > > > >> +  case PR_CAPBSET_DROP_MASK:
> > > > >> +          if (arg4 || arg5)
> > > > >> +                  return -EINVAL;
> > > > >> +          return cap_prctl_drop_mask(arg2, arg3);
> > > > >> +
> > > > >>    /*
> > > > >>     * The next four prctl's remain to assist with transitioning =
a
> > > > >>     * system from legacy UID=3D0 based privilege (when filesyste=
m
> > > > >> --
> > > > >> 2.34.1
> > > >
> > > > --
> > > > Best regards,
> > > > Jinjie

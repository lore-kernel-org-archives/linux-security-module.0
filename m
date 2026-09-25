Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D449B21B
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346503; cv=none; b=ngRgpiZIRs8kVBK//yXz0pKV2GlqOwZNDAKjqVhs3IrYdHZqzaH04thhRPx5DJnbt6oQHgQaVlRu80yHmkYh34jn+sDqvGjChYLaJZIo2ZkFlfSzzQ6ujG2QyAOXvnHw3dcAig1hpRO7tWjGbjn7d8ouP5gkOPjDAoF+MEvfqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346503; c=relaxed/simple;
	bh=A5T5wf4G+/WsSR6xbVt9QGXCYDAY2n/VwwE6PYb7Hrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHYvRndUCHr5hmMii9ecvCOGjtu8lxyCS8Qj0dW0M02v6kdv2tzFAGJpceAhMGKlNKAidz/hRHz9ZPKRUKKr65pXVLafe0SWpSVgPt6GIlbFng9R4dd9eQ5Jr5rW8D03QJqLxLjStKofCbIr/fNpYVrApu0C1zzx9xAAz7bTlb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1tFcASI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1tFcASI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09871F0089A
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346500;
	bh=+s4rZvm4EIXd9sAi6fhmL0FtVBELi8f++tXk8DpdkYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n1tFcASIdfqwx6qQkPe++GZx0Xdd5oVDVRCJRiFVisqpYezYxt3BNMeLRRc+B655x
	 GgQKaCWsk72nKWOgQb/yBr/kAGSdoqawI4blECOIv3ZLImtQFZZLPHyWDE6TjpDVro
	 Y2qOnGOApyI/2ZgqTv/v/wOw7PL1uffU+WD2LL8GqP0WffYT+CEYQWHhggvu1cvSit
	 yqUPlgPNNuaWZRCQmxtuD45t4I4CuvllQn5Q/bBGiqmwXYWlbmTCkeALv4+F+Nm3Dl
	 v+VysFEVouLHVu4yvB821vvWRlFESfIqxqdHaMEAqCE1B0HCiugoFw607w0UnzMvAC
	 ptwaiYkcLrvSg==
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0c52f9a45so392846a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 07:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwGeE6RSHT10PlgkjXAz23qtsguDACRibAjMtHunYhBC0UtbKrSimokBx4JsErTTpUG13Yuztctb8XqMY1m5OdbN1vlHIk=@vger.kernel.org
X-Gm-Message-State: AFuF++mky9hc2Fx93tUjUewTCLhrs5sETsnHika4BUgxviWuok1P0vyQ
	n37sS5UDIuEiRncpDbFAM2kSecE5hjImzbKiVqFOyt/tOwyeDP/6g91wniTfEdb2S5EhJlTj2BD
	rPW+9YD9/6MeOnzUsbPoqCM3+7WKar1k=
X-Received: by 2002:a17:90b:52c4:b0:3a0:bdd7:f1f5 with SMTP id
 98e67ed59e1d1-3a0bdd7ff10mr1710783a91.13.1790346500397; Fri, 25 Sep 2026
 07:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
 <arK0cT7CGb3Khy69@hallyn.com> <7f0c935f-2c3f-4511-924f-822c3acf93da@huawei.com>
 <arZ0TfXSLjmDtyRy@hallyn.com>
In-Reply-To: <arZ0TfXSLjmDtyRy@hallyn.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Fri, 25 Sep 2026 07:28:08 -0700
X-Gmail-Original-Message-ID: <CACmP8UL0SEZxMn4XkByVPtKbRuc_mWQLafwgPZ_=dOFUzo5HKQ@mail.gmail.com>
X-Gm-Features: AclHuK-w3XQrH3mGRc5pMduNZnjF_uLsOguvwzuJmO0IiALrMdpO19Vyc3wQjDA
Message-ID: <CACmP8UL0SEZxMn4XkByVPtKbRuc_mWQLafwgPZ_=dOFUzo5HKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, paul@paul-moore.com, jmorris@namei.org, 
	pjw@kernel.org, tglx@kernel.org, peterz@infradead.org, debug@rivosinc.com, 
	broonie@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't see a race condition in the (*cap.IAB).Set() code. The
semantics of this sort of thing can't be allowed to include a race;
otherwise, back-to-back calls to this "system call" might generate
divergent thread state. How you do that without some serialization
isn't clear to me.

Cheers

Andrew

On Fri, Sep 25, 2026 at 6:17=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Thu, Sep 24, 2026 at 04:05:59PM +0800, Jinjie Ruan wrote:
> >
> >
> > =E5=9C=A8 2026/9/23 1:01, Serge E. Hallyn =E5=86=99=E9=81=93:
> > > On Tue, Sep 22, 2026 at 05:58:16PM +0800, Jinjie Ruan wrote:
> > >> The capability bounding set is per-thread: PR_CAPBSET_DROP only affe=
cts
> > >> the calling thread, since its bounding set lives in the per-task str=
uct
> > >> cred.  User space that wants to drop capabilities for a whole proces=
s
> > >> must therefore invoke PR_CAPBSET_DROP once per capability per thread=
,
> > >> which on a many-threaded process is expensive, and from a Go runtime
> > >> requires stopping the world and signalling every thread.
> > >>
> > >> Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> > >> capabilities, given as a 64-bit mask in arg2 (low 32 bits) and arg3
> > >> (high 32 bits), from the bounding set of every thread of the calling
> > >> thread group in a single call.
> > >>
> > >> The calling thread drops the capabilities synchronously, last; every
> > >> sibling that still holds any of them is asked to drop them through a
> > >> task_work item, so that it applies the drop in its own context.  Thi=
s
> > >> avoids racing with a sibling's concurrent credential updates such as
> > >> setuid() or capset().  The call does not wait for the siblings: a
> > >> sibling may be parked in a wait that is not woken by TIF_NOTIFY_SIGN=
AL
> > >> (e.g. futex), so waiting could block for an unbounded time.  This is
> > >> still safe, because TIF_NOTIFY_SIGNAL is handled on the way out to u=
ser
> > >> mode, so a sibling applies the drop before executing any further
> > >> userspace code.  It does not synchronize against a sibling that is
> > >> concurrently creating threads, so callers must keep the thread group
> > >> quiescent while dropping.
> > >>
> > >> Measured with gVisor's "bounding set trimmed" boot phase on an arm64=
 KVM
> > >> guest (medians over repeated boots):
> > >>   - 8 vCPUs:  ~1.6ms  -> ~0.10ms
> > >>   - 32 vCPUs: ~3.5ms  -> ~0.11ms
> > >>   - 64 vCPUs: ~10.1ms -> ~0.1-0.6ms
> > >>   - cost goes from O(capabilities * threads) stop-the-world prctls t=
o a
> > >>     single thread-group walk.
> > >
> > > That is impressive, but please do detail the specific use case where
> > > you need to drop from the bounding set after the go scheduler has sta=
rted.
> > > I can imagine some cases where you need to do some early setup and th=
en
> > > want to drop privileges, but you could also do that by re-exec'ing, s=
o
> > > I'd like to hear specifics.
> >
> > Hi Serge,
> >
> > Thanks for the review.
> >
> > The use case is gVisor's sentry: a long-lived, pure-Go process that
> > starts a sandbox per container/pod. The final capability set depends on
> > the spec, the platform (ptrace requires CAP_SYS_PTRACE),
> > directfs/networking, and the capabilities granted to the runtime's user
> > namespace.
> >
> > It is therefore only known after the runtime and gVisor's own threads
> > are already up =E2=80=94 the trim happens multi-threaded. We do have a =
re-exec
> > path, but it re-loads a ~100 MB binary and re-runs Go init, so we only
> > take it when forced.
> >
> > >
> > > This makes me nervous, reminding me of the 'sendmail capabilities bug=
'.
> > > If some program specifically locks down one thread, I could imagine t=
he
> > > locked down thread forcing wrong behavior from the privileged threads
> > > by calling this.
> >
> > Fair concern. This new prcoess-wide drop is also a drop =E2=80=94 it on=
ly
> > removes capabilities from all threads, and requires CAP_SETPCAP. But it
>
> Good point, CAP_SETPCAP requirement might mitigate my concern.  I'll look
> at this a bit more, thanks.
>
> > must actually reach every thread, so the thread-creation race still
> > needs to be addressed.
> >
> > >
> > >>
> > >> Cc: Serge Hallyn <serge@hallyn.com>
> > >> Cc: Paul Moore <paul@paul-moore.com>
> > >> Cc: James Morris <jmorris@namei.org>
> > >> Cc: Paul Walmsley <pjw@kernel.org>
> > >> Cc: Thomas Gleixner <tglx@kernel.org>
> > >> Cc: Zong Li <zong.li@sifive.com>
> > >> Cc: Deepak Gupta <debug@rivosinc.com>
> > >> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > >> ---
> > >>  include/uapi/linux/prctl.h |   1 +
> > >>  security/commoncap.c       | 129 ++++++++++++++++++++++++++++++++++=
+++
> > >>  2 files changed, 130 insertions(+)
> > >>
> > >> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > >> index b6ec6f693719..750a7824d3bc 100644
> > >> --- a/include/uapi/linux/prctl.h
> > >> +++ b/include/uapi/linux/prctl.h
> > >> @@ -70,6 +70,7 @@
> > >>  /* Get/set the capability bounding set (as per security/commoncap.c=
) */
> > >>  #define PR_CAPBSET_READ 23
> > >>  #define PR_CAPBSET_DROP 24
> > >> +#define PR_CAPBSET_DROP_MASK 83
> > >>
> > >>  /* Get/set the process' ability to use the timestamp counter instru=
ction */
> > >>  #define PR_GET_TSC 25
> > >> diff --git a/security/commoncap.c b/security/commoncap.c
> > >> index 3399535808fe..ae7ce50a8151 100644
> > >> --- a/security/commoncap.c
> > >> +++ b/security/commoncap.c
> > >> @@ -19,7 +19,14 @@
> > >>  #include <linux/hugetlb.h>
> > >>  #include <linux/mount.h>
> > >>  #include <linux/sched.h>
> > >> +#include <linux/cred.h>
> > >> +#include <linux/rcupdate.h>
> > >> +#include <linux/sched/signal.h>
> > >> +#include <linux/sched/task.h>
> > >> +#include <linux/slab.h>
> > >> +#include <linux/task_work.h>
> > >>  #include <linux/prctl.h>
> > >> +#include <linux/printk.h>
> > >>  #include <linux/securebits.h>
> > >>  #include <linux/user_namespace.h>
> > >>  #include <linux/binfmts.h>
> > >> @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long cap)
> > >>    return commit_creds(new);
> > >>  }
> > >>
> > >> +/*
> > >> + * Structure used to queue process-wide bounding set drops via task=
_work.
> > >> + */
> > >> +struct cap_bset_drop_work {
> > >> +  struct callback_head work;
> > >> +  struct task_struct *task;
> > >> +  kernel_cap_t mask;
> > >> +  struct cap_bset_drop_work *next;
> > >> +};
> > >> +
> > >> +static void cap_bset_drop_work_fn(struct callback_head *work)
> > >> +{
> > >> +  struct cap_bset_drop_work *w =3D container_of(work, struct cap_bs=
et_drop_work, work);
> > >> +  struct cred *new =3D prepare_creds();
> > >> +
> > >> +  if (!new) {
> > >> +          /* Out of memory: bounding set drop failed silently for t=
his thread. */
> > >> +          pr_warn_ratelimited("capability bounding set drop failed =
for pid %d (%s)\n",
> > >> +                              task_pid_nr(current), current->comm);
> > >> +          goto out;
> > >> +  }
> > >> +
> > >> +  new->cap_bset =3D cap_drop(new->cap_bset, w->mask);
> > >> +  commit_creds(new);
> > >> +
> > >> +out:
> > >> +  put_task_struct(w->task);
> > >> +  kfree(w);
> > >> +}
> > >> +
> > >> +/*
> > >> + * cap_bset_drop_process - Drop capabilities from all threads in th=
e group.
> > >> + * @mask: Mask of capabilities to drop from the bounding set.
> > >> + *
> > >> + * Drops @mask from the calling thread synchronously, and queues a =
task_work
> > >> + * item for each sibling thread to safely apply the drop in its own=
 context.
> > >> + *
> > >> + * The caller must hold CAP_SETPCAP. Thread group must be quiescent=
 to avoid
> > >> + * racing with concurrent thread creation.
> > >> + *
> > >> + * Returns 0 on success, or -ENOMEM if allocations fail (all-or-not=
hing).
> > >> + */
> > >> +static int cap_bset_drop_process(kernel_cap_t mask)
> > >> +{
> > >> +  struct cap_bset_drop_work *list =3D NULL, *w, *next;
> > >> +  struct task_struct *thread;
> > >> +  struct cred *new =3D NULL;
> > >> +  int ret =3D 0;
> > >> +
> > >> +  rcu_read_lock();
> > >> +  for_each_thread(current, thread) {
> > >> +          const struct cred *cred;
> > >> +
> > >> +          if (thread =3D=3D current || (thread->flags & PF_EXITING)=
)
> > >> +                  continue;
> > >> +
> > >> +          cred =3D __task_cred(thread);
> > >> +          if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
> > >> +                  continue;
> > >> +
> > >> +          w =3D kmalloc_obj(*w, GFP_ATOMIC);
> > >> +          if (!w) {
> > >> +                  ret =3D -ENOMEM;
> > >> +                  break;
> > >> +          }
> > >> +
> > >> +          w->task =3D get_task_struct(thread);
> > >> +          w->mask =3D mask;
> > >> +          w->next =3D list;
> > >> +          list =3D w;
> > >> +  }
> > >> +  rcu_read_unlock();
> > >> +
> > >> +  if (!ret) {
> > >> +          new =3D prepare_creds();
> > >> +          if (!new)
> > >> +                  ret =3D -ENOMEM;
> > >> +  }
> > >> +
> > >> +  if (ret) {
> > >> +          while (list) {
> > >> +                  next =3D list->next;
> > >> +                  put_task_struct(list->task);
> > >> +                  kfree(list);
> > >> +                  list =3D next;
> > >> +          }
> > >> +          return ret;
> > >> +  }
> > >> +
> > >> +  for (w =3D list; w; w =3D next) {
> > >> +          next =3D w->next;
> > >> +          init_task_work(&w->work, cap_bset_drop_work_fn);
> > >> +          if (task_work_add(w->task, &w->work, TWA_SIGNAL)) {
> > >> +                  put_task_struct(w->task);
> > >> +                  kfree(w);
> > >> +          }
> > >> +  }
> > >> +
> > >> +  new->cap_bset =3D cap_drop(new->cap_bset, mask);
> > >> +  commit_creds(new);
> > >> +
> > >> +  return 0;
> > >> +}
> > >> +
> > >> +static int cap_prctl_drop_mask(unsigned long low, unsigned long hig=
h)
> > >> +{
> > >> +  kernel_cap_t mask =3D mk_kernel_cap((u32)low, (u32)high);
> > >> +
> > >> +  if (cap_isclear(mask))
> > >> +          return 0;
> > >> +
> > >> +  if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> > >> +          return -EPERM;
> > >> +
> > >> +  return cap_bset_drop_process(mask);
> > >> +}
> > >> +
> > >>  /**
> > >>   * cap_task_prctl - Implement process control functions for this se=
curity module
> > >>   * @option: The process control function requested
> > >> @@ -1313,6 +1437,11 @@ int cap_task_prctl(int option, unsigned long =
arg2, unsigned long arg3,
> > >>    case PR_CAPBSET_DROP:
> > >>            return cap_prctl_drop(arg2);
> > >>
> > >> +  case PR_CAPBSET_DROP_MASK:
> > >> +          if (arg4 || arg5)
> > >> +                  return -EINVAL;
> > >> +          return cap_prctl_drop_mask(arg2, arg3);
> > >> +
> > >>    /*
> > >>     * The next four prctl's remain to assist with transitioning a
> > >>     * system from legacy UID=3D0 based privilege (when filesystem
> > >> --
> > >> 2.34.1
> >
> > --
> > Best regards,
> > Jinjie

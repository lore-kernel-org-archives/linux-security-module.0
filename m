Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E84361DC1
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129424; cv=none; b=KrMk9c+CONbysaRbFgN+ml/jZNtG9XuKChPZC5quysUjmhrZvUSNJ0hfsEthTQScmCmP+9WOzoVEBMRYzIRfl+8gXjXT0sZFelHT280moQAinapgu4UecvdfJCCqUT50+jAYmAdyAgXPBdjDe6uU94LP5iFZeRDfZAAtTo4jjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129424; c=relaxed/simple;
	bh=zJs4aOwwFsFj3SvXVZdymZBJN3AaTIjAOllr9jGKB68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBMgQZHvqADLKlikZT5IoiecU0I3MPSk/I9SO2uxtr+m2p2i2dFq3hTaM6M+Attce1WfrC8fdW90bo0srGoWGXa6tye92Dqs0TqFB3JCxjTP99Y5r7GtTRzgRgSLXPRzUiOSWSgKCzETwwJTS3/64SRYX8fdq9WKzKeY5gwr6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlyZwJPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlyZwJPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024791F00893
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129423;
	bh=us9YHg7JOnERKh2ln5timd0T5hyAAB/+9kI7oFnTjgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GlyZwJPlTj9Y3pYpFbkHd+sGykzWwN8EQSmzzkDo+cauesgQ3QuA7tMZJlgiaiD4t
	 50Gi35z7BxWsZQ6//b3TQXgU0OhiWpQWYv+eZJo2bsAtYccXpHH1Eq7ZhcP8NeEG1C
	 mwf6DL09/gEVNqN5sBBatb6JfH90zYWzooy5LXdZ0yIfQgMZQM/N/DARQAXYbMvbB7
	 1Ie6WGgNpNkBfw59kcAH2zhnkMY+tid1TN+gZxZi8Q+CeQ6JvPyMgz7FMgugvFBy/y
	 ajLyU6bP2it9Tjh1TnklPTM/LMe88bsrVo0QJ38W2GVHmhubqHGVAR1eqHxOTbj9eF
	 B6PRI2/FBIq6Q==
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso2102585ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 19:10:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxiMa+jUBM++uobs2FsZ3dbfTiOM09cje3NUadp32203TRK1PLAUL+rYj8rx+66e4PvNdPtMD9tVCO4QgnBc9sx4aUNWt4=@vger.kernel.org
X-Gm-Message-State: AFuF++lDJi82fcAaDxLqtY19AurNKj+zsC0w9IzLeIrzzNl73qHK5dIW
	HqMSqOJxIedxUBplggMqe0Hp2VD/0jJ+zpK04C8JsKKiQ5bGYRwJuThsArBFrylsb8mLYExjmgI
	ETayDY8xDICBGk/b6hzCWfG+q5lSPvfg=
X-Received: by 2002:a17:902:fd87:b0:2d8:d4d0:7930 with SMTP id
 d9443c01a7336-2df69d5fce6mr9835935ad.20.1790129422622; Tue, 22 Sep 2026
 19:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922095816.1191799-1-ruanjinjie@huawei.com> <arK0cT7CGb3Khy69@hallyn.com>
In-Reply-To: <arK0cT7CGb3Khy69@hallyn.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Tue, 22 Sep 2026 19:10:11 -0700
X-Gmail-Original-Message-ID: <CACmP8UK5wGZmBTRVBOm2_ZGhpFG-jWpihvUNxrcrgXr5K2GYEw@mail.gmail.com>
X-Gm-Features: AcwNN1VpEgyPIrdBvaQsAAnQZe78lZotlxrFRUR0fBTtf7p0b-lXKcbaPrcQ564
Message-ID: <CACmP8UK5wGZmBTRVBOm2_ZGhpFG-jWpihvUNxrcrgXr5K2GYEw@mail.gmail.com>
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
To: "Serge E. Hallyn" <serge@hallyn.com>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: paul@paul-moore.com, jmorris@namei.org, pjw@kernel.org, tglx@kernel.org, 
	peterz@infradead.org, debug@rivosinc.com, broonie@kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The https://pkg.go.dev/kernel.org/pub/linux/libs/security/libcap/cap#IAB.Se=
tProc
already handles this for the whole process. It can be run from main()
if you need it to happen early, and it will track down all of the
threads in the runtime.

To Serge's point, I am also curious what benefit there is from doing
it more quickly. After all, this is pretty much a one-time function
request for any executable.

FYI The "sendmail capabilities bug" reference is written up here:
https://sites.google.com/site/fullycapable/thesendmailcapabilitiesissue

Cheers

Andrew

On Tue, Sep 22, 2026 at 10:01=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
>
> On Tue, Sep 22, 2026 at 05:58:16PM +0800, Jinjie Ruan wrote:
> > The capability bounding set is per-thread: PR_CAPBSET_DROP only affects
> > the calling thread, since its bounding set lives in the per-task struct
> > cred.  User space that wants to drop capabilities for a whole process
> > must therefore invoke PR_CAPBSET_DROP once per capability per thread,
> > which on a many-threaded process is expensive, and from a Go runtime
> > requires stopping the world and signalling every thread.
> >
> > Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> > capabilities, given as a 64-bit mask in arg2 (low 32 bits) and arg3
> > (high 32 bits), from the bounding set of every thread of the calling
> > thread group in a single call.
> >
> > The calling thread drops the capabilities synchronously, last; every
> > sibling that still holds any of them is asked to drop them through a
> > task_work item, so that it applies the drop in its own context.  This
> > avoids racing with a sibling's concurrent credential updates such as
> > setuid() or capset().  The call does not wait for the siblings: a
> > sibling may be parked in a wait that is not woken by TIF_NOTIFY_SIGNAL
> > (e.g. futex), so waiting could block for an unbounded time.  This is
> > still safe, because TIF_NOTIFY_SIGNAL is handled on the way out to user
> > mode, so a sibling applies the drop before executing any further
> > userspace code.  It does not synchronize against a sibling that is
> > concurrently creating threads, so callers must keep the thread group
> > quiescent while dropping.
> >
> > Measured with gVisor's "bounding set trimmed" boot phase on an arm64 KV=
M
> > guest (medians over repeated boots):
> >   - 8 vCPUs:  ~1.6ms  -> ~0.10ms
> >   - 32 vCPUs: ~3.5ms  -> ~0.11ms
> >   - 64 vCPUs: ~10.1ms -> ~0.1-0.6ms
> >   - cost goes from O(capabilities * threads) stop-the-world prctls to a
> >     single thread-group walk.
>
> That is impressive, but please do detail the specific use case where
> you need to drop from the bounding set after the go scheduler has started=
.
> I can imagine some cases where you need to do some early setup and then
> want to drop privileges, but you could also do that by re-exec'ing, so
> I'd like to hear specifics.
>
> This makes me nervous, reminding me of the 'sendmail capabilities bug'.
> If some program specifically locks down one thread, I could imagine the
> locked down thread forcing wrong behavior from the privileged threads
> by calling this.
>
> >
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Paul Walmsley <pjw@kernel.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Zong Li <zong.li@sifive.com>
> > Cc: Deepak Gupta <debug@rivosinc.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  include/uapi/linux/prctl.h |   1 +
> >  security/commoncap.c       | 129 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 130 insertions(+)
> >
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index b6ec6f693719..750a7824d3bc 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -70,6 +70,7 @@
> >  /* Get/set the capability bounding set (as per security/commoncap.c) *=
/
> >  #define PR_CAPBSET_READ 23
> >  #define PR_CAPBSET_DROP 24
> > +#define PR_CAPBSET_DROP_MASK 83
> >
> >  /* Get/set the process' ability to use the timestamp counter instructi=
on */
> >  #define PR_GET_TSC 25
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 3399535808fe..ae7ce50a8151 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -19,7 +19,14 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/mount.h>
> >  #include <linux/sched.h>
> > +#include <linux/cred.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/sched/task.h>
> > +#include <linux/slab.h>
> > +#include <linux/task_work.h>
> >  #include <linux/prctl.h>
> > +#include <linux/printk.h>
> >  #include <linux/securebits.h>
> >  #include <linux/user_namespace.h>
> >  #include <linux/binfmts.h>
> > @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long cap)
> >       return commit_creds(new);
> >  }
> >
> > +/*
> > + * Structure used to queue process-wide bounding set drops via task_wo=
rk.
> > + */
> > +struct cap_bset_drop_work {
> > +     struct callback_head work;
> > +     struct task_struct *task;
> > +     kernel_cap_t mask;
> > +     struct cap_bset_drop_work *next;
> > +};
> > +
> > +static void cap_bset_drop_work_fn(struct callback_head *work)
> > +{
> > +     struct cap_bset_drop_work *w =3D container_of(work, struct cap_bs=
et_drop_work, work);
> > +     struct cred *new =3D prepare_creds();
> > +
> > +     if (!new) {
> > +             /* Out of memory: bounding set drop failed silently for t=
his thread. */
> > +             pr_warn_ratelimited("capability bounding set drop failed =
for pid %d (%s)\n",
> > +                                 task_pid_nr(current), current->comm);
> > +             goto out;
> > +     }
> > +
> > +     new->cap_bset =3D cap_drop(new->cap_bset, w->mask);
> > +     commit_creds(new);
> > +
> > +out:
> > +     put_task_struct(w->task);
> > +     kfree(w);
> > +}
> > +
> > +/*
> > + * cap_bset_drop_process - Drop capabilities from all threads in the g=
roup.
> > + * @mask: Mask of capabilities to drop from the bounding set.
> > + *
> > + * Drops @mask from the calling thread synchronously, and queues a tas=
k_work
> > + * item for each sibling thread to safely apply the drop in its own co=
ntext.
> > + *
> > + * The caller must hold CAP_SETPCAP. Thread group must be quiescent to=
 avoid
> > + * racing with concurrent thread creation.
> > + *
> > + * Returns 0 on success, or -ENOMEM if allocations fail (all-or-nothin=
g).
> > + */
> > +static int cap_bset_drop_process(kernel_cap_t mask)
> > +{
> > +     struct cap_bset_drop_work *list =3D NULL, *w, *next;
> > +     struct task_struct *thread;
> > +     struct cred *new =3D NULL;
> > +     int ret =3D 0;
> > +
> > +     rcu_read_lock();
> > +     for_each_thread(current, thread) {
> > +             const struct cred *cred;
> > +
> > +             if (thread =3D=3D current || (thread->flags & PF_EXITING)=
)
> > +                     continue;
> > +
> > +             cred =3D __task_cred(thread);
> > +             if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
> > +                     continue;
> > +
> > +             w =3D kmalloc_obj(*w, GFP_ATOMIC);
> > +             if (!w) {
> > +                     ret =3D -ENOMEM;
> > +                     break;
> > +             }
> > +
> > +             w->task =3D get_task_struct(thread);
> > +             w->mask =3D mask;
> > +             w->next =3D list;
> > +             list =3D w;
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     if (!ret) {
> > +             new =3D prepare_creds();
> > +             if (!new)
> > +                     ret =3D -ENOMEM;
> > +     }
> > +
> > +     if (ret) {
> > +             while (list) {
> > +                     next =3D list->next;
> > +                     put_task_struct(list->task);
> > +                     kfree(list);
> > +                     list =3D next;
> > +             }
> > +             return ret;
> > +     }
> > +
> > +     for (w =3D list; w; w =3D next) {
> > +             next =3D w->next;
> > +             init_task_work(&w->work, cap_bset_drop_work_fn);
> > +             if (task_work_add(w->task, &w->work, TWA_SIGNAL)) {
> > +                     put_task_struct(w->task);
> > +                     kfree(w);
> > +             }
> > +     }
> > +
> > +     new->cap_bset =3D cap_drop(new->cap_bset, mask);
> > +     commit_creds(new);
> > +
> > +     return 0;
> > +}
> > +
> > +static int cap_prctl_drop_mask(unsigned long low, unsigned long high)
> > +{
> > +     kernel_cap_t mask =3D mk_kernel_cap((u32)low, (u32)high);
> > +
> > +     if (cap_isclear(mask))
> > +             return 0;
> > +
> > +     if (!ns_capable(current_user_ns(), CAP_SETPCAP))
> > +             return -EPERM;
> > +
> > +     return cap_bset_drop_process(mask);
> > +}
> > +
> >  /**
> >   * cap_task_prctl - Implement process control functions for this secur=
ity module
> >   * @option: The process control function requested
> > @@ -1313,6 +1437,11 @@ int cap_task_prctl(int option, unsigned long arg=
2, unsigned long arg3,
> >       case PR_CAPBSET_DROP:
> >               return cap_prctl_drop(arg2);
> >
> > +     case PR_CAPBSET_DROP_MASK:
> > +             if (arg4 || arg5)
> > +                     return -EINVAL;
> > +             return cap_prctl_drop_mask(arg2, arg3);
> > +
> >       /*
> >        * The next four prctl's remain to assist with transitioning a
> >        * system from legacy UID=3D0 based privilege (when filesystem
> > --
> > 2.34.1

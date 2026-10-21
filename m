Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593776;
	b=j7X3QsLAqOGg7bJ/biMoPfmXEsEaVO11G+XzUjApKdhoK43F9TYyc/+uordKHENnJvsM
	 CgmwZISMRpa3R+768T/+dEQNWK1+azWOS+u68Vjb3ud5VxfEfz0akdmg+vj0LwRucobWn
	 7Tuk5t2svheJPTtW01H68j5ThQfjrgvbL8rVz968gS5RagShQY7cy2AQ0vHp3Xtx2iCTM
	 9EAi3RrZUqSBZLjuiPUFLVZKlb3XQTxpHdj20Sx/gpWuTKxsEyR3cOhss548s8zqMicRY
	 AfE2hSONuTWw95Qyt4+rqDBjIrgn6p9quZnHyGbctuEIMWFvbNGJzdMQojuX5dlYRjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593776;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=k5c8dJ2C9kocOc+QpEeRoxnt4qOwYqzibxX7LQBazUY=;
	b=Lb59UyiRo7bk/NJT4wVdii+GuOZTs7HlGiKo/kp+WFpsdOaBGLRbuggI0nV3u2N1s0AW
	 34czS0Fn4Smmlavv0poF5KBXLViy9JPY86MeiRHZkNBezl6l7F6NMGFbMKyZoWnnDZOdK
	 0dlSfPpSd5SPPQTQ7/oWIEUUQemaH+OUY1ft9Xkwwv5MNx2YcjPd+IVTBr69daSkoRuHH
	 jAgLdLZ+HW1RV6XI9Ccy3ZhdKhl2M24TNHV3lP8yD/ZGe+iU6EmaDE3p+ELDTGROviY0f
	 LKTuEYiySeWLdYK6FJRRU/DqPNdIxMsKzKtsdBBIs3jqP0etNy/ZhEEdQwwOUuLPlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyw3f3ez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C40606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyw3f3ez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D2B1F000C2
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792593775;
	bh=k5c8dJ2C9kocOc+QpEeRoxnt4qOwYqzibxX7LQBazUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jyw3f3ezwrlndH9Givay0JCwS7MLMtJHhej3yp/lIKXu5IdUP9x8rBI5Gffmomi0U
	 LvpyoE8OrrTUkbOZJMNDPqDHgTmbGvI361y/W+YSbWBL3QAwOBjU5w4JmCHC/JmHI0
	 8qFYhjJo6lib3afvIi13uVGJy3kE6soWtYng5T4fPNtho0VoDtihqPKyjuV4WRnhHZ
	 4OTz3UaJF5t37FYMPhzVizMlMCnxNuT16ZU7K8bsawxt7VBIjBeNfo4EWmgn3aY0s0
	 Sktk0p9AevN3JYu+3ySr8wTmv2OI/SgXcGTMQQXVccDUKSFJHZoggYxczhmWHkKAF3
	 kpBjk6ReRBgaw==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so1133901a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 07:42:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw/MAEb565CbtUsghTqHAb3EyjZH+60zy4l0ZeKvc76bC5CyRAsXHzDD2+AdjhC13uhigD+SJjb8tK6nM7vroHf8UJImCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwol4vu2QIAdM6TXltc9vGH/OqjWD0hS1pJCzmJbj0h4HH6x5G
	a+o5LK8mpScQpxwachXYZ2vyEa1yQVrewIXVbpOqUOCBI6pWKVR6cbE9eCjEvQwwKt7u+xwpmkL
	D7dkw55t2K+IZr8ff73hXPnDCqJIfekc=
X-Received: by 2002:a17:90b:54cb:b0:3a4:7195:ecba with SMTP id
 98e67ed59e1d1-3ad86eed516mr1070459a91.20.1792593774768; Wed, 21 Oct 2026
 07:42:54 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com> <atjN3JX7sWx9kpQ5@hallyn.com>
In-Reply-To: <atjN3JX7sWx9kpQ5@hallyn.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Wed, 21 Oct 2026 07:42:43 -0700
X-Gmail-Original-Message-ID: <CACmP8ULW+COA17s6_UUKhQrJaviWmnUCjfite43Y0FgPN30-AQ@mail.gmail.com>
X-Gm-Features: AclHuK8VpCzFoTf-puWToWEYcZE-hCU6pEvKbog_YpObEYZx-5WzGqZswN5CxgU
Message-ID: <CACmP8ULW+COA17s6_UUKhQrJaviWmnUCjfite43Y0FgPN30-AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Oleg Nesterov <oleg@redhat.com>, kees@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, paul@paul-moore.com, jmorris@namei.org, 
	shuah@kernel.org, brauner@kernel.org, alexjlzheng@tencent.com, 
	jannh@google.com, jaime.saguillo@gmail.com, elver@google.com, 
	blbllhy@gmail.com, bvanassche@acm.org, pjw@kernel.org, broonie@kernel.org, 
	debug@rivosinc.com, tglx@kernel.org, aleksey.oladko@virtuozzo.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are a number of situations where existing code wants to
(temporarily) affect the capabilities of a single thread, so a
subsequent fork() starts with those without affecting the parent
process as a whole. I've been wondering if this code could be
structured to allow an argument of the prctl() to indicate if the call
is "whole process" or "just this thread" scoped?

Cheers

Andrew

On Wed, Oct 21, 2026 at 7:36=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Tue, Sep 29, 2026 at 09:01:59PM +0800, Jinjie Ruan wrote:
> > PR_CAPBSET_DROP only affects the calling thread. Process-wide capabilit=
y
> > dropping requires user space to loop over every thread and every
> > capability, which is highly expensive. For instance, long-lived
> > multi-threaded processes (like gVisor's sentry) spend milliseconds
> > trimming the bounding set because the runtime has to coordinate
> > and signal every thread.
> >
> > Add PR_CAPBSET_DROP_MASK, an opt-in prctl that removes a set of
> > capabilities from the entire thread group's bounding set in a single ca=
ll.
> > The capabilities are specified via a 64-bit mask across arg2 (low 32 bi=
ts)
> > and arg3 (high 32 bits).
> >
> > The drop is recorded in a per-thread-group mask,
> > signal_struct::cap_bset_pending, under sighand->siglock. This pending d=
rop
> > is dynamically folded into the bounding set in critical paths:
> > cap_capset(), PR_CAPBSET_READ(), and cap_bprm_creds_from_file().
> > Running, concurrently created, or future threads within the group will
> > all immediately observe the drop. A forked child inherits this mask
> > in cap_bset_drop_fork() under siglock to close the race window
> > against clone().
> >
> > The operation is drop-only, so concurrent callers commute and a single
> > atomic OR is the linearization point.  It performs no per-thread alloca=
tion
> > and only the caller's replacement cred can fail, reported synchronously=
 as
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
> > @@ -318,7 +319,7 @@ static inline void task_cap(struct seq_file *m, str=
uct task_struct *p)
> >       cap_inheritable =3D cred->cap_inheritable;
> >       cap_permitted   =3D cred->cap_permitted;
> >       cap_effective   =3D cred->cap_effective;
> > -     cap_bset        =3D cred->cap_bset;
> > +     cap_bset        =3D cap_bset_effective(p, cred);
> >       cap_ambient     =3D cred->cap_ambient;
> >       rcu_read_unlock();
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
> > @@ -197,6 +198,10 @@ bool capable_wrt_inode_uidgid(struct mnt_idmap *id=
map,
> >                             const struct inode *inode, int cap);
> >  extern bool file_ns_capable(const struct file *file, struct user_names=
pace *ns, int cap);
> >  extern bool ptracer_capable(struct task_struct *tsk, struct user_names=
pace *ns);
> > +extern kernel_cap_t cap_bset_effective(const struct task_struct *task,
> > +                                    const struct cred *cred);
> > +extern void cap_bset_drop_fork(struct task_struct *p);
> > +
> >  static inline bool perfmon_capable(void)
> >  {
> >       return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.=
h
> > index d45a5476b97d..bda6f18b65b9 100644
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -98,6 +98,14 @@ struct signal_struct {
> >       int                     quick_threads;
> >       struct list_head        thread_head;
> >
> > +     /*
> > +      * Capabilities being removed from the bounding set of every thre=
ad in
> > +      * this group by PR_CAPBSET_DROP_MASK.  Read on capability-transi=
tion
> > +      * paths without sighand->siglock, hence atomic64 (a 64-bit value=
 would
> > +      * otherwise tear on 32-bit).
> > +      */
> > +     atomic64_t              cap_bset_pending;
> > +
> >       wait_queue_head_t       wait_chldexit;  /* for wait4() */
> >
> >       /* current thread group signal load-balancing target: */
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index b6ec6f693719..85ac71897070 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -70,6 +70,7 @@
> >  /* Get/set the capability bounding set (as per security/commoncap.c) *=
/
> >  #define PR_CAPBSET_READ 23
> >  #define PR_CAPBSET_DROP 24
> > +#define PR_CAPBSET_DROP_MASK 82
> >
> >  /* Get/set the process' ability to use the timestamp counter instructi=
on */
> >  #define PR_GET_TSC 25
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 5ef413368912..bf671a85d39d 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2504,6 +2504,7 @@ __latent_entropy struct task_struct *copy_process=
(
> >        * before holding sighand lock.
> >        */
> >       copy_seccomp(p);
> > +     cap_bset_drop_fork(p);
> >
> >       if (clone_flags & CLONE_NNP)
> >               task_set_no_new_privs(p);
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
> > + * A drop recorded by PR_CAPBSET_DROP_MASK is authoritative on the thr=
ead group
> > + * and may not have been materialized into every thread's cred yet, so=
 the
> > + * effective bounding set is the cred's own set minus the group's pend=
ing drop.
> > + */
> > +kernel_cap_t cap_bset_effective(const struct task_struct *task,
> > +                             const struct cred *cred)
> > +{
> > +     kernel_cap_t pending =3D {
> > +             .val =3D atomic64_read(&task->signal->cap_bset_pending),
> > +     };
> > +
> > +     return cap_drop(cred->cap_bset, pending);
> > +}
> > +
> >  /*
> >   * If a non-root user executes a setuid-root binary in
> >   * !secure(SECURE_NOROOT) mode, then we raise capabilities.
> > @@ -284,8 +305,8 @@ int cap_capset(struct cred *new,
> >
> >       if (!cap_issubset(*inheritable,
> >                         cap_combine(old->cap_inheritable,
> > -                                   old->cap_bset)))
> >               /* no new pI capabilities outside bounding set */
> > +                                   cap_bset_effective(current, old))))
> >               return -EPERM;
> >
> >       /* verify restrictions on target's new Permitted set */
> > @@ -849,7 +870,7 @@ static void handle_privileged_root(struct linux_bin=
prm *bprm, bool has_fcap,
> >        */
> >       if (__is_eff(root_uid, new) || __is_real(root_uid, new)) {
> >               /* pP' =3D (cap_bset & ~0) | (pI & ~0) */
> > -             new->cap_permitted =3D cap_combine(old->cap_bset,
> > +             new->cap_permitted =3D cap_combine(new->cap_bset,
> >                                                old->cap_inheritable);
> >       }
> >       /*
> > @@ -925,6 +946,8 @@ int cap_bprm_creds_from_file(struct linux_binprm *b=
prm, const struct file *file)
> >       int ret;
> >       kuid_t root_uid;
> >
> > +     new->cap_bset =3D cap_bset_effective(current, new);
> > +
> >       if (WARN_ON(!cap_ambient_invariant_ok(old)))
> >               return -EPERM;
> >
> > @@ -1283,6 +1306,63 @@ static int cap_prctl_drop(unsigned long cap)
> >       return commit_creds(new);
> >  }
> >
> > +static int cap_bset_drop_process(kernel_cap_t mask)
> > +{
> > +     kernel_cap_t pending;
> > +     struct cred *new;
> > +
> > +     new =3D prepare_creds();
> > +     if (!new)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * Record the drop before committing the caller's cred, so that a
> > +      * thread created from now on is guaranteed to observe it.  Apply=
 the
> > +      * current union, not just this call's mask, to the caller's cred=
.
> > +      */
> > +     spin_lock_irq(&current->sighand->siglock);
> > +     atomic64_or(mask.val, &current->signal->cap_bset_pending);
> > +     pending.val =3D atomic64_read(&current->signal->cap_bset_pending)=
;
> > +     spin_unlock_irq(&current->sighand->siglock);
> > +
> > +     new->cap_bset =3D cap_drop(new->cap_bset, pending);
> > +     commit_creds(new);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Propagate a pending process-wide bounding-set drop to @p, a task be=
ing
> > + * created by the current thread.  Threads sharing the group read
> > + * current->signal->cap_bset_pending directly; a forked child gets its=
 own
> > + * signal_struct and must carry the mask itself.  Called under
> > + * current->sighand->siglock, which serializes it with cap_bset_drop_p=
rocess().
> > + */
> > +void cap_bset_drop_fork(struct task_struct *p)
> > +{
> > +     kernel_cap_t mask =3D {
> > +             .val =3D atomic64_read(&current->signal->cap_bset_pending=
),
> > +     };
> > +
> > +     if (cap_isclear(mask) || p->signal =3D=3D current->signal)
> > +             return;
> > +
> > +     atomic64_or(mask.val, &p->signal->cap_bset_pending);
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
> > @@ -1308,11 +1388,16 @@ int cap_task_prctl(int option, unsigned long ar=
g2, unsigned long arg3,
> >       case PR_CAPBSET_READ:
> >               if (!cap_valid(arg2))
> >                       return -EINVAL;
> > -             return !!cap_raised(old->cap_bset, arg2);
> > +             return !!cap_raised(cap_bset_effective(current, old), arg=
2);
> >
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

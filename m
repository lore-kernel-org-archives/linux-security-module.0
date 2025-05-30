Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECE383A5
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610987; cv=none; b=i6i6wXCKArqR/ejmtMr5n7EgIYzN7rMmlKIhUhQCLIkvcStr9HP97/xALUW4+fgihnRRDKoEZiHkobuylvlW3U//rWOV0F811Fb11OrYuTrMRpNBib6wnblSFF6Xp3VWosZBEEir3Iizg9fXDkga5MdAUrP/N0mErtH0RXlYztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610987; c=relaxed/simple;
	bh=5KOMNpLu2WpVFkd00aYSN3RLJsSiZizQlOdLJbRz9xE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qedD37s2ZovXv5z8APtIdI8TOsq+dwQETgxJAPnJTP8Nw8C8Lbh5RLFeUf9TL2mFH5gEjqknUF1EYxeJymWQzsoWYJYRQrLsineAjbk5COgprrwld34qm5cZWlGOKStim5h3LiDoif6LtrtEv5OQT4TH/baMcc0yX2lHU5AEkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NL32GYhq; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NL32GYhq"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6045ff287cfso2750778a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748610983; x=1749215783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOjMzms7pPSKfR3QpxPX6uvlXEzx6nYbruXkhIiBjcc=;
        b=NL32GYhqXEAHvLXMvaYtzeCbW2ggn/57odSAbIgU8aJ8odYKc5oR5SskVvqNZv/LeN
         woDSrFpGXlOjH/ZgT6pKZkkZhhaqhkAGx8V/t9FaNADyyA+LFfhyoc/WAqfZdw/0bmh2
         S8QaKJCo4r6miYOreK2fLfyi2TfPGuxV8QakOcqeUgyJG77tLHRkXCBv41YfmFOqpgc+
         I9PXvQqIybiX0fllQCqWQX8vugpfdsumKEBS8mvV0GgLwUiwf4oqCBKEoby+Vz7YXbff
         KD3J6Ndsu45TPs79/QeA9Z6deEfxRPIoSrcd8I9NfHyZD9OXYjlFlvrryq0A/+ixz6jL
         6djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748610984; x=1749215784;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IOjMzms7pPSKfR3QpxPX6uvlXEzx6nYbruXkhIiBjcc=;
        b=KXQnFQwXf604SyUEfWRKz7Y0fvvnjYSdFP9slWEd0pXK06pWjTjPJIy9CX7NXzYKff
         Q8gxB0bu3SMMhYmUBuuDCUR6ZL/1cwDjvynJkerutIwdjX3acO/DeaCm+NtIvEBbdvIk
         55rpWrEkBn1xKlW+ZS88QMed4dngopWYaCYZuFJ5Aoymq0vJgef0mC3qCdFI66vG+mvC
         7kbVQypFbhpFBlqjYh5rpsNq78iNzaKhHd54q/RBPDksYTcO8CCXNq4Dz+jW0Qlyw/AD
         NQLfZTVQ3p/CpAFQFe1qSeSX2T8POVH9HvGy+c4qkbvWrsC7bt5bJ/b/2G47Y69KAxhB
         Yz9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbdocTomu6xo3BIFCVhc2R1Cjqb+F1GXVJQe3Wc0mLkdgvxomkXRDUi+NGU9uYP6mApIyH5lBIywI5KXpkltmB/tm+Khs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywN2CFyT7l5i+dmgc/mWyjaOCHHUCJOBS/xuoI+cNnVoBle/U
	PKhZAQogTiJUZoqrjyX11NVqiPtyxDBizA2BBGO3MIeWxXSzRQBE2A5WQwq9y0mESluT73pTdQ7
	2SGnBdg==
X-Google-Smtp-Source: AGHT+IHj8ynbQPQxdrs2D9yFZEID0TqTbe9/3NBy7GO/WduE0quN9mRt47isPnPUzxmpjm4+WhNcwQPv9p8=
X-Received: from edqp17.prod.google.com ([2002:aa7:d311:0:b0:5f6:252a:1d7e])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4316:b0:5f7:2852:2010
 with SMTP id 4fb4d7f45d1cf-6056f80bff2mr2570008a12.13.1748610983613; Fri, 30
 May 2025 06:16:23 -0700 (PDT)
Date: Fri, 30 May 2025 15:16:20 +0200
In-Reply-To: <20250518.xeevoom3kieY@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221184417.27954-2-gnoack3000@gmail.com> <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net> <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net> <20250310.990b29c809af@gnoack.org>
 <20250311.aefai7vo6huW@digikod.net> <20250518.be040c48937c@gnoack.org> <20250518.xeevoom3kieY@digikod.net>
Message-ID: <aDmvpOMlaAZOXrji@google.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for landlock_restrict_self()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>, Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, 
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, Peter Newman <peternewman@google.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 09:57:32PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sun, May 18, 2025 at 09:40:05AM +0200, G=C3=BCnther Noack wrote:
> > On Tue, Mar 11, 2025 at 03:32:53PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Mon, Mar 10, 2025 at 02:04:23PM +0100, G=C3=BCnther Noack wrote:

> > > > Approach 1: Use the creds API thread-by-thread (implemented here)
> > > >=20
> > > >   * Each task calls prepare_creds() and commit_creds() on its own, =
in
> > > >     line with the way the API is designed to be used (from a single
> > > >     task).
> > > >   * Task work gets scheduled with a pseudo-signal and the task that
> > > >     invoked the syscall is waiting for all of them to return.
> > > >   * Task work can fail at the beginning due to prepare_creds(), in
> > > >     which case all tasks have to abort_creds(). Additional
> > > >     synchronization is needed for that.
> > > >=20
> > > >   Drawback: We need to grab the system-global task lock to prevent =
new
> > > >   thread creation and also grab the per-process signal lock to prev=
ent
> > > >   races with other creds accesses, for the entire time as we wait f=
or
> > > >   each task to do the task work.
> > >=20
> > > In other words, this approach blocks all threads from the same proces=
s.
> >=20
> > It does, but that is still an improvement over the current
> > libpsx-based implementation in userspace.  That existing
> > implementation does not block, but it is running the risk that
> > prepare_creds() might fail on one of the threads (e.g. allocation
> > failure), which would leave the processes' threads in an inconsistent
> > state.
> >=20
> > Another upside that the in-kernel implementation has is that the
> > implementation of that is hidden behind an API, so if we can
> > eventually find a better approach, we can migrate to it.  It gives us
> > flexibility.
>=20
> > I guess a possible variant (approach 1B) would be to do the equivalent
> > to what userspace does today, and not make all threads wait for the
> > possible error of prepare_creds() on the other threads.
>=20
> This 1B variant is not OK because it would remove the guarantee that the
> whole process is restricted.

=F0=9F=91=8D Agreed.


> > > > Approach 2: Attempt to do the prepare_creds() step in the calling t=
ask.
> > > >=20
> > > >   * Would use an API similar to what keyctl uses for the
> > > >     parent-process update.
> > > >   * This side-steps the credentials update API as it is documented =
in
> > > >     Documentation, using the cred_alloc_blank() helper and replicat=
ing
> > > >     some prepare_creds() logic.
> > > >=20
> > > >   Drawback: This would introduce another use of the cred_alloc_blan=
k()
> > > >   API (and the cred_transfer LSM hook), which would otherwise be
> > > >   reasonable to delete if we can remove the keyctl use case.
> > > >   (https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a=
2aa1d45e6b8@google.com/)
> > >=20
> > > cred_alloc_blank() was designed to avoid dealing with -ENOMEM, which =
is
> > > a required property for this Landlock TSYNC feature (i.e. atomic and
> > > consistent synchronization).
> >=20
> > Remark on the side, I suspect that the error handling in nptl(7)
> > probably also does not guarantee that, also for setuid(2) and friends.
> >=20
> >=20
> > > I think it would make sense to replace most of the
> > > key_change_session_keyring() code with a new cred_transfer() helper t=
hat
> > > will memcpy the old cred to the new, increment the appropriate ref
> > > counters, and call security_transfer_creds().  We could then use this
> > > helper in Landlock too.
> > >=20
> > > To properly handle race conditions with a thread changing its own
> > > credentials, we would need a new LSM hook called by commit_creds().
> > > For the Landlock implementation, this hook would check if the process=
 is
> > > being Landlocked+TSYNC and return -ERESTARTNOINTR if it is the case.
> > > The newly created task_work would then be free to update each thread'=
s
> > > credentials while only blocking the calling thread (which is also a
> > > required feature).
> > >=20
> > > Alternatively, instead of a new LSM hook, commit_creds() could check
> > > itself a new group leader's flag set if all the credentials from the
> > > calling process are being updated, and return -ERESTARTNOINTR in this
> > > case.
> >=20
> > commit_creds() is explicitly documented to never return errors.
> > It returns a 0 integer so that it lends itself for tail calls,
> > and some of those usages might also rely on it always working.
> > There are ~15 existing calls where the return value is discarded.
>=20
> Indeed, commit_creds() should always return 0.  My full proposal does
> not look safe enough, but the cred_transfer() helper can still be
> useful.
>=20
> >=20
> > If commit_creds() returns -ERESTARTNOINTR, I assume that your idea is
> > that the task_work would retry the prepare-and-commit when
> > encountering that?
> >=20
> > We would have to store the fact that the process is being
> > Landlock+TSYNC'd in a central place (e.g. group leader flag set).
> > When that is done, don't we need more synchronization mechanisms to
> > access that (which RCU was meant to avoid)?
> >=20
> > I am having a hard time wrapping my head around these synchronization
> > schemes, I feel this is getting too complicated for what it is trying
> > to do and might become difficult to maintain if we implemented it.
>=20
> Fair. ERESTARTNOINTR should only be used by a syscall implementation.
>=20
> >=20
> > > > Approach 3: Store Landlock domains outside of credentials altogethe=
r
> > > >=20
> > > >   * We could also store a task's Landlock domain as a pointer in th=
e
> > > >     per-task security blob, and refcount these.  We would need to m=
ake
> > > >     sure that they get newly referenced and updated in the same
> > > >     scenarios as they do within struct cred today.
> > > >   * We could then guard accesses to a task's Landlock domain with a
> > > >     more classic locking mechanism.  This would make it possible to
> > > >     update the Landlock domain of all tasks in a process without
> > > >     having to go through pseudo-signals.
> > > >=20
> > > >   Drawbacks:
> > > >   * Would have to make sure that the Landlock domain the task's LSM
> > > >     blob behaves exactly the same as before in the struct cred.
> > > >   * Potentially slower to access Landlock domains that are guarded =
by
> > > >     a mutex.
> > >=20
> > > This would not work because the kernel (including LSM hooks) uses
> > > credentials to check access.
> >=20
> > It's unclear to me what you mean by that.
> >=20
> > Do you mean that it is hard to replicate for Landlock the cases where
> > the pointer would have to be copied, because the LSM hooks are not
> > suited for it?
>=20
> struct cred is used to check if a task subject can access a task object.
> Landlock's metadata must stay in struct cred to be available when
> checking access to any kernel object.  The LSM hooks reflect this
> rationale by only passing struct cred when checking a task (e.g.
> security_task_kill()'s cred).
>=20
> seccomp only cares about filtering raw syscalls, and the seccomp filters
> are just ignored when the kernel (with an LSM or not) checks task's
> permission to access another task.
>=20
> The per-task security blob could store some state though, e.g. to
> identify if a domain needs to be updated, but I don't see a use case
> here.

(Side remark on the idea of storing "pending domain updates" in the task bl=
ob:

I have pondered such an idea as well, where we do not store the Landlock do=
main
itself in the task blob, but only a "pending" update that we need to do to =
the
Landlock domain in creds, and then to apply that opportunistically/lazily a=
s
part of other Landlock LSM calls.

I believe in this approach, it becomes hard to control whether that update =
can
actually ever get applied.  So to be sure, we would always have to run unde=
r the
assumption that it does not get applied, and then we might as well store th=
e
Landlock domain directly in the task blob.

I also don't think this makes sense.)


> > Here is another possible approach which a colleague suggested in a
> > discussion:
> >=20
> > Approach 4: Freeze-and re-enforce the Landlock ruleset
> >=20
> > Another option would be to have a different user space API for this,
> > with a flag LANDLOCK_RESTRICT_SELF_ENTER (name TBD) to enter a given
> > domain.
> >=20
> > On first usage of landlock_restrict_self() with the flag, the enforced
> > ruleset would be frozen and linked to the Landlock domain which was
> > enforced at the end.
> >=20
> > Subsequent attempts to add rules to the ruleset would fail when the
> > ruleset is frozen.  The ruleset FD is now representing the created
> > domain including all its nesting.
> >=20
> > Subsequent usages of landlock_restrict_self() on a frozen ruleset would=
:
> >=20
> > (a) check that the ruleset's domain is a narrower (nested) domain of
> >     the current thread's domain (so that we retain the property of
> >     only locking in a task further than it was before).
> >=20
> > (b) set the task's domain to the domain attached to the ruleset
> >=20
> > This way, we would keep a per-thread userspace API, avoiding the
> > issues discussed before.  It would become possible to use ruleset file
> > descriptors as handles for entering Landlock domains and pass them
> > around between processes.
> >=20
> > The only drawback I can see is that it has the same issues as libpsx
> > and nptl(7) in that the syscall can fail on individual threads due to
> > ENOMEM.
>=20
> Right. This approach is interesting, but it does not solve the main
> issue here.

It doesn't?

In my mind, the main goal of the patch set is that we can enable Landlock i=
n
multithreaded processes like in Go programs or in multithreaded C(++).

With Approach 4, we would admittedly still have to do some work in userspac=
e,
and it would not have the nice all-or-nothing semantics, but at least, it w=
ould
be possible to get all threads joining the same Landlock domain.  (And afte=
r
all, setuid(0) also does not have the all-or-nothing semantics, from what I=
 can
tell.)


> Anyway, being able to enter a Landlock domain would definitely be
> useful. I would prefer using a pidfd to refer to a task's Landlock
> domain, which would avoid race condition and make the API clearer.  It
> would be nice to be able to pass a pidfd (instead of a ruleset) to
> landlock_restrict_self().  If we want to directly deal with a domain, we
> should create a dedicated domain FD type.

Fair enough, a different FD type for that would also be possible.


> > If we can not find a solution for "TSYNC", it seems that this might be
> > a viable alternative.  For multithreaded applications enforcing a
> > Landlock policy, it would become an application of libpsx with the
> > LANDLOCK_RESTRICT_SELF_ENTER flag.
> >=20
> > Let me know what you think.
> >=20
> > =E2=80=93G=C3=BCnther
>=20
> Thinking more about this feature, it might actually make sense to
> synchronize all threads from the same process without checking other
> threads' Landlock domain. The rationale are:
> 1. Linux threads are not security boundaries and it is allowed for a
>    thread to control other threads' memory, which means changing their
>    code flow.  In other words, thread's permissions are the union of all
>    thread's permissions in the same process.
> 2. libpsx and libc's set*id() ignore other thread's credentials and just
>    blindly execute the same code on all threads.
> 3. It would be simpler and would avoid another error case.

+1, agreed.  That would let us skip the check for the pre-existing domain o=
n
these threads.


> An issue could happen if a Landlock domain restricting a test thread is
> replaced.

You mean for Landlock's selftests?  I thought these were running in their o=
wn
forked-off subprocess?  I'm probably misunderstanding you here. :)


> I don't think the benefit of avoiding this issue is worth it
> compared to the guarantee we get when forcing the sandboxing of a full
> process without error.
>=20



> We should rename the flag to LANDLOCK_RESTRICT_SELF_PROCESS to make it
> clear what it does.
>=20
> The remaining issues are still the potential memory allocation failures.
> There are two things:
>=20
> 1. We should try as much as possible to limit useless credential
>    duplications by not creating a new struct cred if parent credentials
>    are the same.
>=20
> 2. To avoid the libpsx inconsistency (because of ENOMEM or EPERM),
>    landlock_restrict_self(2) should handle memory allocation and
>    transition the process from a known state to another known state.
>=20
> What about this approach:
> - "Freeze" all threads of the current process (not ideal but simple) to
>   make sure their credentials don't get updated.
> - Create a new blank credential for the calling thread.
> - Walk through all threads and create a new blank credential for all
>   threads with a different cred than the caller.
> - Inject a task work that will call cred_transfer() for all threads with
>   either the same new credential used by the caller (incrementing the
>   refcount), or it will populate and use a blank one if it has different
>   credentials than the caller.
>=20
> This may not efficiently deduplicate credentials for all threads but it
> is a simple deduplication approach that should be useful in most cases.
>=20
> The difficult part is mainly in the "fleezing". It would be nice to
> change the cred API to avoid that but I'm not sure how.

I don't see an option how we could freeze the credentials of other threads:

To freeze a task's credentials, we would have to inhibit that commit_creds(=
)
succeeds on that task, and I don't see how that would be done - we can not
prevent these tasks from calling commit_creds() [1], and when commit_creds(=
)
gets called, it is guaranteed to work.

So in my mind, we have to somehow deal with the possibility that a task has=
 a
new and not-previously-seen struct creds, by the time that its task_work ge=
ts
called.  As a consequence, I think a call to prepare_creds() would then be
unavoidable in the task_work?


=E2=80=94G=C3=BCnther


[1] We might be able to keep cred_prepare() and maybe cred_alloc_blank() fr=
om
    succeeding, but that does not mean that no one can call commit_creds() =
-
    there is still the possibility that commit_creds() gets called with a s=
truct
    cred* that was acquired before decided to freeze.


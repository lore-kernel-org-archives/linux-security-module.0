Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC42DCBE6
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618243; cv=none; b=Y62+D0JAKSvZQVb2CPIvN8ElWZV0dKTadDP15npoCHgp1XZ9OV3bP6yhlvIZ2xrXSzy5QIaO4ILQjIj7b1EUC+dMzwSDKqGIkJxZ7g/FimsDOnVeWeN/FQn093bb8oPMPcSdwd+wTpcnGYEO3N/L2ktPpGfbeLGeFJq7zoxy2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618243; c=relaxed/simple;
	bh=nUdSn3ZsgeCsHwjSCtIkAjeI0nisYP2JR9TLh72MQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibD4G2Ttdk0Vwq2nWmR523csCVQNsk+rvMUKts3pBYOdv/pOlMIaEW4tUvxoJZO/LU6BIY01uKx9AP1HQlB4a7dqCc+8+5tJECMwY2AvEbzIZJ8CE4GVDwmQEw4MAWiYaVIRUeehuuLIvePZBwvVszcPRyHn/L8fPv7bp3yVps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dwFk8XdH; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dwFk8XdH"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b86CD1NzZzRG3;
	Fri, 30 May 2025 17:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748617896;
	bh=pzD6RCmiXHRA+M3edlAXDavUVhBBosYzrV+HogsV9TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwFk8XdHXdFGmbYmHmGtQb9c3BL9Ls8RIKNRKbD21RYJaV0BJa6+26nzcBBiX8LYV
	 jfmmBxUs+to3mm/VsTUpLN262UnFhXFBedKcqj4SKHBuyOFH0s/XBOH6cl7n0/IkL6
	 P3mm29GiDmFMxC6KO89GolUgbppmEIYXDr9X4Vlc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b86CC2tXpzKC2;
	Fri, 30 May 2025 17:11:35 +0200 (CEST)
Date: Fri, 30 May 2025 17:11:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, David Howells <dhowells@redhat.com>, 
	Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250530.ozeuZufee5yu@digikod.net>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org>
 <20250311.aefai7vo6huW@digikod.net>
 <20250518.be040c48937c@gnoack.org>
 <20250518.xeevoom3kieY@digikod.net>
 <aDmvpOMlaAZOXrji@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDmvpOMlaAZOXrji@google.com>
X-Infomaniak-Routing: alpha

On Fri, May 30, 2025 at 03:16:20PM +0200, Günther Noack wrote:
> On Sun, May 18, 2025 at 09:57:32PM +0200, Mickaël Salaün wrote:
> > On Sun, May 18, 2025 at 09:40:05AM +0200, Günther Noack wrote:
> > > On Tue, Mar 11, 2025 at 03:32:53PM +0100, Mickaël Salaün wrote:
> > > > On Mon, Mar 10, 2025 at 02:04:23PM +0100, Günther Noack wrote:
> 
> > > > > Approach 1: Use the creds API thread-by-thread (implemented here)
> > > > > 
> > > > >   * Each task calls prepare_creds() and commit_creds() on its own, in
> > > > >     line with the way the API is designed to be used (from a single
> > > > >     task).
> > > > >   * Task work gets scheduled with a pseudo-signal and the task that
> > > > >     invoked the syscall is waiting for all of them to return.
> > > > >   * Task work can fail at the beginning due to prepare_creds(), in
> > > > >     which case all tasks have to abort_creds(). Additional
> > > > >     synchronization is needed for that.
> > > > > 
> > > > >   Drawback: We need to grab the system-global task lock to prevent new
> > > > >   thread creation and also grab the per-process signal lock to prevent
> > > > >   races with other creds accesses, for the entire time as we wait for
> > > > >   each task to do the task work.
> > > > 
> > > > In other words, this approach blocks all threads from the same process.
> > > 
> > > It does, but that is still an improvement over the current
> > > libpsx-based implementation in userspace.  That existing
> > > implementation does not block, but it is running the risk that
> > > prepare_creds() might fail on one of the threads (e.g. allocation
> > > failure), which would leave the processes' threads in an inconsistent
> > > state.
> > > 
> > > Another upside that the in-kernel implementation has is that the
> > > implementation of that is hidden behind an API, so if we can
> > > eventually find a better approach, we can migrate to it.  It gives us
> > > flexibility.
> > 
> > > I guess a possible variant (approach 1B) would be to do the equivalent
> > > to what userspace does today, and not make all threads wait for the
> > > possible error of prepare_creds() on the other threads.
> > 
> > This 1B variant is not OK because it would remove the guarantee that the
> > whole process is restricted.
> 
> 👍 Agreed.
> 
> 
> > > > > Approach 2: Attempt to do the prepare_creds() step in the calling task.
> > > > > 
> > > > >   * Would use an API similar to what keyctl uses for the
> > > > >     parent-process update.
> > > > >   * This side-steps the credentials update API as it is documented in
> > > > >     Documentation, using the cred_alloc_blank() helper and replicating
> > > > >     some prepare_creds() logic.
> > > > > 
> > > > >   Drawback: This would introduce another use of the cred_alloc_blank()
> > > > >   API (and the cred_transfer LSM hook), which would otherwise be
> > > > >   reasonable to delete if we can remove the keyctl use case.
> > > > >   (https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/)
> > > > 
> > > > cred_alloc_blank() was designed to avoid dealing with -ENOMEM, which is
> > > > a required property for this Landlock TSYNC feature (i.e. atomic and
> > > > consistent synchronization).
> > > 
> > > Remark on the side, I suspect that the error handling in nptl(7)
> > > probably also does not guarantee that, also for setuid(2) and friends.
> > > 
> > > 
> > > > I think it would make sense to replace most of the
> > > > key_change_session_keyring() code with a new cred_transfer() helper that
> > > > will memcpy the old cred to the new, increment the appropriate ref
> > > > counters, and call security_transfer_creds().  We could then use this
> > > > helper in Landlock too.
> > > > 
> > > > To properly handle race conditions with a thread changing its own
> > > > credentials, we would need a new LSM hook called by commit_creds().
> > > > For the Landlock implementation, this hook would check if the process is
> > > > being Landlocked+TSYNC and return -ERESTARTNOINTR if it is the case.
> > > > The newly created task_work would then be free to update each thread's
> > > > credentials while only blocking the calling thread (which is also a
> > > > required feature).
> > > > 
> > > > Alternatively, instead of a new LSM hook, commit_creds() could check
> > > > itself a new group leader's flag set if all the credentials from the
> > > > calling process are being updated, and return -ERESTARTNOINTR in this
> > > > case.
> > > 
> > > commit_creds() is explicitly documented to never return errors.
> > > It returns a 0 integer so that it lends itself for tail calls,
> > > and some of those usages might also rely on it always working.
> > > There are ~15 existing calls where the return value is discarded.
> > 
> > Indeed, commit_creds() should always return 0.  My full proposal does
> > not look safe enough, but the cred_transfer() helper can still be
> > useful.
> > 
> > > 
> > > If commit_creds() returns -ERESTARTNOINTR, I assume that your idea is
> > > that the task_work would retry the prepare-and-commit when
> > > encountering that?
> > > 
> > > We would have to store the fact that the process is being
> > > Landlock+TSYNC'd in a central place (e.g. group leader flag set).
> > > When that is done, don't we need more synchronization mechanisms to
> > > access that (which RCU was meant to avoid)?
> > > 
> > > I am having a hard time wrapping my head around these synchronization
> > > schemes, I feel this is getting too complicated for what it is trying
> > > to do and might become difficult to maintain if we implemented it.
> > 
> > Fair. ERESTARTNOINTR should only be used by a syscall implementation.
> > 
> > > 
> > > > > Approach 3: Store Landlock domains outside of credentials altogether
> > > > > 
> > > > >   * We could also store a task's Landlock domain as a pointer in the
> > > > >     per-task security blob, and refcount these.  We would need to make
> > > > >     sure that they get newly referenced and updated in the same
> > > > >     scenarios as they do within struct cred today.
> > > > >   * We could then guard accesses to a task's Landlock domain with a
> > > > >     more classic locking mechanism.  This would make it possible to
> > > > >     update the Landlock domain of all tasks in a process without
> > > > >     having to go through pseudo-signals.
> > > > > 
> > > > >   Drawbacks:
> > > > >   * Would have to make sure that the Landlock domain the task's LSM
> > > > >     blob behaves exactly the same as before in the struct cred.
> > > > >   * Potentially slower to access Landlock domains that are guarded by
> > > > >     a mutex.
> > > > 
> > > > This would not work because the kernel (including LSM hooks) uses
> > > > credentials to check access.
> > > 
> > > It's unclear to me what you mean by that.
> > > 
> > > Do you mean that it is hard to replicate for Landlock the cases where
> > > the pointer would have to be copied, because the LSM hooks are not
> > > suited for it?
> > 
> > struct cred is used to check if a task subject can access a task object.
> > Landlock's metadata must stay in struct cred to be available when
> > checking access to any kernel object.  The LSM hooks reflect this
> > rationale by only passing struct cred when checking a task (e.g.
> > security_task_kill()'s cred).
> > 
> > seccomp only cares about filtering raw syscalls, and the seccomp filters
> > are just ignored when the kernel (with an LSM or not) checks task's
> > permission to access another task.
> > 
> > The per-task security blob could store some state though, e.g. to
> > identify if a domain needs to be updated, but I don't see a use case
> > here.
> 
> (Side remark on the idea of storing "pending domain updates" in the task blob:
> 
> I have pondered such an idea as well, where we do not store the Landlock domain
> itself in the task blob, but only a "pending" update that we need to do to the
> Landlock domain in creds, and then to apply that opportunistically/lazily as
> part of other Landlock LSM calls.
> 
> I believe in this approach, it becomes hard to control whether that update can
> actually ever get applied.  So to be sure, we would always have to run under the
> assumption that it does not get applied, and then we might as well store the
> Landlock domain directly in the task blob.
> 
> I also don't think this makes sense.)
> 
> 
> > > Here is another possible approach which a colleague suggested in a
> > > discussion:
> > > 
> > > Approach 4: Freeze-and re-enforce the Landlock ruleset
> > > 
> > > Another option would be to have a different user space API for this,
> > > with a flag LANDLOCK_RESTRICT_SELF_ENTER (name TBD) to enter a given
> > > domain.
> > > 
> > > On first usage of landlock_restrict_self() with the flag, the enforced
> > > ruleset would be frozen and linked to the Landlock domain which was
> > > enforced at the end.
> > > 
> > > Subsequent attempts to add rules to the ruleset would fail when the
> > > ruleset is frozen.  The ruleset FD is now representing the created
> > > domain including all its nesting.
> > > 
> > > Subsequent usages of landlock_restrict_self() on a frozen ruleset would:
> > > 
> > > (a) check that the ruleset's domain is a narrower (nested) domain of
> > >     the current thread's domain (so that we retain the property of
> > >     only locking in a task further than it was before).
> > > 
> > > (b) set the task's domain to the domain attached to the ruleset
> > > 
> > > This way, we would keep a per-thread userspace API, avoiding the
> > > issues discussed before.  It would become possible to use ruleset file
> > > descriptors as handles for entering Landlock domains and pass them
> > > around between processes.
> > > 
> > > The only drawback I can see is that it has the same issues as libpsx
> > > and nptl(7) in that the syscall can fail on individual threads due to
> > > ENOMEM.
> > 
> > Right. This approach is interesting, but it does not solve the main
> > issue here.
> 
> It doesn't?
> 
> In my mind, the main goal of the patch set is that we can enable Landlock in
> multithreaded processes like in Go programs or in multithreaded C(++).

Yes, but it looks like replicating a user space hack in the kernel.

> 
> With Approach 4, we would admittedly still have to do some work in userspace,
> and it would not have the nice all-or-nothing semantics, but at least, it would
> be possible to get all threads joining the same Landlock domain.  (And after
> all, setuid(0) also does not have the all-or-nothing semantics, from what I can
> tell.)
> 
> 
> > Anyway, being able to enter a Landlock domain would definitely be
> > useful. I would prefer using a pidfd to refer to a task's Landlock
> > domain, which would avoid race condition and make the API clearer.  It
> > would be nice to be able to pass a pidfd (instead of a ruleset) to
> > landlock_restrict_self().  If we want to directly deal with a domain, we
> > should create a dedicated domain FD type.
> 
> Fair enough, a different FD type for that would also be possible.

For this use case, a pidfd would be appropriate to avoid
inconsistencies.

> 
> 
> > > If we can not find a solution for "TSYNC", it seems that this might be
> > > a viable alternative.  For multithreaded applications enforcing a
> > > Landlock policy, it would become an application of libpsx with the
> > > LANDLOCK_RESTRICT_SELF_ENTER flag.
> > > 
> > > Let me know what you think.
> > > 
> > > –Günther
> > 
> > Thinking more about this feature, it might actually make sense to
> > synchronize all threads from the same process without checking other
> > threads' Landlock domain. The rationale are:
> > 1. Linux threads are not security boundaries and it is allowed for a
> >    thread to control other threads' memory, which means changing their
> >    code flow.  In other words, thread's permissions are the union of all
> >    thread's permissions in the same process.
> > 2. libpsx and libc's set*id() ignore other thread's credentials and just
> >    blindly execute the same code on all threads.
> > 3. It would be simpler and would avoid another error case.
> 
> +1, agreed.  That would let us skip the check for the pre-existing domain on
> these threads.
> 
> 
> > An issue could happen if a Landlock domain restricting a test thread is
> > replaced.
> 
> You mean for Landlock's selftests?  I thought these were running in their own
> forked-off subprocess?  I'm probably misunderstanding you here. :)

I was thinking about potential (far fetched) issues that
LANDLOCK_RESTRICT_SELF_PROCESS could cause to existing code.  The main
use case to only enforce a Landlock domain on one thread would be for
test purpose, but this is indeed not the case for kselftest (except for
explit pthread tests).  So yeah, not a big deal but it should be
mentioned in the commit message and the doc that without
LANDLOCK_RESTRICT_SELF_PROCESS, threads can remove restrictions that are
only enforced on their siblings.

> 
> 
> > I don't think the benefit of avoiding this issue is worth it
> > compared to the guarantee we get when forcing the sandboxing of a full
> > process without error.
> > 
> 
> 
> 
> > We should rename the flag to LANDLOCK_RESTRICT_SELF_PROCESS to make it
> > clear what it does.
> > 
> > The remaining issues are still the potential memory allocation failures.
> > There are two things:
> > 
> > 1. We should try as much as possible to limit useless credential
> >    duplications by not creating a new struct cred if parent credentials
> >    are the same.
> > 
> > 2. To avoid the libpsx inconsistency (because of ENOMEM or EPERM),
> >    landlock_restrict_self(2) should handle memory allocation and
> >    transition the process from a known state to another known state.
> > 
> > What about this approach:
> > - "Freeze" all threads of the current process (not ideal but simple) to
> >   make sure their credentials don't get updated.
> > - Create a new blank credential for the calling thread.
> > - Walk through all threads and create a new blank credential for all
> >   threads with a different cred than the caller.
> > - Inject a task work that will call cred_transfer() for all threads with
> >   either the same new credential used by the caller (incrementing the
> >   refcount), or it will populate and use a blank one if it has different
> >   credentials than the caller.
> > 
> > This may not efficiently deduplicate credentials for all threads but it
> > is a simple deduplication approach that should be useful in most cases.
> > 
> > The difficult part is mainly in the "fleezing". It would be nice to
> > change the cred API to avoid that but I'm not sure how.
> 
> I don't see an option how we could freeze the credentials of other threads:
> 
> To freeze a task's credentials, we would have to inhibit that commit_creds()
> succeeds on that task, and I don't see how that would be done - we can not
> prevent these tasks from calling commit_creds() [1], and when commit_creds()
> gets called, it is guaranteed to work.
> 
> So in my mind, we have to somehow deal with the possibility that a task has a
> new and not-previously-seen struct creds, by the time that its task_work gets
> called.  As a consequence, I think a call to prepare_creds() would then be
> unavoidable in the task_work?

OK, we don't need to freeze all threads, just to block thread creation.

What about that:
1. lock thread creation for this process
2. call prepare_creds() for the calling thread (called new_cred)
3. call cred_alloc_blank() for all other threads, store them in a list,
   and exit if ENOMEM
4. asynchronously walk through all threads, and for each:
  a. if its creds are the same (i.e. same pointer) as the calling
     thread's ones, then call get_cred(new_cred) and
     commit_credsnew_cred().
  b. otherwise, take a blank cred, call cred_transfer(), add the
     Landlock domain, and commit_creds() with it.
5. free all unused blank creds (most)
6. call commit_creds(new_creds) and return

Pros:
- do not block threads
- minimize cred duplication
- atomic operation (from the point of view of the caller): all or
  nothing (with an error)
- almost no change to existing cred API

Cons:
- block thread creation
- initially allocate one cred per thread (but free most of them after)

> 
> 
> —Günther
> 
> 
> [1] We might be able to keep cred_prepare() and maybe cred_alloc_blank() from
>     succeeding, but that does not mean that no one can call commit_creds() -
>     there is still the possibility that commit_creds() gets called with a struct
>     cred* that was acquired before decided to freeze.
> 
> 

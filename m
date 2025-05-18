Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B64C8F
	for <linux-security-module@vger.kernel.org>; Sun, 18 May 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747598685; cv=none; b=ZMx66zv0MrnwY5u/Pf6ia19JqX5wv+vixaTZ8fcTyFYhQJWclBw6aTu+oZw26ORvcpnld38JrseAvsddYvAG+d96YMrC5/mZqbhOAP4TVcsjmsOrIFiLLTKhnfYInv6FRGDLpjZ3POvuq2rrbJ5Rj89KUxK0t2z2f4QrFDdW3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747598685; c=relaxed/simple;
	bh=ho1VNhehHgmcngBoWat50ncSfIel8Yp65A37rOp9nno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgdHzbuu8TLzRSjc9Q5xzrdxedVT+gSn9H92bjDqf13J4x77yyJ8Wzh1R/yOAoh0ua+UOk48HcD4ax2wGxsobLhAY5YMzTfNahtwYQpMqpwXM2xXS9B6lH2w62YMwiMqeDwHYeeKZt1vmy1kA/hBy3hHXUXkEN8epHdRhnIh4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DJUTQiAg; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DJUTQiAg"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b0s6k4XKlznQY;
	Sun, 18 May 2025 21:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747598254;
	bh=6a310mmqiABQv4xLsQnCavG9iMDgvOmMPKNv9TnDAoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJUTQiAgNuvy5aY5yl65btNt9qoJvyySGPq++MqMzEzQmARtUxgRFfBG53hOzuVCb
	 0R4N1Sr2rY/q+haEtTGP0W5SXgYhUFE+dZ0B0dikq6nzNTLHcOKrVyKqih8s8IawKj
	 8XgjJnDBRzvX2jG7NYgMqM8GB3DyPheSAmpB4iiQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b0s6j2NGgz2qm;
	Sun, 18 May 2025 21:57:33 +0200 (CEST)
Date: Sun, 18 May 2025 21:57:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, 
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250518.xeevoom3kieY@digikod.net>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org>
 <20250311.aefai7vo6huW@digikod.net>
 <20250518.be040c48937c@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250518.be040c48937c@gnoack.org>
X-Infomaniak-Routing: alpha

On Sun, May 18, 2025 at 09:40:05AM +0200, Günther Noack wrote:
> Hello!
> 
> On Tue, Mar 11, 2025 at 03:32:53PM +0100, Mickaël Salaün wrote:
> > On Mon, Mar 10, 2025 at 02:04:23PM +0100, Günther Noack wrote:
> > > On Tue, Mar 04, 2025 at 09:25:51PM +0100, Mickaël Salaün wrote:
> > > > On Fri, Feb 28, 2025 at 06:33:55PM +0100, Günther Noack wrote:
> > > > > Hello!
> > > > > 
> > > > > Thanks for the review!
> > > > > 
> > > > > I'm adding David Howells to this thread as well.  David, maybe you can
> > > > > help us and suggest a appropriate way to update the struct cred across
> > > > > multiple threads?
> > > 
> > > Paul and Serge, since you are volunteering to take ownership of
> > > credentials, maybe you can advise on what is the best approach here?
> > > 
> > > To summarize the approaches that I have been discussing with Mickaël:
> > > 
> > > Approach 1: Use the creds API thread-by-thread (implemented here)
> > > 
> > >   * Each task calls prepare_creds() and commit_creds() on its own, in
> > >     line with the way the API is designed to be used (from a single
> > >     task).
> > >   * Task work gets scheduled with a pseudo-signal and the task that
> > >     invoked the syscall is waiting for all of them to return.
> > >   * Task work can fail at the beginning due to prepare_creds(), in
> > >     which case all tasks have to abort_creds(). Additional
> > >     synchronization is needed for that.
> > > 
> > >   Drawback: We need to grab the system-global task lock to prevent new
> > >   thread creation and also grab the per-process signal lock to prevent
> > >   races with other creds accesses, for the entire time as we wait for
> > >   each task to do the task work.
> > 
> > In other words, this approach blocks all threads from the same process.
> 
> It does, but that is still an improvement over the current
> libpsx-based implementation in userspace.  That existing
> implementation does not block, but it is running the risk that
> prepare_creds() might fail on one of the threads (e.g. allocation
> failure), which would leave the processes' threads in an inconsistent
> state.
> 
> Another upside that the in-kernel implementation has is that the
> implementation of that is hidden behind an API, so if we can
> eventually find a better approach, we can migrate to it.  It gives us
> flexibility.



> 
> I guess a possible variant (approach 1B) would be to do the equivalent
> to what userspace does today, and not make all threads wait for the
> possible error of prepare_creds() on the other threads.

This 1B variant is not OK because it would remove the guarantee that the
whole process is restricted.

> 
> 
> > > Approach 2: Attempt to do the prepare_creds() step in the calling task.
> > > 
> > >   * Would use an API similar to what keyctl uses for the
> > >     parent-process update.
> > >   * This side-steps the credentials update API as it is documented in
> > >     Documentation, using the cred_alloc_blank() helper and replicating
> > >     some prepare_creds() logic.
> > > 
> > >   Drawback: This would introduce another use of the cred_alloc_blank()
> > >   API (and the cred_transfer LSM hook), which would otherwise be
> > >   reasonable to delete if we can remove the keyctl use case.
> > >   (https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/)
> > 
> > cred_alloc_blank() was designed to avoid dealing with -ENOMEM, which is
> > a required property for this Landlock TSYNC feature (i.e. atomic and
> > consistent synchronization).
> 
> Remark on the side, I suspect that the error handling in nptl(7)
> probably also does not guarantee that, also for setuid(2) and friends.
> 
> 
> > I think it would make sense to replace most of the
> > key_change_session_keyring() code with a new cred_transfer() helper that
> > will memcpy the old cred to the new, increment the appropriate ref
> > counters, and call security_transfer_creds().  We could then use this
> > helper in Landlock too.
> > 
> > To properly handle race conditions with a thread changing its own
> > credentials, we would need a new LSM hook called by commit_creds().
> > For the Landlock implementation, this hook would check if the process is
> > being Landlocked+TSYNC and return -ERESTARTNOINTR if it is the case.
> > The newly created task_work would then be free to update each thread's
> > credentials while only blocking the calling thread (which is also a
> > required feature).
> > 
> > Alternatively, instead of a new LSM hook, commit_creds() could check
> > itself a new group leader's flag set if all the credentials from the
> > calling process are being updated, and return -ERESTARTNOINTR in this
> > case.
> 
> commit_creds() is explicitly documented to never return errors.
> It returns a 0 integer so that it lends itself for tail calls,
> and some of those usages might also rely on it always working.
> There are ~15 existing calls where the return value is discarded.

Indeed, commit_creds() should always return 0.  My full proposal does
not look safe enough, but the cred_transfer() helper can still be
useful.

> 
> If commit_creds() returns -ERESTARTNOINTR, I assume that your idea is
> that the task_work would retry the prepare-and-commit when
> encountering that?
> 
> We would have to store the fact that the process is being
> Landlock+TSYNC'd in a central place (e.g. group leader flag set).
> When that is done, don't we need more synchronization mechanisms to
> access that (which RCU was meant to avoid)?
> 
> I am having a hard time wrapping my head around these synchronization
> schemes, I feel this is getting too complicated for what it is trying
> to do and might become difficult to maintain if we implemented it.

Fair. ERESTARTNOINTR should only be used by a syscall implementation.

> 
> > > Approach 3: Store Landlock domains outside of credentials altogether
> > > 
> > >   * We could also store a task's Landlock domain as a pointer in the
> > >     per-task security blob, and refcount these.  We would need to make
> > >     sure that they get newly referenced and updated in the same
> > >     scenarios as they do within struct cred today.
> > >   * We could then guard accesses to a task's Landlock domain with a
> > >     more classic locking mechanism.  This would make it possible to
> > >     update the Landlock domain of all tasks in a process without
> > >     having to go through pseudo-signals.
> > > 
> > >   Drawbacks:
> > >   * Would have to make sure that the Landlock domain the task's LSM
> > >     blob behaves exactly the same as before in the struct cred.
> > >   * Potentially slower to access Landlock domains that are guarded by
> > >     a mutex.
> > 
> > This would not work because the kernel (including LSM hooks) uses
> > credentials to check access.
> 
> It's unclear to me what you mean by that.
> 
> Do you mean that it is hard to replicate for Landlock the cases where
> the pointer would have to be copied, because the LSM hooks are not
> suited for it?

struct cred is used to check if a task subject can access a task object.
Landlock's metadata must stay in struct cred to be available when
checking access to any kernel object.  The LSM hooks reflect this
rationale by only passing struct cred when checking a task (e.g.
security_task_kill()'s cred).

seccomp only cares about filtering raw syscalls, and the seccomp filters
are just ignored when the kernel (with an LSM or not) checks task's
permission to access another task.

The per-task security blob could store some state though, e.g. to
identify if a domain needs to be updated, but I don't see a use case
here.

> 
> 
> Here is another possible approach which a colleague suggested in a
> discussion:
> 
> Approach 4: Freeze-and re-enforce the Landlock ruleset
> 
> Another option would be to have a different user space API for this,
> with a flag LANDLOCK_RESTRICT_SELF_ENTER (name TBD) to enter a given
> domain.
> 
> On first usage of landlock_restrict_self() with the flag, the enforced
> ruleset would be frozen and linked to the Landlock domain which was
> enforced at the end.
> 
> Subsequent attempts to add rules to the ruleset would fail when the
> ruleset is frozen.  The ruleset FD is now representing the created
> domain including all its nesting.
> 
> Subsequent usages of landlock_restrict_self() on a frozen ruleset would:
> 
> (a) check that the ruleset's domain is a narrower (nested) domain of
>     the current thread's domain (so that we retain the property of
>     only locking in a task further than it was before).
> 
> (b) set the task's domain to the domain attached to the ruleset
> 
> This way, we would keep a per-thread userspace API, avoiding the
> issues discussed before.  It would become possible to use ruleset file
> descriptors as handles for entering Landlock domains and pass them
> around between processes.
> 
> The only drawback I can see is that it has the same issues as libpsx
> and nptl(7) in that the syscall can fail on individual threads due to
> ENOMEM.

Right. This approach is interesting, but it does not solve the main
issue here.

Anyway, being able to enter a Landlock domain would definitely be
useful. I would prefer using a pidfd to refer to a task's Landlock
domain, which would avoid race condition and make the API clearer.  It
would be nice to be able to pass a pidfd (instead of a ruleset) to
landlock_restrict_self().  If we want to directly deal with a domain, we
should create a dedicated domain FD type.

> 
> If we can not find a solution for "TSYNC", it seems that this might be
> a viable alternative.  For multithreaded applications enforcing a
> Landlock policy, it would become an application of libpsx with the
> LANDLOCK_RESTRICT_SELF_ENTER flag.
> 
> Let me know what you think.
> 
> –Günther

Thinking more about this feature, it might actually make sense to
synchronize all threads from the same process without checking other
threads' Landlock domain. The rationale are:
1. Linux threads are not security boundaries and it is allowed for a
   thread to control other threads' memory, which means changing their
   code flow.  In other words, thread's permissions are the union of all
   thread's permissions in the same process.
2. libpsx and libc's set*id() ignore other thread's credentials and just
   blindly execute the same code on all threads.
3. It would be simpler and would avoid another error case.

An issue could happen if a Landlock domain restricting a test thread is
replaced.  I don't think the benefit of avoiding this issue is worth it
compared to the guarantee we get when forcing the sandboxing of a full
process without error.

We should rename the flag to LANDLOCK_RESTRICT_SELF_PROCESS to make it
clear what it does.

The remaining issues are still the potential memory allocation failures.
There are two things:

1. We should try as much as possible to limit useless credential
   duplications by not creating a new struct cred if parent credentials
   are the same.

2. To avoid the libpsx inconsistency (because of ENOMEM or EPERM),
   landlock_restrict_self(2) should handle memory allocation and
   transition the process from a known state to another known state.

What about this approach:
- "Freeze" all threads of the current process (not ideal but simple) to
  make sure their credentials don't get updated.
- Create a new blank credential for the calling thread.
- Walk through all threads and create a new blank credential for all
  threads with a different cred than the caller.
- Inject a task work that will call cred_transfer() for all threads with
  either the same new credential used by the caller (incrementing the
  refcount), or it will populate and use a blank one if it has different
  credentials than the caller.

This may not efficiently deduplicate credentials for all threads but it
is a simple deduplication approach that should be useful in most cases.

The difficult part is mainly in the "fleezing". It would be nice to
change the cred API to avoid that but I'm not sure how.

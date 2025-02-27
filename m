Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF61AF0C9
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689581; cv=none; b=B7dF3nEsaJaCmrBXOqJvQw6VIqTTJA6z7tniprdW3uaUbW305oO2cgdUpblthoO0+ygdTKois9P/MRUdKHSgJk0QKYa+lSpvZ+Yr4v5JTR/12auv7UdZ+HPtBK9Hj15JpypZP3V1Nw/gFR2qE1HnHDq9RxFoAu/foB9R890JBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689581; c=relaxed/simple;
	bh=PtP1bpBqeSFf381zyun/jOyP2jmFdNbL2J3mWsMRXV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loquZ3Q5Ni7YWx+1vjbDCzskcH6Wg8/fjRtxxgCBcoQjLKT21b+nWKpv0oB2toOKSRRKnh9lE810wWVrt3pGF283Jl6L0IkQ8vfVuUkmy9jikKBAs560DWTv6dbMf25m1tD+tZtjJNel78gMuPwxcYg+mXnYYiQDeoGNCtSdvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=n8na0CNb; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="n8na0CNb"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z3k7L6ByyzRyM;
	Thu, 27 Feb 2025 21:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740689566;
	bh=KS6xrFGgjYs9atlz8E4rvzvgxcNNoMOgGA57vst2enU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8na0CNbRP6ZGug1Xk5UE168/v2nWk1lN83gXXozKVRZodi72wNx8Lb/f3kOGTo8V
	 C9pB8DDRHspGOlMiYA5sdTRUKdAa0Tak4yi1cO7Cpjea5jYSrcwHm2TOkO6yINMiUk
	 Xh94IinQhUxn4Q36L/nOsnLicud158YhfMgnw/84=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z3k7K59nPzv48;
	Thu, 27 Feb 2025 21:52:45 +0100 (CET)
Date: Thu, 27 Feb 2025 21:52:44 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] landlock: Multithreaded policy enforcement
Message-ID: <20250227.iCaew6Uephie@digikod.net>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221184417.27954-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 21, 2025 at 07:44:16PM +0100, Günther Noack wrote:
> Hello!
> 
> This patch set adds the LANDLOCK_RESTRICT_SELF_TSYNC flag to
> landlock_restrict_self().  With this flag, the passed Landlock ruleset
> will not only be applied to the calling thread, but to all threads
> which belong to the same process.
> 
> I am sending this intentionally early.  At this point, I am mostly
> looking for high-level comments to check whether the general approach
> is feasible at all and whether I am using appropriate concurrency
> mechanisms for it.

Thanks Günther!  This feature is indeed very important to be able to
enforce consistent sandboxing.

> 
> Motivation
> ==========
> 
> TL;DR: The libpsx/nptl(7) signal hack which we use in user space for
> multi-threaded Landlock enforcement is incompatible with Landlock's
> signal scoping support.  Landlock can restrict the use of signals
> across Landlock domains, but we need signals ourselves in user space
> in ways that are not permitted any more under these restrictions.
> 
> Enabling Landlock proves to be difficult in processes that are already
> multi-threaded at the time of enforcement:
> 
> * Enforcement in only one thread is usually a mistake because threads
>   do not normally have proper security boundaries between them.
> 
> * Also, multithreading is unavoidable in some circumstances, such as
>   when using Landlock from a Go program.  Go programs are already
>   multithreaded by the time that they enter the "func main()".
> 
> So far, the approach in Go[1] was to use libpsx[2].  This library
> implements the mechanism described in nptl(7) [3]: It keeps track of
> all threads with a linker hack and then makes all threads do the same
> syscall by registering a signal handler for them and invoking it.
> 
> With commit 54a6e6bbf3be ("landlock: Add signal scoping"), Landlock
> gained the ability to restrict the use of signals across different
> Landlock domains.
> 
> Landlock's signal scoping support is incompatible with the libpsx
> approach of enabling Landlock:
> 
> (1) With libpsx, although all threads enforce the same ruleset object,
>     they technically do the operation separately and end up in
>     distinct Landlock domains.  When the ruleset uses
>     LANDLOCK_SCOPE_SIGNAL, it becomes impossible to use cross-thread
>     signals in that process.
> 
> (2) Cross-thread Signals are themselves needed to enforce further
>     nested Landlock domains across multiple threads.  So nested
>     Landlock policies become impossible there.
> 
> In addition to Landlock itself, cross-thread signals are also needed
> for other seemingly-harmless API calls like the setuid(2) [4] and for
> the use of libcap (co-developed with libpsx), which have the same
> problem where the underlying syscall only applies to the calling
> thread.
> 
> Implementation approach
> =======================
> 
> The implementation is inspired by Jann Horn's earlier patch set for
> cred_transfer() [5] as well as by the libpsx approach described in [2]
> and [3].  In some way, it is a libpsx-like implementation in the
> kernel:
> 
> When the flag is provided, the calling thread adds a task_work to all
> threads to be executed through a pseudo-signal and makes them run it.
> The logic is in the function restrict_one_thread().  The threads
> execute the following phases in lock step (with a barrier
> synchronization in between):
> 
> * Preparation Phase
>   * Check that the thread meets all prerequisites
>   * Create a new struct cred with prepare_creds()
>   * Manipulate the struct cred as needed for policy enforcement
>   * Write back possible errors to a shared memory location
> * BARRIER: Wait for all threads to catch up to this point
> * Commit Phase
>   * Check that none of the threads had an error.
>   * Invoke commit_creds() (or abort_creds() in case of error)
> 
> None of the functions used in the commit_phase() can return errors, so
> at the time where each thread decides to commit, we are already sure
> that it will work across all threads.
> 
> At the end, the calling thread waits for all task_work to finish
> before returning from the syscall.
> 
> (The calling thread itself obviously does not schedule a task_work for
> itself, but executes the same restrict_one_thread() logic inline.)
> 
> Open questions
> ==============
> 
> The patch set is in early stages, and there are some open questions
> for which I am seeking feedback:
> 
> Conceptual open questions
> ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * To what extent should we expect the threads to be in a known state?
> 
>   The single-threaded variant currently requires the
>   PR_SET_NO_NEW_PRIVS flag or CAP_SYS_ADMIN as prerequisite for
>   enforcing a Landlock ruleset.
> 
>   When we are in the multi-threaded variant, there are two main approaches:
> 
>   a) Expect same state on all threads: The simplest implementation
>      would be that we expect all threads to also have
>      PR_SET_NO_NEW_PRIVS or CAP_SYS_ADMIN, and to already be part of
>      the same Landlock domain.  Otherwise, the operation is aborted on
>      all threads.
>   
>   b) Pull all threads towards the same state: The 'synchronization'
>      option would be that we implicitly establish the same
>      PR_SET_NO_NEW_PRIVS and Landlock domain configuration on all
>      threads.
> 
>      Weird case: If the calling thread has CAP_SYS_ADMIN but not
>      PR_SET_NO_NEW_PRIVS, does this mean that a Landlock domain can be
>      enabled on a thread without PR_SET_NO_NEW_PRIVS?  (We surely
>      should not implicitly grant CAP_SYS_ADMIN to another thread?)

We should assume that there is not security boundaries between threads,
but we should also minimize inconsistent results.  So, no, we should not
grant any particular privileges/capabilites to other threads but only
drop them in a least surprising way for users.  See my proposal in reply
to the first patch.

>   
>   Solutions in the middle between these two might also be possible.
>   Depending on the approach, we might want to change the flag name to
>   say something else but ..._TSYNC. (That name is just carried over
>   from the similarly-named SECCOMP_FILTER_FLAG_TSYNC)

The issue with Landlock also exists with PR_SET_NO_NEW_PRIVS, so we need
to be able to synchronize both properties (as already possible with
seccomp).

> 
> Implementation open questions
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * Are there better synchronization mechanisms for this purpose than
>   task_work with barriers?

I think it's the right approach, but the difficult part is handling
errors in a safe and consistent way.

> 
> * Need to double check deadlock scenarios.
> 
> * Need to double check that we are not racing with a concurrent thread
>   creation.
> 
> * Use the multi-threaded code for the single-threaded variant as well?
> 
>   At the current stage, I left the single-threaded code intact and
>   copied some of its logic into the multi-threaded variant.  It is
>   technically possible to unify this, if we are OK with the single
>   threaded code using atomic operations and struct completion all by
>   itself (or by interleaving many if-checks, but not sure whether
>   that's worth it).

Most of the single-threaded code can be reused.

> 
> * Does landlock_restrict_self() need to be interruptible?
> 
>   (For reference, Jann's patch [5] used
>   wait_for_completion_interruptible())

We should follow seccomp's footsteps as much as possible.

> 
> 
> [1] https://github.com/landlock-lsm/go-landlock
> [2] https://sites.google.com/site/fullycapable/who-ordered-libpsx
> [3] https://man.gnoack.org/7/nptl
> [4] https://man.gnoack.org/2/setuid#VERSIONS
> [5] https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/
> 
> Günther Noack (2):
>   landlock: Multithreading support for landlock_restrict_self()
>   landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC
> 
>  include/uapi/linux/landlock.h                 |  10 +
>  security/landlock/syscalls.c                  | 232 +++++++++++++++++-
>  tools/testing/selftests/landlock/tsync_test.c |  94 +++++++
>  3 files changed, 331 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/landlock/tsync_test.c
> 
> 
> base-commit: 69e858e0b8b2ea07759e995aa383e8780d9d140c
> -- 
> 2.48.1
> 

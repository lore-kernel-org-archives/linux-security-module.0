Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB92308F3D
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317638; cv=none; b=P0k3xcpTLZnni0L9K281CKf1rUOW4k2w/gV7sP0z+VMxZn8VRWSdssRbhBWTX1uhjhzo65MC8on09pUUszPViVhez1wZufrsU1MTTEvaMUQdxLiMqaa/s440l0DLOJsF24+U7xPqo9YfVLRNacZ84T/BJR6c2eWmcMpe0FBBuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317638; c=relaxed/simple;
	bh=PCPy7nfBFM+ESfCwGiVCjVcnQkGbRDEFvcCsY0LBIKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKRJN2YTBcMIod0t72m6ImHj0rlp1cddHj+VKqKEj6xoo2SN55BU74sKUEhn45d/p6CpVK2zycUrxOnnfwlOoVIBty30f5KioN1M5Zh9AxLOj2IQn+xQ+bRP3DDbVXSii6K8v0AmQGozCtVbXvu5+pffOOrPpza+PDYmU8zxLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h3+9yxxs; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h3+9yxxs"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6RFl5PNtzwQp;
	Thu,  5 Feb 2026 19:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770317627;
	bh=Bzwm9AsJ+FYPgpbvINdbpAvR19ZuavRlhPjm6rJ88ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3+9yxxsWn/A04dwedzMyTnpRqJs9eUD0aZHVkaop60ismjoSoDu/1tnO0fxM8gae
	 sYxBfKyc1WuPWY/4Lzif9w+0iJva2fTbZRqDus+9ft0mYjcOmWuYfrgFCg/cy2h2EV
	 mPQVtNQuTcuWBk9douQKLwlaqn5DOLJeAS/vOoe8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6RFl0HNQzr6C;
	Thu,  5 Feb 2026 19:53:46 +0100 (CET)
Date: Thu, 5 Feb 2026 19:53:41 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Serge Hallyn <sergeh@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Tingmao Wang <m@maowtm.org>, Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v3 0/3] Landlock multithreaded enforcement
Message-ID: <20260205.phu7Bo2ieMih@digikod.net>
References: <20251127115136.3064948-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127115136.3064948-1-gnoack@google.com>
X-Infomaniak-Routing: alpha

Good job for writing this complex mechanic (and the related doc), this
patch series is great!  It's been in linux-next for a few weeks and I'll
take it for Linux 7.0

I did some cosmetic changes though, you'll find them in my commits.
Some more tests are needed but I'll take this series for now.

Thanks!

On Thu, Nov 27, 2025 at 12:51:33PM +0100, Günther Noack wrote:
> This patch set adds the LANDLOCK_RESTRICT_SELF_TSYNC flag to
> landlock_restrict_self().  With this flag, the passed Landlock ruleset
> will not only be applied to the calling thread, but to all threads
> which belong to the same process.
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
>     distinct Landlock domains.  This breaks signaling across threads
>     when using LANDLOCK_SCOPE_SIGNAL.
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
> Implementation details
> ======================
> 
> Enforcement prerequisites
> -------------------------
> 
> Normally, the prerequisite for enforcing a Landlock policy is to
> either have CAP_SYS_ADMIN or the no_new_privs flag.  With
> LANDLOCK_RESTRICT_SELF_TSYNC, the no_new_privs flag will automatically
> be applied for sibling threads if the caller had it.
> 
> These prerequisites and the "TSYNC" behavior work the same as for
> Seccomp and its SECCOMP_FILTER_FLAG_TSYNC flag.
> 
> Pseudo-signals
> --------------
> 
> Landlock domains are stored in struct cred, and a task's struct cred
> can only be modified by the task itself [6].
> 
> To make that work, we use task_work_add() to register a pseudo-signal
> for each of the affected threads.  At signal execution time, these
> tasks will coordinate to switch out their Landlock policy in lockstep
> with each other, guaranteeing all-or-nothing semantics.
> 
> This implementation can be thought of as a kernel-side implementation
> of the userspace hack that glibc/NPTL use for setuid(2) [3] [4], and
> which libpsx implements for libcap [2].
> 
> Finding all sibling threads
> ---------------------------
> 
> In order to avoid grabbing the global task_list_lock, we employ the
> scheme proposed by Jann Horn in [7]:
> 
> 1. Loop through the list of sibling threads
> 2. Schedule a pseudo-signal for each and make each thread wait in the
>    pseudo-signal
> 3. Go back to 1. and look for more sibling thread that we have not
>    seen yet
> 
> Do this until no more new threads are found.  As all threads were
> waiting in their pseudo-signals, they can not spawn additional threads
> and we found them all.
> 
> Coordination between tasks
> --------------------------
> 
> As tasks run their pseudo-signal task work, they coordinate through
> the following completions:
> 
>  - all_prepared (with counter num_preparing)
>  
>    When done, all new sibling threads in the inner loop(!) of finding
>    new threads are now in their pseudo-signal handlers and have
>    prepared the struct cred object to commit (or written an error into
>    the shared "preparation_error").
> 
>    The lifetime of all_prepared is only the inner loop of finding new
>    threads.
> 
>  - ready_to_commit
> 
>    When done, the outer loop of finding new threads is done and all
>    sibling threads have prepared their struct cred object.  Marked
>    completed by the calling thread.
> 
>  - all_finished
> 
>    When done, all sibling threads are done executing their
>    pseudo-signal handlers.
> 
> Use of credentials API
> ----------------------
> 
> Under normal circumstances, sibling threads share the same struct cred
> object.  To avoid unnecessary duplication, if we find that a thread
> uses the same struct cred as the calling thread, we side-step the
> normal use of the credentials API [6] and place a pointer to that
> existing struct cred instead of creating a new one using
> prepare_creds() in the sibling thread.
> 
> Noteworthy discussion points
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> * We are side-stepping the normal credentials API [6], by re-wiring an
>   existing struct cred object instead of calling prepare_creds().
> 
>   We can technically avoid it, but it would create unnecessary
>   duplicate struct cred objects in multithreaded scenarios.
> 
> Change Log
> ==========
> 
> v3:
>  - bigger organizational changes
>    - move tsync logic into own file
>    - tsync: extract count_additional_threads() and
>      schedule_task_work()
>  - code style
>    - restrict_one_thread, syscalls.c: use err instead of res (mic)
>    - restrict_one_thread: inline current_cred variable
>    - restrict_one_thread: add comment to shortcut logic (mic)
>    - rsync_works helpers: use size_t i for loop vars
>    - landlock_cred_copy: skip redundant NULL checks
>    - function name: s,tsync_works_free,tsync_works_release, (mic)
>    - tsync_works_grow_by: kzalloc into a temporary variable for
>      clarity (mic)
>    - tsync_works_contains_task: make struct task_works const
>  - bugs
>    - handle kmalloc family failures correctly (jannh)
>    - tsync_works_release: check task NULL ptr before put
>    - s/put_task_struct_rcu_user/put_task_struct/ (jannh)
>  - concurrency bugs
>    - schedule_task_work: do not return error when encountering exiting
>      tasks This can happen during normal operation, we should not
>      error due to it (jannh)
>    - landlock_restrict_sibling_threads: make current hold the
>      num_unfinished/all_finished barrier (more robust, jannh)
>    - un-wedge the deadlock using wait_for_completion_interruptible
>      (jannh) See "testing" below and discussion in
>      https://lore.kernel.org/all/CAG48ez1oS9kANZBq1bt+D76MX03DPHAFp76GJt7z5yx-Na1VLQ@mail.gmail.com/
>  - logic
>    - tsync_works_grow_by(): grow to size+n, not capacity+n
>    - tsync_works_grow_by(): add overflow check for capacity increase
>    - landlock_restrict_self(): make TSYNC and LOG flags work together
>    - set no_new_privs in the same way as seccomp,
>      whenever the calling thread had it
>  - testing
>    - add test where multiple threads call landlock_restrict_self()
>      concurrently
>    - test that no_new_privs is implicitly enabled for sibling threads
>  - bump ABI version to v8
>  - documentation improvements
>    - document ABI v8
>    - move flag documentation into the landlock.h header
>    - comment: Explain why we do not need sighand->siglock or
>      cred_guard_mutex
>    - various comment improvements
>    - reminder above struct landlock_cred_security about updating
>      landlock_cred_copy on changes
> 
> v2:
>  - https://lore.kernel.org/all/20250221184417.27954-2-gnoack3000@gmail.com/
>  - Semantics:
>    - Threads implicitly set NO_NEW_PRIVS unless they have
>      CAP_SYS_ADMIN, to fulfill Landlock policy enforcement
>      prerequisites
>    - Landlock policy gets unconditionally overridden even if the
>      previously established Landlock domains in sibling threads were
>      diverging.
>  - Restructure discovery of all sibling threads, with the algorithm
>    proposed by Jann Horn [7]: Loop through threads multiple times, and
>    get them all stuck in the pseudo signal (task work), until no new
>    sibling threads show up.
>  - Use RCU lock when iterating over sibling threads.
>  - Override existing Landlock domains of other threads,
>    instead of applying a new Landlock policy on top
>  - Directly re-wire the struct cred for sibling threads,
>    instread of creating a new one with prepare_creds().
>  - Tests:
>    - Remove multi_threaded_failure test
>      (The only remaining failure case is ENOMEM,
>      there is no good way to provoke that in a selftest)
>    - Add test for success despite diverging Landlock domains.
> 
> [1] https://github.com/landlock-lsm/go-landlock
> [2] https://sites.google.com/site/fullycapable/who-ordered-libpsx
> [3] https://man.gnoack.org/7/nptl
> [4] https://man.gnoack.org/2/setuid#VERSIONS
> [5] https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/
> [6] https://www.kernel.org/doc/html/latest/security/credentials.html
> [7] https://lore.kernel.org/all/CAG48ez0pWg3OTABfCKRk5sWrURM-HdJhQMcWedEppc_z1rrVJw@mail.gmail.com/
> 
> Günther Noack (3):
>   landlock: Multithreading support for landlock_restrict_self()
>   landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC
>   landlock: Document LANDLOCK_RESTRICT_SELF_TSYNC
> 
>  Documentation/userspace-api/landlock.rst      |   8 +
>  include/uapi/linux/landlock.h                 |  13 +
>  security/landlock/Makefile                    |   2 +-
>  security/landlock/cred.h                      |  12 +
>  security/landlock/limits.h                    |   2 +-
>  security/landlock/syscalls.c                  |  66 ++-
>  security/landlock/tsync.c                     | 555 ++++++++++++++++++
>  security/landlock/tsync.h                     |  16 +
>  tools/testing/selftests/landlock/base_test.c  |   8 +-
>  tools/testing/selftests/landlock/tsync_test.c | 161 +++++
>  10 files changed, 810 insertions(+), 33 deletions(-)
>  create mode 100644 security/landlock/tsync.c
>  create mode 100644 security/landlock/tsync.h
>  create mode 100644 tools/testing/selftests/landlock/tsync_test.c
> 
> -- 
> 2.52.0.177.g9f829587af-goog
> 
> 

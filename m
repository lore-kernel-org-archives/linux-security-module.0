Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1732E151
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244319; cv=none; b=koGozkwmk212ng2qmyPV+LIjym7sMzK2uMV8WvprbT5rFWQ4daIDplRAPTBZ42RQOYBR/poUKJiVqV2PjoqrWgQPCzuX571g5Iz0o9VPx2L9KunZcfbqhoho+ZuW2wC+NlJRaL0KlQmlJ7o/W4FZbAAEDtkg2PhAty08wgoz2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244319; c=relaxed/simple;
	bh=Ibiq39Spw/2TkphUzkLn5lBBF48sI+yEQwo/1o+13e4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=asaa4orrQJtvcszG7+z2f5VPau9DIueghjDl3yaG9tq7vzZplelyRC2N57uHEoRVj1WQ7ma4tFsKLrKQHTUQIDQnAB1OQoZ1iQ3zy6J0PqKVRQ7IZ9UObH6Tr5Ixhj4RCJr+DFPeuabZ7qhXcDqU033/riCw6TK2aSfpQDvo+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auxaI1CO; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auxaI1CO"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso3897355e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764244315; x=1764849115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/mHrxzgYd5kzUKlF23m4G1W+UJuIrn3WS+EoGUuOAc=;
        b=auxaI1COW8o9YP4w6s+zv2TTcCIBeYkcI3l+p94Jn03zUdrJN1O2wmEe9Z0Zm8YAxs
         62F4HO2PB04PZsgS/0Mpi2UC6KT+SQS0p0H0IhqLmC6DbwCJmBwK+5PUe3lIupFaJLuV
         mlux3Hz9P+VQytAdK/nuzPY26Ijm7c/BQ1TyFjSdveIdEJHAiOKUbB9XTg/XOLzBmcR2
         PPCgYswIY1PEy7VFiD/tKexsNIKpQ9LF8TIS4qFGLxn897pRUaL+2WnDhmEX3gh1oS3j
         5qnc/F+bW5tMvqfnwixw1oLXyAS/p8F2QmQ2wWOQZ/5N7RbR7fp1yyzlAb1S3x7IDVSp
         AMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244315; x=1764849115;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/mHrxzgYd5kzUKlF23m4G1W+UJuIrn3WS+EoGUuOAc=;
        b=mn4/ybUshyyYYXCoAJerhR9wlVzfCiHhBzMU9a/Eq9nFXrxt1n6H2MreFwHvI1bYkR
         Q1yeFIcCuv9j6yBHzm55egZQoo/3mMEOdOdE4c2GBZiGWe+vXbiL+VWobEdAmCElpPo0
         kgrFCm3bUib44GqPDwMH0i8yxpoqk7LLJI7fnrEC9cP2PsLCUx83FKN2NbqpYefzorjL
         VmD0syqk4SegAqgf52oSqsmjZqFB84KohcBHWsJze65aXSD38vbFuYw48RWOzmexC0WJ
         bSMsWBoSPAzbPwZKS5aRFWShZMJKJxq3iCUG3tuKSI4+3+w2fewnVG6RRmYFuDt25mcw
         2WAA==
X-Gm-Message-State: AOJu0YzHS7HBd7juJU7WflNGD457vIAQYnnvWkVxLkJZ6xSTpKIR73ds
	ddBPvXgVR1VNbwJrzKCAFsYAtDVb0LXddsdCYPcPQYqLRZkBZXh/ZD37+ozM+RuJ5M6npgm5R8s
	26mMi0ehs7W5U14TDUrTKBn0u+vDbkveeOjVvb8hzWzuXtBrtYVv/wp6YMikIPrlMcZ3Vc3ld4U
	HLsyxuR/Lo7IIXkw9pfX9zQRnWxUzjQonyAoUEBhI3HwUBZT7sCZeB0drl
X-Google-Smtp-Source: AGHT+IEJvqcNF/FAKE0zslsGN1Rj1jfMyvy7XBtOPJvGh8Tv1BNvlWiFptDR5p+fKrjuXAmRAFFRDPB3aUY=
X-Received: from wmkz4.prod.google.com ([2002:a7b:c7c4:0:b0:477:a6e8:797a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3549:b0:477:9fa0:7495
 with SMTP id 5b1f17b1804b1-477c053069fmr225876585e9.14.1764244314788; Thu, 27
 Nov 2025 03:51:54 -0800 (PST)
Date: Thu, 27 Nov 2025 12:51:33 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251127115136.3064948-1-gnoack@google.com>
Subject: [PATCH v3 0/3] Landlock multithreaded enforcement
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch set adds the LANDLOCK_RESTRICT_SELF_TSYNC flag to
landlock_restrict_self().  With this flag, the passed Landlock ruleset
will not only be applied to the calling thread, but to all threads
which belong to the same process.

Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

TL;DR: The libpsx/nptl(7) signal hack which we use in user space for
multi-threaded Landlock enforcement is incompatible with Landlock's
signal scoping support.  Landlock can restrict the use of signals
across Landlock domains, but we need signals ourselves in user space
in ways that are not permitted any more under these restrictions.

Enabling Landlock proves to be difficult in processes that are already
multi-threaded at the time of enforcement:

* Enforcement in only one thread is usually a mistake because threads
  do not normally have proper security boundaries between them.

* Also, multithreading is unavoidable in some circumstances, such as
  when using Landlock from a Go program.  Go programs are already
  multithreaded by the time that they enter the "func main()".

So far, the approach in Go[1] was to use libpsx[2].  This library
implements the mechanism described in nptl(7) [3]: It keeps track of
all threads with a linker hack and then makes all threads do the same
syscall by registering a signal handler for them and invoking it.

With commit 54a6e6bbf3be ("landlock: Add signal scoping"), Landlock
gained the ability to restrict the use of signals across different
Landlock domains.

Landlock's signal scoping support is incompatible with the libpsx
approach of enabling Landlock:

(1) With libpsx, although all threads enforce the same ruleset object,
    they technically do the operation separately and end up in
    distinct Landlock domains.  This breaks signaling across threads
    when using LANDLOCK_SCOPE_SIGNAL.

(2) Cross-thread Signals are themselves needed to enforce further
    nested Landlock domains across multiple threads.  So nested
    Landlock policies become impossible there.

In addition to Landlock itself, cross-thread signals are also needed
for other seemingly-harmless API calls like the setuid(2) [4] and for
the use of libcap (co-developed with libpsx), which have the same
problem where the underlying syscall only applies to the calling
thread.

Implementation details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Enforcement prerequisites
-------------------------

Normally, the prerequisite for enforcing a Landlock policy is to
either have CAP_SYS_ADMIN or the no_new_privs flag.  With
LANDLOCK_RESTRICT_SELF_TSYNC, the no_new_privs flag will automatically
be applied for sibling threads if the caller had it.

These prerequisites and the "TSYNC" behavior work the same as for
Seccomp and its SECCOMP_FILTER_FLAG_TSYNC flag.

Pseudo-signals
--------------

Landlock domains are stored in struct cred, and a task's struct cred
can only be modified by the task itself [6].

To make that work, we use task_work_add() to register a pseudo-signal
for each of the affected threads.  At signal execution time, these
tasks will coordinate to switch out their Landlock policy in lockstep
with each other, guaranteeing all-or-nothing semantics.

This implementation can be thought of as a kernel-side implementation
of the userspace hack that glibc/NPTL use for setuid(2) [3] [4], and
which libpsx implements for libcap [2].

Finding all sibling threads
---------------------------

In order to avoid grabbing the global task_list_lock, we employ the
scheme proposed by Jann Horn in [7]:

1. Loop through the list of sibling threads
2. Schedule a pseudo-signal for each and make each thread wait in the
   pseudo-signal
3. Go back to 1. and look for more sibling thread that we have not
   seen yet

Do this until no more new threads are found.  As all threads were
waiting in their pseudo-signals, they can not spawn additional threads
and we found them all.

Coordination between tasks
--------------------------

As tasks run their pseudo-signal task work, they coordinate through
the following completions:

 - all_prepared (with counter num_preparing)
=20
   When done, all new sibling threads in the inner loop(!) of finding
   new threads are now in their pseudo-signal handlers and have
   prepared the struct cred object to commit (or written an error into
   the shared "preparation_error").

   The lifetime of all_prepared is only the inner loop of finding new
   threads.

 - ready_to_commit

   When done, the outer loop of finding new threads is done and all
   sibling threads have prepared their struct cred object.  Marked
   completed by the calling thread.

 - all_finished

   When done, all sibling threads are done executing their
   pseudo-signal handlers.

Use of credentials API
----------------------

Under normal circumstances, sibling threads share the same struct cred
object.  To avoid unnecessary duplication, if we find that a thread
uses the same struct cred as the calling thread, we side-step the
normal use of the credentials API [6] and place a pointer to that
existing struct cred instead of creating a new one using
prepare_creds() in the sibling thread.

Noteworthy discussion points
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* We are side-stepping the normal credentials API [6], by re-wiring an
  existing struct cred object instead of calling prepare_creds().

  We can technically avoid it, but it would create unnecessary
  duplicate struct cred objects in multithreaded scenarios.

Change Log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

v3:
 - bigger organizational changes
   - move tsync logic into own file
   - tsync: extract count_additional_threads() and
     schedule_task_work()
 - code style
   - restrict_one_thread, syscalls.c: use err instead of res (mic)
   - restrict_one_thread: inline current_cred variable
   - restrict_one_thread: add comment to shortcut logic (mic)
   - rsync_works helpers: use size_t i for loop vars
   - landlock_cred_copy: skip redundant NULL checks
   - function name: s,tsync_works_free,tsync_works_release, (mic)
   - tsync_works_grow_by: kzalloc into a temporary variable for
     clarity (mic)
   - tsync_works_contains_task: make struct task_works const
 - bugs
   - handle kmalloc family failures correctly (jannh)
   - tsync_works_release: check task NULL ptr before put
   - s/put_task_struct_rcu_user/put_task_struct/ (jannh)
 - concurrency bugs
   - schedule_task_work: do not return error when encountering exiting
     tasks This can happen during normal operation, we should not
     error due to it (jannh)
   - landlock_restrict_sibling_threads: make current hold the
     num_unfinished/all_finished barrier (more robust, jannh)
   - un-wedge the deadlock using wait_for_completion_interruptible
     (jannh) See "testing" below and discussion in
     https://lore.kernel.org/all/CAG48ez1oS9kANZBq1bt+D76MX03DPHAFp76GJt7z5=
yx-Na1VLQ@mail.gmail.com/
 - logic
   - tsync_works_grow_by(): grow to size+n, not capacity+n
   - tsync_works_grow_by(): add overflow check for capacity increase
   - landlock_restrict_self(): make TSYNC and LOG flags work together
   - set no_new_privs in the same way as seccomp,
     whenever the calling thread had it
 - testing
   - add test where multiple threads call landlock_restrict_self()
     concurrently
   - test that no_new_privs is implicitly enabled for sibling threads
 - bump ABI version to v8
 - documentation improvements
   - document ABI v8
   - move flag documentation into the landlock.h header
   - comment: Explain why we do not need sighand->siglock or
     cred_guard_mutex
   - various comment improvements
   - reminder above struct landlock_cred_security about updating
     landlock_cred_copy on changes

v2:
 - https://lore.kernel.org/all/20250221184417.27954-2-gnoack3000@gmail.com/
 - Semantics:
   - Threads implicitly set NO_NEW_PRIVS unless they have
     CAP_SYS_ADMIN, to fulfill Landlock policy enforcement
     prerequisites
   - Landlock policy gets unconditionally overridden even if the
     previously established Landlock domains in sibling threads were
     diverging.
 - Restructure discovery of all sibling threads, with the algorithm
   proposed by Jann Horn [7]: Loop through threads multiple times, and
   get them all stuck in the pseudo signal (task work), until no new
   sibling threads show up.
 - Use RCU lock when iterating over sibling threads.
 - Override existing Landlock domains of other threads,
   instead of applying a new Landlock policy on top
 - Directly re-wire the struct cred for sibling threads,
   instread of creating a new one with prepare_creds().
 - Tests:
   - Remove multi_threaded_failure test
     (The only remaining failure case is ENOMEM,
     there is no good way to provoke that in a selftest)
   - Add test for success despite diverging Landlock domains.

[1] https://github.com/landlock-lsm/go-landlock
[2] https://sites.google.com/site/fullycapable/who-ordered-libpsx
[3] https://man.gnoack.org/7/nptl
[4] https://man.gnoack.org/2/setuid#VERSIONS
[5] https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45=
e6b8@google.com/
[6] https://www.kernel.org/doc/html/latest/security/credentials.html
[7] https://lore.kernel.org/all/CAG48ez0pWg3OTABfCKRk5sWrURM-HdJhQMcWedEppc=
_z1rrVJw@mail.gmail.com/

G=C3=BCnther Noack (3):
  landlock: Multithreading support for landlock_restrict_self()
  landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC
  landlock: Document LANDLOCK_RESTRICT_SELF_TSYNC

 Documentation/userspace-api/landlock.rst      |   8 +
 include/uapi/linux/landlock.h                 |  13 +
 security/landlock/Makefile                    |   2 +-
 security/landlock/cred.h                      |  12 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/syscalls.c                  |  66 ++-
 security/landlock/tsync.c                     | 555 ++++++++++++++++++
 security/landlock/tsync.h                     |  16 +
 tools/testing/selftests/landlock/base_test.c  |   8 +-
 tools/testing/selftests/landlock/tsync_test.c | 161 +++++
 10 files changed, 810 insertions(+), 33 deletions(-)
 create mode 100644 security/landlock/tsync.c
 create mode 100644 security/landlock/tsync.h
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c

--=20
2.52.0.177.g9f829587af-goog


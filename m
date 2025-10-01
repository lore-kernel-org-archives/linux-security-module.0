Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB52C029D
	for <linux-security-module@vger.kernel.org>; Wed,  1 Oct 2025 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317843; cv=none; b=IQ2nWFRHHo2gySkX6xe40i1DidHiwc0/tmOmN56Q1R4G3NYr8IGOBLktcKGE0ez2KYgGT7Ev6jkvPKrU6eW3u+HzDYuM2DtRcBkNEOtIYtMNT8bxG/5ZPSn/g2Pqo6xkfY9KVNnAK/aoO8N5E0v5BYaJlyvnhtd403Qg4F4sgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317843; c=relaxed/simple;
	bh=GhWbJ5ZWYTKLzxeRunblMWoEPJVHZLGZhjjocjQ75Lc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mNdyE03rz6B6zGh5FqPeBPNNT6vu3SK3TSivmTkZ1ATDtQEGVmWL0VIIsuiKTXAa/mhr3ZAn1e+Cw+8Cnun/jioLB8ngI4Va8AeqX1kKLGWW5eXK/VQdr0kbfpFO8l4i4siL8W2RVs5tIcpKzjA+VMbwQ0jzYzLymZR+6qdGUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqDNO6Sf; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqDNO6Sf"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso23825125e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Oct 2025 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759317840; x=1759922640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSh7as3lMj8DzI7vIU1vOUtAQjSymdP+EFiYufzlS6Q=;
        b=JqDNO6SfuFwWAjZUDvJE2Pdea7TpXKxl2dUA3onk2LvZ8seehAmU3wbj51bvu4f9q9
         l/4IHyrBpO8hEk7CHSOMIOre0AqU5mFA5B1GmpdMcv8WgHesp6pBfRtYt7uEj6nqXCoM
         NGbUlR7UIhWVs09Lzwk1jUy1uXQ1BqXlUzihunCZg6g2UD9rqBHFo9G74j+2c6yl1ty6
         PST8R6IGh9w2zhRDYup+EE+cRCey2xDT7VXswDi8g2wcut2UwXWooP8MhOlsovukNv3Z
         pudUYAgiqZstTML4cc2Q6BWZU3iiPELL0GIv04KEDYls81UTLhG/QAWJqLn+FNULCwPX
         m32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317840; x=1759922640;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSh7as3lMj8DzI7vIU1vOUtAQjSymdP+EFiYufzlS6Q=;
        b=BauqK3a3/sSRI+eGk4QD7RVy70/YRIre58j2td8jEWxuyMCEuGWOgiyaUfXmtdAq/c
         XL+tcaBu2WdV6dZ6l/B1sZZnSDi2wBqIm85kkClx7hU+8WXQFKKOH4fXPb17dDMU2/va
         fXpWzhAoFSroItWQxuCzkggCAxKNUrTSaKZsqDpFW7LGpPR6DH4qenU3p3u/aWc8fO7x
         kSV2ealgPbFEjt6IMPwz8nmfm/e5WtHITZI01JgXwDOJSKpePbPMNUTMXs3lS7O/p9pD
         yHKCW+TGdJDxHV8m7K2/rOXTOQh7IOEfNb4jKHgVDTRxOHJCKnY118K+fU1axQNP4BUU
         vAeA==
X-Gm-Message-State: AOJu0YyJaCH8E7OkVQzqS8AUTNeBXCIyxUImZ8hElby5L3W+seEx/UBv
	NQvL7y9qYyBgIOrAjMXT0TbBEWg7PSagiTephYI/58xfsX2lLqcsIhbJv1kptIH5+GxXwHidE7Y
	BanuppQ==
X-Google-Smtp-Source: AGHT+IHfjI2rn84s0BjJyx9r1x6p7ykkI+QxDK2btyY9Lz5w/7Mfuk5IBe3+YfEG2HpXPW5kAf0rEBvi5bA=
X-Received: from wmby11-n2.prod.google.com ([2002:a05:600c:c04b:20b0:459:dac7:4ea6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b16:b0:45b:79fd:cb3d
 with SMTP id 5b1f17b1804b1-46e612e6aefmr28175445e9.36.1759317839983; Wed, 01
 Oct 2025 04:23:59 -0700 (PDT)
Date: Wed,  1 Oct 2025 13:23:14 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001111807.18902-1-gnoack@google.com>
Subject: [PATCH v2 0/2] Landlock multithreaded enforcement
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Tingmao Wang <m@maowtm.org>
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
be applied for sibling threads if they don't already fulfill these
requirements.

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

* I am slightly unhappy with the elaborate memory allocation scheme
  that I built for the task work objects. Ideas are welcome.

Change Log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

G=C3=BCnther Noack (2):
  landlock: Multithreading support for landlock_restrict_self()
  landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC

 include/uapi/linux/landlock.h                 |   4 +
 security/landlock/cred.h                      |  12 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/syscalls.c                  | 433 +++++++++++++++++-
 tools/testing/selftests/landlock/base_test.c  |   6 +-
 tools/testing/selftests/landlock/tsync_test.c |  99 ++++
 6 files changed, 550 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c

--=20
2.51.0.618.g983fd99d29-goog


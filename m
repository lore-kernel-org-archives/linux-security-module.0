Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2C2512DC
	for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163495; cv=none; b=gNzskD4Kg2qnWdxNgBNfIpK0pWdt3Qa0DpgWkH88yiLgDWrHMZxZJRYk+4yo/y4pj//ekp1ThyzLFVJl+WXf6SDOmZSqJXVMQT42j51MfU8jDAsVmL0LRtufC6LHk204MU3/Wf0fR/EH2xbZHUJ0dE03iwmNY4tW8COhTTbto04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163495; c=relaxed/simple;
	bh=BAdm7S3StqEWI0QEtCtzZVFqJ+JZpZjRiJVkV2MhrQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4vhRWvcZOf5kD0qO2O4uZBjWfmAZSe4+8mCENxWF2upXqIV6BWWKVYdKc/BkOiU4cVl4nQ2C083ERypb+WUZvHxUy0LZOhO1uZpq4KqTImBtOf2YnYQpjoldfrb4AXk0yFQSx0bv9SKe8m2GbpysuVoz5/SakxYTdz6TrvpLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK0HkD7v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK0HkD7v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso2230981f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2025 10:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740163491; x=1740768291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PNAXGhvQjzBTVglbJXnFaY67e0XkqygNHqaqLQ5ttY=;
        b=cK0HkD7vr56Y4LyQRHDPc5YGB+dVjhjNAfNlwB7VvbGcbt1pm+RHKbtd4j1NN3qcGQ
         fAnMqHIIt3adpWeyO/Jf1BAIhq70gBEIG6e5AkK9yw63r3doDXNNfUes08Z+Iy266QzJ
         bh1dq6L+Jx+g3M/fBlnDgBtZ40H5xqlK9rvBDE3CTDmZj8WTGitMrQIIW6MKx1NEqCbh
         mrMZEYnFdm/yzRo4llg66gbm7RFVDMycey4L8zooCObwOEIrBuGjH6gQwnY2dUtA2V1h
         uSOhzLyXTDvNjqufSeeazKBI1aux4eQozdPawRCOu7PEH7TTj/uv6hHLrbz2cNMLM86J
         ZI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740163491; x=1740768291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PNAXGhvQjzBTVglbJXnFaY67e0XkqygNHqaqLQ5ttY=;
        b=XGWKEESrdR4OkDu1ZlSeNgyo74fDQIYU+N4mkKq2p44DXgPlfbFO7ZjHlCub8VcRgG
         ChRhPneI5WKDrIjRDretAdKhOjDpo6PHFa1MALltWZHEuv3xR37r9lsxhzM0AV1mhUi3
         zyyrGHVsnLJBQ0sCZJGNN9YoqgHe/MF9apicNPPUEaXFvsNqfEuHFozEtj7poK/fg5Dr
         JBMQPYm4NHBiqcUR9GgOKluxAoW2B6KozOsQsimLujdtaHIIqX5F/IhcDviuXdPJaYXg
         GWCfS5MkGOzi+BPudNu30vx301jqvyr0u77SwMSATdRrq1WalBg9W4UCt6n8gUv+3bns
         s7Eg==
X-Gm-Message-State: AOJu0YzEsU6Nbo2JLT5wm9VPSkv0hKKJUjY+usD4dOCl9RR1vLs0OzBo
	u/t85355R/rfwgUsXEGjr6OX7DKNgxpjJaDrQTotQj3wm7fTQRn7GoT3lg==
X-Gm-Gg: ASbGncs3JwOrUfmo0fHhaDzUns02JrUm2/GdoUdlwwUF3QcSW2vVsIyMfFp0DQcgAl9
	/c8NxaI7ux3Cko9J+e35m6Z9AIJb3nSuLu87c+P9f80ymws3AN5YMYD3bmUjUaE05/HE+DOiPkD
	izKEseqjHp12HBkxOsEaW1IrDirIu8pvCZDQ+kveKbvgoaLzf5+Uy4cB3MzgoWRLQ2QcJkXpe0z
	a+3pPLwV9D1V6/PHpjr4BFWbYKqL2y3kmmzENcXcPpJSkIV6BEUBmj1sos4HHHRegzuWyK47Clk
	LIjiNURP8x0+j4Gp1krGjDLj1aw=
X-Google-Smtp-Source: AGHT+IE4MsrTRCEiahKu4dNaL1toUQi5qVnHAFeGRWgt0javjX0k1dFLMVz6nIO4juuIhXYw+WHMEw==
X-Received: by 2002:a05:6000:1866:b0:38d:a695:6daf with SMTP id ffacd0b85a97d-38f6f515337mr3544158f8f.19.1740163490616;
        Fri, 21 Feb 2025 10:44:50 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258dcc50sm24520278f8f.34.2025.02.21.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:44:50 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC 0/2] landlock: Multithreaded policy enforcement
Date: Fri, 21 Feb 2025 19:44:16 +0100
Message-ID: <20250221184417.27954-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch set adds the LANDLOCK_RESTRICT_SELF_TSYNC flag to
landlock_restrict_self().  With this flag, the passed Landlock ruleset
will not only be applied to the calling thread, but to all threads
which belong to the same process.

I am sending this intentionally early.  At this point, I am mostly
looking for high-level comments to check whether the general approach
is feasible at all and whether I am using appropriate concurrency
mechanisms for it.

Motivation
==========

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
    distinct Landlock domains.  When the ruleset uses
    LANDLOCK_SCOPE_SIGNAL, it becomes impossible to use cross-thread
    signals in that process.

(2) Cross-thread Signals are themselves needed to enforce further
    nested Landlock domains across multiple threads.  So nested
    Landlock policies become impossible there.

In addition to Landlock itself, cross-thread signals are also needed
for other seemingly-harmless API calls like the setuid(2) [4] and for
the use of libcap (co-developed with libpsx), which have the same
problem where the underlying syscall only applies to the calling
thread.

Implementation approach
=======================

The implementation is inspired by Jann Horn's earlier patch set for
cred_transfer() [5] as well as by the libpsx approach described in [2]
and [3].  In some way, it is a libpsx-like implementation in the
kernel:

When the flag is provided, the calling thread adds a task_work to all
threads to be executed through a pseudo-signal and makes them run it.
The logic is in the function restrict_one_thread().  The threads
execute the following phases in lock step (with a barrier
synchronization in between):

* Preparation Phase
  * Check that the thread meets all prerequisites
  * Create a new struct cred with prepare_creds()
  * Manipulate the struct cred as needed for policy enforcement
  * Write back possible errors to a shared memory location
* BARRIER: Wait for all threads to catch up to this point
* Commit Phase
  * Check that none of the threads had an error.
  * Invoke commit_creds() (or abort_creds() in case of error)

None of the functions used in the commit_phase() can return errors, so
at the time where each thread decides to commit, we are already sure
that it will work across all threads.

At the end, the calling thread waits for all task_work to finish
before returning from the syscall.

(The calling thread itself obviously does not schedule a task_work for
itself, but executes the same restrict_one_thread() logic inline.)

Open questions
==============

The patch set is in early stages, and there are some open questions
for which I am seeking feedback:

Conceptual open questions
~~~~~~~~~~~~~~~~~~~~~~~~~

* To what extent should we expect the threads to be in a known state?

  The single-threaded variant currently requires the
  PR_SET_NO_NEW_PRIVS flag or CAP_SYS_ADMIN as prerequisite for
  enforcing a Landlock ruleset.

  When we are in the multi-threaded variant, there are two main approaches:

  a) Expect same state on all threads: The simplest implementation
     would be that we expect all threads to also have
     PR_SET_NO_NEW_PRIVS or CAP_SYS_ADMIN, and to already be part of
     the same Landlock domain.  Otherwise, the operation is aborted on
     all threads.
  
  b) Pull all threads towards the same state: The 'synchronization'
     option would be that we implicitly establish the same
     PR_SET_NO_NEW_PRIVS and Landlock domain configuration on all
     threads.

     Weird case: If the calling thread has CAP_SYS_ADMIN but not
     PR_SET_NO_NEW_PRIVS, does this mean that a Landlock domain can be
     enabled on a thread without PR_SET_NO_NEW_PRIVS?  (We surely
     should not implicitly grant CAP_SYS_ADMIN to another thread?)
  
  Solutions in the middle between these two might also be possible.
  Depending on the approach, we might want to change the flag name to
  say something else but ..._TSYNC. (That name is just carried over
  from the similarly-named SECCOMP_FILTER_FLAG_TSYNC)

Implementation open questions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Are there better synchronization mechanisms for this purpose than
  task_work with barriers?

* Need to double check deadlock scenarios.

* Need to double check that we are not racing with a concurrent thread
  creation.

* Use the multi-threaded code for the single-threaded variant as well?

  At the current stage, I left the single-threaded code intact and
  copied some of its logic into the multi-threaded variant.  It is
  technically possible to unify this, if we are OK with the single
  threaded code using atomic operations and struct completion all by
  itself (or by interleaving many if-checks, but not sure whether
  that's worth it).

* Does landlock_restrict_self() need to be interruptible?

  (For reference, Jann's patch [5] used
  wait_for_completion_interruptible())


[1] https://github.com/landlock-lsm/go-landlock
[2] https://sites.google.com/site/fullycapable/who-ordered-libpsx
[3] https://man.gnoack.org/7/nptl
[4] https://man.gnoack.org/2/setuid#VERSIONS
[5] https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/

Günther Noack (2):
  landlock: Multithreading support for landlock_restrict_self()
  landlock: selftests for LANDLOCK_RESTRICT_SELF_TSYNC

 include/uapi/linux/landlock.h                 |  10 +
 security/landlock/syscalls.c                  | 232 +++++++++++++++++-
 tools/testing/selftests/landlock/tsync_test.c |  94 +++++++
 3 files changed, 331 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c


base-commit: 69e858e0b8b2ea07759e995aa383e8780d9d140c
-- 
2.48.1


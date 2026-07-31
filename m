Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F372EEE6E
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464474; cv=none; b=YcYn6eH3vq+DCM/0x/2SmbXhRI3MvtoQBENaGp7Qth+KPcnOFMozZS0mrIumocXryleOwTRR7N6/RjYmpN0Dh8+O765pw8EkdCfkU7tF5Rs1cFqDfZNf2K1iItDrL4yypDI7Bdaj2RFY6qi4SlYD/s594rSI0Bl5w6Mr0b9dPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464474; c=relaxed/simple;
	bh=QFIcGV8zKMtTMfMUX1CnB1PUghN3M7CbeL+Pl/Mt0tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkGF7ZJ6QdmDDZ4P2luB1+leMhgomLu6oWuBZBmGHU/tieLN4R19UOePW8V4FUDcrUkuJLbgJzS/Le2u2GMnaA2c3HYphODjC7q43a48ObhJkclZif0+ZVv/xaiLtlxTpleP5MfcNqAFyk1KxAYRoftaRJpSYflneV0xRqUTZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxkXArwF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxkXArwF"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80bb41f7f3cso5012217b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464471; x=1786069271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgXsqlz9cgHr5MWxiJUtzX4iz4009qsJEQz6j+XHtu8=;
        b=CxkXArwF3+pcKh4b3Qclzz4jNvBL+WfTnDg0w1jlPXgbWQ9sJsxDd8kIoZBqiKykAg
         oZB5HyDWrSwc7+bJcfyTLYNIhj0Du3jYNk83lAv9Frh6W6D8ttDNRqPj03e8P5UH50TV
         Oz99WSD+qxF/HwZ2EuV8o/r71SutpGdPJwUIGYURy8Z7ZITMLsn1YpnblOsZ2PimB8qI
         SL1MjLrjv+QhoY9qMPM4z7BBjS+OKo9/WipGvwjWHrw5z7hD13DNlfOQle8iUWDcOAig
         HJ34pRLY/afma6EbOW2eMIxWRWDNPLvBIOYl2E7KM4x1/mmRZtUHJ8B9yKReLrIKuWin
         aFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464471; x=1786069271;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zgXsqlz9cgHr5MWxiJUtzX4iz4009qsJEQz6j+XHtu8=;
        b=F0KFCb2JceVJ/uRQ9lXG5QWmup1/sYelGkppoDelD0uM64Shy+N7jeKBBXQ/6z9neW
         CxwqI7qa5G9DGPi5TdEeNVppaYmMzy5R3YHQq8nmHauh+sb62czXt3uFTb2vg18OT/tI
         yn0koAegXfQgIU/56RvRk8b1KFih25SdjOPx7eTbXq9Bgm5ctsJDTdRClC7ehUNAJDJl
         DICWYnnWM+cTcxgjDp0nnmpF0jQWk9rsmZAeEU+RS2ozsIcFR9o5819GPHY7HFHdZTdZ
         6aFIrLWMu3A6FYlGk+5jNktUc18mouyM24wLS/mjQ3/OSTU5OUDUBaw1VrvdUkNHTEXc
         Lg5A==
X-Forwarded-Encrypted: i=1; AHgh+Rrk8GX9CbL7jPzsjeXrxRdHq2IHDSGFsEMWUdS0/jeBxtUyRwlpavY3QmlDTVBVbisgU7P76ii0a3ltIfLMFxhRHQgU4Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gpvOL0IdyAgEBhBhaoBon8U4kHtvveXSUMxeSi7BahQbb5/O
	XUEz3NzVtok+1Tv0vWrN79eqmr50hka+0oYmA3+Mx/p6kWvCkDfs0ihQ
X-Gm-Gg: AR+sD10IBxq6wv2eSdY0wrTN5JCwxGSq0MhScA3fbsGLmiE6xce2rpzqckgx254aKnI
	N6s+0oJuzC4NNiKHIaVdDdl1XLQlXqeh8OvT420zMkPpBAo4tgUSx+CPWtffBE32lKEWv2Yrwgw
	S9CDOsajzxG6V8JlB1ylw6FeoeOz3xQ8z6wb972di3E11Lgce493Jgbb8bGpHCnh779p0W1uudu
	aX9HfwkIJYIDGbYt7KkD2JXxwKi0m4F21yDbXmgEWgK7x9GqX+d1n1oY6n7ta2WRHDIqX5pRKaO
	pd94OeUO7rfNmNGCmk2jePr6FRytWEmw+6aOJj0E8QXHd+lqt69iyvxXgnw3t8qW/CKMpeVoLIz
	yjO9T/lGDbfYbCIbXKn/tjrBhCAGyjC2y+8rMsmOcwr+3xX49nQuQbcDcHNJS18hLkd2YMV4s1R
	emZ0CEYJnINwffNjFRFVEEHkK2NTnzj6JRPVDmxc7vcqFqJYzPjKr9wfS5AFVcjWSVHyf5jIYR8
	XDeNpaXdPxcXhiRyPWV2g==
X-Received: by 2002:a05:690c:6f12:b0:7f8:7e11:d023 with SMTP id 00721157ae682-81fcbc24a34mr424837b3.49.1785464471301;
        Thu, 30 Jul 2026 19:21:11 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:10 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
Date: Thu, 30 Jul 2026 22:20:33 -0400
Message-ID: <20260731022047.189137-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Howdy,

This series lets BPF programs apply an existing, userspace-created
Landlock ruleset to a program during exec.  The goal is unchanged from
the RFC [1]: BPF does not create, inspect, or mutate Landlock policy,
it only decides whether a ruleset that was already created and
validated through Landlock's existing userspace API should be applied,
based on runtime exec context.

Motivation
---
Deploying Landlock today requires the sandboxed program's
cooperation.  A process can only restrict itself, so applying a
policy system-wide means wrapping every launch path with a helper
that calls landlock_restrict_self(2) before exec, and anything
spawned outside those wrappers runs unconfined.  Supervising exec
from userspace instead (ptrace, seccomp user notifications) is racy
and slow.  Meanwhile, the tools that do enforce system-wide policy
with BPF LSM programs today (container security agents such as
KubeArmor and Tetragon) end up reimplementing path-based access
control in BPF, fraught with horrors of path reconstruction, bind
mounts, rename races, and worse, which is exactly the problem Landlock
already solves in the kernel, with maintained and versioned semantics.

This series composes BPF and Landlock along their natural grain.  The
intended deployment: a supervisor creates one ruleset per policy
class through the existing syscalls, a syscall BPF program parks
them in map kptr fields, and an LSM BPF program picks which (if
any) to apply to an execution based on its runtime context.  The
policy semantics stay Landlock's; BPF contributes only the
programmable decision of when and to whom.  Deciding inside the
exec path closes the race a userspace supervisor cannot: the
policy is in place before the first instruction of the new program
runs.

Addressing RFC feedback
---

The original thread at [1] received useful feedback from the BPF,
LSM and Landlock maintainers. I've hopefully been able to address
all of it here.

The interface is redesigned around the conclusions of the RFC thread.
While it's been over a week since sending [2] detailing some of the
redesign, I figure it's better to show the code.

Four main takeaways came out of the RFC feedback:

1) no kernel or BPF code may call directly into an individual LSM,
every LSM interface must go through the LSM framework.

2) LSMs interact with the kernel subsystems through LSM hooks. kfuncs
are just hooks from the LSM perspective.

3) A new map type is untenable; new maps will not be added for single
consumers. Especially because new map types become ABI.

4) We must implement a generic interface usable by all LSM, without
forgoing the type safety guarantees provided by BPF or making
a ioctl-like multiplexer.

This series does all, as proposed in [2]: the BPF subsystem owns
per-LSM, strongly typed kfuncs in kernel/bpf/bpf_lsm.c, and every
kfunc call passes through a generic LSM hook.  Individual LSMs
implement ordinary LSM hooks and define no BPF interfaces at all.

The three generic hooks carry the policy reference across the LSM
boundary in union lsm_policy_kptr, tagged by the LSM_ID_* value passed
alongside.  The shims dispatch only to the LSM matching that id
(following the setprocattr pattern) and return -EOPNOTSUPP when it is
compiled out or not enabled, so program loading stays independent of
the boot-time LSM configuration and kernel/bpf/ has no build-time
dependency on Landlock.

The LSM hooks
===

  security_policy_kptr_from_fd(lsmid, fd, &policy)
  security_policy_kptr_put(lsmid, &policy)
  security_bprm_enforce_policy_kptr(lsmid, bprm, &policy, flags)

Landlock implements them as ordinary LSM hooks.  The from_fd hook
validates a ruleset fd the same way as the Landlock syscalls; the
enforce hook stages a restriction on the credentials prepared for an
execution, computed by the same helpers as landlock_restrict_self(2);
and a bprm_committing_creds() hook applies it past the exec point of
no return, where nothing can fail.  An execution either starts
confined by the domain or leaves the calling task untouched: a failed
execution releases the staged restriction when its aborted credentials
are freed, so no domain is created for an execution that never
happens.

The Landlock kfuncs
===

  bpf_landlock_get_ruleset_from_fd(fd)   KF_ACQUIRE | KF_RET_NULL
  bpf_landlock_restrict_binprm(bprm, ruleset, flags)
  bpf_landlock_put_ruleset(ruleset)      KF_RELEASE

All sleepable-only.  The acquire kfunc is exclusive to syscall
programs, which run in the context of the task whose fd table gives a
ruleset fd meaning; enforcement is exclusive to LSM programs attached
to bprm_creds_for_exec or bprm_creds_from_file; release works in both.
A kptr destructor is registered so acquired rulesets can be stashed in
ordinary map kptr fields, which is why the put hook must tolerate
non-sleepable contexts (the free is deferred).

The selftests exercise the deployment described above end to end:
a syscall program acquires the supervisor's ruleset and parks it in
a map kptr field; the LSM program takes it from the map and enforces
it on the executions it monitors.  The landlock_restrict_self(2)
flags apply with their usual semantics, except
LANDLOCK_RESTRICT_SELF_TSYNC, which targets the calling threads
rather than the execution and is rejected with -EINVAL.

Changes since the RFC (quite big):
- every kfunc call now passes through a generic LSM hook; the kfuncs
  moved from security/landlock to kernel/bpf/bpf_lsm.c and nothing
  calls directly into Landlock
- the BPF-facing interface stays strongly typed per LSM; the tagged
  union only travels across the LSM boundary. This is superior to
  the void* model proposed in [2].
- BPF_MAP_TYPE_LANDLOCK_RULESET is nixed: the acquire kfunc plus an
  ordinary map kptr field with a registered destructor replaces the
  dedicated map type
- the whole restriction is now staged in the bprm credentials and
  applied at bprm_committing_creds(), where nothing can fail, instead
  of only staging the no_new_privs bit
- domain allocations on the kfunc path no longer charge the mediated
  task's memcg: the enforce hook computes the restriction in a root
  memcg charging scope
- LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS was split into its own series
  [3] and is not carried here; this series only stages the
  Landlock domain. Nothing about it was necessary for this series.
- no new UAPI: no map type, no new flag, no ABI bump (since this
  series touches no Landlock ABI directly and the kfunc/syscall
  side share common code paths).

Subsystem Summary
---

To LSM maintainers: This was the biggest change. There are three new
generic hooks and the union lsm_policy_kptr to abstract the lsm-specific
features declared next to lsm_prop in security.h with one member per
participating LSM.  The hooks are ordinary, LSM-agnostic entry points
usable by any kernel-internal caller, with targeted dispatch by lsm_id
following the setprocattr precedent. It will return -EOPNOTSUPP when the
named LSM is compiled out or disabled.  Nothing in security/ knows about
BPF, and BPF knows nothing about the enabled LSMs.

To Landlock maintainers: there is no ABI or behavior change for
existing users.  The hook implementations reuse the syscall code
paths: ruleset fd validation is shared with the Landlock syscalls,
and the restriction is computed by the same helpers as
landlock_restrict_self(2), factored into prepare/apply steps so
future restrict_self features can hopefully work for both entry
points.  What is new is the entry point: a restriction staged on the
bprm credentials and committed at bprm_committing_creds(), past the
point of no return. The memory accounting issue pointed out by
Mickaël is addressed as well. [4]

To BPF maintainers: BPF owns the three strongly typed kfuncs in
kernel/bpf/bpf_lsm.c, gated per program type (acquire in syscall
programs, enforcement in sleepable LSM programs on the two bprm
hooks), with a registered kptr destructor so rulesets can live in
ordinary map kptr fields.  No new map type, no BPF internals touched.
kernel/bpf/ has no build-time dependency on Landlock or any other LSM
since it just calls the LSM hooks.

Patches 1-3 add the LSM hooks, 4-5 prepare Landlock (fd lookup
exposure, the restrict_self refactoring), 6 implements the hooks,
7-10 add the BPF-owned kfuncs, 11 selftests (end-to-end enforcement,
TSYNC rejection, staged-restriction replacement and discard on a
failed exec, plus six verifier rejection cases), 12-13 documentation.

Tested with a BPF CI run and manual run of the Landlock selftests.

Based on bpf-next/master, but applies cleanly to lsm/next.

[1] https://lore.kernel.org/linux-security-module/20260407200157.3874806-1-utilityemal77@gmail.com/
[2] https://lore.kernel.org/linux-security-module/al_TBtXYUNGLZHC2@zenbox/
[3] https://lore.kernel.org/linux-security-module/20260717220320.1030123-1-utilityemal77@gmail.com/
[4] https://lore.kernel.org/linux-security-module/20260701.ze4eph1eKo7a@digikod.net/

Justin Suess (13):
  lsm: Add LSM hook security_policy_kptr_from_fd
  lsm: Add LSM hook security_policy_kptr_put
  lsm: Add LSM hook security_bprm_enforce_policy_kptr
  landlock: Expose the ruleset fd lookup to the rest of Landlock
  landlock: Factor the credential restriction out of
    landlock_restrict_self()
  landlock: Implement the LSM policy kptr hooks
  bpf: Add the LSM policy kfunc infrastructure
  bpf: Add the bpf_landlock_put_ruleset kfunc and ruleset destructor
  bpf: Add the bpf_landlock_get_ruleset_from_fd kfunc
  bpf: Add the bpf_landlock_restrict_binprm kfunc
  selftests/bpf: Add tests for the Landlock policy kfuncs
  landlock: Document the BPF kfunc interface
  lsm: Document the LSM policy kptr hooks

 Documentation/security/landlock.rst           |  25 ++
 Documentation/security/lsm-development.rst    |  27 ++
 include/linux/lsm_hook_defs.h                 |   5 +
 include/linux/security.h                      |  43 +++
 kernel/bpf/bpf_lsm.c                          | 202 +++++++++++
 security/landlock/Makefile                    |   2 +
 security/landlock/bpf.c                       | 130 +++++++
 security/landlock/bpf.h                       |  21 ++
 security/landlock/cred.c                      | 116 +++++-
 security/landlock/cred.h                      |  51 +++
 security/landlock/limits.h                    |   4 +
 security/landlock/ruleset.c                   |   2 +-
 security/landlock/ruleset.h                   |   3 +
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  |  70 +---
 security/security.c                           | 106 ++++++
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/config.x86_64     |   2 +-
 .../bpf/prog_tests/lsm_policy_kfuncs.c        | 329 ++++++++++++++++++
 .../bpf/progs/lsm_policy_kfuncs_failure.c     | 100 ++++++
 .../bpf/progs/lsm_policy_kfuncs_success.c     | 107 ++++++
 21 files changed, 1292 insertions(+), 56 deletions(-)
 create mode 100644 security/landlock/bpf.c
 create mode 100644 security/landlock/bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_success.c


base-commit: f0e80dee4e32fd11e6ee1b714b75f681c7cafd3e
-- 
2.54.0


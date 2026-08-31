Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D94306D2A
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188381; cv=none; b=UITe0Wd3vq3nijjpfI1r8lE379zLJ27hvqgdFO+GQjKXzrosbnt6SWThbwJ1B4nN81a6WeQKbMjfNtWQvu08WmXxeNQ7SjWfZnB7nUP0ty6KOpFxP0Ud9Me9wF+Lh6lisDCSgSxvuaZxXsOrGbruXZSTPtS+svEZ/XxhoiMk2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188381; c=relaxed/simple;
	bh=sR+NCrb4jveihqzu/NPXu/su4Ho1Q7I0xS25+c5rX08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l38G/IMU8pKAf+7+c9TgzRVgEI62jrp5UoWbQmoMLajKSKwtxaza/wm2kuy0ShGhGYgEx09wdp9I42Y2NtQK61+rEGIEs2n+d5ugw8cLXH1dslYvMFTmmtmb6vysdUjMcnpqTes3ejZ+XWk0sV8UMsOREUtp8YXKEd/mt4qvUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFmlf+Y1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFmlf+Y1"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-866e57f63a3so8444287b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188378; x=1788793178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQRvH3cICJjq9Ao/BggTFlq5eCfk3kLbx4u3cmiu6to=;
        b=mFmlf+Y1SYbeZf9P7P3HeJ1/Jn9n6cVnNTlrFTn8bKGjewmc9WKFSYP10W5eb9WPgE
         EK/fe+szUn/A9Rm2FLz3dKJEIYSU9QIMLbsC8ZvvFLkEyB1H/BztD0MDNGUizfmBCCe5
         q3Bb4WdvgFc7aQKGn9P+vwumFvdpBBmfwCbfQg+NJMTt6Nrf2/yAc0CDrSbweN6Lx1AF
         +XA5SrLKa9DpUo8IY5meqd/xpgUThco8JcZLSXW5N2VNWz168777+RLamzpWrqJvrCgZ
         d8sP+o1OeFcw8FBT5Hg/KApUb/uq7VHN2nT9xQNn13q4o/3W37y3cRWd2gdCjVi34IFa
         5lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188378; x=1788793178;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQRvH3cICJjq9Ao/BggTFlq5eCfk3kLbx4u3cmiu6to=;
        b=DbcO/XvmQ2OWepERMpx4G5dHAReY8hF3naxDFl2ofVUk6iRBgmSaVF8QdjYwlDexuD
         XqEoESkmUaqYwSCDC8BHWqEsaG9Zsc5BoNCQ7T/R1ccqACLBcd2uzu5EC3EmIeEuixWM
         Vt15ddHoyVxLCRCRYCbebjs6WGe6uRNwmF3k5fr08Sz6IuYMa/QVZsVVOZUPY4muzbi+
         qr57Nlk6RJ+0x5O7JHo8zGA1d8tBWilqIbuDbWkKiTlDGg1MeeQ+jdBqBuvLDrtlNEYz
         6/zJ6/JPNlZ4HC0OLVQi2/zLmhEVSiU0c3pMH7sbPIpDhEmIR48IZp6WJpgaRgU6Y0yR
         oDrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjDeInvMPTd5qRSDqKM5b1BZETwM5LloMQSZ+O1gvXoxrajdKI2Svow5l5hJtVp7vfeTBRJbWR7Vwb4fbVjeaue5zU64c=@vger.kernel.org
X-Gm-Message-State: AFuF++lSa7PP/8ZXHEh1TJeu0P3wZ3OFdVCMi4zdo844G8hm6TZMOAy3
	utUSPvs+ZO+NMqnyHa2ZtJNIPZYESbu+3821SqLu/4vVnqO2FEMYGMJp
X-Gm-Gg: AYBFou0iTlTfN2J/jgnkoGxdQRQdKy8ZSiwc4omTwlCCpjREKfvWWhpyEKa61Bq8j9d
	NyciXHIpqknjWH0XSKbCg/gYQjI3yT7pEvWZcAXiL4uxpaFs+UL5H3fI0aP2Y+zJrmStxPC0EVn
	hbCc9voLw/nUU6HcZX8vLwPrH/ADGup+xqRLe30N90ncCteeHYemqoq7Q/7DYLr55GyJkBToF3E
	q6mMlB1CR3ldcNDbXYTt0O5cTUVWCs0owE58AQiBFZAiRQ0elN5Afb7e0Ad08ceezmL5/yxPCUU
	aGN8072yvllbt8uKGy8F0rzc8RcyoKXmCoJuigTyXSOJ2pPf2x2+Zd/q29DQflBtlLqCiVK5QjV
	lC2LCihzVbT2eKZHuzy1YJP1/G3aqMtlSxJ80znna505h2fOzBDG9uMk96fSnAZ6dBNzUV0LgiD
	tuzEnb8hGZGjwCXBffGTGnuLEvVwbURfyRKKwzC4TJkm5+/4fdqTbMi+zVKD68wTh/N81w2A6H0
	euu520PIsfklfhenzD9iMdhf9zk/U2ZNw==
X-Received: by 2002:a05:690c:5808:b0:7fd:a7b6:8d87 with SMTP id 00721157ae682-85d6e149eb8mr70738057b3.25.1788188378372;
        Mon, 31 Aug 2026 07:59:38 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:37 -0700 (PDT)
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
Subject: [PATCH v2 00/15] BPF interface for applying Landlock rulesets
Date: Mon, 31 Aug 2026 10:58:42 -0400
Message-ID: <20260831145858.3869191-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Landlock ruleset to a program during exec.  The goal is unchanged
from the RFC [1] and v1 [2]: BPF does not create, inspect, or mutate
Landlock policy, it only decides whether a ruleset that was already
created and validated through Landlock's existing userspace API
should be applied, based on runtime exec context.  The policy is in
place before the first instruction of the new program runs, closing
the race a userspace supervisor cannot.

The bottom line change in v2: the kfunc interface is now fully
LSM-generic.

The bpf_landlock_* kfuncs have been dropped in favor of
bpf_lsm_policy_* kfuncs that carry no LSM-specific details: no kfunc
argument names an LSM anywhere in the interface.  This is done
without turning the kfuncs into an ioctl-like multiplexer; see the
usage example for the ergonomics.

This design choice was based on feedback from Paul Moore [3] and
Mickaël Salaün [4].  There was some discussion of whether LSMs should
expose LSM-specific interfaces, and concern that a generic interface
would have poor ergonomics / become an ioctl-like multiplexer.

While initially I argued against a generic interface, ultimately I
believe I've found a design that is LSM-generic without the cons /
poor ergonomics of an ioctl-like interface.

The key is a new struct lsm_policy_object, internal to the LSM
framework:

  struct lsm_policy_object {
          u64 lsmid; /* routes the object to the LSM that owns it */
          u32 type;  /* LSM-private tag for its own object types */
  };

The owning LSM embeds this struct in its own policy structure (here,
the Landlock ruleset), and a pointer to it is the BPF-facing kptr.

The kfuncs dispatch an lsm_policy_object pointer to the owning LSM
based on the lsmid.  The LSM checks the type tag (Landlock has only
LANDLOCK_POLICY_TYPE_RULESET) and recovers its own object with:

   container_of(object, struct landlock_ruleset, policy_object);

The fd translation is the one call with no object to dispatch on,
and it needs no LSM_ID_* argument either: a policy object fd refers
to a file associated with the owning LSM's own userspace interface,
so the fd is identified by its fops pointer.  The kfunc passes the
fd to each policy_object_from_fd implementation; an LSM claims its
own fds and declines anyone else's with -EOPNOTSUPP, so the fd
reaches exactly the LSM that created it.  A program that expects a
policy of one specific LSM can still assert its intent by reading
the lsmid off the returned kptr.

One benefit of this: since all LSMs share the one kptr type, objects
from multiple LSMs can be stored in the same map, allowing users to
create LSM-agnostic programs.

The interface
===

Effectively, the kfuncs are security hooks called by a BPF program.

The kfuncs operate on the generic struct lsm_policy_object (the
struct any LSM policy object must embed), rather than an
LSM-specific type:

  bpf_lsm_policy_from_fd(fd, flags)         KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE
  bpf_lsm_policy_acquire(object)            KF_ACQUIRE | KF_RCU | KF_RET_NULL
  bpf_lsm_policy_release(object)            KF_RELEASE
  bpf_lsm_policy_apply_bprm(object, bprm, flags)  KF_SLEEPABLE

The interface is owned by the LSM framework in
security/bpf_lsm_kfuncs.c.  An LSM participates by implementing four
ordinary hooks:

  policy_object_from_fd(fd, &object)
  policy_object_get(object)
  policy_object_put(object)
  bprm_apply_policy_object(bprm, object, flags)

These hooks are unlike any other in the kernel: they have no
security_*() wrappers in security.c because they have no in-kernel
callers.  Their only entry point is BPF, and the BPF entry point is
the kfunc, so the kfuncs in security/bpf_lsm_kfuncs.c play the role
the security_*() wrappers play for other hooks, dispatching the
static call to the LSM matching the object's lsmid.

As they implement LSM-dispatch logic like any other hook, they cannot
be placed outside security/ without exposing LSM internals in an
undesirable way.

Usage TL;DR
===

A syscall program, run in the supervisor's context, translates a
ruleset fd and parks the reference in a map; a sleepable LSM program
on bprm_creds_for_exec()/bprm_creds_from_file() applies it:

  /* setup (BPF_PROG_TYPE_SYSCALL, supervisor's task context) */
  obj = bpf_lsm_policy_from_fd(ruleset_fd, 0);
  old = bpf_kptr_xchg(&map_val->policy, obj);

  /* enforcement (sleepable BPF_PROG_TYPE_LSM on a bprm hook) */
  bpf_rcu_read_lock();
  obj = bpf_lsm_policy_acquire(map_val->policy);
  bpf_rcu_read_unlock();
  if (obj) {
          bpf_lsm_policy_apply_bprm(obj, bprm, 0);
          bpf_lsm_policy_release(obj);
  }

Notice that no LSM is named anywhere in this process: the LSM
information is carried entirely by the fd and the lsm_policy_object.
The caller need not pass an LSM ID or LSM-specific opcode at all.
The same program could apply a policy object from LSM A and LSM B
by simply changing the fd, with zero code changes.

(A caller that needs LSM-specific logic still has the option of
reading lsm_policy_object->lsmid.)

The acquire kfunc is what lets concurrent executions share the one
reference stored in the map: each program execution takes a
reference of its own under an RCU read lock, instead of taking
exclusive ownership of the stored one with bpf_kptr_xchg() (which
would prevent concurrent application).  Both the acquire path and
the hook backing it are new in v2.

The lifetime contract for embedding lsm_policy_object
===

Collapsing every provider into one BTF type makes the lifetime rules
part of the interface rather than a per-LSM agreement.  Any
LSM-specific policy structure embedding lsm_policy_object must
provide the following semantics:

  - The type field of lsm_policy_object must be nonzero.
  - The object must be reference counted.
  - The object must be RCU protected, and freed only after an RCU
    grace period.
  - get acquires with inc-not-zero semantics and may fail against a
    concurrent last put.  Implementing policy_object_get is
    optional.
  - put must be callable from contexts that cannot sleep: map
    teardown drops map-held references through the registered kptr
    destructor.  Implementing policy_object_put is mandatory, even
    if policy_object_get is not implemented.

This contract was picked to be implementable by other LSMs in the
future, and closely mirrors the contract backing the task_struct,
cgroup, and bpf_crypto_ctx kptrs.

Whether to implement policy_object_get is up to the individual LSM,
and the choice selects between shared and unique pointers:
implementing it (as Landlock does here) lets programs acquire
additional references to the object under RCU, while leaving it out
yields an object whose pointer cannot be copied after creation, only
atomically exchanged with bpf_kptr_xchg().  Both models fit the same
interface.

Landlock specifics
===

The bprm hook accepts the landlock_restrict_self(2) flags with their
usual semantics except LANDLOCK_RESTRICT_SELF_TSYNC (rejected: it
targets the calling threads, not the execution).
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS is honored atomically with the
restriction: both are staged on the bprm credentials and applied past
the exec point of no return, so the executed task starts no_new_privs
if and only if it starts confined, and a failed execution leaves the
calling task untouched.

Enforcement through BPF is as observable as the syscall: committing
a staged restriction emits the same landlock_enforce_domain trace
event, and the create/free domain events stay balanced on every
path, including executions aborted before the point of no return.

Notably, rulesets are now RCU protected, which is what allows
enforcement to share the stored kptr instead of xchg-ing it in and
out of the map.

Changes since v1
===

- The interface is fully generic: the per-LSM kptr type
  (struct bpf_landlock_ruleset), the erasure to void *, and the
  security_kfunc_*() shims dispatching on an explicit LSM_ID_*
  argument are gone.  struct lsm_policy_object (lsmid + LSM-private
  type tag) is embedded in the LSM's own object and resolved with
  container_of(), so no LSM type crosses the LSM boundary in either
  direction.
- The per-LSM kfuncs (bpf_landlock_*) are replaced by the four
  LSM-agnostic bpf_lsm_policy_* kfuncs above; they moved from
  kernel/bpf/bpf_lsm.c to security/bpf_lsm_kfuncs.c as the LSM
  framework's own BPF interface.  kernel/bpf explicitly would
  not make sense here because the kfuncs themselves implement
  LSM dispatch logic, an LSM-internal functionality.
- New shared-acquisition model: the policy_object_get hook and the
  bpf_lsm_policy_acquire() kfunc (KF_RCU, backed by
  refcount_inc_not_zero()) let concurrent executions share one map
  slot.  Landlock frees rulesets after an RCU grace period to back
  it, and struct lsm_policy_object is registered in the verifier's
  rcu_protected_types.
- The lifetime rules above are now the documented interface
  contract, not per-kfunc notes.
- LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, whose series [5] has been
  picked up by the Landlock tree since v1 was posted, is honored on
  the exec path with the same atomicity as the syscall.
- The staged enforcement emits landlock_enforce_domain at the exec
  point of no return, with a selftest attached to the tracepoint.
- The selftests are split in two: the properties of the interface
  itself (the verifier-side filter rules, reference leak rejection,
  RCU acquisition, and the from_fd error contract) are tested with no
  LSM dependency alongside the kfuncs, while the end-to-end
  enforcement tests sit with the Landlock provider.
- Still no new UAPI: no map type, no new flag, no ABI bump; the type
  tag and its enum are kernel-internal.

This series is based on the Landlock tree's next branch [6]: it
depends on the ruleset/domain split, the tracepoint series, and the
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag.  The BPF CI bot will
therefore fail to apply this series onto bpf-next.  To cover CI, the
full branch has been submitted manually to BPF CI on GitHub
Actions [7].

The series is structured with LSM framework patches first: patches 1-2
add the hooks, 3 is trivial macro motion, 4-7 the kfuncs, 8 the interface
documentation, and 9 its LSM-independent selftests.

The Landlock provider follows: patches 10-13 add it, 14 its selftests,
and 15 its documentation.

[1] https://lore.kernel.org/linux-security-module/20260407200157.3874806-1-utilityemal77@gmail.com/
[2] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail.com/
[3] https://lore.kernel.org/linux-security-module/CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com/
[4] https://lore.kernel.org/linux-security-module/20260702.ierahzaiLub3@digikod.net/
[5] https://lore.kernel.org/linux-security-module/20260717220320.1030123-1-utilityemal77@gmail.com/
[6] https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
[7] https://github.com/kernel-patches/bpf/pull/13522

Justin Suess (15):
  lsm: Add the LSM policy object lifetime hooks
  lsm: Add the bprm_apply_policy_object LSM hook
  lsm: Move the lsm_for_each_hook() macro to security/lsm.h
  lsm: Add the bpf_lsm_policy_release kfunc and policy object destructor
  lsm: Add the bpf_lsm_policy_from_fd kfunc
  lsm: Add the bpf_lsm_policy_acquire kfunc
  lsm: Add the bpf_lsm_policy_apply_bprm kfunc
  lsm: Document the LSM policy object interface
  selftests/bpf: Add tests for the LSM policy object kfuncs
  landlock: Expose the ruleset fd lookup to the rest of Landlock
  landlock: Factor the credential restriction out of
    landlock_restrict_self()
  landlock: Free rulesets after an RCU grace period
  landlock: Implement the LSM policy object hooks
  selftests/bpf: Test the LSM policy object kfuncs with Landlock
  landlock: Document the BPF policy interface

 Documentation/security/landlock.rst           |  38 ++
 Documentation/security/lsm-development.rst    |  49 ++
 Documentation/trace/events-landlock.rst       |   5 +-
 MAINTAINERS                                   |   1 +
 include/linux/lsm_hook_defs.h                 |   6 +
 include/linux/security.h                      |  11 +
 include/trace/events/landlock.h               |  15 +-
 kernel/bpf/bpf_lsm.c                          |   4 +
 kernel/bpf/verifier.c                         |   3 +
 security/Makefile                             |   2 +-
 security/bpf_lsm_kfuncs.c                     | 251 +++++++++
 security/landlock/Makefile                    |   2 +
 security/landlock/bpf.c                       | 152 +++++
 security/landlock/bpf.h                       |  21 +
 security/landlock/cred.c                      | 148 ++++-
 security/landlock/cred.h                      |  47 ++
 security/landlock/limits.h                    |   4 +
 security/landlock/ruleset.c                   |  30 +-
 security/landlock/ruleset.h                   |  75 ++-
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  | 105 +---
 security/lsm.h                                |   6 +
 security/security.c                           |   5 -
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/config.x86_64     |   2 +-
 .../bpf/prog_tests/lsm_policy_kfuncs.c        |  54 ++
 .../bpf/prog_tests/lsm_policy_landlock.c      | 522 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_policy_kfuncs.c   |  52 ++
 .../bpf/progs/lsm_policy_kfuncs_failure.c     | 154 ++++++
 .../selftests/bpf/progs/lsm_policy_landlock.c | 142 +++++
 30 files changed, 1786 insertions(+), 123 deletions(-)
 create mode 100644 security/bpf_lsm_kfuncs.c
 create mode 100644 security/landlock/bpf.c
 create mode 100644 security/landlock/bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_landlock.c


base-commit: 172b6a6d8463562b0cbebfd66f770b078f81966b
-- 
2.55.0


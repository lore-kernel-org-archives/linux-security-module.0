Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60D40DFDD
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592127; cv=none; b=HUeXlf/2G6F9ZJkPAAMUiSns/aVSchRQk5NsfW1VsncNajCI2NOLkMwdQ8wbrKD3FhyBY+H8otQ95tY753leju5pR2fgD85HRE+YN6QtffWdU/uLgB+J9yhUfpGWSQlynpFi26Rnp/1aTM2cDifoLCB+LLsxkVYtiEJwa3HYNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592127; c=relaxed/simple;
	bh=7hgu82KO5zryDXP6KdyasB/gKOd0hK7TCSZP6UOrPs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQEoBNnaA68tHRAM33SGEc1+ROpQCx/JYiuunMkCPnTVuvVRRqolQ1GIqeY4JH1BbCjKoNs9IT/9626oOlXWjZTfEy5goykK4bHHrNZs9AZtEanclsI3+UqWCkhFjwAi9cabSMS810jhep04SrCSbM727uNHCG3PBF8RBHvk+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmXYgaVw; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmXYgaVw"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501e465a8eso335958d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592124; x=1776196924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/zBMe9I/TWwTaI5LuU2LeZokWJa3kBbGwEbZonwIRg=;
        b=dmXYgaVwQSaV9XRdJxz76N5U6JA77FzJyip7FsPJpQe5D26q3xFPhG+rayKkzsREPV
         o3uZvSpsepaoN9JXKUxSPfDL+ndAT4fz1LxJPGvu9Oo7Ho8AtRxLYEeQDn/PufNydeG9
         9c/SBdrg1yAV8CoAYgtuEEnfmm+z2T4i9mEZvV+73mBrco/7XfBqEaeZVjV2DahdSMCY
         uYxSYOmbSdD92Pzd4xNvBcs/xeNFYSjPTo3A7wdLswWuiTB/NgKnz3yoLD9wwXM2AZkc
         ljc/Q7rNx5DTaECq54WiJdIgAGGhcatqb2cNgAde5njqt5V9B+d1G/6XaVdyMXNYiJ5b
         4meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592124; x=1776196924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/zBMe9I/TWwTaI5LuU2LeZokWJa3kBbGwEbZonwIRg=;
        b=OT2YlzFfRPO6D7RQ0YAUcK1QGIQ1Ne7XSBlMe8d5fGNUnc7SlzozobRAV4OdOvcvT2
         lUEtL/M/N1KU2dG6WweywG4KiX4SBz5/RTInd3Q7AhH3owg5um/H6tcRfeUftFMRL3c6
         7XWB/qdtDpO9IlYmMjOWXopetBCP81Csu2l1oZ1TXputPFGZ1g0AM5kCzz4ZP4My9th0
         HwUt5VU16zeK7B4W+yCtgSqSok0OnaKTvGWaVn9zwc3Mjv6YdSsLP8UeWz5sQTaMEUEK
         KXXaHxyeyt16BoinfkJNpJARCaszhjfrqH4KEDCuh9mDiCA0Tzu+nvc1zifEy66jos4a
         cyNg==
X-Forwarded-Encrypted: i=1; AJvYcCUi9O9GnUbQQoJOIhvn8YG2por/j+Ktogf34/ch9nLUb4txLeCWYj+4v6bc9Ms6L+SuR87Ww0e0Cxo8ubj25aWOeR63hls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaK5hMwdOOJW2JNEF0DWKvKfEe05NazzhWf0DVbsIpWjf5oJ4X
	OWsBA8HhqWM8WhcrO/GQxJRj43nop4ZHantwZ9e+PzyZP/EKykSOXPdM
X-Gm-Gg: AeBDieuStKds0my2UMBfc72ITMXcpxMywWYWceDHTBJgycz87Uerpuq2vyqigBPsKnL
	17vr6AgTGPpe8YA1b8S++1zH238ZYfCuQ3pZvA1A8cfbVgIeZN+DZPpTJ3eAzEbcjL4iGl+Obsb
	WcMd80le84V5TXx42FNsfJEBh3WM5EhB0Rb+6aWMmWSp1RMxM6w9O3u2WtXBSYH8LGKEiZK4ss6
	kOZQiWgM2/jhli7RIPGb7/UdAORnhBXPt9CNJpwJdxqCEmfvMgPV8MuUWZxwm30TFxmohHHuVbO
	teejpk5C+pu8qfbVQdE5iPoskLNcgKpRirefIcMgQM4ciG0ZLo5hHm+VHJE0/e19wc5yuLtIr2Y
	+TWQ30C7tk4SYrrSx7QLZse2TJO1JPByPnLqTvXI394ITWDHjMUxEd8/kAUArlRCsVxqC+99Bs7
	oMWdCBGnfV8B3d/waF5DV813XuRfcnabQHZd5xLcP9fjBoc+D+uGK/URAcnJTCdR32CQolficS
X-Received: by 2002:a05:690e:4007:b0:650:327f:4ff0 with SMTP id 956f58d0204a3-6503d771009mr15211185d50.12.1775592124001;
        Tue, 07 Apr 2026 13:02:04 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:03 -0700 (PDT)
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
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 00/20] BPF interface for applying Landlock rulesets
Date: Tue,  7 Apr 2026 16:01:22 -0400
Message-ID: <20260407200157.3874806-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series lets sleepable BPF LSM programs apply an existing,
userspace-created Landlock ruleset to a program during exec.

The goal is not to move Landlock policy definition into BPF, nor to create a
second policy engine.  Instead, BPF is used only to select when an already
valid Landlock ruleset should be applied, based on runtime exec context.

Background
===

Landlock is primarily a syscall-driven, unprivileged-first LSM.  That model
works well when the application being sandboxed can create and enforce its own
rulesets, or when a trusted launcher can impose restrictions directly before
running a trusted target.

That becomes harder when the target program is not under first-party control,
for example:

1. third-party binaries,
2. unmodified container images,
3. programs reached through shells, wrappers, or service managers, and
4. user-supplied or otherwise untrusted code.

In these cases, an external supervisor may want to apply a Landlock ruleset to
the final executed program, while leaving unrelated parents or helper
processes alone.

Why external sandboxing is awkward today
===

There are two recurring problems.

First, userspace cannot reliably predict every file a target may need across
different systems, packaging layouts, and runtime conditions.  Shared
libraries, configuration files, interpreters, and helper binaries often depend
on details that are only known at runtime.

Second, Landlock inheritance is intentionally one-way.  Once a task is
restricted, descendants inherit that domain and may only become more
restricted.  This is exactly what Landlock should do, but it makes external
sandboxing awkward when the program of interest is buried inside a larger exec
chain.  Applying restrictions too early can affect unrelated intermediates;
applying them too late misses the target entirely.

This series addresses that target-selection problem.

Overview
===

This series adds a small BPF-to-Landlock bridge:

1. userspace creates a normal Landlock ruleset through the existing ABI;
2. userspace inserts that ruleset FD into a new
	BPF_MAP_TYPE_LANDLOCK_RULESET map;
3. a sleepable BPF LSM program attached to an exec-time hook looks up the
	ruleset; and
4. the program calls a kfunc to apply that ruleset to the new program's
	credentials before exec completes.

The important point is that BPF does not create, inspect, or mutate Landlock
policy here.  It only decides whether to apply a ruleset that was already
created and validated through Landlock's existing userspace API.

Interface
===

The series adds:

1. bpf_landlock_restrict_binprm(), which applies a referenced ruleset to
	struct linux_binprm credentials;
2. bpf_landlock_put_ruleset(), which releases a referenced ruleset; and
3. BPF_MAP_TYPE_LANDLOCK_RULESET, a specialized map type for holding
	references to Landlock rulesets originating from userspace file
	descriptors.
4. A new field in the linux_binprm struct to enable application of
   task_set_no_new_privs once execution is beyond the point of no return.

The kfuncs are restricted to sleepable BPF LSM programs attached to
bprm_creds_for_exec and bprm_creds_from_file, which are the points where the
new program's credentials may still be updated safely.

This series also adds LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.  On the BPF path,
this is staged through the exec context and committed only after exec reaches
point-of-no-return.  This avoids side effects on failed executions while
ensuring that the resulting task cannot gain more privileges through later exec
transitions. This is done through the set_nnp_on_point_of_no_return field.

This has a little subtlety: LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS in the BPF
path will not stop the current execution from escalating at all; only subsequent
ones. This is intentional to allow landlock policies to be applied through a
setuid transition for instance, without affecting the current escalation.

Semantics
===

This proposal is intended to preserve Landlock semantics as much as practical
for an exec-time BPF attachment model:

1. only pre-existing Landlock rulesets may be applied;
2. BPF cannot construct, inspect, or modify rulesets;
3. enforcement still happens before the new program begins execution;
4. normal Landlock inheritance, layering, and future composition remain
	unchanged; and
5. this does not bypass Landlock's privilege checks for applying Landlock
    rulesets.

In other words, BPF acts as an external selector for when to apply Landlock,
not as a replacement for Landlock's enforcement engine.

All behavior, future access rights, and previous access rights are designed
to automatically be supported from either BPF or existing syscall contexts.

The main semantic difference is LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS on the BPF
path: it guarantees that the resulting task is pinned with no_new_privs before
it can perform later exec transitions, but it does not retroactively suppress
privilege gain for the current exec transition itself.

The other exception to semantics is the LANDLOCK_RESTRICT_SELF_TSYNC flag.
(see Points of Feedback section)

Patch layout
===

Patches 1-5 prepare the Landlock side by moving shared ruleset logic out of
syscalls.c, adding a no_new_privs flag for non-syscall callers, exposing
linux_binprm->set_nnp_on_point_of_no_return as an interface to set no_new_privs
on the point of no return, and making deferred ruleset destruction RCU-safe.

Patches 6-10 add the BPF-facing pieces: the Landlock kfuncs, the new map type,
syscall handling for that map, and verifier support.

Patches 11-15 add selftests and the small bpftool update needed for the new
map type.

Patches 16-20 add docs and bump the ABI version and update MAINTAINERS.

Feedback is especially welcome on the overall interface shape, the choice of
hooks, and the map semantics.

Testing
===

This patch series has two portions of tests.

One lives in the traditional Landlock selftests, for the new
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag.

The other suite lives under the BPF selftests, and this tests the Landlock
kfuncs and the new BPF_MAP_TYPE_LANDLOCK_RULESET.

This patch series was run through BPF CI, the results of which are here. [1]

All mentioned tests are passing, as well as the BPF CI.

[1] : https://github.com/kernel-patches/bpf/pull/11562

Points of Feedback
===

First, the new set_nnp_on_point_of_no_return field in struct linux_binprm.
This field was needed to request that task_set_no_new_privs be set during an
execution, but only after the execution has proceeded beyond the point of no
return. I couldn't find a way to express this semantic without adding a new
bitfield to struct linux_binprm and a conditional in fs/exec.c. Please see
patch 2.

Feedback on the BPF testing harness, which was generated with AI assistance as
disclosed in the commit footer, is welcomed. I have only limited familiarity
with BPF testing practices. These tests were made with strong human supervision.
See patches 14 and 15.

Feedback on the NO_NEW_PRIVS situation is also welcomed. Because task_set_no_new_privs()
would otherwise leak state on failed executions or AT_EXECVE_CHECK, this series
stages no_new_privs through the exec context and only commits it after
point-of-no-return. This preserves failure behavior while still ensuring that
the resulting task cannot elevate further through later exec transitions.
When called from bprm_creds_from_file, this does not retroactively change the
privilege outcome of the current exec transition itself.

See patch 2 and 3.

Next, the RCU in the landlock_ruleset. Existing BPF maps use RCU to make sure maps
holding references stay valid. I altered the landlock ruleset to use rcu_work
to make sure that the rcu is synchronized before putting on a ruleset, and
acquire the rcu in the arraymap implementation. See patches 5-10.

Next, the semantics of the map. What operations should be supported from BPF
and userspace and what data types should they return? I consider the struct
bpf_landlock_ruleset to be opaque. Userspace can add items to the map via the
fd, delete items by their index, and BPF can delete and lookup items by their
index. Items cannot be updated, only swapped.

Finally, the handling of the LANDLOCK_RESTRICT_SELF_TSYNC flag. This flag has
no meaning in a pre-execution context, as the credentials during the designated
LSM hooks (bprm_creds_for_exec/creds_from_file) still represent the pre-execution
task. Therefore, this flag is invalidated and attempting to use it with
bpf_landlock_restrict_binprm will return -EINVAL. Otherwise, the flag would
result in applying the landlock ruleset to the wrong target in addition to the
intended one. (see patch 2). This behavior is validated with selftests.

Existing works / Credits
===

Mickaël Salaün created patchsets adding BPF tracepoints for landlock in [2] [3].

Mickaël also gave feedback on this feature and the idea in this GitHub thread. [4]

Günther Noack initially received and provided initial feedback on this idea as
an early prototype.

Liz Rice, author of "Learning eBPF: Programming the Linux Kernel for Enhanced
Observability, Networking, and Security" provided background and inspired me to
experiment with BPF and the BPF LSM. [5]

[2] : https://lore.kernel.org/all/20250523165741.693976-1-mic@digikod.net/
[3] : https://lore.kernel.org/linux-security-module/20260406143717.1815792-1-mic@digikod.net/
[4] : https://github.com/landlock-lsm/linux/issues/56
[5] : https://wellesleybooks.com/book/9781098135126

Kind Regards,
Justin Suess

Justin Suess (20):
  landlock: Move operations from syscall into ruleset code
  execve: Add set_nnp_on_point_of_no_return
  landlock: Implement LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  selftests/landlock: Cover LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  landlock: Make ruleset deferred free RCU safe
  bpf: lsm: Add Landlock kfuncs
  bpf: arraymap: Implement Landlock ruleset map
  bpf: Add Landlock ruleset map type
  bpf: syscall: Handle Landlock ruleset maps
  bpf: verifier: Add Landlock ruleset map support
  selftests/bpf: Add Landlock kfunc declarations
  selftests/landlock: Rename gettid wrapper for BPF reuse
  selftests/bpf: Enable Landlock in selftests kernel.
  selftests/bpf: Add Landlock kfunc test program
  selftests/bpf: Add Landlock kfunc test runner
  landlock: Bump ABI version
  tools: bpftool: Add documentation for landlock_ruleset
  landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  bpf: Document BPF_MAP_TYPE_LANDLOCK_RULESET
  MAINTAINERS: update entry for the Landlock subsystem

 Documentation/bpf/map_landlock_ruleset.rst    | 181 +++++
 Documentation/userspace-api/landlock.rst      |  22 +-
 MAINTAINERS                                   |   4 +
 fs/exec.c                                     |   8 +
 include/linux/binfmts.h                       |   7 +-
 include/linux/bpf_lsm.h                       |  15 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/landlock.h                      |  92 +++
 include/uapi/linux/bpf.h                      |   1 +
 include/uapi/linux/landlock.h                 |  14 +
 kernel/bpf/arraymap.c                         |  67 ++
 kernel/bpf/bpf_lsm.c                          | 145 ++++
 kernel/bpf/syscall.c                          |   4 +-
 kernel/bpf/verifier.c                         |  15 +-
 samples/landlock/sandboxer.c                  |   7 +-
 security/landlock/limits.h                    |   2 +-
 security/landlock/ruleset.c                   | 198 ++++-
 security/landlock/ruleset.h                   |  25 +-
 security/landlock/syscalls.c                  | 158 +---
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   1 +
 tools/lib/bpf/libbpf_probes.c                 |   6 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  20 +
 tools/testing/selftests/bpf/config            |   5 +
 tools/testing/selftests/bpf/config.x86_64     |   1 -
 .../bpf/prog_tests/landlock_kfuncs.c          | 733 ++++++++++++++++++
 .../selftests/bpf/progs/landlock_kfuncs.c     |  92 +++
 tools/testing/selftests/landlock/base_test.c  |  10 +-
 tools/testing/selftests/landlock/common.h     |  28 +-
 tools/testing/selftests/landlock/fs_test.c    | 103 +--
 tools/testing/selftests/landlock/net_test.c   |  55 +-
 .../testing/selftests/landlock/ptrace_test.c  |  14 +-
 .../landlock/scoped_abstract_unix_test.c      |  51 +-
 .../selftests/landlock/scoped_base_variants.h |  23 +
 .../selftests/landlock/scoped_common.h        |   5 +-
 .../selftests/landlock/scoped_signal_test.c   |  30 +-
 tools/testing/selftests/landlock/wrappers.h   |   2 +-
 39 files changed, 1877 insertions(+), 273 deletions(-)
 create mode 100644 Documentation/bpf/map_landlock_ruleset.rst
 create mode 100644 include/linux/landlock.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/landlock_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/landlock_kfuncs.c


base-commit: 8c6a27e02bc55ab110d1828610048b19f903aaec
-- 
2.53.0


Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76233C1D48
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982662; cv=none; b=Dbi4S8NXM18TDZ20o4dfTRz3Lt0q456sIPt+VchwoHHHCe6IE4l5/5iqYQc7tZqbQdNt6MN1g7D9SN7VL/XQh7zZlyCTDgsdEzm4w73cdbiwtx8YRbtCI6Yk8kBMf9nRhseyzu0AjnZ9Gcnv7Jb3vrYMp7h7H2pIdvGdyKpMxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982662; c=relaxed/simple;
	bh=AVov50Izs6mTW2/vlm9mOaKyn9GZMvc84xHZVo4j9kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7iTQzS86YP9BGPMTiPec/eItULVGO08tewbkC2BwJaGoby6zpt43SFS7ejiLI+zi1wQhjHRQE8Ad8BSQVCC5QoT3I3Y4k/VAvk+Bg2qBTsBa4cmLfs8tEBSaOxbkw3KjZk0bvh2Jc0BIKl3K6Dagas5mvgDtgfoWe2Yd9BnWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dag8zkC0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dag8zkC0"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8565d77c277so87414747b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982659; x=1789587459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RWDfMkpqZ2EnvloMST4DPLeQM31Xw13F0J6nj96sv8=;
        b=Dag8zkC0jJaq45mqDUA0xkMvEFzAXfvQA4fTdZHBbNfObhwH0p4ZgSIfyEyckosAxD
         VKX7H5TqKGjWc7hri7XMV2ku6Fpk1tk8NvIhtbYAxIMpZTTuq247rCGaXxB0sSnjPb00
         SDMTXCSHxITmjgt9cnGR3HN813qYaCQA9alL+GZQ10PsVakoFZvQKKeCAPXZ/rEncD4b
         EEhhL1uj2tGkXreflvUU8AwiPaAHgMOTElUGwoRulOnLbaLte3DW0tXsWNHpO950mJZ4
         0IBGg7xsm+J28Y9mkoD/Ndp4CS6gVaZhgDnMFbdLGwihV3rh+APxbrozZP36N/G2e88s
         1NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982659; x=1789587459;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3RWDfMkpqZ2EnvloMST4DPLeQM31Xw13F0J6nj96sv8=;
        b=ILU+x349JB491U82/6HLJ9841gXMC8K0VxPGLUN8rPWVn1tbNLk5ieyGPwhbLZuRdO
         7BoncV20PpF7K1kLH2u63hgrBuZ1QE3IHOm2yh4rKdr0Y29dnp6U6kjI0GPKCKWmQb7q
         nGluLOH9kAJcRRfzAF2XI66Zkaf6xgbLFmyLoUw/QPb5CAA3OVxsDmcKXo+uODTzL4Fl
         HJXMQs85hKa06dchAiHYM0DVmuAkH/0VVNpj6p3rXf1Ahtj2w0T9UGRHHu+jcfsQTUV0
         hYUpCPRLIJbghHzrktqNOPWXNw6IVjehalY3lKA76Cb0nAeqC8UHPffc6OuocaSVMk/y
         OtEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnn8Wlow6Ja+YkVpEINZUxnwpGiLwIHVXpLOsI12c1HyScYQg/uLdgfhcekqbRMwsFx/2dFeAXDuQBJRde9UdtzK/bZPc=@vger.kernel.org
X-Gm-Message-State: AFuF++niH00vcr67ECXB5FxaWIK4NuCeKpZbo2BWRHGwvLpRyEG5bRX7
	7uvOyBgsHIfKzVSOF3lT81aUU2mQgK9qCBVKYwMtUPXXW4iq/1oFoR/Z
X-Gm-Gg: AYBFou1vKMpxrQD26yEUNejfkAlleMyVlGO+mPwP0sYfoZuwXfApn0J80E3s1GLqzjl
	Xmad11T4oe0eCk0SgcswwBatK7qQaSPLBicYf2uD7UF+wnwUqXv8GACWthk76uDQqnd/mzDoRQ1
	X9fwEvBTqyvFa1Pw27uhrs/B1CYwFaZt0Bc+3Sj4Cz5Gu5w/0E5mu+KvYNoN0oYv86bhOxUBZjO
	AEbBGXQRWw5gguIZJaSIy+1A6WYSpsza/NTdY5T4IPMPUcgzjNUzhQS7BbwwOnDixqt378siTiN
	IP+g25Dx2lL3bz/AwCBmRfIiEowLZyaqcxOy95fFgMvKP2KO5alipnYtAk0ekoxlhaoq6jycOKd
	dxPONjkKKOjsM54Ec6xlIyLq9r+4wQ6VXDr3mykI+7GrLdPXhCo7h6c/E3kHPkyToUqnIz7Y0tj
	sWJaLVL6NJMqR+FE0GMl+kuytXWYOp6C/CBUVlXtIBgQZ/2QI0GYCeYC0hKkM5v+cgHSuwLGq99
	SyvM8UZaBHDAMiAAXuNYXIUOidbMDGH
X-Received: by 2002:a05:690c:6910:b0:873:5c6b:a313 with SMTP id 00721157ae682-8735c6ba5a9mr120378907b3.65.1788982658508;
        Wed, 09 Sep 2026 12:37:38 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:37:38 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 00/15] BPF interface for applying Landlock rulesets
Date: Wed,  9 Sep 2026 15:37:03 -0400
Message-ID: <20260909193719.518517-1-utilityemal77@gmail.com>
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
from the RFC [1], v1 [2], and v2 [3]: BPF does not create, inspect,
or mutate Landlock policy, it only decides whether a ruleset that
was already created and validated through Landlock's existing
userspace API should be applied, based on runtime exec context.
The policy is in place before the first instruction of the new
program runs, closing the race a userspace supervisor cannot.

v3 is v2 rebased onto bpf-next, plus small fixes; the design is
unchanged.  The Landlock prerequisites (the ruleset/domain split,
the tracepoint series, and LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS)
went upstream in the 7.3 merge window, so the series now applies
directly to bpf-next.

The interface, for reference:

  bpf_lsm_policy_from_fd(fd, flags)         KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE
  bpf_lsm_policy_acquire(object)            KF_ACQUIRE | KF_RCU | KF_RET_NULL
  bpf_lsm_policy_release(object)            KF_RELEASE
  bpf_lsm_policy_apply_bprm(object, bprm, flags)  KF_SLEEPABLE

The kfuncs are LSM-generic: they operate on struct
lsm_policy_object, which the owning LSM embeds in its own policy
structure, and dispatch to that LSM through four ordinary LSM hooks
(policy_object_from_fd, policy_object_get, policy_object_put,
bprm_apply_policy_object).  No kfunc argument names an LSM anywhere
in the interface, yet it is not an ioctl-like multiplexer.
Landlock is the first provider.

Rather than repeating the whole design here, see the v2
cover letter [3] for the details, as the core design and API are
identical to the previous iteration.

Changes since v2
===

- Rebased onto bpf-next; prerequisites are now met.
- The kfunc filter's BPF_LSM_CGROUP case is dropped: since
  commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP
  programs at load time") such programs cannot be sleepable, so
  KF_SLEEPABLE already excludes them from the apply kfunc, making
  that case redundant.
- The apply_bprm patch now documents why the attach-point filter,
  not the verifier's argument typing, is the authorization boundary:
  trusted linux_binprm pointers are also available at the other bprm
  hooks and to tp_btf programs via the exec tracepoints, which share
  the LSM programs' kfunc registration bucket.
- Fixed a pipe fd leak on the fork() error path of
  test_restrict_binprm_discard() (Sashiko AI review).

Changes since v1 are summarized in the v2 cover letter [3].

The series is structured with LSM framework patches first: patches
1-2 add the hooks, 3 is trivial macro motion, 4-7 the kfuncs, 8 the
interface documentation, and 9 its LSM-independent selftests.  The
Landlock provider follows: patches 10-13 add it, 14 its selftests,
and 15 its documentation.

[1] https://lore.kernel.org/linux-security-module/20260407200157.3874806-1-utilityemal77@gmail.com/
[2] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail.com/
[3] https://lore.kernel.org/bpf/20260831145858.3869191-1-utilityemal77@gmail.com/

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
 security/bpf_lsm_kfuncs.c                     | 247 ++++++++
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
 .../bpf/prog_tests/lsm_policy_landlock.c      | 525 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_policy_kfuncs.c   |  52 ++
 .../bpf/progs/lsm_policy_kfuncs_failure.c     | 154 +++++
 .../selftests/bpf/progs/lsm_policy_landlock.c | 142 +++++
 30 files changed, 1785 insertions(+), 123 deletions(-)
 create mode 100644 security/bpf_lsm_kfuncs.c
 create mode 100644 security/landlock/bpf.c
 create mode 100644 security/landlock/bpf.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_landlock.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0


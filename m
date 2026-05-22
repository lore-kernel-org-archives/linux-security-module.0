Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECF30BBB6;
	Fri, 22 May 2026 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417159; cv=none; b=Utbor6nvf0m5rrV1dr8y+Z6dyCbaJRapl/WZx+HbNK4lG/nlix/PFDC9AscHKIzPL1xyikYC5B9cZaeU3HWc6cT3Im5gF0IIHg7FBKpyyxUjcliyyUN+oot1LrpcBUea39iIWSCIwJLs3FRBc3wN3nFUCNiUlKw4DdA+Q9vdVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417159; c=relaxed/simple;
	bh=OCWHXFAm+7t2WOP89G0JpLFF29BVUQfqyLd34OG4rNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHPDzOfPR/T81cEwVegPfPfCP+JMOL/44ClE/1qxRRxcPijU59uZwn5oPofWPNenJoPyDRMLS2ib+tDYr6W3vsbAWN1PzXAzWPQYyvQpjrXb9LNds7Nu2Wh9BuEI0SsJUGoKKrfyx4e97sZB6bAuWqLy4u+Hg5KhpQT49xu0q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIfU7+kJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIfU7+kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944041F000E9;
	Fri, 22 May 2026 02:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417158;
	bh=D0A6Deeyilrx5YYNsm9wxzeUqKZzuMPkTCuigKI9WL4=;
	h=From:To:Cc:Subject:Date;
	b=YIfU7+kJFDywIsfgugqI7dExPMy5BDYl7TBfJ6oa9iyWNbNaTwqouRkz/gcck1Zgv
	 sldpJhXJKq2ap99mTQUHgLvzO2slqLPDaZWK34w8wQLeZR2aL2Q8C3HSHgCKsbW7k3
	 0Shjo37CaDWNqqEN/qF0n9Jb68icH0NqKAefSVFQaKO1N7yWCKT1oxHda28+MQWbGD
	 jWHrRT0eCKnVK1lZmoCd6jtPP/s9I7AR1l5neAGzjcKa3zLyyPwTee2/MSesKSxksw
	 AeERE+RMNDcr1e3Hgj3P0yjjx3keVMpQFo7xajqOFQYc1WsUYLu7qFyVOV1X/nG2iY
	 /9ltTf67ExQow==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com
Subject: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
Date: Fri, 22 May 2026 04:32:20 +0200
Message-ID: <20260522023234.3778588-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the "Signed BPF programs" work and adds
the missing pieces needed for an LSM to do policy enforcement
and addresses the concerns raised by the developers of Hornet.

One signing scheme, please.

BPF does not need a second signing scheme. It needs a policy
framework that consumes the verdict the existing signing pipeline
produces. Two parallel signing stacks is harmful UX for Cilium,
bpftrace, systemd, distros, and everyone shipping signed lskels.
Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
on layering and TOCTOU grounds.

What this series adds

- prog->aux->sig (verdict + keyring) and prog->aux->is_kernel,
  populated by the syscall path before security_bpf_prog_load
  fires.
- bpf_loader_verify_metadata kfunc -- the metadata check is now
  kernel C code, not BPF bytecode. The verifier injects the
  calling prog->aux as an implicit argument via KF_IMPLICIT_ARGS.
- Loader-side prog BTF with BPF_PSEUDO_KFUNC_CALL_PROG_BTF so
  the kfunc CALL is reproducible across build hosts and resolved
  at load time.
- security_bpf_prog_load_post_integrity LSM hook, fired by the
  kfunc on a successful metadata check.
- IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
  two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).

This series address concerns raised by the Hornet developers:

* The metadata hash check should be in kernel C, not BPF
  bytecode -- Blaise Boscaccy [3]:

  The bpf_loader_verify_metadata kfunc moves the hash check from
  inline BPF instructions into kernel C code.

* LSMs cannot observe the verification result at hook time --
  Paul Moore [4]:

  prog->aux->sig.verdict and sig.keyring are populated before any
  LSM hook runs. Furthermore, security_bpf_prog_load_post_integrity
  hook fires after the in-kernel hash check for consumers that want
  to observe or gate the post-integrity transition.


[1] Alexei Starovoitov, NACK on Hornet (TOCTOU + layering),
    https://lore.kernel.org/all/CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com/
[2] Daniel Borkmann, NACK on Hornet v3,
    https://lore.kernel.org/all/798dba24-b5a7-4584-a1f6-793883fe9b5e@iogearbox.net/
[3] Blaise Boscaccy, Hornet v6 (C-side hash verification rationale),
    https://lore.kernel.org/all/20260429191431.2345448-1-bboscaccy@linux.microsoft.com/
[4] Paul Moore, push for post-verifier observability,
    https://lore.kernel.org/all/CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com/


KP Singh (13):
  bpf: expose signature verdict to LSMs via bpf_prog_aux
  bpf: include prog BTF in the signed loader signature scope
  bpf, libbpf: load prog BTF in the skel_internal loader
  bpf: add bpf_loader_verify_metadata kfunc
  bpf: compute prog->digest at BPF_PROG_LOAD entry
  bpf: resolve loader-style kfunc CALLs against prog BTF
  libbpf: generate prog BTF for loader programs
  bpftool gen: embed loader prog BTF in the lskel header
  lsm: add bpf_prog_load_post_integrity hook
  bpf: invoke security_bpf_prog_load_post_integrity from the metadata
    kfunc
  ipe: add BPF program signature properties
  ipe: gate post-integrity BPF program loads
  selftests/bpf: add IPE BPF policy integration tests

 include/linux/bpf.h                           |  19 +++
 include/linux/bpf_verifier.h                  |   6 +
 include/linux/btf.h                           |   1 +
 include/linux/lsm_hook_defs.h                 |   1 +
 include/linux/security.h                      |   6 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/btf.c                              |   8 +
 kernel/bpf/check_btf.c                        |  18 +-
 kernel/bpf/helpers.c                          |  65 ++++++++
 kernel/bpf/syscall.c                          |  76 ++++++++-
 kernel/bpf/verifier.c                         |  58 ++++++-
 security/ipe/Kconfig                          |  14 ++
 security/ipe/audit.c                          |  13 ++
 security/ipe/eval.c                           |  57 +++++++
 security/ipe/eval.h                           |   5 +
 security/ipe/hooks.c                          |  42 +++++
 security/ipe/hooks.h                          |   9 +
 security/ipe/ipe.c                            |   4 +
 security/ipe/policy.h                         |  11 ++
 security/ipe/policy_parser.c                  |  20 +++
 security/security.c                           |  17 ++
 tools/bpf/bpftool/gen.c                       |  21 +++
 tools/bpf/bpftool/sign.c                      |  17 +-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/bpf_gen_internal.h              |   2 +
 tools/lib/bpf/gen_loader.c                    | 127 +++++++++++---
 tools/lib/bpf/libbpf.h                        |   4 +-
 tools/lib/bpf/skel_internal.h                 |  67 +++++---
 .../selftests/bpf/test_signed_bpf_ipe.sh      | 156 ++++++++++++++++++
 tools/testing/selftests/bpf/vmtest.sh         |   4 +-
 30 files changed, 775 insertions(+), 83 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/test_signed_bpf_ipe.sh

-- 
2.53.0


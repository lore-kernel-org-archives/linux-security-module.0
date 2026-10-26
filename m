Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008648;
	b=l9LHwq4GHMkB20bBt2ttqhroTvJANyTDZCBflitt8pYzyrblIqsZYdbOcM8sl0mwcT/X
	 ruT7jRJ3RMennYjZ1b4A4yR8oua2xYa8zULxcl2dbu1RsHGinuDXECP/HHcZIE8lQEqbm
	 VDKWK0N2gM/t0r7JVeeCjpyzgI/+n8SghZu8+iLLfeVmAyOuYNJkCfK7zHIkMPUcCk1+X
	 5wNUDNRHqHd6PQyJ0hE2hshJTLzcU0R/Zk4hyFRPSXY4bxGBcssBXeFnXKudTi6Hq57Ud
	 qUAJSKfOvP3TRRZqZwc20jfxr4nuexds47crh1EEJ7DxLeSsdTwIM2EVBmyw1SWz2Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008648;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=quNXUpQyV0xVvloki+qOFC1yS6qzAqdmYWGNEfjadOs=;
	b=TMFnq2FeOe00OWfU+N0AAJOC18Ox1EAU9Hxm3DRTGWCfuwSt7hlXKgpsFBnKrZYzlT50
	 pjJQSKsaTgSDUkDJcp+GPZnxL19yHIN5UOI+qLcrhtLH4XB/7GO3f4/C/whE/22KX7xFJ
	 VBVtIiNMjOn4RS/dIPRo2Jc+FASEsz41n2nByuaU9I5VeQBL+/9P9e2ccfUf6wl2aAxj/
	 pl02zW+2H0FhNjRuWfKHbWyq0mt6xAgzDCqIt2OFb86hEw+XRccyJSEU7dClrUqWJNZMT
	 BDniksjtd38hI0D3TiE9RwFc9eeFfrm4KOx1gQYbmeddPpCycNd2PpfNSlohF7e6ugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQPMEuos;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DB606A324;
	Mon, 26 Oct 2026 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQPMEuos
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D00A1F01828;
	Mon, 26 Oct 2026 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008647;
	bh=quNXUpQyV0xVvloki+qOFC1yS6qzAqdmYWGNEfjadOs=;
	h=From:Subject:Date:To:Cc;
	b=GQPMEuostipK8qJ1TCmPvG0u89rYztqBG38ooQLWCJETmnyKUtxJ88bl82bmVeIJL
	 3gD8PI2YwYV88zRxT2xXfoPR8VX5Bf1oBdJupUJ2oQPA0zIwKpKy4CmzxT5NNrPST8
	 nOiezxdRD0VWS2adTgtFKBDM7Ugh+aAB3N/TDXYFu4eK0+QdHF5GUxZgrY19SUznVk
	 QiYNTY/POc1BWF2jQzxONLXsBfYS2q9aAEy0gJtH7sE8Tn+EDhQ3nqHpASoKL6JdBV
	 epRGmWOWpHlVFbE146PbAE4MyIKdJZExtlMEWF9lvnMRPz/eLy0cLqTGAOZ+PmcwCG
	 usKCm9I1h9Ehw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/8] ns: fixes for the namespace LSM hooks
Date: Mon, 26 Oct 2026 10:57:08 +0100
Message-Id: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDMBBFf0Vm3UAU+vyVUmSSXmtajDIT+0D89
 ybt4i7O5XAWUkiA0qlaSPAMGsaYod5U5HuON5hwzUyNbXZ1nnmN8jAKP0tIHxN5gE7s0XYCmD1
 zdzi6rbMWlBOToAvvX/58+bPO7g6fSrMYjhXGCUffl2tgTRBa1y87r++dmQAAAA==
X-Change-ID: 20261026-work-security-namespace_free-7aaf89b5b00e
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lFrGpq5vFucUuuqzkgVPP61G9ITiLYWgPS3DopPkmb4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2GSfqoz+7o5a+gyw9b3hpezWV5zlzXfU5PgPWN1f
 cbSBXa8HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRecbwh2+X+bNHJfu2KgXc
 s2M5213Uu3gT46abaa94zqX1Kxrt6mNk6DBg+8InnvHnRF+1F0/2tIkm+fuDbus2lDUl+S5y0fr
 PBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I tried to switch systemd-nsresourced over to the namespace_free LSM
hook that went in this cycle. I explicitly developed it to work nicely
with that. But the version that is merged is broken for that case.

The namespace_free hook is never called. security_namespace_free() bails
if ns->ns_security is NULL and that's only allocated if an LSM requests
a namespace blob. Nobody does. Landlock doesn't care as it only uses
namespace_init and namespace_install but a bpf program attached to
namespace_free never runs. And it can't work around that either. We
could make the bpf LSM request a blob but that would just be a way to
make the hook fire. So call it unconditionally like we do for
superblocks, files and bpf maps.

The bpf LSM also marks the arguments of namespace_init and
namespace_free as trusted. Curiously that patch was also dropped.

namespace_init is called before the namespace is set up and if anything
fails afterwards the namespace is freed without looking at its reference
count. namespace_free is called on the way out. There's no kfunc that
takes a namespace yet but once there is one a program could take a
reference to a namespace that's about to be freed. So add both hooks to
untrusted_lsm_hooks.

The namespace_init hook also always sees a namespace id of zero because
the id is only allocated after the hook has run. The id is the only
identifier of a namespace that is never recycled. So it's what a bpf LSM
wants to use to track a namespace from namespace_init until
namespace_free.

The inode number is recycled way too quickly for that. So allocate the
id in __ns_common_init() before the hook is called. Then ns_tree_add()
doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
Landlock keeps logging zero for denied namespace creation because that's
what it documents.

I'd want to get the first three patches into v7.4 since the hooks are
new this cycle. The systemd change I have for this uses the
namespace_free hook whenever the kernel has it. On a kernel with the
hook but without the first fix it would never learn about dead user
namespaces.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (8):
      lsm: always call the namespace_free hook
      bpf: don't mark namespace_init and namespace_free arguments as trusted
      selftests/bpf: add verifier tests for the namespace LSM hooks
      landlock: pass the namespace id to log to check_ns_type()
      ns: allocate the namespace id before the namespace_init hook
      nstree: drop ns_tree_add_raw()
      lsm: fix the security_namespace_init() kernel-doc
      selftests/bpf: add a lifecycle test for the namespace LSM hooks

 fs/namespace.c                                     |   6 +-
 include/linux/ns_common.h                          |  16 ++-
 include/linux/nstree.h                             |  29 +----
 ipc/namespace.c                                    |   3 +-
 kernel/bpf/bpf_lsm.c                               |   2 +
 kernel/nscommon.c                                  |   7 +-
 kernel/nstree.c                                    |   2 +-
 net/core/net_namespace.c                           |   4 +-
 security/landlock/ns.c                             |  11 +-
 security/security.c                                |   9 +-
 .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
 .../selftests/bpf/progs/verifier_lsm_namespace.c   |  38 ++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   5 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   1 +
 16 files changed, 314 insertions(+), 54 deletions(-)
---
base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
change-id: 20261026-work-security-namespace_free-7aaf89b5b00e


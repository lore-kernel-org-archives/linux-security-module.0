Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3B3AD525;
	Wed, 24 Jun 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311256; cv=none; b=QM9dnFokXiqxwdI9YqhpocxQGczLbvIfI9c3lTXwAmOZ7QlW6GSeK1xjinw6cCrDv+y37nUKvvcIvOY5o/w3+vWnXB3pvTK/Tvi6Ka0+mQJAGn+dcjWxgMqYKUMkiC3AlUdi0YmbHAMlJm0aibMowDW7QnklOVrVQr/Br5Evqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311256; c=relaxed/simple;
	bh=pPsUM/wH2/4H3QZBlTY2nn3luV/1PewjVUttuiJuFGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khcnN7hAJtVjOL59kjjDwPH7I5gK0jYhFrFBIDjEajhbxkdjOX6kHhnCLPTRe338D/ythLLCKxN/Rq0xkxecn6WitBKbHJMsXLTSFYE2ewAN9i8bhzKyK0ldKU2yEDvP0AWDUxgsd8F+2vUNpdjtfoHjF7giwKcChznTJCBQSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eBvc9bik; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eBvc9bik"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=o1AyfKB+ZjGSgVsdsxUpC3h1BPOdh5U+21renvtoT0E=; b=eBvc9bikCuR2GcuxSlrqn7Lg/q
	T5SDSQYf1omtyZB/eb19QTAqVOPL37VG4G3gjYg6Q0Q+ZUgcYXVvC02bBqwPAjwLRcPQSHQpf1Ohf
	cD7GUipW4ZHqc2EQ8bz8W2zyWpVk1fbrKC9htIPmNuJoC5AjYdx8OEp3wGgG2w4DOmyfwiR5Prjo2
	ObC5AiRPTwmvw4fszDDe+1xGh1s60Wa/H75Dj02URHTfVzbVDuMf+rPUSGLE1t9Z+myUNJhKkXbAv
	i1nA2NdiUCUjqEJx3b2DGUufdf96zxjlg2IKMQjP5c022xbpa2n3aavWXm8g6xcSk1+2VXXxPDCys
	g0OzOTMQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcOBy-000GHn-1T;
	Wed, 24 Jun 2026 16:03:02 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 0/5] Verify BPF signed loader at load time
Date: Wed, 24 Jun 2026 16:02:56 +0200
Message-ID: <20260624140301.93421-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28041/Wed Jun 24 08:24:54 2026)

The BPF signing scheme signs a light skeleton's loader program and lets
the loader vouch for everything else: bpftool bakes the SHA256 of the
metadata map into the loader's instructions, signs the instructions, and
the loader compares the (frozen, exclusive) map against that hash from
within BPF once it runs. The construction is sound as a trusted hash
chain, but the kernel itself never attests the metadata, and that split
has been the recurring objection from the LSM / integrity side since the
scheme was proposed.

This proposal closes both gaps by having the kernel verify the metadata
at BPF_PROG_LOAD time, before the LSM admission hook and before the
verifier, /without/ growing the UAPI. A signed loader binds its metadata
map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
are already bound to the loader's digest via excl_prog_hash. When a
signature is present, the kernel collects the exclusive maps from the
fd_array and appends their frozen contents to the instructions before
PKCS#7 verification, so the signature covers ...

    insns || metadata_0 || metadata_1 || [...]

... in fd_array order. The in-loader hash check is dropped from the
gen_loader entirely: generated loaders carry no verification logic
anymore, and signing or verifying a skeleton becomes an ordinary CMS
operation over bytes that sit verbatim in the skeleton, reproducible
offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED
with nothing in between.

There is no new UAPI, we now have a single signature scheme, no LSM
code reaching into BPF internals, no new LSM hook, and unsigned loads
are completely unaffected. It is also less complex since the loader
does not need to deal with BTF, an extra kfunc, etc, as proposed in
an earlier series [0]. Tested against full BPF CI which came back
green. For more details and examples, see the documentation patch in
this series.

  [0] https://lore.kernel.org/bpf/20260522023234.3778588-1-kpsingh@kernel.org/

v1 -> v2:
  - Addressed both sashiko complaints, the TOCTOU bug regarding
    fd_array processing, as well as exclusive map checking to
    only allow array maps. The validation is now moved into the
    verifier before the main verification work happens. This also
    gives the opportunity to utilize the verifier log.

Daniel Borkmann (5):
  bpf: Verify signed loader metadata at load time
  libbpf: Drop in-loader metadata check for load-time verification
  bpftool: Cover loader metadata with the program signature
  selftests/bpf: Verify load-time signed loader metadata
  Documentation/bpf: Add BPF signing and enforcement doc

 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/signing.rst                 | 490 ++++++++++++++
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/syscall.c                          |  81 +--
 kernel/bpf/verifier.c                         | 163 ++++-
 tools/bpf/bpftool/gen.c                       |   2 +
 tools/bpf/bpftool/sign.c                      |  15 +-
 tools/lib/bpf/bpf_gen_internal.h              |   1 -
 tools/lib/bpf/gen_loader.c                    |  76 +--
 tools/lib/bpf/skel_internal.h                 |  27 +-
 .../selftests/bpf/prog_tests/signed_loader.c  | 597 +++++++++++++-----
 11 files changed, 1114 insertions(+), 340 deletions(-)
 create mode 100644 Documentation/bpf/signing.rst

-- 
2.43.0


Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB37305685;
	Thu,  2 Jul 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002977; cv=none; b=oTdCQ+JyQI/EFJ84thyNUt2APt2xU5YHemF2HUa5Qk2dJ8RhW8YzLUWi/fn/qF6xUrNrpA8zFIlBaJXHCc2MS6/8gRQaXHtlo50hp6lcQNbk3H6FnfD/W9D5VbzWpCHD42PtNUbfqJPuESDLPAKWlRxcdLB7GpGL6sBAxIC+NcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002977; c=relaxed/simple;
	bh=sichXbIKtItcMJueXAc/L6cIRbIatK1eR/qGc3xeOg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+TxR2bFnSvIC3OJ9voSLe7WIBe4IgNAWNlRRk0fnpTE38MhGsAACh/x/QYZcnXXSrasJU4fGGd9W08s1wQujSGksfc69tWUVsCIJSqt73wRVDKPv185WfkHSvAOgRF3LJd0oMeKi/OJ9oUvTL/xLNqjO32d8tahSynS9aatQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=W6EZlVsN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="W6EZlVsN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=g9lH+y+SJyWprt0A1aCfm2zWvdzI7QMFLygctOP0x2A=; b=W6EZlVsN4o4EdoI7npLCG5p2gO
	Iu69QBfGq+gPIIo9hkB/U9YQVuMk58Gku/5nVqvD/xFC+z/vzeMj77ye+W3FlfDSPxAv0LRmMR/Fo
	8CInWgfXqVTJwvElZgls/2wsKeA3bzUbOZ0BZiTqL8HqMcw6hpGTIcccW356hdbzAa9aU7xttqhEf
	KkIULTpCRhZf0LvfC2c2W408g7JRWJffAnb/qDwOmXZuHYfQpQRsKAIJEk5Jt63ViL+apPd8/ihJO
	YCgY+dvtw9uyG7f25moZvIVyWOgK3RVD/zkUEHgmenHkaAeHgf681iYOy9donhIiMMSf1D3lDrUiK
	jcBmiCSw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wfIWM-0004qw-1z;
	Thu, 02 Jul 2026 16:36:06 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v3 0/6] Verify BPF signed loader at load time
Date: Thu,  2 Jul 2026 16:35:59 +0200
Message-ID: <20260702143605.252797-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28048/Thu Jul  2 08:25:04 2026)

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

v2 -> v3:
  - Added first commit to cache and work on objects in fd_array
    which was the most recent issue sashiko rightfully complained
  - Added more BPF signed_loader selftest coverage to cover that
    usage of sparse fd_array or map fds gets rejected
  - I left the security_bpf_prog_load as in v2 given preference
    from BPF side over adding new hook
v1 -> v2:
  - Addressed both sashiko complaints, the TOCTOU bug regarding
    fd_array processing, as well as exclusive map checking to
    only allow array maps. The validation is now moved into the
    verifier before the main verification work happens. This also
    gives the opportunity to utilize the verifier log.

Daniel Borkmann (6):
  bpf: Resolve and cache fd_array objects at load time
  bpf: Verify signed loader metadata at load time
  libbpf: Drop in-loader metadata check for load-time verification
  bpftool: Cover loader metadata with the program signature
  selftests/bpf: Verify load-time signed loader metadata
  Documentation/bpf: Add BPF signing and enforcement doc

 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/signing.rst                 | 490 ++++++++++
 include/linux/bpf_verifier.h                  |  23 +-
 kernel/bpf/syscall.c                          |  81 +-
 kernel/bpf/verifier.c                         | 384 ++++++--
 tools/bpf/bpftool/gen.c                       |   2 +
 tools/bpf/bpftool/sign.c                      |  17 +-
 tools/lib/bpf/bpf_gen_internal.h              |   1 -
 tools/lib/bpf/gen_loader.c                    |  76 +-
 tools/lib/bpf/libbpf_internal.h               |   1 -
 tools/lib/bpf/skel_internal.h                 |  27 +-
 .../selftests/bpf/prog_tests/signed_loader.c  | 859 ++++++++++++++----
 12 files changed, 1569 insertions(+), 393 deletions(-)
 create mode 100644 Documentation/bpf/signing.rst

-- 
2.43.0


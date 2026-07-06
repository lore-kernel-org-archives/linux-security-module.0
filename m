Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEE3264E7;
	Mon,  6 Jul 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346217; cv=none; b=TAqrX/ZjJ09XLRDsy7L07Xad1P25e5IHTd37xN1bsAKqQYw0PzupdPxypwXJV7K2NG81NbpxZFrfwDAVzKj2jJncfkfUlv3j+wPFLs1T2lgVP9DY0wwCP1f7fBHEHib+A8qMSKQoB5XCM9O+sCV5XIekuT6lJjQ1Y4MNQwbdph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346217; c=relaxed/simple;
	bh=MtiJQmgY83I/G0dSGxfu3uVD4jfS1D47sQEw2a/WXvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y45ID1EYCThv+1KmFtYASuaB3RgJyhvG5iBj5rRsqq8n4wGD64FiscCS6ojl6ieaEgqEA45uoLBZrRU8tgMABUYj33ZWt+T94Lo2g74aNna/Cb/ypWc4LDi/T98x9n9aQrQnHL7nE6Sd9kvCl5zaxcVX+1tet8A/hIxlAV6P+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YKtPDozL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YKtPDozL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=0tkztsUrQBnbQAVw5rV+etjFBs0qX6sTzn0ZV4uFew4=; b=YKtPDozL18vIvLT6u0jM1bWPuI
	d7/UPDrecbaVFP8RF+db3sK6Ov4f9WmKO026lJWv8LBvLoyhBFaqzl3eRXNiDYuiQ9yQhBtNngnZD
	nUcK0r+jt5s82NgBFcOul7MZua4/jLPDuwvW2hP/8/kF0Eivk785TiV0myvJ9h9ZPeCYtit/TX7JM
	rRpFyCMXW60riFO6D8NQMfBnmc5ZwHzyZqwB7Kolcv/dmN6ig5m17gTKHp2+egAtHe8/si84eojT0
	nl82IhQ8h4QCnf5iClnTDdfOpwbQ0bVNmH4+OkoaZgBg0QCrjdHUHYY7T8B0RvJNtYtDMT8p/cPZC
	/g82444w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgjoT-000E1M-2s;
	Mon, 06 Jul 2026 15:56:46 +0200
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
Subject: [PATCH bpf-next v4 0/9] Verify BPF signed loader at load time
Date: Mon,  6 Jul 2026 15:56:35 +0200
Message-ID: <20260706135644.326006-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)

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

v3 -> v4:
  - Fix upper limit in MAX_FD_ARRAY_CNT (Anton)
  - Reject !fd_array && attr->fd_array_cnt (Anton)
  - Add bpftool patch wrt ignored return value of EVP_Digest() (sashiko)
  - Fix setting of gen_loader_fixture_init (sashiko)
  - Fix unused map_fd cleanup branch in selftest (bot+bpf-ci)
  - Remove now unused map->excl member and adjust selftests
  - Added more BPF signed_loader corner case selftest coverage
  - Added Paul's Nack wrt bpf_prog_load LSM hook dispute
  - Added patch 2 to move bigger allocations below fd_array
    resolution (Paul)
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

Daniel Borkmann (9):
  bpf: Resolve and cache fd_array objects at load time
  bpf: Move bigger allocations below fd_array resolution
  bpf: Verify signed loader metadata at load time
  libbpf: Drop in-loader metadata check for load-time verification
  bpftool: Check EVP_Digest when computing excl_prog_hash
  bpftool: Cover loader metadata with the program signature
  selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
  selftests/bpf: Verify load-time signed loader metadata
  Documentation/bpf: Add BPF signing and enforcement doc

 Documentation/bpf/index.rst                   |    1 +
 Documentation/bpf/signing.rst                 |  496 ++++++++
 include/linux/bpf.h                           |    1 -
 include/linux/bpf_verifier.h                  |   23 +-
 kernel/bpf/syscall.c                          |   83 +-
 kernel/bpf/verifier.c                         |  450 ++++++--
 tools/bpf/bpftool/gen.c                       |    2 +
 tools/bpf/bpftool/sign.c                      |   24 +-
 tools/lib/bpf/bpf_gen_internal.h              |    1 -
 tools/lib/bpf/gen_loader.c                    |   76 +-
 tools/lib/bpf/libbpf_internal.h               |    1 -
 tools/lib/bpf/skel_internal.h                 |   31 +-
 .../selftests/bpf/prog_tests/signed_loader.c  | 1004 ++++++++++++++---
 .../selftests/bpf/progs/test_signed_loader.c  |    9 +-
 .../selftests/bpf/progs/verifier_map_ptr.c    |   23 +-
 15 files changed, 1786 insertions(+), 439 deletions(-)
 create mode 100644 Documentation/bpf/signing.rst

-- 
2.43.0


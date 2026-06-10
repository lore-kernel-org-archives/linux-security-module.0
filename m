Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF823009E2;
	Wed, 10 Jun 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132621; cv=none; b=VP+qzTVErkFoYe8SHNIFM0yLJqwmdJKH76dQSZjCVnze/cpc7wbk4QMlMuY9lYhPgklG1r7ZqZ60MRTfjVQMpVUf7fSqKlQxeB6tuVszgkD8EseTVlX307fWeiQp4nYTUpsbi0CbbvFpOOZtgV1C7KL/p1NYQvp2iTksXgUlJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132621; c=relaxed/simple;
	bh=vsgJakhjCDDlsUm5r+TjFtWawxnV+ycHBNL5H+iwP94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVKV/zIQApT1hkrg7RpWTijVUL9KY/ZPJXyJGLCIlvj33jj+scNM1/s0/VUDASUwK8QeHeTKh6QZqgiyw0Wqz5KDZTVGUq3A9VQyP3ORqRNhM4ylwL1KFGE0B9sGkSO0FkBJPWD28b1AJgEEAgoLUOAVZPfarDNY/s8GNAesyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=peGxU9hd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="peGxU9hd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=191TKGWsKI049ZZwfHI9VYOs/rKO43O/3MnQ0/mdOD0=; b=peGxU9hdqRjfJRrjTeGetbbbb2
	evAyLE3MPquAUoC/psvDxS+LLJS5Iwa/nr+ebFwliqe3n+EtwGyQJZ+nfcLMHTDqoq1mMuE4Wctje
	W6AChVP8rINvb7kJ9IDLbfBq8zJiGCtKwfXi2HbuEt5Y22EBs/oftv9q9MY/RtIjWfV2pfWWQ8/c7
	LWh+D+89ji0bYKsQyvnhE4KtJcM4+Ro9x4/V+f7u4sqbF0gLicJkw9Gt/hD/ycLyvS6Cv/0OpMRW0
	ZT9UzQ7B2qJ/H39bb8i6UcqdXevZtFL0CXdlQNq40bk9Tez4kkQp9HoNlmsczKV29gC6wc0UM8tCW
	UYIlQ8cw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXRxK-0008QL-0l;
	Thu, 11 Jun 2026 01:03:30 +0200
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
Subject: [PATCH bpf-next 0/5] Verify BPF signed loader at load time
Date: Thu, 11 Jun 2026 01:03:24 +0200
Message-ID: <20260610230329.727075-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)

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

Daniel Borkmann (5):
  bpf: Verify signed loader metadata at load time
  libbpf: Drop in-loader metadata check for load-time verification
  bpftool: Cover loader metadata with the program signature
  selftests/bpf: Verify load-time signed loader metadata
  Documentation/bpf: Add BPF signing and enforcement doc

 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/signing.rst                 | 537 ++++++++++++++++++
 kernel/bpf/syscall.c                          | 169 +++++-
 tools/bpf/bpftool/gen.c                       |   2 +
 tools/bpf/bpftool/sign.c                      |  15 +-
 tools/lib/bpf/bpf_gen_internal.h              |   1 -
 tools/lib/bpf/gen_loader.c                    |  76 +--
 tools/lib/bpf/skel_internal.h                 |  27 +-
 .../selftests/bpf/prog_tests/signed_loader.c  | 460 +++++++++------
 9 files changed, 994 insertions(+), 294 deletions(-)
 create mode 100644 Documentation/bpf/signing.rst

-- 
2.43.0


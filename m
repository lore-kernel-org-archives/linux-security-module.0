Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327138D016;
	Fri, 22 May 2026 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486822; cv=none; b=IifW4b0w5Q8HVLo+w71rdzQjd7Zww5X8Hgok45wD36RdaE/0a0CQ/nypcKsWcNZ9UoOIWLPvZpMHHWaVEgcUTDsyE5TTz6bR9DWgH+pugkScXX8uF8Uu/vfsS21HYRINauDZAwuwLjFKP2PYCY2IJSqh4c7JHrkjYGHpXMFI9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486822; c=relaxed/simple;
	bh=ZXOxSg5g+ywKcMDZWNXaVI3FbCvB6v3V6m+teCNbLec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYVN4LHVMzaV/9diUpxEq3FZ7TT0jR0txSsvAs6KSsPoP8mtFIhAboZrdQKA32IM1svM3uy8vSIJabIRT6KfghH/x/ke7QRTvhtDItP9l8a+E2MX/eUHhQbCwGZm0dDbn3ll152ISVFHZQ+Z8De+9fgRdcm5tByugQFxk9GfO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nizZ/vHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nizZ/vHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409F21F000E9;
	Fri, 22 May 2026 21:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486821;
	bh=OW1nFd9/vRiVSHjLFCeqCYCvKfqXBHw9VRAxSgMjikc=;
	h=From:To:Cc:Subject:Date;
	b=nizZ/vHyAqCUCh5Qu+HEBV9T7i9wmqsaLA9vokbn087U1iCYbGIk7h+E0MjhrmUDs
	 BR5L5MmHQ34YZ+oGxY3odI9zlfw9JALGoOjvrct5OioZc1DnKObcRIq6/v6vH3VQjU
	 9mWVY8P3e1lDn7u72vHaVOf5nuQP5TluJuaR7nIYvgOxNTIKQaduMCBZVqNP4zJTT/
	 tQ+4+Cq/7ReH8yoyn96bTeMXI8ujxhlrob0l2u+J13drt9gRvrisI4qc2FSgdoJ9Ig
	 +K/stticXz1NFNcA8nd82Lbubq5l9ugJucb++8oMi+EYVNIzjXdjf7yPOhVqq08Jgy
	 ItFqVW5b20isw==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com
Subject: [PATCH bpf v3 0/2] gen_loader fixes
Date: Fri, 22 May 2026 23:53:35 +0200
Message-ID: <20260522215337.662271-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


  # v2 -> v3

  defer fixing 32 bit.

  Fix off-by-one in the signed loader's cleanup jump and reject
  non-exclusive metadata maps.

  Patch 1 fixes a pre-existing bug: the cleanup-label offset in
  emit_signature_match() does not account for the MOV insn emitted
  before the JMP.

  Patch 2 adds an exclusivity check so the loader bails if the
  metadata map lacks excl_prog_hash, preventing stale-hash attacks
  from concurrent map writers.

KP Singh (2):
  libbpf: fix off-by-one in emit_signature_match jump offset
  bpf, libbpf: reject non-exclusive metadata maps in the signed loader

 include/linux/bpf.h                           |  2 +-
 tools/lib/bpf/gen_loader.c                    | 20 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_map_ptr.c    |  8 +++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.53.0


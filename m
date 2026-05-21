Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45B30B508;
	Thu, 21 May 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376943; cv=none; b=J0L3DPjLTytWUchmWW696zlfxi4nLymzCiZHmf54SfXJ/wjo6cDniXtR1bwPzIT0MIDFWNrylfu7KTJ9C08mssza8m/cukkzO5TLgVUgLqNrD63I1b/6rEztQL57s89RTFCJs7ShBQYquJ40rGTeeMtfMKl4jTHENcZoDdS4rDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376943; c=relaxed/simple;
	bh=grv4WV0k/rmOQBRAzBbRoIpIiMCMRocZDKTENsGZPVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOwvsaLCSaFxUXKG0ln8+ZzcIIdq8N1zSfYIoZqbjI8mRfbHMRrdbg2iMGydbKfh0NJjt0uQknMlb2UXGfIUe5ORqPIbjMlt4512pzAImW28ubPP6VeeGHcKWdSdKrgTGXy17P8Vgt5TaqfAJuhLXEtKOJdqTdTnoI0LdPIcYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcI9OUm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcI9OUm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF81F000E9;
	Thu, 21 May 2026 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376942;
	bh=bDrs657fJEwFv18I9GfHEiJjBoKDAm0MOhRfhNLzR/M=;
	h=From:To:Cc:Subject:Date;
	b=hcI9OUm7Ds3CD1skMz/e9rorlq30ZcvSo/DmIdygQeE6wYH6i4uq3pnuvTZb5jcM2
	 D/twpdiTiomOtWm6/ouchpy9jwaEFY81T09a5D9a+8tRKcA2zf4fghSkYcTP3r6n4i
	 be9iSlQam7RrAKd+oQFHRsihffTgOsGTySBytQp226+PvfYZ+g4FkRJER5X6CJnNDy
	 +0n0pPZ3hZsfx6RuHh5J14uB4KWX9+H7xGfPlKlxEEydHtzHaPzkdLaH2y7srBM/VD
	 3yUDwpXYFwogtAfRw/i/Ntv5o+KvymXG40yIlM2JtM2Wz2pmI1WcEu2LJngskoXijN
	 BuwC2HQy0YbGw==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com
Subject: [PATCH v2 0/2] gen_loader fixes
Date: Thu, 21 May 2026 17:22:15 +0200
Message-ID: <20260521152217.2345235-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 tools/lib/bpf/gen_loader.c                    | 19 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_map_ptr.c    | 10 ++++++----
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.53.0


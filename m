Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FC26E718
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158306; cv=none; b=VAqrc16hnAFH/Btdr3drUQ0/dnQJa3WSJgtWk7x2qDLKVmOM3zKFGQo5Fac0uZtjINL8D6oqnCxNW4fj6duRUUG2wez8UcMGeoOBNz8hGMNW81FnYU3uFdBOGZf487SZ1daeUrOEmyh2ZGXChgycrTI00n1IEgGfVWjRaX/qNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158306; c=relaxed/simple;
	bh=Vwjf0TTECNJPQ06LrsyLdnGi8pMpt2S7C51Ii/G7I1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5tCLrpn/xYETAZsCjz+fn3k3cv9nqoQ+XTAe8Dlh+A5AD0oNVG9B2wWghyY4mpi1jeY1AO4d79QnjHsMfJPu1oc46DSVhyncW523HoQpEsJwLl5ZeZ3oRf49NdUbBZQ2YMZJGSrANdNMVGSa3XJ9LUszg39+Zzeb51ZpSJzzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HOXVGbZh; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HOXVGbZh"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmsKK69RrzLbZ;
	Thu,  2 Apr 2026 21:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775157973;
	bh=YQVkQ6ls/l/gA0mFN+EXk5YIdxccsBbJ4DatbVFldcc=;
	h=From:To:Cc:Subject:Date:From;
	b=HOXVGbZh/qk33pItxyop7K2eJTXPKuXgWMg790uSK/lbr+rPXgNUbDgb9RKvvg3Zh
	 2FkQVN6Hcksvh0zT4jLgVqym84sogAEPnuO0/mVBfLPoXVRgy0Esjt7r5IJxO/SJsJ
	 1/ReC4dHBEBVWrx9rOq9EZmeC3PEhe0yln8FtT3w=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmsKK2lfFzGM2;
	Thu,  2 Apr 2026 21:26:13 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v3 0/5] Fix Landlock audit test flakiness
Date: Thu,  2 Apr 2026 21:26:01 +0200
Message-ID: <20260402192608.1458252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This series fixes two classes of audit selftest failures plus two minor
bugs in the audit test helpers.

The main issue is that domain deallocation audit records are emitted
asynchronously from kworker threads and can arrive after a previous
test's socket has been closed.  This causes two distinct failure modes:

- audit_match_record() picks up a stale deallocation record from a
  previous test instead of the expected one, causing a domain ID
  mismatch.  The audit.layers test (which reads 16 deallocation records
  in sequence) is particularly vulnerable because the large read window
  allows stale records to interleave.  Patch 4 fixes this by filtering
  deallocation records by domain ID and skipping type-matching records
  with wrong content patterns.

- audit_count_records() counts stale deallocation records from a
  previous test, incrementing records.domain from the expected 0 to 1.
  Patch 3 fixes this by draining stale records at audit_init() time and
  removing records.domain == 0 checks that are not preceded by
  audit_match_record() calls (which would consume stale records).

These races are more likely to manifest when additional instrumentation
changes kworker timing in the deallocation path (e.g. with the upcoming
Landlock tracepoints work).

The two minor fixes (patches 1-2) correct a snprintf truncation check
off-by-one and socket file descriptor leaks on error paths in
audit_init(), audit_init_with_exe_filter(), and audit_cleanup().
Patch 5 fixes a __u64 format warning reported by the kbuild bot on
powerpc64.

Patch 1 is an exact subset of the v1 combined patch, which is why it
carries the Reviewed-by tag.  Patches 2 and 3 extend beyond what was in
v1, so the Reviewed-by is not carried.  Patches 4 and 5 are new.

Changes since v2:
https://lore.kernel.org/r/20260401161503.1136946-1-mic@digikod.net
- Patches 4-5: fix __u64 format warnings on powerpc64 (cast to unsigned
  long long for %llx).  Patch 5 is new.

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
- Split the combined drain fix into four separate patches.
- Patch 2: extend fd leak fix to audit_init_with_exe_filter() and
  audit_cleanup().
- Patch 3: also remove domain checks from audit.trace and
  scoped_audit.connect_to_child, document constraint, explain why a
  longer drain timeout was rejected.
- Patch 4: new, add domain ID filtering and timeout management to
  matches_log_domain_deallocated(), skip stale records in
  audit_match_record().

Mickaël Salaün (5):
  selftests/landlock: Fix snprintf truncation checks in audit helpers
  selftests/landlock: Fix socket file descriptor leaks in audit helpers
  selftests/landlock: Drain stale audit records on init
  selftests/landlock: Skip stale records in audit_match_record()
  selftests/landlock: Fix format warning for __u64 in net_test

 tools/testing/selftests/landlock/audit.h      | 133 ++++++++++++++----
 tools/testing/selftests/landlock/audit_test.c |  36 ++---
 tools/testing/selftests/landlock/net_test.c   |   2 +-
 .../testing/selftests/landlock/ptrace_test.c  |   1 -
 .../landlock/scoped_abstract_unix_test.c      |   1 -
 5 files changed, 119 insertions(+), 54 deletions(-)

-- 
2.53.0


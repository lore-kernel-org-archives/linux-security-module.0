Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E046AECC
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060129; cv=none; b=cq6sATC/IQQad1Iu3wFkB1iIV8BIyQJu+xbC0I1QiUudD/FnIT5IiYYw+SjdtKOXnLF6VDeH0x0h+q0SGayS5o4NOA8bqNomE+431ytgb27hvT0Jm8+mvTI+GNns4gP6Ju59ZpVb2hqH33ahmar9KlQC+mM++YCtsMPlIA/YUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060129; c=relaxed/simple;
	bh=wlWFKP6/PvCRgGJaj8JOCfNyZvXiHGM0DIfxISByMkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=riM8aAi5HKpdAAIJKyjgcV3JGBcutR3P2oawKA8SB/XefYmgx/JyMmJdKir0NqexZQZegWm/mQohp8yXK3xOrYc1YVYg0HDab5c3BHlKgBpi0LX4r+RA3+t4B674iDV8IkfTbI/VmegRxBZslLT9GLyxWnztPdH/w2CFdSIIlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fTcqJJz3; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fTcqJJz3"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fm97W0rkPz47D;
	Wed,  1 Apr 2026 18:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775060119;
	bh=rm6y+3RQbj0mRF2bvt+eixtrUy80oCyQto/hwUVN2C0=;
	h=From:To:Cc:Subject:Date:From;
	b=fTcqJJz38JSHbUV0yw8urvZcwjGhOnLapdXlAfCtTC7mJhkVhw7r9yayYDHC23/1s
	 fT5OfAjnNT6KhTWSA7j0/immDw+jmHMjp3KHHecPLiGN+hYzm+zgnf5wHRnB4SgZeQ
	 k2a6PnwsVbjnGqoKt7HJHH/cObnJx733z6SyB5e8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fm97V4mP4zKwt;
	Wed,  1 Apr 2026 18:15:18 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v2 0/4] Fix Landlock audit test flakiness
Date: Wed,  1 Apr 2026 18:14:47 +0200
Message-ID: <20260401161503.1136946-1-mic@digikod.net>
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

Patch 1 is an exact subset of the v1 combined patch, which is why it
carries the Reviewed-by tag.  Patches 2 and 3 extend beyond what was in
v1, so the Reviewed-by is not carried.  Patch 4 is new.

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

Mickaël Salaün (4):
  selftests/landlock: Fix snprintf truncation checks in audit helpers
  selftests/landlock: Fix socket file descriptor leaks in audit helpers
  selftests/landlock: Drain stale audit records on init
  selftests/landlock: Skip stale records in audit_match_record()

 tools/testing/selftests/landlock/audit.h      | 132 ++++++++++++++----
 tools/testing/selftests/landlock/audit_test.c |  34 ++---
 .../testing/selftests/landlock/ptrace_test.c  |   1 -
 .../landlock/scoped_abstract_unix_test.c      |   1 -
 4 files changed, 116 insertions(+), 52 deletions(-)

-- 
2.53.0


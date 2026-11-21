Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290870;
	b=H+iD7wbe0+GFgkyHvNR5wSFBbiuKC+PDs2M4bQYah56/s45Uc7cRq40le+TC5wvJ5vD1
	 QAnx0///P9YfaCxMfKmAsWZfHxMWdwtB0YpPVSrWU5b666Z5NO2xO7VWqeC+wEe5J5Eo5
	 TZyV+Xw3403Ao0kyIEF2AQ89MpgLU1GxVwNLXkjsNNTy2CVY1alKW8Sxbi7hL4ccieiH+
	 rQXkm2GHvInuUhqd/x7MPJUkIjerImD4RxYeeh2NVwbDdIem64Zgs0eDaSKWlboLy6Nb/
	 jEx0yAgKbXUlK9i/ou/mySLk/IBL1BrPq/rU1VLF5R/0pITaVkUSoj8xyNAcKfNK13A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290870;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=Bcg6serWzzJut+m/VDVYqdkm+Bbwlucwp+T1gHr1Az4=;
	b=FkMNbPkV0D0t1J/rnfNDeoG+uijxmX4yBiVe1iyKXDP9t7hNrapK6JSfLqK5rFKy/Pju
	 4Mo8fP7aVpmaPvQgMeRrlG2biWTqbU3cOnuj2GC1qP1U8wnb5Ym/96KWJuke08B87Y+GH
	 hl5TvDHjcNSIQLGTk+jh1+zd14GXzSISiGXhD0XpbbAvNj6yVpWgomZz6WvTmpxu3hQD+
	 J2hgDinTmLIwon1o56fG04+IUaPX/irvgI/wR84LO53hsz02YCFKApqlanr6xd9Xyctf4
	 LHAT9Y2qfYoEAXBzs7EoRTusukEyDD9YS2K4Ino92LNyQJwNXzlRpJwMdxRbzPoPFEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=lrp1DGXF;
	arc=none smtp.remote-ip=84.16.66.172
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D9606A320
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 19:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52D9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=lrp1DGXF
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jX2wC2ctHzJnk;
	Sat, 21 Nov 2026 20:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795290859;
	bh=Bcg6serWzzJut+m/VDVYqdkm+Bbwlucwp+T1gHr1Az4=;
	h=From:To:Cc:Subject:Date:From;
	b=lrp1DGXF4sMHXSB3dtPD0en1W8ZbNQqcUk0qSl+hXng2yaAiv4JfOL4HSkavI/gyp
	 q20acMGCiabqFSv9uLS8PtZejk73WjxFCjde9H26R0qKwOKUikHKp9hQ4uoJwytvnB
	 epYTtoDF8nBsb67W0+/F0YH2f7rWwLwn4lQC2iAU=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jX2wB2QdWzCSW;
	Sat, 21 Nov 2026 20:54:18 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bart Van Assche <bvanassche@acm.org>,
	Dwi Siswanto <me@dw1.io>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Serge Hallyn <sergeh@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fixes for v7.4-rc4
Date: Sat, 21 Nov 2026 20:54:04 +0100
Message-ID: <20261121195404.2775730-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This fixes several Landlock and LSM issues:

 - prevent composed rulesets from denying link and rename operations
   that each ruleset allows separately;

 - close capability-mediation gaps for low-address mappings, inheritable
   capabilities, the admin memory reserve, and PR_SET_SECUREBITS, so LSM
   capability denials apply consistently;

 - distinguish namespace creation from entry in denial records and
   expose the checked capability context to BPF tracepoint consumers, so
   they can interpret denials correctly.

Tests and documentation are updated.  This also fixes clang-format's
handling of guard() and a missing landlock_add_rule(2) error
description.

Please pull these changes for v7.4-rc4 .  These commits merge cleanly
with your master branch.  Kernel changes have been tested in the latest
linux-next releases.

Test coverage for security/landlock is 91.8% of 2894 lines according to
LLVM 23, and it was 91.8% of 2864 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.4-rc4

for you to fetch changes up to 4feb6879b9ab42cacb905f27a44160b7f1f49d85:

  landlock: Add missing EINVAL case in the doc for landlock_add_rule (2026-11-19 17:51:43 +0100)

----------------------------------------------------------------
Landlock fixes for v7.4-rc4

----------------------------------------------------------------
Günther Noack (5):
      landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
      landlock: Add KUnit test for landlock_get_fs_access_mask()
      selftests/landlock: Test that layering does not break refer
      landlock: Simplify landlock_get_fs_access_mask()
      landlock: Clarify implicit handling of LANDLOCK_ACCESS_FS_REFER

Mickaël Salaün (13):
      landlock: Factor out capability denial checks
      landlock: Mediate CAP_SYS_RAWIO for mappings below mmap_min_addr
      landlock: Mediate CAP_SETPCAP for inheritable capabilities
      landlock: Mediate CAP_SYS_ADMIN for the admin memory reserve
      selftests/landlock: Test capability checks outside the capable hook
      landlock: Fix capability restriction documentation
      capabilities: Check PR_SET_SECUREBITS with ns_capable()
      selftests/landlock: Test PR_SET_SECUREBITS mediation
      landlock: Distinguish namespace creation and entry denials
      landlock: Add capability objects to denial tracing
      selftests/landlock: Test namespace denial operations
      landlock: Document namespace denial operations
      clang-format: Fix formatting of guard()

Tingmao Wang (1):
      landlock: Add missing EINVAL case in the doc for landlock_add_rule

 .clang-format                               |   1 -
 Documentation/admin-guide/LSM/landlock.rst  |  21 +-
 Documentation/security/landlock.rst         |   8 +-
 Documentation/trace/events-landlock.rst     |  26 +-
 Documentation/userspace-api/landlock.rst    |  11 +-
 include/trace/events/landlock.h             |  36 ++-
 include/uapi/linux/landlock.h               |  24 +-
 security/commoncap.c                        |  45 ++--
 security/landlock/access.h                  |  11 +-
 security/landlock/audit.c                   |  10 +-
 security/landlock/cap.c                     | 130 ++++++++-
 security/landlock/domain.c                  |  44 +++
 security/landlock/domain.h                  |   9 +-
 security/landlock/errata/abi-4.h            |  21 ++
 security/landlock/log.c                     |   6 +-
 security/landlock/log.h                     |  12 +-
 security/landlock/ns.c                      |  10 +-
 security/landlock/syscalls.c                |   1 +
 security/landlock/trace.c                   |  12 +-
 tools/testing/selftests/landlock/cap_test.c | 397 ++++++++++++++++++++++++++++
 tools/testing/selftests/landlock/common.h   |   4 +-
 tools/testing/selftests/landlock/fs_test.c  |  61 ++++-
 tools/testing/selftests/landlock/ns_test.c  |  25 +-
 tools/testing/selftests/landlock/trace.h    |   1 +
 24 files changed, 815 insertions(+), 111 deletions(-)

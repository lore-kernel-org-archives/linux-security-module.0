Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46D3793C3
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266806; cv=none; b=tU1+z1QWQb9dJG/odePXfmg7YzwCmSy9xF5bhAmt8j8A97L9nd4TSPy9UN1LiCV28Lo9dXVLloMb7gsGo+KTsB/7EKvJRI/PrU5dIcWV0LD0jHLL563Oq9CzbVRL2oBb8NZF0YXIN2RhvEQcJ1wyQ19hxVLAORFwWAR3GgfTwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266806; c=relaxed/simple;
	bh=DMjQnOyVhS6y2pOO/EulNFqZvZgjiHI8oJL7LeFZwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNxWD3fXQwcPE3WGJoDZPFaXjbbOkrumNZv//SZbb/o9Tgm22xFynitOQNjtIm+ttlA6UBfukPeMOfHDy51lteLf0mMSgp9goKc7wPVgUfJUz/U+qve+B0GiHY+wlu96l00XR6jGCIEJ7v6wqVF8y8eRoGWWlORx0tdn7MFWDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Rlhw9j0n; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Rlhw9j0n"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hrJvg5Fvbz9bW;
	Thu, 24 Sep 2026 18:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1790266799;
	bh=I/hEEJPmwajbrQWBJ+BSovGXHHEjZ6S93Af1PTL3rpI=;
	h=From:To:Cc:Subject:Date:From;
	b=Rlhw9j0nEM5DDuwt0o64Yox6ZkwMJjVjRWjHgGxhVc08Y8RjcQ2P0lBmraZyU0d+c
	 ZMX28v1NBXZM9YQIS3l6hf5kTIRccHMJCrqc3GmYx4lMr1JA5eZ9uX73itp4kxIH+I
	 f9PGOuK8gz00+Pka3XbW2dSiBmem8H689OU0QvNE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hrJvf5wQQzQBF;
	Thu, 24 Sep 2026 18:19:58 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v7.3-rc5
Date: Thu, 24 Sep 2026 18:19:52 +0200
Message-ID: <20260924161952.1104402-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This mainly fixes the Landlock tracepoint support merged this cycle so
that denial and rule events report the intended policy context, whether
through tracefs or BTF-visible callbacks.  The size comes from
propagating the corrected contract through event definitions and
producers, adding new tests for the reported context, and updating the
documentation.  This PR also improves annotation and fixes a GCC 16
build warning.

Please pull these changes for v7.3-rc5 .  These commits have been part
of latest linux-next releases and merge cleanly with your master branch.

Test coverage for security/landlock is 91.6% of 2625 lines according to
LLVM 22, and it was 91.6% of 2574 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.3-rc5

for you to fetch changes up to e7e0a54300a896e731dffd3e2e8dae5631d6243d:

  landlock: Widen ruleset versions to 64 bits (2026-09-22 20:52:13 +0200)

----------------------------------------------------------------
Landlock fix for v7.3-rc5

----------------------------------------------------------------
Arnd Bergmann (1):
      landlock: Work around gcc-16 -Wuninitialized warning

Mickaël Salaün (10):
      landlock: Fix tracepoint fixed-width type names
      landlock: Fix filesystem denial blocker reporting
      landlock: Fix rule tracepoint context
      landlock: Fix network denial trace context
      landlock: Report the actual ptrace tracer
      landlock: Report the effective signal number
      selftests/landlock: Test filesystem denial blockers
      selftests/landlock: Test network denial context
      landlock: Fix tracepoint contract documentation
      landlock: Widen ruleset versions to 64 bits

Tingmao Wang (1):
      landlock: Add counted_by in landlock_domain

 Documentation/trace/events-landlock.rst          |  52 ++--
 include/trace/events/landlock.h                  | 301 ++++++++++++++---------
 security/landlock/access.h                       |   8 +
 security/landlock/domain.h                       |   3 +-
 security/landlock/fs.c                           |  10 +-
 security/landlock/log.h                          |  52 +++-
 security/landlock/net.c                          |  42 +++-
 security/landlock/ruleset.h                      |   5 +-
 security/landlock/task.c                         |  87 ++++---
 security/landlock/trace.c                        |  71 ++++--
 tools/testing/selftests/landlock/fs_test.c       |  28 +--
 tools/testing/selftests/landlock/net_test.c      | 295 +++++++++++-----------
 tools/testing/selftests/landlock/trace.h         |  59 +++--
 tools/testing/selftests/landlock/trace_fs_test.c | 130 ++++++++--
 tools/testing/selftests/landlock/trace_test.c    |  51 ++--
 15 files changed, 753 insertions(+), 441 deletions(-)

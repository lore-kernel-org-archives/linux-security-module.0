Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D8126C03
	for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819207; cv=none; b=WjcEYxL+B9w6iaYgqL3QvPRoD5Stk5+tVaUGKcCzXfFebNXQwnzQQTUeBX4wGuATtVF3qXqxZ9Lxk/zXYpNBA+AEDInTv8ABWSZHPD94fIbHZOBGRQ/OSgjIvabTe+VYaq9rydL5ZWP6BJzqM/VKqSWgCQ8eJ6aTWqfTRJ4CN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819207; c=relaxed/simple;
	bh=Ex+umAHai4rt8ubdZ+khUZt/UlRKPuVEmhpc84HbAuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JH5yge/A8CQqQNpX71pDQYlEp/Iu0jO09JK4l1s7/v5L88WiNZr9orpxgX9I9WHBHiRJrKBV7ywCts7HzikDAw6qK0g1/Or+ioZwt4TMebuTbdE6eFUIiLVagMy1w0goVvJKNnluHH5xva7c/o6eJ6F30qrG80uzJ1sGB+PDnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ODp7a8nP; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ODp7a8nP"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fB0lQ1J9yzLf6;
	Wed, 11 Feb 2026 15:13:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770819202;
	bh=5QPNjSea1myxZ7eNGOLCE9AteNt/YdI3KAGkzfpjGg4=;
	h=From:To:Cc:Subject:Date:From;
	b=ODp7a8nPdF25D2OSiBbaY05h9enNdrMSOFYqC9Ahe6u05Jgd3VDKeh6KylQw5lzXv
	 3KWzh78YCtEaolOHgY35odDNuQg4o4ggU2G6suORzmcP8vN2FhydnB43C2TJT3A4yA
	 3eCd5U/sMnIPJiOO9jE8bSYbEneWPDDkC7i7LWlE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fB0lP2wPdzCgx;
	Wed, 11 Feb 2026 15:13:21 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v7.0-rc1
Date: Wed, 11 Feb 2026 15:13:02 +0100
Message-ID: <20260211141302.1134092-1-mic@digikod.net>
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

These changes extend Landlock to enforce restrictions on a whole
process, similarly to the seccomp's TSYNC flag.  Data structure
refactoring simplifies code and improves performance.  Documentation is
extended to cover missing parts.

Please pull these changes for v7.0-rc1 .  These commits merge cleanly
with your master branch.  The kernel changes have been tested in the
latest linux-next releases for some weeks, but I rebased the last
commits to fix a kselftest build issue on old distros, and to add a
review tag.

Test coverage for security/landlock is 91.4% of 2093 lines according to
LLVM 21, and it was 91.9% of 1933 lines before this PR.

Regards,
 Mickaël


PS: I recently updated my PGP key:
    https://lore.kernel.org/keys/20260206.waiCh9iex3ai@digikod.net/

--
The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7:

  Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.0-rc1

for you to fetch changes up to e265b330b93e3a3f9ff5256451d4f09b5f89b239:

  mailmap: Add entry for Mickaël Salaün (2026-02-11 12:03:44 +0100)

----------------------------------------------------------------
Landlock update for v7.0-rc1

----------------------------------------------------------------
Günther Noack (6):
      landlock: Multithreading support for landlock_restrict_self()
      selftests/landlock: Add LANDLOCK_RESTRICT_SELF_TSYNC tests
      landlock: Document LANDLOCK_RESTRICT_SELF_TSYNC
      selftests/landlock: Add filesystem access benchmark
      landlock: Add access_mask_subset() helper
      landlock: Transpose the layer masks data structure

Matthieu Buffet (2):
      landlock: Minor reword of docs for TCP access rights
      landlock: Refactor TCP socket type check

Mickaël Salaün (1):
      mailmap: Add entry for Mickaël Salaün

Samasth Norway Ananda (3):
      landlock: Add backwards compatibility for restrict flags
      landlock: Add errata documentation section
      landlock: Document audit blocker field format

 .mailmap                                      |   1 +
 Documentation/admin-guide/LSM/landlock.rst    |  35 +-
 Documentation/userspace-api/landlock.rst      | 105 ++++-
 include/uapi/linux/landlock.h                 |  30 +-
 security/landlock/Makefile                    |  11 +-
 security/landlock/access.h                    |  35 +-
 security/landlock/audit.c                     |  81 ++--
 security/landlock/audit.h                     |   3 +-
 security/landlock/cred.h                      |  12 +
 security/landlock/domain.c                    |  44 +-
 security/landlock/domain.h                    |   3 +-
 security/landlock/errata/abi-1.h              |   8 +
 security/landlock/errata/abi-4.h              |   7 +
 security/landlock/errata/abi-6.h              |  10 +
 security/landlock/fs.c                        | 352 ++++++++--------
 security/landlock/limits.h                    |   2 +-
 security/landlock/net.c                       |  30 +-
 security/landlock/ruleset.c                   |  91 ++---
 security/landlock/ruleset.h                   |   6 +-
 security/landlock/syscalls.c                  |  65 +--
 security/landlock/tsync.c                     | 561 ++++++++++++++++++++++++++
 security/landlock/tsync.h                     |  16 +
 tools/testing/selftests/landlock/.gitignore   |   1 +
 tools/testing/selftests/landlock/Makefile     |   1 +
 tools/testing/selftests/landlock/base_test.c  |   8 +-
 tools/testing/selftests/landlock/fs_bench.c   | 214 ++++++++++
 tools/testing/selftests/landlock/tsync_test.c | 161 ++++++++
 27 files changed, 1490 insertions(+), 403 deletions(-)
 create mode 100644 security/landlock/tsync.c
 create mode 100644 security/landlock/tsync.h
 create mode 100644 tools/testing/selftests/landlock/fs_bench.c
 create mode 100644 tools/testing/selftests/landlock/tsync_test.c

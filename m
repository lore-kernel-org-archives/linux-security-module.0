Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4F346FCB
	for <linux-security-module@vger.kernel.org>; Fri,  5 Dec 2025 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764962250; cv=none; b=ks7p+y5GGzhQTxyQwEbMLvMMnOQ8JqZtSZbkKPoHiXNHVtXytHcURhOolcmx0NJLRdCq8vgZPNn0O4BP30FEWjYVnriloTgkNwTD3qZPLHjGtM4m8lk5rgQZm9GYQr1BlvzKlAs4njXbUiRl2tkNrxK8D0HbBJLz74da6ujgqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764962250; c=relaxed/simple;
	bh=QT5YApj2Ow6tFolDsNXzXqlZ73lYyCyjzDPFxm9smKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=orlMfToBtOhTX6d0qv85NQpJLNi1CATmoawH7mr0OYcbrTpOwt8wltWDDts/xLX7Lk2tpw8uwJKNCdf65QImOZIbeE965zKWhmT/LPevmqj0JXL1ucQTkYl9MaOu4/oznvnUhZ0Qun0NqmGO0WEvS/0cDXSTvAoWB6FJCXKaPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dcSwxWIh; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dcSwxWIh"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dNKs02pw4z77H;
	Fri,  5 Dec 2025 19:38:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764959924;
	bh=xvCnwbAfZeqjFhcBWVHTXwb319U07fK++VKavBFwmkU=;
	h=From:To:Cc:Subject:Date:From;
	b=dcSwxWIhe4rZrJrUlNcZW8/FjB8yqX5snW9p3GOsrag4r4BUeKsdWb4lXfQ8WzaDg
	 /KJylzpEAd6xVkr2FB6I4vsILTPPcEw1MjrmUr+rfmuASJWDW1XCv2CuSdVYw7GGJL
	 +bmy6okDAydhl2/Epc9VApY1QwGLABS8CKt93uww=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dNKrz5Dt2zfrH;
	Fri,  5 Dec 2025 19:38:43 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v6.19-rc1
Date: Fri,  5 Dec 2025 19:38:25 +0100
Message-ID: <20251205183825.737361-1-mic@digikod.net>
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

This PR mainly fixes handling of disconnected directories and add new
tests.

Please pull these changes for v6.19-rc1 .  These commits merge cleanly
with your master branch.  The kernel changes have been tested in the
latest linux-next releases for some weeks (even if the last version
landed last week).

Test coverage for security/landlock is 92.1% of 1927 lines according to
LLVM 21, and it was 92.0% of 1923 lines before this PR.

A new syzkaller test has been developed for this specific case:
https://github.com/google/syzkaller/pull/6164

Regards,
 Mickaël

--
The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.19-rc1

for you to fetch changes up to 54f9baf537b0a091adad860ec92e3e18e0a0754c:

  selftests/landlock: Add disconnected leafs and branch test suites (2025-11-28 18:27:07 +0100)

----------------------------------------------------------------
Landlock update for v6.19-rc1

----------------------------------------------------------------
Matthieu Buffet (1):
      selftests/landlock: Fix makefile header list

Mickaël Salaün (3):
      landlock: Fix handling of disconnected directories
      landlock: Improve variable scope
      selftests/landlock: Add disconnected leafs and branch test suites

Tingmao Wang (3):
      landlock: Minor comments improvements
      landlock: Make docs in cred.h and domain.h visible
      selftests/landlock: Add tests for access through disconnected paths

 Documentation/security/landlock.rst        |   11 +-
 security/landlock/errata/abi-1.h           |   16 +
 security/landlock/fs.c                     |   46 +-
 security/landlock/ruleset.c                |   12 +-
 security/landlock/ruleset.h                |    2 +-
 tools/testing/selftests/landlock/Makefile  |    2 +-
 tools/testing/selftests/landlock/fs_test.c | 1474 +++++++++++++++++++++++++++-
 7 files changed, 1536 insertions(+), 27 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

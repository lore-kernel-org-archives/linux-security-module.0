Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C734F27F
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2026 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232956; cv=none; b=URafqbb8SmEsNX9yWIwlewShLt+P6lblsqXyZAVvVFeg7JToREIVx5cI7WZ6iEGUmLjjrjFTkSkbVGe04UIb+v6FZIOfwUlrv2VmMcz1Cv88v8/a0u9aMUNaKDEBe/rG2N/I54iIkHzUXgsnBwZMBxlQ62vUnq8/zWgprcl3Tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232956; c=relaxed/simple;
	bh=aQuWjyis+J+Jg7m9yNcqg1aEpYDdwrOOAXXvJ+75kl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIKpNKqI8t0SzrbuW5y7acKOzHG4Tw0Tw5C6x8LvY3YQKEeV0il8sbHF/IKcp58uMcGd5cDYCnvBZ1VcOYEOdyFz746Vsf+w1MtoSjnunjFvEl5t7FWR/H1fWAXu/xhDlCfXtmG+l8w9Sf2ZR5xabm49J6z6edL6ryLdc44Furg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VZZqVEAu; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VZZqVEAu"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h1P3X3Pr6zv9b;
	Thu, 16 Jul 2026 21:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784231880;
	bh=bb4hsiQvm+ShiYKxWJHrXUKE3lufWnxhz/WVJ4TuuyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VZZqVEAuw7CLP8C1CQfgorKeuQnHoncK+XWv2PCWuXrQkqZcfTRalvtfPcTmel8kY
	 /nC4r40Oqt9eyrAuqcwrPxMEj04iHvyUPhvQSl+5ma3t0ZW+1c9Chx/M5ikqgDWESs
	 KZAf7HWhXe8uTv0+I2NXTyV/45lfDPiYws9iIhPg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h1P3W4bBBzCV8;
	Thu, 16 Jul 2026 21:57:59 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthieu Buffet <matthieu@buffet.re>,
	Thomas Huth <thuth@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v7.2-rc4
Date: Thu, 16 Jul 2026 21:57:52 +0200
Message-ID: <20260716195752.2326332-1-mic@digikod.net>
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

This PR fixes TCP Fast Open support, specific test environments, and doc
warnings.

Please pull these changes for v7.2-rc4 .  These commits merge cleanly
with your master branch.  Most kernel changes have been tested in the
latest linux-next releases for some weeks.

Test coverage for security/landlock is 91.8% of 2357 lines according to
LLVM 22, and it was 91.7% of 2351 lines before this PR.

Regards,
 Mickaël

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.2-rc4

for you to fetch changes up to 5ab1dc6d110db6bee167a32fd94c53ea0e7ad6d2:

  selftests/landlock: Skip scoped_signal subtest with MSG_OOB if not available (2026-07-10 12:59:11 +0200)

----------------------------------------------------------------
Landlock fix for v7.2-rc4

----------------------------------------------------------------
Matthieu Buffet (2):
      landlock: Fix TCP Fast Open connection bypass
      selftests/landlock: Add test for TCP fast open

Mickaël Salaün (2):
      landlock: Fix kernel-doc for the nested quiet layer flag
      landlock: Update formatting

Thomas Huth (2):
      selftests/landlock: Fix screwed up pointers in the scoped_signal_test
      selftests/landlock: Skip scoped_signal subtest with MSG_OOB if not available

 security/landlock/net.c                            |  8 ++
 security/landlock/ruleset.h                        |  4 +-
 security/landlock/task.c                           |  9 +-
 tools/testing/selftests/landlock/net_test.c        | 97 ++++++++++++++++++++++
 .../selftests/landlock/scoped_signal_test.c        | 67 ++++++++++-----
 5 files changed, 154 insertions(+), 31 deletions(-)

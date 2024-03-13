Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545025810A
	for <linux-security-module@vger.kernel.org>; Wed, 13 Mar 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352407; cv=none; b=C4ZPhSFUbZGXAuDxCVvr1rWnHQwK7GGlr1i2fqzanAxWS7KEgblpCpWsybTngFKONsZCH7kh1bZ9B+iQ8Edj8rNg/Bn8MkN4C714PlBq+nzmtq3vdmgvZgY4+29sTQrHnoy5KceG+VxjVVPMC1k1k3FOZ/SmR4zSxUi5Jjnlgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352407; c=relaxed/simple;
	bh=cjAAAgrdcj01UDL3qSNxp3FlfnIKOm6Fuw930OMcsTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FGcg9ZpoBW8Sd7n7wi82fuTu5LPjW9IjS4V7tYYqbfiE4HW3eNgcqk3/ot1R3CNaSo9UTvlyEHcKEYaeyaBzRg3vgcKMjdQSC36tBcoVnCV/iIp2hrzKImQ3g5PUtKWHR67ESOKjFfCHIBCxARHnDzkfm6uL0vpd/wZyFeF9EGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EvlyIkRZ; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EvlyIkRZ"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tvym66BGjzMq1pr;
	Wed, 13 Mar 2024 18:53:10 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tvym62qPPzMpnPs;
	Wed, 13 Mar 2024 18:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710352390;
	bh=cjAAAgrdcj01UDL3qSNxp3FlfnIKOm6Fuw930OMcsTo=;
	h=From:To:Cc:Subject:Date:From;
	b=EvlyIkRZp0XmRSS2jfT7iBc8+VUARDsBxMOB+pPAstXzYQVFKy377Z2lUOMKlhO0w
	 wmROy8+266HoGQV3IW6CBHOyym3SrIdVJKMK+kUstbGHs1yYBJ1xFiz8N+ZpQXFzoz
	 A854nEWkehI3sMO+h/N8VClZE9BySepTzw72TZVc=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.9
Date: Wed, 13 Mar 2024 18:53:07 +0100
Message-ID: <20240313175307.714251-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR brings some miscellaneous improvements, including new KUnit tests,
extended documentation and boot help, and some cosmetic cleanups.

Additional test changes already went through the net tree.

Please pull these changes for v6.9-rc1.  This commit merged cleanly with
your master branch.  The kernel code has been tested in the latest
linux-next releases for a few weeks.

Regards,
 Mickaël

--
The following changes since commit d9818b3e906a0ee1ab02ea79e74a2f755fc5461a:

  landlock: Fix asymmetric private inodes referring (2024-02-26 18:23:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.9-rc1

for you to fetch changes up to a17c60e533f5cd832e77e0d194e2e0bb663371b6:

  samples/landlock: Don't error out if a file path cannot be opened (2024-03-08 18:22:18 +0100)

----------------------------------------------------------------
Landlock updates for v6.9-rc1

----------------------------------------------------------------
Mickaël Salaün (8):
      selftests/landlock: Clean up error logs related to capabilities
      landlock: Add support for KUnit tests
      landlock: Extend documentation for kernel support
      landlock: Warn once if a Landlock action is requested while disabled
      landlock: Simplify current_check_access_socket()
      landlock: Rename "ptrace" files to "task"
      landlock: Use f_cred in security_file_open() hook
      samples/landlock: Don't error out if a file path cannot be opened

 Documentation/userspace-api/landlock.rst     |  59 ++++++-
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/.kunitconfig               |   4 +
 security/landlock/Kconfig                    |  15 ++
 security/landlock/Makefile                   |   2 +-
 security/landlock/common.h                   |   2 +
 security/landlock/fs.c                       | 252 ++++++++++++++++++++++++++-
 security/landlock/net.c                      |   7 +-
 security/landlock/setup.c                    |   4 +-
 security/landlock/syscalls.c                 |  18 +-
 security/landlock/{ptrace.c => task.c}       |   4 +-
 security/landlock/{ptrace.h => task.h}       |   8 +-
 tools/testing/kunit/configs/all_tests.config |   1 +
 tools/testing/selftests/landlock/common.h    |  39 +----
 14 files changed, 363 insertions(+), 65 deletions(-)
 create mode 100644 security/landlock/.kunitconfig
 rename security/landlock/{ptrace.c => task.c} (98%)
 rename security/landlock/{ptrace.h => task.h} (52%)

Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C42D3734
	for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437328; cv=none; b=q91d/4XQ1tyNKo2Va4TDeuVDu1fFEGsEMDm854pSOW0LKuspLq0XTWhdRUfFdj2GyzKcxwanGR07I3tkV8bm+z2+DIXgwz60f65UdLcipF7FW1qcBfjTaxxNuYSvZmdz3Xz7UZvwaoeZCTrJc3Pukz9huZtR0Awf13nw6noWwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437328; c=relaxed/simple;
	bh=MtAZhDajdFu9X9ay94z/QXUgEskUZkD9RToy5eA0J/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXfSNJumFr5QlGSKsnqqMBt87v+F0A8A8lA8aoVKTjU/In7aViFslOQRuAwDqMm0AuOeENLXSjE9oxbnKGYQIU7Eu06gHVs8U5/xaaOSqDPEmg42kV036KkUjjGwbPAAo+4dyGbdHcRVpi6SCgd1g7nwdFTRcizByO+TqQB73Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VqoZY45W; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VqoZY45W"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bpNXM6NtyzJ10;
	Fri, 25 Jul 2025 11:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753437315;
	bh=sEHd5bRXK6QrLxZdY/xI6qozTbLeIllra8WMp0vMoOk=;
	h=From:To:Cc:Subject:Date:From;
	b=VqoZY45WI97RTfjZsd1TlwdWLr2vSy1SEC5C0VbappwAK9/Jyye9n5zbwf4Ip1ud0
	 8t0mpD5NvcwGOU4xU5VdmeBHGxMQHM1ri2Z3d+o0qtOc1AdIcKbORqGMtOgn5UW/5e
	 usCpQQjOMgt4UCC0HGtrOMscgKWmWsdiV13cBnTo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bpNXL6z9CzGw0;
	Fri, 25 Jul 2025 11:55:14 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Brahmajit Das <listout@listout.xyz>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock update for v6.17-rc1
Date: Fri, 25 Jul 2025 11:55:11 +0200
Message-ID: <20250725095511.446960-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Linus,

This PR fixes test issues, improves build compatibility, and adds new tests.

Please pull these changes for v6.17-rc1 .  These commits merge cleanly
with your master branch.  They have been been tested in the latest
linux-next releases.

Test coverage for security/landlock is unchanged (with Kselftest).

Regards,
 Mickaël

--
The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.17-rc1

for you to fetch changes up to 6803b6ebb8164c1d306600f8836a39b6fceffeec:

  landlock: Fix cosmetic change (2025-07-19 12:44:16 +0200)

----------------------------------------------------------------
Landlock update for v6.17-rc1

----------------------------------------------------------------
Brahmajit Das (1):
      samples/landlock: Fix building on musl libc

Mickaël Salaün (3):
      selftests/landlock: Fix readlink check
      selftests/landlock: Add test to check rule tied to covered mount point
      landlock: Fix cosmetic change

Song Liu (1):
      selftests/landlock: Fix build of audit_test

Tingmao Wang (1):
      landlock: Fix warning from KUnit tests

 samples/landlock/sandboxer.c                  |  5 +-
 security/landlock/fs.c                        |  1 +
 security/landlock/id.c                        | 69 ++++++++++++++++-----------
 tools/testing/selftests/landlock/audit.h      |  7 +--
 tools/testing/selftests/landlock/audit_test.c |  1 +
 tools/testing/selftests/landlock/fs_test.c    | 40 ++++++++++++++++
 6 files changed, 92 insertions(+), 31 deletions(-)

Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991125A646
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332577; cv=none; b=UwKSZCK7V0ujzuj2DFGQvteRnv9zUFz4UsznwD2tN/2mefpuXFGsEz+jI8rktDEbpyAU7IBulirjqq9vQwWzeENXHkzF+WuS4csKERHC3Zkh+tXDKAjGqCHHzFNUQMGk9bNroKEEdKP5uaIrjjlHbYAHWkbM1v8A1KEoy/ecUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332577; c=relaxed/simple;
	bh=tFNPapdRFFjooc9r+SlXsVOmgwTmmL5/lfcJfv+Y1p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QBQ7Ahb/iW56CyjjqL6NpQTYSyc7ReKlEsdpEiaM5C/F8E7yIx5uc4lvCGTM/KPe4dEemlg1E2VCdJwCPXwVbhhCZmnkgMN7u9hmkq55zh3Nwvu1EcPeoz69HyvslYkdeiGmB9Byrg8wckP76eJIIHjkYG9++JgNleDod6aI76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=t5IZi5eI; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="t5IZi5eI"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZyyTN5X8kzdJJ;
	Thu, 15 May 2025 19:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747331528;
	bh=0b6gT6hVmnbZkcwayzSS4iB48pHH34w9zFzT0fBtOvg=;
	h=From:To:Cc:Subject:Date:From;
	b=t5IZi5eIILhTAamUm4UumViSRMN0H2KXgpRVMFjV0nJbU1mfCLT4xpM1cdTHb7K4y
	 Ruv8QcF61+N2L/cgEUuzJIQNWblKVxkx0t9JMPJYsF5SQsmHyKDnl1dvtmN+F1bjQI
	 Lo394FqIbFzbBKY9nvMcIAJaCqUEIEZH+vlT1Ej8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZyyTN1lz0zgsP;
	Thu, 15 May 2025 19:52:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.15-rc7
Date: Thu, 15 May 2025 19:52:03 +0200
Message-ID: <20250515175203.2434864-1-mic@digikod.net>
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

This PR fixes a KUnit issue, simplifies code, and adds new tests.

Please pull these changes for v6.15-rc7 .  These commits merge cleanly
with your master branch.  They have been been tested in the latest
linux-next releases.

Test coverage for security/landlock is unchanged (with Kselftest).

Regards,
 Mickaël

--
The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.15-rc7

for you to fetch changes up to 3039ed432745f8fdf5cbb43fdc60b2e1aad624c1:

  landlock: Improve bit operations in audit code (2025-05-12 11:38:53 +0200)

----------------------------------------------------------------
Landlock fix for v6.15-rc7

----------------------------------------------------------------
Mickaël Salaün (2):
      landlock: Remove KUnit test that triggers a warning
      landlock: Improve bit operations in audit code

 security/landlock/audit.c    |  4 ++--
 security/landlock/id.c       | 33 +++++++++++++++++++++++++++++++--
 security/landlock/syscalls.c |  3 ++-
 3 files changed, 35 insertions(+), 5 deletions(-)

Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3935DA44
	for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2026 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547214; cv=none; b=YGlEY9QMVUI9AZFSNcbCilHLcPLY8kfX+BXa/JSVKinA5X/MenDHLccbrx1FFLVhogckTO2W+QJhd+91d0tI27jSc30I3Z6rGaUb4qy7WSuMHro5nEknKZ5A5wnkmABrycDvalADtW6MgOgP4sJQL0q2Az76FMciAv/wvnNRpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547214; c=relaxed/simple;
	bh=RBDgKeJmtSTTzmODKktEI5dymm+hjpJPWFRBxdB+ToI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Or+4yfj4pkCl0mXfuiPM60sM0UwVZlDNj9T7MLNKPeiW+5sO0/aqAD1kzSWqyjA0a+Wdy0OzN9ZHUAC/btdqi8jprcpbCNmIYzXSMao2LHIkiq5vBe4CznYMOys0Vk8K995k6IP6YWPRcrGy8A7PAAcPaknNc7RHv4bXjXItbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=J+if2OXZ; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="J+if2OXZ"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fhW1l1NrwzNgp;
	Thu, 26 Mar 2026 18:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1774546059;
	bh=3FXqP+d5x1g/5Xgp6/OPTric7u1x4n2o9ZqDc9UdWHY=;
	h=From:To:Cc:Subject:Date:From;
	b=J+if2OXZhPo+NUE1AAqYd6uDxyAq5Z8JieEOOmlKsXVnHsKa2s8oPGMT0uOh5U7v5
	 XJ/pjImC91JeyZMVEh2wCzCZpUf0/mm2/xALdoSM737SW8+2FuS2auWssUQNTOVlWB
	 jz24MGS4D3YrOymy8aEw1WrdQw+vOz14JiahRo68=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fhW1k2h4NzT06;
	Thu, 26 Mar 2026 18:27:38 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Dan Cojocaru <dan@dcdev.ro>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Panagiotis Ivory Vasilopoulos <git@n0toose.net>,
	Yihan Ding <dingyihan@uniontech.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v7.0-rc6
Date: Thu, 26 Mar 2026 18:27:27 +0100
Message-ID: <20260326172727.119094-1-mic@digikod.net>
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

This PR mainly fixes Landlock TSYNC issues related to interrupts and
unexpected task exit.  Other fixes touch documentation and sample, and a
new test extends coverage.

Please pull these changes for v7.0-rc6 .  These commits merge cleanly
with your master branch.  Kernel changes have been tested in the latest
linux-next releases for some weeks.

Test coverage for security/landlock is 91.0% of 2105 lines according to
LLVM 21, and it was (up to) 91.4% of 2093 lines before this PR.

syzkaller (also) reported the fixed issues:
- https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
- https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10

Regards,
 Mickaël

--
The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-7.0-rc6

for you to fetch changes up to a23811061a553c70c42de0e811b2ec15b2d54157:

  landlock: Expand restrict flags example for ABI version 8 (2026-03-24 20:55:55 +0100)

----------------------------------------------------------------
Landlock fix for v7.0-rc6

----------------------------------------------------------------
Günther Noack (1):
      samples/landlock: Bump ABI version to 8

Mickaël Salaün (4):
      landlock: Fix formatting
      landlock: Fully release unused TSYNC work entries
      landlock: Improve TSYNC types
      selftests/landlock: Test tsync interruption and cancellation paths

Panagiotis "Ivory" Vasilopoulos (1):
      landlock: Expand restrict flags example for ABI version 8

Yihan Ding (2):
      landlock: Serialize TSYNC thread restriction
      landlock: Clean up interrupted thread logic in TSYNC

 Documentation/userspace-api/landlock.rst      | 23 +++++--
 samples/landlock/sandboxer.c                  |  5 +-
 security/landlock/domain.c                    |  3 +-
 security/landlock/ruleset.c                   |  9 ++-
 security/landlock/tsync.c                     | 92 +++++++++++++++++++++------
 tools/testing/selftests/landlock/tsync_test.c | 91 +++++++++++++++++++++++++-
 6 files changed, 190 insertions(+), 33 deletions(-)

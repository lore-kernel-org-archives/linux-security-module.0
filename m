Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACD225DA
	for <linux-security-module@vger.kernel.org>; Fri, 31 May 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171545; cv=none; b=Z8RJ5XTVMLZ8HqiIRQNTmIlL/PL1WnsJyt2v8t6iGAuPumnHSsEo1IIEwCiLFKoh+lLwaLtQm04UsOI03845pLzfKUsn+ku0FRuXCuu4NO8rntaM/NI5Eqq7T2YPgKzU5N88YPsjuug1RyCN2ZdJLkmIcbEfr9msVEUUPbCkD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171545; c=relaxed/simple;
	bh=jMphLtJ1ajjONUHwdMfQkImvbdmMMRz8DvS2PZBC1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ldXxF3sMlKPSGzIXugyKtHGH+FOzO8gITYrvaZdSvAdoKrKfXQGlwrL41xypwGZY+cEIFg+GG9eny+X+aHFSIAzPuGUITil00JPwcO2CWx7nemsbbvyAjkw5zjQlLpp+KGAER0di/Gn82+Tz7qPQuW2smY8QI95sWXeif7Hnu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XpxlPg86; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XpxlPg86"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrS4q5Z1lz1WM;
	Fri, 31 May 2024 17:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1717170043;
	bh=j4+nbp4ODTAZgk4eMuAJTaPQPhKuOjoc5EjXd36hnA4=;
	h=From:To:Cc:Subject:Date:From;
	b=XpxlPg867rk6kWp5pkC+7M2c23z8uYSM2AN3yaalvLFuvlMCHvGjrGs4ugotxmmE+
	 7IyDArcdEgg1dTPWYq5ju6vKTl5WSSe0eoIXss4vf3m6T5fp4yw7DW799IVaNGCvtc
	 fSdV7graSZaMU4aM9mXSPPPc7K5Q5CLmZ9xC5RhU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrS4q27FFzZ0S;
	Fri, 31 May 2024 17:40:43 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.10-rc2
Date: Fri, 31 May 2024 17:40:34 +0200
Message-ID: <20240531154034.198316-1-mic@digikod.net>
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

This PR fixes a wrong path walk triggered by syzkaller.

Please pull these changes for v6.10-rc2.  This commit merged cleanly with your
master branch.  The kernel code has been tested in the latest linux-next
releases for two weeks, but I rebased it on v6.10-rc1 to fix a commit message
and properly test it again.

Regards,
 Mickaël

--
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc2

for you to fetch changes up to 0055f53aac80fd938bf7cdfad7ad414ca6c0e198:

  selftests/landlock: Add layout1.refer_mount_root (2024-05-31 16:41:54 +0200)

----------------------------------------------------------------
Landlock fix for v6.10-rc2

----------------------------------------------------------------
Mickaël Salaün (2):
      landlock: Fix d_parent walk
      selftests/landlock: Add layout1.refer_mount_root

 security/landlock/fs.c                     | 13 +++++++--
 tools/testing/selftests/landlock/fs_test.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E85145A13
	for <linux-security-module@vger.kernel.org>; Thu, 16 May 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866555; cv=none; b=krdXt3OU+601nvUdJcZG+MlME+vjPrVp03aF4/k6XjSuwo48/95ACf4Hz6pp1qo+rstYZQa4rjLCKqYXkZW5wIDleyBRHQ5Qxbs7/KYGIzgUdddDvaQQidc5vGdAo+2LJChCYYagbSegoGPBxCRVs7jpXvkUJp2eXG9drHu32JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866555; c=relaxed/simple;
	bh=B+YQIsWwKDS2kXk4dBcyryjLpZFGQQdjRWPllppP1HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3VVk1K3ewkFU3nxwcNvCenf5QYQ7rFyEDCCGvFek6tfoQmn3REYDPDp6GKl+NLlDIbtFGPRH4LYEfJylde4EnPtU+VpUqXuRGKrtOLdbKnCbmXf9VO5FIIdAFnHVCii8Px4Td/2r8EsAVmkAnqU/VX8FAoo9htqnYL0aL9FBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OIbMra9Y; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OIbMra9Y"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vg9pp3lDpzK21;
	Thu, 16 May 2024 15:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715865986;
	bh=r3mi6lzal3IHo9WDD7iyS0/n1GYGenLY2na/Gr2Y/iU=;
	h=From:To:Cc:Subject:Date:From;
	b=OIbMra9YBi61V+j1Qta2E0xgwjLiMVB1YL6K/fu/RN26n8aiw+vTL4IA8IaxVMDsw
	 fd+ZK4SQ/X7m3q2uuRD9e7yJF8MpWouhEl4uevz5jmXuhsBd+9G//kLYjOPFWHQUP/
	 7czlu7NjU6vzfXFLwEIH3vWxon3cml3j94vRVhPY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vg9pn4vFDzrbk;
	Thu, 16 May 2024 15:26:25 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.10
Date: Thu, 16 May 2024 15:26:24 +0200
Message-ID: <20240516132624.1536065-1-mic@digikod.net>
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

This PR mainly brings IOCTL control to Landlock, contributed by Günther Noack.
This also adds him as a Landlock reviewer, and fixes an issue in the sample.

Please pull these changes for v6.10-rc1.  This commit merged cleanly with your
master branch.  The kernel code has been tested in the latest linux-next
releases for a few weeks, but I rebased it on v6.9 to avoid a merge conflict
because of the recent Kselftest fixes.

syzkaller has also been patched to know about this new access right.

Regards,
 Mickaël

--
The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.10-rc1

for you to fetch changes up to 5bf9e57e634bd72a97b4b12c87186fc052a6a116:

  MAINTAINERS: Add Günther Noack as Landlock reviewer (2024-05-13 06:58:36 +0200)

----------------------------------------------------------------
Landlock updates for v6.10-rc1

----------------------------------------------------------------
Günther Noack (11):
      landlock: Add IOCTL access right for character and block devices
      selftests/landlock: Test IOCTL support
      selftests/landlock: Test IOCTL with memfds
      selftests/landlock: Test ioctl(2) and ftruncate(2) with open(O_PATH)
      selftests/landlock: Test IOCTLs on named pipes
      selftests/landlock: Check IOCTL restrictions for named UNIX domain sockets
      selftests/landlock: Exhaustive test for the IOCTL allow-list
      samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
      landlock: Document IOCTL support
      MAINTAINERS: Notify Landlock maintainers about changes to fs/ioctl.c
      fs/ioctl: Add a comment to keep the logic in sync with LSM policies

Ivanov Mikhail (1):
      samples/landlock: Fix incorrect free in populate_ruleset_net

Mickaël Salaün (1):
      MAINTAINERS: Add Günther Noack as Landlock reviewer

 Documentation/userspace-api/landlock.rst     |  78 ++++-
 MAINTAINERS                                  |   2 +
 fs/ioctl.c                                   |   3 +
 include/uapi/linux/landlock.h                |  38 ++-
 samples/landlock/sandboxer.c                 |  18 +-
 security/landlock/fs.c                       | 225 ++++++++++++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 487 ++++++++++++++++++++++++++-
 10 files changed, 811 insertions(+), 46 deletions(-)

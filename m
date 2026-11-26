Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697238;
	b=pi0W5kSMG+ACpHUAbErrCz6ccGvyy55P+GlXtohii4/KmgvmEJNOBsx22pq526LYUKdo
	 GCh1iET93f+0a+Fy228huTvbD9jP+fKEkom2Gaa2mX+8CMfBUNpeX0PJwuI4P6ab3Fo6v
	 lMDQvqxdLsRTjLzP4GvDIEjrifMG4Ne8bclaGP5mtGvk8ZAjTMeFwt2wc87gAXJLviW0s
	 6MScLCVkoyxiqUpRJiF7/Us20KQuWce7wAylLsdN1AhxFjxvnqsbUl7Fd9VMd58dKJJPX
	 i1iLRtFG5fqjv2+vfdwg1WoJlFJQ0DdmsRRqRz8lX7Pl7uABezlCqKwqns9Tmy5p/Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697238;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=cluy/CcFwS2tT3OPwmvOS7KZPjZ9l3T0QPb1BF/2Uw0=;
	b=rXmgP+ky4sCaxiIqQxd0DqXkBdEZ88MCVmKhmo1Eoz47yIZdxOJjuVNd66l29FRsl6dl
	 pn5IufQ8/7qYek6n0aVfPu3uY+YqFjkt54lz8LJmiDK2N/BvXYF185iAU5sDjSqpBvBWG
	 TkpjJp+XYGa0ZEa0Pc0VMnoVZ8v26X8L9lUgEMC1OzgZ9Pd9QV6nLGntMTN7WI4a31qYl
	 CacjCusF75ut1zgGqEosWNIoSNk2hiId3/EwkjuvVWVdvBY4N+ed/keGVgmVB5hiTVRoY
	 3u0ccfAeEWSDuFlBwJ2d8W4VpZBWrgm8J0yUqy5ZL1qwYpk/bMobDWHdOwo1sMqdEVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DYKJ65qM;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C67606A321;
	Thu, 26 Nov 2026 12:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C67606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DYKJ65qM
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cluy/CcFwS2tT3OPwmvOS7KZPjZ9l3T0QPb1BF/2Uw0=;
	b=DYKJ65qMjTL/UMkV1AJWhRBp0yEEqeoPOZefPQi+XMmHc2nqHAPsYd9p6q9TZPPALs60ZSAGj
	e75cggWH7wYKUnZFhZNhdvOA/w13QzZ3+39tzu5lkF68fT/EBSD/Sl1c/z32Mp1MmyB09L7sah6
	FUFigpUAfmM4TYXq1TgMwHo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jZxB85cFDz12LDD;
	Thu, 26 Nov 2026 20:46:24 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 48A3D20333;
	Thu, 26 Nov 2026 20:47:12 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:10 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 0/8] lockdown: fix the securityfs interface and add tests
Date: Thu, 26 Nov 2026 21:13:07 +0800
Message-ID: <20261126131315.1256553-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100010.china.huawei.com (7.152.184.41)

The lockdown LSM provides /sys/kernel/security/lockdown, but the file is
neither documented nor covered by a selftest.  While reviewing the
interface, we also found a Kconfig bug and a few accumulated cleanups.

The series is organized as follows:

  - patches 1-2 are small cleanups in lockdown_write(): stop scanning
    after the matching level, and drop an update to a length variable
    that is not used afterwards.
  - patch 3 makes the LSM select SECURITYFS.  Without it, a kernel built
    with CONFIG_SECURITYFS=n logs "failed LSM lockdown core initcall
with
    errno -19" and does not create the file that the
    LOCK_DOWN_KERNEL_FORCE_NONE help text points users at.
  - patch 4 removes LSM_AUDIT_DATA_LOCKDOWN and its formatting code,
    which became dead when the SELinux lockdown implementation was
    removed by commit f5d0e5e9d72d.
  - patch 5 drops an unused include and moves lockdown_reasons[] next to
    its only user.
  - patch 6 replaces sprintf() with scnprintf() and sizes the status
    buffer for the string it holds, whose length is the same whichever
    level is active: all level labels with their trailing spaces, the
    brackets around the active one, and the terminating NUL.
  - patch 7 documents the ABI and adds the new file to the LOCKDOWN
    SECURITY MODULE entry in MAINTAINERS.
  - patch 8 adds a kselftest covering the read format, invalid levels,
    the rejection of the current or a lower level, and an upgrade to the
    next level.

The only functional change is patch 3; the rest are cleanups,
documentation, or test coverage.

Changes since v2:

  - The scnprintf() patch sizes the status buffer from the label lengths
    instead of keeping temp[80] with a BUILD_BUG_ON() (Serge E. Hallyn).
  - The selftest read_file() helper reads up to size bytes again and
    rejects a completely filled buffer, so read_sysfs_lsms() keeps
    failing when its buffer is too small (Nicolas Bouchinet).
  - The selftest read, root and writable checks moved into a
    FIXTURE_SETUP, and the upgrade test now runs before the tests that
    expect an already locked down kernel, so they never run at the none
    level (Nicolas Bouchinet).
  - The ABI documentation now mentions the legacy "security=" kernel
    parameter as another way to order in the lockdown LSM, and now also
    documents the 0644 file mode, so an unprivileged writer can tell
    the EACCES at open() time apart from the EPERM and EINVAL that
    lockdown_write() itself returns.
  - Clarified the changelogs of patches 1-3: the break in
    lockdown_write() is now described as leaving the loop instead of
    returning early, the useless decrement patch gained a commit
    description, and the SECURITYFS patch now points at the
    LOCK_DOWN_KERNEL_FORCE_NONE help text that references the file.

Cai Xinchen (7):
  lockdown: Add break in lockdown_write
  lockdown: select SECURITYFS
  lsm: remove unused lockdown audit data
  lockdown: drop an unused include and move lockdown_reasons
  lockdown: bound the status string with scnprintf
  Documentation/ABI: document the lockdown securityfs file
  selftests/lsm: add lockdown securityfs test

Kalevi Kolttonen (1):
  lockdown: remove useless decrement operation

 Documentation/ABI/testing/securityfs-lockdown |  47 +++++
 MAINTAINERS                                   |   1 +
 include/linux/lsm_audit.h                     |   2 -
 include/linux/security.h                      |   2 -
 security/lockdown/Kconfig                     |   1 +
 security/lockdown/lockdown.c                  |  73 ++++++-
 security/lsm_audit.c                          |   4 -
 security/security.c                           |  40 ----
 tools/testing/selftests/lsm/Makefile          |   8 +
 tools/testing/selftests/lsm/common.c          |  47 ++++-
 tools/testing/selftests/lsm/common.h          |   2 +
 tools/testing/selftests/lsm/config            |   1 +
 tools/testing/selftests/lsm/lockdown_test.c   | 191 ++++++++++++++++++
 13 files changed, 354 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/ABI/testing/securityfs-lockdown
 create mode 100644 tools/testing/selftests/lsm/lockdown_test.c

-- 
2.18.0.huawei.25


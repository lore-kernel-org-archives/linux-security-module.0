Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315356;
	b=uPwqAq4ZePNZcLVA1ilYtRdtXPi8DKAn3IAofGYNBbCeuwVI5c4BlQJ9QrP2IxuTjXZv
	 WQGIu2xx8BDW/Ihn8vnNJCAonT/Jz6XVZe3yqY6FZve99ebS2Rp00Eg01Pb5crlsPQkQw
	 BiuRgZqiriWshhy86XsVapN0PVX44lKkYhU3lURSXUX73cFvLzfoyi+AgxJ/VKQNi5QB6
	 bJbXjq/ViZG5NT3DcpvRcdvmCjHf+08Egqxrn1n7Pr/OL+e679TO07eGghjwWga7Vd7wR
	 1PM3tukC064uPqQDznJrcvyF2BvybwFOYl+FxAhP+T0mWhJD9MYa3VVK7sODJW4J7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315356;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=T2dWyS2c9HCj9HQ2w6QNE6Xzgrb9OoKtERWi7W6SZbU=;
	b=SVnektij1thQUOQe00/wjO/qPevMpvJD1XlhNzV/sZs2pGQKEN95/uptmPmYwfiYOCtH
	 c394n4Oo8SISKF1xB5q70WeM+WY5F5rujNSDfs68Ks4S4hQvQQVj1sVSKcU8+GqSGhSaw
	 Ctfjzw3DZIxRtcTW1TGC/2x/VE0SWw0O4FGlQ1DsWvOLC/zi4cKbzm02fS4Lkb370kc6F
	 vQxc0SuvR/mAJLSLLNjz7aw58GUo+lX6hMzJezWSRovbVK3YJLgwArotYl/BqJsYkDdh/
	 HWSsSqqeAyXSp/1fEjz5pP9TFhwYomXs1Ji8uuywAOSd/4Xc5vjl2dCRmj0yLRPBXHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=nySpbsOQ;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EF606A33B;
	Tue, 10 Nov 2026 12:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4EF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=nySpbsOQ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T2dWyS2c9HCj9HQ2w6QNE6Xzgrb9OoKtERWi7W6SZbU=;
	b=nySpbsOQT9cafudOrzG91TTObxit+LIYM3JtT8zs6HTB47Uea2vFyCjBDRpHY6hXAzsNDl7nD
	CvBLtODiu/qKVYJQB4T/DgE5WL3crgHPipGmLaiB0aRLi4UVFIM+j72y44Bk4UTQxc3XaGeFwww
	zhnja4Vn7PnYedeFRcK2Tp0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jP6881zV5zLlVP;
	Tue, 10 Nov 2026 20:55:36 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E90CC4048B;
	Tue, 10 Nov 2026 20:55:50 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:49 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 0/8] lockdown: fix the securityfs interface and add tests
Date: Tue, 10 Nov 2026 21:28:10 +0800
Message-ID: <20261110132818.2231593-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100010.china.huawei.com (7.152.184.41)

The lockdown LSM provides /sys/kernel/security/lockdown, but the file is
neither documented nor covered by a selftest.  While reviewing the
interface, we also found a Kconfig bug and a few accumulated cleanups.

The series is organized as follows:

  - patches 1-2 are small cleanups in lockdown_write(): stop scanning
    after the matching level, and drop an update to a length variable
    that is not used afterwards.
  - patch 3 makes the LSM select SECURITYFS.  Without it, a kernel built
    with CONFIG_SECURITYFS=n logs "failed LSM lockdown core initcall with
    errno -19" and does not create the file advertised by the Kconfig
    help text.
  - patch 4 removes LSM_AUDIT_DATA_LOCKDOWN and its formatting code,
    which became dead when the SELinux lockdown implementation was
    removed by commit f5d0e5e9d72d.
  - patch 5 drops an unused include and moves lockdown_reasons[] next to
    its only user.
  - patch 6 replaces sprintf() with scnprintf() so that the status
    buffer
    is bounded explicitly if more levels are added later, and adds a
    BUILD_BUG_ON() that checks at compile time that all level labels,
    their separators, and the terminating NUL still fit.
  - patch 7 documents the ABI and adds the new file to the LOCKDOWN
    SECURITY MODULE entry in MAINTAINERS.
  - patch 8 adds a kselftest covering the read format, invalid levels,
    the rejection of the current or a lower level, and an upgrade to the
    next level.

The only functional change is patch 3; the rest are cleanups,
documentation, or test coverage.

Changes since v1:

  - The scnprintf()/BUILD_BUG_ON() patch now comes after the audit and
    cleanup patches.
  - The lockdown_reasons move patch has a corrected commit message: the
    enum comment already pointed at security/lockdown/lockdown.c.
  - The ABI documentation now mentions CONFIG_LSM as a way to order
    lockdown in, and states that the FORCE_* options only take effect
    when the lockdown LSM is active.
  - The selftest patch moves the read-format string checks before the
    active-level checks, corrects the no-downgrade skip message, and adds
    an upgrade test.  Because that test irreversibly raises the lockdown
    level, the test is kept out of the default run
    (TEST_GEN_PROGS_EXTENDED and run_lockdown_test),
    CONFIG_SECURITY_LOCKDOWN_LSM is enabled in the selftest config
    fragment, and non-ENOENT read failures now fail instead of being
    skipped.
  - The break, decrement, SECURITYFS, and audit patches are unchanged.

The upgrade test irreversibly raises the lockdown level, so lockdown_test
is built but not run by default.  Use "make run_lockdown_test" to run it
explicitly, preferably on a disposable test system.  The shared
selftests/lsm config fragment now enables CONFIG_SECURITY_LOCKDOWN_LSM so
that the test has something to exercise.

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

 Documentation/ABI/testing/securityfs-lockdown |  43 ++++
 MAINTAINERS                                   |   1 +
 include/linux/lsm_audit.h                     |   2 -
 include/linux/security.h                      |   2 -
 security/lockdown/Kconfig                     |   1 +
 security/lockdown/lockdown.c                  |  70 +++++-
 security/lsm_audit.c                          |   4 -
 security/security.c                           |  40 ---
 tools/testing/selftests/lsm/Makefile          |   8 +
 tools/testing/selftests/lsm/common.c          |  35 ++-
 tools/testing/selftests/lsm/common.h          |   2 +
 tools/testing/selftests/lsm/config            |   1 +
 tools/testing/selftests/lsm/lockdown_test.c   | 230 ++++++++++++++++++
 13 files changed, 375 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/ABI/testing/securityfs-lockdown
 create mode 100644 tools/testing/selftests/lsm/lockdown_test.c

-- 
2.18.0.huawei.25


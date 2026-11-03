Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692290;
	b=hrm/SML5oPNUXTNY8pANNWesFshiEnI5Aok/PMpxa9BBOJSs5jo1IQaUwzWfSJp6AO5f
	 hHZUtcr8DLPwRF83MHQzW2LFSMOFZwQa62G/hyhxaTDer0jDibDfejw4OBy0s95hb+HmP
	 89H+b99IhRwt4fYu6fysUW20OYje4A2WaEyuE1mskyYpZnxSmLWEYdsWdq9Idbl1OMC0g
	 7/OITfacXZcN2Kc7wodd0CF19VuF8Pv5twSOcz5r2mUDytuOBzZGOXyCmeRtdtrzLN9Zk
	 LiJc5gg7WeJBKrUM9+KLYQuMRHI2co3Ni0TRn1aQrhz0jU17KrPGEhqk9VNFVB8B4yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692290;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=almS/lxwsX1nbVQlrW97UQts5i8lbc/w3OcWMH1ybhc=;
	b=wC0eDTPIbj95FO0eYenShDmGMJgh9rNf/yd/wgsk3vWH+HC/j5KAHL+pRgTykSMD4rBX
	 N5jwZkAMkVdsCDGSlXokLdoS4jjrgViZqS37d3WjhEAKYCrrHf51OecuU5YxLOzzH3e6l
	 Rl1jFMznMkGIGcK6k5AjaDsW6DuYRbGRAU2pFYf9Xh/q8lIScNaS3yFJzQ0qeIBy+8057
	 MMShS8w89mS9/J5k7BCMfg6rJ9FYzCGHQNRioOC8avbBQwljoIGrxamPFixk5m4joOd4t
	 /QET6c4fCOQXmyI9+dMCTID/d8NadTJt9TGvKfaXuwXBFUomZASQo+VlRrnndA03KWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SY49CY+k;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0F606A329;
	Tue,  3 Nov 2026 07:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09E0F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SY49CY+k
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=almS/lxwsX1nbVQlrW97UQts5i8lbc/w3OcWMH1ybhc=;
	b=SY49CY+kIlNjA8Zseno2CgYuP2EJ3MaYskPuzKG97bLCcz2Wfo6gc6da1gRwgsDiT+Fh5Jc8m
	9NDwRmj94q0YzyTGsLbtXFAdOVV6ssGyNqlei7lPCdekBbr6gZ4eDD8P/xoSIHXUc1DNG/cVwaP
	773x4tL/fSnThZnRKCohMvA=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jJgk31lZ3z1cyqr;
	Tue,  3 Nov 2026 15:51:07 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id AB82140565;
	Tue,  3 Nov 2026 15:51:17 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:16 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 0/9] lockdown: fix the securityfs interface and add tests 
Date: Tue, 3 Nov 2026 16:24:12 +0800
Message-ID: <20261103082421.3033195-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

The lockdown LSM exposes /sys/kernel/security/lockdown, but the file is
not documented and has no selftest.  While looking at the interface we
also found a configuration bug and several accumulated cleanups.

The series is organized as follows:

  - patches 1-2 are small cleanups in lockdown_write(): stop scanning
    after the matching level and drop an update to a length variable
    that is not used afterwards.
  - patch 3 replaces sprintf() with scnprintf() so that the status
    buffer is bounded explicitly if more levels are added later.
  - patch 4 makes the LSM select SECURITYFS.  Without it, a kernel
    built with CONFIG_SECURITYFS=n logs "failed LSM lockdown core
    initcall with errno -19" and does not create the file advertised
    by the Kconfig help text.
  - patch 5 removes LSM_AUDIT_DATA_LOCKDOWN and its formatting code,
    which became dead when the SELinux lockdown implementation was
    removed by commit f5d0e5e9d72d.
  - patches 6-7 drop an unused include, simplify the securityfs
    registration, and move lockdown_reasons[] next to its only user.
  - patch 8 documents the ABI and adds the new file to the LOCKDOWN
    SECURITY MODULE entry in MAINTAINERS.
  - patch 9 adds a kselftest covering the read format, invalid levels,
    and the rejection of the current or a lower level.

The only functional change is patch 4; the rest are cleanups,
documentation, or test coverage.  The selftest never escalates
lockdown on the machine where it runs.

Cai Xinchen (8):
  lockdown: Add break in lockdown_write
  lockdown: bound the status string with scnprintf
  lockdown: select SECURITYFS
  lsm: remove unused lockdown audit data
  lockdown: drop an unused include and simplify secfs init
  lockdown: move lockdown_reasons next to its only user
  Documentation/ABI: document the lockdown securityfs file
  selftests/lsm: add lockdown securityfs test

Kalevi Kolttonen (1):
  lockdown: remove useless decrement operation

 Documentation/ABI/testing/securityfs-lockdown |  41 ++++
 MAINTAINERS                                   |   1 +
 include/linux/lsm_audit.h                     |   2 -
 include/linux/security.h                      |   2 -
 security/lockdown/Kconfig                     |   1 +
 security/lockdown/lockdown.c                  |  63 +++++--
 security/lsm_audit.c                          |   4 -
 security/security.c                           |  40 ----
 tools/testing/selftests/lsm/Makefile          |   3 +-
 tools/testing/selftests/lsm/common.c          |  35 +++-
 tools/testing/selftests/lsm/common.h          |   2 +
 tools/testing/selftests/lsm/lockdown_test.c   | 176 ++++++++++++++++++
 12 files changed, 300 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/ABI/testing/securityfs-lockdown
 create mode 100644 tools/testing/selftests/lsm/lockdown_test.c

-- 
2.18.0.huawei.25


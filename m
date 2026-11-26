Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697249;
	b=VYmJlFGsP552ghZLgXOqZoZyGUUaNl2GSXYekanq4eFXp96oUL7Tt1DrlP10q4m1iw3l
	 De9tlb+6rGmfoqClvudfskM/W0BMTMrnDs/pfdVH6buxceam40UkhBDWYcpL+EigyZ6qo
	 efeA8yw6ijMsnaey4pSnlB4DmBucnqOEeuM9EbidhGI4RANZfp6fkhuFkTr3xWnkodR8n
	 Ozs8h1c5gmU/+ElOa6r8aLQk6U0V+qRjKtbmWMQRUAYbPtOOW+PUrLmOph+0Yqg6O9wlE
	 9vy1yI+QxFmwldn07Z32uNWvIiri+Pyjkh1Je53Pe5BBDukTWiLTMclqPFqLc8UlbLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697249;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=ClGX2875WbyQG7rz6Sx/tv42WHG5IdJpsq88ZZE5Thc=;
	b=hRKC6SsGiyewB+TFMMH/nGqVtpl1Rguq2B8+HCcMvwD40DOHlGMrtCiHJQUc3x8YE4xo
	 eYbffOS8QvbLytkLOD/pTR4Wctpz3FkytTwbjdtIZ9VhhnKZt5J4Qzp896T2Xh+w/d9eR
	 Najniyn/hcg0KOl1jkf8Y9uWL01leFCpp1g4yz6I4fvSxU1ieanpzxkGQuOvFEreUNYRL
	 vjUrdB36DUfHU86NftITNSI1LUfaFE8bIm/aDv/Uccg/wm7IhgfoIPhJxDANE5fMsC+/w
	 FSHINg9VxEmRVNmSD7KRFTKHriYKcHE/pVVXTshHz/ODkcFOkHkHziglqaN4vtsJU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NtzDUemK;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C51606A329;
	Thu, 26 Nov 2026 12:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C51606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NtzDUemK
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ClGX2875WbyQG7rz6Sx/tv42WHG5IdJpsq88ZZE5Thc=;
	b=NtzDUemK7yTU8ttfULBUgkfZMv26YXBOzWaYnQmz50NUV4LU+31HK2GDuA+YOTiHd2Ac4kd94
	r2Ygjh3iSOy00OxlizOZ8ekSVd2JjQquI816XcpsxYzH3JbrQgtr6LPwsc0WBjbigC/L4o+bv3+
	5tTcNcqdd7kCadv2xhuwKLs=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jZx9w4LhpzcZxn;
	Thu, 26 Nov 2026 20:46:12 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 24DFB4056D;
	Thu, 26 Nov 2026 20:47:20 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:47:18 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v3 7/8] Documentation/ABI: document the lockdown securityfs file
Date: Thu, 26 Nov 2026 21:13:14 +0800
Message-ID: <20261126131315.1256553-8-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261126131315.1256553-1-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
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

The /sys/kernel/security/lockdown file has existed since v5.4 but was
never documented.  The rest of this series fixes the interface and adds
a selftest for it, so document it now: the levels it reports, how the
active level is marked, when the file is present, and the write
semantics (escalation only, EPERM for the current or a lower level,
EINVAL for an unknown level).

Also add the new ABI file to the LOCKDOWN SECURITY MODULE entry in
MAINTAINERS.

Reviewed-by: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 Documentation/ABI/testing/securityfs-lockdown | 47 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-lockdown

diff --git a/Documentation/ABI/testing/securityfs-lockdown b/Documentation/ABI/testing/securityfs-lockdown
new file mode 100644
index 000000000000..74eb850519e3
--- /dev/null
+++ b/Documentation/ABI/testing/securityfs-lockdown
@@ -0,0 +1,47 @@
+What:		/sys/kernel/security/lockdown
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	linux-security-module@vger.kernel.org
+Description:
+		The lockdown securityfs file reports and controls the
+		lockdown state of the running kernel.  It is provided by
+		the lockdown LSM and is located at
+		/sys/kernel/security/lockdown.
+
+		The file is present only when CONFIG_SECURITY_LOCKDOWN_LSM is
+		enabled and the lockdown LSM is active, either because
+		CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set, or because it is
+		ordered in through CONFIG_LSM, the "lsm=" kernel parameter
+		or the legacy "security=" kernel parameter.  Otherwise the
+		node is absent, and userspace must handle its absence.
+
+		Reading the file returns the supported lockdown levels,
+		with the currently active level enclosed in square
+		brackets.  For example, when the kernel is not locked
+		down::
+
+		  [none] integrity confidentiality
+
+		and when the kernel is in integrity mode::
+
+		  none [integrity] confidentiality
+
+		The file is created with mode 0644: anyone may read it,
+		but writing it requires privileges, and an unprivileged
+		writer fails at open() time with EACCES.
+
+		The file may be written with the name of a level to lock
+		the kernel down further.  Lockdown can only be escalated,
+		never relaxed, so writing the currently active level or a
+		lower level fails with EPERM.  Writing an unrecognized
+		level fails with EINVAL.  Successful writes return the
+		number of bytes written.
+
+		The kernel can also be locked down at boot time with the
+		"lockdown=" kernel parameter, or at build time via
+		CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY or
+		CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY when the
+		lockdown LSM is active.
+
+Users:		fwupd and other userspace tools that query or manage
+		kernel lockdown state
diff --git a/MAINTAINERS b/MAINTAINERS
index 64f8b6153b87..c30b7d10c7c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15753,6 +15753,7 @@ M:	Xiu Jianfeng <xiujianfeng@huawei.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	Documentation/ABI/testing/securityfs-lockdown
 F:	security/lockdown/
 
 LOCKING PRIMITIVES
-- 
2.18.0.huawei.25


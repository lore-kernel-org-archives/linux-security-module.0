Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315367;
	b=QBIOmb1idmMN8q5/ZL9JCD+iFhxx2Yq7gREuA0KOSAbh86Omv9vsewNr7FV0Ai+btFt9
	 UdAOjjV3Wy/qq4S+aHiHzv0Ar7+CQddCgZKcpulMbvKEQ2IPtLH2o6ZOiTpXKH+KsCovi
	 Tmh5iZMC2GwDo+ZjuNWAy9cDMe0s6tkBVWAHG6fJZPnJIBM+HXlJeeOuafXVWTimk/tkC
	 l/cQn3RWGP9vJC123wmET8yhxUfppCL0+VPYHAkElw6kVJl9A8S+xlBQXJwHQZOKzzV4a
	 RLrryu7X4lIgNq5Q4Bf/Xxr7YvWUh4Iv+p2dJ5TMne97dZUnq6rTi0L/sRPPniHSfQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315367;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=583v/INb/FdV9q7pbNC+560YuuPeVN9iULWL+PFKGXg=;
	b=tkhBfayVePzcGsQHCkOFfueFcxwTW2sA/mddkzJsIXwzx8tdL4inU1IG2++SE9vLRot2
	 akJH7UTmtWkasHiME2wLUAJZeCiWFCmVhrtZe0mf8C7kwFa3kzyI4L4C8dEfSNutDaF7D
	 um8CVQQb1lw6g4toP8e7mkPfHH1c8zM+y2lc4oEEPk3wzb+/NTJWq70iODW3VXPiMJEX2
	 jPjVS6Olnix4gKCiGDpyR9JiQvEM/BJ4cm199Nbel5JRb7fPBqABNs6TP/uIV8qqE89Yl
	 8T4jCeyV1Fyz31Kq3jwl05BgBGZUFO05FrUUHVpSKLItqwa1bXgZMhh5Rtn0Iem26eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0pMM6y7u;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F706606A7D3;
	Tue, 10 Nov 2026 12:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F706606A7D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0pMM6y7u
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=583v/INb/FdV9q7pbNC+560YuuPeVN9iULWL+PFKGXg=;
	b=0pMM6y7u5lgfQjamrgCfQ10MyAe5lNGxBKFqovfn0ZiCm779trO8+ZezARJU0l5/i6meSqvTt
	KI2U6Tz0EDkrrmC/7VB/R4FZ7j+6n+kxr1dukejRKOUscFIe5uByqxRQtugKsAr78uDGVhTfVYT
	EakdaRvE1T8T7jwaqUBkViE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jP68P2T2yz1K9YB;
	Tue, 10 Nov 2026 20:55:49 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 18D7740565;
	Tue, 10 Nov 2026 20:55:58 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 20:55:56 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next -v2 7/8] Documentation/ABI: document the lockdown securityfs file
Date: Tue, 10 Nov 2026 21:28:17 +0800
Message-ID: <20261110132818.2231593-8-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261110132818.2231593-1-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
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

Describe the /sys/kernel/security/lockdown interface: the levels it
reports, how the active level is marked, when the file is present, and
the write semantics (escalation only, EPERM for the current or a lower
level, EINVAL for an unknown level).

Also add the new ABI file to the LOCKDOWN SECURITY MODULE entry in
MAINTAINERS.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 Documentation/ABI/testing/securityfs-lockdown | 43 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-lockdown

diff --git a/Documentation/ABI/testing/securityfs-lockdown b/Documentation/ABI/testing/securityfs-lockdown
new file mode 100644
index 000000000000..2967a07df97c
--- /dev/null
+++ b/Documentation/ABI/testing/securityfs-lockdown
@@ -0,0 +1,43 @@
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
+		ordered in through CONFIG_LSM or the "lsm=" kernel
+		parameter.  Otherwise the node is absent, and userspace must
+		handle its absence.
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
index c57be10c8729..0ba942dfe4c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15652,6 +15652,7 @@ M:	Xiu Jianfeng <xiujianfeng@huawei.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	Documentation/ABI/testing/securityfs-lockdown
 F:	security/lockdown/
 
 LOCKING PRIMITIVES
-- 
2.18.0.huawei.25

